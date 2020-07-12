package com.nc.renov;
 
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class RenovActual {
	public void setDivision(HttpServletRequest request, HttpServletResponse response) 
	{
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			String userid = (String)request.getSession().getAttribute("userId");
			String auth = (String)request.getSession().getAttribute("auth01");
			String dept = (String)request.getSession().getAttribute("divcode");
			
			
			
			StringBuffer sb = new StringBuffer();
			
			if(auth.equals("1"))
			{
				sb.append("SELECT ID,NAME,PARENTID FROM TBLBSC ORDER BY PARENTID DESC,ID ");
				rs = dbobject.executeQuery(sb.toString());
			}
			else
			{
				sb.append("SELECT ID,NAME,PARENTID FROM TBLBSC  ") ;
				sb.append("where id = (select parentid from tblbsc where id = ?) ") ;
				sb.append("union all ") ;
				sb.append("SELECT ID,NAME,PARENTID FROM TBLBSC  ") ;
				sb.append("where id = ? ") ;
				sb.append("ORDER BY PARENTID DESC,ID ") ;
				Object[] pa = {dept,dept};
				rs = dbobject.executePreparedQuery(sb.toString(), pa);

			}
			
			
			
			
			
			
			DataSet ds = new DataSet();
			ds.load(rs);
			request.setAttribute("ds",ds);

			StringBuffer mgrUser = new StringBuffer();
			mgrUser.append("select * from tblrenovuser where userid = ?");
			if (rs!=null){rs.close(); rs=null;}
			Object[] pa = {userid};
			rs = dbobject.executePreparedQuery(mgrUser.toString(), pa);
			DataSet dsType = new DataSet();
			dsType.load(rs);
			request.setAttribute("userChk",dsType);
			
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
	
	public void actualRenov(HttpServletRequest request, HttpServletResponse response) 
	{
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String year = request.getParameter("year");
			String dept = request.getParameter("deptid");
			String qtr = request.getParameter("qtr");

			sb.append("select A.RENOVID, ") ;
			sb.append("       A.RENOVNAME, ") ;
			sb.append("       B.RENOVDTLID, ") ;
			sb.append("       B.RENOVDTLNAME, ") ;
			sb.append("       C.GOAL, ") ;
			sb.append("       C.qtr, ") ;
			sb.append("       C.achvid, ") ;
			sb.append("       C.ACHV  ") ;
			sb.append("from tblrenov a, tblrenovdetail b, tblrenovachv c ") ;
			sb.append("where a.RENOVID = b.RENOVID ") ;
			sb.append("and c.RENOVDTLID(+) = b.RENOVDTLID ") ;
			sb.append("and a.mgrdept = ? ") ;
			sb.append("AND C.QTR(+) = ? ") ;
			sb.append("AND A.YEAR = ? ") ;
			sb.append("order by a.renovid ") ;

			Object[] pa = {dept, qtr, year};
			
			rs = dbobject.executePreparedQuery(sb.toString(), pa);
			DataSet ds = new DataSet();
			ds.load(rs);
			request.setAttribute("ds",ds);

			
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
	}//-- method actualRenov
	
	
	
	public void actualDtl(HttpServletRequest request, HttpServletResponse response) 
	{
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try{
 			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String rid = request.getParameter("rid");
			String did = request.getParameter("did");
			String div = request.getParameter("mode")==null?"":request.getParameter("mode");;
			String qtr = request.getParameter("qtr");
			String goal = request.getParameter("goal");
			String achv = request.getParameter("achv");
			String achvid = request.getParameter("achvid")==null?"":request.getParameter("achvid");
			String execWork = request.getParameter("pgDesc");
			String userid = (String)request.getSession().getAttribute("userId");
			
			String fileNm = (String)request.getAttribute("fileNM")==null?"":(String)request.getAttribute("fileNM");
			String didF = (String)request.getAttribute("did")==null?"":(String)request.getAttribute("did");
			String divF = (String)request.getAttribute("mode")==null?"":(String)request.getAttribute("mode");
			

			StringBuffer mgrUser = new StringBuffer();
			mgrUser.append("select * from tblrenovuser where userid = ?");
			if (rs!=null){rs.close(); rs=null;}
			Object[] paUs = {userid};
			rs = dbobject.executePreparedQuery(mgrUser.toString(), paUs);
			DataSet dsType = new DataSet();
			dsType.load(rs);
			request.setAttribute("userChk",dsType);
			
			
			if(div.equals("C"))
			{

				StringBuffer strSQLU = new StringBuffer();
				strSQLU.append("update tblrenovachv set QTR = ?, GOAL = ?, ACHV = ?, MODIR = ?, MODIDATE = sysdate, DRVEXECACHV = ? ") ;
				strSQLU.append("where ACHVID = ? ") ;

				Object[] paU = {qtr, goal, achv, userid, execWork, achvid};
				int udpY = dbobject.executePreparedUpdate(strSQLU.toString(), paU);
				
//				StringBuffer strSQLUU = new StringBuffer();
//				strSQLUU.append("update tblrenovdetail set RENOVEXECWORK = ? where RENOVDTLID = ? ") ;
//				Object[] paUU = {execWork, did};
//				dbobject.executePreparedUpdate(strSQLUU.toString(), paUU);
				
				
				
				if(udpY < 1)
				{
					StringBuffer strSQL = new StringBuffer();
					strSQL.append("insert into tblrenovachv (RENOVID,   ") ;
					strSQL.append("                          RENOVDTLID,   ") ;
					strSQL.append("                          QTR,   ") ;
					strSQL.append("                          GOAL,   ") ;
					strSQL.append("                          ACHV,   ") ;
					strSQL.append("                          REGIR, ") ;
					strSQL.append("                          ACHVID,   ") ;
					strSQL.append("                          DRVEXECACHV   ") ;
					strSQL.append("                          )values(  ") ;
					strSQL.append("                          ?,  ") ;
					strSQL.append("                          ?,  ") ;
					strSQL.append("                          ?,  ") ;
					strSQL.append("                          ?,  ") ;
					strSQL.append("                          ?,  ") ;
					strSQL.append("                          ?, ") ;
					strSQL.append("                          (SELECT NVL(MAX(ACHVID)+1,1) FROM tblrenovachv),  ") ;
					strSQL.append("                          ? ") ;
					strSQL.append("                          ) ") ;

					Object[] paI = {rid, did, qtr, goal, achv,userid, execWork};
					dbobject.executePreparedUpdate(strSQL.toString(), paI);
				}
				
//				StringBuffer strSQLUD = new StringBuffer();
//				strSQLUD.append("update tblrenovdetail set RENOVEXECWORK = ? where RENOVDTLID = ? ") ;
//				Object[] paUD = {execWork, did};
//				dbobject.executePreparedUpdate(strSQLUD.toString(), paUD);
				
				conn.commit();
				request.setAttribute("msg", "1");

			}
			else if(div.equals("U"))
			{
				StringBuffer strSQL = new StringBuffer();
				strSQL.append("update tblrenovachv set QTR = ?, GOAL = ?, ACHV = ?, MODIR = ?, MODIDATE = sysdate ") ;
				strSQL.append("where ACHVID = ? ") ;

				Object[] paI = {qtr, goal, achv, userid, achvid};
				dbobject.executePreparedUpdate(strSQL.toString(), paI);
				
//				StringBuffer strSQLU = new StringBuffer();
//				strSQLU.append("update tblrenovdetail set RENOVEXECWORK = ? where RENOVDTLID = ? ") ;
//				Object[] paU = {execWork, did};
//				dbobject.executePreparedUpdate(strSQLU.toString(), paU);
				
				
				conn.commit();
				request.setAttribute("msg", "1");

			}
			else if(div.equals("D"))
			{
				StringBuffer strSQL = new StringBuffer();
				strSQL.append("delete from TBLRENOVACHV where achvid = ? ") ;
//				strSQL.append("and RENOVDTLID = ? ") ;
				
				Object[] paI = {achvid};
				dbobject.executePreparedUpdate(strSQL.toString(), paI);
				
				conn.commit();
				request.setAttribute("msg", "1");

			}
			
			if(divF.equals("F"))
			{
				StringBuffer strSQLU = new StringBuffer();
				strSQLU.append("update tblrenovdetail set FILEPATH = ? where RENOVDTLID = ? ") ;
				Object[] paU = {fileNm, didF};
				dbobject.executePreparedUpdate(strSQLU.toString(), paU);
				
				
				conn.commit();
				request.setAttribute("msg", "1");
			}
					

			
			sb.append("select a.RENOVID,   ") ;
			sb.append("       a.RENOVDTLID,   ") ;
			sb.append("       a.RENOVDTLNAME,   ") ;
			sb.append("       b.GOAL,   ") ;
			sb.append("       b.ACHV,   ") ;
 			sb.append("       b.DRVEXECACHV, ") ;
			sb.append("       b.qtr, ") ;
			sb.append("       b.achvid ") ;
			sb.append("from tblrenovdetail a, tblrenovachv b  ") ;
			sb.append("where a.renovid = b.renovid(+)  ") ;
			sb.append("and a.renovdtlid = b.renovdtlid(+)  ") ;
			sb.append("and a.renovid = ?  ") ;
			sb.append("and a.renovdtlid = ? ") ;
			sb.append("and b.qtr(+) = ? ") ;



			Object[] pa = {rid, did, qtr};
			
			rs = dbobject.executePreparedQuery(sb.toString(), pa);
			DataSet ds = new DataSet();
			ds.load(rs);
			request.setAttribute("ds",ds);

			
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
	}//-- method actualDtl
	
	
	
	
}	//--class RenovActual
