package com.nc.renov;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class RenovTask 
{
	public void setDivision(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT ID,NAME,PARENTID FROM TBLBSC ORDER BY PARENTID DESC,ID ");
			rs = dbobject.executeQuery(sb.toString());
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);

			StringBuffer sbType = new StringBuffer();
			sbType.append("SELECT TYPEID,TYPENAME FROM TBLSTRATTYPEINFO");

			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executeQuery(sbType.toString());
			

			
		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			System.out.println(this.toString()+" : "+se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			System.out.println(this.toString()+" : "+e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}
	}//-- method setDivision
	

	
	public void setDetail(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String year = request.getParameter("year");
			String qtr = request.getParameter("qtr");
			String dept = request.getParameter("mgrdept");
			String parentid = request.getParameter("parentid");
//			Object[] pa = null;
			
			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT e.RENOVID,   ") ;
			sb.append("       e.RENOVDTLID,   ") ;
			sb.append("       c.QTR,   ") ;
			sb.append("       c.GOAL,   ") ;
			sb.append("       c.ACHV,   ") ;
			sb.append("       DECODE(C.GOAL, NULL, '', ROUND(C.ACHV/C.GOAL*100,2)) AS REALIZE,   ") ;
			sb.append("       c.ACHVID,   ") ;
			sb.append("       e.sqtr,   ") ;
			sb.append("       e.eqtr,   ") ;
			sb.append("       E.RENOVDTLNAME ,   ") ;
			sb.append("       D.ID ,   ") ;
			sb.append("		 (select NAME from tblbsc where id = D.ID) as deptnm,  ") ;
			sb.append("       E.RENOVNAME   ") ;
			sb.append("FROM TBLRENOVACHV C, (SELECT B.RENOVID,    ") ;
			sb.append("                               B.RENOVDTLID,    ") ;
			sb.append("                               B.RENOVDTLNAME,   ") ;
			sb.append("                               B.sqtr,   ") ;
			sb.append("                               B.eqtr,   ") ;
			sb.append("                               A.mgrdept ,   ") ;
			sb.append("                               A.RENOVNAME   ") ;
			sb.append("                      FROM TBLRENOV A, TBLRENOVDETAIL B   ") ;
			sb.append("                      WHERE A.RENOVID = B.RENOVID   ") ;
			sb.append("                      AND A.YEAR = ?   ") ;
			sb.append("                      ) E, TBLBSC D ") ;
			if(!dept.equals("-1"))
			{

				sb.append("WHERE C.RENOVID(+) = E.RENOVID   ") ;
				sb.append("AND   C.RENOVDTLID(+) = E.RENOVDTLID   ") ;
				sb.append("AND   C.QTR(+) = ?  ") ;
				sb.append("AND  D.PARENTID = ? ") ;
				sb.append("AND D.ID = ? ") ;
				sb.append("AND D.ID = E.MGRDEPT ") ;
				sb.append("order by e.mgrdept, e.RENOVID, e.RENOVDTLID ") ;

				Object[] pa = {year, qtr, parentid, dept};
				rs = dbobject.executePreparedQuery(sb.toString(), pa);
			}
			else
			{
				sb.append("WHERE C.RENOVID(+) = E.RENOVID   ") ;
				sb.append("AND   C.RENOVDTLID(+) = E.RENOVDTLID   ") ;
				sb.append("AND   C.QTR(+) = ?  ") ;
				sb.append("AND  D.PARENTID = ? ") ;
				sb.append("AND D.ID = E.MGRDEPT ") ;
				sb.append("order by e.mgrdept, e.RENOVID, e.RENOVDTLID ") ;

				Object[] pa = {year, qtr, parentid};
				rs = dbobject.executePreparedQuery(sb.toString(), pa);
			}
				


//			Object[] pa = {year, dept, qtr};
			
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("proc",ds);
		
		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			System.out.println(this.toString()+" : "+se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			System.out.println(this.toString()+" : "+e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}
	}//-- method setDivision

	
	
	
	
	public void procDetailQtr1(HttpServletRequest request, HttpServletResponse response)
	{
		ResultSet rs = null;
		DataSet ds = null;
		CoolConnection conn = null;
		DBObject dbobject = null;
		StringBuffer strSQL = null;

		String prjid = "";
		String dtlid = "";



		try
		{
			prjid = (String)request.getParameter("prjid");
			dtlid = (String)request.getParameter("dtlid");

			String year = request.getParameter("year");
			String dept = request.getParameter("dept");
			String did = request.getParameter("did");
			
			
			ds = new DataSet();
			strSQL = new StringBuffer();
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());


			strSQL.append("select a.RENOVNAME, b.RENOVDTLNAME, b.RENOVDTLDESC, b.RENOVEXECWORK, b.FILEPATH ") ;
			strSQL.append("from tblrenov a, tblrenovdetail b ") ;
			strSQL.append("where a.renovid = b.renovid ") ;
			strSQL.append("and b.RENOVDTLID = ? ") ;

			
			Object param[] = {did};
			rs = dbobject.executePreparedQuery(strSQL.toString(), param);
			ds.load(rs);
			request.setAttribute("qtrSt_Ed", ds);



			ds = new DataSet();
			strSQL = null;
			strSQL = new StringBuffer();

			strSQL.append("SELECT e.RENOVID, ") ;
			strSQL.append("       e.RENOVDTLID, ") ;
			strSQL.append("       c.QTR, ") ;
			strSQL.append("       c.GOAL, ") ;
			strSQL.append("       c.ACHV, ") ;
			strSQL.append("       DECODE(C.GOAL, NULL, '', ROUND(C.ACHV/C.GOAL*100,2)) AS REALIZE, ") ;
			strSQL.append("       c.ACHVID, ") ;
			strSQL.append("       E.RENOVDTLNAME , ") ;
			strSQL.append("       E.RENOVNAME, ") ;
			strSQL.append("       E.RENOVEXECWORK, ") ;
			strSQL.append("       e.sqtr, ") ;
			strSQL.append("       e.eqtr ") ;
			strSQL.append("FROM TBLRENOVACHV C, (SELECT B.RENOVID,  ") ;
			strSQL.append("                               B.RENOVDTLID,  ") ;
			strSQL.append("                               B.RENOVDTLNAME, ") ;
			strSQL.append("                               A.RENOVNAME, ") ;
			strSQL.append("                               B.RENOVEXECWORK,  ") ;
			strSQL.append("                               b.sqtr, ") ;
			strSQL.append("                               b.eqtr ") ;
			strSQL.append("                      FROM TBLRENOV A, TBLRENOVDETAIL B ") ;
			strSQL.append("                      WHERE A.RENOVID = B.RENOVID ") ;
			strSQL.append("                      AND A.YEAR = ? ") ;
			strSQL.append("                      AND B.RENOVDTLID = ? ") ;
			strSQL.append("                      AND A.MGRDEPT = ?) E ") ;
			strSQL.append("WHERE C.RENOVID(+) = E.RENOVID ") ;
			strSQL.append("AND   C.RENOVDTLID(+) = E.RENOVDTLID ") ;
			strSQL.append("order by c.qtr ") ;


			Object param2[] = {year, did, dept};
			rs = dbobject.executePreparedQuery(strSQL.toString(), param2);
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


	
	
}
