package com.nc.user;

import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;


public class UserApp {

	public void setList(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String mode = request.getParameter("mode");
			String charType = request.getParameter("char");

			String searchKey = null;
			if(charType == null)
				searchKey = Util.getEUCKR(request.getParameter("searchKey"));
			else if(charType.equals("utf"))
				searchKey = Util.getUTF(request.getParameter("searchKey"));

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			if ("N".equals(mode)) {
				String userId = request.getParameter("userId");

				String userName = null;
				if(charType == null)
					userName = Util.getEUCKR(request.getParameter("userName"));
				else if(charType.equals("utf"))
					userName = Util.getUTF(request.getParameter("userName"));
				String email = request.getParameter("email");
				String groupId = request.getParameter("groupId");
				String bscId = request.getParameter("bscId");

				String auth01 = request.getParameter("auth01")!=null?request.getParameter("auth01"):"0";
				String app = request.getParameter("chkApp");
				String charge = request.getParameter("selCharge");
				String strI = "INSERT INTO TBLUSER (USERID,USERNAME,PASSWORD,EMAIL,GROUPID,AUTH01,APPRAISER,POSITION,DIVCODE,INPUTDATE) VALUES (?,?,?,?,?,  ?,?,?,?,?)";
				Object[] pmI = {userId,userName,"FDKGJBLCJHDBALMEEFHFNEIBCMNIGEGOJDEFICLK",email,groupId,auth01,app,charge,bscId,Util.getToDayTime()};

				dbobject.executePreparedUpdate(strI,pmI);

				conn.commit();
			} else if ("U".equals(mode)){
				String userId = request.getParameter("userId");

				String userName = null;
				if(charType == null)
					userName = Util.getEUCKR(request.getParameter("userName"));
				else if(charType.equals("utf"))
					userName = Util.getUTF(request.getParameter("userName"));

				String email = request.getParameter("email");
				String groupId = request.getParameter("groupId");
				String auth01 = request.getParameter("auth01")!=null?request.getParameter("auth01"):"0";
				String app = request.getParameter("chkApp");
				String charge = request.getParameter("selCharge");
				String bscId = request.getParameter("bscId");
				String strU = "UPDATE TBLUSER SET USERNAME=?,EMAIL=?,GROUPID=?,AUTH01=?,APPRAISER=?,POSITION=?,DIVCODE=?,INPUTDATE=? WHERE USERID=?";
				Object[] pmU = {userName,email,groupId,auth01,app,charge,bscId,Util.getToDayTime(),userId};

				dbobject.executePreparedUpdate(strU,pmU);

				conn.commit();
			} else if ("D".equals(mode)){
				String userId= request.getParameter("userId");

				String strD = "DELETE FROM TBLUSER WHERE USERID=?";
				Object[] pmD = {userId};

				dbobject.executePreparedUpdate(strD,pmD);

				conn.commit();
			}

			StringBuffer sbS = new StringBuffer();

			String divCode = request.getParameter("selDiv")!=null?request.getParameter("selDiv"):"%";
			if("-1".equals(divCode)) divCode= "%";
			String appraiser = request.getParameter("appraiser");
			String bscAuth = request.getParameter("bscAuth");
			System.out.println(searchKey);
			System.out.println(divCode);
			System.out.println(appraiser);
			System.out.println(bscAuth);

			Object[] pm = null;
			sbS.append("	SELECT U.*,(SELECT NAME FROM TBLBSC WHERE LTRIM(TO_CHAR(ID))=U.DIVCODE) DIVNAME,");
			sbS.append("	       (SELECT DEPT_NM FROM TBLDEPT WHERE DEPT_CD=U.DEPT_CD) DEPTNAME           ");
			sbS.append("	FROM  TBLUSER U                                                                 ");
			sbS.append("	WHERE USERNAME LIKE ?||'%'                                                      ");
			sbS.append("	AND   LTRIM(NVL(DIVCODE, '0')) LIKE ?                                           ");
			/*sbS.append("	AND   LTRIM(TO_CHAR(GROUPID,   '9')) LIKE ?                                     ");
			sbS.append("	AND   NVL(LTRIM(TO_CHAR(APPRAISER, '9')),'0') LIKE ?                            ");*/
			sbS.append("	ORDER BY USERNAME                                                               ");

			/*pm = new Object[] {searchKey,divCode,bscAuth,appraiser};*/
			pm = new Object[] {searchKey,divCode};

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

	public void setUserDetail(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			StringBuffer sbS = new StringBuffer();
			sbS.append("SELECT * FROM TBLBSC ORDER BY NAME");

			rs = dbobject.executeQuery(sbS.toString());

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds", ds);

			StringBuffer sb = new StringBuffer();
			sb.append("SELECT SDIV_CD id,DIV_NM name FROM TZ_COMCODE WHERE LDIV_CD='P01' ORDER BY id");

			rs = dbobject.executeQuery(sb.toString());

			DataSet dsPst = new DataSet();
			dsPst.load(rs);

			request.setAttribute("dsPst", dsPst);

			conn.commit();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public void getDutyList(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		ResultSet rs = null;
		DBObject dbobject = null;
		try {
		conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
		conn.createStatement(false);

		StringBuffer sbS = new StringBuffer();
		sbS.append("SELECT LDIV_CD, SDIV_CD ID, DIV_NM NAME FROM TZ_COMCODE WHERE LDIV_CD='P01' ORDER BY SDIV_CD");
		dbobject = new DBObject(conn.getConnection());
		rs = dbobject.executeQuery(sbS.toString());

		DataSet dsPst = new DataSet();
		dsPst.load(rs);

		request.setAttribute("dsPst", dsPst);

		conn.commit();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public void getManager(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			String year     = request.getParameter("year");
			String userId   = request.getParameter("userId");

			StringBuffer sbS = new StringBuffer();
			Object[] pm = null;
			sbS.append("	 SELECT * FROM                                                                                                                                                                                             ");
			sbS.append("	 (SELECT A.YEAR AYEAR,A.MEASUREID AMID,'M' TAG FROM TBLAUTHORITY A WHERE A.USERID like ? AND YEAR=?                                                                                               ");
			sbS.append("	 UNION                                                                                                                                                                                                     ");
			sbS.append("	 SELECT D.YEAR AYEAR,D.ID AMID,'S' TAG FROM TBLMEASUREDEFINE D WHERE D.UPDATEID like ? AND YEAR=?) AUT                                                                                            ");
			sbS.append("	 LEFT JOIN                                                                                                                                                                                                 ");
			sbS.append("	 (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,T.YEAR MTYEAR,D.MEASUREMENT                                                   ");
			sbS.append("	 FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=?  ) MEA                                           ");
			sbS.append("	 ON AUT.AMID=MEA.MCID AND AUT.AYEAR=MTYEAR                                                                                                                                                                 ");
			sbS.append("	 LEFT JOIN                                                                                                                                                                                                 ");
			sbS.append("	 (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME                                                                                           ");
			sbS.append("	 FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=?) OBJ                                                                                                          ");
			sbS.append("	 ON MEA.MPID=OBJ.OID                                                                                                                                                                                       ");
			sbS.append("	 LEFT JOIN                                                                                                                                                                                                 ");
			sbS.append("	 (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME                                                                                           ");
			sbS.append("	 FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=?) PST                                                                                                                ");
			sbS.append("	 ON OBJ.OPID=PST.PID                                                                                                                                                                                       ");
			sbS.append("	 INNER JOIN                                                                                                                                                                                                ");
			sbS.append("	 (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME                                                                                           ");
			sbS.append("	 FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=?) BSC                                                                                                                ");
			sbS.append("	 ON PST.PPID=BSC.BID                                                                                                                                                                                       ");
			sbS.append("	 INNER JOIN                                                                                                                                                                                                ");
			sbS.append("	 (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME                                                                                           ");
			sbS.append("	 FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=?) SBU                                                                                                                ");
			sbS.append("	 ON BSC.BPID=SBU.SID                                                                                                                                                                                       ");
			//sbS.append("	 LEFT JOIN                                                                                                                                                                                                 ");
			//sbS.append("	 (SELECT d.STRDATE, ROUND(D.ACTUAL,3) ACTUAL,D.PLANNED,D.PLANNEDBASE,D.BASE,D.BASELIMIT,D.LIMIT,FILEPATH,FILENAME,D.MEASUREID,ROUND(S.SCORE,3) SCORE,S.GRADE,S.GRADE_SCORE FROM TBLMEASUREDETAIL D, TBLMEASURESCORE S ");
			//sbS.append("	 WHERE D.MEASUREID=S.MEASUREID AND substr(D.STRDATE,1,6)=substr(S.STRDATE,1,6)) DET                                                                                                                        ");
			//sbS.append("	 ON AUT.AMID=DET.MEASUREID                                                                                                                                                                                 ");
			sbS.append("	 WHERE MID IS NOT NULL ORDER BY OID,ORANK,PRANK,PID,MRANK                                                                                                                                                   ");
			pm = new Object[]{userId,year,userId,year, year,year,year,year,year};

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
