package com.nc.task;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class TaskProceed {

	public void procGetGrap(HttpServletRequest request, HttpServletResponse response) {
		ResultSet rs = null;
		DataSet ds = null;
		CoolConnection conn = null;
		DBObject dbobject = null;

		try {
			ds = new DataSet();
			StringBuffer strSQL = new StringBuffer();
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());

			String projId = request.getParameter("projId");
			
			if (projId==null) return;

			strSQL.append("SELECT MIN(SYEAR) AS MINYEAR, MAX(EYEAR) AS MAXYEAR FROM TBLSTRATPROJECTDETAIL WHERE PROJECTID=?") ;

			Object param[] = {projId};

			rs = dbobject.executePreparedQuery(strSQL.toString(), param);
			ds.load(rs);
			request.setAttribute("year", ds);


			strSQL = null; strSQL = new StringBuffer();
			ds = new DataSet();


			strSQL.append(" SELECT * FROM (   ")
	         .append("       (  ")
	         .append(" 	  SELECT PROJECTID, EXECWORK, DNAME, SYEAR, EYEAR,SQTR, EQTR,DETAILID,DYEAR,DID,ROUND(QTRGOAL,2) AS QTRGOAL,ROUND(QTRACHV,2) AS QTRACHV,round(REALIZE,2) as REALIZE,AYEAR,AQTR, DETAILID ADID, 0 SDTLID, 0 LEV, ROUND(REAVG, 2) REAVG   ")
	         .append(" 	  FROM    ")
	         .append("             (   ")
	         .append("             SELECT PROJECTID,    ")
	         .append("                    EXECWORK,   ")
	         .append("                    (SELECT TRIM(NAME) FROM TBLBSC WHERE ID=MGRDEPT ) DNAME,          ")
	         .append("                    D.SYEAR,D.EYEAR,   ")
	         .append("                    D.SQTR, D.EQTR,   ")
	         .append("                    D.DETAILID ")
	         .append("             FROM TBLSTRATPROJECTDETAIL D   ")
	         .append("             WHERE D.PROJECTID=?   ")
	         .append("             ) D            ")
	         .append("             LEFT JOIN   ")
	         .append("             (   ")
	         .append("              SELECT CASE WHEN (MAX(YEAR||QTR) > case when to_number(to_char(sysdate,'mm')) >= 1 and to_number(to_char(sysdate, 'mm')) <= 3 then to_char(sysdate,'yyyy')||1   ")
	         .append("                                                      when to_number(to_char(sysdate,'mm')) >= 4 and to_number(to_char(sysdate, 'mm')) <= 6 then to_char(sysdate,'yyyy')||2   ")
	         .append("                                                      when to_number(to_char(sysdate,'mm')) >= 7 and to_number(to_char(sysdate, 'mm')) <= 9 then to_char(sysdate,'yyyy')||3   ")
	         .append("                                                      when to_number(to_char(sysdate,'mm')) >= 10 and to_number(to_char(sysdate, 'mm')) <= 12 then to_char(sysdate,'yyyy')||4   ")
	         .append("                                                 end   ")
	         .append("                               )   ")
	         .append("                          THEN case when to_number(to_char(sysdate,'mm')) >= 1 and to_number(to_char(sysdate, 'mm')) <= 3 then to_char(sysdate,'yyyy')||1   ")
	         .append("                                    when to_number(to_char(sysdate,'mm')) >= 4 and to_number(to_char(sysdate, 'mm')) <= 6 then to_char(sysdate,'yyyy')||2   ")
	         .append("                                    when to_number(to_char(sysdate,'mm')) >= 7 and to_number(to_char(sysdate, 'mm')) <= 9 then to_char(sysdate,'yyyy')||3   ")
	         .append("                                    when to_number(to_char(sysdate,'mm')) >= 10 and to_number(to_char(sysdate, 'mm')) <= 12 then to_char(sysdate,'yyyy')||4   ")
	         .append("                               end   ")
	         .append("                          ELSE MAX(YEAR||QTR) END DYEAR, DETAILID DID,  (SUM(REALIZE) / (SELECT COUNT(I.DETAILID) FROM TBLSTRATACHVREGI I WHERE I.DETAILID = TBLSTRATACHVREGI.DETAILID  GROUP BY I.DETAILID)) AS REAVG  ")
	         .append("              FROM TBLSTRATACHVREGI    ")
	         .append("              WHERE REALIZE<>0   ")
	         .append("              GROUP BY DETAILID   ")
	         .append("             ) A   ")
	         .append("             ON A.DID=D.DETAILID     ")
	         .append("             LEFT JOIN   ")
	         .append("             (    ")
	         .append("             SELECT QTRGOAL,   ")
	         .append("                    QTRACHV,   ")
	         .append("                    REALIZE,   ")
	         .append("                    YEAR AYEAR,   ")
	         .append("                    QTR AQTR,   ")
	         .append("                    DETAILID ADID   ")
	         .append("             FROM TBLSTRATACHVREGI   ")
	         .append("             ) ACH   ")
	         .append("             ON A.DYEAR=ACH.AYEAR||AQTR AND A.DID=ACH.ADID   ")
	         .append("       )   ")
	         .append("       UNION ALL    ")
	         .append("       (   ")
	         .append("       SELECT PROJECTID, EXECWORK, DNAME, SYEAR, EYEAR,SQTR, EQTR,DETAILID,DYEAR,DID,ROUND(QTRGOAL,2) AS QTRGOAL,ROUND(QTRACHV,2) AS QTRACHV,round(REALIZE,2) as REALIZE,AYEAR,AQTR, DETAILID ADID , SDTLID, 1 LEV, 0 REAVG  ")
	         .append("       FROM    ")
	         .append("           ( SELECT A.PROJECTID, B.DTLNAME EXECWORK, A.DNAME, B.SYEAR, B.EYEAR, B.SQTR,B.EQTR, B.DETAILID DETAILID, B.DTLID SDTLID   ")
	         .append("             FROM   ")
	         .append("              ( SELECT  PROJECTID,    ")
	         .append("                        EXECWORK,   ")
	         .append("                        (SELECT TRIM(NAME) FROM TBLBSC WHERE ID=MGRDEPT ) DNAME,          ")
	         .append("                        SYEAR,EYEAR,   ")
	         .append("                        SQTR,EQTR,   ")
	         .append("                        DETAILID   ")
	         .append("                 FROM TBLSTRATPROJECTDETAIL D   ")
	         .append("                 WHERE D.PROJECTID=?     ")
	         .append("               )A, TBLSTRATWORK B   ")
	         .append("             WHERE B.DETAILID = A.DETAILID ")
	         .append(" 		  )D   ")
	         .append("           LEFT JOIN   ")
	         .append("           (   ")
	         .append("           SELECT CASE WHEN (MAX(YEAR||QTR) > case when to_number(to_char(sysdate,'mm')) >= 1 and to_number(to_char(sysdate, 'mm')) <= 3 then to_char(sysdate,'yyyy')||1   ")
	         .append("                                                    when to_number(to_char(sysdate,'mm')) >= 4 and to_number(to_char(sysdate, 'mm')) <= 6 then to_char(sysdate,'yyyy')||2   ")
	         .append("                                                    when to_number(to_char(sysdate,'mm')) >= 7 and to_number(to_char(sysdate, 'mm')) <= 9 then to_char(sysdate,'yyyy')||3   ")
	         .append("                                                    when to_number(to_char(sysdate,'mm')) >= 10 and to_number(to_char(sysdate, 'mm')) <= 12 then to_char(sysdate,'yyyy')||4   ")
	         .append("                                               end   ")
	         .append("                             )   ")
	         .append("                        THEN case when to_number(to_char(sysdate,'mm')) >= 1 and to_number(to_char(sysdate, 'mm')) <= 3 then to_char(sysdate,'yyyy')||1   ")
	         .append("                                  when to_number(to_char(sysdate,'mm')) >= 4 and to_number(to_char(sysdate, 'mm')) <= 6 then to_char(sysdate,'yyyy')||2   ")
	         .append("                                  when to_number(to_char(sysdate,'mm')) >= 7 and to_number(to_char(sysdate, 'mm')) <= 9 then to_char(sysdate,'yyyy')||3   ")
	         .append("                                  when to_number(to_char(sysdate,'mm')) >= 10 and to_number(to_char(sysdate, 'mm')) <= 12 then to_char(sysdate,'yyyy')||4   ")
	         .append("                             end   ")
	         .append("                        ELSE MAX(YEAR||QTR) END DYEAR,DTLID DID   ")
	         .append("            FROM TBLSTRATWORKACHV    ")
	         .append("            WHERE REALIZE<>0   ")
	         .append("            GROUP BY DTLID   ")
	         .append("           ) A   ")
	         .append("           ON A.DID=D.SDTLID   ")
	         .append("           LEFT JOIN   ")
	         .append("           (SELECT QTRGOAL,   ")
	         .append("                  QTRACHV,   ")
	         .append("                  REALIZE,   ")
	         .append("                  YEAR AYEAR,   ")
	         .append("                  QTR AQTR,   ")
	         .append("                  DTLID ADID   ")
	         .append("            FROM TBLSTRATWORKACHV   ")
	         .append("           ) ACH   ")
	         .append("           ON A.DYEAR=ACH.AYEAR||AQTR AND A.DID=ACH.ADID   ")
	         .append("       )      ")
	         .append(" )   ")
	         .append(" ORDER BY  ADID, LEV, SDTLID   ");

			
			Object params[] = {projId,projId};    

			rs = dbobject.executePreparedQuery(strSQL.toString(), params);
			ds.load(rs);
			request.setAttribute("proc", ds);

		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			request.setAttribute("result","false");
			System.out.println(se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			request.setAttribute("result","false");
			System.out.println(e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}

	}	//procGetGrap


	public void procDetailQtr1(HttpServletRequest request, HttpServletResponse response) {
		ResultSet rs = null;
		DataSet ds = null;
		CoolConnection conn = null;
		DBObject dbobject = null;
		StringBuffer strSQL = null;

		String prjid = "";
		String dtlid = "";
		String div = "";
		String sdtlid = "";
		
		try {
			prjid = (String)request.getParameter("prjid");
			dtlid = (String)request.getParameter("dtlid");
			div = (String)request.getParameter("div");
			sdtlid = (String)request.getParameter("sdtlid");	//세부실행과제 일때만 값이 들어 오고 아닐때는 0이 들어 온다 .
			
			ds = new DataSet();
			strSQL = new StringBuffer();
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());


			

			if(!sdtlid.equals("0"))	//--세부실행계획
			{
				strSQL.append(" select a.name, (select name from tblbsc t where t.id = (select divcode from tbluser u   ")
		         .append("                       where userid = B.MGRUSER)) as MGRDEPT,  ")
		         .append("         b.EXECWORK, b.syear, b.eyear, b.eqtr, b.sqtr,c.dtlname ")
		         .append(" from tblstratproject a, tblstratprojectdetail b, tblstratwork c   ")
		         .append(" where a.id = ?  and a.id=b.projectid and b.detailid = ? and b.detailid=c.detailid and c.dtlid=?  ");
				
				Object[] param = {prjid, dtlid,sdtlid};
				rs = dbobject.executePreparedQuery(strSQL.toString(), param);
			}
			else	//--실행계획
			{
				strSQL.append(" select  NAME,   ")
		         .append("         b.EXECWORK,   ")
		         .append("        (select name   ")
		         .append("         from tblbsc   ")
		         .append("         where B.MGRDEPT = id) As MGRDEPT,    ")
		         .append("         b.syear,   ")
		         .append("         b.eyear   ")
		         .append(" from tblstratproject a, tblstratprojectdetail b   ")
		         .append(" where a.id = ?   ")
		         .append(" and b.detailid = ?   ");

				Object[] param = {prjid, dtlid};
				rs = dbobject.executePreparedQuery(strSQL.toString(), param);
			}



			
			
			ds.load(rs);
			request.setAttribute("qtrSt_Ed", ds);



			ds = new DataSet();
			strSQL = null;
			strSQL = new StringBuffer();
			
			if(!sdtlid.equals("0")) {
				strSQL.append(" select max(a.id) as projectid, b.detailid, max(execwork) as execwork , d.year,    ")
		         .append(" max((select NAME from tblbsc where id = (SELECT DIVCODE FROM TBLUSER WHERE USERID=b.MGRUSER))) as MGRDEPT,    ")
		         .append(" max(decode(d.qtr, 1, d.QTRACHV))||'/'||max(decode(d.qtr, 1, d.QTRGOAL))||'('||max(decode(d.qtr, 1, d.REALIZE))||')' as qtr1,    ")
		         .append(" max(decode(d.qtr, 2, d.QTRACHV))||'/'||max(decode(d.qtr, 2, d.QTRGOAL))||'('||max(decode(d.qtr, 2, d.REALIZE))||')' as qtr2,      ")
		         .append(" max(decode(d.qtr, 3, d.QTRACHV))||'/'||max(decode(d.qtr, 3, d.QTRGOAL))||'('||max(decode(d.qtr, 3, d.REALIZE))||')' as qtr3,    ")
		         .append(" max(decode(d.qtr, 4, d.QTRACHV))||'/'||max(decode(d.qtr, 4, d.QTRGOAL))||'('||max(decode(d.qtr, 4, d.REALIZE))||')' as qtr4  ")
		         .append("  from tblstratproject a, tblstratprojectdetail b, TBLSTRATWORK c , TBLSTRATWORKACHV d  ")
		         .append(" where a.id = ?    ")
		         .append(" and a.id = b.projectid    ")
		         .append(" and c.detailid = b.detailid    ")
		         .append(" and c.detailid = ?     ")
		         .append(" and c.dtlid = ?  ")
		         .append(" and c.dtlid = d.dtlid(+)  ")
		         .append(" group by d.year, b.detailid ");
				Object param2[] = {prjid, dtlid, sdtlid};
				rs = dbobject.executePreparedQuery(strSQL.toString(), param2);
			} else {
				strSQL.append(" select max(a.id) as projectid,     ")
		         .append("        b.detailid,     ")
		         .append("        max(execwork) as execwork ,     ")
		         .append("        c.year,     ")
		         .append(" max(decode(c.qtr, 1, c.realize)) as qtr1,   ")
		         .append(" max(decode(c.qtr, 2, c.realize)) as qtr2,          ")
		         .append(" max(decode(c.qtr, 3, c.realize)) as qtr3,   ")
		         .append(" max(decode(c.qtr, 4, c.realize)) as qtr4,  ")
		         .append(" max((select NAME from tblbsc where id = (SELECT DIVCODE FROM TBLUSER WHERE USERID=MGRUSER))) as MGRDEPT  ")
		         .append("  from tblstratproject a, tblstratprojectdetail b, tblstratachvregi c     ")
		         .append(" where a.id = ?     ")
		         .append(" and a.id = b.projectid     ")
		         .append(" and c.detailid = b.detailid     ")
		         .append(" and c.detailid = ?     ")
		         .append(" group by c.year, b.detailid  ");


				Object param2[] = {prjid, dtlid};
				rs = dbobject.executePreparedQuery(strSQL.toString(), param2);
			}
				


			ds.load(rs);
			request.setAttribute("detailQtr1", ds);

		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			request.setAttribute("result","false");
			System.out.println(se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			request.setAttribute("result","false");
			System.out.println(e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}


	}	//method procDetailQtr1

	
	
	public void achvFile(HttpServletRequest request, HttpServletResponse response)
	{
		ResultSet rs = null;
		DataSet ds = null;
		CoolConnection conn = null;
		DBObject dbobject = null;
		
		String typeid = "";
		String did = "";
		String qtr = "";
		String year = "";
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			typeid = request.getParameter("typeid");
			did = request.getParameter("did");
			qtr = request.getParameter("qtr");
			year = request.getParameter("year");
			
				
			StringBuffer strSQL = new StringBuffer();
			strSQL.append("select FILEPATH from TBLSTRATACHVREGI ") ;
			strSQL.append("where DETAILID = ? ") ;
			strSQL.append("and year = ? ") ;
			strSQL.append("and qtr = ? ") ;
			Object[] pa = {did, year, qtr};
			rs = dbobject.executePreparedQuery(strSQL.toString(), pa);
				
			
			ds = new DataSet();
			ds.load(rs);
			request.setAttribute("fileList", ds);
			
			
		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			request.setAttribute("result","false");
			System.out.println(se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			request.setAttribute("result","false");
			System.out.println(e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}

		
	}// mehtod achvFile



}	//TaskProceed
