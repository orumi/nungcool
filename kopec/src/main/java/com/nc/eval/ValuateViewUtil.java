package com.nc.eval;

import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;

public class ValuateViewUtil {
	public void setEvalGroup(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String qtr = Util.getPrevQty(null);
			
			String year = request.getParameter("year")!=null?request.getParameter("year"):qtr.substring(0,4);
			String month = request.getParameter("month")!=null?request.getParameter("month"):qtr.substring(4,6);
			
			String userId = (String)request.getSession().getAttribute("userId");
			
			StringBuffer sbGrp = new StringBuffer();
			sbGrp.append("SELECT * FROM TBLMEAEVALGRP WHERE YEAR=? AND MONTH=?");
			Object[] params = {year,month};
	         
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			rs = dbobject.executePreparedQuery(sbGrp.toString(),params);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("dsGrp", ds);
			
			String strDetail = "SELECT D.*,B.NAME FROM TBLMEAEVALDEPT D, TBLBSC B WHERE D.EVALDEPTID=B.ID AND GRPID IN (SELECT GRPID FROM TBLMEAEVALGRP WHERE YEAR=? AND MONTH=?)";
			
			if (rs!=null) {rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(strDetail,params);
			
			DataSet dsDtl = new DataSet();
			dsDtl.load(rs);
			
			request.setAttribute("dsDtl",dsDtl);
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}
	
	public void setEvalMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			String schDate = request.getParameter("schDate");
			
			if (schDate==null) return;
			
			String year = schDate.substring(0,4);
			String month = schDate.substring(4,6);
			String bscId = request.getParameter("bscId");
			String sbuId = request.getParameter("sbuId"); // eval group id;;
			
			
			String userId = (String)request.getSession().getAttribute("userId");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String frq = getFrequecny(new Integer(month).intValue());
			
			
			StringBuffer sb = new StringBuffer();
			Object[] pm = null;
			
			sb.append(" SELECT * FROM    ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME    ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? AND T.CONTENTID=? ) BSC   ")
	         .append(" LEFT JOIN   ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME    ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST   ")
	         .append(" ON BSC.BID=PST.PPID   ")
	         .append(" LEFT JOIN   ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME    ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ   ")
	         .append(" ON PST.PID=OBJ.OPID   ")
	         .append(" LEFT JOIN   ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,D.MEASUREMENT    ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.FREQUENCY IN ("+frq+")) MEA   ")
	         .append(" ON OBJ.OID=MEA.MPID   ")
	         .append(" LEFT JOIN   ")
	         .append(" (SELECT AVG(EVALSCORE) AVGSCR,EVALID,COUNT(EVALSCORE) CNT FROM TBLMEAEVALDETAIL WHERE YEAR=? AND MONTH=? GROUP BY EVALID) EVAL ")
	         .append(" ON MEA.MCID=EVAL.EVALID ")
	         .append(" WHERE MEASUREMENT='비계량' AND MID IS NOT NULL   ")
	         .append(" ORDER BY BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");
			
	         pm = new Object[] {year,bscId,year,year,year,year,month};
		         
	         rs = dbobject.executePreparedQuery(sb.toString(),pm);
			
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
	
	private String getFrequecny(int m){
		String reval="'월'";
		if ( (m==3) || (m==9)) {
			reval = reval+",'분기'";
		} else if ((m == 6) ) {
			reval = reval+",'분기','반기'";
		} else if (m==12) {
			reval = reval+",'분기','반기','년'";
		}
		return reval;
	}		
}
