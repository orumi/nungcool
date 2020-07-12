package com.nc.renov;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class RenovMgr {

	public void setMgrUser(HttpServletRequest request, HttpServletResponse response)
	{
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try
		{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			StringBuffer strSQL = new StringBuffer();
			strSQL.append("select  ") ;
			strSQL.append("    (select NAME from tblbsc where id = a.DEPTID) as deptname, ") ;
			strSQL.append("    (select USERNAME from tbluser where USERID = a.USERID) as username, ") ;
			strSQL.append("(select DIVCODE from tbluser where USERID = a.USERID) as parentid, ") ;
			strSQL.append("    userid, ") ;
			strSQL.append("    DEPTID ") ;
			strSQL.append("from TBLRENOVUSER a ") ;

			rs = dbobject.executeQuery(strSQL.toString());
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
			
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
		
	}	//method setMgrUser
	
	public void getUserInfo(HttpServletRequest request, HttpServletResponse response)
	{
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		String deptid = "";
		String userid= "";
		String div = "";
		String regid = "";
		try
		{
			div = request.getParameter("div");
			userid = request.getParameter("mgruser");
			deptid = request.getParameter("dept");
			regid = (String)request.getSession().getAttribute("userId");
			
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			StringBuffer strSQL = new StringBuffer();
			strSQL.append("select * from tblbsc ") ;
			strSQL.append("where parentid is not null order by parentid ") ;
			rs = dbobject.executeQuery(strSQL.toString());
			DataSet ds = new DataSet();
			ds.load(rs);
			request.setAttribute("dept",ds);
			
			
			StringBuffer user = new StringBuffer();
			user.append("select userid, username, divcode as parent  ") ;
			user.append("from tbluser  ") ;
			user.append("where divcode is not null  ") ;
			user.append("order by username ") ;
			rs = dbobject.executeQuery(user.toString());
			DataSet userDs = new DataSet();
			userDs.load(rs);
			request.setAttribute("user",userDs);
			
			
			StringBuffer isExist = new StringBuffer();
			isExist.append("SELECT * FROM TBLRENOVUSER WHERE DEPTID = ?") ;
			Object[] pa = {deptid};
			rs = dbobject.executePreparedQuery(isExist.toString(), pa);
			DataSet existDs = new DataSet();
			existDs.load(rs);
			int rowCnt = existDs.getRowCount();
			
			if(div.equals("I"))
			{
				if(rowCnt == 0)
				{
					StringBuffer ins = new StringBuffer();
					ins.append("insert into TBLRENOVUSER (DEPTID, USERID, REGIR) ") ;
					ins.append("        values(?,?,?) ") ;
	
					Object[] param = {deptid, userid,regid};
					dbobject.executePreparedUpdate(ins.toString(), param);
					conn.commit();
					
					request.setAttribute("reqUser", userid);
					request.setAttribute("reqDept", deptid);
					request.setAttribute("proc", "ok");
				}
				else
				{
					request.setAttribute("msg", "기존에 입력한 데이터가 있습니다.");
				}
					

			}
			else if(div.equals("U"))
			{
				StringBuffer udp = new StringBuffer();
				udp.append("update TBLRENOVUSER set USERID = ?, modir = ?, MODIDATE = sysdate ") ;
				udp.append("where DEPTID = ? ") ;

				Object[] param = {userid, regid, deptid};
				dbobject.executePreparedUpdate(udp.toString(), param);
				conn.commit();
				
				request.setAttribute("reqUser", userid);
				request.setAttribute("reqDept", deptid);
				request.setAttribute("proc", "ok");
			}
			else if(div.equals("D"))
			{

				StringBuffer strSQLd = new StringBuffer();
				strSQLd.append("select  *  ") ;
				strSQLd.append("from GIZMO80.TBLRENOV  ") ;
				strSQLd.append("WHERE MGRDEPT = ? ") ;

				Object[] paramS = {deptid};
				rs = dbobject.executePreparedQuery(strSQLd.toString(), paramS);
				DataSet dsD = new DataSet();
				dsD.load(rs);
				
				
				if(dsD.getRowCount() == 0)
				{
					StringBuffer del = new StringBuffer();
					del.append("delete from TBLRENOVUSER where DEPTID = ? ") ;
					Object[] param = {deptid};
					dbobject.executePreparedQuery(del.toString(), param);
					conn.commit();
				}
				else
				{
					request.setAttribute("msg", "담당하는 혁신과제가 있어 삭제할 수 없습니다.");
				}



				request.setAttribute("reqUser", userid);
				request.setAttribute("reqDept", deptid);
				request.setAttribute("proc", "ok");
				
			}
			

			
			
		
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
		
	}	//method setMgrUser
	
	
	
	
}	//class RenovMgr
