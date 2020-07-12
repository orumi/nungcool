package com.nc.xml;

import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class UserUtil {
	
	public void getUser(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
		try {  
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			if ("C".equals(mode)){
				// insert
			} else if ("U".equals(mode)){
				String userId = request.getParameter("userId");
				String userName = request.getParameter("userName");
				
				String str = "UPDA";
					
				//update
			} else if ("D".equals(mode)){
				//delete
			}
			
			
			String strS = "SELECT * FROM TBLUSER WHERE USERNAME LIKE ?||'%' ORDER BY USERNAME";
			String uname = request.getParameter("uname")!=null?request.getParameter("uname"):"";
			Object[] obj = {uname};
			
			rs = dbobject.executePreparedQuery(strS,obj);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	
}
