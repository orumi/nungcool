package com.nc.task;


import java.sql.ResultSet;
import java.sql.SQLException;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.StrConvert;
import com.nc.util.Util;
import com.nc.cool.CoolServer;

public class TaskAdmin {

	public void setProject(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT P.ID PID,P.NAME,T.TYPENAME FROM TBLSTRATPROJECT P, TBLSTRATTYPEINFO T WHERE P.TYPEID=T.TYPEID ORDER BY T.TYPEID, P.ID");
			rs = dbobject.executeQuery(sb.toString());
			
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
	
	public void setProjectDetail(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			String pid = request.getParameter("pid");
			String userId = (String)request.getSession().getAttribute("userId");
			
			if ("C".equals(mode)){
				String type = request.getParameter("selType");
				String pname = Util.getEUCKR(request.getParameter("pname"));
				
				String strI = "INSERT INTO TBLSTRATPROJECT (ID,NAME,TYPEID) VALUES (?,?,?) ";
				Object[] parI = {new Integer(dbobject.getNextId("TBLSTRATPROJECT")),pname,type};
				
				dbobject.executePreparedUpdate(strI,parI);
				
				conn.commit();
				request.setAttribute("refresh", "true");
			} else if ("U".equals(mode)){
				String type = request.getParameter("selType");
				String pname = Util.getEUCKR(request.getParameter("pname"));
				
				String strU = "UPDATE TBLSTRATPROJECT SET NAME=?,TYPEID=? WHERE ID=?";
				Object[] pmU = {pname,type,pid};
				
				dbobject.executePreparedUpdate(strU,pmU);
				
				conn.commit();
				request.setAttribute("refresh", "true");
			} else if ("D".equals(mode)){
				String strD = "DELETE FROM TBLSTRATPROJECT WHERE ID=?";
				Object[] pmD = {pid};
				
				dbobject.executePreparedUpdate(strD,pmD);
				
				conn.commit();
				request.setAttribute("refresh", "true");
			}
			
			if (rs!=null){rs.close(); rs=null;}
			
			StringBuffer sbT = new StringBuffer();
			sbT.append("SELECT * FROM TBLSTRATTYPEINFO");
			
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executeQuery(sbT.toString());
			
			DataSet dsT = new DataSet();
			dsT.load(rs);
			
			request.setAttribute("dsT",dsT);
			
			if (pid!=null){
				StringBuffer sb = new StringBuffer();
				sb.append("SELECT P.ID,P.NAME,T.TYPENAME,T.TYPEID FROM TBLSTRATPROJECT P, TBLSTRATTYPEINFO T WHERE P.TYPEID = T.TYPEID AND ID=?");
				Object[] pm = {pid};
				
				if (rs!=null){rs.close();rs=null;}
				rs = dbobject.executePreparedQuery(sb.toString(),pm);
				
				DataSet ds = new DataSet();
				ds.load(rs);
				
				request.setAttribute("ds",ds);
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
	
	public void setDetailList(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;

		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			String userId = (String)request.getSession().getAttribute("userId");

			String pid = request.getParameter("projectId");
			
			
			if ("C".equals(mode)){
				String execWork = Util.getEUCKR(request.getParameter("execWork"));
				String sYear = request.getParameter("sYear");
				String sQtr = request.getParameter("sQtr");
				String eYear = request.getParameter("eYear");
				String eQtr = request.getParameter("eQtr");
				String mgr = request.getParameter("mgr");
				String define = Util.getEUCKR(request.getParameter("define"));
				String drvgoal = Util.getEUCKR(request.getParameter("drvgoal"));
				
				String mgrdept = request.getParameter("dept");
				String budget = Util.getEUCKR(request.getParameter("budget"));
				String manhour = Util.getEUCKR(request.getParameter("manhour"));
				String mng_no = request.getParameter("mng_no");
				String link = request.getParameter("link");
				
				
		            StringBuffer sbU = new StringBuffer();
		            sbU.append("INSERT INTO TBLSTRATPROJECTDETAIL (PROJECTID,DETAILID,MGRUSER,EXECWORK,DEFINE,DRVGOAL,") 
		            	.append(" REGIR,REGIDATE,SYEAR,EYEAR,SQTR,EQTR,MGRDEPT,BUDGET,MANHOUR,MNG_NO,LINKURL) VALUES (?,?,?,?,?, ?,?,SYSDATE,?,? ,?,?,?,?,?,?,?)");
		            
		            Object[] pmU = {pid,new Integer(dbobject.getNextId("TBLSTRATPROJECTDETAIL","DETAILID")),mgr,execWork,define,drvgoal,userId,sYear,eYear,sQtr,eQtr,mgrdept,budget,manhour,mng_no,link};
		            
		            dbobject.executePreparedUpdate(sbU.toString(),pmU);
		            
		            conn.commit();
		            request.setAttribute("refresh", "true");
		            request.setAttribute("msg", "true");
			} else if ("U".equals(mode)) {
				String did = request.getParameter("detailId");
				String execWork = Util.getEUCKR(request.getParameter("execWork"));
				String sYear = request.getParameter("sYear");
				String sQtr = request.getParameter("sQtr");
				String eYear = request.getParameter("eYear");
				String eQtr = request.getParameter("eQtr");
				String mgr = request.getParameter("mgr");
				String define = Util.getEUCKR(request.getParameter("define"));
				String drvgoal = Util.getEUCKR(request.getParameter("drvgoal"));
				
				String mgrdept = request.getParameter("dept");
				String budget = Util.getEUCKR(request.getParameter("budget"));
				String manhour = Util.getEUCKR(request.getParameter("manhour"));
				String mng_no = request.getParameter("mng_no");
				String link = request.getParameter("link");
				
	            StringBuffer sbU = new StringBuffer();
	            sbU.append("UPDATE TBLSTRATPROJECTDETAIL SET MGRUSER=?,EXECWORK=?,DEFINE=?,DRVGOAL=?, ") 
	            	.append(" MODIR=?,MODIDATE=SYSDATE,SYEAR=?,EYEAR=?,SQTR=?,EQTR=?,MGRDEPT=?,BUDGET=?,MANHOUR=?,MNG_NO=?,LINKURL=?   ")
	            	.append(" WHERE PROJECTID=? AND DETAILID=?");
	            Object[] pmU = {mgr,execWork,define,drvgoal,userId,sYear,eYear,sQtr,eQtr,mgrdept,budget,manhour,mng_no,link,pid,did};
	            
	            dbobject.executePreparedUpdate(sbU.toString(),pmU);
	            
	            conn.commit();
	            request.setAttribute("msg", "true");
			} else if ("D".equals(mode)) {
				String did = request.getParameter("detailId");

					StringBuffer strSQL = new StringBuffer();
					strSQL.append("SELECT  *  ") ;
					strSQL.append("FROM TBLSTRATACHVREGI  ") ;
					strSQL.append("WHERE DETAILID = ? ") ;
					Object[] pa = {did};
					rs = dbobject.executePreparedQuery(strSQL.toString(), pa);
					DataSet da2  = new DataSet();
					da2.load(rs);
					if(da2.getRowCount() == 0)
					{
						String sbD = "DELETE FROM TBLSTRATPROJECTDETAIL WHERE PROJECTID=? AND DETAILID=?";
						Object[] pmD = {pid,did};
						dbobject.executePreparedUpdate(sbD,pmD);
						conn.commit();
						request.setAttribute("msg", "true");
					}
					else
					{
						request.setAttribute("msg", "false");
					}
			}
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT D.*,D.SYEAR||'/'||'0'||D.SQTR||'-'||D.EYEAR||'/'||'0'||D.EQTR PERIOD,(SELECT USERNAME FROM TBLUSER WHERE USERID=D.MGRUSER) MGR, ") 
				.append(" (SELECT NAME FROM TBLBSC WHERE ID=D.MGRDEPT) DNAME, D.SYEAR, D.EYEAR, D.SQTR, D.EQTR ")
				.append(" FROM TBLSTRATPROJECTDETAIL D WHERE D.PROJECTID=? ");
			Object[] pm = {pid};
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
			
			String projectId = request.getParameter("projectId");
			String detailId = request.getParameter("detailId");

			String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			if ((projectId!=null)&&(detailId!=null)&&("G".equals(tag))) {
			

				StringBuffer sb = new StringBuffer();
				sb.append("SELECT D.*,(SELECT USERNAME FROM TBLUSER WHERE USERID=D.MGRUSER) MGR, ")
					.append(" (SELECT NAME FROM TBLBSC WHERE ID=D.MGRDEPT) DNAME  ")
					.append(" FROM TBLSTRATPROJECTDETAIL D WHERE D.PROJECTID=? AND D.DETAILID=? ");
				Object[] pm = {projectId,detailId};
				
				rs = dbobject.executePreparedQuery(sb.toString(),pm);
				
				DataSet ds = new DataSet();
				ds.load(rs);
				
				request.setAttribute("ds",ds);
			}
			
			String str = "SELECT U.*,(SELECT NAME FROM TBLBSC B WHERE B.ID=U.DIVCODE) DNAME FROM TBLUSER U WHERE U.GROUPID<4 ORDER BY U.USERNAME";
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executeQuery(str);
			
			DataSet dsUser = new DataSet();
			dsUser.load(rs);
			
			request.setAttribute("dsUser",dsUser);
			
			
			StringBuffer strSQLD = new StringBuffer();
			strSQLD.append("SELECT * FROM TBLBSC ") ;
			rs = dbobject.executeQuery(strSQLD.toString());
			DataSet dsD = new DataSet();
			dsD.load(rs);
			request.setAttribute("dept",dsD);
			
			
			
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
	
	
	public void getType(HttpServletRequest request, HttpServletResponse response)
	{ 
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		DataSet ds = null;
		StringBuffer type = new StringBuffer();
		StringBuffer project = new StringBuffer();
		StringBuffer field = new StringBuffer();
		StringBuffer projectDetail = new StringBuffer();
		StringBuffer iudQuery = null;
		StringBuffer prjMain = new StringBuffer();
		StrConvert sConv = new StrConvert();
		StringBuffer _prjDetail = new StringBuffer();
		
		
//		System.out.println("groupid   getParameter   " + request.getSession().getAttribute("groupId"));

		try
		{
			String idx = request.getParameter("idx")!=null?request.getParameter("idx"):"";	//IUD 구분
			String projectNmText = request.getParameter("projectNmText")!=null?request.getParameter("projectNmText"):"";;	//프로젝트명
			String iType = request.getParameter("type")!=null?request.getParameter("type"):"";	// 조회&업뎃조건용 유형 구분
			String uType = request.getParameter("typeid")!=null?request.getParameter("typeid"):"";	// 업뎃 구분 
			String iField = request.getParameter("fieldID")!=null?request.getParameter("fieldID"):"";	//조회용 분야 구분
			String projectDesTxt = request.getParameter("projectDesTxt")!=null?request.getParameter("projectDesTxt"):"";	//개요
			String projectGoal = request.getParameter("projectGoal")!=null?request.getParameter("projectGoal"):"";		//목표
			String projectID = request.getParameter("projectID")!=null?request.getParameter("projectID"):"";
			String userID = request.getParameter("userID")!=null?request.getParameter("userID"):"";		//변경자 ID
			String stepID = request.getParameter("stepID")!=null?request.getParameter("stepID"):"";		//단계
			String uField = request.getParameter("fieldIDU")!=null?request.getParameter("fieldIDU"):"";	//분야를 변경했을시  분야 구분
			
			String dtlId = request.getParameter("dtlId")!=null?request.getParameter("dtlId"):"";	//분야를 변경했을시  분야 구분
//
			//System.out.println("dtlId     " + dtlId);
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			if(idx.equals("U"))
			{

				iudQuery = new StringBuffer();

				
				
				iudQuery.append("update TBLSTRATPROJECTINFO set ");
				iudQuery.append(" PROJECTNAME = ?");
				iudQuery.append(",TYPEID = ?");
				iudQuery.append(",FIELDID = ?");
				iudQuery.append(",PROJECTDESC = ?");
				iudQuery.append(",PROJECTGOALDESC = ?");
				iudQuery.append(",MODIR = ?");
				iudQuery.append(", MODIDATE = sysdate ");
				iudQuery.append(" where PROJECTID = ?");
				iudQuery.append(" and FIELDID = ?");
				iudQuery.append(" and TYPEID = ?");


				Object params[] = {sConv.convertChar(projectNmText), uType, uField, sConv.convertChar(projectDesTxt), sConv.convertChar(projectGoal), userID, projectID, iField, iType};
				dbobject.executePreparedUpdate(iudQuery.toString(), params);
			}
			else if(idx.equals("I"))	//프로젝트 입력
			{
				iudQuery = new StringBuffer();

				
				iudQuery.append("insert into TBLSTRATPROJECTINFO ");
				iudQuery.append("(PROJECTID,");
				iudQuery.append("FIELDID,");
				iudQuery.append("TYPEID,");
				iudQuery.append("PROJECTNAME,");
				iudQuery.append("PROJECTDESC,");
				iudQuery.append("PROJECTGOALDESC,");
				iudQuery.append("REGIR, ");
				iudQuery.append("REGIDATE)values( (select nvl(max(PROJECTID)+1,1) from TBLSTRATPROJECTINFO), ");
				iudQuery.append("?,");
				iudQuery.append("?,");
				iudQuery.append("?,");
				iudQuery.append("?,");
				iudQuery.append("?,");
				iudQuery.append("?,");
				iudQuery.append("sysdate)");

				
				Object params[] = {uField, uType, sConv.convertChar(projectNmText), sConv.convertChar(projectDesTxt), sConv.convertChar(projectGoal), userID};
				dbobject.executePreparedQuery(iudQuery.toString(), params);
			}
			else if(idx.equals("D"))	//프로젝트 삭제(관련 데이터 전부 삭제)
			{

				iudQuery = null;
				iudQuery = new StringBuffer();
				iudQuery.append("delete from TBLSTRATPROJECTINFO where PROJECTID = ?");
				
				Object params[] = {projectID};
				dbobject.executePreparedQuery(iudQuery.toString(), params);


				iudQuery = null;
				iudQuery = new StringBuffer();
				iudQuery.append("delete from TBLSTRATSTEPINFO where PROJECTID = ?");
				dbobject.executePreparedQuery(iudQuery.toString(), params);

				iudQuery = null;
				iudQuery = new StringBuffer();
				iudQuery.append("delete from TBLSTRATPROJECTDETAIL where PROJECTID = ?");
				dbobject.executePreparedQuery(iudQuery.toString(), params);
			}
			else if(idx.equals("E"))	//세부실행계획 조회
			{
				if (rs!=null && ds != null){rs.close(); ds = new DataSet(); rs = null;}


//				projectDetail.append("select a.PROJECTID, ") ;
//				projectDetail.append("       c.typeid, ") ;
//				projectDetail.append("       b.stepid, ") ;
//				projectDetail.append("       b.DETAILID, ") ;
//				projectDetail.append("       c.fieldid, ") ;
//				projectDetail.append("       b.EXECWORK,                   ") ;
//				projectDetail.append("       b.DRVPERI,                   ") ;
//				projectDetail.append("       b.GOALLEV,                   ") ;
//				projectDetail.append("       b.MAINDESC,                   ") ;
//				projectDetail.append("       b.DRVMTHD,                 ") ;
//				projectDetail.append("       (select username||'('||id||')' from tbluser where id = b.MGRUSER) as MGRUSER,                 ") ;
//				projectDetail.append("       b.ERRCNSDR,                 ") ;
//				projectDetail.append("       (select trim(name)||'('||id||')' from tblbsc where id = b.MGRDEPT) as MGRDEPT ") ;
//				projectDetail.append("from TBLSTRATSTEPINFO a, TBLSTRATPROJECTDETAIL b, TBLSTRATPROJECTINFO c ") ;
//				projectDetail.append("where a.PROJECTID = " + projectID) ;
//				projectDetail.append(" and b.STEPID = " + stepID) ;
//				projectDetail.append(" and a.PROJECTID = b.PROJECTID  ") ;
//				projectDetail.append(" and a.STEPID = b.STEPID  ") ;
//				projectDetail.append(" and a.PROJECTID = c.PROJECTID ") ;
				      
				projectDetail.append("SELECT A.DETAILID,  ") ;
				projectDetail.append("       A.PROJECTID, ") ;
				projectDetail.append("       A.STEPID, ") ;
				projectDetail.append("       A.DRVMTHD, ") ;
				projectDetail.append("       A.ERRCNSDR, ") ;
				projectDetail.append("       A.EXECWORK,  ") ;
				projectDetail.append("       A.SYEAR||'.'||A.SQTR||' - '||A.EYEAR||'.'||A.EQTR as DRVPERI,  ") ;
				projectDetail.append("       A.GOALLEV, ") ;
				projectDetail.append("       A.MAINDESC, ") ;
				projectDetail.append("       (SELECT ID FROM TBLBSC WHERE ID = A.MGRDEPT) AS DEPTID,  ") ;
				projectDetail.append("       (SELECT USERID FROM TBLUSER WHERE USERID = A.MGRUSER)  AS USERID,  ") ;
				projectDetail.append("       (SELECT USERNAME FROM TBLUSER WHERE USERID = A.MGRUSER)  AS MGRUSER,  ") ;
				projectDetail.append("       (select (select name from tblbsc y where y.id = t.divcode) from tbluser t where t.USERID = A.MGRUSER) AS MGRDEPT, ") ;
				projectDetail.append("       (select count(*) from TBLSTRATPROJECTDETAIL x, TBLSTRATACHVREGI z where x.projectid = A.PROJECTID and x.DETAILID = z.DETAILID) as achvCnt ") ;
				projectDetail.append("FROM TBLSTRATPROJECTDETAIL A ") ;
				projectDetail.append("WHERE PROJECTID = ? ") ;
				projectDetail.append("AND  STEPID = ? order by A.DETAILID") ;
				



				Object[] param=null;
				
				param =	new Object[]{projectID, stepID};
				
				ds = new DataSet();
				rs = dbobject.executePreparedQuery(projectDetail.toString(), param);
				ds.load(rs);
				request.setAttribute("projectDetail",ds);
//				conn.close();
				
				if (rs!=null && ds != null){rs.close(); ds = new DataSet(); rs = null;}
				param = null;
				param = new Object[]{stepID,stepID,stepID,projectID};
				prjMain.append("select decode(?, 1, MAINDESC_1, 2, MAINDESC_2, 3, MAINDESC_3, '' ) as MAINDESC, ") ;
				prjMain.append("       decode(?, 1, DRVMTHD_1, 2, DRVMTHD_2, 3, DRVMTHD_3, '') as DRVMTHD, ") ;
				prjMain.append("       decode(?, 1, ERRCNSDR_1, 2, ERRCNSDR_2, 3, ERRCNSDR_3, '') as ERRCNSDR ") ;
				prjMain.append("from tblstratprojectinfo ") ;
				prjMain.append("where projectid = ? ") ;
				
				rs = dbobject.executePreparedQuery(prjMain.toString(), param);
				ds.load(rs);
				request.setAttribute("prjMain",ds);
			}
			else if(idx.equals("DD"))
			{
				Object param[] = {dtlId};
				
				StringBuffer strSQL = new StringBuffer();
				strSQL.append("delete from TBLSTRATPROJECTDETAIL where DETAILID = ? ") ;
				dbobject.executePreparedQuery(strSQL.toString(), param);
			}
			else if(idx.equals("PU"))
			{
				String mainDesc = request.getParameter("mainDesc");
				String drvMthd = request.getParameter("drvMth");
				String errDsc = request.getParameter("errDsc");
				StringBuffer strSQL = new StringBuffer();				

				
				if(stepID.equals("1"))
				{

					strSQL.append("update tblstratprojectinfo set ") ;
					strSQL.append("MAINDESC_1 = ?, ") ;
					strSQL.append("DRVMTHD_1 = ?, ") ;
					strSQL.append("ERRCNSDR_1 = ? ") ;
					strSQL.append("WHERE  ") ;
					strSQL.append("PROJECTID = ? ") ;
					
					Object[] param = null;
					param = new Object[]{sConv.convertChar(mainDesc), sConv.convertChar(drvMthd), sConv.convertChar(errDsc), projectID};
					dbobject.executePreparedUpdate(strSQL.toString(), param);
				}
				else if(stepID.equals("2"))
				{
					strSQL.append("update tblstratprojectinfo set ") ;
					strSQL.append("MAINDESC_2 = ?, ") ;
					strSQL.append("DRVMTHD_2 = ?, ") ;
					strSQL.append("ERRCNSDR_2 = ? ") ;
					strSQL.append("WHERE  ") ;
					strSQL.append("PROJECTID = ? ") ;
					
					Object[] param = null;
					param = new Object[]{mainDesc, drvMthd, errDsc, projectID};
					dbobject.executePreparedUpdate(strSQL.toString(), param);
				}
				else if(stepID.equals("3"))
				{
					strSQL.append("update tblstratprojectinfo set ") ;
					strSQL.append("MAINDESC_3 = ?, ") ;
					strSQL.append("DRVMTHD_3= ?, ") ;
					strSQL.append("ERRCNSDR_3 = ? ") ;
					strSQL.append("WHERE  ") ;
					strSQL.append("PROJECTID = ? ") ;
					
					Object[] param = null;
					param = new Object[]{mainDesc, drvMthd, errDsc, projectID};
					dbobject.executePreparedUpdate(strSQL.toString(), param);
				}
			}
			
			
			if (rs!=null && ds != null){rs.close(); ds = new DataSet(); rs = null;}
			
			
			Object param[] = {};
			type.append("select * from tblstrattypeinfo");
			project.append("select * from TBLSTRATPROJECTINFO");
			field.append("select * from TBLSTRATFIELDINFO");
			_prjDetail.append("SELECT A.PROJECTID,   ") ;
			_prjDetail.append("       A.PROJECTNAME,   ") ;
			_prjDetail.append("       A.PROJECTDESC,   ") ;
			_prjDetail.append("       A.PROJECTGOALDESC,    ") ;
			_prjDetail.append("       B.TYPEID,   ") ;
			_prjDetail.append("       B.TYPENAME,   ") ;
			_prjDetail.append("       C.FIELDID,  ") ;
			_prjDetail.append("       C.FIELDNAME, ") ;
			_prjDetail.append("       (select count(*) from TBLSTRATPROJECTDETAIL where PROJECTID = a.PROJECTID) as dtlCnt, ") ;
			_prjDetail.append("       (select count(*) from TBLSTRATPROJECTDETAIL x, TBLSTRATACHVREGI z where x.projectid = A.PROJECTID and x.DETAILID = z.DETAILID) as achvCnt ") ;
			_prjDetail.append("FROM TBLSTRATPROJECTINFO A, TBLSTRATTYPEINFO B, TBLSTRATFIELDINFO C  ") ;
			_prjDetail.append("WHERE A.TYPEID = B.TYPEID  ") ;
			_prjDetail.append("AND A.FIELDID = C.FIELDID ") ;


 
			
			rs = dbobject.executePreparedQuery(type.toString(), param);
			ds = new DataSet();
			ds.load(rs);
			request.setAttribute("type", ds);

			if (rs!=null && ds != null){rs.close(); ds = new DataSet(); rs = null;}
			rs = dbobject.executePreparedQuery(project.toString(), param);
			ds = new DataSet();
			ds.load(rs);
			request.setAttribute("project", ds);


			if (rs!=null && ds != null){rs.close(); ds = new DataSet(); rs = null;}
			rs = dbobject.executePreparedQuery(field.toString(), param);
			ds = new DataSet();
			ds.load(rs);
			request.setAttribute("field", ds);

			if (rs!=null && ds != null){rs.close(); ds = new DataSet(); rs = null;}
//			System.out.println(_prjDetail.toString());
			rs = dbobject.executePreparedQuery(_prjDetail.toString(), null);
			ds = new DataSet();
			ds.load(rs);
			request.setAttribute("_prjDetail", ds); 
			
			

			
			conn.commit();

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




	public void taskAdminDetail(HttpServletRequest request, HttpServletResponse response)	//projectDetail insert
	{
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		DataSet ds = null;
		StringBuffer strSQL = null;
		StringBuffer strUpdate = null;
		StringBuffer strInsert = null;
		StrConvert	sConv = new StrConvert();
		
		String div = request.getParameter("div1")!=null?request.getParameter("div1"):"";
		String execwork = request.getParameter("_execwork")!=null?request.getParameter("_execwork"):"";
		
		String sYear = request.getParameter("sYear")!=null?request.getParameter("sYear"):"";
		String eYear = request.getParameter("eYear")!=null?request.getParameter("eYear"):"";
		String sQtr = request.getParameter("sQtr")!=null?request.getParameter("sQtr"):"";
		String eQtr = request.getParameter("eQtr")!=null?request.getParameter("eQtr"):"";
		
		
		String drvperi = request.getParameter("_drvperi")!=null?request.getParameter("_drvperi"):"";
		String mgrdeptid = request.getParameter("_mgrdept_I")!=null?request.getParameter("_mgrdept_I"):"";
		String goallev = request.getParameter("_goallev")!=null?request.getParameter("_goallev"):"";
		String maindesc = request.getParameter("_maindesc")!=null?request.getParameter("_maindesc"):"";
		String regir = (String)request.getSession().getAttribute("userId");
		String stepID = request.getParameter("_stepID")!=null?request.getParameter("_stepID"):"";
		String detailid = request.getParameter("_detailid")!=null?request.getParameter("_detailid"):"";
        String projectID = request.getParameter("_projectID")!=null?request.getParameter("_projectID"):"";
        String mgruser = request.getParameter("_mgruser")!=null?request.getParameter("_mgruser"):"";
        String drvmthd = request.getParameter("_projectID")!=null?request.getParameter("_drvmthd"):"";
        String errcnsdr = request.getParameter("_projectID")!=null?request.getParameter("_errcnsdr"):"";


		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null)
				dbobject = new DBObject(conn.getConnection());
			
			ds = new DataSet();
			strSQL = new StringBuffer();
			strSQL.append("select id, name from tblbsc ") ;	//부서

			rs = dbobject.executePreparedQuery(strSQL.toString(), null);
			ds.load(rs);
			request.setAttribute("detail",ds);

			strSQL = new StringBuffer();
			ds = null;
			ds = new DataSet();
			strSQL.append("select USERID, USERNAME from tbluser where groupid=3");	//담당자 
//			System.out.println(strSQL);
			rs = dbobject.executePreparedQuery(strSQL.toString(), null);
			ds.load(rs);
			request.setAttribute("user",ds);
			
			
			
			
			if(div.equals("DU"))	//세부실행계획 수정
			{
				
				strUpdate = new StringBuffer();

				if (rs!=null && ds != null){rs.close(); ds = new DataSet(); rs = null;}	//reset ResultSet, DataSet

				strUpdate.append("update TBLSTRATPROJECTDETAIL ") ;
				strUpdate.append("set EXECWORK = '" + sConv.convertChar(execwork) + "',") ;
				strUpdate.append("    GOALLEV = '" + sConv.convertChar(goallev) + "',") ;
//				strUpdate.append("    MGRDEPT = '" + mgrdeptid + "',") ;
				strUpdate.append("    MODIR = '" + regir + "',") ;
				strUpdate.append("    MODIDATE = sysdate, ") ;
				strUpdate.append("    SQTR = " + sQtr + ",") ;
				strUpdate.append("    EQTR = " + eQtr + ",") ;
				strUpdate.append("    SYEAR = '" + sYear.trim() + "',") ;
				strUpdate.append("    EYEAR = '" + eYear.trim() + "'") ;
				strUpdate.append("where DETAILID = " + detailid) ;
				
				
//				strUpdate.append("update TBLSTRATPROJECTDETAIL ") ;
//				strUpdate.append("set EXECWORK = ?,  ") ;
//				strUpdate.append("    GOALLEV = ?,  ") ;
//				strUpdate.append("    MAINDESC = ?,  ") ;
//				strUpdate.append("    DRVMTHD = ?,  ") ;
//				strUpdate.append("    ERRCNSDR = ?,  ") ;
//				strUpdate.append("    MODIR = ?, ") ;
//				strUpdate.append("    MODIDATE = sysdate, ") ;
//				strUpdate.append("    SQTR = ?,  ") ;
//				strUpdate.append("    EQTR = ?,  ") ;
//				strUpdate.append("    SYEAR = ?,  ") ;
//				strUpdate.append("    EYEAR = ?  ") ;
//				strUpdate.append("where DETAILID = ? ") ;
				
				
				
				
//				Object param[] = {execwork,  
//								  goallev, 
//								  maindesc, 
//								  drvmthd, 
//								  errcnsdr, 
//								  regir,  
//								  sQtr, 
//								  eQtr, 
//								  sYear, 
//								  eYear,
//								  detailid};
				dbobject.executeUpdate(strUpdate.toString());
//				dbobject.executePreparedQuery(strUpdate.toString(), param);
//				dbobject.executePreparedUpdate(strUpdate.toString(), param);
				conn.commit();

			}
			else if(div.equals("DI"))	//세부실행계획 추가
			{
			      strInsert = new StringBuffer();
			      String mgrdept = request.getParameter("_mgrdept_I")!=null?request.getParameter("_mgrdept_I"):"";
//			      System.out.println(mgrdept);
			      
			      if (rs!=null && ds != null){rs.close(); ds = new DataSet(); rs = null;}	//reset ResultSet
                        
                        strInsert.append("insert into tblstratprojectdetail (PROJECTID,  ") ;
                        strInsert.append("                                   STEPID,  ") ;
                        strInsert.append("                                   DETAILID,  ") ;
                        strInsert.append("                                   MGRUSER,  ") ;
                        strInsert.append("                                   EXECWORK,  ") ;
                        strInsert.append("                                   GOALLEV,  ") ;
                        strInsert.append("                                   MAINDESC,  ") ;
                        strInsert.append("                                   DRVMTHD,  ") ;
                        strInsert.append("                                   ERRCNSDR,  ") ;
                        strInsert.append("                                   REGIR,  ") ;
//                        strInsert.append("                                   MGRDEPT,  ") ;
                        strInsert.append("                                   SQTR,  ") ;
                        strInsert.append("                                   EQTR,  ") ;
                        strInsert.append("                                   SYEAR,  ") ;
                        strInsert.append("                                   EYEAR ") ;
                        strInsert.append("                                   )values( ") ;
                        strInsert.append("                                   ?, ") ;
                        strInsert.append("                                   ?, ") ;
                        strInsert.append("                                   (select nvl(max(DETAILID)+1, 1) from TBLSTRATPROJECTDETAIL),") ;
                        strInsert.append("                                   ?, ") ;
                        strInsert.append("                                   ?, ") ;
                        strInsert.append("                                   ?, ") ;
                        strInsert.append("                                   ?, ") ;
                        strInsert.append("                                   ?, ") ;
                        strInsert.append("                                   ?, ") ;
                        strInsert.append("                                   ?, ") ;
//                        strInsert.append("                                   ?, ") ;
                        strInsert.append("                                   ?, ") ;
                        strInsert.append("                                   ?, ") ;
                        strInsert.append("                                   ?, ") ;
                        strInsert.append("                                   ? ") ;
                        strInsert.append("                                   ) ") ;
                        
                        
                		Object paramI[] = {projectID, 
								           stepID, 
								           mgruser, 
								           sConv.convertChar(execwork),
								           sConv.convertChar(goallev), 
								           maindesc,
								           drvmthd,
								           errcnsdr,
								           regir,
//								           mgrdept, 
								           sQtr, 
								           eQtr,
								           sYear, 
								           eYear, 
						                 };
        				dbobject.executePreparedQuery(strInsert.toString(), paramI);
        				conn.commit();
        				//conn.close();
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
	
	

	public void setDtlWork(HttpServletRequest request, HttpServletResponse response)
	{
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			String did = request.getParameter("did");

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT W.DETAILID,W.DTLID,W.SYEAR,W.EYEAR,W.SQTR,W.EQTR,W.DTLNAME,W.DEFINE, ")
				.append(" (SELECT NAME FROM TBLBSC WHERE ID=W.MGRDEPT) DNAME,W.MGRDEPT, ")
				.append(" (SELECT USERNAME FROM TBLUSER WHERE USERID=W.MGRUSER) MGRNAME,W.MGRUSER, W.WEIGHT FROM TBLSTRATWORK W WHERE DETAILID=?") ;

			Object[] pa = {did};
			rs = dbobject.executePreparedQuery(sb.toString(), pa);
			
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
	}//-- method setDtlWork


	
	
	public void setDtlTak(HttpServletRequest request, HttpServletResponse response)
	{
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		String deptid = "";
		String mgruser= "";
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String dtlid = request.getParameter("dtlid");
			String mode = request.getParameter("mode")==null?"":request.getParameter("mode");
			String sqtr = request.getParameter("_sQtr");
			String eqtr = request.getParameter("_eQtr");
			String syear = request.getParameter("syear");
			String eyear = request.getParameter("eyear");
			String dtlname = Util.getEUCKR(request.getParameter("dtlname"));
			String detailid = request.getParameter("did");
			String userid = (String)request.getSession().getAttribute("userId");
			mgruser = request.getParameter("mgruser");
			deptid = request.getParameter("dept");
			String define = Util.getEUCKR(request.getParameter("define"));
			String weight = request.getParameter("weight");
			
			define = define.replaceAll("<br>","\n");
			//System.out.println("define:"+define);
			if(mode.equals("C")) {
				StringBuffer strSQL = new StringBuffer();
				strSQL.append("INSERT INTO TBLSTRATWORK (DETAILID, DTLID, SYEAR, EYEAR, SQTR, EQTR, REGIR, DTLNAME, MGRDEPT, MGRUSER, REGIDATE,DEFINE, WEIGHT ")
					.append(" ) VALUES (?,?,?,?,?,   ?,?,?,?,?,  SYSDATE,?,?) ");
				
				
				Object[] pa = {detailid,new Integer(dbobject.getNextId("TBLSTRATWORK","DTLID")), syear, eyear, sqtr, eqtr,userid, dtlname, deptid, mgruser,define,weight};
				dbobject.executePreparedUpdate(strSQL.toString(), pa);
				conn.commit();
				
				//System.out.println("insert work :"+dtlname);
			} else if(mode.equals("U")) {
				
				StringBuffer strSQL = new StringBuffer();
				strSQL.append("UPDATE TBLSTRATWORK SET SYEAR=?,EYEAR=?,SQTR=?,EQTR=?,MODIR=?,MODIDATE=SYSDATE,DTLNAME=?,MGRDEPT=?,MGRUSER=?,DEFINE=?,WEIGHT=? ")
					.append(" WHERE DTLID=?");
		

				
				Object[] pa = {syear, eyear, sqtr, eqtr,userid,dtlname, deptid, mgruser,define,weight,dtlid};
				dbobject.executePreparedUpdate(strSQL.toString(), pa);
				conn.commit();
			} else if(mode.equals("D")) {
				StringBuffer strSQLS = new StringBuffer();
				strSQLS.append("select * from TBLSTRATWORKACHV  ") ;
				strSQLS.append("where dtlid = ? ") ;
				Object[] paS = {dtlid};
				rs = dbobject.executePreparedQuery(strSQLS.toString(), paS);
				DataSet dsS = new DataSet();
				dsS.load(rs);
				int rowCnt = dsS.getRowCount();
				if(rowCnt > 0)
				{
					request.setAttribute("msg", "관련 정보가 있어 삭제할 수 없습니다.");
				}
				else
				{
				
					StringBuffer strSQL = new StringBuffer();
					strSQL.append("delete from TBLSTRATWORK where dtlid = ? ") ;
					
					Object[] pa = {dtlid};
					dbobject.executePreparedUpdate(strSQL.toString(), pa);
					conn.commit();
				}
			}
				
			
			
			StringBuffer strSQL = new StringBuffer();
			strSQL.append("SELECT * FROM TBLSTRATPROJECTDETAIL D, TBLSTRATPROJECT P WHERE D.PROJECTID=P.ID AND D.DETAILID=?") ;

			Object[] pa2 = {detailid};
			rs = dbobject.executePreparedQuery(strSQL.toString(), pa2);
			
			DataSet ds2 = new DataSet();
			ds2.load(rs);
			request.setAttribute("ds2",ds2);
			
			StringBuffer strSQLD = new StringBuffer();
			strSQLD.append("SELECT * FROM TBLBSC ") ;
			rs = dbobject.executeQuery(strSQLD.toString());
			DataSet dsD = new DataSet();
			dsD.load(rs);
			request.setAttribute("dept",dsD);
			
			
			StringBuffer user = new StringBuffer();
			user.append("select userid, username, divcode as parent  ") ;
			user.append("from tbluser  ") ;
			user.append("order by username ") ;
			rs = dbobject.executeQuery(user.toString());
			DataSet userDs = new DataSet();
			userDs.load(rs);
			request.setAttribute("user",userDs);
			
			
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
	}//-- method setDtlTak
	
	public void setProjectType(HttpServletRequest request, HttpServletResponse response)
	{
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			String userId = (String)request.getSession().getAttribute("userId");
			if (userId==null) return;
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			if ("C".equals(mode)){
				String name = Util.getEUCKR(request.getParameter("name"));
				
				String strI = "INSERT INTO TBLSTRATTYPEINFO (TYPEID,TYPENAME,REGIR,REGIDATE) VALUES (?,?,?,SYSDATE)";
				Object[] pmI = {new Integer(dbobject.getNextId("TBLSTRATTYPEINFO","TYPEID")),name,userId};
				
				dbobject.executePreparedUpdate(strI,pmI);
				
				conn.commit();
			} else if ("U".equals(mode)) {
				String name = Util.getEUCKR(request.getParameter("name"));
				String id = request.getParameter("id");
				
				String strU = "UPDATE TBLSTRATTYPEINFO SET TYPENAME=?,MODIR=?,MODIDATE=SYSDATE WHERE TYPEID=?";
				Object[] pmU = {name,userId,id};
				
				dbobject.executePreparedUpdate(strU,pmU);
				
				conn.commit();
			} else if ("D".equals(mode)) {
				String id = request.getParameter("id");
				
				String strD = "DELETE FROM TBLSTRATTYPEINFO WHERE TYPEID=?";
				Object[] pmD = {id};
				
				dbobject.executePreparedUpdate(strD,pmD);
				
				conn.commit();
			}
			
			
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT * FROM TBLSTRATTYPEINFO  ") ;


			rs = dbobject.executeQuery(sb.toString());
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			System.out.println(se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			System.out.println(e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}
	}//-- method setDtlWork
	
	

}	//-- class TaskAdmin
