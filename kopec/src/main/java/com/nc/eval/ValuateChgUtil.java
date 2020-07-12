package com.nc.eval;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.actual.MeasureDetail;
import com.nc.cool.CoolServer;
import com.nc.math.Expression;
import com.nc.math.ExpressionParser;
import com.nc.sql.CoolConnection;
import com.nc.util.Common_Data;
import com.nc.util.CoolFile;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.SmartUpload;
import com.nc.util.Util;
//import com.sun.rsasign.d;

public class ValuateChgUtil { 
	/////////////////////////////////////////////////////////////////////////////////////
	/*
	 *  new version kosep ;; 
	 */
	
	public void setDivision(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			int groupId = 1; // session.getAttribute();
			
			String userId = "admin"; //session.getAttribute();
			
			StringBuffer sb = new StringBuffer();
			Object[] params = null;
			if (groupId < 2) {
				sb.append(" SELECT CID,CRANK,SID,SCID,SPID,SNAME,SRANK,BID,BCID,BPID,BNAME,BRANK FROM  ")
				 .append(" (SELECT T.ID CID,T.PARENTID CPID,T.CONTENTID CCID,T.TREELEVEL CLEVEL,T.RANK CRANK,T.WEIGHT CWEIGHT,C.NAME CNAME  ")
				 .append(" FROM TBLHIERARCHY T,TBLCOMPANY C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=0 AND T.YEAR=? ) COM ")
				 .append(" LEFT JOIN")
		         .append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME  ")
		         .append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? ) SBU ")
		         .append(" ON COM.CID=SBU.SPID")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
		         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
		         .append(" ON SBU.SID=BSC.BPID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
		         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
		         .append(" ON BSC.BID=PST.PPID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
		         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
		         .append(" ON PST.PID=OBJ.OPID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME  ")
		         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA ")
		         .append(" ON OBJ.OID=MEA.MPID ")
		         .append(" WHERE MID IS NOT NULL ")
		         .append(" GROUP BY CID,CRANK,SID,SCID,SPID,SNAME,SRANK,BID,BCID,BPID,BNAME,BRANK ")
		         .append(" ORDER BY CRANK,CID,SRANK,SID,BRANK,BID ");
				
		         params = new Object[] {year,year,year,year,year,year};
			} else {
				sb.append(" SELECT CID,CRANK,SID,SCID,SPID,SNAME,SRANK,BID,BCID,BPID,BNAME,BRANK FROM  ")
				 .append(" (SELECT T.ID CID,T.PARENTID CPID,T.CONTENTID CCID,T.TREELEVEL CLEVEL,T.RANK CRANK,T.WEIGHT CWEIGHT,C.NAME CNAME  ")
				 .append(" FROM TBLHIERARCHY T,TBLCOMPANY C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=0 AND T.YEAR=? ) COM ")
				 .append(" LEFT JOIN")				
		         .append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME  ")
		         .append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? ) SBU ")
		         .append(" ON COM.CID=SBU.SPID")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
		         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
		         .append(" ON SBU.SID=BSC.BPID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
		         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
		         .append(" ON BSC.BID=PST.PPID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
		         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
		         .append(" ON PST.PID=OBJ.OPID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.UPDATEID ")
		         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND UPDATEID=? ) MEA ")
		         .append(" ON OBJ.OID=MEA.MPID ")
		         .append(" WHERE MID IS NOT NULL ")
		         .append(" GROUP BY CID,CRANK,SID,SCID,SPID,SNAME,SRANK,BID,BCID,BPID,BNAME,BRANK ")
		         .append(" ORDER BY CRANK,CID,SRANK,SID,BRANK,BID ");
				
		         params = new Object[] {year,year,year,year,year,year,userId};
			}
	         
	         
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			rs = dbobject.executePreparedQuery(sb.toString(),params);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds", ds);
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}
	
	public void setEvalGroup(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			String appraiser = (String)request.getSession().getAttribute("appraiser");
			if ((appraiser==null)||(!"2".equals(appraiser))) return;
			
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			String month = request.getParameter("month")!=null?request.getParameter("month"):"12";
			
			String userId = (String)request.getSession().getAttribute("userId");
			
			StringBuffer sbGrp = new StringBuffer();
			sbGrp.append("SELECT * FROM TBLMEAEVALGRP WHERE GRPID IN (SELECT GRPID FROM TBLMEAEVALR WHERE EVALRID=?) AND YEAR=? AND MONTH=?");
			Object[] params = {userId,year,month};
	         
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			rs = dbobject.executePreparedQuery(sbGrp.toString(),params);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("dsGrp", ds);
			
			StringBuffer strDetail = new StringBuffer();
			strDetail.append(" SELECT DISTINCT(MEASUREID),MNAME,GRPID,GRPNM FROM  ")
	         .append(" (SELECT GRPID,GRPNM,YEAR,MONTH FROM TBLMEAEVALGRP WHERE GRPID IN (SELECT GRPID FROM TBLMEAEVALR WHERE EVALRID=?)   ")
	         .append(" AND YEAR=? AND MONTH=12 ) GRP  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT D.GRPID GID,D.EVALDEPTID,B.ID,B.NAME FROM TBLMEAEVALDEPT D, TBLBSC B WHERE D.EVALDEPTID=B.ID) DEP  ")
	         .append(" ON GRP.GRPID=DEP.GID   ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME   ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC  ")
	         .append(" ON DEP.EVALDEPTID=BSC.BCID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME   ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST  ")
	         .append(" ON BSC.BID=PST.PPID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME   ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ  ")
	         .append(" ON PST.PID=OBJ.OPID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID,  ")
	         .append(" CASE WHEN (C.MEASCHAR='I') THEN '고유' ELSE '공통' END MKIND, C.MEASCHAR, D.MEASUREMENT ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND MEASUREMENT='비계량' ) MEA  ")
	         .append(" ON OBJ.OID=MEA.MPID   ")
	         .append(" WHERE MID IS NOT NULL AND MEASCHAR='C' ");
			
			Object[] obj = {userId,year,year,year,year,year};
			if (rs!=null) {rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(strDetail.toString(),obj);
			
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
			
			
			String year = request.getParameter("year");
			if (year==null) return;
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			String grpId = request.getParameter("grpId");
			String measureId = request.getParameter("measureId");
			
			String userId = (String)request.getSession().getAttribute("userId");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String[] grade=null;
			if ("I".equals(mode)){
				String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
				String[] mids = aMCID.split("\\|");
				
				String strU = "UPDATE TBLMEAEVALDETAIL SET EVALGRADE=?,EVALSCORE=?,MODIR=?,MODIDATE=SYSDATE,CONFIRM=1 WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=?";
				Object[] pmU = {null,null,userId,null,userId,year,"12"};
				
				String strI = "INSERT INTO TBLMEAEVALDETAIL (EVALID,EVALRID,YEAR,MONTH,EVALGRADE,EVALSCORE,REGIR,CONFIRM) VALUES (?,?,?,?,?,?,?,1)";
				Object[] pmI = {null,userId,year,"12",null,null,userId};
				
				for (int i = 0; i < mids.length; i++) {
					if (!"".equals(mids[i])){
						String grades = request.getParameter("rdo"+mids[i]);
						grade = grades.split("\\|");
						String grd = grade[0];
						String scr = grade[1];
						
						pmU[0]=grd;
						pmU[1]=scr;
						pmU[3]=mids[i];
						if (dbobject.executePreparedUpdate(strU,pmU)<1){
							pmI[0]=mids[i];
							pmI[4]=grd;
							pmI[5]=scr;
							dbobject.executePreparedUpdate(strI,pmI);
						}
						System.out.println(grades);
					}
				}

				
			} else if ("D".equals(mode)){
				String strD = "DELETE FROM TBLMEAEVALDETAIL WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=12";
				Object[] objD = {null,userId,year};
				String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
				String[] mids = aMCID.split("\\|");
				
				for (int i = 0; i < mids.length; i++) {
					if (!"".equals(mids[i])){
						objD[0]=mids[i];
						dbobject.executePreparedUpdate(strD,objD);
					}
				}
			}
			
			StringBuffer sb = new StringBuffer();
			Object[] params = null;
			
			sb.append(" SELECT * FROM ")
	         .append(" (SELECT GRPID,GRPNM,YEAR,MONTH FROM TBLMEAEVALGRP WHERE GRPID IN (SELECT GRPID FROM TBLMEAEVALR WHERE EVALRID=?)  ")
	         .append(" AND YEAR=? AND MONTH=12 AND GRPID=?) GRP ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT D.GRPID GID,D.EVALDEPTID,B.ID,B.NAME FROM TBLMEAEVALDEPT D, TBLBSC B WHERE D.EVALDEPTID=B.ID) DEP ")
	         .append(" ON GRP.GRPID=DEP.GID  ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
	         .append(" ON DEP.EVALDEPTID=BSC.BCID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
	         .append(" ON BSC.BID=PST.PPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
	         .append(" ON PST.PID=OBJ.OPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID, ")
	         .append(" CASE WHEN (C.MEASCHAR='I') THEN '고유' ELSE '공통' END MKIND,C.MEASCHAR  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT EVALGRADE,EVALSCORE,EVALID FROM TBLMEAEVALDETAIL WHERE YEAR=? AND MONTH=12 AND EVALRID=?) EVAL ")
	         .append(" ON MEA.MCID=EVALID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT MEASUREID AMID,FILEPATH,FILENAME FROM TBLEVALMEASUREDETAIL WHERE EFFECTIVEDATE=?) ATT ")
	         .append(" ON MEA.MCID=ATT.AMID ")
	         .append(" WHERE MEASUREID=? ")
	         .append(" ORDER BY BRANK,BID ");
			
	         params = new Object[] {userId,year,grpId, year,year,year,year,year,userId,year+"12",measureId};
		         
			rs = dbobject.executePreparedQuery(sb.toString(),params);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			int cnt = ds.getRowCount();
			
			StringBuffer sbCnt = new StringBuffer();
			sbCnt.append("SELECT * FROM TBLMEAEVALGRADE WHERE CNT=? AND TYPE=1");
			Object[] obj = {String.valueOf(cnt)};
			
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(sbCnt.toString(),obj);
			DataSet dsCnt = new DataSet();
			dsCnt.load(rs);
			
			String strScr = "SELECT * FROM TBLMEAEVALGRADE WHERE CNT=-1 AND TYPE=1";
			if (rs!=null) {rs.close(); rs=null;}
			
			rs = dbobject.executeQuery(strScr);
			DataSet dsScr = new DataSet();
			dsScr.load(rs);
			
			request.setAttribute("ds", ds);
			request.setAttribute("dsCnt",dsCnt);
			request.setAttribute("dsScr",dsScr);
			
			conn.commit();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}		
	}	
	
	public void setEvalInn(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String appraiser = (String)request.getSession().getAttribute("appraiser");
			if (!"2".equals(appraiser)) return;
			
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			
			String userId = (String)request.getSession().getAttribute("userId");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			StringBuffer sb = new StringBuffer();
			Object[] pm = {userId,year};
			
			sb.append("SELECT * FROM TBLMEAEVALGRP WHERE GRPID IN (SELECT GRPID FROM TBLMEAEVALR WHERE EVALRID=?) AND YEAR=? AND MONTH=12");
			
			rs = dbobject.executePreparedQuery(sb.toString(),pm);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds", ds);
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}		
	}
	
	public void setEvalInnDetail(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			String grpId = request.getParameter("grpId");
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			String userId = (String)request.getSession().getAttribute("userId");
			if (userId==null) return;
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String[] grade=null;
			if ("I".equals(mode)){
				String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
				String[] mids = aMCID.split("\\|");
				
				String strU = "UPDATE TBLMEAEVALDETAIL SET EVALGRADE=?,EVALSCORE=?,MODIR=?,MODIDATE=SYSDATE,CONFIRM=1 WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=?";
				Object[] pmU = {null,null,userId,null,userId,year,"12"};
				
				String strI = "INSERT INTO TBLMEAEVALDETAIL (EVALID,EVALRID,YEAR,MONTH,EVALGRADE,EVALSCORE,REGIR,CONFIRM) VALUES (?,?,?,?,?,?,?,1)";
				Object[] pmI = {null,userId,year,"12",null,null,userId};
				
				for (int i = 0; i < mids.length; i++) {
					if (!"".equals(mids[i])){
						String grades = request.getParameter("rdo"+mids[i]);
						grade = grades.split("\\|");
						String grd = grade[0];
						String scr = grade[1];
						
						pmU[0]=grd;
						pmU[1]=scr;
						pmU[3]=mids[i];
						if (dbobject.executePreparedUpdate(strU,pmU)<1){
							pmI[0]=mids[i];
							pmI[4]=grd;
							pmI[5]=scr;
							dbobject.executePreparedUpdate(strI,pmI);
						}
					}
				}

				
			} else if ("D".equals(mode)){
				String strD = "DELETE FROM TBLMEAEVALDETAIL WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=12";
				Object[] objD = {null,userId,year};
				String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
				String[] mids = aMCID.split("\\|");
				
				for (int i = 0; i < mids.length; i++) {
					if (!"".equals(mids[i])){
						objD[0]=mids[i];
						dbobject.executePreparedUpdate(strD,objD);
					}
				}
			}
			
			StringBuffer sb = new StringBuffer();
			Object[] params = null;
			
			sb.append(" SELECT * FROM  ")
	         .append(" (SELECT GRPID,GRPNM,YEAR,MONTH FROM TBLMEAEVALGRP WHERE GRPID IN (SELECT GRPID FROM TBLMEAEVALR WHERE EVALRID=?)   ")
	         .append(" AND YEAR=? AND MONTH=12 AND GRPID=?) GRP  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT D.GRPID GID,D.EVALDEPTID,B.ID,B.NAME FROM TBLMEAEVALDEPT D, TBLBSC B WHERE D.EVALDEPTID=B.ID) DEP  ")
	         .append(" ON GRP.GRPID=DEP.GID   ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME   ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC  ")
	         .append(" ON DEP.EVALDEPTID=BSC.BCID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME   ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST  ")
	         .append(" ON BSC.BID=PST.PPID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME   ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ  ")
	         .append(" ON PST.PID=OBJ.OPID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID, ")
	         .append(" D.MEASUREMENT,CASE WHEN (C.MEASCHAR='I') THEN '고유' ELSE '공통' END MKIND,C.MEASCHAR   ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.MEASUREMENT='비계량' ) MEA  ")
	         .append(" ON OBJ.OID=MEA.MPID  ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT EVALGRADE,EVALSCORE,EVALID FROM TBLMEAEVALDETAIL WHERE YEAR=? AND MONTH=12 AND EVALRID=?) EVAL ")
	         .append(" ON MEA.MCID=EVALID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT MEASUREID AMID,FILEPATH,FILENAME FROM TBLEVALMEASUREDETAIL WHERE EFFECTIVEDATE=?) ATT ")
	         .append(" ON MEA.MCID=ATT.AMID ")	         
	         .append(" WHERE MID IS NOT NULL AND MEASCHAR='I' ")
	         .append(" ORDER BY BRANK,BID  ");
			
	         params = new Object[] {userId,year,grpId,year,year,year,year,year,userId,year+"12"};
		         
			rs = dbobject.executePreparedQuery(sb.toString(),params);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds", ds);
			
			int cnt = ds.getRowCount();
			
			StringBuffer sbCnt = new StringBuffer();
			sbCnt.append("SELECT * FROM TBLMEAEVALGRADE WHERE CNT=? AND TYPE=1");
			Object[] obj = {String.valueOf(cnt)};
			
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(sbCnt.toString(),obj);
			DataSet dsCnt = new DataSet();
			dsCnt.load(rs);
			
			request.setAttribute("dsCnt",dsCnt);
			
			String strScr = "SELECT * FROM TBLMEAEVALGRADE WHERE CNT=-1 AND TYPE=1";
			if (rs!=null) {rs.close(); rs=null;}
			
			rs = dbobject.executeQuery(strScr);
			DataSet dsScr = new DataSet();
			dsScr.load(rs);
			
			request.setAttribute("dsScr",dsScr);
			
			conn.commit();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}		
	}
	
	public void setOpinionList(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			String year = request.getParameter("year");
			
			String userId = (String)request.getSession().getAttribute("userId");
			
			String grpId = request.getParameter("grpId");
			
			if (userId==null) return;
			
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM ( ")
	         .append(" SELECT * FROM ")
	         .append(" (SELECT GRPID,GRPNM,YEAR,MONTH FROM TBLMEAEVALGRP WHERE GRPID IN (SELECT GRPID FROM TBLMEAEVALR WHERE EVALRID=?)  ")
	         .append(" AND YEAR=? AND MONTH=12 AND GRPID=?) GRP ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT D.GRPID GID,D.EVALDEPTID,B.ID,B.NAME FROM TBLMEAEVALDEPT D, TBLBSC B WHERE D.EVALDEPTID=B.ID) DEP ")
	         .append(" ON GRP.GRPID=DEP.GID  ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
	         .append(" ON DEP.EVALDEPTID=BSC.BCID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
	         .append(" ON BSC.BID=PST.PPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
	         .append(" ON PST.PID=OBJ.OPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID, ")
	         .append(" D.MEASUREMENT, CASE WHEN (C.MEASCHAR='I') THEN '고유' ELSE '공통' END MKIND,C.MEASCHAR  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.MEASUREMENT='비계량' ) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT EVALID,EVALGRADE,NVL(EVALSCORE,0) EVALSCORE FROM TBLMEAEVALDETAIL WHERE EVALRID=? AND YEAR=? AND MONTH=12) EVAL ")
	         .append(" ON MEA.MCID=EVAL.EVALID ")
	         .append(" WHERE MID IS NOT NULL ")
	         .append(" ) M ")
	         .append(" LEFT JOIN ")
	         .append(" ( ")
	         .append(" SELECT ROUND(SUM(FSCORE),2) FSCORE,NAME FNAME,EVALDEPTID FDEPID FROM ( ")
	         .append(" SELECT GRPNM,NAME,MWEIGHT*EVALSCORE/100 FSCORE,EVALDEPTID FROM ")
	         .append(" (SELECT GRPID,GRPNM,YEAR,MONTH FROM TBLMEAEVALGRP WHERE GRPID IN (SELECT GRPID FROM TBLMEAEVALR WHERE EVALRID=?)  ")
	         .append(" AND YEAR=? AND MONTH=12 AND GRPID=?) GRP ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT D.GRPID GID,D.EVALDEPTID,B.ID,B.NAME FROM TBLMEAEVALDEPT D, TBLBSC B WHERE D.EVALDEPTID=B.ID) DEP ")
	         .append(" ON GRP.GRPID=DEP.GID  ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
	         .append(" ON DEP.EVALDEPTID=BSC.BCID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
	         .append(" ON BSC.BID=PST.PPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
	         .append(" ON PST.PID=OBJ.OPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID, ")
	         .append(" D.MEASUREMENT, CASE WHEN (C.MEASCHAR='I') THEN '고유' ELSE '공통' END MKIND,C.MEASCHAR  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.MEASUREMENT='비계량' ) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT EVALID,EVALGRADE,NVL(EVALSCORE,0) EVALSCORE FROM TBLMEAEVALDETAIL WHERE EVALRID=? AND YEAR=? AND MONTH=12) EVAL ")
	         .append(" ON MEA.MCID=EVAL.EVALID ")
	         .append(" WHERE MID IS NOT NULL ")
	         .append(" ) GROUP BY NAME,EVALDEPTID ")
	         .append(" ) F ")
	         .append(" ON M.EVALDEPTID=F.FDEPID ")
	         .append(" ORDER BY BRANK,BID,MEASCHAR ");
			
			Object[] pm = {userId,year,grpId,year,year,      year,year,userId,year,userId,	year,grpId,year,year,year,	year,userId,year};
			
	         
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			rs = dbobject.executePreparedQuery(sb.toString(),pm);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds", ds);
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}
		
	
	
	public void setOpinionDetail01(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			String year = request.getParameter("year");
			String grpId = request.getParameter("grpId");
			
			if (year==null) return;
			
			String userId = (String)request.getSession().getAttribute("userId");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			if ("A".equals(mode)){
				String best = Util.getEUCKR(request.getParameter("best"));
				String worst = Util.getEUCKR(request.getParameter("worst"));
				
				String strU = "UPDATE TBLMEAEVALOPINION01 SET BEST=?,WORST=? WHERE YEAR=? AND MONTH=12 AND GRPID=? AND EVALR=?";
				Object[] objU = {best,worst,year,grpId,userId};
				
				String strI = "INSERT INTO TBLMEAEVALOPINION01 (YEAR,MONTH,GRPID,EVALR,BEST,WORST) VALUES (?,12,?,?,?,?)";
				Object[] objI = {year,grpId,userId,best,worst};
				
				if (dbobject.executePreparedUpdate(strU,objU)<1){
					dbobject.executePreparedUpdate(strI,objI);
				}
				
			} else if ("D".equals(mode)) {
				String strD = "DELETE FROM TBLMEAEVALOPINION01 WHERE YEAR=? AND MONTH=12 AND GRPID=? AND EVALR=?";
				Object[] objD = {year,grpId,userId};
				
				dbobject.executePreparedUpdate(strD,objD);
			}
			
			
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM TBLMEAEVALOPINION01 WHERE GRPID=? AND EVALR=? AND YEAR=? AND MONTH=12");
			
			Object[] pm = {grpId,userId,year};
			
			rs = dbobject.executePreparedQuery(sb.toString(),pm);
			
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
	
	
	public void setOpinionDetail02(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			String year = request.getParameter("year");
			if (year==null) return;
			
			String userId = (String)request.getSession().getAttribute("userId");
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			String grpId = request.getParameter("grpId");
			if ("A".equals(mode)) {
				String deptIds = request.getParameter("depts")!=null?request.getParameter("depts"):"";
				String[] aDept = deptIds.split("\\|");
				
				String strU = "UPDATE TBLMEAEVALOPINION02 SET OPINION=? WHERE YEAR=? AND MONTH=12 AND EVALR=? AND EVALDEPTID=?";
				Object[] objU = {null,year,userId,null};
				
				String strI = "INSERT INTO TBLMEAEVALOPINION02 (YEAR,MONTH,EVALR,EVALDEPTID,OPINION) VALUES (?,12,?,?,?)";
				Object[] objI = {year,userId,null,null};
				for (int i = 0; i < aDept.length; i++) {
					String opn = Util.getEUCKR(request.getParameter("opn"+aDept[i]));
					
					if ((opn!=null)&&(!"".equals(opn))){
						objU[0]=opn;
						objU[3]=aDept[i];
						if (dbobject.executePreparedUpdate(strU,objU)<1){
							objI[2]=aDept[i];
							objI[3]=opn;
							dbobject.executePreparedUpdate(strI,objI);
						}
					}
				}
				
			} else if ("D".equals(mode)) {
				String deptIds = request.getParameter("depts")!=null?request.getParameter("depts"):"";
				String[] aDept = deptIds.split("\\|");
				
				String strD = "DELETE FROM TBLMEAEVALOPINION02 WHERE YEAR=? AND MONTH=12 AND EVALR=? AND EVALDEPTID=?";
				Object[] objD = {year,userId,null};
				
				for (int i = 0; i < aDept.length; i++) {
					if ((aDept[i]!=null)&&(!"".equals(aDept[i]))){
					
						objD[2]=aDept[i];
						dbobject.executePreparedUpdate(strD,objD);
					}
				}
			}
			
			
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM  ")
	         .append(" (SELECT * FROM TBLMEAEVALGRP WHERE GRPID=? ) GRP ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT D.GRPID GID,D.EVALDEPTID,B.ID,B.NAME FROM TBLMEAEVALDEPT D, TBLBSC B WHERE D.EVALDEPTID=B.ID) DEP ")
	         .append(" ON GRP.GRPID=DEP.GID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT EVALR,EVALDEPTID DID,OPINION FROM TBLMEAEVALOPINION02 WHERE YEAR=? AND MONTH=12 AND EVALR=?) OPN ")
	         .append(" ON DEP.EVALDEPTID=OPN.DID ");
			
			Object[] pm = {grpId,year,userId};
			
			rs = dbobject.executePreparedQuery(sb.toString(),pm);
			
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
	
		
	public void setViewActual(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			String year = request.getParameter("year");
			if (year==null) return;
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String mid = request.getParameter("mid");
			
			
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM  ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,C.NAME,C.ID CID  ")
	         .append(" FROM TBLMEASUREDEFINE D, TBLMEASURE C, TBLTREESCORE T WHERE T.CONTENTID=D.ID AND T.TREELEVEL=5 AND D.MEASUREID=C.ID AND D.ID=?) MEA ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,C.NAME ONAME ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=?) OBJ ")
	         .append(" ON MEA.MPID=OBJ.OID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,C.NAME PNAME ")
	         .append(" FROM TBLTREESCORE T, TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=?)PST ")
	         .append(" ON OBJ.OPID=PST.PID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,C.NAME BNAME ")
	         .append(" FROM TBLHIERARCHY T, TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=?)BSC ")
	         .append(" ON PST.PPID=BSC.BID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT * FROM TBLEVALMEASUREDETAIL WHERE EFFECTIVEDATE=?) ACT ")
	         .append(" ON MEA.MCID=ACT.MEASUREID ");
			
			Object[] pm = {mid,year,year,year,year+"12"};
			
			rs = dbobject.executePreparedQuery(sb.toString(),pm);
			
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
