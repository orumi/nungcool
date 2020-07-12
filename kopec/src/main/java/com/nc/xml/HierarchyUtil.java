package com.nc.xml;

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

public class HierarchyUtil {
	public void getHierarchy(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM  ")
	         .append(" (SELECT T.ID CID,T.PARENTID CPID,T.CONTENTID CCID,T.TREELEVEL CLEVEL,T.RANK CRANK,T.WEIGHT CWEIGHT,C.NAME CNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLCOMPANY C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=0 AND T.YEAR=? ) COM ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? ) SBU ")
	         .append(" ON COM.CID=SBU.SPID ")
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
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" ORDER BY CRANK,SRANK,SID,BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");

	         Object[] params = {year,year,year,year,year,year};

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

	public void getComponent(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT 0 KD,ID,NAME FROM TBLCOMPANY ")
				.append(" UNION ")
				.append(" SELECT 1 KD,ID,NAME FROM TBLSBU ")
				.append(" UNION ")
				.append(" SELECT 2 KD,ID,NAME FROM TBLBSC ")
				.append(" UNION ")
				.append(" SELECT 3 KD,ID,NAME FROM TBLPST ")
				.append(" UNION ")
				.append(" SELECT 4 KD,ID,NAME FROM TBLOBJECTIVE ")
				.append(" UNION ")
				.append(" SELECT 5 KD,ID,NAME FROM TBLMEASURE ORDER BY KD,NAME");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executeQuery(sb.toString());

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

	public void updateNode(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year");
			String mode = request.getParameter("mode");
			String level = request.getParameter("level");
			int lvl = Integer.valueOf(level).intValue();

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String tId = "";
			dbobject = new DBObject(conn.getConnection());
			String tbl = "TBLHIERARCHY";

			if ("new".equals(mode)){
				String pid = request.getParameter("pid");
				String cid = request.getParameter("cid");
				String weight = request.getParameter("weight");
				String orderby = request.getParameter("orderby");
				lvl++;
				if (lvl==0) pid="0";


				if (lvl>2) tbl ="TBLTREESCORE";
				tId = String.valueOf(dbobject.getNextId(tbl));		// nextID
				String strI = "INSERT INTO "+tbl+" (ID,PARENTID,CONTENTID,TREELEVEL,RANK,INPUTDATE,YEAR,WEIGHT) VALUES (?,?,?,?,?,?,?,?)";
				Object[] paramI = {tId,pid,cid,String.valueOf(lvl),orderby,Util.getToDayTime().substring(0,14),year,weight};

				dbobject.executePreparedUpdate(strI,paramI);

			} else if ("mod".equals(mode)){
				String id      = request.getParameter("id");
				String weight  = request.getParameter("weight");
				String orderby = request.getParameter("orderby");
				tId = id;
				if (lvl>2) tbl="TBLTREESCORE";
				String strU = "UPDATE "+tbl+" SET WEIGHT=?,RANK=? WHERE ID=? AND TREELEVEL=? AND YEAR=?";
				Object[] paramU = {weight,orderby,id,level,year};

				dbobject.executePreparedUpdate(strU,paramU);
			}
			String tblCom = "TBLCOMPANY";
			if (lvl==1) tblCom ="TBLSBU";
			else if (lvl==2) tblCom="TBLBSC";
			else if (lvl==3) tblCom="TBLPST";
			else if (lvl==4) tblCom="TBLOBJECTIVE";

			StringBuffer sb = new StringBuffer();
			sb.append("SELECT T.ID,T.PARENTID,T.CONTENTID,T.TREELEVEL,T.RANK,T.YEAR,T.WEIGHT,C.NAME FROM "+tbl+" T,"+tblCom+" C WHERE T.CONTENTID=C.ID AND T.ID=? AND T.YEAR=?");
			Object[] params = {tId,year};

			rs = dbobject.executePreparedQuery(sb.toString(),params);

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

	public void deleteNode(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year");
			String mode = request.getParameter("mode");
			String level = request.getParameter("level");
			int lvl = Integer.valueOf(level).intValue();

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String tId = "";
			dbobject = new DBObject(conn.getConnection());
			String tbl = "TBLHIERARCHY";
			String tblCom = "TBLCOMPANY";
			if (lvl==1) tblCom ="TBLSBU";
			else if (lvl==2) tblCom="TBLBSC";
			else if (lvl==3) tblCom="TBLPST";
			else if (lvl==4) tblCom="TBLOBJECTIVE";

			if ("del".equals(mode)){
				String id = request.getParameter("id");

				if (lvl>2) tbl ="TBLTREESCORE";
				String strI = "DELETE FROM "+tbl+" WHERE ID=? AND TREELEVEL=? AND YEAR=?";
				Object[] paramI = {id,level,year};

				dbobject.executePreparedUpdate(strI,paramI);
				conn.commit();
			}

			request.setAttribute("result", "true");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public void insertMeasure(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year");
			String updater = (String)request.getSession().getAttribute("userId");
			if (updater==null) {
				request.setAttribute("equ","sessionOUT");
				return;
			}

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			String tid="";
			String mcid= request.getParameter("mcid");
			String objId = request.getParameter("objId");

			StringBuffer sbI = new StringBuffer();
			sbI.append("INSERT INTO TBLMEASUREDEFINE (ID,MEASUREID,UPDATEID,  WEIGHT,PLANNED,  BASE,LIMIT,FREQUENCY,MEASUREMENT,TREND,YEAR )")
				.append(" VALUES (?,?,?,0,0,  0,0, '월','계량','상향' ,?)");

			String mid = String.valueOf(dbobject.getNextId("TBLMEASUREDEFINE"));
			Object[] paramI = {mid,mcid,updater,year};

			dbobject.executePreparedQuery(sbI.toString(),paramI);

			String strI = "INSERT INTO TBLTREESCORE (ID,PARENTID,CONTENTID,TREELEVEL,RANK,INPUTDATE,YEAR,WEIGHT) VALUES (?,?,?,?,0,?,?,0)";

			tid=String.valueOf(dbobject.getNextId("TBLTREESCORE"));
			Object[] paramIC = {tid,objId,mid,"5",Util.getToDayTime().substring(0,14),year};
			dbobject.executePreparedQuery(strI.toString(),paramIC);

			String strUD = "DELETE FROM TBLAUTHORITY WHERE YEAR=? AND MEASUREID=? ";
			Object[] pmUD = {year,mid};

			dbobject.executePreparedUpdate(strUD,pmUD);

			conn.commit();


			String strS = "SELECT T.ID,T.PARENTID,T.CONTENTID,T.TREELEVEL,T.RANK,T.YEAR,T.WEIGHT,C.NAME FROM TBLTREESCORE T,TBLMEASURE C,TBLMEASUREDEFINE D WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.ID=? AND T.YEAR=? ";
			Object[] paramS = {tid,year};

			rs = dbobject.executePreparedQuery(strS,paramS);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

			request.setAttribute("equ","true");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	public void updateMeasure(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			String year = request.getParameter("year");
			String mode = request.getParameter("mode");
			String level = request.getParameter("level");

			String mean = request.getParameter("mean").trim()==null?"":request.getParameter("mean").trim();
			String detail = request.getParameter("detail").trim()==null?"":request.getParameter("detail").trim();
			String etlkey = request.getParameter("etlkey")==null?"":request.getParameter("etlkey");
			String equDefine = request.getParameter("equDefine").trim()==null?"":request.getParameter("equDefine").trim();
			String datasource = request.getParameter("datasource")==null?"":request.getParameter("datasource").trim();
			String weight = request.getParameter("weight")==null?"":request.getParameter("weight");
			String orderby =request.getParameter("orderby")==null?"":request.getParameter("orderby");
			String unit = request.getParameter("unit").trim()==null?"":request.getParameter("unit").trim();
			String trend = request.getParameter("trend")==null?"":request.getParameter("trend");
			String frequecny = request.getParameter("frequency")==null?"":request.getParameter("frequency");
			String type=request.getParameter("type")==null?"":request.getParameter("type");
			String planned = request.getParameter("planned")==null?"":request.getParameter("planned");
			String plannedbase = request.getParameter("plannedbase")==null?"":request.getParameter("plannedbase");
			String base = request.getParameter("base")==null?"":request.getParameter("base");
			String baselimit = request.getParameter("baselimit")==null?"":request.getParameter("baselimit");
			String limit = request.getParameter("limit")==null?"":request.getParameter("limit");
			String equation = request.getParameter("equation").trim()==null?"": request.getParameter("equation").trim();
			String ya1=request.getParameter("ya1")==null?"":request.getParameter("ya1");
			String ya2=request.getParameter("ya2")==null?"":request.getParameter("ya2");
			String ya3=request.getParameter("ya3")==null?"":request.getParameter("ya3");
			String ya4=request.getParameter("ya4")==null?"":request.getParameter("ya4");
			String y=request.getParameter("y")==null?"":request.getParameter("y");
			String yb1=request.getParameter("yb1")==null?"":request.getParameter("yb1");
			String yb2=request.getParameter("yb2")==null?"":request.getParameter("yb2");
			String yb3=request.getParameter("yb3")==null?"":request.getParameter("yb3");
			String updateId = request.getParameter("updateId")==null?"":request.getParameter("updateId");
			String item = request.getParameter("item")==null?"":request.getParameter("item");

			String equType = request.getParameter("equType")==null?"":request.getParameter("equType");
			String ifsystem = request.getParameter("ifsystem")==null?"":request.getParameter("ifsystem").trim();
			String mngdeptnm = request.getParameter("mngdeptnm")==null?"":request.getParameter("mngdeptnm").trim();
			String targetrationle = request.getParameter("targetrationle")==null?"":request.getParameter("targetrationle").trim();
			String plannedflag = request.getParameter("plannedflag")==null?"":request.getParameter("plannedflag");

			String updater = request.getParameter("updater")==null?"":request.getParameter("updater");


			// 산식 체크 if
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			String tid="";


			if ("new".equals(mode)) {
				// store measuredefine

				String mcid= request.getParameter("mcid");
				String objId = request.getParameter("objId");

				StringBuffer sbI = new StringBuffer();
				sbI.append("INSERT INTO TBLMEASUREDEFINE (ID,MEASUREID,MEAN,DETAILDEFINE,DATASOURCE,ETLKEY,UPDATEID,WEIGHT,PLANNED,PLANNEDBASE,BASE,BASELIMIT,LIMIT ")
					.append(",FREQUENCY,MEASUREMENT,EQUATION,EQUATIONDEFINE,UNIT,TREND,YA1,YA2,YA3,YA4,Y,YB1,YB2,YB3,YEAR,EQUATIONTYPE, IFSYSTEM,MNGDEPTNM,TARGETRATIONLE, PLANNED_FLAG) ")
					.append(" VALUES (?,?,?,?,?,?,?,?,?,?,?,?,? ,?,?,?,?,?,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,?)");

				String mid = String.valueOf(dbobject.getNextId("TBLMEASUREDEFINE"));
				Object[] paramI = {mid,mcid,mean,detail,datasource,etlkey,updateId,weight,planned,plannedbase, base,baselimit,limit,   frequecny,type,equation,equDefine,unit,trend,ya1,ya2,ya3,ya4,  y,yb1,yb2,yb3,year, equType,ifsystem,mngdeptnm,targetrationle,plannedflag};

				dbobject.executePreparedQuery(sbI.toString(),paramI);
				// store items

				if (!"".equals(item.trim())){
					String[] items = item.split("`");
					String strItem = "INSERT INTO TBLITEM (CODE,MEASUREID,ITEMNAME,ITEMENTRY,ITEMFIXED) VALUES (?,?,?,?,?)";
					Object[] parItem = new Object[5];

					for (int i = 0; i < items.length; i++) {
						String[] iPart = items[i].split(",");
						parItem[0] = iPart[0];
						parItem[1] = mid;
						parItem[2] = iPart[1];
						parItem[3] = iPart[2];
						parItem[4] = iPart[3];

						dbobject.executePreparedUpdate(strItem,parItem);
					}
				}

				String strUD = "DELETE FROM TBLAUTHORITY WHERE YEAR=? AND MEASUREID=? ";
				Object[] pmUD = {year,mid};

				dbobject.executePreparedUpdate(strUD,pmUD);

				String strUI = "INSERT INTO TBLAUTHORITY (YEAR,MEASUREID,USERID) VALUES (?,?,?)";
				Object[] pmUI = {year,mid,null};
				if (!"".equals(updater.trim())){
					String[] updaters  = updater.split("`");
					String   tmpUserId = updaters[0];
					pmUI[2]=tmpUserId;

					dbobject.executePreparedUpdate(strUI,pmUI);
				}
				// add tbltreescore

				String strI = "INSERT INTO TBLTREESCORE (ID,PARENTID,CONTENTID,TREELEVEL,RANK,INPUTDATE,YEAR,WEIGHT) VALUES (?,?,?,?,?,?,?,?)";

				tid=String.valueOf(dbobject.getNextId("TBLTREESCORE"));
				Object[] paramIC = {tid,objId,mid,"5",orderby,Util.getToDayTime().substring(0,14),year,weight};
				dbobject.executePreparedQuery(strI.toString(),paramIC);

				conn.commit();

				//  목표값 자동생성
				setMeasDetailValue(year,mid);

			} else if ("mod".equals(mode)) {
				tid = request.getParameter("tid");
				String mid= request.getParameter("mid");
				//String objId = request.getParameter("objId");

				StringBuffer sbU = new StringBuffer();
				sbU.append("UPDATE TBLMEASUREDEFINE SET MEAN=?,DETAILDEFINE=?,DATASOURCE=?, ETLKEY=?,UPDATEID=?,WEIGHT=?,PLANNED=?,PLANNEDBASE=?,BASE=?,BASELIMIT=?,LIMIT=?")
					.append(",FREQUENCY=?,MEASUREMENT=?,EQUATION=?,EQUATIONDEFINE=?,UNIT=?,TREND=?,EQUATIONTYPE=?,YA1=?,YA2=?,YA3=?,YA4=?,Y=?,YB1=?,YB2=?,YB3=?, IFSYSTEM=?,MNGDEPTNM=?,TARGETRATIONLE=?, PLANNED_FLAG=? WHERE ID=? ");

				Object[] paramU = {mean,detail,datasource,etlkey,updateId,weight,planned,plannedbase,base,baselimit,limit,frequecny,type,equation,equDefine,unit,trend,equType,ya1,ya2,ya3,ya4,y,yb1,yb2,yb3,ifsystem,mngdeptnm,targetrationle, plannedflag, mid};

				dbobject.executePreparedQuery(sbU.toString(),paramU);
				// store items
				if (!"".equals(item.trim())){
					String[] items = item.split("`");
					String strItem = "INSERT INTO TBLITEM (CODE,MEASUREID,ITEMNAME,ITEMENTRY,ITEMFIXED, ITEMTYPE) VALUES (?,?,?,?,?,'현재값')";
					Object[] parItem = new Object[5];
					String strItemU ="UPDATE TBLITEM SET ITEMNAME=?,ITEMENTRY=?,ITEMFIXED=?,ITEMTYPE='현재값' WHERE CODE=? AND MEASUREID=?";
					Object[] parItemU = new Object[5];

					ArrayList a = new ArrayList();
					for (int i = 0; i < items.length; i++) {
						String[] iPart = items[i].split(",");
						parItemU[0] = iPart[1];
						parItemU[1] = iPart[2];
						parItemU[2] = iPart[3];
						parItemU[3] = iPart[0];
						parItemU[4] = mid;

						if (dbobject.executePreparedUpdate(strItemU,parItemU)<1){
							parItem[0] = iPart[0];
							parItem[1] = mid;
							parItem[2] = iPart[1];
							parItem[3] = iPart[2];
							parItem[4] = iPart[3];

							dbobject.executePreparedUpdate(strItem,parItem);
						}

						a.add(iPart[0]);

					}
					String aId = "";
					for (int j = 0; j < a.size(); j++) {
						if (j==0) aId = "'"+(String)a.get(j)+"'";
						else aId += ",'"+(String)a.get(j)+"'";
					}

					String strD = "DELETE FROM TBLITEM WHERE MEASUREID=? AND CODE NOT IN ("+aId+")";
					if (a.size()==0) strD = "DELETE FROM TBLITEM WHERE MEASUREID=?";
					dbobject.executePreparedUpdate(strD,new Object[]{mid});
				} else {
					String strD = "DELETE FROM TBLITEM WHERE MEASUREID=?";
					dbobject.executePreparedUpdate(strD,new Object[]{mid});
				}

				String strUD = "DELETE FROM TBLAUTHORITY WHERE YEAR=? AND MEASUREID=? ";
				Object[] pmUD = {year,mid};

				dbobject.executePreparedUpdate(strUD,pmUD);

				String strUI = "INSERT INTO TBLAUTHORITY (YEAR,MEASUREID,USERID) VALUES (?,?,?)";
				Object[] pmUI = {year,mid,null};
				if (!"".equals(updater.trim())){
					String[] updaters = updater.split("`");

					for (int m = 0; m < updaters.length; m++) {
						String[] tmpUserId = updaters[m].split(",");
						pmUI[2]=tmpUserId[0];

						dbobject.executePreparedUpdate(strUI,pmUI);
					}

				}


				// add tbltreescore
				String strU = "UPDATE TBLTREESCORE SET RANK=?,INPUTDATE=?,WEIGHT=? WHERE ID=? AND YEAR=?";

				Object[] paramUC = {orderby,Util.getToDayTime().substring(0,14),weight,tid,year};
				dbobject.executePreparedQuery(strU.toString(),paramUC);

				conn.commit();

				//  목표값 자동생성
				setMeasDetailValue(year,mid);
			}

			String strS = "SELECT T.ID,T.PARENTID,T.CONTENTID,T.TREELEVEL,T.RANK,T.YEAR,T.WEIGHT,C.NAME FROM TBLTREESCORE T,TBLMEASURE C,TBLMEASUREDEFINE D WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.ID=? AND T.YEAR=? ";
			Object[] paramS = {tid,year};

			rs = dbobject.executePreparedQuery(strS,paramS);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

			request.setAttribute("equ","true");
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public void deleteMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			String year = request.getParameter("year");
			String mode = request.getParameter("mode");

			if ("del".equals(mode)){
				String tid = request.getParameter("tid");
				String mid = request.getParameter("mid");

				String strI = "DELETE FROM TBLITEM WHERE MEASUREID=?";
				Object[] par = {mid};
				dbobject.executePreparedUpdate(strI,par);

				String strM = "DELETE FROM TBLMEASUREDEFINE WHERE ID=?";
				dbobject.executePreparedUpdate(strM,par);

				String strT = "DELETE FROM TBLTREESCORE WHERE ID=? AND TREELEVEL=5 AND YEAR=?";
				Object[] parT = {tid,year};

				dbobject.executePreparedUpdate(strT,parT);

				conn.commit();
			}

			request.setAttribute("result", "true");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public void getMeasure(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			String mid = request.getParameter("mid");
			String year = request.getParameter("year");

			//System.out.println(mid);

			StringBuffer strS = new StringBuffer();
			strS.append(" SELECT * FROM  ")
	         .append(" (SELECT D.ID,D.MEASUREID,D.DETAILDEFINE,D.WEIGHT,D.UNIT,D.PLANNED,D.FREQUENCY,D.EQUATION,D.EQUATIONDEFINE,D.UPDATEID,D.MEAN, ")
	         .append(" D.ETLKEY,D.MEASUREMENT,D.YEAR,D.TREND,D.BASE,D.LIMIT,D.Y,D.YA1,D.YA2,D.YA3,D.YA4,D.YB1,D.YB2,D.YB3,T.ID MTID,T.PARENTID MPID ")
	         .append(" ,C.NAME,T.RANK,D.EQUATIONTYPE, D.DATASOURCE, D.PLANNEDBASE, D.BASELIMIT,D.IFSYSTEM, D.MNGDEPTNM, D.TARGETRATIONLE, D.PLANNED_FLAG, D.SCORECODE, L.S, L.A, L.B, L.C, L.D ")
	         .append("  FROM TBLMEASUREDEFINE D, TBLMEASURE C, TBLTREESCORE T, TBLSCORELEVEL L WHERE T.CONTENTID=D.ID AND T.TREELEVEL=5 AND D.MEASUREID=C.ID AND L.SCORECODE=D.SCORECODE AND D.ID=?) MEA ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.TREELEVEL OLEVEL,T.RANK ORANK,C.NAME ONAME  ")
	         .append(" FROM TBLTREESCORE T, TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND YEAR=? ) OBJ ")
	         .append(" ON MEA.MPID=OBJ.OID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.TREELEVEL PLEVEL,T.RANK PRANK,C.NAME PNAME ")
	         .append(" FROM TBLTREESCORE T, TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND YEAR=? ) PST ")
	         .append(" ON OBJ.OPID=PST.PID  ");

			Object[] paramS = {mid,year,year};

			rs = dbobject.executePreparedQuery(strS.toString(),paramS);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

			String strItem ="SELECT * FROM TBLITEM WHERE MEASUREID=? ORDER BY CODE";
			Object[] param = {mid};

			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strItem,param);

			DataSet dsItem = new DataSet();
			dsItem.load(rs);

			request.setAttribute("dsItem",dsItem);

			String strUpdater = "SELECT R.USERID,(SELECT USERNAME FROM TBLUSER U WHERE U.USERID=R.USERID) USERNAME FROM TBLAUTHORITY R WHERE MEASUREID=?";
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strUpdater,param);

			DataSet dsUpdater = new DataSet();
			dsUpdater.load(rs);

			request.setAttribute("dsUpdater",dsUpdater);


		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public void getUser(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());


			String strS = "SELECT USERID,USERNAME FROM TBLUSER WHERE GROUPID<4 ORDER BY USERNAME";

			rs = dbobject.executeQuery(strS);

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

	public void getEquType (HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());


			String strS = "SELECT * FROM TBLEQUATIONTYPE ORDER BY TYPE";

			rs = dbobject.executeQuery(strS);

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

	// 지표복사를 위해서 사용함.
	public void getMeasCopy(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			String mcid = request.getParameter("mcid")!=null?request.getParameter("mcid"):"%";
			String measureid = request.getParameter("measureid")!=null?request.getParameter("measureid"):"%";

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM  ")
	         .append(" (SELECT T.ID CID,T.PARENTID CPID,T.CONTENTID CCID,T.TREELEVEL CLEVEL,T.RANK CRANK,T.WEIGHT CWEIGHT,C.NAME CNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLCOMPANY C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=0 AND T.YEAR=? ) COM ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? ) SBU ")
	         .append(" ON COM.CID=SBU.SPID ")
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
	         .append("  JOIN ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID, D.ETLKEY ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND T.CONTENTID LIKE ? AND D.MEASUREID LIKE ?) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" ORDER BY CRANK,SRANK,SID,BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");

	         Object[] params = {year,year,year,year,year,year, mcid, measureid};

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

	/*
	//-----------------------------------------------------------------------------------------------------
	// 	지표복사
	//-----------------------------------------------------------------------------------------------------
	*/
	public void setMeasCopy(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

//			param.mode      = "U";
//			param.year      = parentObj.year ;
//			param.mcid      = parentObj.mcid ;  // 지표정의서 ID.
//			param.measureid = strMeasureId   ;  // 지표코드
//
//			// Option...
//			param.detail    = cbxDetail.selected?"1":"0";
//			param.datasource= cbxDataSource.selected?"1":"0";
//			param.weight    = cbxWeight.selected?"1":"0";
//			param.unit      = cbxUnit.selected?"1":"0";
//			param.trend     = cbxTrend.selected?"1":"0";
//			param.updateid  = cbxUpdateid.selected?"1":"0";
//			param.frequncy  = cbxFrequncy.selected?"1":"0";
//			param.mtype     = cbxMType.selected?"1":"0";
//			param.grade     = cbxGrade.selected?"1":"0";
//			param.equation  = cbxEquation.selected?"1":"0";
//			param.mean      = cbxMean.selected?"1":"0";
//			param.item      = cbxItem.selected?"1":"0";
//
//			// Copy Target Org...
//			param.orgdefineid = f_mkTgtOrg();


			String year = request.getParameter("year");
			String mode = request.getParameter("mode");

			// 지표정의서와 지표코드
			String mcid= request.getParameter("mcid");

			// 지표정의서 단일항목
			String mean = request.getParameter("mean").trim()==null?"":request.getParameter("mean").trim();
			String detail = request.getParameter("detail").trim()==null?"":request.getParameter("detail").trim();
			String datasource = request.getParameter("datasource")==null?"":request.getParameter("datasource").trim();
			String weight = request.getParameter("weight")==null?"":request.getParameter("weight");
			String unit = request.getParameter("unit").trim()==null?"":request.getParameter("unit").trim();
			String trend = request.getParameter("trend")==null?"":request.getParameter("trend");
			String frequency = request.getParameter("frequency")==null?"":request.getParameter("frequency");
			String mtype=request.getParameter("mtype")==null?"":request.getParameter("mtype");
			String updateId = request.getParameter("updateId")==null?"":request.getParameter("updateId");

			String ifsystem = request.getParameter("ifsystem")==null?"":request.getParameter("ifsystem").trim();
			String mngdeptnm = request.getParameter("mngdeptnm")==null?"":request.getParameter("mngdeptnm").trim();
			String targetrationle = request.getParameter("targetrationle")==null?"":request.getParameter("targetrationle").trim();

			//	 Equation...
			String equation = request.getParameter("equation").trim()==null?"":request.getParameter("equation").trim();

			// 목표값 : Grade
			String grade = request.getParameter("grade")==null?"":request.getParameter("grade");

			// 항목
			String item = request.getParameter("item")==null?"":request.getParameter("item");

			// 대상부서 (부서명, mcid)
			String orgdefineid = request.getParameter("orgdefineid")==null?"":request.getParameter("orgdefineid");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());


			System.out.println("freq :" + frequency );

			if ("U".equals(mode)) {

					//-----------------------------------------------------------------------------------------------
					// 지표정의서 복사원본을 구함
					//-----------------------------------------------------------------------------------------------
					StringBuffer sbI = new StringBuffer();
					  sbI.append(" select 	  id,measureid, detaildefine, weight, unit,        ")
					 	 .append("            entrytype, measuretype, frequency,               ")
						 .append("  		  equation, equationdefine, etlkey,                ")
						 .append("            measurement, year, trend,                        ")
						 .append("            planned, plannedbase,base,baselimit,limit,       ")
						 .append("            y, ya1, ya2, ya3, ya4, yb1, yb2, yb3,            ")
						 .append("            mean, updateid, equationtype, datasource,	       ")
						 .append("            ifsystem, mngdeptnm, targetrationle, planned_flag  ")
					     .append("   from  tblmeasuredefine                                    ")
					     .append(" where year =?                                               ")
						 .append("   and id   =?                                               ");
					Object[] paramS = {year,mcid};

					System.out.println("원본 : " + mcid);

					rs = dbobject.executePreparedQuery(sbI.toString(),paramS);

					// 지표정의서 복사원본
					DataSet dsFrom = new DataSet();
					dsFrom.load(rs);
					dsFrom.next();

					//-----------------------------------------------------------------------------------------------
					// 복사 Check Flag에 따라 Update SQL 문을 만듬.
					//-----------------------------------------------------------------------------------------------
					//System.out.println("Detail : " + dsFrom.getString("detaildefine") );

					StringBuffer sbu = new StringBuffer();

					sbu.append(" Update tblmeasuredefine set year = year ");

					if ("1".equals(mean))          { sbu.append(", mean         = '" + (dsFrom.getString("mean")==null?"":dsFrom.getString("mean")) + "'" ); }
					//if ("1".equals(detail))        { sbu.append(", detaildefine = '" + (dsFrom.getString("detaildefine")==null?"":dsFrom.getString("detaildefine")) + "'" ); }
					if ("1".equals(datasource))    { sbu.append(", datasource   = '" + (dsFrom.getString("datasource")==null?"":dsFrom.getString("datasource")) + "'" ); }
					if ("1".equals(unit))          { sbu.append(", unit         = '" + (dsFrom.getString("unit")==null?"":dsFrom.getString("unit")) + "'" ); }
					if ("1".equals(trend))         { sbu.append(", trend        = '" + (dsFrom.getString("trend")==null?"":dsFrom.getString("trend")) + "'" ); }
					if ("1".equals(frequency))     { sbu.append(", frequency    = '" + (dsFrom.getString("frequency")==null?"":dsFrom.getString("frequency")) + "'" ); }
					if ("1".equals(mtype))         { sbu.append(", measuretype  = '" + (dsFrom.getString("measuretype")==null?"":dsFrom.getString("measuretype")) + "'" ); }
					if ("1".equals(mtype))         { sbu.append(", entrytype    = '" + (dsFrom.getString("entrytype")==null?"":dsFrom.getString("entrytype")) + "'" ); }
					if ("1".equals(mtype))         { sbu.append(", measurement  = '" + (dsFrom.getString("measurement")==null?"":dsFrom.getString("measurement")) + "'" ); }

					if ("1".equals(updateId))      { sbu.append(",  updateid = '" + (dsFrom.getString("updateId")==null?"":dsFrom.getString("updateId")) + "'" ); }

					if ("1".equals(ifsystem))      { sbu.append(", ifsystem = '" + ( dsFrom.getString("ifsystem")==null?"":dsFrom.getString("ifsystem")) + "'" ); }
					if ("1".equals(mngdeptnm))     { sbu.append(", mngdeptnm = '" + (dsFrom.getString("mngdeptnm")==null?"":dsFrom.getString("mngdeptnm")) + "'" ); }
					if ("1".equals(targetrationle)){ sbu.append(",  targetrationle = '" + (dsFrom.getString("targetrationle")==null?"":dsFrom.getString("targetrationle")) + "'" ); }

					if ("1".equals(equation)){ sbu.append(", equation = '" + (dsFrom.getString("equation")==null?"":dsFrom.getString("equation")) + "'" ); }
					if ("1".equals(equation)){ sbu.append(", equationdefine = '" + (dsFrom.getString("equationdefine")==null?"":dsFrom.getString("equationdefine")) + "'" ); }

					if ("1".equals(weight))  { sbu.append(", weight = " + (dsFrom.getString("weight")==null?"null":dsFrom.getString("weight")) ); }
					if ("1".equals(grade))   { sbu.append(", planned = " + (dsFrom.getString("planned")==null||dsFrom.isEmpty("planned")?"null":dsFrom.getString("planned")) ); }
					if ("1".equals(grade))   { sbu.append(", plannedbase = " + (dsFrom.getString("plannedbase")==null||dsFrom.isEmpty("plannedbase")?"null":dsFrom.getString("plannedbase")) ); }
					if ("1".equals(grade))   { sbu.append(", base = " + (dsFrom.getString("base")==null||dsFrom.isEmpty("base")?"null":dsFrom.getString("base")) ); }
					if ("1".equals(grade))   { sbu.append(", baselimit = " + (dsFrom.getString("baselimit")==null||dsFrom.isEmpty("baselimit")?"null":dsFrom.getString("baselimit")) ); }
					if ("1".equals(grade))   { sbu.append(", limit = " + (dsFrom.getString("limit")==null||dsFrom.isEmpty("limit")?"null":dsFrom.getString("limit")) ); }
					if ("1".equals(grade))   { sbu.append(", planned_flag = '" + (dsFrom.getString("planned_flag")==null||dsFrom.isEmpty("planned_flag")?"U":dsFrom.getString("planned_flag")) + "'" ); }

					sbu.append(" where year =  " + year  );
					sbu.append(" and    id = ? ");

					//System.out.println("frequency : "  + frequency);


					// TreeScore 의 WEIGHT도 Update...
					StringBuffer sbtu = new StringBuffer();

					if ("1".equals(weight)){
							sbtu.append(" update tbltreescore  set weight = " + (dsFrom.getString("weight")==null?"null":dsFrom.getString("weight")) );
							sbtu.append(" where year = " + year   );
							sbtu.append(" and    contentid = ? "   );
					}

					StringBuffer sbdu = new StringBuffer();

					if ("1".equals(detail)){
							sbdu.append(" update tblmeasuredefine  set detaildefine = (select detaildefine from tblmeasuredefine where id = ? )"  );
							sbdu.append(" where year = " + year   );
							sbdu.append(" and   id   = ? "   );
					}

					//System.out.println("Update SQL2 : \n");

					//--------------------------------------------------------------------------------------------
					//  부서별 Update.... 젠장 부서명에 ',' 이 들어가네...
					//--------------------------------------------------------------------------------------------
					if (!"".equals(orgdefineid.trim())){

						String    orgMcid ;

						String[] orgdefineids = orgdefineid.split("`");

						//System.out.println("MeasCopy1 : " + orgdefineids);

						for (int m = 0; m < orgdefineids.length; m++) {
							String[] iPart = orgdefineids[m].split("^");
							orgMcid= iPart[0];

							System.out.println("MeasCopy : " + orgMcid);
							System.out.println("MeasCopy : " + orgMcid + "\n" + sbu.toString());

							dbobject.executePreparedUpdate(sbu.toString(),new Object[]{orgMcid});



							// Weight 도 업데이트 하는 경우
							if ("1".equals(weight)){
								dbobject.executePreparedUpdate(sbtu.toString(),new Object[]{orgMcid});
							}

							// detailDefine에 특수문자가 들어가는 경우
							if ("1".equals(detail)){
								dbobject.executePreparedUpdate(sbdu.toString(),new Object[]{mcid, orgMcid});
							}

							// 항목코드도 복사하는가?
							if ("1".equals(item)){


									String strD = "DELETE FROM TBLITEM WHERE MEASUREID=?";
									dbobject.executePreparedUpdate(strD,new Object[]{orgMcid});

									String strUI   = " insert into tblitem (measureid, code, itemname, itementry, itemtype, unit, itemfixed)";
											  strUI += " select ?, code, itemname, itementry, itemtype, unit, itemfixed  " ;
											  strUI += " from   tblitem ";
											  strUI += " where  measureid = ?" ;

									System.out.println("항목복사 SQL : \n"  + strUI);

									Object[] pmUI = {orgMcid, mcid};
									dbobject.executePreparedUpdate(strUI,pmUI);
							}

							//  등급구간 목표값 자동생성 : 주기, 가중치, 등급구간이 같이 선택된 경우...
							if ("1".equals(grade)){
								if ("1".equals(weight)){
									if ("1".equals(frequency)){

										String    mfrequency  = dsFrom.getString("frequency");
										String    mweight     = dsFrom.getString("weight");
										String	  planned     = dsFrom.getString("planned");
										String    plannedbase = dsFrom.getString("plannedbase");
										String    base        = dsFrom.getString("base");
										String    baselimit   = dsFrom.getString("baselimit");
										String    limit       = dsFrom.getString("limit");

										setMeasDetailValue2(year,orgMcid, mfrequency, mweight, planned, plannedbase, base, baselimit, limit );
									}
								}
							}
						}
				}

				conn.commit();
			}

			request.setAttribute("rslt","true");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	//-----------------------------------------------------------------------------------------------------
	// 	 : setMeasDetailValue
	//   지표 목표값 생성시 관련 MeasureDetail에 Planned, Base, Limt을 주기에 맞게 자동생성.
	//-----------------------------------------------------------------------------------------------------
	public int setMeasDetailValue(String year, String mcid) {

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		DataSet ds = new DataSet();

		try {
				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				if (dbobject==null) dbobject= new DBObject(conn.getConnection());

				if ("".equals(year)){
					return -1;
				}

				// 0. 년도의 지표정의서 ID에 해당되는 정보를 구함.
				StringBuffer sb = new StringBuffer();

				sb.append(" SELECT  a.id, a.measureid, a.frequency, a.weight, ?||b.ym ym,           ");
				sb.append("         a.planned, a.plannedbase, a.base , a.baselimit, a.limit         ");
				sb.append(" FROM    tblmeasuredefine a,                                             ");
				sb.append("         (                                                               ");
				sb.append("         SELECT '년' freq, ltrim(to_char(rownum * 12,'00')) ym           ");
				sb.append("         FROM   tbluser WHERE rownum <= 1                                ");
				sb.append("         UNION ALL                                                       ");
				sb.append("         SELECT '반기' freq, ltrim(to_char(rownum * 6,'00')) ym          ");
				sb.append("         FROM   tbluser WHERE rownum <= 2                                ");
				sb.append("         UNION ALL                                                       ");
				sb.append("         SELECT '분기' freq, ltrim(to_char(rownum * 3,'00')) ym          ");
				sb.append("         FROM   tbluser WHERE rownum <= 4                                ");
				sb.append("         UNION ALL                                                       ");
				sb.append("         SELECT '월' freq, ltrim(to_char(rownum * 1,'00')) ym            ");
				sb.append("         FROM   tbluser WHERE rownum <= 12                               ");
				sb.append("         ) b                                                             ");
				sb.append(" WHERE  a.frequency = b.freq                                             ");
				sb.append(" AND    a.year      = ?                                                  ");
				sb.append(" AND    a.id        = ?                                                  ");
				sb.append(" ORDER BY a.id, b.ym                                                     ");

				Object[] paramS = {year,year,mcid};
				rs = dbobject.executePreparedQuery(sb.toString(),paramS);
				ds.load(rs);
				System.out.println("Row Count : "+ ds.getRowCount());
				System.out.println("MeasDetail 1.mcid : " + mcid );

				int     measureid  ;
				String  frequency  ;
				String  weight     ;
				String  ym         ;
				double planned    ;
				double plannedbase;
				double base       ;
				double baselimit  ;
				double limit      ;

				// 지표정의서 Read...
				int v_cnt = 0;
				int i = 0;

				while(ds.next()){

					System.out.println("MeasDetail Loop : " + i++);

					measureid   = ds.getInt("id"         );
					ym          = ds.getString("ym"         );
					frequency   = ds.getString("frequency"  );
					weight      = ds.getString("weight"     );
					planned     = ds.getDouble("planned"    );
					plannedbase = ds.getDouble("plannedbase");
					base        = ds.getDouble("base"       );
					baselimit   = ds.getDouble("baselimit"  );
					limit       = ds.getDouble("limit"      );

					//--------------------------------------------------------------
					// 1. MeasureDetail에 목표등급 데이타 Setting.
					//--------------------------------------------------------------
					// 1-1. 주기에 맞지않는 목표값 삭제

					StringBuffer sbD = new StringBuffer();

					if ("년".equals(frequency)){

						sbD.append(" delete tblmeasuredetail                               ");
						sbD.append(" where  measureid                = ?                   ");
						sbD.append(" and    strdate               like substr(?, 1,4)||'%' ");
						sbD.append(" and    substr(strdate,5,2) not in ('12')              ");

					} else if ("반기".equals(frequency)){
						sbD.append(" delete tblmeasuredetail                               ");
						sbD.append(" where  measureid                = ?                   ");
						sbD.append(" and    strdate               like substr(?, 1,4)||'%' ");
						sbD.append(" and    substr(strdate,5,2) not in  ('06','12')        ");

					} else if ("분기".equals(frequency)){
						sbD.append(" delete tblmeasuredetail                                 ");
						sbD.append(" where  measureid                = ?                     ");
						sbD.append(" and    strdate               like substr(?, 1,4)||'%'   ");
						sbD.append(" and    substr(strdate,5,2) not in ('03','06','09','12') ");
					}

					Object[] paramD = {measureid,ym};
					dbobject.executePreparedUpdate(sbD.toString(),paramD);

					System.out.println("MeasDetail Delete : " + mcid + ", ym :" + ym);

					// 1-2. 주기에 맞는 목표값 자동 생성
					StringBuffer sbQ = new StringBuffer();

					sbQ.append(" select count(*) cnt             ");
					sbQ.append(" from   tblmeasuredetail         ");
					sbQ.append(" where  measureid       = ?      ");
					sbQ.append(" and    strdate      like ?||'%' ");

					Object[] paramQ = {measureid,ym};

					rs2 = null;
					rs2 = dbobject.executePreparedQuery(sbQ.toString(),paramQ);
					rs2.next();

					v_cnt = rs2.getInt("cnt");
					rs2.close();

					System.out.println("MeasDetail I/U Check : " + v_cnt);

					if (v_cnt > 0){
						StringBuffer sbU = new StringBuffer();

						sbU.append(" update tblmeasuredetail                                         ");
						sbU.append(" set    weight      = ?                                          ");
						sbU.append("     ,  planned     = ?                                          ");
						sbU.append("     ,  plannedbase = ?                                          ");
						sbU.append("     ,  base        = ?                                          ");
						sbU.append("     ,  baselimit   = ?                                          ");
						sbU.append("     ,  limit       = ?                                          ");
						sbU.append("     ,  updatedate  = sysdate                                    ");
						sbU.append(" where  measureid       = ?                                      ");
						sbU.append(" and    strdate      like ?||'%'                                 ");

						Object[] paramU = {weight, planned, plannedbase, base,baselimit,limit, measureid,ym};
						dbobject.executePreparedUpdate(sbU.toString(),paramU);

						System.out.println("MeasDetail Update : " + mcid);

					}else{
						StringBuffer sbC = new StringBuffer();

						sbC.append(" insert into tblmeasuredetail                                            ");
						sbC.append(" (id, measureid, strdate, weight,                                        ");
						sbC.append("  planned, plannedbase, base, baselimit, limit, inputdate)               ");
						sbC.append(" SELECT nvl(max(id) + 1,0) id, ? measureid,?   ym,?  weight,             ");
						sbC.append("        ? planned, ? plannedbase, ? base, ? baselimit, ? limit, sysdate  ");
						sbC.append(" FROM   tblmeasuredetail                                                 ");

						Object[] paramI = {measureid,ym,weight, planned, plannedbase, base, baselimit, limit};
						dbobject.executePreparedUpdate(sbC.toString(),paramI);

						System.out.println("MeasDetail Insert : " + mcid);
					}

				}

				System.out.println("MeasDetail Planned Auto Create Sucess : " + mcid);

				rs.close();
				conn.commit();

				return 0;

		} catch (Exception e) {
			System.out.println("setMeasDetailValue 에러 : " + e.toString());
			//e.printStackTrace();
			return -1;
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			try{if (rs2 != null) {rs2.close(); rs2 = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}

	}

	//-----------------------------------------------------------------------------------------------------
	// 	 : setMeasDetailValue2
	//   지표 목표값 생성시 관련 MeasureDetail에 Planned, Base, Limt을 주기에 맞게 자동생성.
	//
	//		tbluser에 12명이상 등록안되면 입력이 제대로 안됨.
	//-----------------------------------------------------------------------------------------------------
	public int setMeasDetailValue2(String year, String measureid, String frequency, String weight,
			                        String planned,String plannedbase,String base,String baselimit,String limit) {

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		DataSet ds = new DataSet();

		try {
				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				if (dbobject==null) dbobject= new DBObject(conn.getConnection());

				if ("".equals(year)){
					return -1;
				}
				// 0. 년도의 지표정의서 ID에 해당되는 정보를 구함.
				StringBuffer sb = new StringBuffer();

				sb.append(" SELECT  ?||a.ym ym                   ");
				sb.append(" FROM    (                                                               ");
				sb.append("         SELECT '년' freq, ltrim(to_char(rownum * 12,'00')) ym           ");
				sb.append("         FROM   tbluser WHERE rownum <= 1                                ");
				sb.append("         UNION ALL                                                       ");
				sb.append("         SELECT '반기' freq, ltrim(to_char(rownum * 6,'00')) ym          ");
				sb.append("         FROM   tbluser WHERE rownum <= 2                                ");
				sb.append("         UNION ALL                                                       ");
				sb.append("         SELECT '분기' freq, ltrim(to_char(rownum * 3,'00')) ym          ");
				sb.append("         FROM   tbluser WHERE rownum <= 4                                ");
				sb.append("         UNION ALL                                                       ");
				sb.append("         SELECT '월' freq, ltrim(to_char(rownum * 1,'00')) ym            ");
				sb.append("         FROM   tbluser WHERE rownum <= 12                               ");
				sb.append("         ) a                                                             ");
				sb.append(" WHERE  a.freq = ?                                                       ");
				sb.append(" ORDER BY a.ym                                                           ");

				Object[] paramS = {year,frequency};
				rs = dbobject.executePreparedQuery(sb.toString(),paramS);
				ds.load(rs);
				System.out.println("Row Count : "+ ds.getRowCount());
				System.out.println("MeasDetail 1.mcid : " + measureid );


				String  ym         ;

				// 지표정의서 Read...
				int v_cnt = 0;
				int i = 0;

				while(ds.next()){

					System.out.println("MeasDetail Loop : " + i++);

					ym          = ds.getString("ym"         );

					//--------------------------------------------------------------
					// 1. MeasureDetail에 목표등급 데이타 Setting.
					//--------------------------------------------------------------
					// 1-1. 주기에 맞지않는 목표값 삭제

					StringBuffer sbD = new StringBuffer();

					if ("년".equals(frequency)){

						sbD.append(" delete tblmeasuredetail                               ");
						sbD.append(" where  measureid                = ?                   ");
						sbD.append(" and    strdate               like substr(?, 1,4)||'%' ");
						sbD.append(" and    substr(strdate,5,2) not in ('12')              ");

					} else if ("반기".equals(frequency)){
						sbD.append(" delete tblmeasuredetail                               ");
						sbD.append(" where  measureid                = ?                   ");
						sbD.append(" and    strdate               like substr(?, 1,4)||'%' ");
						sbD.append(" and    substr(strdate,5,2) not in  ('06','12')        ");

					} else if ("분기".equals(frequency)){
						sbD.append(" delete tblmeasuredetail                                 ");
						sbD.append(" where  measureid                = ?                     ");
						sbD.append(" and    strdate               like substr(?, 1,4)||'%'   ");
						sbD.append(" and    substr(strdate,5,2) not in ('03','06','09','12') ");
					}

					Object[] paramD = {measureid,ym};
					dbobject.executePreparedUpdate(sbD.toString(),paramD);

					System.out.println("MeasDetail Delete : " + measureid + ", ym :" + ym);

					// 1-2. 주기에 맞는 목표값 자동 생성
					StringBuffer sbQ = new StringBuffer();

					sbQ.append(" select count(*) cnt             ");
					sbQ.append(" from   tblmeasuredetail         ");
					sbQ.append(" where  measureid       = ?      ");
					sbQ.append(" and    strdate      like ?||'%' ");

					Object[] paramQ = {measureid,ym};

					rs2 = null;
					rs2 = dbobject.executePreparedQuery(sbQ.toString(),paramQ);
					rs2.next();

					v_cnt = rs2.getInt("cnt");
					rs2.close();

					System.out.println("MeasDetail I/U Check : " + v_cnt);

					if (v_cnt > 0){
						StringBuffer sbU = new StringBuffer();

						sbU.append(" update tblmeasuredetail                                         ");
						sbU.append(" set    weight      = ?                                          ");
						sbU.append("     ,  planned     = ?                                          ");
						sbU.append("     ,  plannedbase = ?                                          ");
						sbU.append("     ,  base        = ?                                          ");
						sbU.append("     ,  baselimit   = ?                                          ");
						sbU.append("     ,  limit       = ?                                          ");
						sbU.append("     ,  updatedate  = sysdate                                    ");
						sbU.append(" where  measureid       = ?                                      ");
						sbU.append(" and    strdate      like ?||'%'                                 ");

						Object[] paramU = {weight, planned, plannedbase, base,baselimit,limit, measureid,ym};
						dbobject.executePreparedUpdate(sbU.toString(),paramU);

						System.out.println("MeasDetail Update : " + measureid);

					}else{
						StringBuffer sbC = new StringBuffer();

						sbC.append(" insert into tblmeasuredetail                                            ");
						sbC.append(" (id, measureid, strdate, weight,                                        ");
						sbC.append("  planned, plannedbase, base, baselimit, limit, inputdate)               ");
						sbC.append(" SELECT nvl(max(id) + 1,0) id, ? measureid,?   ym,?  weight,             ");
						sbC.append("        ? planned, ? plannedbase, ? base, ? baselimit, ? limit, sysdate  ");
						sbC.append(" FROM   tblmeasuredetail                                                 ");

						Object[] paramI = {measureid,ym,weight, planned, plannedbase, base, baselimit, limit};
						dbobject.executePreparedUpdate(sbC.toString(),paramI);

						System.out.println("MeasDetail Insert : " + measureid);
					}

				}

				System.out.println("MeasDetail Planned Auto Create Sucess : " + measureid);

				rs.close();

				conn.commit();

				return 0;

		} catch (Exception e) {
			System.out.println("setMeasDetailValue2 에러 : " + e.toString());
			//e.printStackTrace();
			return -1;
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			try{if (rs2 != null) {rs2.close(); rs2 = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}

	}

	//-----------------------------------------------------------------------------------------------------
	// 	지표복사(년 이관) http://127.0.0.1:7070/kopec/jsp/xml/hierarchy/copyMeasure.jsp?mode=U&div_gn=setMeasYearCopy
	//-----------------------------------------------------------------------------------------------------

	public void setMeasYearCopy(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
	    int rslt = 0;

		try {

			String fmyear = request.getParameter("fmyear")==null?"":request.getParameter("fmyear");
			String toyear = request.getParameter("toyear")==null?"":request.getParameter("toyear");

			//fmyear = "2007";
			//toyear ="2008";
			if ("".equals(fmyear)||"".equals(toyear)){
				request.setAttribute("rslt","false");
				return;
			}

			System.out.println("\n\n" );
			System.out.println("=========================================================================");
			System.out.println("Meas Year Copy : From " + fmyear + " To " + toyear );

			// 0. 기존 자료를 삭제한다.
			//     0-1.tblitem,  tblauthority 의 경우 tblmeasuredefine의 년도 ID에 속한 항목들을 모두 삭제
			//     0-2.tblhierarchy, tbltreescore, tblmeasuredefine 테이블의 년도에 해당되는 되는 항목삭제.
			if (setMeasYearDelete(toyear) < 0){
					System.out.println(" setMeasYearCopy - 지표 이관년도 삭제중 오류 :  "  + toyear);
					 conn.rollback();
					return;
			}

			System.out.println("1. Meas Year Copy : Delete Target Year's Meas");

			//-----------------------------------------------------------------------------
			//  MAX ID...
			//-----------------------------------------------------------------------------
			int v_mm = -1;     // TBLMeasureDefine
			int v_hm = -1;      // TBLHIERARCHY
			int v_sm = -1;      // TBLTREESCORE
			int v_dm = -1;		// TBLMEASUREDETAIL

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			// 1-1. 지표정의서 MAX ID : Query에서 년도 제거(2007 -> 2010)
			String strQry = "SELECT MAX(ID) as MM FROM TBLMEASUREDEFINE";
			rs = dbobject.executeQuery(strQry);
			while (rs.next()){
					v_mm = rs.getInt("MM");
			}

			// 1-2. TREESCORE MAX ID.
			strQry = "SELECT MAX(ID) as SM FROM TBLTREESCORE";
			rs = dbobject.executeQuery(strQry);
			while (rs.next()){
					v_sm = rs.getInt("SM");
			}

			// 1-3. TBLHIERARCHY  MAX ID.
			strQry = "SELECT MAX(ID) as HM FROM TBLHIERARCHY";
			rs = dbobject.executeQuery(strQry);
			while (rs.next()){
					v_hm = rs.getInt("HM");
			}
			// 1-4. TBLMEASUREDETAIL  MAX ID.
			strQry = "SELECT MAX(ID) as DM FROM TBLMEASUREDETAIL ";
			rs = dbobject.executeQuery(strQry);
			while (rs.next()){
					v_dm = rs.getInt("DM");
			}

			System.out.println("2. Get Next MAX ID for Target Year.");

			//-----------------------------------------------------------------------------
			// 2. 지표체계 복사
			//-----------------------------------------------------------------------------
			// 2-1. 지표정의서 복사
			String strM = " ";
			strM += " insert into tblmeasuredefine (                   ";
			strM += "    id, measureid, detaildefine, weight, unit,    ";
			strM += "    entrytype, measuretype, frequency,            ";
			strM += "    equation, equationdefine, etlkey,             ";
			strM += "    measurement, year, trend,                     ";
			strM += "    planned, plannedbase, base, baselimit, limit, ";
			strM += "    y,   ya1, ya2, ya3, ya4, yb1, yb2, yb3,       ";
			strM += "    mean, updateid, equationtype, datasource,     ";
			strM += "    ifsystem, mngdeptnm, targetrationle, planned_flag   )       ";
			strM += " select                                           ";
			strM += "    id + ? id, measureid, detaildefine, weight, unit,    ";
			strM += "    entrytype, measuretype, frequency,            ";
			strM += "    equation, equationdefine, etlkey,             ";
			strM += "    measurement, ? year, trend,                   ";
			strM += "    planned, plannedbase, base, baselimit, limit, ";
			strM += "    y,   ya1, ya2, ya3, ya4, yb1, yb2, yb3,       ";
			strM += "    mean, updateid, equationtype, datasource,     ";
			strM += "    ifsystem, mngdeptnm, targetrationle, planned_flag           ";
			strM += " from  tblmeasuredefine                           ";
			strM += " where year = ?                                   ";
			strM += " order by id                                      ";

			dbobject.executePreparedUpdate(strM, new Object[]{String.valueOf(v_mm), toyear, fmyear});

			System.out.println("3. Meas Copy : 지표정의서");

			// 2-2. 지표 TREESCORE  복사
			String strS = " ";
			strS += " insert into tbltreescore                                                           ";
			strS += " (id,parentid,contentid,treelevel,rank,year,weight)                   ";
			strS += " select id+?, parentid,contentid,treelevel,rank,? year,weight    ";
			strS += " from tbltreescore where year=?                                             ";

			dbobject.executePreparedUpdate(strS, new Object[]{String.valueOf(v_sm), toyear, fmyear});
			System.out.println("3. Meas Copy : TREESCORE");

			// 2-3. 지표 Hierarchy 복사
			String strH = " ";
			strH += " insert into tblhierarchy                                                           ";
			strH += " (id,parentid,contentid,treelevel,rank,year,weight)                   ";
			strH += " select id+?, parentid,contentid,treelevel,rank,? year,weight    ";
			strH += " from tblhierarchy where year=?                                             ";
			dbobject.executePreparedUpdate(strH, new Object[]{String.valueOf(v_hm), toyear, fmyear});
			System.out.println("3. Meas Copy : Hierarchy");


			// 2-4. parent ID정리.
			strH = " update tblhierarchy set parentid=parentid+? where year=? and treelevel in (1,2) ";
			dbobject.executePreparedUpdate(strH, new Object[]{String.valueOf(v_hm), toyear});

			strH = " update tbltreescore set parentid=parentid+? where year=? and treelevel in (3) ";
			dbobject.executePreparedUpdate(strH, new Object[]{String.valueOf(v_hm), toyear});

			strS = " update tbltreescore set parentid=parentid+? where year=? and treelevel in (4,5) ";
			dbobject.executePreparedUpdate(strS, new Object[]{String.valueOf(v_sm), toyear});

			strS = " update tbltreescore set contentid=contentid+? where year=? and treelevel in (5) ";
			dbobject.executePreparedUpdate(strS, new Object[]{String.valueOf(v_mm), toyear});

			System.out.println("3. Meas Copy : parent ID");

			//-----------------------------------------------------------------------------
			// 3. 지표항목 복사 : 2007년 지표의 항목정보를 Update.
			//-----------------------------------------------------------------------------
			// 3-1. 지표항목 복사
			strS   = " insert into tblitem (code,measureid,itemname,itementry,itemtype,unit, itemfixed)       ";
			strS += " select code,measureid+?, itemname,itementry,itemtype,unit, itemfixed from tblitem ";
			strS += " where measureid in  (select id from tblmeasuredefine where year=?)       ";

			dbobject.executePreparedUpdate(strS, new Object[]{String.valueOf(v_mm), fmyear});
			System.out.println("3. Meas Copy : 지표항목");

			//-----------------------------------------------------------------------------
			// 4. 지표사용자 정보
			//-----------------------------------------------------------------------------
			// 4-1. 지표사용자 복사
			strS   = " insert into tblauthority (year,measureid,userid)       ";
			strS += " select ? year,  measureid+?,userid  from tblauthority ";
			strS += " where year = ?  ";

			dbobject.executePreparedUpdate(strS, new Object[]{toyear, String.valueOf(v_mm), fmyear});
			System.out.println("3. Meas Copy : 지표사용자");

			// 6. 주기별 실적테이블의 목표값까지 설정.
			//
			// 4-1. 목표값  복사
			strS  = " insert into tblmeasuredetail (id,measureid,strdate, weight,planned, plannedbase, base, baselimit, limit, inputid, inputdate)  ";
			strS += " select id + ? id, measureid + ? measureid, ? ||substr(strdate,5) strdate, weight, planned, plannedbase, base, baselimit, limit, inputid, inputdate from tblmeasuredetail ";
			strS += " where strdate like ? ||'%' ";

			dbobject.executePreparedUpdate(strS, new Object[]{String.valueOf(v_dm), String.valueOf(v_mm), toyear, fmyear});
			System.out.println("3. Meas Copy : 목표값");

			System.out.println("3. Copy and Restructure BSC Arch : Hierarchy,treescore, measuredefine, item, authority, target value.");

			conn.commit();

			request.setAttribute("rslt","true");

			System.out.println("=========================================================================");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}



	public void setMeasYearDeleteAll(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
	    int rslt = 0;

		try {

			String year = request.getParameter("year")==null?"":request.getParameter("year");

			//fmyear = "2007";
			//toyear ="2008";
			if ("".equals(year)){
				request.setAttribute("rslt","false");
				return;
			}

			System.out.println("\n\n" );
			System.out.println("=========================================================================");
			System.out.println("Meas Year Delete : " + year );

			// 0. 기존 자료를 삭제한다.
			//     0-1.tblitem,  tblauthority 의 경우 tblmeasuredefine의 년도 ID에 속한 항목들을 모두 삭제
			//     0-2.tblhierarchy, tbltreescore, tblmeasuredefine 테이블의 년도에 해당되는 되는 항목삭제.
			if (setMeasYearDelete(year) < 0){
					System.out.println(" setMeasYearCopy - 지표 이관년도 삭제중 오류 :  "  + year);
					 conn.rollback();
					return;
			}

			request.setAttribute("rslt","true");
			System.out.println("=========================================================================");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}


	// 년도의 지표정의서 관련 삭제.
	public int setMeasYearDelete(String year){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				if (dbobject==null) dbobject= new DBObject(conn.getConnection());

				if ("".equals(year)){
					return -1;
				}

				// 0. tblmeasuredetail : 주기별 실적 테이블
				String strD = "delete from tblmeasuredetail where strdate like ?||'%'";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				strD = "delete from tblmeasurescore where strdate like ?||'%'";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				// 1. tblitem : 항목 테이블
				strD = "delete from tblitem where measureid in (select  id from tblmeasuredefine where  year = ?) ";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				strD = "delete from tblitemactual where measureid in (select  id from tblmeasuredefine where  year = ?) ";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				// 2. tblauthority : 권한 테이블
				strD = "delete from tblauthority where year = ?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				// 3. tblmeasuredefine : 지표정의서 테이블
				strD = "delete from tblmeasuredefine where year = ?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				// 4. tbltreescore : TREESCORE 테이블
				strD = "delete from tbltreescore where year = ?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				// 4. tblhierarchy : Hierachy 테이블
				strD = "delete from tblhierarchy where year = ?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				conn.commit();
				return 0;

		} catch (Exception e) {
			System.out.println(e);
			return -1;
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}

	}

	/*
	//-----------------------------------------------------------------------------------------------------
	// 	부서 매핑 - 부서매핑을 위해 평가부서와 미배정 조직부서 조회 / 평가부서에 배정된 조직부서 조회
	//-----------------------------------------------------------------------------------------------------
	*/
	public void getDeptMapping(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			String year = request.getParameter("year");
			String mode = request.getParameter("mode");
			String sid = request.getParameter("sid");
			String bid = request.getParameter("bid");
			//System.out.println("mapping process..."+mode);
			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			if("M".equals(mode)){
				//System.out.println("mapping process..."+year+"/"+bid);
				sb.append(" SELECT * FROM TBLDEPTMAPPING M INNER JOIN  ")
				  .append(" (SELECT nvl(U.DEPT_CD, D.DEPT_CD) UDID, nvl(U.DEPT_NM, D.DEPT_NM) UDNAME, D.DEPT_NM DNAME, D.DEPT_CD DID, D.USE_YN, D.FINISHED_DT ")
				  .append("  FROM TBLDEPT D LEFT OUTER JOIN TBLDEPT U ON D.UP_DEPT_CD = U.DEPT_CD) DET ")
				  .append(" ON M.DEPT_CD = DET.DID ")
				  .append(" WHERE M.ORG_CD=? AND M.YEAR=? ")
				  .append(" ORDER BY UDID, DID ");

				params = new Object[] {bid,year};

				rs = dbobject.executePreparedQuery(sb.toString(),params);

				DataSet dsMap = new DataSet();
				dsMap.load(rs);

				request.setAttribute("dsMap", dsMap);

			}else{

				// 년도의 평가조직.
				 sb.append(" SELECT  a.sid, a.scid, a.sname, a.srank,                                                                                               \n");
				 sb.append("         a.bid, a.bcid, a.bname, a.brank,                                                                                               \n");
				 sb.append("         count(b.dept_cd) dept_cnt                                                                                                      \n");
				 sb.append(" FROM    (                                                                                                                              \n");
				 sb.append("         SELECT SID, SPID, SCID, SNAME, SRANK,                                                                                          \n");
				 sb.append("                BID, BPID, BCID, BNAME, BRANK                                                                                           \n");
				 sb.append("         FROM                                                                                                                           \n");
				 sb.append("                 (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME        \n");
				 sb.append("                  FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=?) SBU,                         \n");
				 sb.append("                 (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME        \n");
				 sb.append("                  FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=?) BSC                          \n");
				 sb.append("         WHERE   BSC.BPID=SBU.SID                                                                                                       \n");
				 sb.append("         ORDER BY SRANK, SID, BRANK, BID                                                                                                \n");
				 sb.append("         ) a,                                                                                                                           \n");
				 sb.append("         (                                                                                                                              \n");
				 sb.append("         SELECT a.dept_cd, a.org_cd, b.dept_nm, b.up_dept_cd                                                                            \n");
				 sb.append("         FROM   tbldeptmapping a,                                                                                                       \n");
				 sb.append("                tbldept        b                                                                                                        \n");
				 sb.append("         WHERE  a.dept_cd = b.dept_cd (+)                                                                                               \n");
				 sb.append("         AND    a.year = ?                                                                                                         \n");
				 sb.append("         ) b                                                                                                                            \n");
				 sb.append(" WHERE   a.bcid = b.org_cd(+)                                                                                                           \n");
				 sb.append(" GROUP BY a.sid, a.scid, a.sname, a.srank,                                                                                              \n");
				 sb.append("          a.bid, a.bcid, a.bname, a.brank                                                                                               \n");
				 sb.append(" ORDER BY a.srank, a.sid, a.brank, a.bid                                                                                                \n");

				params = new Object[] {year,year,year};

				rs = dbobject.executePreparedQuery(sb.toString(),params);

				DataSet dsOrg = new DataSet();
				dsOrg.load(rs);

				request.setAttribute("dsOrg", dsOrg);

				// 미배정 조직
				sb = new StringBuffer();
				sb.append(" SELECT * FROM ")
				  .append(" (SELECT nvl(U.DEPT_CD, D.DEPT_CD) UDID, nvl(U.DEPT_NM, D.DEPT_NM) UDNAME, D.DEPT_NM DNAME, D.DEPT_CD DID, D.USE_YN, D.FINISHED_DT ")
				  .append("  FROM TBLDEPT D LEFT OUTER JOIN TBLDEPT U ON D.UP_DEPT_CD = U.DEPT_CD) DET ")
				  .append(" WHERE DID NOT IN (SELECT DEPT_CD FROM TBLDEPTMAPPING WHERE YEAR=?) ")
				//  .append(" AND   DID     IN (SELECT DEPT_CD FROM tbldept WHERE NVL(FINISHED_DT,'99990101') >= ?||'0101')  ")
				  .append(" ORDER BY UDID, DID ");


				params = new Object[] {year};

				rs = dbobject.executePreparedQuery(sb.toString(),params);

				DataSet dsDept = new DataSet();
				dsDept.load(rs);

				request.setAttribute("dsDept", dsDept);
			}

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	//-----------------------------------------------------------------------------------------------------
	// 	부서 매핑 - 배정되거나 배정에서 빠진 부서 매핑 정보 변경
	//-----------------------------------------------------------------------------------------------------
	*/
	public void setDeptMapping(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year")==null?"":request.getParameter("year");
			String mode = request.getParameter("mode")==null?"":request.getParameter("mode");
			String sid = request.getParameter("sid")==null?"":request.getParameter("sid");
			String bid = request.getParameter("bid")==null?"":request.getParameter("bid");
			String nbid = request.getParameter("nbid")==null?"":request.getParameter("nbid");
			String arr = request.getParameter("arr")==null?"":request.getParameter("arr");
			String fmyear = request.getParameter("fmyear")==null?"":request.getParameter("fmyear");
			String toyear = request.getParameter("toyear")==null?"":request.getParameter("toyear");

			StringBuffer sb = new StringBuffer();
			StringBuffer sbI = new StringBuffer();
			StringBuffer sbD = new StringBuffer();
			Object[] params = null;
			Object[] paramI = null;
			Object[] paramD = null;

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			if(mode.equals("C")){
				//System.out.println("mapping copy..."+toyear+"/"+fmyear);
				sbD = new StringBuffer();
				sbD.append(" DELETE FROM TBLDEPTMAPPING WHERE YEAR=? ");
				paramD = new Object[] {toyear};

				dbobject.executePreparedUpdate(sbD.toString(),paramD);
				conn.commit();

				sbI = new StringBuffer();
				sbI.append(" INSERT INTO TBLDEPTMAPPING(YEAR,DEPT_CD,ORG_CD) ")
				   .append(" SELECT ?,DEPT_CD,ORG_CD FROM TBLDEPTMAPPING ")
				   .append(" WHERE YEAR=? ");
				paramI = new Object[] {toyear,fmyear};

				dbobject.executePreparedUpdate(sbI.toString(),paramI);
				conn.commit();

				request.setAttribute("rslt", "true");

			}else{
				String[] arrDept = arr.split(",");

				sbD.append(" DELETE FROM TBLDEPTMAPPING WHERE YEAR=? AND ORG_CD=? ");
				paramD = new Object[] {year,bid};

				dbobject.executePreparedUpdate(sbD.toString(),paramD);
				conn.commit();

				StringBuffer sbU = new StringBuffer();
				Object[] paramU = null;
				for(int i=0;i<arrDept.length;i++){
					//System.out.println("arr: "+year+"/"+arrDept[i]+"/"+bid+"/"+arrDept.length);
					if(!arrDept[i].equals("")){
						sbI = new StringBuffer();
						sbI.append(" INSERT INTO TBLDEPTMAPPING(YEAR,DEPT_CD,ORG_CD) VALUES(?,?,?)");
						paramI = new Object[] {year,arrDept[i],bid};

						dbobject.executePreparedUpdate(sbI.toString(),paramI);
						conn.commit();

						sbU = new StringBuffer();
						sbU.append(" UPDATE TBLUSER SET DIVCODE=? WHERE DEPT_CD=? ");
						paramU = new Object[] {bid,arrDept[i]};

						dbobject.executePreparedUpdate(sbU.toString(),paramU);
						conn.commit();
					}
				}
				request.setAttribute("rslt", "true");

				sb = new StringBuffer();
				sb.append(" SELECT * FROM ")
				  .append(" (SELECT nvl(U.DEPT_CD, D.DEPT_CD) UDID, nvl(U.DEPT_NM, D.DEPT_NM) UDNAME, D.DEPT_NM DNAME, D.DEPT_CD DID, D.USE_YN, D.FINISHED_DT ")
				  .append("  FROM TBLDEPT D LEFT OUTER JOIN TBLDEPT U ON D.UP_DEPT_CD = U.DEPT_CD) DET ")
				  .append(" WHERE DID NOT IN (SELECT DEPT_CD FROM TBLDEPTMAPPING WHERE YEAR=?) ")
				  .append(" AND   DID     IN (SELECT DEPT_CD FROM tbldept WHERE NVL(FINISHED_DT,'99990101') >= ?||'0101')  ")
				  .append(" ORDER BY UDID, DID ");

				params = new Object[] {year,year};

				rs = dbobject.executePreparedQuery(sb.toString(),params);

				DataSet dsDept = new DataSet();
				dsDept.load(rs);

				request.setAttribute("dsDept", dsDept);

				sb = new StringBuffer();
				sb.append(" SELECT * FROM TBLDEPTMAPPING M INNER JOIN  ")
				  .append(" (SELECT nvl(U.DEPT_CD, D.DEPT_CD) UDID, nvl(U.DEPT_NM, D.DEPT_NM) UDNAME, D.DEPT_NM DNAME, D.DEPT_CD DID, D.USE_YN, D.FINISHED_DT ")
				  .append("  FROM TBLDEPT D LEFT OUTER JOIN TBLDEPT U ON D.UP_DEPT_CD = U.DEPT_CD) DET ")
				  .append(" ON M.DEPT_CD = DET.DID ")
				  .append(" WHERE M.ORG_CD=? AND M.YEAR=? ")
				  .append(" ORDER BY UDID, DID ");

				params = new Object[] {nbid,year};

				rs = dbobject.executePreparedQuery(sb.toString(),params);

				DataSet dsMap = new DataSet();
				dsMap.load(rs);

				request.setAttribute("dsMap", dsMap);

			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
}
