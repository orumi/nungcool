package com.nc.eval;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.actual.MeasureDetail;
import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;

public class AdjustValuateUtil {
	public void setEvalGroup(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String qtr = Util.getPrevQty(null);

			String year = request.getParameter("year")!=null?request.getParameter("year"):qtr.substring(0,4);
			String month = request.getParameter("month")!=null?request.getParameter("month"):qtr.substring(4,6);
			String userId = (String)request.getSession().getAttribute("userId");

			StringBuffer sbGrp = new StringBuffer();
			sbGrp.append("SELECT * FROM TBLMEAEVALGRP WHERE YEAR=? AND MONTH=?");
			Object[] params = {year,month};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sbGrp.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("dsGrp", ds);

			String strDetail = "SELECT D.*,B.NAME FROM TBLMEAEVALDEPT D, TBLBSC B WHERE D.EVALDEPTID=B.ID AND GRPID IN (SELECT GRPID FROM TBLMEAEVALGRP WHERE YEAR=? AND MONTH=?)";

			if (rs!=null) {rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(strDetail,params);

			DataSet dsDtl = new DataSet();
			dsDtl.load(rs);

			request.setAttribute("dsDtl",dsDtl);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}


	/**
	 * 비계량 지표 실적 반영 및 초기화(2007년 평가, 중간점검, 최종평가)
	 *
	 * @param request
	 * @param response
	 */
	public void setEvalMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String year = request.getParameter("year");

			if (year==null) return;

			String grpId = request.getParameter("grpId");  // SCID가 들어옴,
			String month = request.getParameter("month");

			String userId = (String)request.getSession().getAttribute("userId");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";

			//-----------------------------------------------------------------------------------
			// 평가실적반영 : tblmeasuredetail
			//-----------------------------------------------------------------------------------
			if ("A".equals(tag)){
				String amId = request.getParameter("amId");
				System.out.println("amId  =============="+amId);

				String[] mIds = amId.split("\\|");

				for (int i = 0; i < mIds.length; i++) {
					String actual = request.getParameter("avgact"+mIds[i]);   //
					String score  = request.getParameter("avgscr"+mIds[i]);
					String grade  = request.getParameter("avggrd"+mIds[i]);

					// 비계량지표의 실적이 actual이 5,4,3,2,1 로 계산되므로... 실적은 100,90,80,70,60으로 처리하기 위하여...
					actual = score;

					System.out.println("평가반영 : " + year+month + ":" + amId + ", Actual : " + actual );

					if (actual!=null && !"".equals(actual) && !"0.0".equals(actual)){
						//------------------------------------------------------------------------
						// itemactual : 항목
						//------------------------------------------------------------------------
						StringBuffer sbD = new StringBuffer();
						sbD = new StringBuffer();
						sbD.append(" DELETE FROM TBLITEMACTUAL WHERE STRDATE LIKE ?||'%' AND measureid = ? ");
						Object[] paramD = new Object[] {year + month, mIds[i]};
						dbobject.executePreparedUpdate(sbD.toString(),paramD);

						StringBuffer sbI = new StringBuffer();
						sbI = new StringBuffer();
						sbI.append(" INSERT INTO TBLITEMACTUAL  ")
						   .append("        (measureid, code, strdate, inputdate, actual) ")
						   .append(" VALUES (?,?,?,to_char(sysdate,'yyyymmdd'), ?) ");
						Object[] paramI = new Object[] {mIds[i],"X01",year + month,actual};
						dbobject.executePreparedUpdate(sbI.toString(),paramI);
						//------------------------------------------------------------------------
						// itemactual : 항목  End.
						//------------------------------------------------------------------------

						String strEqu = "SELECT EQUATION,WEIGHT,TREND,FREQUENCY,MEASUREID FROM TBLMEASUREDEFINE WHERE ID=?";
						Object[] pmEqu = {mIds[i]};

						if (rs!=null){rs.close(); rs=null;}

						rs = dbobject.executePreparedQuery(strEqu,pmEqu);
						String equ = "";
						String weight = null;
						String trend = null;
						String frequency = null;
						String measureid = "";
						while(rs.next()){
							equ = rs.getString("EQUATION");
							weight = rs.getString("WEIGHT");
							trend = rs.getString("TREND");
							frequency = rs.getString("FREQUENCY");
							measureid = rs.getString("MEASUREID");
						}


						//System.out.println("Save:"+i+"/"+mIds[i]+"/"+measureid+"/"+actual+"/"+score+"/"+grade);

						MeasureDetail measuredetail = getMeasureDetail (dbobject,mIds[i],year+month);
						measuredetail.actual = new Double(actual).doubleValue();
						measuredetail.strDate = Util.getLastMonth(year+month);
						measuredetail.weight = new Float(weight).floatValue();
						//measuredetail.id = new Integer(mIds[i]).intValue();
						measuredetail.measureId = new Integer(mIds[i]).intValue();
						measuredetail.trend = (trend==null)?"상향":trend;
						measuredetail.frequency = frequency;
						measuredetail.score = new Double(score).doubleValue();
						measuredetail.grade = grade;
						measuredetail.strDate = year+month;

						updateMeasureDetail(dbobject,measuredetail);

					}
				}
				request.setAttribute("flag", "true");
			}

			//-----------------------------------------------------------------------------------
			// 평가반영 실적 초기화...   중간점검인 경우 SCID에 해당되는 내용 삭제.
			//-----------------------------------------------------------------------------------
			if ("E".equals(tag)||"R".equals(tag)){
				System.out.println("평가반영 실적 초기화   ============== "+year + ":" + month + ":" + grpId);

				// 항목 초기화.
				StringBuffer sbDI = new StringBuffer();
				sbDI = new StringBuffer();
				Object[] pmDI = null;

				 sbDI.append(" DELETE FROM TBLITEMACTUAL                   ")
					 .append(" WHERE  strdate   like ?||'%'                ")
					 .append(" AND    measureid in (                       ")
		          	 .append(" SELECT  mcid FROM (                         ")
			         .append(" SELECT  grpid, grpnm,                       ")
			         .append("         cid, ccid, clevel, crank, cname,   ")
			         .append("         sid, scid, slevel, srank, sname,   ")
			         .append("         bid, bcid, blevel, brank, bname,   ")
			         .append("         pid, pcid, plevel, prank, pname,   ")
			         .append("         oid, ocid, olevel, orank, oname,   ")
			         .append("         mid, mcid, mlevel, mrank, mname,  mweight, ")
			         .append("         measureid ")
			         .append(" FROM ")
			         .append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ")
			         .append("         from   tblhierarchy t,tblcompany c ")
			         .append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =? ")
			         .append("        ) com, ")
			         .append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
			         .append("         from   tblhierarchy t,tblsbu c ")
			         .append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =? and t.contentid like ? ")
			         .append("        ) sbu, ")
			         .append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname ")
			         .append("         from   tblhierarchy t,tblbsc c ")
			         .append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =? ")
			         .append("        ) bsc, ")
			         .append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname ")
			         .append("         from   tbltreescore t,tblpst c ")
			         .append("         where  t.contentid=c.id  and t.treelevel=3 and t.year =? ")
			         .append("        ) pst  , ")
			         .append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname ")
			         .append("         from   tbltreescore t,tblobjective c ")
			         .append("         where  t.contentid=c.id  and t.treelevel=4 and t.year =? ")
			         .append("        ) obj , ")
			         .append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname, ")
			         .append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey, ")
			         .append("                d.unit       , ")
			         .append("                d.planned, d.base,  d.limit ")
			         .append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d ")
			         .append("         where  t.contentid=d.id  and t.treelevel=5 and t.year =? and d.measureid=c.id ")
			         .append("         and    d.measurement = '비계량' ")
			         .append("        ) mea,  ")
			         .append("        ( ")
			         .append("         SELECT a.grpid, a.grpnm, b.evaldeptid gbcid  ")
			         .append("         FROM   tblmeaevalgrp  a, tblmeaevaldept b ")
			         .append("         WHERE  a.grpid = b.grpid ")
			         .append("         AND    a.year  = ? ")
			         .append("         AND    a.month = ? ")
			         .append("         AND    a.grpid like '%' ")
			         .append("         ) grp ")
			         .append(" where  cid = spid (+) ")
			         .append(" and    sid = bpid (+) ")
			         .append(" and    bid = ppid (+) ")
			         .append(" and    pid = opid (+) ")
			         .append(" and    oid = mpid  ")
			         .append(" and    bcid = gbcid ")
			         .append(" order by crank, srank, brank, prank, orank, mrank ")
			         .append(" ) ")
			         .append(" ) ");

		         pmDI =  new Object[] {year + month, year, year, grpId, year,year,year,year, year,month};

				dbobject.executePreparedUpdate(sbDI.toString(),pmDI);


				StringBuffer sbU = new StringBuffer();
				Object[] pm = null;

				  sbU.append(" update tblmeasuredetail                     ")
				     .append(" set    actual      = null,                  ")
				     .append("        grade       = null,                  ")
				     .append("        grade_score = null                   ")
					 .append(" WHERE  strdate   like ?||'%'                ")
					 .append(" AND    measureid in (                       ")
		          	 .append(" SELECT  mcid FROM (                         ")
			         .append(" SELECT  grpid, grpnm,                       ")
			         .append("         cid, ccid, clevel, crank, cname,   ")
			         .append("         sid, scid, slevel, srank, sname,   ")
			         .append("         bid, bcid, blevel, brank, bname,   ")
			         .append("         pid, pcid, plevel, prank, pname,   ")
			         .append("         oid, ocid, olevel, orank, oname,   ")
			         .append("         mid, mcid, mlevel, mrank, mname,  mweight, ")
			         .append("         measureid ")
			         .append(" FROM ")
			         .append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ")
			         .append("         from   tblhierarchy t,tblcompany c ")
			         .append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =? ")
			         .append("        ) com, ")
			         .append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
			         .append("         from   tblhierarchy t,tblsbu c ")
			         .append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =? and t.contentid like ? ")
			         .append("        ) sbu, ")
			         .append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname ")
			         .append("         from   tblhierarchy t,tblbsc c ")
			         .append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =? ")
			         .append("        ) bsc, ")
			         .append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname ")
			         .append("         from   tbltreescore t,tblpst c ")
			         .append("         where  t.contentid=c.id  and t.treelevel=3 and t.year =? ")
			         .append("        ) pst  , ")
			         .append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname ")
			         .append("         from   tbltreescore t,tblobjective c ")
			         .append("         where  t.contentid=c.id  and t.treelevel=4 and t.year =? ")
			         .append("        ) obj , ")
			         .append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname, ")
			         .append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey, ")
			         .append("                d.unit       , ")
			         .append("                d.planned, d.base,  d.limit ")
			         .append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d ")
			         .append("         where  t.contentid=d.id  and t.treelevel=5 and t.year =? and d.measureid=c.id ")
			         .append("         and    d.measurement = '비계량' ")
			         .append("        ) mea,  ")
			         .append("        ( ")
			         .append("         SELECT a.grpid, a.grpnm, b.evaldeptid gbcid  ")
			         .append("         FROM   tblmeaevalgrp  a, tblmeaevaldept b ")
			         .append("         WHERE  a.grpid = b.grpid ")
			         .append("         AND    a.year  = ? ")
			         .append("         AND    a.month = ? ")
			         .append("         AND    a.grpid like '%' ")
			         .append("         ) grp ")
			         .append(" where  cid = spid (+) ")
			         .append(" and    sid = bpid (+) ")
			         .append(" and    bid = ppid (+) ")
			         .append(" and    pid = opid (+) ")
			         .append(" and    oid = mpid  ")
			         .append(" and    bcid = gbcid ")
			         .append(" order by crank, srank, brank, prank, orank, mrank ")
			         .append(" ) ")
			         .append(" ) ");

		         pm =  new Object[] {year + month, year, year, grpId, year,year,year,year, year,month};

    			dbobject.executePreparedUpdate(sbU.toString(),pm);

    			//--------------------------------------------------------------------------------------
				// GROUP에 해당되는 지표의 평가점수 삭제  : 지표의 주기에 따라 기간설정필요...
    			//--------------------------------------------------------------------------------------
				sbU = new StringBuffer();
				Object[] pmD = null;

				// 지표의 주기에 따라 생성된 모니터링 점수 삭제.
    			StringBuffer sbQ = new StringBuffer();
    			Object[] paramQ = null;

	            sbQ.append(" SELECT id   mcid,                                                  ");
	            sbQ.append("        case when frequency = '분기' and mm = '03' then '01'         ");
	            sbQ.append("             when frequency = '분기' and mm = '06' then '04'         ");
	            sbQ.append("             when frequency = '분기' and mm = '09' then '07'         ");
	            sbQ.append("             when frequency = '분기' and mm = '12' then '10'         ");
	            sbQ.append("             when frequency = '반기' and mm = '06' then '01'         ");
	            sbQ.append("             when frequency = '반기' and mm = '12' then '07'         ");
	            sbQ.append("             when frequency = '년'   then '01'                       ");
	            sbQ.append("        end frmm,                                                    ");
	            sbQ.append("        case when frequency = '분기' and mm = '03' then '05'          ");
	            sbQ.append("             when frequency = '분기' and mm = '06' then '08'          ");
	            sbQ.append("             when frequency = '분기' and mm = '09' then '11'          ");
	            sbQ.append("             when frequency = '분기' and mm = '12' then '12'          ");
	            sbQ.append("             when frequency = '반기' and mm = '06' then '11'          ");
	            sbQ.append("             when frequency = '반기' and mm = '12' then '12'          ");
	            sbQ.append("             when frequency = '년'   then '12'                        ");
	            sbQ.append("        end   tomm, frequency, measurement                            ");
	            sbQ.append(" FROM tblmeasuredefine, (select ? mm from dual)                       ");
	            sbQ.append(" WHERE id in (                                                                                                              ");
	            sbQ.append("  SELECT  mcid FROM (                                                                                                       ");
	            sbQ.append("  SELECT  grpid, grpnm,                                                                                                     ");
	            sbQ.append("          cid, ccid, clevel, crank, cname,                                                                                  ");
	            sbQ.append("          sid, scid, slevel, srank, sname,                                                                                  ");
	            sbQ.append("          bid, bcid, blevel, brank, bname,                                                                                  ");
	            sbQ.append("          pid, pcid, plevel, prank, pname,                                                                                  ");
	            sbQ.append("          oid, ocid, olevel, orank, oname,                                                                                  ");
	            sbQ.append("          mid, mcid, mlevel, mrank, mname,  mweight,                                                                        ");
	            sbQ.append("          measureid                                                                                                         ");
	            sbQ.append("  FROM                                                                                                                      ");
	            sbQ.append("         (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname   ");
	            sbQ.append("          from   tblhierarchy t,tblcompany c                                                                                ");
	            sbQ.append("          where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                                          ");
	            sbQ.append("         ) com,                                                                                                             ");
	            sbQ.append("         (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname   ");
	            sbQ.append("          from   tblhierarchy t,tblsbu c                                                                                    ");
	            sbQ.append("          where  t.contentid=c.id  and t.treelevel=1 and t.year =? and t.contentid like ?                                   ");
	            sbQ.append("         ) sbu,                                                                                                             ");
	            sbQ.append("         (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname   ");
	            sbQ.append("          from   tblhierarchy t,tblbsc c                                                                                    ");
	            sbQ.append("          where  t.contentid=c.id  and t.treelevel=2 and t.year =?                                                          ");
	            sbQ.append("         ) bsc,                                                                                                             ");
	            sbQ.append("         (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname   ");
	            sbQ.append("          from   tbltreescore t,tblpst c                                                                                    ");
	            sbQ.append("          where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                                          ");
	            sbQ.append("         ) pst  ,                                                                                                           ");
	            sbQ.append("         (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname   ");
	            sbQ.append("          from   tbltreescore t,tblobjective c                                                                              ");
	            sbQ.append("          where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                                          ");
	            sbQ.append("         ) obj ,                                                                                                            ");
	            sbQ.append("         (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname,");
	            sbQ.append("                 c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey,                                     ");
	            sbQ.append("                 d.unit       ,                                                                                             ");
	            sbQ.append("                 d.planned, d.base,  d.limit                                                                                ");
	            sbQ.append("          from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d                                                      ");
	            sbQ.append("          where  t.contentid=d.id  and t.treelevel=5 and t.year =? and d.measureid=c.id                                     ");
	            sbQ.append("          and    d.measurement = '비계량'                                                                                   ");
	            sbQ.append("         ) mea,                                                                                                             ");
	            sbQ.append("         (                                                                                                                  ");
	            sbQ.append("          SELECT a.grpid, a.grpnm, b.evaldeptid gbcid                                                                       ");
	            sbQ.append("          FROM   tblmeaevalgrp  a, tblmeaevaldept b                                                                         ");
	            sbQ.append("          WHERE  a.grpid = b.grpid                                                                                          ");
	            sbQ.append("          AND    a.year  = ?                                                                                                ");
	            sbQ.append("          AND    a.month = ?                                                                                                ");
	            sbQ.append("          AND    a.grpid like '%'                                                                                           ");
	            sbQ.append("          ) grp                                                                                                             ");
	            sbQ.append("  where  cid = spid (+)                                                                                                     ");
	            sbQ.append("  and    sid = bpid (+)                                                                                                     ");
	            sbQ.append("  and    bid = ppid (+)                                                                                                     ");
	            sbQ.append("  and    pid = opid (+)                                                                                                     ");
	            sbQ.append("  and    oid = mpid                                                                                                         ");
	            sbQ.append("  and    bcid = gbcid                                                                                                       ");
	            sbQ.append("  order by crank, srank, brank, prank, orank, mrank                                                                         ");
	            sbQ.append("  )                                                                                                                         ");
	            sbQ.append("  )                                                                                                                         ");

	            paramQ =  new Object[] {month,  year, year, grpId, year,year,year,year, year,month};


    			if (rs!=null){rs.close(); rs=null;}
    			rs = dbobject.executePreparedQuery(sbQ.toString(),paramQ);

    			String mcid   = null;
				String frym   = null;
				String toym   = null;

				sbU.append(" DELETE FROM tblmeasurescore                 ");
				sbU.append(" WHERE  strdate   >= ?                       ");
				sbU.append(" AND    strdate   <= ?                       ");
				sbU.append(" AND    measureid  = ?                       ");

				DataSet dsMea = new DataSet();
				dsMea.load(rs);

				while(dsMea.next()){
					mcid   = dsMea.getString("MCID");
					frym   = year + dsMea.getString("FRMM") + "01";
					toym   = year + dsMea.getString("TOMM") + "99";

					System.out.println("지표삭제(MEASURESCORE) : " + mcid + ":" + frym + "~" + toym);

					pmD = new Object[] {frym,toym,mcid};
					dbobject.executePreparedUpdate(sbU.toString(),pmD);
				}


				// GROUP의 실적삭제.
				conn.commit();
				request.setAttribute("flag", "true");
			}

			//-----------------------------------------------------------------------------------
			// 평가단 입력 실적 초기화...
			//-----------------------------------------------------------------------------------
			if ("R".equals(tag)){
				System.out.println("평가단 입력실적초기화   ============== "+year + ":" + month + ":" + grpId);

				StringBuffer sbD = new StringBuffer();
				Object[] pmD = null;

						// 중간점검인 경우 부서별 비계량 지표를 삭제처리한다.

	          sbD.append(" DELETE FROM TBLMEAEVALDETAIL WHERE YEAR=? AND MONTH=? AND EVALID IN (  ")
		         .append(" SELECT  mcid FROM ( ")
		         .append(" SELECT  grpid, grpnm,  ")
		         .append("         cid, ccid, clevel, crank, cname,   ")
		         .append("         sid, scid, slevel, srank, sname,   ")
		         .append("         bid, bcid, blevel, brank, bname,   ")
		         .append("         pid, pcid, plevel, prank, pname,   ")
		         .append("         oid, ocid, olevel, orank, oname,   ")
		         .append("         mid, mcid, mlevel, mrank, mname,  mweight, ")
		         .append("         measureid ")
		         .append(" FROM ")
		         .append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ")
		         .append("         from   tblhierarchy t,tblcompany c ")
		         .append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =? ")
		         .append("        ) com, ")
		         .append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
		         .append("         from   tblhierarchy t,tblsbu c ")
		         .append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =? and t.contentid like ? ")
		         .append("        ) sbu, ")
		         .append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname ")
		         .append("         from   tblhierarchy t,tblbsc c ")
		         .append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =? ")
		         .append("        ) bsc, ")
		         .append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname ")
		         .append("         from   tbltreescore t,tblpst c ")
		         .append("         where  t.contentid=c.id  and t.treelevel=3 and t.year =? ")
		         .append("        ) pst  , ")
		         .append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname ")
		         .append("         from   tbltreescore t,tblobjective c ")
		         .append("         where  t.contentid=c.id  and t.treelevel=4 and t.year =? ")
		         .append("        ) obj , ")
		         .append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname, ")
		         .append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey, ")
		         .append("                d.unit       , ")
		         .append("                d.planned, d.base,  d.limit ")
		         .append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d ")
		         .append("         where  t.contentid=d.id  and t.treelevel=5 and t.year =? and d.measureid=c.id ")
		         .append("         and    d.measurement = '비계량' ")
		         .append("        ) mea,  ")
		         .append("        ( ")
		         .append("         SELECT a.grpid, a.grpnm, b.evaldeptid gbcid  ")
		         .append("         FROM   tblmeaevalgrp  a, tblmeaevaldept b ")
		         .append("         WHERE  a.grpid = b.grpid ")
		         .append("         AND    a.year  = ? ")
		         .append("         AND    a.month = ? ")
		         .append("         AND    a.grpid like '%' ")
		         .append("         ) grp ")
		         .append(" where  cid = spid (+) ")
		         .append(" and    sid = bpid (+) ")
		         .append(" and    bid = ppid (+) ")
		         .append(" and    pid = opid (+) ")
		         .append(" and    oid = mpid  ")
		         .append(" and    bcid = gbcid ")
		         .append(" order by crank, srank, brank, prank, orank, mrank ")
		         .append(" ) ")
		         .append(" ) ");

	         pmD =  new Object[] {year, month, year, year, grpId, year,year,year,year, year,month};

				dbobject.executePreparedUpdate(sbD.toString(),pmD);

				// GROUP의 실적삭제.
				conn.commit();
				request.setAttribute("flag", "true");
			}



	         //=======================================================================================

	         StringBuffer strSQL = new StringBuffer();
	         Object[] pm22 = null;

	         String frq = getFrequecny(new Integer(month).intValue());//반기 분기별 추력하기 위해

        	 strSQL.append("  SELECT  cid, ccid, clevel, crank, cname,  cweight,                                                                                 ")
	        	 .append("          sid, scid, slevel, srank, sname,  sweight,                                                                                  ")
	        	 .append("          bid, bcid, blevel, brank, bname,  sum(mweight) over (partition by cid, sid, bid          ) bweight,                         ")
	        	 .append("          pid, pcid, plevel, prank, pname,  sum(mweight) over (partition by cid, sid, bid, pid     ) pweight,                         ")
	        	 .append("          oid, ocid, olevel, orank, oname,  sum(mweight) over (partition by cid, sid, bid, pid, oid) oweight,                         ")
	        	 .append("          mid, mcid, mlevel, mrank, mname,  mweight,                                                                                  ")
	        	 .append("          mea.measureid, CASE WHEN (mea.MEASCHAR='I') THEN '고유' ELSE '공통' END mkind, measchar ,                                   ")
	        	 .append("          grp.year, grp.month, avg_score, grade, avg_score grade_score, round(mweight * avg_score/100,2)  meas_score                          ")
	        	 .append("  FROM                                                                                                                                ")
	        	 .append("         (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname             ")
	        	 .append("          from   tblhierarchy t,tblcompany c                                                                                          ")
	        	 .append("          where  t.contentid=c.id  and t.treelevel=0 and t.year = ?                                                           ")
	        	 .append("         ) com,                                                                                                                       ")
	        	 .append("         (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname             ")
	        	 .append("          from   tblhierarchy t,tblsbu c                                                                                              ")
	        	 .append("          where  t.contentid=c.id  and t.treelevel=1 and t.year = ? and t.contentid like ?                                                    ")
	        	 .append("         ) sbu,                                                                                                                       ")
	        	 .append("         (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname             ")
	        	 .append("          from   tblhierarchy t,tblbsc c                                                                                              ")
	        	 .append("          where  t.contentid=c.id  and t.treelevel=2 and t.year = ?                                                           ")
	        	 .append("         ) bsc,                                                                                                                       ")
	        	 .append("         (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname             ")
	        	 .append("          from   tbltreescore t,tblpst c                                                                                              ")
	        	 .append("          where  t.contentid=c.id  and t.treelevel=3 and t.year = ?                                                          ")
	        	 .append("         ) pst  ,                                                                                                                     ")
	        	 .append("         (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname             ")
	        	 .append("          from   tbltreescore t,tblobjective c                                                                                        ")
	        	 .append("          where  t.contentid=c.id  and t.treelevel=4 and t.year = ?                                                           ")
	        	 .append("         ) obj ,                                                                                                                      ")
	        	 .append("         (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname,          ")
	        	 .append("                 c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey,                                               ")
	        	 .append("                 d.unit   , c.MEASCHAR ,                                                                                              ")
	        	 .append("                 d.planned,d.plannedbase, d.base, d.baselimit, d.limit                                                                ")
	        	 .append("          from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d                                                                ")
	        	 .append("          where  t.contentid=d.id  and t.treelevel=5 and t.year = ?  and d.measureid=c.id                                     ")
	        	 .append("          and    d.frequency   in ("+frq+")") // 분기,반기 출력 sql문 추가
	        	 .append("          and    d.measurement = '비계량'                                                                                             ")
	        	 .append("         ) mea,                                                                                                                       ")
	        	 .append("         (                                                                                                                            ")
	        	 .append("           select a.grpid, a.grpnm, a.year, a.month,                                                                                  ")
	        	 .append("                  b.evaldeptid, c.id  gbcid, c.name                                                                               ")
	        	 .append("           from tblmeaevalgrp a, tblmeaevaldept b,                                                                                    ")
	        	 .append("                tblbsc        c                                                                                                       ")
	        	 .append("           where a.grpid      = b.grpid                                                                                               ")
	        	 .append("           and   b.evaldeptid = c.id                                                                                                  ")
	        	 .append("           and   a.year = ?                                                                                                   ")
	        	 .append("           and   a.month= ?                                                                                                     ")
	        	 .append("           and   a.grpid like '%'                                                                                                     ")
	        	 .append("         ) grp,                                                                                                                       ")
	        	 .append("         (                                                                                                                            ")
	        	 .append("           SELECT evalid, year, month,                                                                                                ")
	        	 .append("                  avg_score,                                                                                                          ")
	        	 .append("                   case when avg_score >= 100 then 'S'                                                                                  ")

	        	 .append("                        when avg_score < 100 and  avg_score >= 95 then 'A+'                                                            ")
				.append("                        when avg_score < 95  and  avg_score >= 90 then 'A'                                                            ")
				.append("                        when avg_score < 90  and  avg_score >= 85 then 'B+' 						")
				.append("                        when avg_score < 85  and  avg_score >= 80 then 'B' 						")
				.append("                        when avg_score < 80  and  avg_score >= 75 then 'C+' 						")
				.append("                        when avg_score < 75  and  avg_score >= 70 then 'C' 						")
				.append("                        when avg_score < 70  and  avg_score >= 65 then 'D+'                                                            ")
				.append("                        when avg_score < 65  then 'D'                                                                                  ")
				.append("                   end grade,                                                                                                           ")
				.append("                   case when avg_score >= 100 then 100                                                                                  ")
				.append("                        when avg_score < 100 and  avg_score >= 95 then 95                                                            ")
				.append("                        when avg_score < 95  and  avg_score >= 90 then 90                                                            ")
				.append("                        when avg_score < 90  and  avg_score >= 85 then 85 ")
				.append("                        when avg_score < 85  and  avg_score >= 80 then 80 ")
				.append("                        when avg_score < 80  and  avg_score >= 75 then 75 ")
				.append("                        when avg_score < 75  and  avg_score >= 70 then 70 ")
				.append("                        when avg_score < 70  and  avg_score >= 65 then 65                                                            ")
				.append("                        when avg_score < 65  then 60                                                                                  ")
				.append("                   end grade_score  ")

	        	 .append("           FROM                                                                                                                       ")
	        	 .append("               (                                                                                                                      ")
	        	 .append("               SELECT evalid, year, month, count(*) cnt,                                                                              ")
	        	 .append("                      sum(evalscore)  scr_sum,                                                                                        ")
	        	 .append("                      max(evalscore)  scr_max,                                                                                        ")
	        	 .append("                      min(evalscore)  scr_min,                                                                                        ")
	        	 .append("                      round(case when count(*) >= 5 then                                                                              ")
	        	 .append("                                     (sum(evalscore) - max(evalscore) - min(evalscore))/(count(*) - 2)                                ")
	        	 .append("                                 else sum(evalscore) / count(*)                                                                       ")
	        	 .append("                            end,1)  avg_score                                                                                         ")
	        	 .append("               FROM   TBLMEAEVALDETAIL                                                                                                ")
	        	 .append("               WHERE  year  = ?                                                                                            ")
	        	 .append("               AND    month = ?                                                                                                   ")
	        	 .append("               AND    evalgrade is not null                                                                                           ")
	        	 .append("               GROUP BY evalid, year, month                                                                                           ")
	        	 .append("               )                                                                                                                      ")
	        	 .append("           ) measrslt                                                                                                                 ")
	        	 .append("  where  cid = spid                                                                                                                   ")
	        	 .append("  and    sid = bpid                                                                                                                   ")
	        	 .append("  and    bid = ppid                                                                                                                   ")
	        	 .append("  and    pid = opid                                                                                                                   ")
	        	 .append("  and    oid = mpid                                                                                                                   ")
	        	 .append("  and    mcid = measrslt.evalid (+)                                                                                          ")
	        	 .append("  and    bcid = gbcid                                                                                                ")
	        	 .append("  order by mea.measureid, crank, cid, srank, sid, brank, bid, prank, pid, orank, oid ");

        	 pm22 = new Object[] {year,year,grpId, year,year,year,year,  year,month, year,month};


	         if (rs!=null){rs.close();rs=null;}


	         rs = dbobject.executePreparedQuery(strSQL.toString(),pm22);

	         EvalMeasureUtil meautil = new EvalMeasureUtil();

	         while(rs.next())
	        	 meautil.AddMeasure2(rs);



	         StringBuffer str = new StringBuffer();
	        str.append("SELECT E.*,(SELECT USERNAME FROM TBLUSER U WHERE U.USERID=E.EVALRID) USERNAME, ")
	         	.append(" (SELECT APPRAISER FROM TBLUSER U WHERE U.USERID=E.EVALRID) APP FROM TBLMEAEVALR E WHERE GRPID=?");
	         Object[] pmUser = {grpId};

	         if (rs!=null){rs.close(); rs=null;}

	         rs = dbobject.executePreparedQuery(str.toString(),pmUser);

	         while(rs.next())
	        	 meautil.setAppName(rs);

	         StringBuffer sb1 = new StringBuffer();
	         Object[] pm1 = null;


	         sb1.append(" SELECT * FROM TBLMEAEVALDETAIL WHERE YEAR=? AND MONTH=? AND EVALID IN (  ")
	         .append(" SELECT  mcid FROM ( ")
	         .append(" SELECT  grpid, grpnm,  ")
	         .append("         cid, ccid, clevel, crank, cname,   ")
	         .append("         sid, scid, slevel, srank, sname,   ")
	         .append("         bid, bcid, blevel, brank, bname,   ")
	         .append("         pid, pcid, plevel, prank, pname,   ")
	         .append("         oid, ocid, olevel, orank, oname,   ")
	         .append("         mid, mcid, mlevel, mrank, mname,  mweight, ")
	         .append("         measureid ")
	         .append(" FROM ")
	         .append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ")
	         .append("         from   tblhierarchy t,tblcompany c ")
	         .append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =? ")
	         .append("        ) com, ")
	         .append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
	         .append("         from   tblhierarchy t,tblsbu c ")
	         .append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =? and t.contentid like ? ")
	         .append("        ) sbu, ")
	         .append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname ")
	         .append("         from   tblhierarchy t,tblbsc c ")
	         .append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =? ")
	         .append("        ) bsc, ")
	         .append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname ")
	         .append("         from   tbltreescore t,tblpst c ")
	         .append("         where  t.contentid=c.id  and t.treelevel=3 and t.year =? ")
	         .append("        ) pst  , ")
	         .append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname ")
	         .append("         from   tbltreescore t,tblobjective c ")
	         .append("         where  t.contentid=c.id  and t.treelevel=4 and t.year =? ")
	         .append("        ) obj , ")
	         .append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname, ")
	         .append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey, ")
	         .append("                d.unit       , ")
	         .append("                d.planned, d.base,  d.limit ")
	         .append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d ")
	         .append("         where  t.contentid=d.id  and t.treelevel=5 and t.year =? and d.measureid=c.id ")
	         .append("         and    d.frequency   in ("+frq+")") // 분기,반기 출력 sql문 추가
	         .append("         and    d.measurement = '비계량' ")
	         .append("        ) mea,  ")
	         .append("        ( ")
	         .append("         SELECT a.grpid, a.grpnm, b.evaldeptid gbcid  ")
	         .append("         FROM   tblmeaevalgrp  a, tblmeaevaldept b ")
	         .append("         WHERE  a.grpid = b.grpid ")
	         .append("         AND    a.year  = ? ")
	         .append("         AND    a.month = ? ")
	         .append("         AND    a.grpid like '%' ")
	         .append("         ) grp ")
	         .append(" where  cid = spid (+) ")
	         .append(" and    sid = bpid (+) ")
	         .append(" and    bid = ppid (+) ")
	         .append(" and    pid = opid (+) ")
	         .append(" and    oid = mpid  ")
	         .append(" and    bcid = gbcid ")
	         .append(" order by crank, srank, brank, prank, orank, mrank ")
	         .append(" ) ")
	         .append(" ) ");

	         pm1 =  new Object[] {year, month, year, year, grpId, year,year,year,year, year,month};




	         if (rs!=null){rs.close();rs=null;}

	         rs = dbobject.executePreparedQuery(sb1.toString(),pm1);

	         while(rs.next())
	        	 meautil.setActual(rs);


	         request.setAttribute("meautil",meautil);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	private String getFrequecny(int m){
		String reval="'월'";
		if ( (m==3) || (m==9)) {
			reval = reval+",'분기'";
		} else if ((m == 6) ) {
			reval = reval+",'분기','반기'";
		} else if (m==12) {
			reval = reval+",'분기','반기','년'";
		}
		return reval;
	}

	public MeasureDetail getMeasureDetail(DBObject dbobject,String mid, String date) throws SQLException{
		ResultSet rs = null;
		try {
			String s = "SELECT * FROM TBLMEASUREDETAIL WHERE MEASUREID=? AND SUBSTR(STRDATE,0,6)=?";
			Object[] p = {mid,date.substring(0,6)};

			MeasureDetail detail = new MeasureDetail();
			rs = dbobject.executePreparedQuery(s,p);
			while(rs.next()){
				detail.id = rs.getInt("ID");
				detail.measureId = rs.getInt("MEASUREID");
				detail.strDate = rs.getString("STRDATE");
				detail.actual = rs.getDouble("ACTUAL");
				detail.weight = rs.getFloat("WEIGHT");
				detail.planned = rs.getDouble("PLANNED");
				detail.base = rs.getDouble("BASE");
				detail.limit = rs.getDouble("LIMIT");
				detail.filePath = rs.getString("FILEPATH");
				detail.fileName = rs.getString("FILENAME");
			}

			return detail;
		} catch (SQLException e) {
			throw e;
		} finally {
			if (rs!=null) {rs.close(); rs=null;}
		}
	}

	public int updateMeasureDetail(DBObject dbobject, MeasureDetail measuredetail) throws SQLException {
		int reval=0;
		try {
			//double score = measuredetail.getScoreVariable();
			double grade_score = measuredetail.score * measuredetail.weight / 100;

			if (measuredetail.id==0){
				String str = "INSERT INTO TBLMEASUREDETAIL (ID,MEASUREID,STRDATE,ACTUAL,WEIGHT,PLANNED,PLANNEDBASE,BASE,BASELIMIT,LIMIT,FILEPATH,FILENAME,GRADE,GRADE_SCORE) VALUES (?,?,?,?,?, ?,?,?,?,?, ?,?,?,?)";
				Object[] pm = new Object[14];

				measuredetail.id = dbobject.getNextId("TBLMEASUREDETAIL");
				pm[0] = new Integer(measuredetail.id);
				pm[1] = new Integer(measuredetail.measureId);
				pm[2] = measuredetail.strDate;
				pm[3] = new Double(measuredetail.actual);
				pm[4] = new Float(measuredetail.weight);
				pm[5] = new Double(measuredetail.planned);
				pm[6] = new Double(measuredetail.plannedbase);
				pm[7] = new Double(measuredetail.base);
				pm[8] = new Double(measuredetail.baselimit);
				pm[9] = new Double(measuredetail.limit);
				pm[10] = measuredetail.filePath;
				pm[11] = measuredetail.fileName;
				pm[12] = measuredetail.grade;
				pm[13] = new Double(grade_score);
				//System.out.println("up:"+measuredetail.id);
				reval=dbobject.executePreparedUpdate(str,pm);
			} else {
				String str = "UPDATE TBLMEASUREDETAIL SET ACTUAL=?,WEIGHT=?,PLANNED=?,PLANNEDBASE=?,BASE=?,BASELIMIT=?,LIMIT=?,FILEPATH=?,FILENAME=?,GRADE=?,GRADE_SCORE=? WHERE ID=? ";
				Object[] pm = new Object[12];
				pm[0] = new Double(measuredetail.actual);
				pm[1] = new Float(measuredetail.weight);
				pm[2] = new Double(measuredetail.planned);
				pm[3] = new Double(measuredetail.plannedbase);
				pm[4] = new Double(measuredetail.base);
				pm[5] = new Double(measuredetail.baselimit);
				pm[6] = new Double(measuredetail.limit);
				pm[7] = measuredetail.filePath;
				pm[8] = measuredetail.fileName;
				pm[9] = measuredetail.grade;
				pm[10] = new Double(grade_score);
				pm[11] = new Integer(measuredetail.id);
				//System.out.println("up(a):"+measuredetail.actual);
				reval=dbobject.executePreparedUpdate(str,pm);
			}

			// update measurescore;

			if (grade_score !=-1){
				String strU = "UPDATE TBLMEASURESCORE SET ACTUAL=?,WEIGHT=?,PLANNED=?,PLANNEDBASE=?,BASE=?,BASELIMIT=?,LIMIT=?,GRADE_SCORE=?,GRADE=?,SCORE=? WHERE MEASUREID=? AND STRDATE=?";
				Object[] pmU = new Object[12];
				pmU[0] = new Double(measuredetail.actual);
				pmU[1] = new Float(measuredetail.weight);
				pmU[2] = new Double(measuredetail.planned);
				pmU[3] = new Double(measuredetail.plannedbase);
				pmU[4] = new Double(measuredetail.base);
				pmU[5] = new Double(measuredetail.baselimit);
				pmU[6] = new Double(measuredetail.limit);
				pmU[7] = new Double(grade_score);
				pmU[8] = measuredetail.grade;
				pmU[9] = new Double(measuredetail.score);
				pmU[10] = new Integer(measuredetail.measureId);
				pmU[11] = null;

				String strI = "INSERT INTO TBLMEASURESCORE (MEASUREID,STRDATE,ACTUAL,WEIGHT,PLANNED,PLANNEDBASE,BASE,BASELIMIT,LIMIT,GRADE_SCORE,GRADE,SCORE) VALUES (?,?,?,?,?, ?,?,?,?,?, ?,?)";
				Object[] pmI = new Object[12];
				pmI[0] = pmU[10];
				pmI[2] = pmU[0];
				pmI[3] = pmU[1];
				pmI[4] = pmU[2];
				pmI[5] = pmU[3];
				pmI[6] = pmU[4];
				pmI[7] = pmU[5];
				pmI[8] = pmU[6];
				pmI[9] = pmU[7];
				pmI[10] = pmU[8];
				pmI[11] = pmU[9];

				ArrayList list = getMonths(dbobject,measuredetail);

				for (int i = 0; i < list.size(); i++) {
					pmU[11] = Util.getLastMonth((String)list.get(i));
					if (dbobject.executePreparedUpdate(strU,pmU)<1){
						pmI[1] = pmU[11];
						dbobject.executePreparedUpdate(strI,pmI);
					}
					//System.out.println("up(Score):"+measuredetail.grade+"/"+measuredetail.score);
				}
			}

			// 평가완료로 자체평가 금지...
			dbobject.executePreparedUpdate("UPDATE TBLMEASUREDEFINE SET ESTIRSLT='Y' WHERE ID=?",new Object[]{String.valueOf(measuredetail.measureId)});
			dbobject.getConnection().commit();
			return reval;
		} catch (SQLException e) {
			throw e;
		} finally {

		}
	}

	public ArrayList getMonths(DBObject dbobject,MeasureDetail measuredetail) throws SQLException {
		ResultSet rs = null;
		ArrayList list = new ArrayList();
		String year = measuredetail.strDate.substring(0,4);
		String month = measuredetail.strDate.substring(4,6);
		int m = new Integer(month).intValue();
		try {

			String str = "SELECT SCORE FROM TBLMEASURESCORE WHERE MEASUREID=? AND STRDATE=?";
			Object[] pm = {new Integer(measuredetail.measureId),null};
			if (measuredetail.frequency.equals("월")){
				list.add(year+month);
			} else if (measuredetail.frequency.equals("분기")){
				if (m==3){
					//list.add(year+"01"); list.add(year+"02");

					list.add(year+"03");
					pm[1]=year+"06";
					rs = dbobject.executePreparedQuery(str,pm);
					double score =-1;
					while(rs.next()){
						score = rs.getDouble("SCORE");
					}
					if (score ==-1){
						list.add(year+"04"); list.add(year+"05");
					}
				} else if (m==6) {
					//list.add(year+"04"); list.add(year+"05");

					list.add(year+"06");
					pm[1]=year+"09";
					rs = dbobject.executePreparedQuery(str,pm);
					double score =-1;
					while(rs.next()){
						score = rs.getDouble("SCORE");
					}
					if (score ==-1){
						list.add(year+"07"); list.add(year+"08");
					}
				} else if (m==9) {
					//list.add(year+"07"); list.add(year+"08");

					list.add(year+"09");
					pm[1]=year+"12";
					rs = dbobject.executePreparedQuery(str,pm);
					double score =-1;
					while(rs.next()){
						score = rs.getDouble("SCORE");
					}
					if (score ==-1){
						list.add(year+"10"); list.add(year+"11");
					}
				} else if (m==12){
					//list.add(year+"10"); list.add(year+"11");

					list.add(year+"12");
					int nYear = new Integer(year).intValue()+1;

					pm[1]=String.valueOf(nYear)+"03";
					rs = dbobject.executePreparedQuery(str,pm);
					double score =-1;
					while(rs.next()){
						score = rs.getDouble("SCORE");
					}
					if (score ==-1){
						list.add(String.valueOf(nYear)+"01"); list.add(String.valueOf(nYear)+"02");
					}
				}
			} else if (measuredetail.frequency.equals("반기")){
				if (m==6){
					//list.add(year+"01"); list.add(year+"02"); list.add(year+"03");list.add(year+"04"); list.add(year+"05");
					list.add(year+"06");
					pm[1]=year+"12";
					rs = dbobject.executePreparedQuery(str,pm);
					double score =-1;
					while(rs.next()){
						score = rs.getDouble("SCORE");
					}
					if (score ==-1){
						list.add(year+"07"); list.add(year+"08"); list.add(year+"09"); list.add(year+"10"); list.add(year+"11");
					}
				} else if (m==12) {
					//list.add(year+"07"); list.add(year+"08"); list.add(year+"09"); list.add(year+"10"); list.add(year+"11");

					list.add(year+"12");
					int nYear = new Integer(year).intValue()+1;

					pm[1]=String.valueOf(nYear)+"06";
					rs = dbobject.executePreparedQuery(str,pm);
					double score =-1;
					while(rs.next()){
						score = rs.getDouble("SCORE");
					}
					if (score ==-1){
						list.add(String.valueOf(nYear)+"01"); list.add(String.valueOf(nYear)+"02"); list.add(String.valueOf(nYear)+"03"); list.add(String.valueOf(nYear)+"04"); list.add(String.valueOf(nYear)+"05");
					}
				}
			} else if (measuredetail.frequency.equals("년")){
				//list.add(year+"01"); list.add(year+"02"); list.add(year+"03");list.add(year+"04"); list.add(year+"05"); list.add(year+"06");
				//list.add(year+"07"); list.add(year+"08"); list.add(year+"09");list.add(year+"10"); list.add(year+"11");
				list.add(year+"12");

				int nYear = new Integer(year).intValue()+1;
				pm[1]=String.valueOf(nYear)+"12";
				rs = dbobject.executePreparedQuery(str,pm);
				double score=-1;
				while(rs.next()){
					score = rs.getDouble("SCORE");
				}
				if (score ==-1){
				//	list.add(String.valueOf(nYear)+"01"); list.add(String.valueOf(nYear)+"02"); list.add(String.valueOf(nYear)+"03"); list.add(String.valueOf(nYear)+"04"); list.add(String.valueOf(nYear)+"05");list.add(String.valueOf(nYear)+"06");
				//	list.add(String.valueOf(nYear)+"07"); list.add(String.valueOf(nYear)+"08"); list.add(String.valueOf(nYear)+"09"); list.add(String.valueOf(nYear)+"10"); list.add(String.valueOf(nYear)+"11");
				}
			}

			return list;
		} catch (SQLException e) {
			throw e;
		} finally {
			if (rs!=null) {rs.close(); rs=null;}
		}
	}


	public void setEvalNonMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year");
			String month = request.getParameter("month");

			if (year==null) return;

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			StringBuffer sb = new StringBuffer();
			Object[] pm = null;

			sb.append(" SELECT * FROM  ")
	         .append(" (SELECT * FROM  ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,D.ETLKEY,D.MEASUREMENT,T.YEAR,D.FREQUENCY,C.NAME  ")
	         .append(" FROM TBLMEASUREDEFINE D, TBLMEASURE C, TBLTREESCORE T WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.MEASUREMENT='비계량') MEA ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT ACTUAL,MEASUREID AMID FROM TBLMEASUREDETAIL WHERE SUBSTR(STRDATE,0,6)=?) ACT ")
	         .append(" ON MEA.MCID=ACT.AMID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT AVG(EVALSCORE) AVGSCR,EVALID,COUNT(EVALID) CNT FROM TBLMEAEVALDETAIL WHERE YEAR=? AND MONTH=? GROUP BY EVALID) EVA ")
	         .append(" ON MEA.MCID=EVALID  ")
	         .append(" WHERE ACTUAL IS NULL OR ACTUAL<>AVGSCR ) M ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME    ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ   ")
	         .append(" ON M.MPID=OBJ.OID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME    ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST   ")
	         .append(" ON OBJ.OPID=PST.PID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME    ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC  ")
	         .append(" ON PST.PPID=BSC.BID ")
	         .append(" WHERE BID IS NOT NULL ");

	         pm = new Object[] {year,year+month,year,month,year,year,year};

	         rs = dbobject.executePreparedQuery(sb.toString(),pm);

	         DataSet ds = new DataSet();
	         ds.load(rs);

	         request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
}
