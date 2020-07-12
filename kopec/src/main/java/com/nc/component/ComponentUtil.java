package com.nc.component;

import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;

public class ComponentUtil {
	public ComponentUtil(){
		
	}
	public void setBSC(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String kind=request.getParameter("kind");
			if (kind == null) return;
			
			String cd = "B";
			String tbl = "TBLBSC";
			String level = "2";
			String tblHier = "TBLHIERARCHY";
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String mode = request.getParameter("mode");
			String searchKey = Util.getEUCKR(request.getParameter("searchKey"));
			
			if ("N".equals(mode)){
				String name = Util.getEUCKR(request.getParameter("txtDesc"));
				String strI = "INSERT INTO "+tbl+" (ID,CODE,NAME,INPUTDATE,PARENTID) VALUES (?,?,?,?,?)";
				int id = dbobject.getNextId(tbl);
				String pid = request.getParameter("selParent")!=null?request.getParameter("selParent"):"";
				if ("-1".equals(pid)){
					pid = null;
				}				
				Object[] pmI = {new Integer(id),dbobject.getNewCode(cd,id),name,Util.getToDayTime(),pid};
				
				dbobject.executePreparedUpdate(strI,pmI);
			} else if ("U".equals(mode)){
				String id = request.getParameter("id");
				String name = Util.getEUCKR(request.getParameter("txtDesc"));
				String pid = request.getParameter("selParent")!=null?request.getParameter("selParent"):"";
				if ("-1".equals(pid)){
					pid = null;
				}
				String strU = "UPDATE "+tbl+" SET NAME=?,UPDATEDATE=?,PARENTID=? WHERE ID=?";
				Object[] pmU = {name,Util.getToDayTime(),pid,id};
				
				dbobject.executePreparedUpdate(strU,pmU);
			} else if ("D".equals(mode)){
				boolean step = false;
				String id = request.getParameter("id");
				
				if ("5".equals(level)){
					String strG = "SELECT * FROM TBLMEASUREDEFINE WHERE MEASUREID=?";
					Object[] pmG = {id};
					
					if (rs!=null){rs.close(); rs=null;}
					
					rs = dbobject.executePreparedQuery(strG,pmG);
					
					while(rs.next()){
						step=true;
					}
				} else {
					String strG = "SELECT * FROM "+tblHier + " WHERE CONTENTID=? AND TREELEVEL=?";
					Object[] pmG = {id,level};
					
					if (rs!=null){rs.close(); rs=null;}
					
					rs = dbobject.executePreparedQuery(strG,pmG);
					
					while(rs.next()){
						step=true;
					}
				}
				if (step){
					request.setAttribute("errMsg","참조된 정보가 있습니다.");
				} else {
					
					String strD = "DELETE FROM "+ tbl +" WHERE ID=?";
					Object[] pmD = {id};
					
					dbobject.executePreparedUpdate(strD,pmD);
				
				}
				
			}

			StringBuffer sbS = new StringBuffer();
			sbS.append("SELECT B.*,(SELECT NAME FROM TBLBSC P WHERE B.PARENTID=P.ID) PNAME FROM TBLBSC B WHERE NAME LIKE ?||'%' ORDER BY NAME");
			
			Object[] pm = {searchKey};
			
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(sbS.toString(),pm);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds", ds);
			
			String str = "SELECT * FROM TBLBSC WHERE PARENTID IS NULL";
			if (rs !=null){rs.close(); rs=null;}
			rs = dbobject.executeQuery(str);
			
			DataSet dsPT = new DataSet();
			dsPT.load(rs);
			
			request.setAttribute("dsPT",dsPT);
			
			conn.commit();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}		
	}
	
	public void setComponent(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String kind=request.getParameter("kind");
			if (kind == null) return;
			
			String cd = null;
			String tbl = null;
			String level = null;
			String tblHier = null;
			if ("com".equals(kind)){
				tbl= "TBLCOMPANY";
				cd = "C";
				level="0";
				tblHier = "TBLHIERARCHY";
			} else if ("sbu".equals(kind)) {
				tbl= "TBLSBU";
				cd = "S";
				level="1";
				tblHier = "TBLHIERARCHY";				
			} else if ("bsc".equals(kind)) {
				tbl= "TBLBSC";
				cd = "B";
				level="2";
				tblHier = "TBLHIERARCHY";
				
			} else if ("pst".equals(kind)) {
				tbl= "TBLPST";
				cd = "P";
				level="3";
				tblHier = "TBLTREESCORE";				
			} else if ("obj".equals(kind)) {
				tbl= "TBLOBJECTIVE";
				cd = "O";
				level="4";
				tblHier = "TBLTREESCORE";				
			} else if ("mea".equals(kind)) {
				tbl= "TBLMEASURE";
				cd = "M";
				level="5";
				tblHier = "TBLTREESCORE";				
			}
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String mode = request.getParameter("mode");
			String searchKey = Util.getEUCKR(request.getParameter("searchKey"));
			
			if ("N".equals(mode)){
				String name = Util.getEUCKR(request.getParameter("txtDesc"));
				if ("mea".equals(kind)){
					String type = Util.getEUCKR(request.getParameter("cboType"));
					String strI = "INSERT INTO "+tbl+" (ID,CODE,NAME,INPUTDATE,MEASCHAR) VALUES (?,?,?,?,?)";
					int id = dbobject.getNextId(tbl);
					Object[] pmI = {new Integer(id),dbobject.getNewCode(cd,id),name,Util.getToDayTime(),type};
					dbobject.executePreparedUpdate(strI,pmI);
				} else {
					String strI = "INSERT INTO "+tbl+" (ID,CODE,NAME,INPUTDATE) VALUES (?,?,?,?)";
					int id = dbobject.getNextId(tbl);
					Object[] pmI = {new Integer(id),dbobject.getNewCode(cd,id),name,Util.getToDayTime()};
					dbobject.executePreparedUpdate(strI,pmI);
				}				
			} else if ("U".equals(mode)){
				String id = request.getParameter("id");
				String name = Util.getEUCKR(request.getParameter("txtDesc"));
				if ("mea".equals(kind)){
					String type = Util.getEUCKR(request.getParameter("cboType"));
					String strU = "UPDATE "+tbl+" SET NAME=?,UPDATEDATE=?,MEASCHAR=? WHERE ID=?";
					Object[] pmU = {name,Util.getToDayTime(),type,id};
					dbobject.executePreparedUpdate(strU,pmU);
				} else {
					String strU = "UPDATE "+tbl+" SET NAME=?,UPDATEDATE=? WHERE ID=?";
					Object[] pmU = {name,Util.getToDayTime(),id};
					dbobject.executePreparedUpdate(strU,pmU);
				}
			} else if ("D".equals(mode)){
				boolean step = false;
				String id = request.getParameter("id");
				
				if ("5".equals(level)){
					String strG = "SELECT * FROM TBLMEASUREDEFINE WHERE MEASUREID=?";
					Object[] pmG = {id};
					
					if (rs!=null){rs.close(); rs=null;}
					
					rs = dbobject.executePreparedQuery(strG,pmG);
					
					while(rs.next()){
						step=true;
					}
				} else {
					String strG = "SELECT * FROM "+tblHier + " WHERE CONTENTID=? AND TREELEVEL=?";
					Object[] pmG = {id,level};
					
					if (rs!=null){rs.close(); rs=null;}
					
					rs = dbobject.executePreparedQuery(strG,pmG);
					
					while(rs.next()){
						step=true;
					}
				}
				if (step){
					request.setAttribute("errMsg","참조된 정보가 있습니다.");
				} else {
					
					String strD = "DELETE FROM "+ tbl +" WHERE ID=?";
					Object[] pmD = {id};
					
					dbobject.executePreparedUpdate(strD,pmD);
				
				}
				
			}

			StringBuffer sbS = new StringBuffer();
			sbS.append("SELECT * FROM "+tbl+" WHERE NAME LIKE ?||'%' ORDER BY NAME");
			
			Object[] pm = {searchKey};
			
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(sbS.toString(),pm);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds", ds);
			
			conn.commit();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
		
	}
	
}
