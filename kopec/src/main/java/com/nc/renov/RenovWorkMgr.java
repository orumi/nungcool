package com.nc.renov;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class RenovWorkMgr {

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
			
			DataSet dsType = new DataSet();
			dsType.load(rs);
			
			request.setAttribute("dsType",dsType);
			
			StringBuffer sbProj = new StringBuffer();
			sbProj.append("SELECT PROJECTID,TYPEID,CONTENTID, ")
				.append(" (SELECT NAME FROM TBLSTRATPROJECT WHERE ID=CONTENTID) PNAME, ")
				.append(" FIELDID, (SELECT FIELDNAME FROM TBLSTRATFIELDINFO F WHERE F.FIELDID=P.FIELDID) FNAME ") 
				.append(" FROM TBLSTRATPROJECTINFO P ORDER BY TYPEID,FIELDID");
			
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executeQuery(sbProj.toString());
			
			DataSet dsProj = new DataSet();
			dsProj.load(rs);
			
			request.setAttribute("dsProj",dsProj);

			
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
	}//-- method getDivisionprocGetGrap
	
	
	public void setProject(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String deptid = request.getParameter("deptid");
			String year = request.getParameter("year");
			
			
			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT a.renovid, a.RENOVNAME, b.RENOVDTLNAME FROM TBLRENOV A, TBLRENOVDETAIL B ") ;
			sb.append("WHERE A.RENOVID = B.RENOVID(+) ") ;
			sb.append("AND A.MGRDEPT = ? ") ;
			sb.append("AND A.YEAR = ? ") ;

			Object[] par = {deptid, year};
			rs = dbobject.executePreparedQuery(sb.toString(), par);
			
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
	}	//method setProject
	
	
	public void setProjectDetail(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		DataSet sDs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null)
				dbobject = new DBObject(conn.getConnection());
			
			
			String div = request.getParameter("mode");
			String rid = request.getParameter("pid");
			String rname = request.getParameter("pname");
			String deptid = request.getParameter("deptid");
			String year = request.getParameter("year");
			String userid = (String)request.getSession().getAttribute("userId");
			
			if(div.equals("C"))
			{
				StringBuffer iStrSQL = new StringBuffer();
				iStrSQL.append("insert into TBLRENOV (RENOVID,  ") ;
				iStrSQL.append("                      MGRDEPT,  ") ;
				iStrSQL.append("                      RENOVNAME,  ") ;
				iStrSQL.append("                      REGIR, ") ;
				iStrSQL.append("                      YEAR ") ;
				iStrSQL.append("                     )values ") ;
				iStrSQL.append("                     (  (select nvl(max(RENOVID)+1,1) from TBLRENOV), ") ;
				iStrSQL.append("                      ?, ") ;
				iStrSQL.append("                      ?, ") ;
				iStrSQL.append("                      ?, ") ;
				iStrSQL.append("                      ? ") ;
				iStrSQL.append("                     ) ") ;


				Object[] iPa = {deptid, rname, userid, year};
				dbobject.executePreparedUpdate(iStrSQL.toString(), iPa);
				conn.commit();
				request.setAttribute("proc", "ok");
			}
			else if(div.equals("U"))
			{
				StringBuffer uStrSQL = new StringBuffer();
				uStrSQL.append("update TBLRENOV set RENOVNAME = ?  ") ;
				uStrSQL.append("where RENOVID = ? ") ;
				uStrSQL.append("and   MGRDEPT = ? ") ;
				uStrSQL.append("and   YEAR = ? ") ;
				
				Object[] iPa = {rname, rid, deptid, year};
				dbobject.executePreparedUpdate(uStrSQL.toString(), iPa);
				conn.commit();
				request.setAttribute("proc", "ok");

			}
			else if(div.equals("D"))
			{
				
				StringBuffer delSQL = new StringBuffer();
				delSQL.append("select * from TBLRENOVDETAIL ") ;
				delSQL.append("where RENOVID = ? ") ;
				Object[] sPa = {rid};
				rs = dbobject.executePreparedQuery(delSQL.toString(), sPa);
				sDs = new DataSet();
				sDs.load(rs);
				
				
				if(sDs.getRowCount() == 0)
				{
					StringBuffer dStrSQL = new StringBuffer();
					dStrSQL.append("delete from TBLRENOV ") ;
					dStrSQL.append("where renovid = ? ") ;
					dStrSQL.append("and MGRDEPT = ? ") ;
					dStrSQL.append("and year = ? ") ;
					Object[] iPa = {rid, deptid, year};
					dbobject.executePreparedUpdate(dStrSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");
				}
				else
				{
					request.setAttribute("proc", "fail");
				}


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
	} //-- method setProjectDetail
	
	public void setDetailList(HttpServletRequest request, HttpServletResponse response)
	{
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			String rid = request.getParameter("pid");
			String did = request.getParameter("did");
			String div = request.getParameter("mode");
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null)
				dbobject = new DBObject(conn.getConnection());
			
			
			if(div.equals("D"))
			{
				StringBuffer strSQLD = new StringBuffer();
				strSQLD.append("select * from tblrenovachv where  RENOVID = ? and RENOVDTLID= ? ") ;

				Object[] dPaD = {rid, did};
				rs = dbobject.executePreparedQuery(strSQLD.toString(), dPaD);
				DataSet ds = new DataSet();
				ds.load(rs);
				if(ds.getRowCount() != 0)
				{
					request.setAttribute("msg", "fail");
				}
				else
				{
					StringBuffer strSQL = new StringBuffer();
					strSQL.append("delete from TBLRENOVDETAIL ") ;
					strSQL.append("where RENOVID = ? ") ;
					strSQL.append("and RENOVDTLID = ? ") ;
	
					Object[] dPa = {rid, did};
					dbobject.executePreparedQuery(strSQL.toString(), dPa);
					conn.commit();
					request.setAttribute("msg", "ok");
				}
			}
			
			
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT A.RENOVID,  ") ;
			sb.append("       B.RENOVDTLID,  ") ;
			sb.append("       B.RENOVDTLNAME,  ") ;
			sb.append("       B.RENOVDTLDESC,  ") ;
			sb.append("       (SELECT NAME FROM TBLBSC WHERE ID = A.MGRDEPT) AS DEPTNM,  ") ;
			sb.append("       (SELECT USERNAME FROM TBLUSER WHERE USERID = C.USERID) AS USERNM ") ;
			sb.append("FROM TBLRENOV A, TBLRENOVDETAIL B, TBLRENOVUSER C ") ;
			sb.append("WHERE A.RENOVID = B.RENOVID ") ;
			sb.append("AND A.RENOVID = ? ") ;
			sb.append("AND A.MGRDEPT = C.DEPTID ") ;

			Object[] pm = {rid};
			
			rs = dbobject.executePreparedQuery(sb.toString(),pm);
			
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
	}
	
	
	public void getDetailExe(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String rid = request.getParameter("pid");
			String did = request.getParameter("did");
			String tag = request.getParameter("tag");
			String div = request.getParameter("mode")==null?"":request.getParameter("mode");
			String sqtr = request.getParameter("sqtr");
			String eqtr = request.getParameter("eqtr");
			
			
			String renovExec = request.getParameter("renovExec");
			String renovDtl = request.getParameter("renovDtl");
			
			String userid = (String)request.getSession().getAttribute("userId");
			
			
			if(tag.equals("U"))
			{
				if(div.equals("T"))
				{
					StringBuffer uStrSQL = new StringBuffer();
					uStrSQL.append("update tblrenovdetail  ") ;
					uStrSQL.append("set RENOVDTLNAME = ?,  ") ;
					uStrSQL.append("    RENOVDTLDESC = ?, ") ;
					uStrSQL.append("    SQTR = ?, ") ;
					uStrSQL.append("    EQTR = ?, ") ;
					uStrSQL.append("    MODIR = ?, ") ;
					uStrSQL.append("    MODIDATE = sysdate   ") ;
					uStrSQL.append("where RENOVID = ? ") ;
					uStrSQL.append("and RENOVDTLID = ? ") ;
	
					
					Object[] paU = {renovExec, renovDtl, sqtr, eqtr, userid, rid, did};
					dbobject.executePreparedUpdate(uStrSQL.toString(), paU);
					request.setAttribute("proc", "pop");	//-- 처리 완료후 메시지
				}
				
				
				
				StringBuffer sb = new StringBuffer();
				sb.append("select (select RENOVNAME from tblrenov where RENOVID = a.RENOVID) as RENOVNAME,  ") ;
				sb.append("       a.RENOVDTLID,  ") ;
				sb.append("       a.RENOVDTLNAME,  ") ;
				sb.append("       a.sqtr,  ") ;
				sb.append("       a.eqtr,  ") ;
				sb.append("       a.RENOVDTLDESC  ") ;
				sb.append("from tblrenovdetail a ") ;
				sb.append("where a.RENOVID = ?  ") ;
				sb.append("and a.RENOVDTLID  = ?  ") ;


				Object[] pm = {rid,did};
				
				rs = dbobject.executePreparedQuery(sb.toString(),pm);
				
				DataSet ds = new DataSet();
				ds.load(rs);
				
				request.setAttribute("dsUser",ds);
				

				
				conn.commit();
			}
			else if(tag.equals("I"))
			{
				if(div.equals("G"))
				{
					
					StringBuffer strSQL = new StringBuffer();
					strSQL.append("insert into tblrenovdetail (RENOVID,  ") ;
					strSQL.append("                            RENOVDTLID,  ") ;
					strSQL.append("                            RENOVDTLNAME,  ") ;
					strSQL.append("                            RENOVDTLDESC,  ") ;
					strSQL.append("                            REGIR, ") ;
					strSQL.append("                            SQTR, ") ;
					strSQL.append("                            EQTR ") ;
					strSQL.append("                            )values( ") ;
					strSQL.append("                            ?, ") ;
					strSQL.append("                            (select nvl(max(RENOVDTLID)+1, 1) from tblrenovdetail), ") ;
					strSQL.append("                            ?, ") ;
					strSQL.append("                            ?, ") ;
					strSQL.append("                            ?, ") ;
					strSQL.append("                            ?, ") ;
					strSQL.append("                            ? ") ;
					strSQL.append("                            ) ") ;
	
					Object[] pmI = {rid,renovExec, renovDtl, userid, sqtr, eqtr};
					dbobject.executePreparedUpdate(strSQL.toString(), pmI);
					
					request.setAttribute("proc", "pop");//-- 처리 완료후 메시지
				}
				
				
				
				StringBuffer sb = new StringBuffer();
				sb.append("select * from tblrenov ") ;
				sb.append("where RENOVID = ? ") ;
				Object[] pm = {rid};
				rs = dbobject.executePreparedQuery(sb.toString(),pm);
				DataSet ds = new DataSet();
				ds.load(rs);
				request.setAttribute("dsUser",ds);


				
				conn.commit();
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
	}
	
	
	
	
	
	
	
	
	
	
	
	
}	//-- class RenovWorkMgr
