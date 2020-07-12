package com.nc.task;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.sql.CoolConnection;
import com.nc.util.*;
import com.nc.cool.CoolServer;

public class TaskActualUtil  {
	public void taskActualList(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			String userId = (String)request.getSession().getAttribute("userId");
			String userGrp = (String)request.getSession().getAttribute("groupId");
			String pid = request.getParameter("pid");

			if (pid==null) return;
			

			StringBuffer sb = new StringBuffer();
			if(!userGrp.equals("1")) {
				sb.append(" SELECT D.*,''''||substr(D.SYEAR,3,4)||'/'||'0'||D.SQTR||'-'||''''||substr(D.EYEAR, 3,4)||'/'||'0'||D.EQTR PERIOD  ")
		         .append(" FROM TBLSTRATPROJECTDETAIL D WHERE D.PROJECTID=?  ")
		         .append(" AND DETAILID IN (SELECT DETAILID FROM TBLSTRATWORK WHERE MGRUSER=?) ");
				Object[] pm = {pid, userId};
				rs = dbobject.executePreparedQuery(sb.toString(),pm);
			} else {
				sb.append(" SELECT D.*,''''||substr(D.SYEAR,3,4)||'/'||'0'||D.SQTR||'-'||''''||substr(D.EYEAR, 3,4)||'/'||'0'||D.EQTR PERIOD  ")
		         .append(" FROM TBLSTRATPROJECTDETAIL D WHERE D.PROJECTID=?  ")
		         .append(" AND DETAILID IN (SELECT DETAILID FROM TBLSTRATWORK ) ");
				Object[] pm = {pid};
				rs = dbobject.executePreparedQuery(sb.toString(),pm);
			}
			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

			String str = "SELECT * FROM TBLSTRATPROJECT WHERE ID=?";

			if (rs!=null) {rs.close(); rs=null;}
			Object[] pm = {pid};
			rs = dbobject.executePreparedQuery(str,pm);

			DataSet dsP = new DataSet();
			dsP.load(rs);

			request.setAttribute("dsP",dsP);

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

	
	
	public void setProject(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			String userId = (String)request.getSession().getAttribute("userId");
			String userGrp = (String)request.getSession().getAttribute("groupId");
			

			StringBuffer sb = new StringBuffer();
			if(!userGrp.equals("1")) {
				sb.append(" SELECT P.ID PID,P.NAME PNAME, P.TYPEID, T.TYPENAME FROM TBLSTRATPROJECT P, TBLSTRATTYPEINFO T WHERE P.TYPEID=T.TYPEID  ")
		         .append(" AND P.ID IN ( ")
		         .append(" SELECT PROJECTID FROM ")
		         .append(" (SELECT * FROM TBLSTRATPROJECTDETAIL) DTL ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT DETAILID WDID,DTLID WID,SYEAR WSYEAR,EYEAR WEYEAR,SQTR WSQTR,EQTR WEQTR,DTLNAME,MGRDEPT WMGRDETP,MGRUSER WMGRUSER, DEFINE WEDEFINE FROM TBLSTRATWORK) WRK ")
		         .append(" ON DTL.DETAILID=WRK.WDID ")
		         .append(" WHERE WMGRUSER=? ")
		         .append(" ) ORDER BY TYPEID, PID ");

				Object[] pa = {userId};
				rs = dbobject.executePreparedQuery(sb.toString(), pa);
			} else {
				sb.append(" SELECT P.ID PID,P.NAME PNAME, P.TYPEID, T.TYPENAME FROM TBLSTRATPROJECT P, TBLSTRATTYPEINFO T WHERE P.TYPEID=T.TYPEID  ")
		         .append(" AND P.ID IN ( ")
		         .append(" SELECT PROJECTID FROM ")
		         .append(" (SELECT * FROM TBLSTRATPROJECTDETAIL) DTL ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT DETAILID WDID,DTLID WID,SYEAR WSYEAR,EYEAR WEYEAR,SQTR WSQTR,EQTR WEQTR,DTLNAME,MGRDEPT WMGRDETP,MGRUSER WMGRUSER, DEFINE WEDEFINE FROM TBLSTRATWORK) WRK ")
		         .append(" ON DTL.DETAILID=WRK.WDID ")
		         .append(" ")
		         .append(" ) ORDER BY TYPEID, PID ");
				
				rs = dbobject.executeQuery(sb.toString());
			}
			
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
	
	public void taskDetail(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());

			StringBuffer sbType = new StringBuffer();
			sbType.append("SELECT TYPEID,TYPENAME FROM TBLSTRATTYPEINFO");

			rs = dbobject.executeQuery(sbType.toString());

			DataSet dsType = new DataSet();
			dsType.load(rs);

			request.setAttribute("dsType",dsType);

			StringBuffer sbProj = new StringBuffer();
			sbProj.append("SELECT ID,NAME,TYPEID FROM TBLSTRATPROJECT ");

			if (rs!=null){rs.close(); rs=null;}

			rs = dbobject.executeQuery(sbProj.toString());

			DataSet dsProj = new DataSet();
			dsProj.load(rs);

			request.setAttribute("dsProj",dsProj);

		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			request.setAttribute("result","false");
			System.out.println(this.toString()+":"+se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			request.setAttribute("result","false");
			System.out.println(this.toString()+":"+e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}
	}


    public void taskActual(HttpServletRequest request, HttpServletResponse response)  {

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
    	try{
    		String projectId = request.getParameter("projectId");
    		
    		if (projectId==null) return;
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
    		StringBuffer str1 = new StringBuffer();
    		str1.append("SELECT * FROM ")
    			.append(" (SELECT D.DETAILID,D.PROJECTID,D.EXECWORK,D.DEFINE,D.DRVGOAL, ")
    			.append(" ''''||substr(D.SYEAR,3,4)||'/'||'0'||D.SQTR||'-'||''''||substr(D.EYEAR, 3,4)||'/'||'0'||D.EQTR PERIOD ")
    			.append(" FROM TBLSTRATPROJECTDETAIL D WHERE D.PROJECTID=?) DTL ")
    			.append(" LEFT JOIN ")
    			.append(" (SELECT W.DETAILID WDID,W.DTLID WID,''''||substr(W.SYEAR,3,4)||'/'||'0'||W.SQTR||'-'||''''||substr(W.EYEAR, 3,4)||'/'||'0'||W.EQTR WPERIOD, ")
    			.append(" W.DTLNAME,W.DEFINE WDEFINE FROM TBLSTRATWORK W ) WRK ")
    			.append(" ON DTL.DETAILID=WRK.WDID ");
    		Object[] pm1 ={projectId};
    		
    		rs = dbobject.executePreparedQuery(str1.toString(),pm1);
    		
    		DataSet dsD = new DataSet();
    		dsD.load(rs);
    		
    		request.setAttribute("dsD",dsD);
    		
    		String str = "SELECT P.ID,P.NAME,T.TYPENAME FROM TBLSTRATPROJECT P, TBLSTRATTYPEINFO T WHERE P.TYPEID=T.TYPEID AND ID=?";
    		if (rs!=null){rs.close(); rs=null;}
    		
    		rs = dbobject.executePreparedQuery(str,pm1);
    		
    		DataSet dsP = new DataSet();
    		
    		dsP.load(rs);
    		
    		request.setAttribute("dsP",dsP);
    		
    		
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



    }	//method taskActual


    public void taskActualCombo(HttpServletRequest request, DBObject dbo)
    {

    	DataSet ds = null;
    	ResultSet rs = null;
    	StringBuffer type = null;
    	StringBuffer project = null;
    	StringBuffer field = null;



    	try
    	{

			Object param[] = {};
			type = new StringBuffer();
			field = new StringBuffer();
			project = new StringBuffer();
			type.append("select * from tblstrattypeinfo");
			project.append("select * from TBLSTRATPROJECTINFO");
			field.append("select * from TBLSTRATFIELDINFO");

			rs = dbo.executePreparedQuery(type.toString(), param);
			ds = new DataSet();
			ds.load(rs);
			System.out.println("typeAll    :" + ds);
			request.setAttribute("typeAll", ds);

			if (rs!=null && ds != null){rs.close(); ds = new DataSet(); rs = null;}
			rs = dbo.executePreparedQuery(project.toString(), param);
			ds = new DataSet();
			ds.load(rs);
			System.out.println("projectAll    :" + ds);
			request.setAttribute("projectAll", ds);


			if (rs!=null && ds != null){rs.close(); ds = new DataSet(); rs = null;}
			rs = dbo.executePreparedQuery(field.toString(), param);
			ds = new DataSet();
			ds.load(rs);
			System.out.println("fieldAll   :" + ds);
			request.setAttribute("fieldAll", ds);

		}catch (SQLException se){
			request.setAttribute("result","false");
			System.out.println(se);
		} catch (Exception e){
			request.setAttribute("result","false");
			System.out.println(e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
		}


    }	//--method taskActualCombo



    public void taskActualQtr(HttpServletRequest request, HttpServletResponse response)
    {
    	DBObject dbobject = null;
		CoolConnection conn = null;
		ResultSet rs = null;
		try{

			String dtlid = request.getParameter("dtlid");
			String year = request.getParameter("year");

			String userId = (String)request.getSession().getAttribute("userId");
			
			if ((dtlid==null)) return;

    		conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
    		conn.createStatement(false);

    		if (dbobject==null) dbobject = new DBObject(conn.getConnection());

    		String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";

    		if ("U".equals(mode)) {

    			String strU = "UPDATE TBLSTRATWORKACHV SET QTRGOAL=?,QTRACHV=?,REALIZE=?,MODIR=?,MODIDATE=SYSDATE WHERE DTLID=? AND YEAR=? AND QTR=?";
    			Object[] pmU = {null,null,null,userId,dtlid,year,null};

    			String strI = "INSERT INTO TBLSTRATWORKACHV (DTLID,ACHVID,YEAR,QTR,QTRGOAL,QTRACHV,REALIZE,REGIR,REGIDATE) VALUES (?,?,?,?,?, ?,?,?,SYSDATE)";
    			Object[] pmI = {dtlid,null,year,null,null,null,null,userId};

    			String strD = "DELETE FROM TBLSTRATWORKACHV WHERE DTLID=? AND YEAR=? and QTR=?";
    			Object[] pmD = {dtlid, year, null};
    			for (int i = 0; i < 4; i++) 
    			{
					String goal = request.getParameter("qtrGoal"+(i+1));
					String actual = request.getParameter("qtrAchv"+(i+1));
					double rel = 0;
					
					if ((goal!=null)&&(actual!=null)){	//둘다 값이 있을때.
						if ((!"".equals(goal))&&(!"".equals(actual))){
							if(goal.equals("0"))
								rel =  Common.round(Double.parseDouble(actual)/Double.parseDouble("1") *100,3);
							else
								rel =  Common.round(Double.parseDouble(actual)/Double.parseDouble(goal) *100,3);
								
						}
					}
					
    				pmU[0]=goal;
    				pmU[1]=actual;
    				pmU[2]=new Double(rel);
    				pmU[6]=String.valueOf(i+1);
    				pmD[2]=String.valueOf(i+1);
    				
					if(goal.equals("") && actual.equals("")) {
						dbobject.executePreparedUpdate(strD, pmD);
					} else {
	    				if (dbobject.executePreparedUpdate(strU,pmU)<1) {
	    					pmI[1]=new Integer(dbobject.getNextId("TBLSTRATWORKACHV","ACHVID"));
	    					pmI[3]=String.valueOf(i+1);
	    					pmI[4]=goal;
	    					pmI[5]=actual;
	    					pmI[6]=new Double(Common.numRound(String.valueOf(rel), 2));	//폼에서 받은 실 데이터로 계산을 하고 저장할때 반올림한다.  
	    					
	    					dbobject.executePreparedUpdate(strI,pmI);
	    				}
					}
				}

    			taskActualCalc(year, dtlid, dbobject, request, userId);
    		} else if ("D".equals(mode)){

    			String strD = "DELETE FROM TBLSTRATACHVREGI WHERE DETAILID=? AND YEAR=?";
    			Object[] pmD = {dtlid,year};

    			dbobject.executePreparedUpdate(strD,pmD);
    		}

    		StringBuffer qtr = new StringBuffer();
    			
    		qtr.append("SELECT DTLID,ACHVID,YEAR,QTR, round(QTRGOAL,2) as QTRGOAL, round(QTRACHV, 2) as QTRACHV,  round(REALIZE,2) as REALIZE,  REGIR ")  
    				.append(" FROM TBLSTRATWORKACHV  WHERE DTLID=?  AND YEAR=? ")
    				.append(" ORDER BY QTR ") ;

			Object[] pm = {dtlid,year};

			rs = dbobject.executePreparedQuery(qtr.toString(), pm);
			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds", ds);
    		
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
			if (dbobject !=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}


    }// method taskActualQtr

    public void taskActualCalc(String year, String detailid, DBObject dbobj, HttpServletRequest request, String userid) 
    {
    	DataSet ds = new DataSet();
    	
    	ResultSet rs = null;
    	double realize = 0;
    	ArrayList calc = new ArrayList();
    	int rowCnt = 0;
    	int count = 0;
    	try{
    		
    		String detailidp = request.getParameter("detailid");
        	StringBuffer strSQL = new StringBuffer();
//        	StringBuffer strSQL = new StringBuffer();
        	strSQL.append("select b.* from TBLSTRATWORK a, TBLSTRATWORKACHV b ") ;
        	strSQL.append("where a.detailid = ? ") ;
        	strSQL.append("and a.dtlid = b.dtlid ") ;
        	strSQL.append("and b.year = ? ") ;
        	strSQL.append("and b.qtr = ? ") ;
        	strSQL.append("and ? between a.syear||a.sqtr and a.eyear||a.eqtr ") ;

        	
        	for(int i = 1; i <= 4; i++)
        	{
        		Object[] pa = {detailidp, year, String.valueOf(i), year+String.valueOf(i)};
        		rs = dbobj.executePreparedQuery(strSQL.toString(), pa);
        		ds.load(rs);
        		rowCnt = ds.getRowCount()==0?1:ds.getRowCount();
        		if(ds != null)
        		{
        			while(ds.next())
        			{
        				double value = ds.isEmpty("REALIZE")?0:ds.getDouble("REALIZE");
        				realize  = realize + value;
        			}
        			
        			calc.add(String.valueOf(realize/rowCnt));
        		}
        		
        		count++;
        		realize = 0;
        	}
        	
        	StringBuffer strSQLU = new StringBuffer();
        	strSQLU.append("update TBLSTRATACHVREGI set REALIZE = round(to_number(?),2), modir = ?, modidate = sysdate  ") ;
        	strSQLU.append("where DETAILID = ?  ") ;
        	strSQLU.append("and YEAR = ? ") ;
        	strSQLU.append("and qtr = ? ") ;
        	
        	StringBuffer strSQLI = new StringBuffer();
        	strSQLI.append("insert into TBLSTRATACHVREGI (ACHVID, DETAILID, REALIZE, YEAR, QTR, REGIR  ") ;
        	strSQLI.append("                                )values( ") ;
        	strSQLI.append("                               (select nvl(max(ACHVID)+1, 1) from TBLSTRATACHVREGI), ") ;
        	strSQLI.append("                               ?, ") ;
        	strSQLI.append("                               round(to_number(?),2), ") ;
        	strSQLI.append("                               ?, ") ;
        	strSQLI.append("                               ?, ") ;
        	strSQLI.append("                               ? ") ;
        	strSQLI.append("                               ) ") ;

        	
        	
        	for(int i = 0; i < calc.size();i++)
        	{
        		String real = String.valueOf(calc.get(i));
        		Object[] paU2 = {real, userid, detailidp, year, String.valueOf(i+1)} ;
        		
        		if(dbobj.executePreparedUpdate(strSQLU.toString(), paU2) <1)
        		{
        			Object[] paI2 = {detailidp, real, year, String.valueOf(i+1), userid} ;
        			dbobj.executePreparedUpdate(strSQLI.toString(), paI2);
        			//System.out.println(String.valueOf(calc.get(i)));
        		}
        	}
        	    		
		}catch (SQLException se){
			request.setAttribute("result","false");
			System.out.println(se);
		} catch (Exception e){
			request.setAttribute("result","false");
			System.out.println(e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
		}
    	


    	
    	
    }
    

    public void taskActualUpload(HttpServletRequest request, HttpServletResponse response) 
    {
		ResultSet rs = null;
		CoolConnection conn = null;
		DBObject dbobject = null;


//		String did = (String) request.getAttribute("did");
//		String qtr = (String) request.getAttribute("qtr");
//		String year = (String) request.getAttribute("year");
//		String typeid = (String) request.getAttribute("typeid");
//		String fileNM = (String) request.getAttribute("fileNM");


		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
    		conn.createStatement(false);

    		
    		String did = (String) request.getAttribute("did");
    		String qtr = (String) request.getAttribute("qtr");
    		String year = (String) request.getAttribute("year");
    		String typeid = (String) request.getAttribute("typeid");
    		String fileNM_i = (String) request.getAttribute("fileNM");
    		String fileNM_u = (String) request.getAttribute("fileNM");
    		String userid = (String)request.getSession().getAttribute("userId");
    		String dbFile = "";
    		
     		dbobject = new DBObject(conn.getConnection());

    		if(typeid.equals("1"))
    		{
    			
    			StringBuffer strSQLc = new StringBuffer();
    			strSQLc.append("SELECT * FROM TBLSTRATWORKACHV WHERE DTLID=? AND YEAR=? and qtr=? ") ;
				Object[] pm = {did, year, qtr};
				rs = dbobject.executePreparedQuery(strSQLc.toString(), pm);
				DataSet ds = new DataSet();
				ds.load(rs);
				if(ds != null)
				{
					while(ds.next())
					{
						dbFile = ds.isEmpty("FILEPATH")?"":ds.getString("FILEPATH");
					}
				}
    			if(!dbFile.equals(""))	//기존에 있던 파일에 새로운 파일 추가.
    			{
    				fileNM_u =  dbFile + "|" + fileNM_u;
    			}
    			
    			String stU = "update TBLSTRATWORKACHV set FILEPATH = ?, modir=?, modidate = sysdate where dtlid = ? and year = ? and qtr = ?";
    			StringBuffer strSQL = new StringBuffer();
    			strSQL.append("insert into TBLSTRATWORKACHV ( ") ;
    			strSQL.append("                                DTLID,  ") ;
    			strSQL.append("                                ACHVID,  ") ;
    			strSQL.append("                                YEAR,  ") ;
    			strSQL.append("                                QTR,  ") ;
    			strSQL.append("                                FILEPATH,  ") ;
    			strSQL.append("                                REGIR ") ;
    			strSQL.append("                            )values( ") ;
    			strSQL.append("                                ?, ") ;
    			strSQL.append("                                (select nvl(max(ACHVID)+1, 1) from TBLSTRATWORKACHV), ") ;
    			strSQL.append("                                ?, ") ;
    			strSQL.append("                                ?, ") ;
    			strSQL.append("                                ?, ") ;
    			strSQL.append("                                ? ") ;
    			strSQL.append("                            ) ") ;

    			Object[] paU = {fileNM_u, userid, did, year, qtr};
    			Object[] paI = {did, year, qtr, fileNM_i, userid};
    			
    			int udp = dbobject.executePreparedUpdate(stU,paU);
	    		if (udp < 1)
	    		{
	    			dbobject.executePreparedUpdate(strSQL.toString(),paI);
	    		}

    		}
    		else
    		{
    			
    			StringBuffer strSQLc = new StringBuffer(); 
    			strSQLc.append("select * from TBLSTRATACHVREGI where DETAILID = ? and YEAR = ? and qtr = ? ") ;
				Object[] pm = {did, year, qtr};
				rs = dbobject.executePreparedQuery(strSQLc.toString(), pm);
				DataSet ds = new DataSet();
				ds.load(rs);
				if(ds != null)
				{
					while(ds.next())
					{
						dbFile = ds.isEmpty("FILEPATH")?"":ds.getString("FILEPATH");
					}
				}
    			
    			if(!dbFile.equals(""))
    			{
    				fileNM_u =  dbFile + "|" + fileNM_u;
    			}
    			
	    		String strU = "UPDATE TBLSTRATACHVREGI SET FILEPATH=? WHERE DETAILID=? AND YEAR=? AND QTR=?";
	    		Object[] pmU = {fileNM_u,did,year,qtr};
	
	    		String strI = "INSERT INTO TBLSTRATACHVREGI (ACHVID,DETAILID,YEAR,QTR,FILEPATH) VALUES (?,?,?,?,?)";
	    		Object[] pmI = {new Integer(dbobject.getNextId("TBLSTRATACHVREGI","ACHVID")), did,year,qtr,fileNM_i};
	    		
	    		int udp = dbobject.executePreparedUpdate(strU,pmU);
	
	    		
	    		
	    		if (udp < 1)
	    		{
	    			dbobject.executePreparedUpdate(strI,pmI);
	    		}
    		}
    		
    		conn.commit();
		}catch (SQLException se){
			request.setAttribute("result","false");
			System.out.println(se);
		} catch (Exception e){
			request.setAttribute("result","false");
			System.out.println(e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null) dbobject.close();
			if (conn!=null) conn.close();
		}

    }	//method taskActualUpload


    
    public void taskDeletefile(HttpServletRequest request, HttpServletResponse response )
    {
		ResultSet rs = null;
		CoolConnection conn = null;
		DBObject dbobject = null;
		
		try{
    		String did = (String) request.getAttribute("did");
    		String qtr = (String) request.getAttribute("qtr");
    		String year = (String) request.getAttribute("year");
    		String typeid = (String) request.getAttribute("typeid");
    		String files = (String) request.getAttribute("fileNM")==null?"":(String) request.getAttribute("fileNM");
    		String userid = (String)request.getSession().getAttribute("userId");
    		
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
    		conn.createStatement(false);
    		dbobject = new DBObject(conn.getConnection());
    		
    		if(typeid.equals("2"))	//--중점 추진 업무
    		{
	    		String strU = "UPDATE TBLSTRATACHVREGI SET FILEPATH=? WHERE DETAILID=? AND YEAR=? AND QTR=?";
	    		Object[] pmU = {files,did,year,qtr};
	    		dbobject.executePreparedUpdate(strU, pmU);
    		}
    		else	//-- 전략적 프로젝트 
    		{
	    		String stU = "update TBLSTRATWORKACHV set FILEPATH = ?, modir=?, modidate = sysdate where dtlid = ? and year = ? and qtr = ?";
	    		Object[] pa = {files, userid, did, year, qtr};
	    		dbobject.executePreparedUpdate(stU, pa);
    		}
    		conn.commit();
    		request.setAttribute("msg", "true");
		}catch (SQLException se){
			request.setAttribute("result","false");
			System.out.println(se);
		} catch (Exception e){
			request.setAttribute("result","false");
			System.out.println(e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null) dbobject.close();
			if (conn!=null) conn.close();
		}
		
    }
    
    
    
    public void taskActualUpNofile(DBObject dbobject, HttpServletRequest request )
    {
		ResultSet rs = null;
		DataSet ds = null;

		String div = (String)request.getParameter("div")==null?"N":(String)request.getParameter("div");

		System.out.println("div     :    " + div);

		String qtrGoal1 = (String)request.getParameter("qtrGoal1")==null?"":(String)request.getParameter("qtrGoal1");
		String qtrAchv1 = (String)request.getParameter("qtrAchv1")==null?"":(String)request.getParameter("qtrAchv1");
		String file1 = (String)request.getParameter("file1")==null?"":(String)request.getParameter("file1");
		String detailid1 = (String)request.getParameter("detailid1")==null?"":(String)request.getParameter("detailid1");
		String achvid1 = (String)request.getParameter("achvid1")==null?"":(String)request.getParameter("achvid1");
		String realize1 = "";

//		int realize1 = Integer.parseInt(qtrAchv1)/Integer.parseInt(qtrGoal1)*100;
		if(div.equals("E"))
		{
			if(qtrGoal1 == null)
				qtrGoal1 = "1";
			else if(qtrGoal1.equals("0"))
				qtrGoal1 = "1";

			if(qtrAchv1 == null)
				qtrAchv1 = "1";

			System.out.println(qtrGoal1);
			realize1 = String.valueOf(Double.parseDouble(qtrAchv1)/Integer.parseInt(qtrGoal1)*100);

			System.out.println(realize1);
		}

		String qtrGoal2 = (String)request.getParameter("qtrGoal2")==null?"":(String)request.getParameter("qtrGoal2");
		String qtrAchv2=  (String)request.getParameter("qtrAchv2")==null?"":(String)request.getParameter("qtrAchv2");
		String file2 = (String)request.getParameter("file1")==null?"":(String)request.getParameter("file1");
		String detailid2 = (String)request.getParameter("detailid1")==null?"":(String)request.getParameter("detailid1");
		String achvid2 = (String)request.getParameter("achvid2")==null?"":(String)request.getParameter("achvid2");
		String realize2 = "";

		if(div.equals("E"))
		{
			if(qtrGoal2.equals("0"))
				qtrGoal2 = "1";
			else if(qtrGoal2 == null)
				qtrGoal2 = "1";

				realize2 = String.valueOf(Double.parseDouble(qtrAchv2)/Double.parseDouble(qtrGoal2)*100);
		}


		String qtrGoal3 = (String)request.getParameter("qtrGoal3")==null?"":(String)request.getParameter("qtrGoal3");
		String qtrAchv3 = (String)request.getParameter("qtrAchv3")==null?"":(String)request.getParameter("qtrAchv3");
		String file3 = (String)request.getParameter("file1")==null?"":(String)request.getParameter("file1");
		String detailid3 = (String)request.getParameter("detailid1")==null?"":(String)request.getParameter("detailid1");
		String achvid3 = (String)request.getParameter("achvid3")==null?"":(String)request.getParameter("achvid3");
//		int realize3 = Integer.parseInt(qtrAchv3)/Integer.parseInt(qtrGoal3)*100;
		String realize3 = "";

		System.out.println("qtrGoal3    " + qtrGoal3);
		System.out.println("qtrAchv3    " + qtrAchv3);
		System.out.println("file3    " + file3);
		System.out.println("detailid3    " + detailid3);
		System.out.println("achvid3    " + achvid3);

		if(div.equals("E"))
		{
			if(qtrGoal3.equals("0"))
				qtrGoal3 = "1";
			else if(qtrGoal3 == null)
				qtrGoal3 = "1";

			realize3 = String.valueOf(Double.parseDouble(qtrAchv3)/Double.parseDouble(qtrGoal3)*100);
		}


		String qtrGoal4 = (String)request.getParameter("qtrGoal4")==null?"":(String)request.getParameter("qtrGoal4");
		String qtrAchv4 =  (String)request.getParameter("qtrAchv4")==null?"":(String)request.getParameter("qtrAchv4");
		String file4 = (String)request.getParameter("file1")==null?"":(String)request.getParameter("file1");
		String detailid4 = (String)request.getParameter("detailid1")==null?"":(String)request.getParameter("detailid1");
		String achvid4 = (String)request.getParameter("achvid4")==null?"":(String)request.getParameter("achvid4");
		String realize4 = "";

		System.out.println("qtrGoal4     " + qtrGoal4);
		System.out.println("qtrAchv4     " + qtrAchv4);
		System.out.println("file4        " + file4);
		System.out.println("detailid4    " + detailid4);
		System.out.println("achvid4      " + achvid4);


		if(div.equals("E"))
		{
			if(qtrGoal4.equals("0"))
				qtrGoal4 = "1";
			else if(qtrGoal4 == null)
				qtrGoal4 = "1";

			realize4 = String.valueOf(Double.parseDouble(qtrAchv4)/Double.parseDouble(qtrGoal4)*100);
		}


		String detailid = (String)request.getParameter("detailid")==null?"":(String)request.getParameter("detailid");
		String year = (String)request.getParameter("year")==null?"":(String)request.getParameter("year");
		StringBuffer delSQL = new StringBuffer();
		StringBuffer insSQL = new StringBuffer();
		String user = (String)request.getSession().getAttribute("userid");

		System.out.println("detailid     " + detailid);
		System.out.println("year     " + year);



//		if(user.equals("") || user == null)
//			user = "admin";

		System.out.println("qtrGoal1    " + qtrGoal1);

		try
		{
			ds = new DataSet();

    		if(div.equals("E"))
    		{

	    		//-- 1분기 삭제
	    		delSQL.append("delete from TBLSTRATACHVREGI  ") ;
	    		delSQL.append("where ACHVID = " + achvid1) ;
	    		delSQL.append(" and DETAILID = " + detailid) ;
	    		System.out.println("1 분기 delSQL   :" + delSQL + "\n\n\n\n\n");
	    		dbobject.executeQuery(delSQL.toString());


	    		delSQL = new StringBuffer();

	    		//-- 1분기 insert
	    		insSQL.append("insert into TBLSTRATACHVREGI  \n") ;
	    		insSQL.append("(ACHVID,  \n") ;
	    		insSQL.append("DETAILID,  \n") ;
	    		insSQL.append("QTRGOAL,  \n") ;
	    		insSQL.append("QTRACHV,  \n") ;
	    		insSQL.append("REALIZE,  \n") ;
	    		insSQL.append("YEAR,  \n") ;
	    		insSQL.append("QTR,  \n") ;
	    		insSQL.append("FILEPATH,  \n") ;
	    		insSQL.append("REGIR \n") ;
	    		insSQL.append(")values( \n") ;
	    		insSQL.append("decode("+achvid1+",0,(select nvl(max(ACHVID)+1,1) from TBLSTRATACHVREGI ),"+achvid1+") \n") ;
	    		insSQL.append("," + detailid + "\n") ;
	    		insSQL.append(",'" + qtrGoal1  + "'\n") ;
	    		insSQL.append(",'" + qtrAchv1  + "'\n") ;
	    		insSQL.append(",round(to_number(" + realize1  + "),2) \n") ;
	    		insSQL.append(",'" + year + "'\n") ;
	    		insSQL.append(",'" + "1' \n") ;
	    		insSQL.append(",'" + file1 + "'\n") ;
	    		insSQL.append(",'" + user + "'\n") ;
	    		insSQL.append(") ") ;

	    		System.out.println("1 분기 insSQL   :" + insSQL + "\n\n\n\n\n");
	    		dbobject.executeQuery(insSQL.toString());


	    		insSQL = new StringBuffer();


	    		//-- 2분기 삭제
	    		delSQL.append("delete from TBLSTRATACHVREGI  ") ;
	    		delSQL.append("where ACHVID = " + achvid2) ;
	    		delSQL.append(" and DETAILID = " + detailid) ;

	    		System.out.println("2 분기 delSQL   :" + delSQL + "\n\n\n\n\n");

	    		dbobject.executeQuery(delSQL.toString());
	    		System.out.println("2 분기 delSQL   :" + delSQL + "\n\n\n\n\n");

	    		delSQL = new StringBuffer();;

	    		//-- 2분기 insert
	    		insSQL.append("insert into TBLSTRATACHVREGI  \n") ;
	    		insSQL.append("(ACHVID,  \n") ;
	    		insSQL.append("DETAILID,  \n") ;
	    		insSQL.append("QTRGOAL,  \n") ;
	    		insSQL.append("QTRACHV,  \n") ;
	    		insSQL.append("REALIZE,  \n") ;
	    		insSQL.append("YEAR,  \n") ;
	    		insSQL.append("QTR,  \n") ;
	    		insSQL.append("FILEPATH,  \n") ;
	    		insSQL.append("REGIR \n") ;
	    		insSQL.append(")values( \n") ;
	    		insSQL.append("decode("+achvid2+",0,(select nvl(max(ACHVID)+1,1) from TBLSTRATACHVREGI ),"+achvid2+") \n") ;
	    		insSQL.append(","  + detailid + "\n") ;
	    		insSQL.append(",'" + qtrGoal2  + "'\n") ;
	    		insSQL.append(",'" + qtrAchv2  + "'\n") ;
	    		insSQL.append(",round(to_number(" + realize2  + "),2) \n") ;
	    		insSQL.append(",'" + year + "'\n") ;
	    		insSQL.append(",'" + "2' \n") ;
	    		insSQL.append(",'" + file2 + "'\n") ;
	    		insSQL.append(",'" + user + "'\n") ;
	    		insSQL.append(") ") ;

	    		System.out.println("2 분기 insSQL   :" + insSQL + "\n\n\n\n\n");

	    		dbobject.executeQuery(insSQL.toString());

	    		insSQL = new StringBuffer();;


	    		//-- 3분기 삭제
	    		delSQL.append("delete from TBLSTRATACHVREGI  ") ;
	    		delSQL.append("where ACHVID = " + achvid3) ;
	    		delSQL.append(" and DETAILID = " + detailid) ;

	    		System.out.println("3 분기 delSQL   :" + delSQL + "\n\n\n\n\n");

	    		dbobject.executeQuery(delSQL.toString());

	    		delSQL = new StringBuffer();

	    		//-- 3분기 insert
	    		insSQL.append("insert into TBLSTRATACHVREGI  \n") ;
	    		insSQL.append("(ACHVID,  \n") ;
	    		insSQL.append("DETAILID,  \n") ;
	    		insSQL.append("QTRGOAL,  \n") ;
	    		insSQL.append("QTRACHV,  \n") ;
	    		insSQL.append("REALIZE,  \n") ;
	    		insSQL.append("YEAR,  \n") ;
	    		insSQL.append("QTR,  \n") ;
	    		insSQL.append("FILEPATH,  \n") ;
	    		insSQL.append("REGIR \n") ;
	    		insSQL.append(")values( \n") ;
	    		insSQL.append("decode("+achvid3+",0,(select nvl(max(ACHVID)+1,1) from TBLSTRATACHVREGI ),"+achvid3+") \n") ;
	    		insSQL.append("," + detailid + "\n") ;
	    		insSQL.append(",'" + qtrGoal3  + "'\n") ;
	    		insSQL.append(",'" + qtrAchv3  + "'\n") ;
	    		insSQL.append(",round(to_number(" + realize3  + "),2) \n") ;
	    		insSQL.append(",'" + year + "'\n") ;
	    		insSQL.append(",'" + "3' \n") ;
	    		insSQL.append(",'" + file3 + "'\n") ;
	    		insSQL.append(",'" + user + "'\n") ;
	    		insSQL.append(") ") ;

	    		System.out.println("3 분기 insSQL   :" + insSQL + "\n\n\n\n\n");

	    		dbobject.executeQuery(insSQL.toString());

	    		insSQL = new StringBuffer();;


	    		//-- 4분기 삭제
	    		delSQL.append("delete from TBLSTRATACHVREGI  ") ;
	    		delSQL.append("where ACHVID = " + achvid4) ;
	    		delSQL.append(" and DETAILID = " + detailid) ;

	    		System.out.println("4 분기 delSQL   :" + delSQL + "\n\n\n\n\n");

	    		dbobject.executeQuery(delSQL.toString());

	    		delSQL = new StringBuffer();;

	    		//-- 4분기 insert
	    		insSQL.append("insert into TBLSTRATACHVREGI  \n") ;
	    		insSQL.append("(ACHVID,  \n") ;
	    		insSQL.append("DETAILID,  \n") ;
	    		insSQL.append("QTRGOAL,  \n") ;
	    		insSQL.append("QTRACHV,  \n") ;
	    		insSQL.append("REALIZE,  \n") ;
	    		insSQL.append("YEAR,  \n") ;
	    		insSQL.append("QTR,  \n") ;
	    		insSQL.append("FILEPATH,  \n") ;
	    		insSQL.append("REGIR \n") ;
	    		insSQL.append(")values( \n") ;
	    		insSQL.append("decode("+achvid4+",0,(select nvl(max(ACHVID)+1,1) from TBLSTRATACHVREGI ),"+achvid4+") \n") ;
	    		insSQL.append("," + detailid + "\n") ;
	    		insSQL.append(",'" + qtrGoal4  + "'\n") ;
	    		insSQL.append(",'" + qtrAchv4  + "'\n") ;
	    		insSQL.append(",round(to_number(" + realize4  + "),2) \n") ;
	    		insSQL.append(",'" + year + "'\n") ;
	    		insSQL.append(",'" + "4' \n") ;
	    		insSQL.append(",'" + file4 + "'\n") ;
	    		insSQL.append(",'" + user + "'\n") ;
	    		insSQL.append(") ") ;

	    		System.out.println("4 분기 insSQL   :" + insSQL + "\n\n\n\n\n");

	    		dbobject.executeQuery(insSQL.toString());

	    		insSQL = new StringBuffer();;
    		}


		}catch (SQLException se){
			request.setAttribute("result","false");
			System.out.println(se);
		} catch (Exception e){
			request.setAttribute("result","false");
			System.out.println(e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
		}
    }	//method taskActualUpNofile

    public void taskActualPop(HttpServletRequest request, HttpServletResponse response)
    {

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		DataSet ds = null;

		StringBuffer dtlSQL = null;	//프로젝트 디테일 정보
		StringBuffer fileSQL = null;	//프로젝트 디테일 정보
		Object[] param = null;
		String typeid = "";
		String dtld = "";
		try{
			dtld = (String)request.getAttribute("detailid");
			
			typeid = (String)request.getAttribute("typeid");


			ds = new DataSet();

			dtlSQL = new StringBuffer();
			fileSQL = new StringBuffer();

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
    		conn.createStatement(false);
			if(dbobject == null)
				dbobject = new DBObject(conn.getConnection());


			dtlSQL.append("select PROJECTNAME,  \n") ;
			dtlSQL.append("       PROJECTDESC,  \n") ;
			dtlSQL.append("       PROJECTGOALDESC,  \n") ;
			dtlSQL.append("       MGRUSER,  \n") ;
			dtlSQL.append("       EXECWORK,  \n") ;
			dtlSQL.append("       b.SYEAR||'.'||b.SQTR||' - '||b.EYEAR||'.'||b.EQTR as DRVPERI,  ") ;
			dtlSQL.append("       GOALLEV,  \n") ;
			dtlSQL.append("       MAINDESC,  \n") ;
			
			if(typeid.equals("2"))
			{
				dtlSQL.append("       b.stopyn,  \n") ;
				dtlSQL.append("       b.stopyear,  \n") ;
				dtlSQL.append("       b.stopqtr,  \n") ;
			}
			
			dtlSQL.append("(select NAME from tblbsc a where a.ID = (SELECT DIVCODE FROM TBLUSER WHERE USERID=MGRUSER) ) as MGRDEPT  \n") ;
			dtlSQL.append("        from TBLSTRATPROJECTINFO a, TBLSTRATPROJECTDETAIL b \n") ;
			dtlSQL.append(" where  ") ;
			dtlSQL.append("\n a.PROJECTID = b.PROJECTID ") ;
			dtlSQL.append("\n and b.DETAILID = ?") ;


			param = new Object[]{dtld};
			rs = dbobject.executePreparedQuery(dtlSQL.toString(), param);

			ds.load(rs);
			request.setAttribute("dtlInfo", ds);

			if (rs!=null && ds != null){rs.close(); ds = new DataSet(); rs = null;}

			
			ds = new DataSet();
			if(typeid.equals("2"))
			{
				fileSQL.append("select * from TBLSTRATACHVREGI where DETAILID = ? ") ;
				fileSQL.append(" and FILEPATH <>'null'  ") ;
				fileSQL.append(" and FILEPATH <> ' '  ") ;
				fileSQL.append(" and FILEPATH is not null  ") ;
				
			//System.out.println(fileSQL.toString());
				Object[] pa = {dtld};
				rs = dbobject.executePreparedQuery(fileSQL.toString(), pa);
				ds.load(rs);
				request.setAttribute("fileInfo", ds);
			}
			else
			{
				
				fileSQL.append("select b.* from TBLSTRATWORK a, TBLSTRATWORKACHV b  ") ;
				fileSQL.append("where a.detailid = ? ") ;
				fileSQL.append("and a.dtlid = b.dtlid ") ;
				Object[] pa = {dtld};
				rs = dbobject.executePreparedQuery(fileSQL.toString(), pa);
				ds.load(rs);
				request.setAttribute("fileInfo", ds);

			}

			StringBuffer sb = new StringBuffer();
			sb.append("SELECT A.DETAILID,  ") ;
			sb.append("       A.EXECWORK, ") ;
			sb.append("       B.DTLID, ") ;
			sb.append("       B.DTLNAME, ") ;
			sb.append("      (SELECT  ") ;
			sb.append("            (SELECT NAME  ") ;
			sb.append("             FROM TBLSTRATPROJECT  ") ;
			sb.append("             WHERE X.CONTENTID = ID )  ") ;
			sb.append("        FROM TBLSTRATPROJECTINFO X  ") ;
			sb.append("        WHERE X.PROJECTID = A.PROJECTID) AS PNAME ") ;
			sb.append("FROM TBLSTRATPROJECTDETAIL A, TBLSTRATWORK B ") ;
			sb.append("WHERE A.DETAILID = B.DETAILID(+) ") ;
			sb.append("AND A.DETAILID = ? ") ;
			Object[] pa = {dtld};
			rs = dbobject.executePreparedQuery(sb.toString(), pa);
			
			DataSet ds2 = new DataSet();
			ds2.load(rs);
			
			request.setAttribute("ds",ds2);
			
			
			
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

    }	//method taskActualPop
    
    
    
    public void taskActualDtl(HttpServletRequest request, HttpServletResponse response)
    {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		DataSet ds = null;
		String detailid = "";
		try{
			detailid = request.getParameter("detailid");
			if (detailid==null) return;
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
    		conn.createStatement(false);
			if(dbobject == null)
				dbobject = new DBObject(conn.getConnection());
			ds = new DataSet();
			
			String userId = (String)request.getSession().getAttribute("userId");
			String userGrp = (String)request.getSession().getAttribute("groupId");
				
			if ("1".equals(userGrp)){
				StringBuffer strSQL = new StringBuffer();
				strSQL.append("SELECT DETAILID,DTLID,SYEAR,EYEAR,SYEAR||'-'||EYEAR,SQTR,EQTR,DTLNAME FROM TBLSTRATWORK WHERE DETAILID=? ") ;


				Object[] pa = {detailid};
				rs = dbobject.executePreparedQuery(strSQL.toString(),pa);				
				ds.load(rs);
				request.setAttribute("ds", ds);	
			} else {
				StringBuffer strSQL = new StringBuffer();
				strSQL.append("SELECT DETAILID,DTLID,SYEAR,EYEAR,SYEAR||'-'||EYEAR,SQTR,EQTR,DTLNAME FROM TBLSTRATWORK WHERE DETAILID=? AND MGRUSER=?") ;


				Object[] pa = {detailid,userId};
				rs = dbobject.executePreparedQuery(strSQL.toString(),pa);				
				ds.load(rs);
				request.setAttribute("ds", ds);	
			}
			
			String strG = "SELECT * FROM TBLSTRATPROJECTDETAIL WHERE DETAILID=?";
			Object[] pmG = {detailid};
			
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(strG,pmG);
			
			DataSet dsDtl = new DataSet();
			dsDtl.load(rs);
			
			request.setAttribute("dsDtl", dsDtl);
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
		
    }	// method taskActualDtl
    

    public void taskActualPopDtl(HttpServletRequest request, HttpServletResponse response)
    {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		DataSet ds = null;
		String detailid = "";
		String dtlid = "";

		try{
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
    		conn.createStatement(false);
			if(dbobject == null)
				dbobject = new DBObject(conn.getConnection());
			
			
			detailid = request.getParameter("detailid");
			dtlid = request.getParameter("dtlid");
			
			
			StringBuffer sb = new StringBuffer();
			sb.append("select DTLNAME,  ") ;
			sb.append("       (select name from tblbsc where a.MGRDEPT = id) as MGRDEPT,  ") ;
			sb.append("       (select name from tblbsc where a.RELADEPT_1 = id) as RELADEPT_1,  ") ;
			sb.append("       (select name from tblbsc where a.RELADEPT_2 = id) as RELADEPT_2,  ") ;
			sb.append("       SYEAR,  ") ;
			sb.append("       SQTR,  ") ;
			sb.append("       EYEAR,  ") ;
			sb.append("       EQTR,  ") ;
			sb.append("       GOALLEV,  ") ;
			sb.append("       DRVMTHD,  ") ;
			sb.append("       stopyn,  ") ;
			sb.append("       stopyear,  ") ;
			sb.append("       stopqtr,  ") ;
			sb.append("       DTLID from TBLSTRATWORK a ") ;
			sb.append("where a.DTLID = ? ") ;
			Object[] pa = {dtlid};
			rs = dbobject.executePreparedQuery(sb.toString(), pa);
			ds = new DataSet();
			ds.load(rs);
			request.setAttribute("ds",ds);

			StringBuffer strSQL = new StringBuffer();
			strSQL.append("select (select name from TBLSTRATPROJECT where id = b.CONTENTID) as pnm,  ") ;
			strSQL.append("        a.EXECWORK ") ;
			strSQL.append("from TBLSTRATPROJECTDETAIL a, TBLSTRATPROJECTINFO b ") ;
			strSQL.append("where a.PROJECTID = b.PROJECTID ") ;
			strSQL.append("and a.detailid = ? ") ;
			Object[] pa2 = {detailid};
			rs = dbobject.executePreparedQuery(strSQL.toString(), pa2);
			DataSet ds2 = new DataSet();
			ds2.load(rs);
			//System.out.println(ds2);
			request.setAttribute("ds2",ds2);
			
			
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
    
    
    public void taskAdminDtlPop(HttpServletRequest request, HttpServletResponse response)
    {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		DataSet ds = null;
		String detailId = "";
		String typeId = "";
		String drvGoal = "";
		String drvAchv = "";
		String year = "";
		String userId = "";
		String div = "";
		String selYear = "";
		
		try{
			detailId = request.getParameter("detailid");
			typeId = request.getParameter("typeid");
			year = request.getParameter("year");
			selYear = request.getParameter("selYear");
			drvGoal = request.getParameter("drvgoal");
			drvAchv = request.getParameter("drvachv");
			userId = (String)request.getSession().getAttribute("userId");
			div = request.getParameter("div")==null?"":request.getParameter("div");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
    		conn.createStatement(false);
			if(dbobject == null)
				dbobject = new DBObject(conn.getConnection());
			
			if(div.equals("P"))
			{			
				StringBuffer strSQL = new StringBuffer();
				strSQL.append("update TBLSTRATDRV set YEAR = ?,  ") ;
				strSQL.append("                       DRVGOAL = ?,  ") ;
	//			strSQL.append("                       DRVACHV = ?,  ") ;
				strSQL.append("                       MODIR = ?,  ") ;
				strSQL.append("                       MODIDATE = sysdate ") ;
				strSQL.append("where DETAILID = ? ") ;
				strSQL.append("and TYPEID = ? ") ;
				strSQL.append("and YEAR = ? ") ;
				Object[] pa = {year, drvGoal, userId, detailId, typeId, year};
				
				
				StringBuffer strSQLI = new StringBuffer();
				strSQLI.append("insert into TBLSTRATDRV (DRVID,  ") ;
				strSQLI.append("                         DETAILID,  ") ;
				strSQLI.append("                         TYPEID,  ") ;
				strSQLI.append("                         YEAR,  ") ;
				strSQLI.append("                         DRVGOAL,  ") ;
	//			strSQLI.append("                         DRVACHV,  ") ;
				strSQLI.append("                         REGIR  ") ;
				strSQLI.append("                         )values ") ;
				strSQLI.append("                        ((select nvl(max(DRVID)+1,1) from TBLSTRATDRV), ") ;
				strSQLI.append("                         ?, ") ;
				strSQLI.append("                         ?, ") ;
				strSQLI.append("                         ?, ") ;
				strSQLI.append("                         ?, ") ;
//				strSQLI.append("                         ?, ") ;
				strSQLI.append("                         ? ") ;
				strSQLI.append("                         ) ") ;
				Object[] paI = {detailId, typeId, year, drvGoal, userId};
				
	//			Object[] paI = {year, drvGoal, drvAchv, userId, detailId, typeId, year};
				if(dbobject.executePreparedUpdate(strSQL.toString(), pa) < 1 )
				{
					dbobject.executePreparedUpdate(strSQLI.toString(), paI);
				}
				conn.commit();
				request.setAttribute("msg", "처리 되었습니다.");
			}	
			
			StringBuffer strSQLS = new StringBuffer();
			strSQLS.append("select * from TBLSTRATDRV ") ;
			strSQLS.append("where detailid = ? ") ;
			strSQLS.append("and typeid = ? ") ;
			strSQLS.append("and year = ? ") ;
			Object[] pa2 = {detailId, typeId, year};
			rs = dbobject.executePreparedQuery(strSQLS.toString(), pa2);
			DataSet ds2 = new DataSet();
			ds2.load(rs);
			//System.out.println(ds2);
			request.setAttribute("ds2",ds2);
			
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
    
    public void taskActualDtlPop(HttpServletRequest request, HttpServletResponse response)
    {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		DataSet ds = null;
		String detailId = "";
		String typeId = "";
		String drvGoal = "";
		String drvAchv = "";
		String year = "";
		String userId = "";
		String div = "";
		String selYear = "";
		try{
			detailId = request.getParameter("detailid");
			typeId = request.getParameter("typeid");
			year = request.getParameter("year");
			selYear = request.getParameter("selYear");
			drvGoal = request.getParameter("drvgoal");
			drvAchv = request.getParameter("drvachv");
			userId = (String)request.getSession().getAttribute("userId");
			div = request.getParameter("div")==null?"":request.getParameter("div");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
    		conn.createStatement(false);
			if(dbobject == null)
				dbobject = new DBObject(conn.getConnection());
			
			if(div.equals("P"))
			{
				StringBuffer strSQL = new StringBuffer();
				strSQL.append("update TBLSTRATDRV set YEAR = ?,  ") ;
				strSQL.append("                       DRVGOAL = ?,  ") ;
				strSQL.append("                       DRVACHV = ?,  ") ;
				strSQL.append("                       MODIR = ?,  ") ;
				strSQL.append("                       MODIDATE = sysdate ") ;
				strSQL.append("where DETAILID = ? ") ;
				strSQL.append("and TYPEID = ? ") ;
				strSQL.append("and YEAR = ? ") ;
				Object[] pa = {year, drvGoal,drvAchv, userId, detailId, typeId, year};
				
				
				StringBuffer strSQLI = new StringBuffer();
				strSQLI.append("insert into TBLSTRATDRV (DRVID,  ") ;
				strSQLI.append("                         DETAILID,  ") ;
				strSQLI.append("                         TYPEID,  ") ;
				strSQLI.append("                         YEAR,  ") ;
				strSQLI.append("                         DRVGOAL,  ") ;
				strSQLI.append("                         DRVACHV,  ") ;
				strSQLI.append("                         REGIR  ") ;
				strSQLI.append("                         )values ") ;
				strSQLI.append("                        ((select nvl(max(DRVID)+1,1) from TBLSTRATDRV), ") ;
				strSQLI.append("                         ?, ") ;
				strSQLI.append("                         ?, ") ;
				strSQLI.append("                         ?, ") ;
				strSQLI.append("                         ?, ") ;
				strSQLI.append("                         ?, ") ;
				strSQLI.append("                         ? ") ;
				strSQLI.append("                         ) ") ;
				Object[] paI = {detailId, typeId, year, drvGoal, drvAchv, userId};
				
				if(dbobject.executePreparedUpdate(strSQL.toString(), pa) < 1 )
				{
					dbobject.executePreparedUpdate(strSQLI.toString(), paI);
				}
				conn.commit();
				request.setAttribute("msg", "처리 되었습니다.");
				
			}
			
			StringBuffer strSQL = new StringBuffer();
			strSQL.append("select * from TBLSTRATDRV ") ;
			strSQL.append("where detailid = ? ") ;
			strSQL.append("and typeid = ? ") ;
			strSQL.append("and year = ? ") ;
			Object[] pa2 = {detailId, typeId, year};
			rs = dbobject.executePreparedQuery(strSQL.toString(), pa2);
			DataSet ds2 = new DataSet();
			ds2.load(rs);
			//System.out.println(ds2);
			request.setAttribute("ds2",ds2);
			
			
			
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
		String file = "";
		String div = "";
		int idx;
		String udpFile = "";
		String userid = "";
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			typeid = request.getParameter("typeid");
			did = request.getParameter("did");
			qtr = request.getParameter("qtr");
			year = request.getParameter("year");
			file = request.getParameter("file");
			div = request.getParameter("div")==null?"":request.getParameter("div");
			idx = Integer.parseInt(request.getParameter("idx")==null?"0":request.getParameter("idx"));
			userid = (String)request.getSession().getAttribute("userId"); 
			
			if(div.equals("D"))	//--파일삭제
			{
				ArrayList fileAl = new ArrayList();
				
				String fileList[] = file.split("\\|");
				
				
				
				for(int i=0; i < fileList.length; i++)
				{
					fileAl.add(fileList[i]);
				}
//				out.println(imgUri+"/jsp/web/upload/"+fileAl.get(idx));
				String filePh = request.getSession().getServletContext().getRealPath("/")+ "jsp/web/upload/" +fileAl.get(idx);	//--절대경로.
//				String filePh = "fiel:///imgUri"+fileAl.get(idx);
//				URI ri = new URI(imgUri);
//				out.println(filePh);
				
				File f = new File(filePh);
				f.delete();
				
				fileAl.remove(idx);
//				out.println("size" + fileAl.size());
				for(int i=0; i < fileAl.size(); i++)
				{
					udpFile = udpFile + fileAl.get(i) + "|";
//					out.println("aaa    " + udpFile);
				}

				if(!udpFile.equals(""))
				{
					udpFile = udpFile.substring(0, udpFile.lastIndexOf("|"));	//--마지막에 붙은 "|" 이넘을 지운다.
				}
				
				
	    		if(typeid.equals("2"))	//--중점 추진 업무
	    		{
		    		String strU = "UPDATE TBLSTRATACHVREGI SET FILEPATH=? WHERE DETAILID=? AND YEAR=? AND QTR=?";
		    		Object[] pmU = {udpFile,did,year,qtr};
		    		dbobject.executePreparedUpdate(strU, pmU);
	    		}
	    		else	//-- 전략적 프로젝트 
	    		{
		    		String stU = "update TBLSTRATWORKACHV set FILEPATH = ?, modir=?, modidate = sysdate where dtlid = ? and year = ? and qtr = ?";
		    		Object[] pa = {udpFile, userid, did, year, qtr};
		    		dbobject.executePreparedUpdate(stU, pa);
	    		}
	    		conn.commit();
	    		request.setAttribute("msg", "true");				
				
			}			
			
			
			
			if(typeid.equals("1"))	//전략적 프로젝트 실행계획의 세부 실행계획.
			{
				
				StringBuffer strSQL = new StringBuffer();
				strSQL.append("select DTLID as did, YEAR, QTR,  FILEPATH from TBLSTRATWORKACHV ") ;
				strSQL.append("where DTLID = ? ") ;
				strSQL.append("and year = ? ") ;
				strSQL.append("and qtr = ? ") ;
				Object[] pa = {did, year, qtr};
				rs = dbobject.executePreparedQuery(strSQL.toString(), pa);
				
			}
			else	//중점추진 업무 
			{
				StringBuffer strSQL = new StringBuffer();
				strSQL.append("select DETAILID as did, YEAR, QTR,  FILEPATH  ") ;
				strSQL.append("from TBLSTRATACHVREGI  ") ;
				strSQL.append("where DETAILID = ? ") ;
				strSQL.append("and year = ? ") ;
				strSQL.append("and qtr = ? ") ;
				Object[] pa = {did, year, qtr};
				rs = dbobject.executePreparedQuery(strSQL.toString(), pa);
				
			}
			
			
			

			
			
			
			ds = new DataSet();
			ds.load(rs);
			request.setAttribute("fileList", ds);
			request.setAttribute("typeid", typeid);	//typeid 만 다시 넘겨 준다.
			
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
    
}	//class taskActualAchv


