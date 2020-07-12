package com.nc.totEval;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;

public class ESTAdminUtil {
	
	public void setDivision (HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String userId = (String)request.getSession().getAttribute("userId");
			if (userId==null) return;
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			if ("C".equals(mode)){
				String name = Util.getEUCKR(request.getParameter("name"));
				
				String strI = "INSERT INTO TBLESTSECTION (ID,NAME) VALUES (?,?)";
				Object[] pmI = {new Integer(dbobject.getNextId("TBLESTSECTION")),name};
				
				dbobject.executePreparedUpdate(strI,pmI);
				
				conn.commit();
			} else if ("U".equals(mode)) {
				String name = Util.getEUCKR(request.getParameter("name"));
				String id = request.getParameter("id");
				
				String strU = "UPDATE TBLESTSECTION SET NAME=? WHERE ID=?";
				Object[] pmU = {name,id};
				
				dbobject.executePreparedUpdate(strU,pmU);
				
				conn.commit();
			} else if ("D".equals(mode)) {
				String id = request.getParameter("id");
				
				String strD = "DELETE FROM TBLESTSECTION WHERE ID=?";
				Object[] pmD = {id};
				
				dbobject.executePreparedUpdate(strD,pmD);
				
				conn.commit();
			}
			
			
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT * FROM TBLESTSECTION  ") ;


			rs = dbobject.executeQuery(sb.toString());
			
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
	}
	public void setMeasure (HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String userId = (String)request.getSession().getAttribute("userId");
			if (userId==null) return;
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			if ("C".equals(mode)){
				String name = Util.getEUCKR(request.getParameter("name"));
				String sectionId = request.getParameter("sectionId");
				
				String strI = "INSERT INTO TBLESTMEASURE (ID,SECTIONID,NAME) VALUES (?,?,?)";
				Object[] pmI = {new Integer(dbobject.getNextId("TBLESTMEASURE")),sectionId,name};
				
				dbobject.executePreparedUpdate(strI,pmI);
				
				conn.commit();
			} else if ("U".equals(mode)) {
				String name = Util.getEUCKR(request.getParameter("name"));
				String sectionId = request.getParameter("sectionId");
				String id = request.getParameter("id");
				
				String strU = "UPDATE TBLESTMEASURE SET NAME=?,SECTIONID=? WHERE ID=?";
				Object[] pmU = {name,sectionId,id};
				
				dbobject.executePreparedUpdate(strU,pmU);
				
				conn.commit();
			} else if ("D".equals(mode)) {
				String id = request.getParameter("id");
				
				String strD = "DELETE FROM TBLESTMEASURE WHERE ID=?";
				Object[] pmD = {id};
				
				dbobject.executePreparedUpdate(strD,pmD);
				
				conn.commit();
			}
			
			
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT * FROM TBLESTSECTION  ") ;

			rs = dbobject.executeQuery(sb.toString());
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("dsS",ds);
			
			String strM = "SELECT M.*,(SELECT NAME FROM TBLESTSECTION S WHERE S.ID=SECTIONID) SNAME FROM TBLESTMEASURE M ORDER BY SECTIONID";
			if (rs!=null){rs.close();rs=null;}
			rs = dbobject.executeQuery(strM);
			
			DataSet dsM = new DataSet(rs);
			request.setAttribute("dsM",dsM);
			
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
	}
	public void setBuzResult(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
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
	}
	
	public void setBuzAllot(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());

			
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
	}
	
	public void setAdminBuzMea(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
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
	}
	
	
	public void setAdminBuzMeaList(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			String userId = (String)request.getSession().getAttribute("userId");
			if (userId==null) return;
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			if ("C".equals(mode)){
				String measureId =  (request.getParameter("measure"));
				String allot = request.getParameter("allot");
				String bscId = request.getParameter("bscId");
				String factor = Util.getEUCKR(request.getParameter("factor"));
				String orderby = request.getParameter("orderby");
				
				String strC = "INSERT INTO TBLESTMEASUREDEFINE (MEASUREID,YEAR,ALLOT,BSCID,FACTOR,REGIR,REGIDATE,ORDERBY) VALUES (?,?,?,?,?, ?,SYSDATE,? )";
				Object[] pmC = {measureId,year,allot,bscId,factor,userId,orderby};
				
				dbobject.executePreparedUpdate(strC,pmC);
				
			} else if ("U".equals(mode)) {
				String measureId =  Util.getEUCKR(request.getParameter("measure"));
				String allot = request.getParameter("allot");
				String bscId = request.getParameter("bscId");
				String factor = Util.getEUCKR(request.getParameter("factor"));
				String orderby = request.getParameter("orderby");
				
				String strR = "UPDATE TBLESTMEASUREDEFINE SET ALLOT=?,BSCID=?,FACTOR=?,MODIR=?,MODIDATE=SYSDATE,ORDERBY=? WHERE YEAR=? AND MEASUREID=?";
				Object[] pmR = {allot,bscId,factor,userId,orderby,year,measureId};
				
				dbobject.executePreparedUpdate(strR,pmR);
			} else if ("D".equals(mode)) {
				String mid = request.getParameter("measure");
				
				String strD = "DELETE FROM TBLESTMEASUREDEFINE WHERE YEAR=? AND MEASUREID=?";
				Object[] pmD = {year,mid};
				
				dbobject.executePreparedUpdate(strD,pmD);
				
			} 
			StringBuffer strG = new StringBuffer();
				strG.append("SELECT S.NAME SNAME,M.ID MID,M.SECTIONID,M.NAME MNAME,D.YEAR,D.ALLOT,(SELECT NAME FROM TBLBSC WHERE ID=D.BSCID) BNAME, ")
					.append(" D.FACTOR,D.BSCID,D.ORDERBY FROM TBLESTSECTION S,TBLESTMEASURE M,TBLESTMEASUREDEFINE D ")
					.append(" WHERE S.ID=M.SECTIONID AND D.MEASUREID=M.ID AND D.YEAR=? ORDER BY ORDERBY");
			Object[] pmG = {year};
			
			rs = dbobject.executePreparedQuery(strG.toString(),pmG);
			
			DataSet ds = new DataSet(rs);
			request.setAttribute("ds",ds);
			
			conn.commit();
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
	}
	
	
	public void setAdminBuzMeaDetail(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String userId = (String) request.getSession().getAttribute("userId");
			if (userId==null) return;
			
			
			String strSec = "SELECT * FROM TBLESTSECTION";
			if (rs!=null){ rs.close(); rs=null;}
			rs = dbobject.executeQuery(strSec);
			DataSet dsSec = new DataSet(rs);
			request.setAttribute("dsSec",dsSec);
			
			String strBSC = "SELECT * FROM TBLBSC";
			if (rs!=null){ rs.close(); rs=null;}
			rs = dbobject.executeQuery(strBSC);
			DataSet dsBSC = new DataSet(rs);
			request.setAttribute("dsBSC",dsBSC);
			
			String strMea = "SELECT * FROM TBLESTMEASURE";
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executeQuery(strMea);
			DataSet dsMea = new DataSet(rs);
			request.setAttribute("dsMea",dsMea);
			
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
	}	
	
	public void setAdminBuzAllot(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			/*
			 * 1. 평가지표목록을 가져온다.
			 * 2. 부서목록 정보를 가져온다.
			 * 3. 가중치 정보를 가져온다.
			 */
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			
			if ("A".equals(mode)) {

				
				String pmMeas = request.getParameter("pmMeas")!=null?request.getParameter("pmMeas"):"";
				String pmDivs = request.getParameter("pmDivs")!=null?request.getParameter("pmDivs"):"";
				
				String strI = "INSERT INTO TBLESTDETAIL (YEAR,DIVISIONID,MID,ALLOT) VALUES (?,?,?,?)";
				Object[] pmI = {year,null,null,null};
				String strU = "UPDATE TBLESTDETAIL SET ALLOT=? WHERE YEAR=? AND DIVISIONID=? AND MID=?";
				Object[] pmU = {null,year,null,null};
				String strD = "DELETE FROM TBLESTDETAIL WHERE YEAR=? AND DIVISIONID=? AND MID=?";
				Object[] pmD = {year,null,null};
				
				String[] meas = pmMeas.split("\\|");
				String[] divs = pmDivs.split("\\|");
				
				for (int i = 0; i < meas.length; i++) {
					String mid = meas[i];
					if ((mid!=null)&&(!mid.equals(""))){
						for (int j = 0; j < divs.length; j++) {
							String div = divs[j];
							if ((div!=null)&&(!"".equals(div))){
								String dtl = request.getParameter("dtl|"+mid+"|"+div);
								if ((dtl!=null)&&(!"".equals(dtl))){
									pmU[0]=dtl;
									pmU[2]=div;
									pmU[3]=mid;
									if (dbobject.executePreparedUpdate(strU,pmU)<1){
										pmI[1]=div;
										pmI[2]=mid;
										pmI[3]=dtl;
										dbobject.executePreparedUpdate(strI,pmI);
									}
								} else {
									pmD[1]=div;
									pmD[2]=mid;
									dbobject.executePreparedUpdate(strD,pmD);
								}
							}
						}
					}
				}
				conn.commit();
			} else if ("D".equals(mode)) {
				String strD = "DELETE FROM TBLESTDETAIL WHERE YEAR=?";
				Object[] pmD = {year};
				
				dbobject.executePreparedUpdate(strD,pmD);
				
				conn.commit();
			}
			
			EstManager manager = new EstManager();
			String strDiv = "SELECT * FROM TBLESTDIVISION ";
			if (rs!=null){ rs.close(); rs=null;}
			rs = dbobject.executeQuery(strDiv);
			while(rs.next()){
				manager.setDivision(rs);
			}
			
			StringBuffer strMea = new StringBuffer();
			strMea.append("SELECT S.NAME SNAME,M.ID MID,M.SECTIONID,M.NAME MNAME,D.YEAR,D.ALLOT,(SELECT NAME FROM TBLBSC WHERE ID=D.BSCID) BNAME, ")
				.append(" D.FACTOR,D.BSCID,D.ORDERBY FROM TBLESTSECTION S,TBLESTMEASURE M,TBLESTMEASUREDEFINE D ")
				.append(" WHERE S.ID=M.SECTIONID AND D.MEASUREID=M.ID AND YEAR=? " );
			Object[] pmMea = {year};
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strMea.toString(),pmMea);
			while(rs.next()){
				manager.setMeasure(rs);
			}
			
			String strDtl = "SELECT * FROM TBLESTDETAIL WHERE YEAR=?";
			Object[] pmDtl = {year};
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strDtl,pmDtl);
			while(rs.next()){
				manager.setDetails(rs);
			}
			
			request.setAttribute("manager",manager);			
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
	}
	
	public void setAdminBuzResultRegi(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			String userId = (String)request.getSession().getAttribute("userId");
			if (userId==null) return;
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			if ("A".equals(mode)) {
				String pmMeas = request.getParameter("pmMeas")!=null?request.getParameter("pmMeas"):"";
				String pmComs = request.getParameter("pmComs")!=null?request.getParameter("pmComs"):"";
				
				String strI = "INSERT INTO TBLESTSCORE (YEAR,COMID,MID,SCORE,REGIR,REGIDATE) VALUES (?,?,?,?,?,SYSDATE)";
				Object[] pmI = {year,null,null,null,userId};
				String strU = "UPDATE TBLESTSCORE SET SCORE=?,MODIR=?,MODIDATE=SYSDATE WHERE YEAR=? AND COMID=? AND MID=?";
				Object[] pmU = {null,userId,year,null,null};
				String strD = "DELETE FROM TBLESTSCORE WHERE YEAR=? AND COMID=? AND MID=?";
				Object[] pmD = {year,null,null};
				
				String[] meas = pmMeas.split("\\|");
				String[] coms = pmComs.split("\\|");
				
				for (int i = 0; i < meas.length; i++) {
					String mid = meas[i];
					if ((mid!=null)&&(!mid.equals(""))){
						for (int j = 0; j < coms.length; j++) {
							String com = coms[j];
							if ((com!=null)&&(!"".equals(com))){
								String scr = request.getParameter("scr|"+mid+"|"+com);
								if ((scr!=null)&&(!"".equals(scr))){
									pmU[0]=scr;
									pmU[3]=com;
									pmU[4]=mid;
									if (dbobject.executePreparedUpdate(strU,pmU)<1){
										pmI[1]=com;
										pmI[2]=mid;
										pmI[3]=scr;
										dbobject.executePreparedUpdate(strI,pmI);
									}
								} else {
									pmD[1]=com;
									pmD[2]=mid;
									dbobject.executePreparedUpdate(strD,pmD);
								}
							}
						}
					}
				}
				
				StringBuffer strUR = new StringBuffer();  // UPDATE RANK;;;
				strUR.append("UPDATE TBLESTSCORE E SET RANK= ")
					.append(" (SELECT SRANK FROM (SELECT S.*,RANK() OVER (PARTITION BY MID ORDER BY SCORE DESC) SRANK FROM ( ")
					.append(" SELECT * FROM TBLESTSCORE WHERE YEAR=?) S) R WHERE R.MID=E.MID AND R.COMID=E.COMID) ");
				Object[] pmUR = {year};
				
				dbobject.executePreparedUpdate(strUR.toString(),pmUR);
				
				StringBuffer strUA = new StringBuffer();   // update average;;;
				strUA.append("UPDATE TBLESTSCORE E SET AVG=(SELECT AV FROM ( ")
					.append(" SELECT YEAR,MID,AV FROM ")
					.append(" (SELECT S.*,((SUM(SCORE) OVER (PARTITION BY MID))-(MAX(SCORE) OVER (PARTITION BY MID))-(MIN(SCORE) OVER (PARTITION BY MID)))/((COUNT(SCORE) OVER (PARTITION BY MID))-2) AV ") 
					.append(" FROM ( SELECT * FROM TBLESTSCORE WHERE YEAR=? AND COMID <> 1) S ) GROUP BY YEAR,MID,AV ")
					.append(" ) SS WHERE SS.MID=E.MID AND E.COMID=1 AND E.YEAR=?) ");
				Object[] pmUA = {year,year};
				dbobject.executePreparedUpdate(strUA.toString(),pmUA);
				
				StringBuffer sbUD = new StringBuffer();  // update differ
				sbUD.append("UPDATE TBLESTSCORE SET DIFFER=SCORE-AVG WHERE YEAR=? AND COMID=1");
				dbobject.executePreparedUpdate(sbUD.toString(),pmUR);
				
				conn.commit();
			} else if ("D".equals(mode)) {
				String strD = "DELETE FROM TBLESTSCORE WHERE YEAR=?";
				Object[] pmD = {year};
				
				dbobject.executePreparedUpdate(strD,pmD);
				
				conn.commit();
			} else if ("WA".equals(mode)) {
				String pmMeas = request.getParameter("pmMeas")!=null?request.getParameter("pmMeas"):"";
				String strU = "UPDATE TBLESTSCORE SET ALLOTAVG=?,MODIR=?,MODIDATE=SYSDATE WHERE YEAR=? AND COMID=1 AND MID=?";
				Object[] pmU = {null,userId,year,null};
				String[] meas = pmMeas.split("\\|");
				
				for (int i = 0; i < meas.length; i++) {
					String mid = meas[i];
					if ((mid!=null)&&(!mid.equals(""))){
						String allotW = request.getParameter("allotWeight"+mid);
						if (allotW!=null){
							pmU[0]=allotW;
							pmU[3]=mid;
							dbobject.executePreparedUpdate(strU,pmU);
						}
					}
				}
				String strUD = "UPDATE TBLESTSCORE SET ALLOTDIFFER=ALLOTAVG-RANK WHERE YEAR=? AND COMID=1";
				Object[] pmUD = {year};
				dbobject.executePreparedUpdate(strUD,pmUD);
				
				conn.commit();
			} else if ("WD".equals(mode)) {
				String strWD = "UPDATE TBLESTSCORE SET ALLOTAVG=NULL,ALLOTDIFFER=NULL WHERE YEAR=?";
				Object[] pmWD = {year};
				
				dbobject.executePreparedUpdate(strWD,pmWD);
				conn.commit();
			}
			
			
			EstScrManager manager = new EstScrManager();
			String strC = "SELECT * FROM TBLESTCOMPANY ORDER BY ORDERBY";
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executeQuery(strC);
			while(rs.next())
				manager.setCompany(rs);
			
			StringBuffer sbM = new StringBuffer(); 
			sbM.append("SELECT S.NAME SNAME,M.ID MID,M.SECTIONID,M.NAME MNAME,D.YEAR,D.ALLOT,(SELECT NAME FROM TBLBSC WHERE ID=D.BSCID) BNAME,")
			.append(" D.FACTOR,D.BSCID,D.ORDERBY FROM TBLESTSECTION S,TBLESTMEASURE M,TBLESTMEASUREDEFINE D")
			.append(" WHERE S.ID=M.SECTIONID AND D.MEASUREID=M.ID AND YEAR=?");	
			Object[] pmM = {year};
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(sbM.toString(),pmM);
			while (rs.next())
				manager.setMeasure(rs);
			
			StringBuffer strS = new StringBuffer();
			strS.append("SELECT * FROM ")
				.append(" (SELECT * FROM TBLESTSCORE WHERE YEAR=?) B ")
				.append(" LEFT JOIN ")
				.append(" (SELECT YEAR B1YEAR,COMID B1COMID,MID B1MID,RANK B1RANK FROM TBLESTSCORE WHERE YEAR=?) B1 ")
				.append(" ON B.COMID=B1.B1COMID AND B.MID=B1.B1MID ")
				.append(" LEFT JOIN ")
				.append(" (SELECT YEAR B2YEAR,COMID B2COMID,MID B2MID,RANK B2RANK FROM TBLESTSCORE WHERE YEAR=?) B2 ")
				.append(" ON B.COMID=B2.B2COMID AND B.MID=B2.B2MID ")
				.append(" LEFT JOIN ")
				.append(" (SELECT YEAR B3YEAR,COMID B3COMID,MID B3MID,RANK B3RANK FROM TBLESTSCORE WHERE YEAR=?) B3 ")
				.append(" ON B.COMID=B3.B3COMID AND B.MID=B3.B3MID ");
			
			Object[] pmS = {year,String.valueOf(Integer.parseInt(year)-1),String.valueOf(Integer.parseInt(year)-2),String.valueOf(Integer.parseInt(year)-3)};
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strS.toString(),pmS);
			
			while(rs.next()){
				manager.setScore(rs);
			}
			
			request.setAttribute("manager",manager);
			request.setAttribute("years",pmS);
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
	}
	
	public void setAdminBuzScore(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			String year = request.getParameter("year");
			if (year==null) return;
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			if ("A".equals(mode)) {
				String pmMeas = request.getParameter("pmMeas")!=null?request.getParameter("pmMeas"):"";
				String pmDivs = request.getParameter("pmDivs")!=null?request.getParameter("pmDivs"):"";
				
				String strU = "UPDATE TBLESTDETAIL SET EARNSCR=? WHERE YEAR=? AND DIVISIONID=? AND MID=?";
				Object[] pmU = {null,year,null,null};
				
				String[] meas = pmMeas.split("\\|");
				String[] divs = pmDivs.split("\\|");
				
				for (int i = 0; i < meas.length; i++) {
					String mid = meas[i];
					if ((mid!=null)&&(!mid.equals(""))){
						for (int j = 0; j < divs.length; j++) {
							String div = divs[j];
							if ((div!=null)&&(!"".equals(div))){
								String dtl = request.getParameter("dtl|"+mid+"|"+div);
								if ((dtl!=null)&&(!"".equals(dtl))){
									pmU[0]=dtl;
									pmU[2]=div;
									pmU[3]=mid;
									dbobject.executePreparedUpdate(strU,pmU);
								} else {
									pmU[0]=null;
									pmU[2]=div;
									pmU[3]=mid;
									dbobject.executePreparedUpdate(strU,pmU);
								}
							}
						}
					}
				}
				conn.commit();
			} else if ("R".equals(mode)) {
				String strD = "UPDATE TBLESTDETAIL SET EARNSCR=NULL WHERE YEAR=?";
				Object[] pmD = {year};
				
				dbobject.executePreparedUpdate(strD,pmD);
				
				conn.commit();
			}
			
			
			
			EstManager manager = new EstManager();
			String strDiv = "SELECT * FROM TBLESTDIVISION ";
			if (rs!=null){ rs.close(); rs=null;}
			rs = dbobject.executeQuery(strDiv);
			while(rs.next()){
				manager.setDivision(rs);
			}
			
			StringBuffer strMea = new StringBuffer();
			strMea.append("SELECT * FROM ( ")
				.append(" SELECT S.NAME SNAME,M.ID MID,M.SECTIONID,M.NAME MNAME,D.YEAR,D.ALLOT,(SELECT NAME FROM TBLBSC WHERE ID=D.BSCID) BNAME, ") 
				.append(" D.FACTOR,D.BSCID,D.ORDERBY FROM TBLESTSECTION S,TBLESTMEASURE M,TBLESTMEASUREDEFINE D  ")
				.append(" WHERE S.ID=M.SECTIONID AND D.MEASUREID=M.ID AND YEAR=? ")
				.append(" ) MEA ")
				.append(" LEFT JOIN ")
				.append(" (SELECT MID SMID,SCORE,RANK,AVG,ALLOTAVG,ALLOTDIFFER,DIFFER FROM TBLESTSCORE WHERE COMID=1 AND YEAR=?) SCR ")
				.append(" ON MEA.MID=SCR.SMID" );
			
			Object[] pmMea = {year,year};
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strMea.toString(),pmMea);
			while(rs.next()){
				manager.setMeasureDetail(rs);
			}
			
			String strDtl = "SELECT * FROM TBLESTDETAIL WHERE YEAR=?";
			Object[] pmDtl = {year};
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strDtl,pmDtl);
			while(rs.next()){
				manager.setDetailsScore(rs,0);
			}
			
			request.setAttribute("manager",manager);
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
	}
	
	public void setAdminBuzScore01(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			String year = request.getParameter("year");
			if (year==null) return;
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			if ("A".equals(mode)) {
				String pmMeas = request.getParameter("pmMeas")!=null?request.getParameter("pmMeas"):"";
				String pmDivs = request.getParameter("pmDivs")!=null?request.getParameter("pmDivs"):"";
				
				String strU = "UPDATE TBLESTDETAIL SET RANKSCR=? WHERE YEAR=? AND DIVISIONID=? AND MID=?";
				Object[] pmU = {null,year,null,null};
				
				String[] meas = pmMeas.split("\\|");
				String[] divs = pmDivs.split("\\|");
				
				for (int i = 0; i < meas.length; i++) {
					String mid = meas[i];
					if ((mid!=null)&&(!mid.equals(""))){
						for (int j = 0; j < divs.length; j++) {
							String div = divs[j];
							if ((div!=null)&&(!"".equals(div))){
								String dtl = request.getParameter("dtl|"+mid+"|"+div);
								if ((dtl!=null)&&(!"".equals(dtl))){
									pmU[0]=dtl;
									pmU[2]=div;
									pmU[3]=mid;
									dbobject.executePreparedUpdate(strU,pmU);
								} else {
									pmU[0]=null;
									pmU[2]=div;
									pmU[3]=mid;
									dbobject.executePreparedUpdate(strU,pmU);
								}
							}
						}
					}
				}
				conn.commit();
			} else if ("R".equals(mode)) {
				String strD = "UPDATE TBLESTDETAIL SET RANKSCR=NULL WHERE YEAR=?";
				Object[] pmD = {year};
				
				dbobject.executePreparedUpdate(strD,pmD);
				
				conn.commit();
			}
			
			
			
			EstManager manager = new EstManager();
			String strDiv = "SELECT * FROM TBLESTDIVISION ";
			if (rs!=null){ rs.close(); rs=null;}
			rs = dbobject.executeQuery(strDiv);
			while(rs.next()){
				manager.setDivision(rs);
			}
			
			StringBuffer strMea = new StringBuffer();
			strMea.append("SELECT * FROM ( ")
				.append(" SELECT S.NAME SNAME,M.ID MID,M.SECTIONID,M.NAME MNAME,D.YEAR,D.ALLOT,(SELECT NAME FROM TBLBSC WHERE ID=D.BSCID) BNAME, ") 
				.append(" D.FACTOR,D.BSCID,D.ORDERBY FROM TBLESTSECTION S,TBLESTMEASURE M,TBLESTMEASUREDEFINE D  ")
				.append(" WHERE S.ID=M.SECTIONID AND D.MEASUREID=M.ID AND YEAR=? ")
				.append(" ) MEA ")
				.append(" LEFT JOIN ")
				.append(" (SELECT MID SMID,SCORE,RANK,AVG,ALLOTAVG,ALLOTDIFFER,DIFFER FROM TBLESTSCORE WHERE COMID=1 AND YEAR=?) SCR ")
				.append(" ON MEA.MID=SCR.SMID" );
			
			Object[] pmMea = {year,year};
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strMea.toString(),pmMea);
			while(rs.next()){
				manager.setMeasureDetail(rs);
			}
			
			String strDtl = "SELECT * FROM TBLESTDETAIL WHERE YEAR=?";
			Object[] pmDtl = {year};
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strDtl,pmDtl);
			while(rs.next()){
				manager.setDetailsScore(rs,1);
			}
			
			request.setAttribute("manager",manager);
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
	}
	
	public void setAdminBuzScore02(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			String year = request.getParameter("year");
			if (year==null) return;
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			if ("A".equals(mode)) {
				String pmMeas = request.getParameter("pmMeas")!=null?request.getParameter("pmMeas"):"";
				String pmDivs = request.getParameter("pmDivs")!=null?request.getParameter("pmDivs"):"";
				
				String strU = "UPDATE TBLESTDETAIL SET ACHIVSCR=? WHERE YEAR=? AND DIVISIONID=? AND MID=?";
				Object[] pmU = {null,year,null,null};
				
				String[] meas = pmMeas.split("\\|");
				String[] divs = pmDivs.split("\\|");
				
				for (int i = 0; i < meas.length; i++) {
					String mid = meas[i];
					if ((mid!=null)&&(!mid.equals(""))){
						for (int j = 0; j < divs.length; j++) {
							String div = divs[j];
							if ((div!=null)&&(!"".equals(div))){
								String dtl = request.getParameter("dtl|"+mid+"|"+div);
								if ((dtl!=null)&&(!"".equals(dtl))){
									pmU[0]=dtl;
									pmU[2]=div;
									pmU[3]=mid;
									dbobject.executePreparedUpdate(strU,pmU);
								} else {
									pmU[0]=null;
									pmU[2]=div;
									pmU[3]=mid;
									dbobject.executePreparedUpdate(strU,pmU);
								}
							}
						}
					}
				}
				conn.commit();
			} else if ("R".equals(mode)) {
				String strD = "UPDATE TBLESTDETAIL SET ACHIVSCR=NULL WHERE YEAR=?";
				Object[] pmD = {year};
				
				dbobject.executePreparedUpdate(strD,pmD);
				
				conn.commit();
			}
			
			EstManager manager = new EstManager();
			String strDiv = "SELECT * FROM TBLESTDIVISION ";
			if (rs!=null){ rs.close(); rs=null;}
			rs = dbobject.executeQuery(strDiv);
			while(rs.next()){
				manager.setDivision(rs);
			}
			
			StringBuffer strMea = new StringBuffer();
			strMea.append("SELECT * FROM ( ")
				.append(" SELECT S.NAME SNAME,M.ID MID,M.SECTIONID,M.NAME MNAME,D.YEAR,D.ALLOT,(SELECT NAME FROM TBLBSC WHERE ID=D.BSCID) BNAME, ") 
				.append(" D.FACTOR,D.BSCID,D.ORDERBY FROM TBLESTSECTION S,TBLESTMEASURE M,TBLESTMEASUREDEFINE D  ")
				.append(" WHERE S.ID=M.SECTIONID AND D.MEASUREID=M.ID AND YEAR=? ")
				.append(" ) MEA ")
				.append(" LEFT JOIN ")
				.append(" (SELECT MID SMID,SCORE,RANK,AVG,ALLOTAVG,ALLOTDIFFER,DIFFER FROM TBLESTSCORE WHERE COMID=1 AND YEAR=?) SCR ")
				.append(" ON MEA.MID=SCR.SMID" );
			
			Object[] pmMea = {year,year};
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strMea.toString(),pmMea);
			while(rs.next()){
				manager.setMeasureDetail(rs);
			}
			
			String strDtl = "SELECT * FROM TBLESTDETAIL WHERE YEAR=?";
			Object[] pmDtl = {year};
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strDtl,pmDtl);
			while(rs.next()){
				manager.setDetailsScore(rs,2);
			}
			
			request.setAttribute("manager",manager);
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
	}
	
	public void setAdminBuzScoreFinal (HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			if ("A".equals(mode)) {
				String pmDivs = request.getParameter("pmDivs");
				StringBuffer strU = new StringBuffer();
				strU.append("UPDATE TBLESTDIVISIONSCORE SET WEIGHT00=?,WEIGHT01=?,WEIGHT02=?,DISTRIBUTE00=?,DISTRIBUTE01=?,DISTRIBUTE02=?, ")
					.append(" SCORE00=?,SCORE01=?,SCORE02=? WHERE DIVISIONID=? AND YEAR=? ");
				Object[] pmU = {null,null,null, null,null,null, null,null,null, null,null};
				
				StringBuffer strI = new StringBuffer();
				strI.append("INSERT INTO TBLESTDIVISIONSCORE (DIVISIONID,YEAR,SCORE00,SCORE01,SCORE02,WEIGHT00,WEIGHT01,WEIGHT02,DISTRIBUTE00,DISTRIBUTE01,DISTRIBUTE02) ")
					.append(" VALUES (?,?,?,?,?, ?,?,?,?,?, ?) ");
				Object[] pmI = {null,null, null,null,null, null,null,null, null,null,null};
				
				String[] divs = pmDivs.split("\\|");
				
				for (int i = 0; i < divs.length; i++) {
					String did = divs[i];
					if ((did!=null)&&(!"".equals(did))){
						String wgt0 = request.getParameter("w00");
						String wgt1 = request.getParameter("w01");
						String wgt2 = request.getParameter("w02");
						String dis0 = request.getParameter("d00");
						String dis1 = request.getParameter("d01");
						String dis2 = request.getParameter("d02");
						
						String scr0 = request.getParameter("s00_"+did);
						String scr1 = request.getParameter("s01_"+did);
						String scr2 = request.getParameter("s02_"+did);
						
						pmU[0] = wgt0; 
						pmU[1] = wgt1;
						pmU[2] = wgt2;
						pmU[3] = dis0;
						pmU[4] = dis1;
						pmU[5] = dis2;
						pmU[6] = scr0;
						pmU[7] = scr1;
						pmU[8] = scr2;
						
						pmU[9] = did;
						pmU[10] = year;
						
						if (dbobject.executePreparedUpdate(strU.toString(),pmU)<1){
							pmI[0]=did;
							pmI[1]=year;
							
							pmI[2]=scr0;
							pmI[3]=scr1;
							pmI[4]=scr2;
							pmI[5]=wgt0;
							pmI[6]=wgt1;
							pmI[7]=wgt2;
							pmI[8]=dis0;
							pmI[9]=dis1;
							pmI[10]=dis2;
							
							dbobject.executePreparedUpdate(strI.toString(),pmI);
						}
					}
				}
				
				StringBuffer strR0 = new StringBuffer();
				strR0.append( "UPDATE TBLESTDIVISIONSCORE S SET RANK00= ")
					.append(" (SELECT SRANK FROM (SELECT S.*, RANK() OVER (PARTITION BY YEAR ORDER BY SCORE00 DESC) SRANK FROM TBLESTDIVISIONSCORE S WHERE YEAR=?) R ") 
					.append(" WHERE R.DIVISIONID=S.DIVISIONID  ) WHERE YEAR=? ");
				Object[] pmR = {year,year};
				
				dbobject.executePreparedUpdate(strR0.toString(),pmR);

				StringBuffer strR1 = new StringBuffer();
				strR1.append( "UPDATE TBLESTDIVISIONSCORE S SET RANK01= ")
					.append(" (SELECT SRANK FROM (SELECT S.*, RANK() OVER (PARTITION BY YEAR ORDER BY SCORE01 DESC) SRANK FROM TBLESTDIVISIONSCORE S WHERE YEAR=?) R ") 
					.append(" WHERE R.DIVISIONID=S.DIVISIONID  ) WHERE YEAR=? ");
				
				dbobject.executePreparedUpdate(strR1.toString(),pmR);
				
				StringBuffer strR2 = new StringBuffer();
				strR2.append( "UPDATE TBLESTDIVISIONSCORE S SET RANK02= ")
					.append(" (SELECT SRANK FROM (SELECT S.*, RANK() OVER (PARTITION BY YEAR ORDER BY SCORE02 DESC) SRANK FROM TBLESTDIVISIONSCORE S WHERE YEAR=?) R ") 
					.append(" WHERE R.DIVISIONID=S.DIVISIONID  ) WHERE YEAR=? ");
				
				dbobject.executePreparedUpdate(strR2.toString(),pmR);
				
				conn.commit();
			} else if ("R".equals(mode)) {
				String strD = "DELETE FROM TBLESTDIVISIONSCORE WHERE YEAR=?";
				Object[] pmD = {year};
				
				dbobject.executePreparedUpdate(strD,pmD);
				
				conn.commit();
			}
			StringBuffer strG = new StringBuffer();
			strG.append("SELECT * FROM ( ")
				.append(" SELECT * FROM TBLESTDIVISION ")
				.append(" ) DIV ")
				.append(" LEFT JOIN ")
				.append(" (SELECT * FROM TBLESTDIVISIONSCORE WHERE YEAR=?) SCR ")
				.append(" ON DIV.ID=SCR.DIVISIONID ")
				.append(" ORDER BY ORDERBY ");
			Object[] pmG = {year};
			
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(strG.toString(),pmG);
			
			ArrayList list = new ArrayList();
			
			while(rs.next()){
				EstFinalScore scr = new EstFinalScore();
				scr.year = new Integer(year).intValue();
				scr.divisionId = rs.getInt("ID");
				scr.distribute[0] = rs.getDouble("DISTRIBUTE00");
				scr.distribute[1] = rs.getDouble("DISTRIBUTE01");
				scr.distribute[2] = rs.getDouble("DISTRIBUTE02");
				scr.weight[0] = rs.getDouble("WEIGHT00");
				scr.weight[1] = rs.getDouble("WEIGHT01");
				scr.weight[2] = rs.getDouble("WEIGHT02");
				
				scr.score[0] = rs.getDouble("SCORE00");
				scr.score[1] = rs.getDouble("SCORE01");
				scr.score[2] = rs.getDouble("SCORE02");
				scr.dName = rs.getString("NAME");
				
				list.add(scr);
			}
			
			request.setAttribute("list",list);
			
			String strScr = "SELECT SUM(EARNSCR) ESCR,SUM(RANKSCR) RSCR,SUM(ACHIVSCR) ASCR, YEAR,DIVISIONID FROM TBLESTDETAIL GROUP BY YEAR,DIVISIONID HAVING YEAR=?";
			Object[] pmScr = {year};
			
			if (rs!=null){ rs.close(); rs=null; }
			rs = dbobject.executePreparedQuery(strScr,pmScr);
			
			DataSet dsSCR = new DataSet(rs);
			
			request.setAttribute("dsSCR",dsSCR);
			
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
	}	
}
