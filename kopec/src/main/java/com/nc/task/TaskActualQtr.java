package com.nc.task;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.sql.CoolConnection;
import com.nc.sql.ConnectionManager;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.cool.CoolServer;

public class TaskActualQtr {

    public void taskActualQtr(HttpServletRequest request, HttpServletResponse response)
    {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		StringBuffer qtr = null;
		
		String detailid = request.getParameter("detailid");
		String year = request.getParameter("year");
		int rowCnt = 0;
		try{
			
			qtr = new StringBuffer();
//			rs = new ResultSet();
    		conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
    		conn.createStatement(false);
			
			qtr.append("select ACHVID,DETAILID, QTR, QTRGOAL, QTRACHV, REALIZE, FILEPATH, YEAR from TBLSTRATACHVREGI ") ;
			qtr.append("where DETAILID = " + detailid) ;
			qtr.append(" and YEAR = " + year) ;
			qtr.append(" order by qtr") ;
			
			System.out.println(qtr);
			System.out.println(detailid);
			System.out.println(year);
			 
			rs = conn.executeQuery(qtr.toString());
			
			DataSet dsQtr = new DataSet();
			dsQtr.load(rs);
			
			request.setAttribute("dsQtr", dsQtr);

//
			
			
			//
			
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
    	
    
    }// method taskActualQtr
}
