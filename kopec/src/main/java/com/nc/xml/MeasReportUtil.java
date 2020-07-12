package com.nc.xml;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.ServerStatic;
import com.nc.util.Util;

public class MeasReportUtil {




    /**
     * Method Name : getMeasList
     * Description : �ڵ� List�� ����.
     * Author	   : PHG
     * Create Date : 2008-02-04
     * History	          :
     * @throws SQLException
     */
	public void getMeasList(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			String name = request.getParameter("name")==null?"%":request.getParameter("name");
			String measchar = request.getParameter("measchar")==null?"%":request.getParameter("measchar");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
            sbSQL.append(" select id,                                                     ");
            sbSQL.append("           code,                                                ");
            sbSQL.append("           name,                                                ");
            sbSQL.append("           measchar,                                            ");
            sbSQL.append("           case when measchar = 'C' then '공통지표'             ");
            sbSQL.append("                    else '고유지표'                             ");
            sbSQL.append("           end  meascharnm                                      ");
            sbSQL.append("  from   tblmeasure                                             ");
            sbSQL.append("  where  name like '%'||?||'%'                                  ");
            sbSQL.append("  and    nvl(measchar,'I') like ?||'%'                          ");
            sbSQL.append("  order by name                                                 ");

			System.out.println("Name : " + name + "Char " + measchar);

			Object[] pmSQL =  {name, measchar};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getComCode : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}//-- method getMeasList

    /**
     * Method Name : getYearMeasList
     * Description : �ڵ� List�� ����(�򰡳⵵)
     * Author	   : PHG
     * Create Date : 2008-02-04
     * History	          :
     * @throws SQLException
     */
	public void getYearMeasList(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			String year = request.getParameter("year");
			String name = request.getParameter("name")==null?"%":request.getParameter("name");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());



			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append(" SELECT b.id,                                      ");
			sbSQL.append("        b.code,                                    ");
			sbSQL.append("        b.name,                                    ");
			sbSQL.append("        b.measchar,                                ");
			sbSQL.append("        case when b.measchar = 'C' then '공통지표' ");
			sbSQL.append("             else '고유지표'                       ");
			sbSQL.append("        end  meascharnm                            ");
			sbSQL.append(" FROM                                              ");
			sbSQL.append("     (                                             ");
			sbSQL.append("     SELECT distinct measureid                     ");
			sbSQL.append("     FROM  TBLMEASUREDEFINE                        ");
			sbSQL.append("     WHERE year = ?                                ");
			sbSQL.append("     ) a,                                          ");
			sbSQL.append("     tblmeasure b                                  ");
			sbSQL.append(" where  a.measureid = b.id                         ");
			sbSQL.append(" and    b.name like '%'||?||'%'                    ");
			sbSQL.append(" order by b.name                                   ");


			Object[] pmSQL =  {year, name};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getYearMeasList : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}//-- method getYearMeasList

	/*
	 *  Method : getOrgRank
	 *  Desc.  :  �μ����� ��ȸ
	 *  Created by : Park.HG, 2008.02.28
	 *
	 */
	public void getOrgRank(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year           = request.getParameter("year");
			String ym             = request.getParameter("ym");
			String sbuId         = request.getParameter("sbuId")==null?"%":request.getParameter("sbuId");


//			year = "2007";
//			ym   = "200712";

			System.out.println(" getOrgRank : " + year + "-" +  ym + "-" + sbuId);

			StringBuffer sb = new StringBuffer();
			sb.append("  select sid, max(sname) sname, bid, max(bname)  bname,  max(bcid)  bcid,                                                ");
			sb.append("         sum(case when measurement='계량'   then mweight         end)   mweight1,                                                 ");
			sb.append("         round(sum(case when measurement='계량'   then grade_score     end),2)   mscore1 ,                                                 ");
			sb.append("         sum(case when measurement='비계량' then mweight         end)   mweight2,                                                 ");
			sb.append("         round(sum(case when measurement='비계량' then grade_score     end),2)   mscore2 ,                                                 ");
			sb.append("         round(sum(grade_score),2)                               scoresum,                                                               ");
			sb.append("         max(addscr)                                    scoreadd,                                                               ");
			sb.append("         max(inputScr)                              inputScr,                                                               ");
			sb.append("         max(calGrd)                              calGrd,                                                               ");
			sb.append("         max(calGrdScr)                              calGrdScr,                                                               ");
			sb.append("         round(nvl(sum(grade_score),0) + nvl(max(addscr),0),2)   scoretot,                                                               ");
			sb.append("         max(nvl(addscr_cmt,''))				 	       scoreadd_cmt,                                                             ");
			sb.append("         nvl(blink,0) blink,                                                             ");
			sb.append("         rank() over (partition by sid,nvl(blink,0) order by nvl(sum(grade_score),0) + nvl(max(addscr),0) desc) grp_rank                     ");
			sb.append("  from                                                                                                                    ");
			sb.append("          (select c.name cname,t.id cid,t.contentid ccid,t.parentid cpid,t.rank crank                                     ");
			sb.append("          from tblcompany c, tblhierarchy t where t.treelevel=0 and t.year=? and t.contentid=c.id) com,             ");
			sb.append("          (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank                                     ");
			sb.append("          from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id  and t.id like ? ) sbu,                 ");
			sb.append("          (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank, c.link blink                                     ");
			sb.append("          from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc,                 ");
			sb.append("          (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank                                     ");
			sb.append("          from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst,                ");
			sb.append("          (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank                                     ");
			sb.append("          from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj,           ");
			sb.append("          (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.measureid,     ");
			sb.append("                  detaildefine, d.unit measunit,                                                                          ");
			sb.append("                 entrytype, measuretype,                                                                                  ");
			sb.append("                 frequency, equation, equationdefine,                                                                     ");
			sb.append("                 etlkey, measurement,                                                                                     ");
			sb.append("                 trend, e.planned, e.plannedbase, e.base,e.baselimit, e.limit,                                            ");
			sb.append("                 e.actual, e.grade, e.grade_score, e.score, nvl(e.grade_score, 0) rank_score                              ");
			sb.append("          from tblmeasure c, tbltreescore t, tblmeasuredefine d, tblmeasurescore e                                        ");
			sb.append("          where t.treelevel=5 and t.year=? and t.contentid=d.id                                                      ");
			sb.append("          and  d.measureid = c.id                                                                                         ");
			sb.append("          and  d.id = e.measureid (+)                                                                                     ");
			sb.append("          and  e.strdate(+) like ?||'%' ) mea,                                                                       ");
			sb.append("          (select bid ebid, addscr, inputScr,calGrd,calGrdScr, addscr_cmt from tblevalresult where year = ? and month=substr(?,5,2))   eval                          ");
			sb.append("  where  com.cid=sbu.spid                                                                                                 ");
			sb.append("  and    sbu.sid=bsc.bpid                                                                                                 ");
			sb.append("  and    bsc.bid=pst.ppid                                                                                                 ");
			sb.append("  and    pst.pid=obj.opid                                                                                                 ");
			sb.append("  and    obj.oid=mea.mpid                                                                                                 ");
			sb.append("  and    bsc.bid=eval.ebid(+)                                                                                             ");
			sb.append("  group by sid, bid, blink                                                                                                      ");
			sb.append("  order by sid, blink, bid                                                                                                       ");


	         Object[] params = {year,year,sbuId,year,year,year,year,ym,year,ym};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sb.toString(),params);

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


	/*
	 *  Method : getMeasRank
	 *  Desc.  : ��ǥ�� �μ����� ��ȸ
	 *  Created by : Park.HG, 2008.02.28
	 *
	 */
	public void getMeasRank(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year           = request.getParameter("year");
			String ym             = request.getParameter("ym");
			String measureid = request.getParameter("measureid");

			System.out.println(" getMeasRank : " + measureid);

			StringBuffer sb = new StringBuffer();
			sb.append("  select mname, mcid, sid, sname, bid, bname,                                                                           ");
			sb.append("         mweight, planned, plannedbase, base, baselimit, limit,                                                         ");
			sb.append("         round(actual,1) actual, grade  , grade_score, score, rank_score,                                           ");
			sb.append("         rank() over(partition by sid order by rank_score desc ) grp_rank,                                              ");
			sb.append("         rank() over(order by rank_score desc )                  all_rank,                                              ");
			sb.append("         round(avg(grade_score) over(partition by sid ),1)       grp_avg,                                               ");
			sb.append("         round(avg(grade_score) over(),1)                        all_avg                                                ");
			sb.append("  from                                                                                                                  ");
			sb.append("      (select c.name cname,t.id cid,t.contentid ccid,t.parentid cpid,t.rank crank                                       ");
			sb.append("      from tblcompany c, tblhierarchy t where t.treelevel=0 and t.year=? and t.contentid=c.id ) com,               ");
			sb.append("      (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank                                       ");
			sb.append("      from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id ) sbu,                   ");
			sb.append("      (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank                                       ");
			sb.append("      from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc,                   ");
			sb.append("      (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank                                       ");
			sb.append("      from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst,                  ");
			sb.append("      (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank                                       ");
			sb.append("      from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj,             ");
			sb.append("      (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.measureid,       ");
			sb.append("              detaildefine, d.unit measunit,                                                                            ");
			sb.append("             entrytype, measuretype,                                                                                    ");
			sb.append("             frequency, equation, equationdefine,                                                                       ");
			sb.append("             etlkey, measurement,                                                                                       ");
			sb.append("             trend, e.planned, e.plannedbase, e.base,e.baselimit, e.limit,                                              ");
			sb.append("             e.actual, e.grade, e.score  grade_score, e.score, nvl(e.score, 0) rank_score                                ");
			sb.append("      from tblmeasure c, tbltreescore t, tblmeasuredefine d, tblmeasurescore e                                          ");
			sb.append("      where t.treelevel=5 and t.year=? and t.contentid=d.id                                                              ");
			sb.append("      and  d.measureid = c.id                                                                                            ");
			sb.append("      and  d.id = e.measureid (+)                                                                                        ");
			sb.append("      and  e.strdate(+) like ?||'%'                                                                                      ");
			sb.append("      and  c.id like ? ) mea                                                                                             ");
			sb.append("  where  com.cid=sbu.spid                                                                                               ");
			sb.append("  and    sbu.sid=bsc.bpid                                                                                               ");
			sb.append("  and    bsc.bid=pst.ppid                                                                                               ");
			sb.append("  and    pst.pid=obj.opid                                                                                               ");
			sb.append("  and    obj.oid=mea.mpid                                                                                               ");
			sb.append("  order by srank,sid, brank,bid                                                                                         ");

	         Object[] params = {year,year,year,year,year,year,ym,measureid};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sb.toString(),params);

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


	/*
	 *  Method : getOrgAddScore
	 *  Desc.  :  �μ����������
	 *  Created by : Choi,YS, 2008.03.04
	 *
	 */
	public void getOrgAddScore(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String userId		= (String)request.getSession().getAttribute("userId");
			String year         = request.getParameter("year");
			String ym           = request.getParameter("ym");
			String month        = ym.substring(4, 6);  //request.getParameter("month");
			if (month==null || "".equals(month)){
				month = ym.substring(4, 6);
			}
			String sbuId        = request.getParameter("sbuId")==null?"%":request.getParameter("sbuId");
			String mode			= request.getParameter("mode")==null?"":request.getParameter("mode");

			String scoreadd		= request.getParameter("scoreadd")==null?"":request.getParameter("scoreadd");
			String scoretot		= request.getParameter("scoretot")==null?"":request.getParameter("scoretot");
			String scoreadd_cmt	= request.getParameter("scoreadd_cmt")==null?"":request.getParameter("scoreadd_cmt");
			String sid			= request.getParameter("sid")==null?"":request.getParameter("sid");
			String scid			= request.getParameter("scid")==null?"":request.getParameter("scid");
			String bid			= request.getParameter("bid")==null?"":request.getParameter("bid");

			String inputScr		= request.getParameter("inputScr")==null?"":request.getParameter("inputScr");
			String calGrd		= request.getParameter("calGrd")==null?"":request.getParameter("calGrd");
			String calGrdScr	= request.getParameter("calGrdScr")==null?"":request.getParameter("calGrdScr");



//			year = "2007";
//			ym   = "200712";
			System.out.println("getOrgAddScore:"+mode+"/"+year+"/"+month+"/"+ym+"/"+scoretot+"/"+scoreadd+"/"+scoreadd_cmt+"/"+scid+"/"+sid);

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			if("U".equals(mode)){
				StringBuffer sbU = new StringBuffer();
				sbU.append("UPDATE TBLEVALRESULT SET TOTALSCR=?, ADDSCR=?, ADDSCR_CMT=?, INPUTSCR=?, CALGRD=?, CALGRDSCR=? WHERE YEAR=? AND MONTH=? AND BCID=? AND BID=?");
				Object[] paramU = {scoretot,scoreadd,scoreadd_cmt,inputScr,calGrd,calGrdScr,    year,month,bid,bid};

				StringBuffer sbI = new StringBuffer();
				sbI.append(" INSERT INTO TBLEVALRESULT(YEAR, MONTH, BCID, BID, TOTALSCR, ADDSCR, ADDSCR_CMT, INPUTSCR, CALGRD, CALGRDSCR, REGIR, REGIDATE) ")
				   .append(" VALUES(?,?,?,?,?,?,?,?,?,?,?,SYSDATE)");
				Object[] paramI = {year,month,bid,bid,scoretot,scoreadd,scoreadd_cmt,inputScr,calGrd,calGrdScr,  userId};

				int ret = dbobject.executePreparedUpdate(sbU.toString(),paramU);
		        if(ret<1){
		        	System.out.println("Insert ...");
					dbobject.executePreparedUpdate(sbI.toString(),paramI);
				}
		        conn.commit();
		        //System.out.println("ret:"+ret);
			}else if("D".equals(mode)){
				StringBuffer sbD = new StringBuffer();
				sbD.append("DELETE FROM TBLEVALRESULT WHERE YEAR=? AND MONTH=? AND BCID=? AND BID=? ");
				Object[] paramD = {year,month,bid,bid};

				dbobject.executePreparedUpdate(sbD.toString(),paramD);
				//System.out.println("delete!!!");
				conn.commit();
			}


			StringBuffer sb = new StringBuffer();
			sb.append("  select sid, scid, max(sname) sname, bid, max(bname)  bname,                                                                   ");
			sb.append("         sum(case when measurement='계량'   then mweight   end)   mweight1,                                                ");
			sb.append("         sum(case when measurement='계량'   then grade_score     end)   mscore1 ,                                                ");
			sb.append("         sum(case when measurement='비계량' then mweight   end)   mweight2,                                                ");
			sb.append("         sum(case when measurement='비계량' then grade_score    end)    mscore2 ,                                                 ");
			sb.append("         sum(grade_score)                               scoresum,                                                               ");
			sb.append("         max(addscr)                              scoreadd,                                                               ");
			sb.append("         max(inputScr)                              inputScr,                                                               ");
			sb.append("         max(calGrd)                              calGrd,                                                               ");
			sb.append("         max(calGrdScr)                              calGrdScr,                                                               ");
			sb.append("         nvl(sum(grade_score),0) + nvl(max(addscr),0)   scoretot,                                                               ");
			sb.append("         max(nvl(addscr_cmt,''))				 	 addscr_cmt,                                                             ");
			sb.append("         nvl(blink,0) blink,                                                             ");
			sb.append("         rank() over (partition by sid, nvl(blink,0) order by nvl(sum(grade_score),0) + nvl(max(addscr),0) desc) grp_rank                     ");
			sb.append("  from                                                                                                                    ");
			sb.append("          (select c.name cname,t.id cid,t.contentid ccid,t.parentid cpid,t.rank crank                                     ");
			sb.append("          from tblcompany c, tblhierarchy t where t.treelevel=0 and t.year=? and t.contentid=c.id) com,             		 ");
			sb.append("          (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank                                     ");
			sb.append("          from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id  and t.id like ? ) sbu,     ");
			sb.append("          (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank, c.link blink                                     ");
			sb.append("          from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc,                 	 ");
			sb.append("          (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank                                     ");
			sb.append("          from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst,                	 ");
			sb.append("          (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank                                     ");
			sb.append("          from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj,           	 ");
			sb.append("          (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.measureid,     ");
			sb.append("                  detaildefine, d.unit measunit,                                                                          ");
			sb.append("                 entrytype, measuretype,                                                                                  ");
			sb.append("                 frequency, equation, equationdefine,                                                                     ");
			sb.append("                 etlkey, measurement,                                                                                     ");
			sb.append("                 trend, e.planned, e.plannedbase, e.base,e.baselimit, e.limit,                                            ");
			sb.append("                 e.actual, e.grade, e.grade_score, e.score, nvl(e.grade_score, 0) rank_score                              ");
			sb.append("          from tblmeasure c, tbltreescore t, tblmeasuredefine d, tblmeasurescore e                                        ");
			sb.append("          where t.treelevel=5 and t.year=? and t.contentid=d.id                                                      	 ");
			sb.append("          and  d.measureid = c.id                                                                                         ");
			sb.append("          and  d.id = e.measureid (+)                                                                                     ");
			sb.append("          and  e.strdate(+) like ?||'%' ) mea,                                                                       	 ");
			sb.append("          (select bid ebid, addscr, inputScr,calGrd,calGrdScr, addscr_cmt from tblevalresult where year = ? and month=substr(?,5,2))   eval          ");
			sb.append("  where  com.cid=sbu.spid                                                                                                 ");
			sb.append("  and    sbu.sid=bsc.bpid                                                                                                 ");
			sb.append("  and    bsc.bid=pst.ppid                                                                                                 ");
			sb.append("  and    pst.pid=obj.opid                                                                                                 ");
			sb.append("  and    obj.oid=mea.mpid                                                                                                 ");
			sb.append("  and    bsc.bid=eval.ebid(+)                                                                                             ");
			sb.append("  group by sid, scid, bid, blink                                                                                                       ");
			sb.append("  order by sid, scid, blink, bid                                                                                                       ");

	        Object[] params = {year,year,sbuId,year,year,year,year,ym,year,ym};

	        dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sb.toString(),params);

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

	/*
	 *  Method     : getOrgScore
	 *  Desc.      : ������ ������ȸ
	 *  Created by : PHG, 2008.03.15
	 *
	 */
	public void getOrgScore(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year  = request.getParameter("year" );
			String ym    = request.getParameter("ym"   );
			String bscid = request.getParameter("bscid");

//			year = "2008";
//			ym = "200812";
//			bscid = "81";

			System.out.println("getOrgScore : ym-" +ym + ", bscid-" + bscid);

			//-------------------------------------------------------------------------------------------------
			// Query�� ���� ��Ʊ� ������ ������ ���� ���ذ� �� ����.
			//-------------------------------------------------------------------------------------------------
			// 1. bcscore  : ������ �Էµ� ��ǥ������ ��( SUM(���� * ��ǥ����ġ) / bcweight)
			// 2. bcweight : ������ �Էµ� ����ġ�� ��
			//-------------------------------------------------------------------------------------------------
			// ==> �׳� �ѹ� �������� ���ذ� �� ����.
			//-------------------------------------------------------------------------------------------------

			StringBuffer sb = new StringBuffer();
			sb.append("  select bid, bpid, bcid, blevel, brank, bweight, bname,                                                                  ");
			sb.append("             round(sum(calcscore) over(partition by bid) /                                                                ");
			sb.append("                  sum(case when mcscore is not null then mweight end) over(partition by bid),1)  bcscore,                 ");
			sb.append("             sum(case when mcscore is not null then mweight end) over(partition by bid)  bcweight,                        ");
			sb.append("         pid, ppid, pcid, plevel, prank, pweight, pname,                                                                  ");
			sb.append("             round(sum(calcscore) over(partition by bid,pid) /                                                            ");
			sb.append("                   sum(case when mcscore is not null then mweight end) over(partition by bid,pid),1)  pcscore,            ");
			sb.append("             sum(case when mcscore is not null then mweight end) over(partition by bid,pid)  pcweight,                    ");
			sb.append("         oid, opid, ocid, olevel, orank, oweight, oname,                                                                  ");
			sb.append("             round(sum(calcscore) over(partition by bid,pid,oid) /                                                        ");
			sb.append("                   sum(case when mcscore is not null then mweight end) over(partition by bid,pid,oid),1)  ocscore,        ");
			sb.append("             sum(case when mcscore is not null then mweight end) over(partition by bid,pid,oid)  ocweight,                ");
			sb.append("         mid, mpid, mcid, mlevel, mrank, mweight, mname,                                                                  ");
			sb.append("             measurement, frequency, trend, etlkey, unit,                                                                 ");
			sb.append("             planned, plannedbase, base, baselimit, limit ,                                                               ");
			sb.append("             actual, grade, score, grade_score,' ' comments , mcscore, calcscore                                          ");
			sb.append("  from                                                                                                                    ");
			sb.append("       (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel,t.rank brank,t.weight bweight,c.name bname    ");
			sb.append("       from tblhierarchy t,tblbsc c where t.contentid=c.id and t.treelevel=2 and t.year=? and t.id=to_number(?) ) bsc,    ");
			sb.append("       (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel,t.rank prank,t.weight pweight,c.name pname    ");
			sb.append("       from tbltreescore t,tblpst c where t.contentid=c.id and t.treelevel=3 and t.year=? ) pst  ,                        ");
			sb.append("       (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel,t.rank orank,t.weight oweight,c.name oname    ");
			sb.append("       from tbltreescore t,tblobjective c where t.contentid=c.id and t.treelevel=4 and t.year=? ) obj ,                   ");
			sb.append("       (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel,t.rank mrank,t.weight mweight,c.name mname,   ");
			sb.append("               d.measurement, d.frequency, d.trend, d.etlkey,d.unit,                                                      ");
			sb.append("               d.planned,d.plannedbase, d.base, d.baselimit, d.limit ,                                                    ");
			sb.append("               round(s.actual,2) actual, s.grade, s.score  score, s.grade_score, dt.comments,                             ");
			sb.append("               s.score   mcscore, s.score * d.weight calcscore                                                            ");
			sb.append("       from    tbltreescore t,tblmeasuredefine d, tblmeasure c,                                                           ");
			sb.append("               tblmeasurescore s, tblmeasuredetail dt                                                                     ");
			sb.append("       where t.contentid=d.id                                                                                             ");
			sb.append("       and   d.measureid=c.id                                                                                             ");
			sb.append("       and   t.treelevel=5                                                                                                ");
			sb.append("       and   d.id       =s.measureid  (+)                                                                                 ");
			sb.append("       and   s.measureid=dt.measureid (+)                                                                                 ");
			sb.append("       and   s.strdate  =dt.strdate   (+)                                                                                 ");
			sb.append("       and   s.strdate(+) like ?||'%'                                                                                     ");
			sb.append("       and   t.year=?   ) mea                                                                                             ");
			sb.append("   where bsc.bid=pst.ppid                                                                                                 ");
			sb.append("   and   pst.pid=obj.opid                                                                                                 ");
			sb.append("   and   obj.oid=mea.mpid                                                                                                 ");
			sb.append("   order by brank,bid,prank,pid,orank,oid,mrank																			 ");

			// ��ȸ Arg
			Object[] params = {year,bscid,year,year,ym,year};

			//System.out.println(sb.toString());

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

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
	}	// getOrgScore...

	/*
	 *  Method     : getOrgRankBonbu
	 *  Desc.      : ����(��)�� ���������� ���� : �ʱ�ȭ�鿡�� �̿�.
	 *  Created by : PHG, 2008.05.16
	 *
	 */

	public void getOrgRankBonbu(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String qtr    = Util.getPrevQty(null);

			String year  = (String)request.getAttribute("year" );
			String ym    = (String)request.getAttribute("ym"   );

			String scid  = "2" ; // request.getParameter("scid") ;		// ����(��)�� ��� �ڵ尡 2��.

			//ym = "200811";
			//year = "2008";


			StringBuffer sb = new StringBuffer();


			sb.append(" SELECT SID, SPID,SCID,SRANK,SNAME,BID,BPID, BCID, BRANK, BNAME,GSCORE, \n ");
			sb.append("         (SELECT (ADDSCR) FROM TBLEVALRESULT A WHERE A.BID = S.BID AND A.YEAR||A.MONTH=201712) ADDSCR, \n ");
			sb.append("         GSCORE + (SELECT (ADDSCR) FROM TBLEVALRESULT A WHERE A.BID = S.BID AND A.YEAR||A.MONTH=?) FSCR, \n ");
			sb.append("         BSCORE,DEPTRANK,colorgrade \n ");
			sb.append(" FROM (  \n ");


			 sb.append(" SELECT sid, spid, scid, srank, sname,                                                                                           ");
			 sb.append("        bid, bpid, bcid, brank, bname,                                                                                           ");
			 sb.append("        to_char(max(gscore),'999.00') gscore,                                                                                    ");
			 sb.append("        to_char(max(bcscore),'999.00') bscore,                                                                                   ");
			 sb.append("        rank() over (partition by sid order by max(bcscore) desc) deptrank,                                                      ");


			 sb.append("        case when max(bcscore) > "+ServerStatic.HIGH+"   then 's'                                                                 ");
			 sb.append("             when max(bcscore) > "+ServerStatic.LOW+"    then 'a'                                                                  ");
			 sb.append("             when max(bcscore) > "+ServerStatic.LOWER+"  then 'b'                                                                ");
			 sb.append("             when max(bcscore) > "+ServerStatic.LOWST+"  then 'c'                                                                ");
			 sb.append("             when max(bcscore) <= "+ServerStatic.LOWST+" then 'd'                                                                ");
			 sb.append("             else 'n'                                                                                                            ");
			 sb.append("        end  colorgrade                                                                                                          ");


			 sb.append(" FROM   (                                                                                                                        ");
			 sb.append("   select                                                                                                                        ");
			 sb.append("         sid, spid, scid, slevel, srank, sweight, sname,                                                                         ");
			 sb.append("         bid, bpid, bcid, blevel, brank, bweight, bname,                                                                         ");
			 sb.append("              round(sum(grade_score) over(partition by bid) ,2) gscore,                                                          ");
			 sb.append("              round(sum(calcscore) over(partition by bid) /                                                                      ");
			 sb.append("                   sum(case when mcscore is not null then mweight end) over(partition by bid),2)  bcscore,                       ");
			 sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid)  bcweight,                              ");
			 sb.append("          pid, ppid, pcid, plevel, prank, pweight, pname,                                                                        ");
			 sb.append("              round(sum(calcscore) over(partition by bid,pid) /                                                                  ");
			 sb.append("                    sum(case when mcscore is not null then mweight end) over(partition by bid,pid),2)  pcscore,                  ");
			 sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid,pid)  pcweight,                          ");
			 sb.append("          oid, opid, ocid, olevel, orank, oweight, oname,                                                                        ");
			 sb.append("              round(sum(calcscore) over(partition by bid,pid,oid) /                                                              ");
			 sb.append("                    sum(case when mcscore is not null then mweight end) over(partition by bid,pid,oid),2)  ocscore,              ");
			 sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid,pid,oid)  ocweight,                      ");
			 sb.append("          mid, mpid, mcid, mlevel, mrank, mweight, mname,                                                                        ");
			 sb.append("              measurement, frequency, trend, etlkey, unit,                                                                       ");
			 sb.append("              planned, plannedbase, base, baselimit, limit ,                                                                     ");
			 sb.append("              actual, grade, score, grade_score, comments , mcscore, calcscore                                                   ");
			 sb.append("   from                                                                                                                          ");
			 sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel,t.rank srank,t.weight sweight,c.name sname          ");
			 sb.append("        from tblhierarchy t,tblsbu c where t.contentid=c.id and t.treelevel=1 and t.year=? and t.contentid = ?) sbu,      ");
			 sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel,t.rank brank,t.weight bweight,c.name bname          ");
			 sb.append("        from tblhierarchy t,tblbsc c where t.contentid=c.id and t.treelevel=2 and t.year=? ) bsc,                           ");
			 sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel,t.rank prank,t.weight pweight,c.name pname          ");
			 sb.append("        from tbltreescore t,tblpst c where t.contentid=c.id and t.treelevel=3 and t.year=? ) pst  ,                         ");
			 sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel,t.rank orank,t.weight oweight,c.name oname          ");
			 sb.append("        from tbltreescore t,tblobjective c where t.contentid=c.id and t.treelevel=4 and t.year=? ) obj ,                    ");
			 sb.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel,t.rank mrank,t.weight mweight,c.name mname,         ");
			 sb.append("                d.measurement, d.frequency, d.trend, d.etlkey,d.unit,                                                            ");
			 sb.append("                d.planned,d.plannedbase, d.base, d.baselimit, d.limit ,                                                          ");
			 sb.append("                round(s.actual,2) actual, s.grade, s.score  score, s.grade_score, dt.comments,                                   ");
			 sb.append("                s.score   mcscore, s.score * d.weight calcscore                                                                  ");
			 sb.append("        from    tbltreescore t,tblmeasuredefine d, tblmeasure c,                                                                 ");
			 sb.append("                tblmeasurescore s, tblmeasuredetail dt                                                                           ");
			 sb.append("        where t.contentid=d.id                                                                                                   ");
			 sb.append("        and   d.measureid=c.id                                                                                                   ");
			 sb.append("        and   t.treelevel=5                                                                                                      ");
			 sb.append("        and   d.id       =s.measureid  (+)                                                                                       ");
			 sb.append("        and   s.measureid=dt.measureid (+)                                                                                       ");
			 sb.append("        and   s.strdate  =dt.strdate   (+)                                                                                       ");
			 sb.append("        and   s.strdate(+) like ?||'%'                                                                                    ");
			 sb.append("        and   t.year=?          ) mea                                                                                       ");
			 sb.append("    where sbu.sid=bsc.bpid                                                                                                       ");
			 sb.append("    and   bsc.bid=pst.ppid                                                                                                       ");
			 sb.append("    and   pst.pid=obj.opid                                                                                                       ");
			 sb.append("    and   obj.oid=mea.mpid                                                                                                       ");
			 sb.append("    order by brank,bid,prank,pid,orank,oid,mrank                                                                                 ");
			 sb.append(" )                                                                                                                               ");
			 sb.append(" GROUP BY sid, spid, scid, srank, sname,                                                                                         ");
			 sb.append("          bid, bpid, bcid, brank, bname                                                                                          ");
			 sb.append(" ) S ORDER BY deptrank, srank, sid, brank, bid                                                                                        ");


			// ��ȸ Arg
			Object[] params = {ym, year,scid,year,year,year,ym,year};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

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
	}	// getOrgScore...



	/*
	 *  Method     : getOrgPstStatus
	 *  Desc.      : ������ ������ȸ - ������ ������Ȳ
	 *  Created by : PHG, 2008.03.15
	 *
	 */
	public void getOrgPstStatus(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year  = request.getParameter("year" );
			String ym    = request.getParameter("ym"   );
			String bscid = request.getParameter("bscid");

//			year = "2008";
//			ym = "200812";
//			bscid = "81";

			System.out.println("getOrgScore : ym-" +ym + ", bscid-" + bscid);


			StringBuffer sb = new StringBuffer();

            sb.append(" select pid, pcid, pname, max(brank) brank,                             ");
            sb.append("        count(*)                                    total,              ");
            sb.append("        sum(case when grade ='S' then 1 else 0 end) grade_s,            ");
            sb.append("        sum(case when grade ='A' then 1 else 0 end) grade_a,            ");
            sb.append("        sum(case when grade ='B' then 1 else 0 end) grade_b,            ");
            sb.append("        sum(case when grade ='C' then 1 else 0 end) grade_c,            ");
            sb.append("        sum(case when grade ='D' then 1 else 0 end) grade_d,            ");
            sb.append("        sum(case when grade is null then 1 else 0 end) notinput         ");
            sb.append(" from  (                                                                ");
			sb.append("   select * from                                                                                                          ");
			sb.append("       (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel,t.rank brank,t.weight bweight,c.name bname    ");
			sb.append("       from tblhierarchy t,tblbsc c where t.contentid=c.id and t.treelevel=2 and t.year=? and t.id=to_number(?) ) bsc,    ");
			sb.append("       (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel,t.rank prank,t.weight pweight,c.name pname    ");
			sb.append("       from tbltreescore t,tblpst c where t.contentid=c.id and t.treelevel=3 and t.year=? ) pst  ,                        ");
			sb.append("       (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel,t.rank orank,t.weight oweight,c.name oname    ");
			sb.append("       from tbltreescore t,tblobjective c where t.contentid=c.id and t.treelevel=4 and t.year=? ) obj ,                   ");
			sb.append("       (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel,t.rank mrank,t.weight mweight,c.name mname,   ");
			sb.append("               d.measurement, d.frequency, d.trend, d.etlkey,d.unit,                                                      ");
			sb.append("               d.planned,d.plannedbase, d.base, d.baselimit, d.limit ,                                                    ");
			sb.append("               round(s.actual,2) actual, s.grade, s.score  score, s.grade_score, dt.comments                              ");
			sb.append("       from    tbltreescore t,tblmeasuredefine d, tblmeasure c,                                                           ");
			sb.append("               tblmeasurescore s, tblmeasuredetail dt                                                                     ");
			sb.append("       where t.contentid=d.id                                                                                             ");
			sb.append("       and   d.measureid=c.id                                                                                             ");
			sb.append("       and   t.treelevel=5                                                                                                ");
			sb.append("       and   d.id       =s.measureid  (+)                                                                                 ");
			sb.append("       and   s.measureid=dt.measureid (+)                                                                                 ");
			sb.append("       and   s.strdate  =dt.strdate   (+)                                                                                 ");
			sb.append("       and   s.strdate(+) like ?||'%'                                                                                     ");
			sb.append("       and   t.year=?   ) mea                                                                                             ");
			sb.append("   where bsc.bid=pst.ppid                                                                                                 ");
			sb.append("   and   pst.pid=obj.opid                                                                                                 ");
			sb.append("   and   obj.oid=mea.mpid                                                                                                 ");
			sb.append("   order by brank,bid,prank,pid,orank,oid,mrank																			 ");
            sb.append(" )                                                                      ");
			sb.append(" group by pid, pcid, pname                                              ");
			sb.append(" order by 4,pid, pcid                                                   ");

			// ��ȸ Arg
			Object[] params = {year,bscid,year,year,ym,year};

			//System.out.println(sb.toString());

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

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
	}	// getOrgPstStatus


	/*
	 *  Method     : getCeoOrgBscStatus
	 *  Desc.      : ������ ������Ȳ - �׷� �μ��� ���� �� ��޺� ��ǥ��Ȳ
	 *  Created by : PHG, 2008.03.15
	 *
	 */
	public void getCeoOrgBscStatus(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year  = request.getParameter("year" );
			String ym    = request.getParameter("ym"   );
			String sbuid = request.getParameter("sbuid");
			String month = ym.substring(4,6).trim();
			String freq  = "��";

//			 = "2008";
//			ym = "200812";
//			bscid = "81";
			if ((new Integer(month).intValue() == 3)||(new Integer(month).intValue() == 9)){
				freq = "'월','분기'";
			} else if (new Integer(month).intValue() == 6){
				freq = "'월','분기','반기'";
			} else if (new Integer(month).intValue() == 12){
				freq = "'월','분기','반기','년'";
			} else {
				freq = "'월'";
			}

//			if ("03".equals("month")||"09".equals("month")){
//				freq = "'��','�б�'";
//			}else if ("06".equals("month")){
//					freq = "'��','�б�','�ݱ�'";
//			}else if ("12".equals("month")){
//				freq = "'��','�б�','�ݱ�','��'";
//			} else {
//				freq = "'��'";
//			}
			System.out.println("getCeoOrgBscStatus : year-"+ year + ", month-" +month + ", bscid-" + sbuid + ",freq=" + freq);

			StringBuffer sb = new StringBuffer();


			if(!year.equals("")){
				String str = "";
				if(!sbuid.equals("%"))
					str = " and t.id="+sbuid;

				sb.append(" SELECT sid, spid, scid, srank, sname,                                                                                        ");
				sb.append("        bid, bpid, bcid, brank, bname,                                                                                        ");
				sb.append("        max(bcscore) bscore,                                                                                                  ");
				sb.append("        sum(case when grade ='S' then 1 else 0 end) grade_s,                                                                  ");
				sb.append("        sum(case when grade ='A' then 1 else 0 end) grade_a,                                                                  ");
				sb.append("        sum(case when grade ='B' then 1 else 0 end) grade_b,                                                                  ");
				sb.append("        sum(case when grade ='C' then 1 else 0 end) grade_c,                                                                  ");
				sb.append("        sum(case when grade ='D' then 1 else 0 end) grade_d,                                                                  ");
				sb.append("        sum(case when grade is null then 1 else 0 end) notinput,                                                              ");
				sb.append("        count(*)                                       total                                                                  ");
				sb.append(" FROM   (                                                                                                                     ");
				sb.append("   select                                                                                                                     ");
				sb.append("         sid, spid, scid, slevel, srank, sweight, sname,                                                                      ");
				sb.append("         bid, bpid, bcid, blevel, brank, bweight, bname,                                                                      ");
				sb.append("              round(sum(calcscore) over(partition by bid) /                                                                   ");
				sb.append("                   sum(case when mcscore is not null then mweight end) over(partition by bid),2)  bcscore,                    ");
				sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid)  bcweight,                           ");
				sb.append("          pid, ppid, pcid, plevel, prank, pweight, pname,                                                                     ");
				sb.append("              round(sum(calcscore) over(partition by bid,pid) /                                                               ");
				sb.append("                    sum(case when mcscore is not null then mweight end) over(partition by bid,pid),2)  pcscore,               ");
				sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid,pid)  pcweight,                       ");
				sb.append("          oid, opid, ocid, olevel, orank, oweight, oname,                                                                     ");
				sb.append("              round(sum(calcscore) over(partition by bid,pid,oid) /                                                           ");
				sb.append("                    sum(case when mcscore is not null then mweight end) over(partition by bid,pid,oid),2)  ocscore,           ");
				sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid,pid,oid)  ocweight,                   ");
				sb.append("          mid, mpid, mcid, mlevel, mrank, mweight, mname,                                                                     ");
				sb.append("              measurement, frequency, trend, etlkey, unit,                                                                    ");
				sb.append("              planned, plannedbase, base, baselimit, limit ,                                                                  ");
				sb.append("              actual, grade, score, grade_score, comments , mcscore, calcscore                                                ");
				sb.append("   from                                                                                                                       ");
				sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel,t.rank srank,t.weight sweight,c.name sname       ");
				sb.append("        from tblhierarchy t,tblsbu c where t.contentid=c.id and t.treelevel=1 and t.year=? "+str+") sbu,                   	 ");
				sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel,t.rank brank,t.weight bweight,c.name bname       ");
				sb.append("        from tblhierarchy t,tblbsc c where t.contentid=c.id and t.treelevel=2 and t.year=? ) bsc,                             ");
				sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel,t.rank prank,t.weight pweight,c.name pname       ");
				sb.append("        from tbltreescore t,tblpst c where t.contentid=c.id and t.treelevel=3 and t.year=? ) pst  ,                           ");
				sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel,t.rank orank,t.weight oweight,c.name oname       ");
				sb.append("        from tbltreescore t,tblobjective c where t.contentid=c.id and t.treelevel=4 and t.year=? ) obj ,                      ");
				sb.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel,t.rank mrank,t.weight mweight,c.name mname,      ");
				sb.append("                d.measurement, d.frequency, d.trend, d.etlkey,d.unit,                                                         ");
				sb.append("                d.planned,d.plannedbase, d.base, d.baselimit, d.limit ,                                                       ");
				sb.append("                round(s.actual,2) actual, s.grade, s.score  score, s.grade_score, dt.comments,                                ");
				sb.append("                s.score   mcscore, s.score * d.weight calcscore                                                               ");
				sb.append("        from    tbltreescore t,tblmeasuredefine d, tblmeasure c,                                                              ");
				sb.append("                tblmeasurescore s, tblmeasuredetail dt                                                                        ");
				sb.append("        where t.contentid=d.id                                                                                                ");
				sb.append("        and   d.measureid=c.id                                                                                                ");
				sb.append("        and   t.treelevel=5                                                                                                   ");
				sb.append("        and   d.id       =s.measureid  (+)                                                                                    ");
				sb.append("        and   s.measureid=dt.measureid (+)                                                                                    ");
				sb.append("        and   s.strdate  =dt.strdate   (+)                                                                                    ");
				sb.append("        and   s.strdate(+) like ?||'%'                                                                                        ");
				sb.append("        and   t.year=?                                                                                                        ");
				sb.append("        and   d.frequency in ("+freq+")  ) mea                                                                                ");
				sb.append("    where sbu.sid=bsc.bpid                                                                                                    ");
				sb.append("    and   bsc.bid=pst.ppid                                                                                                    ");
				sb.append("    and   pst.pid=obj.opid                                                                                                    ");
				sb.append("    and   obj.oid=mea.mpid                                                                                                    ");
				sb.append("    order by brank,bid,prank,pid,orank,oid,mrank																			     ");
				sb.append(" )                                                                                                                            ");
				sb.append(" GROUP BY sid, spid, scid, srank, sname,                                                                                      ");
				sb.append("          bid, bpid, bcid, brank, bname                                                                                       ");
				sb.append(" ORDER BY srank, sid, brank, bid                                                                                              ");


				// ��ȸ Arg
				Object[] params = {year,year,year,year,ym,year};

				//System.out.println(sb.toString());

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());
				rs = dbobject.executePreparedQuery(sb.toString(),params);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds", ds);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	// getOrgPstStatus




	/*
	 *  Method     : getCeoOrgPstStatus
	 *  Desc.      : ������ ������Ȳ - �ܺ��� ������ ����
	 *  Created by : PHG, 2008.03.15
	 *
	 */
	public void getCeoOrgPstStatus(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year  = request.getParameter("year" );
			String ym    = request.getParameter("ym"   );
			String bscid = request.getParameter("bscid");

//			year = "2008";
//			ym = "200812";
//			bscid = "81";

			//System.out.println("getCeoOrgPstStatus : ym-" +ym + ", bscid-" + bscid);

			StringBuffer sb = new StringBuffer();

			//sb.append(" SELECT sid, spid, scid, srank, sname,                                                                                        ");
			//sb.append("        bid, bpid, bcid, brank, bname,                                                                                        ");
			//sb.append("        max(bcscore) bscore,                                                                                                  ");
			//sb.append("        sum(case when grade ='S' then 1 else 0 end) grade_s,                                                                  ");
			//sb.append("        sum(case when grade ='A' then 1 else 0 end) grade_a,                                                                  ");
			//sb.append("        sum(case when grade ='B' then 1 else 0 end) grade_b,                                                                  ");
			//sb.append("        sum(case when grade ='C' then 1 else 0 end) grade_c,                                                                  ");
			//sb.append("        sum(case when grade ='D' then 1 else 0 end) grade_d,                                                                  ");
			//sb.append("        sum(case when grade is null then 1 else 0 end) notinput                                                               ");
			//sb.append(" FROM   (                                                                                                                     ");
			//sb.append("   select                                                                                                                     ");
			//sb.append("         sid, spid, scid, slevel, srank, sweight, sname,                                                                      ");
			//sb.append("         bid, bpid, bcid, blevel, brank, bweight, bname,                                                                      ");
			//sb.append("              round(sum(calcscore) over(partition by bid) /                                                                   ");
			//sb.append("                   sum(case when mcscore is not null then mweight end) over(partition by bid),2)  bcscore,                    ");
			//sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid)  bcweight,                           ");
			//sb.append("          pid, ppid, pcid, plevel, prank, pweight, pname,                                                                     ");
			//sb.append("              round(sum(calcscore) over(partition by bid,pid) /                                                               ");
			//sb.append("                    sum(case when mcscore is not null then mweight end) over(partition by bid,pid),2)  pcscore,               ");
			//sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid,pid)  pcweight,                       ");
			//sb.append("          oid, opid, ocid, olevel, orank, oweight, oname,                                                                     ");
			//sb.append("              round(sum(calcscore) over(partition by bid,pid,oid) /                                                           ");
			//sb.append("                    sum(case when mcscore is not null then mweight end) over(partition by bid,pid,oid),2)  ocscore,           ");
			//sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid,pid,oid)  ocweight,                   ");
			//sb.append("          mid, mpid, mcid, mlevel, mrank, mweight, mname,                                                                     ");
			//sb.append("              measurement, frequency, trend, etlkey, unit,                                                                    ");
			//sb.append("              planned, plannedbase, base, baselimit, limit ,                                                                  ");
			//sb.append("              actual, grade, score, grade_score, comments , mcscore, calcscore                                                ");
			//sb.append("   from                                                                                                                       ");
			//sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel,t.rank srank,t.weight sweight,c.name sname       ");
			//sb.append("        from tblhierarchy t,tblsbu c where t.contentid=c.id and t.treelevel=1 and t.year=? and t.id=?) sbu,                   ");
			//sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel,t.rank brank,t.weight bweight,c.name bname       ");
			//sb.append("        from tblhierarchy t,tblbsc c where t.contentid=c.id and t.treelevel=2 and t.year=? ) bsc,                             ");
			//sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel,t.rank prank,t.weight pweight,c.name pname       ");
			//sb.append("        from tbltreescore t,tblpst c where t.contentid=c.id and t.treelevel=3 and t.year=? ) pst  ,                           ");
			//sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel,t.rank orank,t.weight oweight,c.name oname       ");
			//sb.append("        from tbltreescore t,tblobjective c where t.contentid=c.id and t.treelevel=4 and t.year=? ) obj ,                      ");
			//sb.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel,t.rank mrank,t.weight mweight,c.name mname,      ");
			//sb.append("                d.measurement, d.frequency, d.trend, d.etlkey,d.unit,                                                         ");
			//sb.append("                d.planned,d.plannedbase, d.base, d.baselimit, d.limit ,                                                       ");
			//sb.append("                round(s.actual,2) actual, s.grade, s.score  score, s.grade_score, dt.comments,                                ");
			//sb.append("                s.score   mcscore, s.score * d.weight calcscore                                                               ");
			//sb.append("        from    tbltreescore t,tblmeasuredefine d, tblmeasure c,                                                              ");
			//sb.append("                tblmeasurescore s, tblmeasuredetail dt                                                                        ");
			//sb.append("        where t.contentid=d.id                                                                                                ");
			//sb.append("        and   d.measureid=c.id                                                                                                ");
			//sb.append("        and   t.treelevel=5                                                                                                   ");
			//sb.append("        and   d.id       =s.measureid  (+)                                                                                    ");
			//sb.append("        and   s.measureid=dt.measureid (+)                                                                                    ");
			//sb.append("        and   s.strdate  =dt.strdate   (+)                                                                                    ");
			//sb.append("        and   s.strdate(+) like ?||'%'                                                                                        ");
			//sb.append("        and   t.year=?   ) mea                                                                                                ");
			//sb.append("    where sbu.sid=bsc.bpid                                                                                                    ");
			//sb.append("    and   bsc.bid=pst.ppid                                                                                                    ");
			//sb.append("    and   pst.pid=obj.opid                                                                                                    ");
			//sb.append("    and   obj.oid=mea.mpid                                                                                                    ");
			//sb.append("    order by brank,bid,prank,pid,orank,oid,mrank																			     ");
			//sb.append(" )                                                                                                                            ");
			//sb.append(" GROUP BY sid, spid, scid, srank, sname,                                                                                      ");
			//sb.append("          bid, bpid, bcid, brank, bname                                                                                       ");
			//sb.append(" ORDER BY srank, sid, brank, bid                                                                                              ");

			sb.append("   select *                                                                     					");
			sb.append("   from tblpst a,                                                                     			");
			sb.append("   (select  distinct                                                                         	");
			sb.append("         pcid, prank, pname,                                                                      ");
			sb.append("         round(sum(calcscore) over(partition by bid,pid) /                                                                    ");
			sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid,pid),2)  pcscore                      ");
			sb.append("   from                                                                                                                       ");
			sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel,t.rank srank,t.weight sweight,c.name sname       ");
			sb.append("        from tblhierarchy t,tblsbu c where t.contentid=c.id and t.treelevel=1 and t.year=? ) sbu,                   			 ");
			sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel,t.rank brank,t.weight bweight,c.name bname       ");
			sb.append("        from tblhierarchy t,tblbsc c where t.contentid=c.id and t.treelevel=2 and t.year=? and c.id=? ) bsc,                  ");
			sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel,t.rank prank,t.weight pweight,c.name pname       ");
			sb.append("        from tbltreescore t,tblpst c where t.contentid=c.id and t.treelevel=3 and t.year=? ) pst  ,                           ");
			sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel,t.rank orank,t.weight oweight,c.name oname       ");
			sb.append("        from tbltreescore t,tblobjective c where t.contentid=c.id and t.treelevel=4 and t.year=? ) obj ,                      ");
			sb.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel,t.rank mrank,t.weight mweight,c.name mname,      ");
			sb.append("                d.measurement, d.frequency, d.trend, d.etlkey,d.unit,                                                         ");
			sb.append("                d.planned,d.plannedbase, d.base, d.baselimit, d.limit ,                                                       ");
			sb.append("                round(s.actual,2) actual, s.grade, s.score  score, s.grade_score, dt.comments,                                ");
			sb.append("                s.score   mcscore, s.score * d.weight calcscore                                                               ");
			sb.append("        from    tbltreescore t,tblmeasuredefine d, tblmeasure c,                                                              ");
			sb.append("                tblmeasurescore s, tblmeasuredetail dt                                                                        ");
			sb.append("        where t.contentid=d.id                                                                                                ");
			sb.append("        and   d.measureid=c.id                                                                                                ");
			sb.append("        and   t.treelevel=5                                                                                                   ");
			sb.append("        and   d.id       =s.measureid  (+)                                                                                    ");
			sb.append("        and   s.measureid=dt.measureid (+)                                                                                    ");
			sb.append("        and   s.strdate  =dt.strdate   (+)                                                                                    ");
			sb.append("        and   s.strdate(+) like ?||'%'                                                                                        ");
			sb.append("        and   t.year=?   ) mea                                                                                                ");
			sb.append("    where sbu.sid=bsc.bpid                                                                                                    ");
			sb.append("    and   bsc.bid=pst.ppid                                                                                                    ");
			sb.append("    and   pst.pid=obj.opid                                                                                                    ");
			sb.append("    and   obj.oid=mea.mpid                                                                                                    ");
			sb.append("   ) b  where a.id = b.pcid(+)															     ");
			sb.append("    order by CODE DESC																		     ");

			// ��ȸ Arg
			Object[] params = {year,year,bscid,year,year,ym,year};

			//System.out.println(sb.toString());

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

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
	}	// getOrgPstStatus




	/*
	 *  Method     : getCeoOrgMeasStatus
	 *  Desc.      : ������ ������Ȳ - �ܺ��� ��ǥ���� �� ��å(�跮,��跮)
	 *  Created by : PHG, 2008.03.15
	 *
	 */

	public void getCeoOrgMeasStatus(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year  = request.getParameter("year" );
			String ym    = request.getParameter("ym"   );
			String bscid = request.getParameter("bscid");

			//year = "2008";
			//ym = "200812";
			//bscid = "64";

			//System.out.println("getCeoOrgMeasStatus : ym-" +ym + ", bscid-" + bscid);

			StringBuffer sb = new StringBuffer();

			sb.append("   select                                                                                                                     ");
			sb.append("         sid, spid, scid, slevel, srank, sweight, sname,                                                                      ");
			sb.append("         bid, bpid, bcid, blevel, brank, bweight, bname,                                                                      ");
			sb.append("              round(sum(calcscore) over(partition by bid) /                                                                   ");
			sb.append("                   sum(case when mcscore is not null then mweight end) over(partition by bid),2)  bcscore,                    ");
			sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid)  bcweight,                           ");
			sb.append("          pid, ppid, pcid, plevel, prank, pweight, pname,                                                                     ");
			sb.append("              round(sum(calcscore) over(partition by bid,pid) /                                                               ");
			sb.append("                    sum(case when mcscore is not null then mweight end) over(partition by bid,pid),2)  pcscore,               ");
			sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid,pid)  pcweight,                       ");
			sb.append("          oid, opid, ocid, olevel, orank, oweight, oname,                                                                     ");
			sb.append("              round(sum(calcscore) over(partition by bid,pid,oid) /                                                           ");
			sb.append("                    sum(case when mcscore is not null then mweight end) over(partition by bid,pid,oid),2)  ocscore,           ");
			sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid,pid,oid)  ocweight,                   ");
			sb.append("          mid, mpid, mcid, mlevel, mrank, mweight, mname,                                                                     ");
			sb.append("              measurement, frequency, trend, etlkey, unit,                                                                    ");
			sb.append("              planned, plannedbase, base, baselimit, limit ,                                                                  ");
			sb.append("              actual, grade, score, grade_score, ' ' comments , mcscore, calcscore                                            ");
			sb.append("   from                                                                                                                       ");
			sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel,t.rank srank,t.weight sweight,c.name sname       ");
			sb.append("        from tblhierarchy t,tblsbu c where t.contentid=c.id and t.treelevel=1 and t.year=? ) sbu,                   			 ");
			sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel,t.rank brank,t.weight bweight,c.name bname       ");
			sb.append("        from tblhierarchy t,tblbsc c where t.contentid=c.id and t.treelevel=2 and t.year=? and c.id=? ) bsc,                  ");
			sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel,t.rank prank,t.weight pweight,c.name pname       ");
			sb.append("        from tbltreescore t,tblpst c where t.contentid=c.id and t.treelevel=3 and t.year=? ) pst  ,                           ");
			sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel,t.rank orank,t.weight oweight,c.name oname       ");
			sb.append("        from tbltreescore t,tblobjective c where t.contentid=c.id and t.treelevel=4 and t.year=? ) obj ,                      ");
			sb.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel,t.rank mrank,t.weight mweight,c.name mname,      ");
			sb.append("                d.measurement, d.frequency, d.trend, d.etlkey,d.unit,                                                         ");
			sb.append("                d.planned,d.plannedbase, d.base, d.baselimit, d.limit ,                                                       ");
			sb.append("                round(s.actual,2) actual, s.grade, s.score  score, s.grade_score, dt.comments,                                ");
			sb.append("                s.score   mcscore, s.score * d.weight calcscore                                                               ");
			sb.append("        from    tbltreescore t,tblmeasuredefine d, tblmeasure c,                                                              ");
			sb.append("                tblmeasurescore s, tblmeasuredetail dt                                                                        ");
			sb.append("        where t.contentid=d.id                                                                                                ");
			sb.append("        and   d.measureid=c.id                                                                                                ");
			sb.append("        and   t.treelevel=5                                                                                                   ");
			sb.append("        and   d.id       =s.measureid  (+)                                                                                    ");
			sb.append("        and   s.measureid=dt.measureid (+)                                                                                    ");
			sb.append("        and   s.strdate  =dt.strdate   (+)                                                                                    ");
			sb.append("        and   s.strdate(+) like ?||'%'                                                                                        ");
			sb.append("        and   t.year=?   ) mea                                                                                                ");
			sb.append("    where sbu.sid=bsc.bpid                                                                                                    ");
			sb.append("    and   bsc.bid=pst.ppid                                                                                                    ");
			sb.append("    and   pst.pid=obj.opid                                                                                                    ");
			sb.append("    and   obj.oid=mea.mpid                                                                                                    ");
			sb.append("    order by brank,bid,prank,pid,orank,oid,mrank																			     ");


			// ��ȸ Arg
			Object[] params = {year,year,bscid,year,year,ym,year};

			//System.out.println(sb.toString());

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

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
	}	// getOrgMeasStatus

	/*
	 *  Method     : getCeoOrgMeasList
	 *  Desc.      : ������ Ź��,����,�������� ���� ����Ʈ
	 *  Created by : PHG, 2008.03.26
	 *
	 */

	public void getCeoOrgMeasList(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year  = request.getParameter("year" );
			String ym    = request.getParameter("ym"   );
			String month = ym.substring(4,6);
			String sbuid = request.getParameter("sbuid");
			String state = request.getParameter("state");
			String freq  = "월";


			if ((new Integer(month).intValue() == 3)||(new Integer(month).intValue() == 9)){
				freq = "'월','분기'";
			} else if (new Integer(month).intValue() == 6){
				freq = "'월','분기','반기'";
			} else if (new Integer(month).intValue() == 12){
				freq = "'월','분기','반기','년'";
			} else {
				freq = "'월'";
			}

			String str = "";
			if(!state.equals("")){
				str = " where grade in (";
				String[] tmp = state.split("\\|");
				for(int i=0;i<tmp.length;i++){
					if(i==tmp.length-1)
						str = str + "'" + tmp[i] + "') ";
					else
						str = str + "'" + tmp[i] + "',";
				}
			}

			StringBuffer sb = new StringBuffer();

			sb.append(" select * from (                                                                                                             \n");
			sb.append("   select                                                                                                                    \n");
			sb.append("         sid, spid, scid, slevel, srank, sweight, sname,                                                                     \n");
			sb.append("         bid, bpid, bcid, blevel, brank, bweight, bname,                                                                     \n");
			sb.append("              round(sum(calcscore) over(partition by bid) /                                                                  \n");
			sb.append("                   sum(case when mcscore is not null then mweight end) over(partition by bid),2)  bcscore,                   \n");
			sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid)  bcweight,                          \n");
			sb.append("          pid, ppid, pcid, plevel, prank, pweight, pname,                                                                    \n");
			sb.append("              round(sum(calcscore) over(partition by bid,pid) /                                                              \n");
			sb.append("                    sum(case when mcscore is not null then mweight end) over(partition by bid,pid),2)  pcscore,              \n");
			sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid,pid)  pcweight,                      \n");
			sb.append("          oid, opid, ocid, olevel, orank, oweight, oname,                                                                    \n");
			sb.append("              round(sum(calcscore) over(partition by bid,pid,oid) /                                                          \n");
			sb.append("                    sum(case when mcscore is not null then mweight end) over(partition by bid,pid,oid),2)  ocscore,          \n");
			sb.append("              sum(case when mcscore is not null then mweight end) over(partition by bid,pid,oid)  ocweight,                  \n");
			sb.append("          mid, mpid, mcid, mlevel, mrank, mweight, mname,                                                                    \n");
			sb.append("              measurement, frequency, trend, etlkey, unit,                                                                   \n");
			sb.append("              planned, plannedbase, base, baselimit, limit ,                                                                 \n");
			//sb.append("              actual, grade, score, grade_score,  comments , mcscore, calcscore                                           \n");

			sb.append("              actual, grade, score, grade_score,  mcscore, calcscore,                                           \n");
			sb.append("               case when measurement='��跮'  then \n"  );
			sb.append("                 estimate \n"  );
			sb.append("               else comments end comments \n"  );



			sb.append("   from                                                                                                                      \n");
			sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel,t.rank srank,t.weight sweight,c.name sname      \n");
			sb.append("        from tblhierarchy t,tblsbu c where t.contentid=c.id and t.treelevel=1 and t.year=? and t.id=? ) sbu,                 \n");
			sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel,t.rank brank,t.weight bweight,c.name bname      \n");
			sb.append("        from tblhierarchy t,tblbsc c where t.contentid=c.id and t.treelevel=2 and t.year=?) bsc,                  			      \n");
			sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel,t.rank prank,t.weight pweight,c.name pname      \n");
			sb.append("        from tbltreescore t,tblpst c where t.contentid=c.id and t.treelevel=3 and t.year=? ) pst  ,                          \n");
			sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel,t.rank orank,t.weight oweight,c.name oname      \n");
			sb.append("        from tbltreescore t,tblobjective c where t.contentid=c.id and t.treelevel=4 and t.year=? ) obj ,                     \n");
			sb.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel,t.rank mrank,t.weight mweight,c.name mname,     \n");
			sb.append("                d.measurement, d.frequency, d.trend, d.etlkey,d.unit,                                                        \n");
			sb.append("                d.planned,d.plannedbase, d.base, d.baselimit, d.limit ,                                                      \n");
			sb.append("                round(s.actual,2) actual, s.grade, s.score  score, s.grade_score, dt.comments,                               \n");
			//sb.append("                s.score   mcscore, s.score * d.weight calcscore                                                              \n");

			sb.append("                s.score   mcscore, s.score * d.weight calcscore, estimate                                                              \n");


			sb.append("        from    tbltreescore t,tblmeasuredefine d, tblmeasure c,                                                             \n");
			//sb.append("                tblmeasurescore s, tblmeasuredetail dt                                                                       \n");

			sb.append("                tblmeasurescore s, tblmeasuredetail dt, TBLEVALMEASUREDETAIL edt                                                                       \n");


			sb.append("        where t.contentid=d.id                                                                                               \n");
			sb.append("        and   d.measureid=c.id                                                                                               \n");
			sb.append("        and   t.treelevel=5                                                                                                  \n");
			sb.append("        and   d.id       =s.measureid  (+)                                                                                   \n");
			sb.append("        and   s.measureid=dt.measureid (+)                                                                                   \n");
			sb.append("        and   substr(s.strdate,1,6)  = substr(dt.strdate(+),1,6)                                                                                  \n");

			/// add
			sb.append("         and   s.measureid=edt.measureid (+)     \n"  );
			sb.append(" 	and   substr(s.strdate,1,6)  = substr(edt.effectivedate(+),1,6)    \n"  );

			sb.append("        and   s.strdate(+) like ?||'%'                                                                                       \n");
			sb.append("        and   t.year=?                                                                                                       \n");
			sb.append("        and   d.frequency in ("+freq+")   ) mea                                                                              \n");
			sb.append("    where sbu.sid=bsc.bpid                                                                                                   \n");
			sb.append("    and   bsc.bid=pst.ppid                                                                                                   \n");
			sb.append("    and   pst.pid=obj.opid                                                                                                   \n");
			sb.append("    and   obj.oid=mea.mpid                                                                                                  	\n");
			sb.append("	) B "+str+"																							 					                                                        	\n");
			sb.append(" order by brank,bid,prank,pid,orank,oid,mrank																			                                          \n");


			// ��ȸ Arg
			Object[] params = {year,sbuid,year,year,year,ym,year};

			System.out.println(sb.toString());

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

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
	}	// getCeoOrgMeasList

	/*
	 *  Method     : getOrgMeasItemActual
	 *  Desc.      : ������ ��ǥ�� ������ǥ ��ǥ�׸� ����Ÿ
	 *  Created by : PHG, 2008.05.16
	 *
	 */

	public void getOrgMeasItemActual(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year  = request.getParameter("year" );
			String sbuid = request.getParameter("sbuid");
			String bscid = request.getParameter("bscid");
			String freq  = Util.getUTF(request.getParameter("freq" ));

			//year = "2008";
			//ym = "200812";
			//bscid = "64";

			System.out.println("getOrgMeasItemActual : year=" +year+ ", sbuid-" +sbuid + ", bscid-" + bscid + "freq :" + freq);

			StringBuffer sb = new StringBuffer();

			sb.append(" SELECT  cid, ccid, clevel, crank, cname,  cweight,                                                                         ");
			sb.append("         sid, scid, slevel, srank, sname,  sweight,                                                                         ");
			sb.append("         bid, bcid, blevel, brank, bname,  sum(mweight) over (partition by cid, sid, bid          ) bweight,                ");
			sb.append("         pid, pcid, plevel, prank, pname,  sum(mweight) over (partition by cid, sid, bid, pid     ) pweight,                ");
			sb.append("         oid, ocid, olevel, orank, oname,  sum(mweight) over (partition by cid, sid, bid, pid, oid) oweight,                ");
			sb.append("         mid, mcid, mlevel, mrank, mname,  mweight, measureid, frequency, f_getempnm(updateid) empnm,                       ");
			sb.append("         itemcode, itemname,itemfixed, mm03, mm06, mm09, mm12                                                               ");
			sb.append(" FROM                                                                                                                       ");
			sb.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname    ");
			sb.append("         from   tblhierarchy t,tblcompany c                                                                                 ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year = ?                                                          ");
			sb.append("        ) com,                                                                                                              ");
			sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname    ");
			sb.append("         from   tblhierarchy t,tblsbu c                                                                                     ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year = ? and t.id like ?                                          ");
			sb.append("        ) sbu,                                                                                                              ");
			sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname    ");
			sb.append("         from   tblhierarchy t,tblbsc c                                                                                     ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=2 and t.year = ? and t.id like ?                                          ");
			sb.append("        ) bsc,                                                                                                              ");
			sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname    ");
			sb.append("         from   tbltreescore t,tblpst c                                                                                     ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=3 and t.year = ?                                                          ");
			sb.append("        ) pst  ,                                                                                                            ");
			sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname    ");
			sb.append("         from   tbltreescore t,tblobjective c                                                                               ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year = ?                                                          ");
			sb.append("        ) obj ,                                                                                                             ");
			sb.append("        (                                                                                                                   ");
			sb.append("         select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname, ");
			sb.append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey,                                      ");
			sb.append("                d.unit       , max(d.updateid) updateid ,                                                                                             ");
			sb.append("                d.planned,d.plannedbase, d.base, d.baselimit, d.limit,                                                      ");
			sb.append("                mi.code itemcode, mi.itemname, mi.itemfixed,                                                                ");
			sb.append("                max(case when substr(mia.strdate,5,2) = '03' then actual end)   mm03,                                       ");
			sb.append("                max(case when substr(mia.strdate,5,2) = '06' then actual end)   mm06,                                       ");
			sb.append("                max(case when substr(mia.strdate,5,2) = '09' then actual end)   mm09,                                       ");
			sb.append("                max(case when substr(mia.strdate,5,2) = '12' then actual end)   mm12                                        ");
			sb.append("         from   tbltreescore    t, tblmeasure c,  tblmeasuredefine d, tblitem mi, tblitemactual mia                         ");
			sb.append("         where  t.contentid  = d.id  and t.treelevel=5 and t.year =?  and d.measureid=c.id                                  ");
			sb.append("         and    t.contentid  = mi.measureid  (+)                                                                            ");
			sb.append("         and    mi.measureid = mia.measureid (+)                                                                            ");
			sb.append("         and    mi.code      = mia.code      (+)                                                                            ");
			sb.append("         and    d.measurement = '계량'                                                                                      ");
			sb.append("         and    d.frequency   like ? ||'%'                                                                                       ");
			sb.append("         group by   t.id ,t.parentid ,t.contentid ,t.treelevel , t.rank , t.weight , c.name ,                               ");
			sb.append("                    c.id ,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey,                                     ");
			sb.append("                    d.unit       ,                                                                                          ");
			sb.append("	                   d.planned,d.plannedbase, d.base, d.baselimit, d.limit,                                                  ");
			sb.append("                    mi.code, mi.itemname, mi.itemfixed                                                                      ");
			sb.append("        ) mea                                                                                                               ");
			sb.append(" where  cid = spid (+)                                                                                                      ");
			sb.append(" and    sid = bpid (+)                                                                                                      ");
			sb.append(" and    bid = ppid (+)                                                                                                      ");
			sb.append(" and    pid = opid (+)                                                                                                      ");
			sb.append(" and    oid = mpid                                                                                                          ");
			sb.append(" order by crank, srank, brank, prank, orank, mrank, itemcode                                                                ");

			// ��ȸ Arg
			Object[] params = {year,year,sbuid,year,bscid,year,year,year,freq};

			//System.out.println(sb.toString());

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds", ds);
		} catch (Exception e) {
			System.out.println("getOrgMeasItemActual Error :" + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	// getOrgMeasItemActual


	/*
	 *  Method     : getOrgMeasEvalActual
	 *  Desc.      : ������ ��ǥ�� ������ǥ ��跮 ����Ÿ
	 *  Created by : PHG, 2008.05.16
	 *
	 */

	public void getOrgMeasEvalActual(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year  = request.getParameter("year" );
			String sbuid = request.getParameter("sbuid");
			String bscid = request.getParameter("bscid");
			String freq  = Util.getUTF(request.getParameter("freq" )); //2008sus 11�� 3�� �ݱ�, �б�, �� �˻��ɼ� �ȵǴ°� ����

			System.out.println(freq);

			//year = "2008";
			//ym = "200812";
			//bscid = "64";

			System.out.println("getOrgMeasEvalActual BSCID: " + bscid);

			StringBuffer sb = new StringBuffer();

			sb.append(" SELECT  cid, ccid, clevel, crank, cname,  cweight,                                                                        ");
			sb.append("         sid, scid, slevel, srank, sname,  sweight,                                                                        ");
			sb.append("         bid, bcid, blevel, brank, bname,  sum(mweight) over (partition by cid, sid, bid          ) bweight,               ");
			sb.append("         pid, pcid, plevel, prank, pname,  sum(mweight) over (partition by cid, sid, bid, pid     ) pweight,               ");
			sb.append("         oid, ocid, olevel, orank, oname,  sum(mweight) over (partition by cid, sid, bid, pid, oid) oweight,               ");
			sb.append("         mid, mcid, mlevel, mrank, mname,  mweight, mea.measureid, frequency,  f_getempnm(updateid) empnm,                 ");
			sb.append("         substr(effectivedate,1,4)||'-'||substr(effectivedate,5,2) ym, substr(effectivedate,5,2) mm,                       ");
			sb.append("		    mia.planned  evalplan, mia.detail evalactual, mia.estimate evalself                                               ");
			sb.append(" FROM                                                                                                                      ");
			sb.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname   ");
			sb.append("         from   tblhierarchy t,tblcompany c                                                                                ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                                          ");
			sb.append("        ) com,                                                                                                             ");
			sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname   ");
			sb.append("         from   tblhierarchy t,tblsbu c                                                                                    ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =? and t.id like ?                                          ");
			sb.append("        ) sbu,                                                                                                             ");
			sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname   ");
			sb.append("         from   tblhierarchy t,tblbsc c                                                                                    ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =? and t.id like ?                                          ");
			sb.append("        ) bsc,                                                                                                             ");
			sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname   ");
			sb.append("         from   tbltreescore t,tblpst c                                                                                    ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                                          ");
			sb.append("        ) pst  ,                                                                                                           ");
			sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname   ");
			sb.append("         from   tbltreescore t,tblobjective c                                                                              ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year = ?                                                         ");
			sb.append("        ) obj ,                                                                                                            ");
			sb.append("         (                                                                                                                                  ");
			sb.append("          select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname,                ");
			sb.append("                 c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey,                                                     ");
			sb.append("                 d.unit       , d.updateid updateid,                                                                                        ");
			sb.append("                 d.planned,d.plannedbase, d.base, d.baselimit, d.limit, freq.fym                                                            ");
			sb.append("          from   tbltreescore    t, tblmeasure c,  tblmeasuredefine d,                                                                      ");
			sb.append("                  (                                                                                                                         ");
			sb.append("                  SELECT freq, year||mm fym                                                                                                 ");
			sb.append("                  FROM                                                                                                                      ");
			sb.append("                  (                                                                                                                         ");
			sb.append("                  SELECT year, '년'   freq, ltrim(to_char(rownum * 1 ,'00')) mm  FROM tbltreescore WHERE year = ? AND rownum <=12  UNION    ");
			sb.append("                  SELECT year, '반기' freq, ltrim(to_char(rownum * 3 ,'00')) mm  FROM tbltreescore WHERE year = ? AND rownum <=4   UNION    ");
			sb.append("                  SELECT year, '분기' freq, ltrim(to_char(rownum * 6 ,'00')) mm  FROM tbltreescore WHERE year = ? AND rownum <=2   UNION    ");
			sb.append("                  SELECT year, '월'   freq, ltrim(to_char(rownum * 12,'00')) mm  FROM tbltreescore WHERE year = ? AND rownum <=1            ");
			sb.append("                  )) freq                                                                                                                   ");
			sb.append("          where  t.contentid   = d.id  and t.treelevel=5 and t.year =? and d.measureid=c.id                                                 ");
			sb.append("          and    d.frequency   = freq.freq                                                                                                  ");
			sb.append("          and    d.measurement = '비계량'                                                                                                   ");
			sb.append("          and    d.frequency like ?||'%'                                                                                                         ");
			sb.append("         ) mea,                                                                                                                             ");
			sb.append("         TBLEVALMEASUREDETAIL mia                                                                                                           ");
			sb.append("  where  cid = spid (+)                                                                                                                     ");
			sb.append("  and    sid = bpid (+)                                                                                                                     ");
			sb.append("  and    bid = ppid (+)                                                                                                                     ");
			sb.append("  and    pid = opid (+)                                                                                                                     ");
			sb.append("  and    oid = mpid                                                                                                                         ");
			sb.append("  and    mcid = mia.measureid (+)                                                                                                           ");
			sb.append("  and    fym  = substr(mia.effectivedate(+),1,6)                                                                                            ");
			sb.append("  order by crank, srank, brank, prank, orank, mrank, fym                                                                                    ");

			// ��ȸ Arg
			Object[] params = {year,year,sbuid,year,bscid,year,year,   year,year,year,year, year, freq};

			//System.out.println(sb.toString());

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds", ds);

		} catch (Exception e) {
			System.out.println("getOrgMeasEvalComment Error :" + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}

	}

	/*
	 *  Method     : getOrgMeasEvalComment
	 *  Desc.      : ������ ��ǥ�� ������ǥ ��跮 ����Ÿ
	 *  Created by : PHG, 2008.05.16
	 *
	 */

	public void getOrgMeasEvalComment(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year  = request.getParameter("year" );
			String sbuid = request.getParameter("sbuid");
			String bscid = request.getParameter("bscid");

			//year = "2008";
			//ym = "200812";
			//bscid = "64";

			System.out.println("getOrgMeasEvalComment : year=" +year+ ", sbuid-" +sbuid + ", bscid-" + bscid);

			StringBuffer sb = new StringBuffer();

			sb.append(" SELECT  cid, ccid, clevel, crank, cname,  cweight,                                                                          ");
			sb.append("         sid, scid, slevel, srank, sname,  sweight,                                                                          ");
			sb.append("         bid, bcid, blevel, brank, bname,  sum(mweight) over (partition by cid, sid, bid          ) bweight,                 ");
			sb.append("         pid, pcid, plevel, prank, pname,  sum(mweight) over (partition by cid, sid, bid, pid     ) pweight,                 ");
			sb.append("         oid, ocid, olevel, orank, oname,  sum(mweight) over (partition by cid, sid, bid, pid, oid) oweight,                 ");
			sb.append("         mid, mcid, mlevel, mrank, mname,  mweight, measureid, frequency,                                                    ");
			sb.append("         substr(ym,1,4)||'-'||substr(ym,5,2) ym, substr(ym,5,2) mm, evalcomment                                                                                  ");
			sb.append(" FROM                                                                                                                        ");
			sb.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname     ");
			sb.append("         from   tblhierarchy t,tblcompany c                                                                                  ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year = ?                                                           ");
			sb.append("        ) com,                                                                                                               ");
			sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname     ");
			sb.append("         from   tblhierarchy t,tblsbu c                                                                                      ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year = ? and t.id like ?                                           ");
			sb.append("        ) sbu,                                                                                                               ");
			sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname     ");
			sb.append("         from   tblhierarchy t,tblbsc c                                                                                      ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=2 and t.year = ? and t.id like ?                                           ");
			sb.append("        ) bsc,                                                                                                               ");
			sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname     ");
			sb.append("         from   tbltreescore t,tblpst c                                                                                      ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=3 and t.year = ?                                                           ");
			sb.append("        ) pst  ,                                                                                                             ");
			sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname     ");
			sb.append("         from   tbltreescore t,tblobjective c                                                                                ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year = ?                                                           ");
			sb.append("        ) obj ,                                                                                                              ");
			sb.append("        (                                                                                                                    ");
			sb.append("         select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname,  ");
			sb.append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey,                                       ");
			sb.append("                d.unit       ,                                                                                               ");
			sb.append("                d.planned,d.plannedbase, d.base, d.baselimit, d.limit,                                                       ");
			sb.append("                mia.year||mia.month  ym, mia.evalopinion  evalcomment, evalgrade, evalscore, evalrid                         ");
			sb.append("         from   tbltreescore    t, tblmeasure c,  tblmeasuredefine d, tblmeaevaldetail mia                                   ");
			sb.append("         where  t.contentid  = d.id  and t.treelevel=5 and t.year = ? and d.measureid=c.id                                   ");
			sb.append("         and    t.contentid  = mia.evalid (+)                                                                             ");
			sb.append("         and    d.measurement = '비계량'                                                                                     ");
			sb.append("        ) mea                                                                                                                ");
			sb.append(" where  cid = spid (+)                                                                                                       ");
			sb.append(" and    sid = bpid (+)                                                                                                       ");
			sb.append(" and    bid = ppid (+)                                                                                                       ");
			sb.append(" and    pid = opid (+)                                                                                                       ");
			sb.append(" and    oid = mpid                                                                                                           ");
			sb.append(" order by crank, srank, brank, prank, orank, mrank                                                                           ");


			// ��ȸ Arg
			Object[] params = {year,year,sbuid,year,bscid,year,year,year};

			//System.out.println(sb.toString());

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);
			System.out.println(ds.toString());
			request.setAttribute("ds", ds);

		} catch (Exception e) {
			System.out.println("getOrgMeasEvalComment Error :" + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	// getOrgMeasEvalComment

	//== End ==========================================================================================================================

	//��跮��ǥ ���ǰ� ������
	public void getOrgMeasEvalComment1(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year  = request.getParameter("year" );
			String sbuid = request.getParameter("sbuid");
			String bscid = request.getParameter("bscid");
			String mcid = request.getParameter("mcid");

			//year = "2008";
			//ym = "200812";
			//bscid = "64";

			System.out.println("getOrgMeasEvalComment : year=" +year+ ", sbuid-" +sbuid + ", bscid-" + bscid+ ", mcid-" + mcid);

			StringBuffer sb = new StringBuffer();

			sb.append(" SELECT  *                                                                         ");
			sb.append(" FROM                                                                                                                        ");
			sb.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname     ");
			sb.append("         from   tblhierarchy t,tblcompany c                                                                                  ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year = ?                                                           ");
			sb.append("        ) com,                                                                                                               ");
			sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname     ");
			sb.append("         from   tblhierarchy t,tblsbu c                                                                                      ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year = ? and t.id like ?                                           ");
			sb.append("        ) sbu,                                                                                                               ");
			sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname     ");
			sb.append("         from   tblhierarchy t,tblbsc c                                                                                      ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=2 and t.year = ? and t.id like ?                                           ");
			sb.append("        ) bsc,                                                                                                               ");
			sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname     ");
			sb.append("         from   tbltreescore t,tblpst c                                                                                      ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=3 and t.year = ?                                                           ");
			sb.append("        ) pst  ,                                                                                                             ");
			sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname     ");
			sb.append("         from   tbltreescore t,tblobjective c                                                                                ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year = ?                                                           ");
			sb.append("        ) obj ,                                                                                                              ");
			sb.append("        (                                                                                                                    ");
			sb.append("         select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname,  ");
			sb.append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey,                                       ");
			sb.append("                d.unit       ,                                                                                               ");
			sb.append("                d.planned,d.plannedbase, d.base, d.baselimit, d.limit,                                                       ");
			sb.append("                mia.year||mia.month  ym, nvl(mia.evalopinion,' ')  evalcomment, evalgrade, evalscore, evalrid ,                        ");
			sb.append("	               f_getempnm(mia.evalrid) evalrnm,  d.mean, 		");		// �߰��� �κ�
			sb.append("	               emd.planned  evalplan, emd.detail  evaldetail, emd.estimate  evalestimate     ");  // �߰��� �κ�
			sb.append("         from   tbltreescore    t, tblmeasure c,  tblmeasuredefine d, tblmeaevaldetail mia ,                                  ");
			sb.append("		           tblevalmeasuredetail   emd     "); //�߰�
			sb.append("         where  t.contentid  = d.id  and t.treelevel=5 and t.year = ? and d.measureid=c.id                                   ");
			sb.append("         and    t.contentid  = mia.evalid (+)                                                                             ");
			sb.append("			and    t.contentid  = emd.measureid (+)   "); //�߰�
			sb.append("   		and    emd.effectivedate like mia.year||mia.month||'%'  "); //�߰�
			sb.append("         and    d.measurement = '비계량'                                                                                     ");
			sb.append("        ) mea                                                                                                                ");
			sb.append(" where  cid = spid (+)                                                                                                       ");
			sb.append(" and    sid = bpid (+)                                                                                                       ");
			sb.append(" and    bid = ppid (+)                                                                                                       ");
			sb.append(" and    pid = opid (+)                                                                                                       ");
			sb.append(" and    oid = mpid                                                                                                           ");
			sb.append(" and    mcid = ?                                                                                                           ");
			sb.append(" order by crank, srank, brank, prank, orank, mrank                                                                           ");


			// ��ȸ Arg
			Object[] params = {year,year,sbuid,year,bscid,year,year,year,mcid};

			//System.out.println(sb.toString());

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);
			System.out.println(ds.toString());
			request.setAttribute("ds", ds);

		} catch (Exception e) {
			System.out.println("getOrgMeasEvalComment Error :" + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	// getOrgMeasEvalComment

	//== End ==========================================================================================================================



}
