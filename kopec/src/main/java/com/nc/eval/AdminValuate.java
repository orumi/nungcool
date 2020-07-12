package com.nc.eval;

import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;

public class AdminValuate {
	public void setEvalGroup(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			String qtr = Util.getPrevQty(null);

			String ym    = request.getParameter("curDate")!=null?request.getParameter("curDate"):null;
			if (ym == null){
				ym = request.getAttribute("curDate")!= null?request.getAttribute("curDate").toString():qtr.substring(0,6);
			}
			String year  = ym.substring(0,4);
			String month = ym.substring(4,6);

			if ("01".equals(month)||"02".equals(month)||"03".equals(month)) month = "03";
			if ("04".equals(month)||"05".equals(month)||"06".equals(month)) month = "06";
			if ("07".equals(month)||"08".equals(month)||"09".equals(month)) month = "09";
			if ("10".equals(month)||"11".equals(month)||"12".equals(month)) month = "12";

			System.out.println("setEvalGroup : " + year + month);
			StringBuffer sbGrp = new StringBuffer();
			Object[] params = null;

			// 2007년만 ...
			if ("2007".equals(year)) {
				sbGrp.append("SELECT * FROM TBLMEAEVALGRP WHERE YEAR=? AND MONTH=?");
				params = new Object[] {year,month};

			} else {
				// 년평가
/*				if ("12".equals(month)){
					sbGrp.append("SELECT * FROM TBLMEAEVALGRP WHERE YEAR=? AND MONTH=?");
					params = new Object[] {year,month};

				}else{
*/
					sbGrp.append(" SELECT  distinct cid, ccid, clevel, crank, cname,    ")
						 .append("          sid, scid GRPID, slevel, srank, sname GRPNM ")
						 .append(" FROM ")
						 .append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ")
						 .append("         from   tblhierarchy t,tblcompany c ")
						 .append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =? ")
						 .append("        ) com, ")
						 .append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
						 .append("         from   tblhierarchy t,tblsbu c ")
						 .append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =? ")
						 .append("        ) sbu, ")
						 .append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname ")
						 .append("         from   tblhierarchy t,tblbsc c ")
						 .append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =? ")
						 .append("        ) bsc, ")
						 .append("        ( ")
						 .append("         select evaldeptid from tblmeaevaldept  ")
						 .append("         where  grpid in (select grpid from tblmeaevalr  ")
						 .append("                          where evalrid like '%' and year = ? and month = ?) ")
						 .append("        ) emp ")
						 .append(" where  cid  = spid        ")
						 .append(" and    sid  = bpid        ")
						 .append(" and    bcid = evaldeptid  ")
						 .append(" order by crank, srank     ");

					params = new Object[] {year,year,year,year,month};
//				}
			}

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sbGrp.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("dsGrp", ds);
			request.setAttribute("month", month);
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 *  처리 과정 : 관리자가 평가진행과정을 전체적으로 모니터링이 가능하도록 구현
	 *  1. 그룹에 대한 지표 목록을 가져온다.
	 *  	1.1 지표 목록을 등록한다.
	 *  2. 평가자 목록을 가져 온다.
	 *  3. 평가 결과를 등록 한다.
	 */
	public void setEvalMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year = request.getParameter("year");
			String month = request.getParameter("month");

			if (year==null||month==null) return;

			if(month.length() != 2)
				month = "0" + month;

			String grpId = request.getParameter("grpId");
			String userId = (String)request.getSession().getAttribute("userId");

			System.out.println("grpId  ========"+grpId);
			System.out.println("userId  ========"+userId);

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

	         //=======================================================================================

	         StringBuffer strSQL = new StringBuffer();

	         Object[] pm22 = null;
	         if ("2007".equals(year)) {
	        	 strSQL.append("  SELECT  cid, ccid, clevel, crank, cname,  cweight,                                                                                 ")
		        	 .append("          sid, scid, slevel, srank, sname,  sweight,                                                                                  ")
		        	 .append("          bid, bcid, blevel, brank, bname,  sum(mweight) over (partition by cid, sid, bid          ) bweight,                         ")
		        	 .append("          pid, pcid, plevel, prank, pname,  sum(mweight) over (partition by cid, sid, bid, pid     ) pweight,                         ")
		        	 .append("          oid, ocid, olevel, orank, oname,  sum(mweight) over (partition by cid, sid, bid, pid, oid) oweight,                         ")
		        	 .append("          mid, mcid, mlevel, mrank, mname,  mweight,                                                                                  ")
		        	 .append("          mea.measureid, CASE WHEN (mea.MEASCHAR='I') THEN '고유' ELSE '공통' END mkind, measchar ,                                   ")
		        	 .append("          grp.year, grp.month, avg_score, grade, grade_score, round(mweight * grade_score/100,1)  meas_score                          ")
		        	 .append("  FROM                                                                                                                                ")
		        	 .append("         (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname             ")
		        	 .append("          from   tblhierarchy t,tblcompany c                                                                                          ")
		        	 .append("          where  t.contentid=c.id  and t.treelevel=0 and t.year = '2007'                                                           ")
		        	 .append("         ) com,                                                                                                                       ")
		        	 .append("         (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname             ")
		        	 .append("          from   tblhierarchy t,tblsbu c                                                                                              ")
		        	 .append("          where  t.contentid=c.id  and t.treelevel=1 and t.year = '2007'                                                         ")
		        	 .append("         ) sbu,                                                                                                                       ")
		        	 .append("         (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname             ")
		        	 .append("          from   tblhierarchy t,tblbsc c                                                                                              ")
		        	 .append("          where  t.contentid=c.id  and t.treelevel=2 and t.year = '2007'                                                           ")
		        	 .append("         ) bsc,                                                                                                                       ")
		        	 .append("         (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname             ")
		        	 .append("          from   tbltreescore t,tblpst c                                                                                              ")
		        	 .append("          where  t.contentid=c.id  and t.treelevel=3 and t.year = '2007'                                                          ")
		        	 .append("         ) pst  ,                                                                                                                     ")
		        	 .append("         (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname             ")
		        	 .append("          from   tbltreescore t,tblobjective c                                                                                        ")
		        	 .append("          where  t.contentid=c.id  and t.treelevel=4 and t.year = '2007'                                                           ")
		        	 .append("         ) obj ,                                                                                                                      ")
		        	 .append("         (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname,          ")
		        	 .append("                 c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey,                                               ")
		        	 .append("                 d.unit   , c.MEASCHAR ,                                                                                              ")
		        	 .append("                 d.planned,d.plannedbase, d.base, d.baselimit, d.limit                                                                ")
		        	 .append("          from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d                                                                ")
		        	 .append("          where  t.contentid=d.id  and t.treelevel=5 and t.year = '2007'  and d.measureid=c.id                                     ")
		        	 .append("          and    d.measurement = '비계량'                                                                                             ")
		        	 .append("         ) mea,                                                                                                                       ")
		        	 .append("         (                                                                                                                            ")
		        	 .append("           select a.grpid, a.grpnm, a.year, a.month,                                                                                  ")
		        	 .append("                  b.evaldeptid, c.id  gscid, c.name                                                                               ")
		        	 .append("           from tblmeaevalgrp a, tblmeaevaldept b,                                                                                    ")
		        	 .append("                tblsbu        c                                                                                                       ")
		        	 .append("           where a.grpid      = b.grpid                                                                                               ")
		        	 .append("           and   b.evaldeptid = c.id                                                                                                  ")
		        	 .append("           and   a.year = '2007'                                                                                                   ")
		        	 .append("           and   a.month= '12'                                                                                                     ")
		        	 .append("           and   a.grpid= ?                                                                                                     ")
		        	 .append("         ) grp,                                                                                                                       ")
		        	 .append("         (                                                                                                                            ")
		        	 .append("           SELECT evalid, year, month,                                                                                                ")
		        	 .append("                  avg_score,                                                                                                          ")
		        	 .append("                  case when avg_score >= 4.5 then 'S'                                                                                 ")
		        	 .append("                       when avg_score < 4.5  and  avg_score >= 3.5 then 'A'                                                           ")
		        	 .append("                       when avg_score < 3.5  and  avg_score >= 2.5 then 'B'                                                           ")
		        	 .append("                       when avg_score < 2.5  and  avg_score >= 1.5 then 'C'                                                           ")
		        	 .append("                       when avg_score < 1.5  then 'D'                                                                                 ")
		        	 .append("                  end grade,                                                                                                          ")
		        	 .append("                  case when avg_score >= 4.5 then '100'                                                                               ")
		        	 .append("                       when avg_score < 4.5  and  avg_score >= 3.5 then '90'                                                          ")
		        	 .append("                       when avg_score < 3.5  and  avg_score >= 2.5 then '80'                                                          ")
		        	 .append("                       when avg_score < 2.5  and  avg_score >= 1.5 then '70'                                                          ")
		        	 .append("                       when avg_score < 1.5  then '60'                                                                                ")
		        	 .append("                  end grade_score                                                                                                     ")
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
		        	 .append("               WHERE  year  = '2007'                                                                                            ")
		        	 .append("               AND    month = '12'                                                                                                 ")
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
		        	 .append("  and    scid = gscid                                                                                                ")
		        	 .append("  order by mea.measureid, crank, srank, brank, prank, orank ");

	        	 pm22 = new Object[] {grpId};
	         } else {
                     /* 평가 평균에 대한 점수 반영
                      * 2018 03 29 by kmc
                      *
                      * 1. 평가 최종 등급은 등급 사이
                      * 2. 평가결과는 평균 기준으로 적용
                      *
                      * */
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
				        	 .append("                  case when avg_score >=100 then 'S'                                                                                 ")
				        	 .append("                       when avg_score < 100 and  avg_score >= 95 then 'A+'                                                           ")
				        	 .append("                       when avg_score < 95  and  avg_score >= 90 then 'A'                                                           ")
				        	 .append("                       when avg_score < 90  and  avg_score >= 85 then 'B+'")
				        	 .append("                       when avg_score < 85  and  avg_score >= 80 then 'B'")
				        	 .append("                       when avg_score < 80  and  avg_score >= 75 then 'C+'")
				        	 .append("                       when avg_score < 75  and  avg_score >= 70 then 'C'")
				        	 .append("                       when avg_score < 70  and  avg_score >= 65 then 'D+'                                                           ")
				        	 .append("                       when avg_score < 65  then 'D'                                                                                 ")
				        	 .append("                  end grade,                                                                                                          ")
				        	 .append("                  case when avg_score >=100 then '100'                                                                                 ")
				        	 .append("                       when avg_score < 100 and  avg_score >= 95 then '95'                                                           ")
				        	 .append("                       when avg_score < 95  and  avg_score >= 90 then '90'                                                           ")
				        	 .append("                       when avg_score < 90  and  avg_score >= 85 then '85'")
				        	 .append("                       when avg_score < 85  and  avg_score >= 80 then '80'")
				        	 .append("                       when avg_score < 80  and  avg_score >= 75 then '75'")
				        	 .append("                       when avg_score < 75  and  avg_score >= 70 then '70'")
				        	 .append("                       when avg_score < 70  and  avg_score >= 65 then '65'                                                           ")
				        	 .append("                       when avg_score < 65  then '60'                                                                              ")
				        	 .append("                  end grade_score  ")
				        	 .append("           FROM                                                                                                                       ")
				        	 .append("               (                                                                                                                      ")
				        	 .append("               SELECT evalid, year, month, count(*) cnt,                                                                              ")
				        	 .append("                      sum(evalscore)  scr_sum,                                                                                        ")
				        	 .append("                      max(evalscore)  scr_max,                                                                                        ")
				        	 .append("                      min(evalscore)  scr_min,                                                                                        ")
				        	 .append("                      round(case when count(*) >= 5 then                                                                              ")
				        	 .append("                                     (sum(evalscore) - max(evalscore) - min(evalscore))/(count(*) - 2)                                ")
				        	 .append("                                 else sum(evalscore) / count(*)                                                                       ")
				        	 .append("                            end,2)  avg_score                                                                                         ")
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
				        	 .append("  order by mea.measureid, crank, srank, brank, prank, orank ");

			        	 pm22 = new Object[] {year,year,grpId, year,year,year,year,  year,month, year,month};

//					}
	         }

	         if (rs!=null){rs.close();rs=null;}


	        // pm = new Object[] {year,month,grpId,year,year,year,year,year};
	         rs = dbobject.executePreparedQuery(strSQL.toString(),pm22);

	         EvalMeasureUtil meautil = new EvalMeasureUtil();

	         while(rs.next())
	        	 meautil.AddMeasure2(rs);

//	         System.out.println("strSQL.toString()  ============== "+strSQL.toString());
//	         rs = dbobject.executePreparedQuery(strSQL.toString(),pm22);
//
//	         DataSet ds = new DataSet();
//				ds.load(rs);
//				request.setAttribute("ds",ds);

	         //=======================================================================================

	         StringBuffer str = new StringBuffer();
	         Object[] pmUser  = null;

	         if ("2007".equals(year)) {
		         str.append("SELECT E.*,(SELECT USERNAME FROM TBLUSER U WHERE U.USERID=E.EVALRID) USERNAME, ")
		         	.append(" (SELECT APPRAISER FROM TBLUSER U WHERE U.USERID=E.EVALRID) APP FROM TBLMEAEVALR E WHERE GRPID=?");

		         pmUser = new  Object[] {grpId};
	         } else {
	        	 str.append(" SELECT E.*,(SELECT USERNAME  FROM TBLUSER U WHERE U.USERID=E.EVALRID) USERNAME,                                             ");
	        	 str.append("            (SELECT APPRAISER FROM TBLUSER U WHERE U.USERID=E.EVALRID) APP                                                   ");
	        	 str.append(" FROM   TBLMEAEVALR E                                                                                                        ");
	        	 str.append(" WHERE  GRPID IN (                                                                                                           ");
	        	 str.append(" SELECT   grpid                                                                                                              ");
	        	 str.append(" FROM    (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname    ");
	        	 str.append("          from   tblhierarchy t,tblsbu c                                                                                     ");
	        	 str.append("          where  t.contentid=c.id  and t.treelevel=1 and t.year =? AND t.contentid = ?                                    ");
	        	 str.append("         ) sbu,                                                                                                              ");
	        	 str.append("         (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname    ");
	        	 str.append("          from   tblhierarchy t,tblbsc c                                                                                     ");
	        	 str.append("          where  t.contentid=c.id  and t.treelevel=2 and t.year =?                                                      ");
	        	 str.append("         ) bsc,                                                                                                              ");
	        	 str.append("         (                                                                                                                   ");
	        	 str.append("          SELECT a.grpid, a.grpnm, b.evaldeptid gbcid                                                                        ");
	        	 str.append("          FROM   tblmeaevalgrp  a, tblmeaevaldept b                                                                          ");
	        	 str.append("          WHERE  a.grpid = b.grpid                                                                                           ");
	        	 str.append("          AND    a.year  = ?                                                                                            ");
	        	 str.append("          AND    a.month = ?                                                                                              ");
	        	 str.append("          ) grp                                                                                                              ");
	        	 str.append(" WHERE   sid  = bpid                                                                                                         ");
	        	 str.append(" AND     bcid = gbcid                                                                                                        ");
	        	 str.append(" )                                                                                                                           ");

		         pmUser = new  Object[] {year, grpId, year, year,month };
	         }


	         if (rs!=null){rs.close(); rs=null;}

	         rs = dbobject.executePreparedQuery(str.toString(),pmUser);

	         while(rs.next())
	        	 meautil.setAppName(rs);

	         StringBuffer sb1 = new StringBuffer();
	         Object[] pm1 = null;

	         if ("2007".equals(year)) {
		         sb1.append(" SELECT * FROM TBLMEAEVALDETAIL WHERE YEAR='2007' AND MONTH='12' AND EVALID IN (  ")
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
		         .append("         where  t.contentid=c.id  and t.treelevel=0 and t.year ='2007' ")
		         .append("        ) com, ")
		         .append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
		         .append("         from   tblhierarchy t,tblsbu c ")
		         .append("         where  t.contentid=c.id  and t.treelevel=1 and t.year ='2007' ")
		         .append("        ) sbu, ")
		         .append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname ")
		         .append("         from   tblhierarchy t,tblbsc c ")
		         .append("         where  t.contentid=c.id  and t.treelevel=2 and t.year ='2007' ")
		         .append("        ) bsc, ")
		         .append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname ")
		         .append("         from   tbltreescore t,tblpst c ")
		         .append("         where  t.contentid=c.id  and t.treelevel=3 and t.year ='2007' ")
		         .append("        ) pst  , ")
		         .append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname ")
		         .append("         from   tbltreescore t,tblobjective c ")
		         .append("         where  t.contentid=c.id  and t.treelevel=4 and t.year ='2007' ")
		         .append("        ) obj , ")
		         .append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname, ")
		         .append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey, ")
		         .append("                d.unit       , ")
		         .append("                d.planned, d.base,  d.limit ")
		         .append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d ")
		         .append("         where  t.contentid=d.id  and t.treelevel=5 and t.year ='2007' and d.measureid=c.id ")
		         .append("         and    d.measurement = '비계량' ")
		         .append("        ) mea,  ")
		         .append("        ( ")
		         .append("         SELECT a.grpid, a.grpnm, b.evaldeptid gscid  ")
		         .append("         FROM   tblmeaevalgrp  a, tblmeaevaldept b ")
		         .append("         WHERE  a.grpid = b.grpid ")
		         .append("         AND    a.year  = '2007' ")
		         .append("         AND    a.month = '12' ")
		         .append("         AND    a.grpid = ? ")
		         .append("         ) grp ")
		         .append(" where  cid = spid (+) ")
		         .append(" and    sid = bpid (+) ")
		         .append(" and    bid = ppid (+) ")
		         .append(" and    pid = opid (+) ")
		         .append(" and    oid = mpid  ")
		         .append(" and    scid = gscid ")
		         .append(" order by crank, srank, brank, prank, orank, mrank ")
		         .append(" ) ")
		         .append(" ) ");

		         pm1 = new Object[] {grpId};

	         } else {

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
//	        	 }

	         }



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

	public void setEvalDetail(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String year = request.getParameter("year");
			String month = request.getParameter("month");

			String mId = request.getParameter("mId");
			if (mId==null) return;

			String userId = (String)request.getSession().getAttribute("userId");
			String evalrId = request.getParameter("evalrId");

			String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			if ("R".equals(tag)){
				String str = "UPDATE TBLMEAEVALDETAIL SET CONFIRM=0 WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=?";
				Object[] pm = {mId,evalrId,year,month};

				dbobject.executePreparedUpdate(str,pm);

				conn.commit();
			}

			String frq = getFrequecny(new Integer(month).intValue());

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM  ")
	         .append(" (SELECT D.ID,D.MEASUREID,D.WEIGHT,D.UNIT,D.FREQUENCY,D.MEASUREMENT,D.TREND,C.NAME FROM TBLMEASUREDEFINE D,TBLMEASURE C WHERE D.MEASUREID=C.ID AND D.ID=?) MEA ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT MEASUREID MID,PLANNED,DETAIL,FILEPATH,PCONFIRM,ACONFIRM FROM TBLEVALMEASUREDETAIL WHERE EFFECTIVEDATE=?) DTL ")
	         .append(" ON MEA.ID=DTL.MID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT E.*,(SELECT USERNAME FROM TBLUSER WHERE USERID=EVALRID) USERNAME FROM TBLMEAEVALDETAIL E WHERE EVALRID=? AND YEAR=? AND MONTH=?) EVAL ")
	         .append(" ON MEA.ID=EVAL.EVALID ");

			Object[] pm = {mId,year+month,evalrId,year,month};

			rs = dbobject.executePreparedQuery(sb.toString(),pm);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds", ds);
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

	public void setPopDetail(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String year  = request.getParameter("year");
			String month = request.getParameter("month");
			String grpId = request.getParameter("grpId");
			if (grpId==null) return;

			System.out.println("setPopDetail : " + year + month + " GrpID : " + grpId );

			String userId = (String)request.getSession().getAttribute("userId");
			String evalrId = request.getParameter("evalrId");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM ")
	         .append(" (SELECT GRPID,GRPNM,YEAR,MONTH FROM TBLMEAEVALGRP WHERE GRPID IN (SELECT GRPID FROM TBLMEAEVALR WHERE EVALRID=?)  ")
	         .append(" AND YEAR=? AND MONTH=12 AND GRPID=?) GRP ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT D.GRPID GID,D.EVALDEPTID,B.ID,B.NAME FROM TBLMEAEVALDEPT D, TBLMEASURE B WHERE D.EVALDEPTID=B.ID) DEP ")
	         .append(" ON GRP.GRPID=DEP.GID  ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID, ")
	         .append(" CASE WHEN (C.MEASCHAR='I') THEN '고유' ELSE '공통' END MKIND,C.MEASCHAR  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA ")
	         .append(" ON DEP.EVALDEPTID=MEA.MEASUREID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
	         .append(" ON PST.PID=OBJ.OPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
	         .append(" ON BSC.BID=PST.PPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? ) SBU ")
	         .append(" ON BSC.BPID=SBU.SID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT EVALGRADE,EVALSCORE,EVALID FROM TBLMEAEVALDETAIL WHERE YEAR=? AND MONTH=12 AND EVALRID=?) EVAL ")
	         .append(" ON MEA.MCID=EVALID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT MEASUREID AMID,FILEPATH,FILENAME FROM TBLEVALMEASUREDETAIL WHERE EFFECTIVEDATE=?) ATT ")
	         .append(" ON MEA.MCID=ATT.AMID ")
	         .append(" ORDER BY MEASUREID,SRANK,BRANK,BID ");

			Object[] pm = {evalrId,year,grpId,year,year,year,year,year,year,evalrId,year+"12"};

			rs = dbobject.executePreparedQuery(sb.toString(),pm);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds", ds);

			String strBW = "SELECT * FROM TBLMEAEVALOPINION01 WHERE GRPID=? AND EVALR=? AND YEAR=? AND MONTH=12";
			Object[] pmBW = {grpId,evalrId,year};

			if (rs!=null) {rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(strBW,pmBW);

			DataSet dsBW = new DataSet();
			dsBW.load(rs);

			request.setAttribute("dsBW",dsBW);

			StringBuffer sbDiv = new StringBuffer();
			sbDiv.append(" SELECT * FROM   ")
	         .append(" (SELECT GRPID, GRPNM FROM TBLMEAEVALGRP WHERE GRPID=? ) GRP  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT D.GRPID GID,D.EVALDEPTID,B.ID,B.NAME FROM TBLMEAEVALDEPT D, TBLMEASURE B WHERE D.EVALDEPTID=B.ID) DEP  ")
	         .append(" ON GRP.GRPID=DEP.GID  ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID, ")
	         .append(" CASE WHEN (C.MEASCHAR='I') THEN '고유' ELSE '공통' END MKIND,C.MEASCHAR  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA ")
	         .append(" ON DEP.EVALDEPTID=MEA.MEASUREID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
	         .append(" ON PST.PID=OBJ.OPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
	         .append(" ON BSC.BID=PST.PPID ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT EVALID,EVALOPINION FROM TBLMEAEVALDETAIL WHERE YEAR=? AND EVALRID=?) OPN  ")
	         .append(" ON MEA.MCID=OPN.EVALID  ");

			Object[] pmDiv = {grpId,year,year,year,year,year, evalrId};

			if (rs!=null){rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(sbDiv.toString(),pmDiv);

			DataSet dsDiv = new DataSet();
			dsDiv.load(rs);

			request.setAttribute("dsDiv",dsDiv);


		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
}
