package com.nc.xml;

import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.tree.TreeNode;
import com.nc.tree.TreeUtil;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;

import net.sf.json.JSONArray;

public class ScoreTableUtil {

	public void getDivision(HttpServletRequest request, HttpServletResponse response) {
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
	         .append(" ORDER BY CRANK,SRANK,SID,BRANK,BID ");

	         Object[] params = {year,year,year};

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

	public void setScoreTable(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String year  = request.getParameter("year");
			String bscId = request.getParameter("bscId");

			TreeUtil treeutil = new TreeUtil(conn.getConnection());

			TreeNode treenode = treeutil.getTreeRoot(year,bscId);

			StringBuffer sb = new StringBuffer();
			treenode.buildTextNode(sb,5);

			request.setAttribute("sb",sb);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public JSONArray selectScoreTableScore(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String year  = request.getParameter("year");
			String bscId = request.getParameter("bid");

			TreeUtil treeutil = new TreeUtil(conn.getConnection());

			TreeNode treenode = treeutil.getTreeRoot(year,bscId);

			JSONArray jArray = new JSONArray();

			treenode.buildJsonNode(jArray,5);

			return jArray;
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}

		return null;
	}

	public JSONArray selectMeasureScore(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String year  = request.getParameter("year");
			String bscId = request.getParameter("bid");

			TreeUtil treeutil = new TreeUtil(conn.getConnection());

			TreeNode treenode = treeutil.getTreeRoot(year,bscId);

			JSONArray jArray = new JSONArray();

			treenode.buildJsonMeasure(jArray,5);

			return jArray;
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}

		return null;
	}

	public void setMeasureDetail(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year");
			String mid = request.getParameter("mid");

			StringBuffer sb = new StringBuffer();
			sb.append("SELECT SUBSTR(D.STRDATE,1,4) YEAR, SUBSTR(D.STRDATE,5,2) MONTH,ROUND(D.ACTUAL,2) ACTUAL,D.WEIGHT,D.PLANNED,D.COMMENTS,D.BASE,D.LIMIT,ROUND(S.SCORE,2) SCORE ")
			  .append("       , D.PLANNEDBASE, D.BASELIMIT, D.GRADE  ")
			  .append(" FROM TBLMEASUREDETAIL D,TBLMEASURESCORE S WHERE D.MEASUREID=S.MEASUREID(+) AND SUBSTR(D.STRDATE,1,6)=SUBSTR(S.STRDATE(+),1,6) ")
			  .append(" AND D.MEASUREID=? AND SUBSTR(D.STRDATE,0,4)=? ORDER BY D.STRDATE ");

	        Object[] params = {mid,year};

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

	public void setMeasureList(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year");
			String bid = request.getParameter("bid");

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM  ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? AND T.ID=? ) BSC ")
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
	         .append(" ORDER BY BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");

	        Object[] params = {year,bid,year,year,year};

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

	public void setMeasureItem(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year");
			String mid = request.getParameter("mcid");

			String beforeY=null;
			if (year!=null){
				int y = new Integer(year).intValue();
				y = y-1;
				beforeY = String.valueOf(y);
			}
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM ( ")
	         .append(" SELECT SUBSTR(D.STRDATE,1,4) YEAR, SUBSTR(D.STRDATE,5,2) MONTH,ROUND(D.ACTUAL,2) ACTUAL,D.WEIGHT,D.PLANNED,D.COMMENTS,D.BASE,D.LIMIT,ROUND(S.SCORE,2) SCORE, D.PLANNEDBASE, D.BASELIMIT ")
	         .append(" FROM TBLMEASUREDETAIL D,TBLMEASURESCORE S WHERE D.MEASUREID=S.MEASUREID(+) AND SUBSTR(D.STRDATE,1,6)=SUBSTR(S.STRDATE(+),1,6) ")
	         .append(" AND D.MEASUREID=? AND SUBSTR(D.STRDATE,0,4)=? ) CUR ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SUBSTR(D.STRDATE,1,4) YEARB, SUBSTR(D.STRDATE,5,2) MONTHB,ROUND(D.ACTUAL,2) ACTUALB,D.WEIGHT WEIGHTB,D.PLANNED PLANNEDB,D.COMMENTS COMMENTSB,D.BASE BASEB, D.PLANNEDBASE PLANNEDBASEB, D.BASELIMIT BASELIMITB ")
	         .append(" ,D.LIMIT LIMITB,ROUND(S.SCORE,2) SCOREB ")
	         .append(" FROM TBLMEASUREDETAIL D,TBLMEASURESCORE S WHERE D.MEASUREID=S.MEASUREID(+) AND SUBSTR(D.STRDATE,1,6)=SUBSTR(S.STRDATE(+),1,6) ")
	         .append(" AND D.MEASUREID=(SELECT ID FROM TBLMEASUREDEFINE WHERE ETLKEY=(SELECT D.ETLKEY FROM TBLMEASUREDEFINE D WHERE D.ID=?) AND YEAR=?)  ")
	         .append(" AND SUBSTR(D.STRDATE,0,4)=?)BEF ")
	         .append(" ON CUR.MONTH=BEF.MONTHB ")
	         .append(" ORDER BY YEAR,MONTH ");

	        Object[] params = {mid,year,mid,beforeY,beforeY};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sb.toString(),params);

			System.out.println("setMeasureItem : mid " + mid + "\n" + sb.toString());

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds", ds);

			StringBuffer sb1 = new StringBuffer();
			sb1.append(" SELECT * FROM  ")
	         .append(" ( ")
	         .append(" SELECT I.CODE,I.ITEMNAME,I.ITEMENTRY,I.ITEMTYPE FROM TBLITEM I WHERE I.MEASUREID=? ")
	         .append(" ) ITEM ")
	         .append(" LEFT JOIN ")
	         .append(" ( ")
	         .append(" SELECT A.CODE CD, A.STRDATE,SUBSTR(A.STRDATE,0,4) YEAR,SUBSTR(A.STRDATE,5,2) MONTH,A.ACTUAL,A.ACCUM,A.AVERAGE FROM TBLITEMACTUAL A WHERE A.MEASUREID=? AND SUBSTR(A.STRDATE,0,4)=?  ")
	         .append(" ) ACT ")
	         .append(" ON ITEM.CODE=ACT.CD ORDER BY CODE,STRDATE ");
			Object[] pm1 = {mid,mid,year};

			if (rs!=null){ rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(sb1.toString(),pm1);

			DataSet dsItem = new DataSet();
			dsItem.load(rs);

			request.setAttribute("dsItem",dsItem);

			StringBuffer s = new StringBuffer();
			s.append("SELECT C.NAME,D.*,(SELECT USERNAME FROM TBLUSER U WHERE D.UPDATEID=U.USERID) USERNAME FROM TBLMEASUREDEFINE D,TBLMEASURE C WHERE D.MEASUREID=C.ID AND D.ID=?");
			Object[] o = {mid};

			if (rs!=null) {rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(s.toString(),o);

			DataSet dsMea = new DataSet();
			dsMea.load(rs);

			request.setAttribute("dsMea",dsMea);

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

			String mid  = request.getParameter("mid");
			String year = request.getParameter("year");

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,D.ID MCID,D.MEASUREID,D.DETAILDEFINE,D.WEIGHT,D.UNIT,D.PLANNED,D.FREQUENCY,D.EQUATION,D.EQUATIONDEFINE,D.UPDATEID,D.MEAN, ")
	         .append(" D.ETLKEY,D.MEASUREMENT,D.YEAR,D.TREND,D.BASE,D.LIMIT,D.Y,D.YA1,D.YA2,D.YA3,D.YA4,D.YB1,D.YB2,D.YB3,D.DATASOURCE, D.PLANNEDBASE, D.BASELIMIT, D.IFSYSTEM, D.MNGDEPTNM, D.TARGETRATIONLE, ")
	         .append(" (SELECT USERNAME FROM TBLUSER WHERE USERID=D.UPDATEID) USERNAME, ")
	         .append(" C.NAME,T.RANK FROM TBLMEASUREDEFINE D, TBLMEASURE C,TBLTREESCORE T WHERE T.CONTENTID=D.ID AND T.TREELEVEL=5 AND D.MEASUREID=C.ID AND D.ID=? ) MEA ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
	         .append(" ON MEA.MPID=OBJ.OID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
	         .append(" ON OBJ.OPID=PST.PID ");

			Object[] paramS = {mid,year,year};

			rs = dbobject.executePreparedQuery(sb.toString(),paramS);

			DataSet ds = new DataSet();

			ds.load(rs);
			System.out.println("ds : "+ds.toString());
			request.setAttribute("ds",ds);

			String strItem ="SELECT * FROM TBLITEM WHERE MEASUREID=? ORDER BY CODE";
			Object[] pmItem = {mid};
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strItem,pmItem);

			DataSet dsItem = new DataSet();
			dsItem.load(rs);

			request.setAttribute("dsItem",dsItem);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}


	public void setMomo(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());


			String mid = request.getParameter("mid");
			String year = request.getParameter("year");

			String userId = (String) request.getSession().getAttribute("userId");

			if (userId == null) {
				String msg = "다시 접속해 주십시오.";
				request.setAttribute("msg",msg);
				return;
			}

			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";


			String strUser = "SELECT USERID, USERNAME, (SELECT NAME FROM TBLBSC WHERE ID=DIVCODE) DNAME FROM TBLUSER WHERE USERID=?";
			Object[] pmUser = {userId};

			if (rs!=null){rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(strUser,pmUser);

			DataSet dsUser = new DataSet();
			dsUser.load(rs);

			request.setAttribute("dsUser",dsUser);


			StringBuffer sb = new StringBuffer();
			sb.append("SELECT D.STRDATE,ROUND(D.ACTUAL,2) ACTUAL,ROUND(D.PLANNED,2) PLANNED,ROUND(D.BASE,2)BASE,ROUND(D.LIMIT,2) LIMIT,D.COMMENTS,D.FILENAME,TO_CHAR(D.INPUTDATE,'YYYYMMDD') INPUTDATE, ")
				.append(" TO_CHAR(D.UPDATEDATE,'YYYYMMDD') UPDATEDATE, ")
				.append(" (SELECT USERNAME FROM TBLUSER WHERE USERID=INPUTID) INNAME, ")
				.append(" (SELECT USERNAME FROM TBLUSER WHERE USERID=UPDATEID) UPNAME FROM TBLMEASUREDETAIL D WHERE D.MEASUREID=? ORDER BY STRDATE ");

			Object[] paramS = {mid};

			if (rs!=null) {rs.close(); rs = null;}

			rs = dbobject.executePreparedQuery(sb.toString(),paramS);

			DataSet dsMemo = new DataSet();
			dsMemo.load(rs);

			request.setAttribute("dsMemo",dsMemo);

			String strMea ="SELECT D.UPDATEID, C.NAME FROM TBLMEASUREDEFINE D, TBLMEASURE C WHERE D.MEASUREID=C.ID AND D.ID=?";

			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strMea,paramS);

			DataSet dsMea = new DataSet();
			dsMea.load(rs);

			request.setAttribute("dsMea",dsMea);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}


	/*
	 * 	Object   : getMemoMeas : 지표의 간략정보를 구함
	 *  Created  : 2008.05.02 by PHG
	 */

	public void getMemoMeas(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			String mid  = request.getParameter("mid" );
			System.out.println("mid1 : "+mid);

			StringBuffer sb = new StringBuffer();
			sb.append("  select a.id, a.measureid, b.name,             ");
			sb.append("         a.frequency     , a.weight,            ");
			sb.append("         a.equationdefine, a.equation,          ");
			sb.append("         a.measurement   , a.etlkey             ");
			sb.append("  from   tblmeasuredefine a,                    ");
			sb.append("         tblmeasure       b                     ");
			sb.append("  where  a.measureid = b.id                     ");
			sb.append("  and    a.id = ?                               ");


			Object[] paramS = {mid};

			if (rs!=null) {rs.close(); rs = null;}

			rs = dbobject.executePreparedQuery(sb.toString(),paramS);

			DataSet dsMeas = new DataSet();
			dsMeas.load(rs);
			System.out.println("dsMeas : "+dsMeas.toString());
			request.setAttribute("ds",dsMeas);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 * 	Object   : getMemoMeasQty : 계량지표의 정보를 구함.
	 *  Created  : 2008.05.02 by PHG
	 */

	public void getMemoMeasQty(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			String mid  = request.getParameter("mid");

			StringBuffer sb = new StringBuffer();
			sb.append(" select substr(d.strdate,1,6)  ym    ,                ");
			sb.append("        round(d.actual ,2)     actual,                ");
			sb.append("        round(d.planned,2)     planned,               ");
			sb.append("        round(d.plannedbase,2) plannedbase,           ");
			sb.append("        round(d.base,2)        base,                  ");
			sb.append("        round(d.baselimit,2)   baselimit,             ");
			sb.append("        round(d.limit,2)       limit,                 ");
			sb.append("        d.comments ,                                  ");
			sb.append("        d.filename ,                                  ");
			sb.append("        d.filepath ,                                  ");
			sb.append("        d.grade                grade                  ");
			sb.append(" from   tblmeasuredetail d                            ");
			sb.append(" where  d.measureid=?                                 ");
//			sb.append(" and    d.comments is not null                        ");
			sb.append(" order by strdate                                     ");

			//System.out.println(sb.toString());

			Object[] paramS = {mid};

			if (rs!=null) {rs.close(); rs = null;}

			rs = dbobject.executePreparedQuery(sb.toString(),paramS);

			DataSet dsMemo = new DataSet();
			dsMemo.load(rs);
			//System.out.println(dsMemo.toString());
			request.setAttribute("ds",dsMemo);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 * 	Object   : getMemoMeasQtyItem : 계량지표의 정보를 구함.
	 *  Created  : 2008.05.02 by PHG
	 */

	public void getMemoMeasQtyItem(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			String mid  = request.getParameter("mid");
			String ym   = request.getParameter("ym" );
			System.out.println("----------mid : "+mid);
			System.out.println("----------ym : "+ym);
			StringBuffer sbSQL = new StringBuffer();
			sbSQL.append(" select a.code, a.itemname, a.itementry,  ");
			sbSQL.append("        b.actual                          ");
			sbSQL.append(" from   tblitem a,                        ");
			sbSQL.append("        tblitemactual b                   ");
			sbSQL.append(" where  a.measureid = b.measureid (+)     ");
			sbSQL.append(" and    a.code      = b.code      (+)     ");
			sbSQL.append(" and    a.measureid = ?                   ");
			sbSQL.append(" and    b.strdate   like ?||'%'           ");
			sbSQL.append(" order by a.code                          ");


			Object[] paramS = {mid, ym};

			if (rs!=null) {rs.close(); rs = null;}

			rs = dbobject.executePreparedQuery(sbSQL.toString(),paramS);

			DataSet dsMemo = new DataSet();
			dsMemo.load(rs);

			request.setAttribute("ds",dsMemo);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 * 	Object   : getMemoMeasQly : 비계량지표의 정보를 구함.
	 *  Created  : 2008.05.02 by PHG
	 */

	public void getMemoMeasQly(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			String mid  = request.getParameter("mid");

			System.out.println("mid : " + mid);

			StringBuffer sb = new StringBuffer();
			sb.append("  SELECT a.ym,                                                                                                                    ");
			sb.append("         b.planned  ,                                                                                                             ");
			sb.append("         b.detail   ,                                                                                                             ");
			sb.append("         b.estigrade,                                                                                                             ");
			sb.append("         b.estimate         ,                                                                                                     ");
			sb.append("         b.filename         ,                                                                                                     ");
			sb.append("         b.grade            ,                                                                                                     ");
			sb.append("         b.filepath         ,                                                                                                     ");
			sb.append("         b.filename_plan    ,                                                                                                     ");
			sb.append("         b.filepath_plan    ,                                                                                                     ");
			sb.append("         b.evalopinion      ,                                                                                                     ");
			sb.append("         b.evalrnm                                                                                                                ");
			sb.append("  FROM                                                                                                                            ");
			sb.append("          (                                                                                                                       ");
			sb.append("          select year, mm, year||mm ym, frequency                                                                                 ");
			sb.append("          from   tblmeasuredefine a ,                                                                                             ");
			sb.append("                  (                                                                                                               ");
			sb.append("                  select '년'   freq, ltrim(to_char(rownum * 12,'00')) mm from tz_calendar where rownum <= 1  union               ");
			sb.append("                  select '반기' freq, ltrim(to_char(rownum * 6 ,'00')) mm from tz_calendar where rownum <= 2  union               ");
			sb.append("                  select '분기' freq, ltrim(to_char(rownum * 3 ,'00')) mm from tz_calendar where rownum <= 4  union               ");
			sb.append("                  select '월'   freq, ltrim(to_char(rownum * 1 ,'00')) mm from tz_calendar where rownum <= 12                     ");
			sb.append("                  ) freq                                                                                                          ");
			sb.append("          where  id  = ?                                                                                                        ");
			sb.append("          and    frequency = freq                                                                                                 ");
			sb.append("          ) a,                                                                                                                    ");
			sb.append("          (                                                                                                                       ");
			sb.append("           select a.measureid,                                                                                                    ");
			sb.append("                 substr(a.effectivedate,1,6)          ym,                                                                         ");
			sb.append("                 a.planned  ,                                                                                                     ");
			sb.append("                 a.detail   ,                                                                                                     ");
			sb.append("                 a.estigrade,                                                                                                     ");
			sb.append("                 a.estimate ,                                                                                                     ");
			sb.append("                 a.filepath ,                                                                                                     ");
			sb.append("                 a.filename ,                                                                                                     ");
			sb.append("                 b.grade    ,                                                                                                     ");
			sb.append("                 a.filepath_plan    ,                                                                                             ");
			sb.append("                 a.filename_plan    ,                                                                                             ");
			sb.append("                 NVL(evalopinion,' ') evalopinion,                                                                                ");
			sb.append("                 ' '                    evalrnm                                                                                   ");
			sb.append("          from   tblevalmeasuredetail a,                                                                                          ");
			sb.append("                 tblmeasuredetail     b,                                                                                          ");
			sb.append("                 (                                                                            ");
			sb.append("                  SELECT evalid, year||month  ym, MAX(evalopinion)  evalopinion               ");
			sb.append("                  FROM   tblmeaevaldetail c                                                   ");
			sb.append("                  WHERE  evalid = ?                                                           ");
			sb.append("                  GROUP BY evalid, year||month                                                ");
			sb.append("                  ) c                                                                         ");

/*
			sb.append("                 (                                                                                                                ");
			sb.append("                  SELECT 	evalid,  ym,                                                                                         ");
			sb.append("         		              SUBSTR(MAX(SYS_CONNECT_BY_PATH (opinion, '+ ')), 4) evalopinion                                  ");
			sb.append("                  FROM                                                                                                            ");
			sb.append("                          (                                                                                                       ");
			sb.append("                          SELECT evalid, year||month  ym, ' '||NVL(c.evalopinion, ' ') opinion,                                        ");
			sb.append("                                 ROW_NUMBER () OVER (PARTITION BY evalid, year, month ORDER BY evalid, year, month) rnum          ");
			sb.append("                          FROM   tblmeaevaldetail c                                                                               ");
			sb.append("                          WHERE  evalid = ?                                                                                       ");
//			sb.append("                          AND    confirm = 1                                                                                      ");
			sb.append("                          AND    evalopinion is not null                                                                          ");
			sb.append("                          )                                                                                                       ");
			sb.append("                  START WITH rnum = 1                                                                                             ");
			sb.append("                  CONNECT BY PRIOR rnum = rnum - 1                                                                                ");
			sb.append("                         AND PRIOR evalid = evalid                                                                                ");
			sb.append("                         AND PRIOR ym = ym                                                                                        ");
			sb.append("                  GROUP BY evalid, ym                                                                                             ");
			sb.append("                  ) c                                                                                                             ");
*/
			sb.append("          where  a.measureid                 = b.measureid (+)                                                                    ");
			sb.append("          and    substr(a.effectivedate,1,6) = substr(b.strdate(+), 1,6)                                                          ");
			sb.append("          and    a.measureid                 = c.evalid    (+)                                                                    ");
			sb.append("          and    substr(a.effectivedate,1,6) = c.ym        (+)                                                                    ");
			sb.append("          and    a.measureid     like ?                                                                                         ");
			sb.append("          order by a.effectivedate                                                                                                ");
			sb.append("          ) b                                                                                                                     ");
			sb.append("  where  a.ym = b.ym (+)                                                                                                          ");
			sb.append("  order by a.ym                                                                                                                   ");

			//System.out.println(sb.toString());

			Object[] paramS = {mid,mid,mid};

			if (rs!=null) {rs.close(); rs = null;}

			rs = dbobject.executePreparedQuery(sb.toString(),paramS);

			DataSet dsMemo = new DataSet();
			dsMemo.load(rs);

			request.setAttribute("ds",dsMemo);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 * 	getMemo : 전격전인 보수작업을 합니다...허허헉... KOPEC 사용안함.
	 */

	public void getMemo(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			String mid  = request.getParameter("mid");
			System.out.println("mid"+mid);
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT SUBSTR(D.STRDATE,1,4)||'-'||SUBSTR(D.STRDATE,5,2)  YM, ");
			sb.append("        ROUND(D.ACTUAL ,2)     ACTUAL,                ");
			sb.append("        ROUND(D.PLANNED,2)     PLANNED,               ");
			sb.append("        ROUND(D.PLANNEDBASE,2) PLANNEDBASE,           ");
			sb.append("        ROUND(D.BASE,2)        BASE,                  ");
			sb.append("        ROUND(D.BASELIMIT,2)   BASELIMIT,             ");
			sb.append("        ROUND(D.LIMIT,2)       LIMIT,                 ");
			sb.append("        D.COMMENTS ,                                  ");
			sb.append("        D.FILENAME ,                                  ");
			sb.append("        TO_CHAR(D.UPDATEDATE,'YYYY.MM.DD') UPDATEDATE,");
			sb.append("        f_getempnm(D.UPDATEID)           UPDATENM,    ");
			sb.append("        D.GRADE                GRADE                  ");
			sb.append(" FROM   tblmeasuredetail d                            ");
			sb.append(" WHERE  D.MEASUREID=?                                 ");
			sb.append(" AND    D.COMMENTS IS NOT NULL                        ");
			sb.append(" ORDER BY STRDATE DESC                                ");

			//System.out.println(sb.toString());

			Object[] paramS = {mid};

			if (rs!=null) {rs.close(); rs = null;}

			rs = dbobject.executePreparedQuery(sb.toString(),paramS);

			DataSet dsMemo = new DataSet();
			dsMemo.load(rs);

			request.setAttribute("ds",dsMemo);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	//----------------------------------------------------------------------------------------------------------

}
