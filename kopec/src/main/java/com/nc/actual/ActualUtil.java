package com.nc.actual;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.math.Expression;
import com.nc.math.ExpressionParser;
import com.nc.sql.CoolConnection;
import com.nc.util.Common_Data;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

import com.nc.util.ServerStatic;
import com.nc.util.Util;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.ByUserIdFileRenamePolicy;
//import com.sun.corba.se.ActivationIDL.Server;

public class ActualUtil {

	public ActualUtil() {
		// TODO Auto-generated constructor stub
	}
	public void setAuthMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year   = request.getParameter("year");
			String month  = request.getParameter("month");
			String sbuId  = request.getParameter("sbuId");
			String bscId  = request.getParameter("bscId");
			String userId = (String)request.getSession().getAttribute("userId");

			if (year==null) return;

			System.out.println("SBU : " + sbuId + ",BSC : " + bscId + ", month : " + month);

			String groupId = (String)request.getSession().getAttribute("groupId");
			int group = 5;

			if (groupId!=null) group = Integer.parseInt(groupId);

			if (group>3) return;
			if (group==1){
				userId = "%";
			}

			String frq = getFrequecny(new Integer(month).intValue());

			StringBuffer sb = new StringBuffer();
			Object[] params = null;
		   sb.append(" SELECT * FROM ")
	         .append(" (SELECT A.YEAR AYEAR,A.MEASUREID AMID FROM TBLAUTHORITY A WHERE A.USERID like ? AND YEAR=? ")
	         .append(" UNION ")
	         .append(" SELECT D.YEAR AYEAR,D.ID AMID  FROM TBLMEASUREDEFINE D WHERE D.UPDATEID like ? AND YEAR=?) AUT ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,T.YEAR MTYEAR,D.MEASUREMENT  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.FREQUENCY IN ("+frq+") AND MEASUREMENT='계량' ) MEA ")
	         .append(" ON AUT.AMID=MEA.MCID AND AUT.AYEAR=MTYEAR ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
	         .append(" ON MEA.MPID=OBJ.OID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
	         .append(" ON OBJ.OPID=PST.PID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? AND T.ID LIKE ?) BSC ")
	         .append(" ON PST.PPID=BSC.BID ")
	         .append(" JOIN ")
	         .append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? AND T.ID LIKE ?) SBU ")
	         .append(" ON BSC.BPID=SBU.SID ")
	         .append(" LEFT JOIN ")
	         .append("(SELECT ROUND(D.ACTUAL,3) ACTUAL,D.PLANNED,D.PLANNEDBASE,D.BASE,D.BASELIMIT,D.LIMIT,FILEPATH,FILENAME,D.MEASUREID,ROUND(S.SCORE,3) SCORE,S.GRADE,S.GRADE_SCORE FROM TBLMEASUREDETAIL D, TBLMEASURESCORE S ")
	         .append(" WHERE D.MEASUREID=S.MEASUREID AND substr(D.STRDATE,1,6)=substr(S.STRDATE,1,6) AND SUBSTR(D.STRDATE,0,6)=?) DET ")
	         .append(" ON AUT.AMID=DET.MEASUREID ")
	         .append(" WHERE MID IS NOT NULL ORDER BY OID,ORANK,PRANK,PID,MRANK");

	         params = new Object[] {userId,year,userId,year, year,year,year,
	        		                year,bscId, year,sbuId, year+month};

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

	public void setDivision(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year")!=null?request.getParameter("year"):null;
			if (year == null){
				year = request.getAttribute("year")!= null?request.getAttribute("year").toString():Util.getPrevQty(null).substring(0,4);
			}
			//System.out.println("YEAR :::::: " + year);

			int groupId = Integer.parseInt((String)request.getSession().getAttribute("groupId"));
			String userId = (String)request.getSession().getAttribute("userId");

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
		         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 ")
		         .append(" AND T.YEAR=? AND D.ID IN (                                                                                                ")
				 .append("                           SELECT D.ID AMID        FROM TBLMEASUREDEFINE D WHERE D.UPDATEID like ? AND YEAR=?   ")
				 .append("                           UNION                                                                                           ")
				 .append("                           SELECT A.MEASUREID AMID FROM TBLAUTHORITY A WHERE A.USERID like ? AND YEAR=? ) ) MEA ")
		         .append(" ON OBJ.OID=MEA.MPID ")
		         .append(" WHERE MID IS NOT NULL ")
		         .append(" GROUP BY CID,CRANK,SID,SCID,SPID,SNAME,SRANK,BID,BCID,BPID,BNAME,BRANK ")
		         .append(" ORDER BY CRANK,CID,SRANK,SID,BRANK,BID ");

		         params = new Object[] {year,year,year,year,year,year,userId, year, userId, year};
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

	public void setMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String schDate = request.getParameter("schDate");

			String year = schDate.substring(0,4);
			String month = schDate.substring(4,6);
			String bscId = request.getParameter("bscId");

			String frq = getFrequecny(new Integer(month).intValue());//반기 분기 구별

			StringBuffer sb = new StringBuffer();
			Object[] params = null;
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
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,D.MEASUREMENT,  ")
	         .append("  UPDATEID,(SELECT (SELECT B.NAME FROM TBLBSC B WHERE B.ID=U.DIVCODE) FROM TBLUSER U WHERE U.USERID=UPDATEID) DIVNAME ")
	         .append("  FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C  WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.FREQUENCY IN ("+frq+") ) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT ACTUAL,SCORE,GRADE,GRADE_SCORE,MEASUREID,STRDATE,FILEPATH,FILENAME FROM  ")
	         .append("  (SELECT ROUND(ACTUAL,3) ACTUAL,MEASUREID,STRDATE,FILEPATH,FILENAME FROM TBLMEASUREDETAIL) DET ")
	         .append("  LEFT JOIN ")
	         .append("  (SELECT ROUND(SCORE,3) SCORE,GRADE,GRADE_SCORE, MEASUREID SCRMID,STRDATE SCRDATE FROM TBLMEASURESCORE )SCR ")
	         .append("  ON DET.MEASUREID=SCR.SCRMID AND DET.STRDATE=SCR.SCRDATE) DET ")
	         .append(" ON MEA.MCID=DET.MEASUREID AND SUBSTR(STRDATE,0,6)=? ")
	         .append(" WHERE MEASUREMENT='계량' AND MID IS NOT NULL ")
	         .append(" ORDER BY BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");

	        params = new Object[] {year,bscId,year,year,year,schDate};

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

	public void setActual(HttpServletRequest request, HttpServletResponse response) {

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		String msg = null;

		try {

			Common_Data cd = new Common_Data();

			String userId = (String)request.getSession().getAttribute("userId");
			String groupId = (String)request.getSession().getAttribute("groupId");

			if (userId == null) return;

			int group = Integer.parseInt(groupId);

			String type = request.getContentType()!=null?request.getContentType():"";
			if (type.indexOf(";")>0) {
				int ik = type.indexOf(";");
				type = type.substring(0,ik);
			}

			if ("multipart/form-data".equals(type)) {
				int sizeLimit = 10 * 1024 * 1024; // 10M, 파일 사이즈 제한, 제한 사이즈 초과시 exception발생.
				String UPLOADROOT = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"actual"+File.separator+"upload"; // 경로 지정(절대 경로 | ROOT를 기준으로 한 상대경로)
				//String UPLOADROOT = "http://203.255.122.31:8088/bsc"+File.separator+"actual"+File.separator+"upload"; // 경로 지정(절대 경로 | ROOT를 기준으로 한 상대경로)

				String UPLOADPATH = UPLOADROOT + File.separator;
				File upfolder = new File(UPLOADROOT);

				if(!upfolder.isDirectory())
				{
					upfolder.mkdir();
				}

				//MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit, new DefaultFileRenamePolicy()); // 이부분에서 upload가 됨. Unix 계열.
				//MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit,"euc-kr", new DefaultFileRenamePolicy()); // 이부분에서 upload가 됨.

				MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit,"euc-kr", new ByUserIdFileRenamePolicy());      // 서버 한글 깨짐 ...
				//위에서 업로드 하기전  new ByUserIdFileRenamePolicy() <-- 부분에서 특수문자 삭제
				ArrayList filename = new ArrayList();
				ArrayList originalFilename = new ArrayList();
				Enumeration filenames = multi.getFileNames();







				while(filenames.hasMoreElements())   {
					String formName = (String)filenames.nextElement();
					filename.add(multi.getFilesystemName(formName));

				    System.out.println("form : "+ (multi.getFilesystemName(formName)));

				    originalFilename.add(cd.ReplaceCode1(multi.getOriginalFileName(formName)));
				    System.out.println("ooooooformName : "+originalFilename);
				}


				//String file = Util.getEUCKR((String)filename.get(0));
				String file = (String)filename.get(0);
				file = cd.ReplaceCode1(file); //String 에서 ' 를 제가 하는 함수


				String originalFile = (String) originalFilename.get(0);


				String tag = multi.getParameter("tag");
				String schDate = multi.getParameter("schDate");
				String mid = multi.getParameter("contentId");




				if ((schDate==null)||(mid==null)) return;

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);

				dbobject = new DBObject(conn.getConnection());

				String year = schDate.substring(0,4);
				String month = schDate.substring(4,6);
				boolean step = true;

				if ("U".equals(tag)){
					String itemCD = multi.getParameter("itemCD");
					String[] code = itemCD.split("\\|");
					double[] act = new double[code.length];
					double[] acc = new double[code.length];
					double[] avg = new double[code.length];
					String[] itemType = new String[code.length];
					Double[] cal = new Double[code.length];

					HashMap map = new HashMap();

					StringBuffer sbItem = new StringBuffer();
					sbItem.append("SELECT COUNT(ACTUAL) CNT,SUM(ACTUAL) ACC,AVG(ACTUAL) AVG FROM TBLITEMACTUAL WHERE MEASUREID=? AND CODE=? AND STRDATE>=? AND STRDATE<?");
					Object[] pmItem = {mid,null,year+"01",schDate};

					StringBuffer sbItemI = new StringBuffer();
					sbItemI.append("INSERT INTO TBLITEMACTUAL (MEASUREID,CODE,STRDATE,INPUTDATE,ACTUAL,ACCUM,AVERAGE) VALUES (?,?,?,?,?, ?,?)");
					Object[] pmItemI = {mid,null,schDate,Util.getToDay().substring(0,8),null,null,null};

					StringBuffer sbItemU = new StringBuffer();
					sbItemU.append("UPDATE TBLITEMACTUAL SET INPUTDATE=?,ACTUAL=?,ACCUM=?,AVERAGE=? WHERE MEASUREID=? AND CODE=? AND STRDATE=?");
					Object[] pmItemU = {Util.getToDay().substring(0,8),null,null,null,mid,null,schDate};



					for (int i = 0; i < code.length; i++) {
						System.out.println("itemAcutal"+i+" : "+multi.getParameter("itemAcutal"+code[i])) ;
						if (multi.getParameter("itemAcutal"+code[i]).equals("")){
							step=false;
							msg="입력되지 않은 항목이 있습니다.";
							continue;
						}
						act[i] = new Double(multi.getParameter("itemAcutal"+code[i])).doubleValue();
						//itemType[i] = Util.getEUCKR(multi.getParameter("itemType"+code[i]));
						itemType[i] = (multi.getParameter("itemType"+code[i]));
						if (rs!=null){rs.close(); rs=null;}
						pmItem[1]=code[i];
						rs = dbobject.executePreparedQuery(sbItem.toString(),pmItem);
						while(rs.next()){
							int cnt = rs.getInt("CNT");
							if (cnt == 0){
								acc[i]=act[i];
								avg[i]=act[i];
							} else {
								acc[i] = rs.getDouble("ACC")+act[i];
								avg[i] = acc[i]/(cnt+1);
							}
						}
						pmItemU[1] = new Double(act[i]);
						pmItemU[2] = new Double(acc[i]);
						pmItemU[3] = new Double(avg[i]);
						pmItemU[5] = code[i];
						if (dbobject.executePreparedUpdate(sbItemU.toString(),pmItemU)<1){
							pmItemI[1] = code[i];
							pmItemI[4] = new Double(act[i]);
							pmItemI[5] = new Double(acc[i]);
							pmItemI[6] = new Double(avg[i]);

							dbobject.executePreparedUpdate(sbItemI.toString(),pmItemI);
						}

						if (itemType[i].equals("누적")){
							cal[i]=new Double(acc[i]);
						} else if (itemType[i].equals("평균")){
							cal[i]=new Double(avg[i]);
						} else {
							cal[i]=new Double(act[i]);
						}
						map.put(code[i],cal[i]);
					}


					StringBuffer strEqu = new StringBuffer();
					strEqu.append("SELECT EQUATION,WEIGHT,TREND,FREQUENCY,SCORECODE SCODE,PLANNED,PLANNEDBASEPLUS, PLANNEDBASE,BASEPLUS,BASE,     BASELIMITPLUS,BASELIMIT,LIMITPLUS,LIMIT FROM TBLMEASUREDEFINE WHERE ID=? ") ;

					Object[] pmEqu = {mid};

					if (rs!=null){rs.close(); rs=null;}

					rs = dbobject.executePreparedQuery(strEqu.toString(),pmEqu);
					String equ = "";
					String weight = null;
					String trend = null;
					String frequency = null;



					/* 2014 11 20 구간 9등급으로 변경
					int upper = ServerStatic.UPPER;
					int high  = ServerStatic.HIGH;
					int low   = ServerStatic.LOW;
					int lower = ServerStatic.LOWER;
					int lowst = ServerStatic.LOWST;
					*/
					/*int upper     = 100;
					int highplus  = 95;
					int high      = 90;
					int lowplus   = 85;
					int low       = 80;
					int lowerplus = 75;
					int lower     = 70;
					int lowstplus = 65;
					int lowst     = 60;*/

					double upper     = 100;
					double highplus  = 87.5;
					double high      = 75;
					double lowplus   = 62.5;
					double low       = 50;
					double lowerplus = 37.5;
					double lower     = 25;
					double lowstplus = 12.5;
					double lowst     = 0;

					double PLANNED          = 100;
					double PLANNEDBASEPLUS  = 95;
					double PLANNEDBASE      = 90;
					double BASEPLUS         = 85;
					double BASE             = 80;
					double BASELIMITPLUS    = 75;
					double BASELIMIT        = 70;
					double LIMITPLUS        = 65;
					double LIMIT            = 65;  // limitplus와 같게...


					while(rs.next()){
						equ       = rs.getString("EQUATION");
						weight    = rs.getString("WEIGHT");
						trend     = rs.getString("TREND");
						frequency = rs.getString("FREQUENCY");

						PLANNED          = rs.getDouble("PLANNED");
						PLANNEDBASEPLUS  = rs.getDouble("PLANNEDBASEPLUS");
						PLANNEDBASE      = rs.getDouble("PLANNEDBASE");
						BASEPLUS         = rs.getDouble("BASEPLUS");
						BASE             = rs.getDouble("BASE");
						BASELIMITPLUS    = rs.getDouble("BASELIMITPLUS");
						BASELIMIT        = rs.getDouble("BASELIMIT");
						LIMITPLUS        = rs.getDouble("LIMITPLUS");
						LIMIT            = rs.getDouble("LIMIT");

					}

					ExpressionParser exParser = null;
					Expression expression = null;
					Hashtable table = null;

					try {

						exParser = new ExpressionParser(equ);
						expression = exParser.getCompleteExpression();

						Vector vector = new Vector();
						expression.addUnknowns(vector);
						int k = vector.size();
						table = new Hashtable();
						for (int j = 0; j < k ; j++) {
							String icd = (String)vector.get(j);

							//System.out.println(" Loop j :" + j + ", icd :" + icd);

							Object obj = map.get(icd);

							//------------------------------------------------
							//System.out.println(" Object j :" + j + ", Object :" + obj.toString());

							if (obj!=null)
								table.put(icd,obj);
						}

					} catch (Exception ex){
						msg="산식 오류가 있습니다.";
						step=false;
					}


					if (step) {
						Double actual = null;
						try {
							actual = (Double)expression.evaluate(table);

							///////////////////////////////////////////////////////////////
							/*  목표값이 -일때 보정 KOPEC만 적용  */
							if ("$X01/$X02*100".equals(equ) ) {
								Double val01 = (Double)map.get("X01");
								Double val02 = (Double)map.get("X02");
								if ( (val01 > 0)&&(val02 < 0) ){
									actual = -actual;
								}
							}

							//System.out.println("Equation :" + equ + " Actual : " + actual);
							////////////////////////////////////////////////////////////////

						} catch (Exception exp) {
							msg="계산값에 오류가 있습니다.";
						}
						if ((actual!=null)&&(!actual.isInfinite())){
							MeasureDetail measuredetail = getMeasureDetail (dbobject, mid, Util.getLastMonth(schDate));
							//
							measuredetail.planned         = PLANNED;
							measuredetail.plannedbaseplus = PLANNEDBASEPLUS;
							measuredetail.plannedbase     = PLANNEDBASE;
							measuredetail.baseplus        = BASEPLUS;
							measuredetail.base            = BASE;
							measuredetail.baselimitplus   = BASELIMITPLUS;
							measuredetail.baselimit       = BASELIMIT;
							measuredetail.limitplus       = LIMITPLUS;
							measuredetail.limit           = LIMIT;

							//
							measuredetail.actual = actual.doubleValue();
							measuredetail.strDate = Util.getLastMonth(schDate);
							measuredetail.weight = new Float(weight).floatValue();
							measuredetail.measureId = new Integer(mid).intValue();
							measuredetail.trend = (trend==null)?"상향":trend;
							measuredetail.frequency = frequency;
							//measuredetail.comments = Util.getEUCKR(multi.getParameter("comments"));
							measuredetail.comments = cd.ReplaceCode3((multi.getParameter("comments")));
							//cd.ReplaceCode3(); <--- 받아온 문자열에서 <, > 를 &lt; , &gt; 로 변화해서 저장함
							measuredetail.updater = userId;

							measuredetail.upper     = upper;
							measuredetail.highplus  = highplus;
							measuredetail.high      = high;
							measuredetail.lowplus   = lowplus;
							measuredetail.low       = low;
							measuredetail.lowerplus = lowerplus;
							measuredetail.lower     = lower;
							measuredetail.lowstplus = lowstplus;
							measuredetail.lowst     = lowst;

							System.out.println("Measure Detail Planned Flag : " + measuredetail.plannedflag);

							/////////////////////////////////////////////////////////////////// attach File
							String strFilename = file;


							//System.out.println("Actual : " + measuredetail.actual);

							if (strFilename!=null) {

								// if isExit File delete file;;;
								try {
									if (measuredetail.filePath !=null){
										File tempfile = new File(measuredetail.filePath);
										if(tempfile.exists()){
											tempfile.delete();
										}
									}
								} catch (Exception se) {
									System.out.println(se);
								}
								measuredetail.fileName =  (originalFile);
								measuredetail.filePath = (strFilename);
							}
							updateMeasureDetail(dbobject,measuredetail);

						} else {
							msg = "무한값이 계산됩니다.";
						}
					}




				} else if ("D".equals(tag) ) {

					String strD = "DELETE FROM TBLITEMACTUAL WHERE MEASUREID=? AND STRDATE=?";
					Object[] pmD = {mid,schDate};

					dbobject.executePreparedUpdate(strD,pmD);


					String strEqu = "SELECT EQUATION,WEIGHT,TREND,FREQUENCY FROM TBLMEASUREDEFINE WHERE ID=?";
					Object[] pmEqu = {mid};

					if (rs!=null){rs.close(); rs=null;}

					rs = dbobject.executePreparedQuery(strEqu,pmEqu);
					String equ       = "";
					String weight    = null;
					String trend     = null;
					String frequency = null;
					while(rs.next()){
						equ       = rs.getString("EQUATION");
						weight    = rs.getString("WEIGHT");
						trend     = rs.getString("TREND");
						frequency = rs.getString("FREQUENCY");
					}

					MeasureDetail measuredetail = getMeasureDetail (dbobject,mid,schDate);
					measuredetail.frequency = frequency;
					String savepath = File.separator+"actual"+File.separator+"upload"+File.separator;
					if (measuredetail.filePath !=null){
						File tmpfile = new File(UPLOADROOT +File.separator+ measuredetail.fileName);
						if(tmpfile.exists()){
							tmpfile.delete();
						}
					}
					deletemeasureDetail(dbobject,measuredetail);
				} else if ("FD".equals(tag)){
					MeasureDetail measuredetail = getMeasureDetail (dbobject,mid,schDate);
					String savepath = File.separator+"actual"+File.separator+"upload"+File.separator;
					if (measuredetail.filePath !=null){
						File tmpfile = new File(UPLOADROOT +File.separator+ measuredetail.filePath);
						if(tmpfile.exists()){
							tmpfile.delete();
						}
					}

					String strFD = "UPDATE TBLMEASUREDETAIL SET FILEPATH=NULL,FILENAME=NULL WHERE ID=?";
					Object[] pmFD = {new Integer(measuredetail.id)};
					dbobject.executePreparedUpdate(strFD,pmFD);
				}

				StringBuffer sbMea = new StringBuffer();

				sbMea.append(" SELECT * FROM                                                                                                      ");
				sbMea.append(" (SELECT T.ID CID,T.PARENTID CPID,T.CONTENTID CCID,T.TREELEVEL CLEVEL,T.RANK CRANK,T.WEIGHT CWEIGHT,C.NAME CNAME    ");
				sbMea.append(" FROM TBLHIERARCHY T,TBLCOMPANY C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=0 AND T.YEAR=? ) COM                  ");
				sbMea.append(" LEFT JOIN                                                                                                          ");
				sbMea.append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME    ");
				sbMea.append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? ) SBU                      ");
				sbMea.append(" ON COM.CID=SBU.SPID                                                                                                ");
				sbMea.append(" LEFT JOIN                                                                                                          ");
				sbMea.append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME    ");
				sbMea.append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC                      ");
				sbMea.append(" ON SBU.SID=BSC.BPID                                                                                                ");
				sbMea.append(" LEFT JOIN                                                                                                          ");
				sbMea.append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME    ");
				sbMea.append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST                      ");
				sbMea.append(" ON BSC.BID=PST.PPID                                                                                                ");
				sbMea.append(" LEFT JOIN                                                                                                          ");
				sbMea.append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME    ");
				sbMea.append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ                ");
				sbMea.append(" ON PST.PID=OBJ.OPID                                                                                                ");
				sbMea.append(" LEFT JOIN                                                                                                          ");
				sbMea.append(" (SELECT T.CONTENTID MCID, T.PARENTID MPID,D.ID, C.NAME,D.EQUATION,D.TREND,D.UPDATEID,                              ");
				sbMea.append("        (SELECT U.USERNAME FROM TBLUSER U WHERE U.USERID=D.UPDATEID) UNAME,D.UNIT,D.EQUATIONTYPE, D.SCORECODE                    ");
				sbMea.append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C                                                               ");
				sbMea.append(" WHERE T.CONTENTID= D.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.MEASUREID=C.ID AND D.ID=? ) DEF                ");
				sbMea.append(" ON OBJ.OID=DEF.MPID                                                                                                ");
				sbMea.append(" JOIN                                                                                                               ");
				sbMea.append(" (SELECT TYPE FROM TBLEQUATIONTYPE ) TYPE                                                                              ");
				sbMea.append(" ON DEF.EQUATIONTYPE=TYPE.TYPE                                                                                      ");
				sbMea.append(" LEFT JOIN                                                                                                          ");
				sbMea.append(" (SELECT MEASUREID,PLANNED,PLANNEDBASE,BASE,BASELIMIT,LIMIT,"
						+ "    PLANNEDBASEPLUS,BASEPLUS, BASELIMITPLUS, LIMITPLUS, WEIGHT,ROUND(ACTUAL,3) ACTUAL,STRDATE,COMMENTS,FILENAME,FILEPATH ");
				sbMea.append("  FROM TBLMEASUREDETAIL WHERE MEASUREID=? AND SUBSTR(STRDATE,0,6)=?) DET                                     ");
				sbMea.append(" ON DEF.ID=DET.MEASUREID                                                                                            ");
				sbMea.append(" LEFT JOIN                                                                                                          ");
				sbMea.append(" (SELECT MEASUREID MID,ROUND(SCORE,3) SCORE,GRADE,GRADE_SCORE FROM TBLMEASURESCORE                                  ");
				sbMea.append(" WHERE MEASUREID=? AND SUBSTR(STRDATE,0,6)=?) SCR                                                            ");
				sbMea.append(" ON DEF.ID=SCR.MID                                                                                                  ");
				sbMea.append(" LEFT JOIN ");
				sbMea.append(" (SELECT SCORECODE SCODE,S,A,B,C,D FROM TBLSCORELEVEL ) SLEVEL");
				sbMea.append(" ON DEF.SCORECODE=SLEVEL.SCODE ");


				Object[] pmMea = {year,year,year,year,year,year,   mid,mid,schDate,mid,schDate};

				if (rs!=null){rs.close(); rs=null;}
				rs = dbobject.executePreparedQuery(sbMea.toString(),pmMea);

				DataSet dsMea = new DataSet();
				dsMea.load(rs);

				boolean aut = false;
				if (group==1) {
					aut = true;
				} else if (group==3) {
					if (dsMea!=null) dsMea.next();
					String updater = dsMea.getString("UPDATEID");
					if (updater!=null){
						if (updater.equals(userId)){
							aut=true;
						} else {
							String strAut = "SELECT USERID FROM TBLAUTHORITY WHERE MEASUREID=? AND USERID=? AND YEAR=?";
							Object[] pmAut = {mid,userId,schDate.substring(0,4)};

							if (rs!=null){rs.close(); rs=null;}
							rs = dbobject.executePreparedQuery(strAut,pmAut);
							if (rs.next()){
								aut = true;
							}
						}
					}
					dsMea.resetCursor();
				}
				request.setAttribute("dsMea", dsMea);

				request.setAttribute("aut",new Boolean(aut));

				StringBuffer sbItem = new StringBuffer();
				sbItem.append(" SELECT * FROM ")
		         .append(" (SELECT * FROM TBLITEM WHERE MEASUREID=(SELECT ID FROM TBLMEASUREDEFINE WHERE ID=?) ) ITEM ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT MEASUREID MID,CODE CD,STRDATE,ACTUAL,ROUND(ACCUM,3) ACCUM,ROUND(AVERAGE,3) AVERAGE FROM TBLITEMACTUAL WHERE STRDATE=? AND MEASUREID=?) ACT ")
		         .append(" ON ITEM.CODE=ACT.CD ORDER BY CODE");

				Object[] pmItem = {mid,schDate,mid};

				if (rs!=null){rs.close(); rs=null;}
				rs = dbobject.executePreparedQuery(sbItem.toString(),pmItem);

				DataSet dsItem = new DataSet();
				dsItem.load(rs);

				request.setAttribute("dsItem",dsItem);

				request.setAttribute("mid",mid);

				String strAut = "SELECT (SELECT USERNAME FROM TBLUSER U WHERE U.USERID=A.USERID) UNAME FROM TBLAUTHORITY A WHERE A.MEASUREID=?";
				Object[] pmAut = {mid};

				if(rs!=null){rs.close(); rs=null;}
				rs = dbobject.executePreparedQuery(strAut,pmAut);

				DataSet dsAut = new DataSet();
				dsAut.load(rs);

				request.setAttribute("dsAut",dsAut);

				conn.commit();

				request.setAttribute("msg",msg);
				request.setAttribute("schDate",schDate);

			}

		} catch (IOException ie){
			System.out.print("setActual : " + ie);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public MeasureDetail getMeasureDetail(DBObject dbobject,String mid, String date) throws SQLException{
		ResultSet rs = null;
		try {
			//String s = "SELECT * FROM TBLMEASUREDETAIL WHERE MEASUREID=? AND SUBSTR(STRDATE,0,6)=?";

			// KOPEC의 특수한 상황임 ( 목표구간에 따른 점수 재계산 처리)

			String s  = " SELECT a.*, NVL(b.planned_flag,'U') PLANNEDFLAG " ;
				   s += " FROM   TBLMEASUREDETAIL a, TBLMEASUREDEFINE b "   ;
			       s += " WHERE  a.MEASUREID = b.ID(+)                  "   ;
			       s += " AND    a.MEASUREID =? AND substr(a.STRDATE,0,6)=? ";

			Object[] p = {mid, date.substring(0, 6)};

			MeasureDetail detail = new MeasureDetail();
			rs = dbobject.executePreparedQuery(s,p);
			while(rs.next()){
				detail.id = rs.getInt("ID");
				detail.measureId   = rs.getInt("MEASUREID");
				detail.strDate     = rs.getString("STRDATE");
				detail.actual      = rs.getDouble("ACTUAL");
				detail.weight      = rs.getFloat("WEIGHT");


				/*
				detail.planned     = rs.getDouble("PLANNED");
				detail.plannedbaseplus = rs.getDouble("PLANNEDBASEPLUS");
				detail.plannedbase = rs.getDouble("PLANNEDBASE");

				detail.baseplus    = rs.getDouble("BASEPLUS");
				detail.base        = rs.getDouble("BASE");

				detail.baselimitplus   = rs.getDouble("BASELIMITPLUS");
				detail.baselimit   = rs.getDouble("BASELIMIT");

				detail.limitplus       = rs.getDouble("LIMITPLUS");
				detail.limit       = rs.getDouble("LIMIT");
				*/

				detail.filePath    = rs.getString("FILEPATH");
				detail.fileName    = rs.getString("FILENAME");
				detail.plannedflag = rs.getString("PLANNEDFLAG");
			}

			return detail;
		} catch (SQLException e) {

			throw e;
		} finally {
			if (rs!=null) {rs.close(); rs=null;}
		}
	}

	public int deletemeasureDetail(DBObject dbobject,MeasureDetail measuredetail) throws SQLException {
		int reval=0;
		try {
			   	ArrayList list = getMonths(dbobject,measuredetail);

			   	String scrD="DELETE FROM TBLMEASURESCORE WHERE MEASUREID=? AND SUBSTR(STRDATE,0,6)=?";
			   	Object[] pmSD = {new Integer(measuredetail.measureId),null};
				for (int i = 0; i < list.size(); i++) {
					pmSD[1] = (String)list.get(i);
					dbobject.executePreparedUpdate(scrD,pmSD);
				}


				String str = "UPDATE TBLMEASUREDETAIL SET ACTUAL=NULL,FILEPATH=NULL,FILENAME=NULL,COMMENTS=NULL WHERE ID=? ";
				Object[] pm = {new Integer(measuredetail.id)};

				reval=dbobject.executePreparedUpdate(str,pm);

			dbobject.getConnection().commit();
			return reval;
		} catch (SQLException e) {

			throw e;
		} finally {

		}
	}

	public int updateMeasureDetail(DBObject dbobject, MeasureDetail measuredetail) throws SQLException {
		int reval=0;
		try {

			//update measurescore;
			double grade_score = measuredetail.getScoreVariable();

			if (measuredetail.id==0){
				String str = "INSERT INTO TBLMEASUREDETAIL (ID,MEASUREID,STRDATE,ACTUAL,WEIGHT,  PLANNED,PLANNEDBASEPLUS, PLANNEDBASE,BASEPLUS,BASE,     "
						+ "BASELIMITPLUS,BASELIMIT,LIMITPLUS,LIMIT,  GRADE, GRADE_SCORE, FILEPATH,FILENAME,INPUTID,INPUTDATE,COMMENTS) "
						+ " VALUES (?,?,?,?,?,    ?,?,?,?,?,   ?,?,?,?   ,?,?,  ?,?,?,SYSDATE,?)";
				//String str = "INSERT INTO TBLMEASUREDETAIL (ID,MEASUREID,STRDATE,ACTUAL,WEIGHT,FILEPATH,FILENAME,INPUTID,INPUTDATE,COMMENTS,GRADE,GRADE_SCORE) VALUES (?,?,?,?, ?,?,?,?,SYSDATE,?,?,?)";
				Object[] pm = new Object[20];

				measuredetail.id = dbobject.getNextId("TBLMEASUREDETAIL");
				pm[0] = new Integer(measuredetail.id);
				pm[1] = new Integer(measuredetail.measureId);
				pm[2] = measuredetail.strDate;
				pm[3] = new Double(measuredetail.actual);
				pm[4] = new Float(measuredetail.weight);

				pm[5] = new Double(measuredetail.planned);
				pm[6] = new Double(measuredetail.plannedbaseplus);
				pm[7] = new Double(measuredetail.plannedbase);
				pm[8] = new Double(measuredetail.baseplus);
				pm[9] = new Double(measuredetail.base);


				pm[10] = new Double(measuredetail.baselimitplus);
				pm[11] = new Double(measuredetail.baselimit);
				pm[12] = new Double(measuredetail.limitplus);
				pm[13] = new Double(measuredetail.limit);

				pm[14] = measuredetail.grade;
				pm[15] = new Double(grade_score);

				pm[16] = measuredetail.filePath;
				pm[17] = measuredetail.fileName;
				pm[18] = measuredetail.updater;
				pm[19] = measuredetail.comments;


				reval=dbobject.executePreparedUpdate(str,pm);
			} else {

				String str = "UPDATE TBLMEASUREDETAIL SET ACTUAL=?,WEIGHT=?,PLANNED=?,PLANNEDBASEPLUS=?,PLANNEDBASE=?,BASEPLUS=?,BASE=?,BASELIMITPLUS=?,BASELIMIT=?,LIMITPLUS=?,LIMIT=?,"
						+ " GRADE=?, GRADE_SCORE=?,  FILEPATH=?,FILENAME=?,UPDATEID=?,UPDATEDATE=SYSDATE,COMMENTS=? WHERE ID=? ";
				//String str = "UPDATE TBLMEASUREDETAIL SET ACTUAL=?,WEIGHT=?,FILEPATH=?,FILENAME=?,UPDATEID=?,UPDATEDATE=SYSDATE,COMMENTS=?,GRADE=?,GRADE_SCORE=? WHERE ID=? ";
				Object[] pm = new Object[18];
				pm[0] = new Double(measuredetail.actual);
				pm[1] = new Float(measuredetail.weight);
				pm[2] = new Double(measuredetail.planned);
				pm[3] = new Double(measuredetail.plannedbaseplus);
				pm[4] = new Double(measuredetail.plannedbase);
				pm[5] = new Double(measuredetail.baseplus);
				pm[6] = new Double(measuredetail.base);
				pm[7] = new Double(measuredetail.baselimitplus);
				pm[8] = new Double(measuredetail.baselimit);
				pm[9] = new Double(measuredetail.limitplus);
				pm[10] = new Double(measuredetail.limit);

				pm[11] = measuredetail.grade;
				pm[12] = new Double(grade_score);

				pm[13] = measuredetail.filePath;
				pm[14] = measuredetail.fileName;
				pm[15] = measuredetail.updater;
				pm[16] = measuredetail.comments;
				pm[17] = new Integer(measuredetail.id);

				reval=dbobject.executePreparedUpdate(str,pm);
			}

			if (grade_score !=-1){
				String strU = "UPDATE TBLMEASURESCORE SET ACTUAL=?,WEIGHT=?,PLANNED=?,PLANNEDBASEPLUS=?,PLANNEDBASE=?,BASEPLUS=?,BASE=?,BASELIMITPLUS=?,BASELIMIT=?,LIMITPLUS=?,LIMIT=?,"
						+ "SCORE=?,GRADE=?,GRADE_SCORE=? WHERE MEASUREID=? AND STRDATE = ?";
				Object[] pmU = new Object[16];
				pmU[0] = new Double(measuredetail.actual);
				pmU[1] = new Float(measuredetail.weight);
				pmU[2] = new Double(measuredetail.planned);
				pmU[3] = new Double(measuredetail.plannedbaseplus);
				pmU[4] = new Double(measuredetail.plannedbase);
				pmU[5] = new Double(measuredetail.baseplus);
				pmU[6] = new Double(measuredetail.base);
				pmU[7] = new Double(measuredetail.baselimitplus);
				pmU[8] = new Double(measuredetail.baselimit);
				pmU[9] = new Double(measuredetail.limitplus);
				pmU[10] = new Double(measuredetail.limit);
				pmU[11] = new Double(measuredetail.score);
				pmU[12] = new String(measuredetail.grade);
				pmU[13] = new Double(grade_score);
				pmU[14] = new Integer(measuredetail.measureId);
				pmU[15] = null;

				String strI = "INSERT INTO TBLMEASURESCORE (MEASUREID,STRDATE,ACTUAL,WEIGHT,    PLANNED,PLANNEDBASEPLUS, PLANNEDBASE,BASEPLUS,BASE,     BASELIMITPLUS,BASELIMIT,LIMITPLUS,LIMIT,    SCORE, GRADE, GRADE_SCORE) "
						+ "VALUES (?,?,?,?,    ?,?,?,?,?,    ?,?,?,?,  ?,?,?)";
				Object[] pmI = new Object[16];
				pmI[0] = pmU[14];
				pmI[1] = null;
				pmI[2] = pmU[0];
				pmI[3] = pmU[1];

				pmI[4] = pmU[2];
				pmI[5] = pmU[3];
				pmI[6] = pmU[4];
				pmI[7] = pmU[5];
				pmI[8] = pmU[6];
				pmI[9] = pmU[7];
				pmI[10] = pmU[8];
				pmI[11] = pmU[9];
				pmI[12] = pmU[10];

				pmI[13] = pmU[11];
				pmI[14] = pmU[12];
				pmI[15] = pmU[13];


				ArrayList list = getMonths(dbobject,measuredetail);
				for (int i = 0; i < list.size(); i++) {
					pmU[15] = Util.getLastMonth((String)list.get(i));

					if (dbobject.executePreparedUpdate(strU,pmU)<1){
						pmI[1] = pmU[15];
						dbobject.executePreparedUpdate(strI,pmI);
					}
				}
				//System.out.println("update:"+pmU[9]+"/"+pmU[8]+"/"+pmU[7]);
			}
			//System.out.println("updatedetail:"+measuredetail.strDate+"/"+measuredetail.grade+"/"+measuredetail.grade_score+"/"+measuredetail.score);
			dbobject.getConnection().commit();
			return reval;
		} catch (SQLException e) {
			if (dbobject != null){dbobject.close(); dbobject = null;}
			throw e;
		} finally {

		}
	}

	/* 2009.02.20 박성주 팀장의 요청에 의해
	 *
	 * 1. 분기지표 입력시 입력월부터 다음 주기 직전월까지 점수생성.
	 *
	 */

	public ArrayList getMonths(DBObject dbobject,MeasureDetail measuredetail) throws SQLException {
		ResultSet rs = null;
		ArrayList list = new ArrayList();
		String year = measuredetail.strDate.substring(0,4);
		String month = measuredetail.strDate.substring(4,6);

		int m = new Integer(month).intValue();
		try {
			String str = "SELECT SCORE FROM TBLMEASURESCORE WHERE MEASUREID=? AND SUBSTR(STRDATE,0,6)=?";
			Object[] pm = {new Integer(measuredetail.measureId),null};
			if (measuredetail.frequency.equals("월")){
				list.add(year+month);
			} else if (measuredetail.frequency.equals("분기")){
				if (m==3){
					//list.add(year+"01"); list.add(year+"02");

					list.add(year+"03");
					pm[1]=year+"06";
					rs = dbobject.executePreparedQuery(str,pm);
					double score =-1;
					while(rs.next()){
						score = rs.getDouble("SCORE");
					}
					if (score ==-1){
						list.add(year+"04"); list.add(year+"05");
					}
				} else if (m==6) {
					//list.add(year+"04"); list.add(year+"05");

					list.add(year+"06");
					pm[1]=year+"09";
					rs = dbobject.executePreparedQuery(str,pm);
					double score =-1;
					while(rs.next()){
						score = rs.getDouble("SCORE");
					}
					if (score ==-1){
						list.add(year+"07"); list.add(year+"08");
					}
				} else if (m==9) {
					//list.add(year+"07"); list.add(year+"08");

					list.add(year+"09");
					pm[1]=year+"12";
					rs = dbobject.executePreparedQuery(str,pm);
					double score =-1;
					while(rs.next()){
						score = rs.getDouble("SCORE");
					}
					if (score ==-1){
						list.add(year+"10"); list.add(year+"11");
					}
				} else if (m==12){
					//list.add(year+"10"); list.add(year+"11");

					list.add(year+"12");
					int nYear = new Integer(year).intValue()+1;

					pm[1]=String.valueOf(nYear)+"03";
					rs = dbobject.executePreparedQuery(str,pm);
					double score =-1;
					while(rs.next()){
						score = rs.getDouble("SCORE");
					}
					if (score ==-1){
						list.add(String.valueOf(nYear)+"01"); list.add(String.valueOf(nYear)+"02");
					}
				}
			} else if (measuredetail.frequency.equals("반기")){
				if (m==6){
					//list.add(year+"01"); list.add(year+"02"); list.add(year+"03");list.add(year+"04"); list.add(year+"05");

					list.add(year+"06");
					pm[1]=year+"12";
					rs = dbobject.executePreparedQuery(str,pm);
					double score =-1;
					while(rs.next()){
						score = rs.getDouble("SCORE");
					}
					if (score ==-1){
						list.add(year+"07"); list.add(year+"08"); list.add(year+"09"); list.add(year+"10"); list.add(year+"11");
					}
				} else if (m==12) {
					//list.add(year+"07"); list.add(year+"08"); list.add(year+"09"); list.add(year+"10"); list.add(year+"11");

					list.add(year+"12");
					int nYear = new Integer(year).intValue()+1;

					pm[1]=String.valueOf(nYear)+"06";
					rs = dbobject.executePreparedQuery(str,pm);
					double score =-1;
					while(rs.next()){
						score = rs.getDouble("SCORE");
					}
					if (score ==-1){
						list.add(String.valueOf(nYear)+"01"); list.add(String.valueOf(nYear)+"02"); list.add(String.valueOf(nYear)+"03"); list.add(String.valueOf(nYear)+"04"); list.add(String.valueOf(nYear)+"05");
					}
				}
			} else if (measuredetail.frequency.equals("년")){
				//list.add(year+"01"); list.add(year+"02"); list.add(year+"03");list.add(year+"04"); list.add(year+"05"); list.add(year+"06");
				//list.add(year+"07"); list.add(year+"08"); list.add(year+"09");list.add(year+"10"); list.add(year+"11");

				list.add(year+"12");

				int nYear = new Integer(year).intValue()+1;
				pm[1]=String.valueOf(nYear)+"12";
				rs = dbobject.executePreparedQuery(str,pm);
				double score=-1;
				if(rs != null)
					while(rs.next()){
						score = rs.getDouble("SCORE");
					}
				if (score ==-1){
					//list.add(String.valueOf(nYear)+"01"); list.add(String.valueOf(nYear)+"02"); list.add(String.valueOf(nYear)+"03"); list.add(String.valueOf(nYear)+"04"); list.add(String.valueOf(nYear)+"05");list.add(String.valueOf(nYear)+"06");
					//list.add(String.valueOf(nYear)+"07"); list.add(String.valueOf(nYear)+"08"); list.add(String.valueOf(nYear)+"09"); list.add(String.valueOf(nYear)+"10"); list.add(String.valueOf(nYear)+"11");
				}
			}

			return list;
		} catch (SQLException e) {
			throw e;
		} finally {
			if (rs!=null) {rs.close(); rs=null;}
		}
	}

	public void setPlanned(HttpServletRequest request, HttpServletResponse response) {

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String tag = request.getParameter("tag");
			String schDate = request.getParameter("schDate");
			String mid =request.getParameter("contentId");

			//System.out.println(tag);
			if ((schDate==null)||(mid==null)) return;

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			String year = schDate.substring(0,4);


			if ("U".equals(tag)){
				String[] s = new String[12];
				String[] ap = new String[12];
				String[] a = new String[12];
				String[] bp = new String[12];
				String[] b = new String[12];
				String[] cp = new String[12];
				String[] c = new String[12];
				String[] dp = new String[12];
				String[] d = new String[12];

				String strU = "UPDATE TBLMEASUREDETAIL M SET WEIGHT=(SELECT WEIGHT FROM TBLMEASUREDEFINE D WHERE D.ID=M.MEASUREID) ,PLANNED=?,PLANNEDBASEPLUS=?,PLANNEDBASE=?,BASEPLUS=?,BASE=?,"
						+ "BASELIMITPLUS=?,BASELIMIT=?,LIMITPLUS=?,LIMIT=? WHERE MEASUREID=? AND substr(STRDATE,1,6)=substr(?,1,6)";
				Object[] pmU = {null,null,null,null,null   ,null,null,null,null,   mid,null};

				String strI = "INSERT INTO TBLMEASUREDETAIL (ID,MEASUREID,STRDATE,WEIGHT,      PLANNED,PLANNEDBASEPLUS,PLANNEDBASE,BASEPLUS,BASE,    BASELIMITPLUS,BASELIMIT,LIMITPLUS,LIMIT) "
						+ " VALUES (?,?,?,(SELECT WEIGHT FROM TBLMEASUREDEFINE D WHERE D.ID=?),  ?,?,?,?,?,  ?,?,?,?)";
				Object[] pmI = {null,mid,null,  mid,    null,null,null,null,null,     null,null,null,null};

				String strD = "DELETE FROM TBLMEASUREDETAIL WHERE MEASUREID=? AND substr(STRDATE,1,6)=substr(?,1,6)";
				Object[] pmD = {mid,null};

				for (int i = 0; i < 12; i++) {
					s[i]  =request.getParameter("s"+i);
					ap[i] =request.getParameter("ap"+i);
					a[i]  =request.getParameter("a"+i);
					bp[i] =request.getParameter("bp"+i);
					b[i]  =request.getParameter("b"+i);
					cp[i] =request.getParameter("cp"+i);
					c[i]  =request.getParameter("c"+i);
					dp[i] =request.getParameter("dp"+i);
					d[i]  =request.getParameter("d"+i);

					if ((s[i]!=null)&&(!"".equals(s[i]))){
						pmU[0]=s[i];
						pmU[1]=ap[i];
						pmU[2]=a[i];
						pmU[3]=bp[i];
						pmU[4]=b[i];

						pmU[5]=cp[i];
						pmU[6]=c[i];
						pmU[7]=dp[i];
						pmU[8]=d[i];

						pmU[10]=Util.getLastMonth(year+((i+1)<10?"0"+(i+1):String.valueOf(i+1)));

						if (dbobject.executePreparedUpdate(strU,pmU)<1){
							pmI[0]=new Integer(dbobject.getNextId("TBLMEASUREDETAIL"));

							pmI[2]=pmU[10];

							pmI[4]=pmU[0];
							pmI[5]=pmU[1];
							pmI[6]=pmU[2];
							pmI[7]=pmU[3];
							pmI[8]=pmU[4];
							pmI[9]=pmU[5];
							pmI[10]=pmU[6];
							pmI[11]=pmU[7];
							pmI[12]=pmU[8];

							dbobject.executePreparedUpdate(strI,pmI);
						}
					} else {
						pmD[1]=Util.getLastMonth(year+((i+1)<10?"0"+(i+1):String.valueOf(i+1)));
						dbobject.executePreparedUpdate(strD,pmD);
					}
				}
				String strDU = "UPDATE TBLMEASUREDEFINE SET PLANNED=?,   PLANNEDBASEPLUS=?,PLANNEDBASE=?,  BASEPLUS=?,BASE=?,  BASELIMITPLUS=?,BASELIMIT=?,  LIMITPLUS=?,LIMIT=? WHERE ID=?";
				Object[] pmDU = {s[11],ap[11],a[11],   bp[11], b[11],  cp[11],c[11],  dp[11],d[11],   mid};

				dbobject.executePreparedUpdate(strDU,pmDU);
			} else if ("D".equals(tag) ) {
				String strD= "DELETE FROM TBLMEASUREDETAIL WHERE MEASUREID=? AND SUBSTR(STRDATE,0,4)=?";
				Object[] pmD = {mid,year};

				dbobject.executePreparedUpdate(strD,pmD);
			}


			StringBuffer sbMea = new StringBuffer();
			sbMea.append(" SELECT D.ID,D.DETAILDEFINE,D.WEIGHT,D.FREQUENCY,D.PLANNED,D.PLANNEDBASEPLUS,D.PLANNEDBASE,"
					+ "D.BASEPLUS,D.BASE,D.BASELIMITPLUS, D.BASELIMIT,D.LIMITPLUS, D.LIMIT,D.UPDATEID,C.NAME FROM TBLMEASUREDEFINE D,TBLMEASURE  C WHERE D.MEASUREID=C.ID AND D.ID=? ");

			Object[] pmMea = {mid};

			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(sbMea.toString(),pmMea);

			DataSet dsMea = new DataSet();
			dsMea.load(rs);

			request.setAttribute("dsMea", dsMea);

			StringBuffer sbDetail = new StringBuffer();
			sbDetail.append(" SELECT SUBSTR(STRDATE,0,4) YEAR,SUBSTR(STRDATE,5,2) MONTH,PLANNED,PLANNEDBASEPLUS, PLANNEDBASE,"
					+ "BASEPLUS,BASE, BASELIMITPLUS, BASELIMIT, LIMITPLUS, LIMIT FROM TBLMEASUREDETAIL WHERE MEASUREID=? AND SUBSTR(STRDATE,0,4)=? ORDER BY STRDATE ");

			Object[] pmDetail= {mid,year};

			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(sbDetail.toString(),pmDetail);

			DataSet dsDetail = new DataSet();
			dsDetail.load(rs);

			request.setAttribute("dsDetail",dsDetail);

			request.setAttribute("mid",mid);

			conn.commit();
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	public void setMeasurePlanned(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String schDate = request.getParameter("schDate");

			String year = schDate.substring(0,4);
			String bscId = request.getParameter("bscId");

			int groupId = Integer.parseInt(request.getSession().getAttribute("groupId").toString());
			String userId = (String)request.getSession().getAttribute("userId");

			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			if (groupId < 2) {
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
		         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,D.UNIT, D.ETLKEY METLKEY  ")
		         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.MEASUREMENT='계량' ) MEA ")
		         .append(" ON OBJ.OID=MEA.MPID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT ACTUAL,MEASUREID,STRDATE,FILEPATH,FILENAME FROM  ")
		         .append(" (SELECT ACTUAL,MEASUREID,STRDATE,FILEPATH,FILENAME FROM TBLMEASUREDETAIL) DET ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT SCORE,MEASUREID SCRMID,STRDATE SCRDATE FROM TBLMEASURESCORE )SCR ")
		         .append(" ON DET.MEASUREID=SCR.SCRMID AND DET.STRDATE=SCR.SCRDATE) DET ")
		         .append(" ON MEA.MCID=DET.MEASUREID AND SUBSTR(STRDATE,0,6)=? ")
		         .append(" WHERE MID IS NOT NULL ")
		         .append(" ORDER BY BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");

		         params = new Object[] {year,bscId,year,year,year,schDate};
			} else {
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
		         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,D.UNIT, D.ETLKEY METLKEY  ")
		         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.UPDATEID=? AND D.MEASUREMENT='계량') MEA ")
		         .append(" ON OBJ.OID=MEA.MPID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT ACTUAL,MEASUREID,STRDATE,FILEPATH,FILENAME FROM  ")
		         .append(" (SELECT ACTUAL,MEASUREID,STRDATE,FILEPATH,FILENAME FROM TBLMEASUREDETAIL) DET ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT SCORE,MEASUREID SCRMID,STRDATE SCRDATE FROM TBLMEASURESCORE )SCR ")
		         .append(" ON DET.MEASUREID=SCR.SCRMID AND DET.STRDATE=SCR.SCRDATE) DET ")
		         .append(" ON MEA.MCID=DET.MEASUREID AND SUBSTR(STRDATE,0,6)=? ")
		         .append(" WHERE MID IS NOT NULL ")
		         .append(" ORDER BY BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");


		         params = new Object[] {year,bscId,year,year,year,userId,schDate};

				/*
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
		         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,D.UPDATEID,D.FREQUENCY,D.UNIT  ")
		         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND UPDATEID=?  ) MEA ")
		         .append(" ON OBJ.OID=MEA.MPID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT ACTUAL,MEASUREID,STRDATE,FILEPATH,FILENAME FROM  ")
		         .append(" (SELECT ACTUAL,MEASUREID,STRDATE,FILEPATH,FILENAME FROM TBLMEASUREDETAIL) DET ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT SCORE,MEASUREID SCRMID,STRDATE SCRDATE FROM TBLMEASURESCORE )SCR ")
		         .append(" ON DET.MEASUREID=SCR.SCRMID AND DET.STRDATE=SCR.SCRDATE) DET ")
		         .append(" ON MEA.MCID=DET.MEASUREID AND SUBSTR(STRDATE,0,6)=? ")
		         .append(" WHERE MID IS NOT NULL ")
		         .append(" ORDER BY BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");
					*/

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

	public void setMeasure2(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String schDate = request.getParameter("schDate");

			String year = schDate.substring(0,4);
			String bscId = request.getParameter("bscId");

			int groupId = Integer.parseInt(request.getSession().getAttribute("groupId").toString());
			String userId = (String)request.getSession().getAttribute("userId");

			StringBuffer sb = new StringBuffer();
			Object[] params = null;

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
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,D.UNIT, D.ETLKEY METLKEY  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=?  ) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT ACTUAL,MEASUREID,STRDATE,FILEPATH,FILENAME FROM  ")
	         .append(" (SELECT ACTUAL,MEASUREID,STRDATE,FILEPATH,FILENAME FROM TBLMEASUREDETAIL) DET ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE,MEASUREID SCRMID,STRDATE SCRDATE FROM TBLMEASURESCORE )SCR ")
	         .append(" ON DET.MEASUREID=SCR.SCRMID AND DET.STRDATE=SCR.SCRDATE) DET ")
	         .append(" ON MEA.MCID=DET.MEASUREID AND SUBSTR(STRDATE,0,6)=? ")
	         .append(" WHERE MID IS NOT NULL ")
	         .append(" ORDER BY BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");

	         params = new Object[] {year,bscId,year,year,year,schDate};


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

	public void setActWeight(HttpServletRequest request, HttpServletResponse response) {

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String mode = request.getParameter("mode");
			String schDate = request.getParameter("schDate");

			String year = schDate.substring(0,4);
			String bscId = request.getParameter("bscId");

			if ("U".equals(mode)){
				int rowCnt =  Integer.parseInt(request.getParameter("dsCnt"));
				if ((schDate==null)) return;

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);

				dbobject = new DBObject(conn.getConnection());

				String wData   = request.getParameter("wData");
				String wEtlkey = request.getParameter("wEtlkey");
				String wRank = request.getParameter("wRank");
				String wID = request.getParameter("wID");
				String wcID = request.getParameter("wcID");

				String[] arr1 = wData.split("/");
				String[] arr2 = wID.split("/");
				String[] arr3 = wEtlkey.split("/");
				String[] arr4 = wRank.split("/");
				String[] arr5 = wcID.split("/");
				Object[] params = null;

//				System.out.println("wData  ========"+wData);
//				System.out.println("wEtlkey  ========"+wEtlkey);
//				System.out.println("wRank  ========"+wRank);
//				System.out.println("wID  ========"+wID);
//				System.out.println("wcID  ========"+wcID);
//


		    	String pids = request.getParameter("pids");
		    	String pranks = request.getParameter("pranks");
		    	String oids = request.getParameter("oids");
		    	String oranks = request.getParameter("oranks");


				String[] aPid = pids.split("\\|");
				String[] aPrank = pranks.split("\\|");

				String[] oPid = oids.split("\\|");
				String[] oPrank = oranks.split("\\|");

				String strR = "UPDATE TBLTREESCORE SET RANK=? WHERE ID=? ";
				Object[] pmR = new Object[2];
				for (int a=0; a<aPid.length; a++) {
					if(aPid[a]!=null && !"".equals(aPid[a])){
						pmR[0] = aPrank[a];
						pmR[1] = aPid[a];
						dbobject.executePreparedUpdate(strR,pmR);
						dbobject.getConnection().commit();
					}
				}

				for (int a=0; a<oPid.length; a++) {
					if(oPid[a]!=null && !"".equals(oPid[a])){
						pmR[0] = oPrank[a];
						pmR[1] = oPid[a];
						dbobject.executePreparedUpdate(strR,pmR);
						dbobject.getConnection().commit();
					}
				}









				// 지표순서 및 가중치 Update...
				String str = "UPDATE TBLTREESCORE SET WEIGHT=?, RANK=? WHERE ID=? ";
				for(int i=1;i<=rowCnt;i++) {


					//System.out.println("weight:"+arr1[i]);
					//System.out.println("id:"+arr2[i]);

					params = new Object[] {arr1[i],arr4[i],arr2[i]};

					dbobject.executePreparedUpdate(str,params);
					dbobject.getConnection().commit();
				}

				// ETL KEY, Weight Update...
				for(int i=1;i<=rowCnt;i++) {
					String strM = "UPDATE TBLMEASUREDEFINE SET WEIGHT=?, ETLKEY=nvl(?," + i + ") WHERE ID=? ";

					params = new Object[] {arr1[i], arr3[i],arr5[i]};

					dbobject.executePreparedUpdate(strM, params);
					dbobject.getConnection().commit();
				}

				// ETL KEY Update...
				StringBuffer sb = new StringBuffer();

				System.out.println("Object Weight ...");
				sb = new StringBuffer();

				sb.append("update tbltreescore s ")
				  .append("set s.weight = (select oweight from ")
				  .append(" (select distinct oid, oname, sum(mweight) over (partition by bid, pid, oid) oweight from ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank ")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d  ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.oid) ")
				  .append("where exists (select oweight from ")
				  .append(" (select distinct oid, oname, sum(mweight) over (partition by bid, pid, oid) oweight from ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.oid) ");

				params = new Object[] {year,year,year,year,bscId,year,year,year,year,bscId};

				dbobject.executePreparedUpdate(sb.toString(),params);
				dbobject.getConnection().commit();

				System.out.println("Perspective Weight ...");
				sb = new StringBuffer();

				sb.append("update tbltreescore s ")
				  .append("set s.weight = (select pweight from ")
				  .append(" (select distinct pid, pname, sum(mweight) over (partition by bid, pid)  pweight from ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank ")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d  ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.pid) ")
				  .append("where exists (select pweight from ")
				  .append(" (select distinct pid, pname, sum(mweight) over (partition by bid, pid)  pweight from ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.pid) ");

				params = new Object[] {year,year,year,year,bscId,year,year,year,year,bscId};

				dbobject.executePreparedUpdate(sb.toString(),params);
				dbobject.getConnection().commit();


				System.out.println("BSC Weight ...");
				sb = new StringBuffer();

				sb.append("update tblhierarchy s ")
				  .append("set s.weight = (select bweight from ")
				  .append(" (select distinct bid, bname, sum(mweight) over (partition by cid, sid, bid) bweight from ")
				  .append("  (select c.name cname,t.id cid,t.contentid ccid,t.parentid cpid,t.rank crank ")
				  .append("  from tblcompany c, tblhierarchy t where t.treelevel=0 and t.year=? and t.contentid=c.id ) com, ")
				  .append("  (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank ")
				  .append("  from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id ) sbu, ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank ")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d  ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.bid) ")
				  .append("where exists (select bweight from ")
				  .append(" (select distinct bid, bname, sum(mweight) over (partition by cid, sid, bid) bweight from ")
				  .append("  (select c.name cname,t.id cid,t.contentid ccid,t.parentid cpid,t.rank crank ")
				  .append("  from tblcompany c, tblhierarchy t where t.treelevel=0 and t.year=? and t.contentid=c.id ) com, ")
				  .append("  (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank ")
				  .append("  from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id ) sbu, ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.bid) ");

				params = new Object[] {year,year,year,year,year,year,bscId,year,year,year,year,year,year,bscId};

				dbobject.executePreparedUpdate(sb.toString(),params);
				dbobject.getConnection().commit();

				//setMeasurePlanned(request, response);
			} else {
				//setMeasurePlanned(request, response);
			}

			// 다른 메서드를 사용해도 되잖아...
			setMeasure2(request, response);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public void getOrgMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year = request.getParameter("year");
			String month1 = request.getParameter("month1");
			String month2 = request.getParameter("month2");
			String sbuId = request.getParameter("sbuId");
			String mode = request.getParameter("mode");
			String contentId = request.getParameter("contentId");

			String groupId = (String)request.getSession().getAttribute("groupId");
			int group = 5;
			System.out.println("groupId :" + groupId);
			if (groupId!=null) group = Integer.parseInt(groupId);

			if (group>3) return;

			String userId = (String)request.getSession().getAttribute("userId");

			if (year==null) return;
			System.out.println("OutPut:"+userId+"/"+year+"/"+month1+"/"+month2+"/"+sbuId+"/"+mode+"/"+contentId);
			System.out.println("mode:"+mode);
			//String frq = getFrequecny(new Integer(month1).intValue());

			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			if(mode.equals("detail")) {
				StringBuffer sbItem = new StringBuffer();
				sbItem.append(" SELECT * FROM ")
		         	  .append(" (SELECT * FROM TBLITEM WHERE MEASUREID=(SELECT ID FROM (select ID from TBLMEASUREDEFINE where YEAR = ? AND MEASUREID=? ORDER BY ID) ITEMs WHERE ROWNUM = 1) ) ITEM ");
				params = new Object[] {year, contentId};

				rs = dbobject.executePreparedQuery(sbItem.toString(),params);

				DataSet dsItem = new DataSet();
				dsItem.load(rs);

				request.setAttribute("dsItem", dsItem);

				StringBuffer sbItemAct = new StringBuffer();
//				sbItemAct.append(" SELECT * FROM ")
//				         .append(" (SELECT * FROM TBLITEM WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE YEAR = ? AND MEASUREID=?) ) ITEM ")
//				         .append(" LEFT JOIN ")
//				         .append(" (SELECT MEASUREID MID,CODE CD,STRDATE,ACTUAL,ROUND(ACCUM,3) ACCUM,ROUND(AVERAGE,3) AVERAGE FROM TBLITEMACTUAL WHERE STRDATE>=? AND STRDATE <=?) ACT ")
//				         .append(" ON ITEM.CODE=ACT.CD AND ITEM.MEASUREID = ACT.MID ORDER BY MEASUREID, STRDATE, CODE");

				//-------------------------------------------------------------------------------------------------------------------------------------------
				// 일부 항목만 입력된 경우 처리가 안되어 수정, 2008.05.20 PHG.
				//
				// and 이렇게 SQL 코딩하면 가독성이 뛰어나지 않나???
				//-------------------------------------------------------------------------------------------------------------------------------------------
				sbItemAct.append(" SELECT a.ym strdate, a.mcid measureid, a.frequency, a.code, a.itemname, a.itementry, a.itemfixed, b.actual                   ");
				sbItemAct.append(" FROM   (                                                                                                                     ");
				sbItemAct.append("         SELECT a.year||c.mm  ym, a.id  mcid, a.frequency, b.code, b.itemname, b.itementry, b.itemfixed                       ");
				sbItemAct.append("         FROM   tblmeasuredefine a, tblitem b,                                                                                ");
				sbItemAct.append("                 (                                                                                                            ");
				sbItemAct.append("                 select '년'   freq, ltrim(to_char(rownum*12, '00')) mm from tblmeasuredefine where rownum  = 1   union all   ");
				sbItemAct.append("                 select '반기' freq, ltrim(to_char(rownum*6 , '00')) mm from tblmeasuredefine where rownum <= 2   union all   ");
				sbItemAct.append("                 select '분기' freq, ltrim(to_char(rownum*3 , '00')) mm from tblmeasuredefine where rownum <= 4   union all   ");
				sbItemAct.append("                 select '월'   freq, ltrim(to_char(rownum*1 , '00')) mm from tblmeasuredefine where rownum <= 12              ");
				sbItemAct.append("                 ) c                                                                                                          ");
				sbItemAct.append("         WHERE  a.id        = b.measureid                                                                                     ");
				sbItemAct.append("         AND    a.frequency = c.freq                                                                                          ");
				sbItemAct.append("         AND    a.year      = ?                                                                                               ");
				sbItemAct.append("         AND    a.measureid = ?                                                                                               ");
				sbItemAct.append("         ) a,                                                                                                                 ");
				sbItemAct.append("         tblitemactual b                                                                                                      ");
				sbItemAct.append(" where  a.ym   = substr(b.strdate(+),1,6)                                                                                     ");
				sbItemAct.append(" and    a.mcid = b.measureid(+)                                                                                               ");
				sbItemAct.append(" and    a.code = b.code     (+)                                                                                               ");
				sbItemAct.append(" and    a.ym  >= ?                                                                                                            ");
				sbItemAct.append(" and    a.ym  <= ?                                                                                                            ");
				sbItemAct.append(" order by a.mcid, a.ym, a.code                                                                                                ");

				Object[] pmItem = {year, contentId,year+month1, year+month2};

				rs = dbobject.executePreparedQuery(sbItemAct.toString(),pmItem);

				DataSet dsItemAct = new DataSet();
				dsItemAct.load(rs);

				request.setAttribute("dsItemAct", dsItemAct);

				if (groupId.equals("1")){userId = "%";} // 관리자 일 경우 모든성과식적 표시  2008년 10월 27일 배광진씨요청

				sb.append(" SELECT * FROM ")
				 .append(" (SELECT A.YEAR AYEAR,A.MEASUREID AMID FROM TBLAUTHORITY A WHERE A.USERID like ? AND YEAR=? ")
		         .append(" UNION ")
		         .append(" SELECT D.YEAR AYEAR,D.ID AMID  FROM TBLMEASUREDEFINE D WHERE D.UPDATEID like ? AND YEAR=?) AUT ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT MEA.*, CASE WHEN MEA.FREQUENCY ='년' THEN CAL1.YM WHEN MEA.FREQUENCY='반기' THEN CAL2.YM ")
				 .append("  WHEN MEA.FREQUENCY='분기' THEN CAL3.YM WHEN MEA.FREQUENCY ='월' THEN CAL4.YM END YM FROM")
		         .append("  (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT, ")
		         .append("  C.NAME MNAME,D.FREQUENCY,T.YEAR MTYEAR,D.MEASUREMENT,D.MEASUREID MSID,C.MEASCHAR,D.ID DID,D.ETLKEY, D.EQUATION  ")
		         .append(" 	 FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND MEASUREMENT='계량' AND D.MEASUREID=? ) MEA ")
		         .append("   LEFT JOIN ")
		         .append("  (SELECT D.ID, C.YM, D.FREQUENCY ")
		         .append("   FROM (SELECT max(YM) YM FROM TZ_CALENDAR WHERE YEAR=? AND MM='12' GROUP BY YM) C, ")
		         .append("   TBLMEASUREDEFINE D WHERE D.FREQUENCY='년' AND D.YEAR=? AND MEASUREMENT='계량' AND MEASUREID=?) CAL1 ")
		         .append("   ON MEA.DID = CAL1.ID AND MEA.FREQUENCY = CAL1.FREQUENCY ")
		         .append("   LEFT JOIN ")
		         .append("  (SELECT D.ID, C.YM, D.FREQUENCY ")
		         .append("   FROM (SELECT max(YM) YM FROM TZ_CALENDAR WHERE YEAR=? AND MM in ('06','12') GROUP BY YM) C, ")
		         .append("   TBLMEASUREDEFINE D WHERE D.FREQUENCY='반기' AND D.YEAR=? AND MEASUREMENT='계량' AND MEASUREID=?) CAL2 ")
		         .append("   ON MEA.DID = CAL2.ID AND MEA.FREQUENCY = CAL2.FREQUENCY ")
		         .append("   LEFT JOIN ")
		         .append("  (SELECT D.ID, C.YM, D.FREQUENCY ")
		         .append("   FROM (SELECT max(YM) YM FROM TZ_CALENDAR WHERE YEAR=? AND MM in ('03','06','09','12') GROUP BY YM) C, ")
		         .append("   TBLMEASUREDEFINE D WHERE D.FREQUENCY='분기' AND D.YEAR=? AND MEASUREMENT='계량' AND MEASUREID=?) CAL3 ")
		         .append("   ON MEA.DID = CAL3.ID AND MEA.FREQUENCY = CAL3.FREQUENCY ")
		         .append("   LEFT JOIN ")
		         .append("  (SELECT D.ID, C.YM, D.FREQUENCY ")
		         .append("   FROM (SELECT max(YM) YM FROM TZ_CALENDAR WHERE YEAR=? GROUP BY YM) C, ")
		         .append("   TBLMEASUREDEFINE D WHERE D.FREQUENCY='월' AND D.YEAR=? AND MEASUREMENT='계량' AND MEASUREID=?) CAL4 ")
		         .append("   ON MEA.DID = CAL4.ID AND MEA.FREQUENCY = CAL4.FREQUENCY ")
		         .append("  ) MEA ON AUT.AMID=MEA.MCID AND AUT.AYEAR=MTYEAR ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
		         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
		         .append(" ON MEA.MPID=OBJ.OID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
		         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
		         .append(" ON OBJ.OPID=PST.PID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
		         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
		         .append(" ON PST.PPID=BSC.BID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME ")
		         .append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? ) SBU ")
		         .append(" ON BSC.BPID=SBU.SID ")
		         .append(" LEFT JOIN ")
		         .append("(SELECT ROUND(D.ACTUAL,3) ACTUAL,D.PLANNED,D.PLANNEDBASE,D.BASE,D.BASELIMIT,D.LIMIT,FILEPATH,FILENAME,D.MEASUREID,ROUND(S.SCORE,3) SCORE,S.GRADE,S.GRADE_SCORE,S.STRDATE ")
		         .append(" FROM TBLMEASUREDETAIL D, TBLMEASURESCORE S ")
		         .append(" WHERE D.MEASUREID=S.MEASUREID AND D.STRDATE=S.STRDATE ) DET ")
		         .append(" ON MEA.MCID=DET.MEASUREID AND MEA.YM = substr(DET.STRDATE, 0, 6) ")
		         .append(" WHERE MID IS NOT NULL AND YM>='"+year+month1+"' AND YM<='"+year+month2+"'  ")
		         .append(" ORDER BY YM, SID, BID");
				//System.out.println(sb.toString());
				params = new Object[] {userId,year,userId,year, year,contentId, year,year,contentId,year,year,contentId,year,year,contentId,year,year,contentId, year,year,year,year};
			} else {
				String frq = "'월'";

				if ( (new Integer(month1).intValue()==3) || (new Integer(month1).intValue()==9)) {
					frq = frq+",'분기'";
				} else if ((new Integer(month1).intValue()==6) ) {
					frq = frq+",'분기','반기'";
				} else if (new Integer(month1).intValue()==12) {
					frq = frq+",'분기','반기','년'";
				}
				System.out.println("frq:"+frq+"/"+frq.indexOf("년"));
				if ( (new Integer(month2).intValue()==3) || (new Integer(month2).intValue()==9) && frq.indexOf("분기")==-1) {
					frq = frq+",'분기'";
				} else if ((new Integer(month2).intValue()==6) && frq.indexOf("반기")==-1) {
					frq = frq+",'분기','반기'";
				} else if (new Integer(month2).intValue()==12 && frq.indexOf("년")==-1) {
					frq = frq+",'분기','반기','년'";
				}
				System.out.println("groupId  2:" + groupId);
				if (groupId.equals("1")){
					//관리자 일 경우 모든성과실적 표시  2008년 10월 27일 배광진씨요청으로 수정


					sb.append(" SELECT DISTINCT MNAME, FREQUENCY, MSID, MEASCHAR FROM ")
			         .append(" (SELECT A.YEAR AYEAR,A.MEASUREID AMID FROM TBLAUTHORITY A WHERE  YEAR=? ")
			         .append(" UNION ")
			         .append(" SELECT D.YEAR AYEAR,D.ID AMID  FROM TBLMEASUREDEFINE D WHERE  YEAR=?) AUT ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,T.YEAR MTYEAR,D.MEASUREMENT,D.MEASUREID MSID,C.MEASCHAR  ")
			         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND MEASUREMENT='계량'  AND D.FREQUENCY IN ("+frq+") ) MEA ")
			         .append(" ON AUT.AMID=MEA.MCID AND AUT.AYEAR=MTYEAR ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
			         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
			         .append(" ON MEA.MPID=OBJ.OID ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
			         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
			         .append(" ON OBJ.OPID=PST.PID ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
			         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
			         .append(" ON PST.PPID=BSC.BID ")
			         .append(" LEFT JOIN ")
			         .append("(SELECT ROUND(D.ACTUAL,3) ACTUAL,D.PLANNED,D.PLANNEDBASE,D.BASE,D.BASELIMIT,D.LIMIT,FILEPATH,FILENAME,D.MEASUREID,ROUND(S.SCORE,3) SCORE,S.GRADE,S.GRADE_SCORE FROM TBLMEASUREDETAIL D, TBLMEASURESCORE S ")
			         .append(" WHERE D.MEASUREID=S.MEASUREID AND SUBSTR(D.STRDATE,1,6) = SUBSTR(S.STRDATE,1,6) ) DET ")
			         .append(" ON AUT.AMID=DET.MEASUREID ")
			         .append(" WHERE MID IS NOT NULL ORDER BY MNAME");

					params = new Object[] {year,year, year,year,year,year};
				} else { //관리자가 아닌경우 로그인시
					sb.append(" SELECT DISTINCT MNAME, FREQUENCY, MSID, MEASCHAR FROM ")
			         .append(" (SELECT A.YEAR AYEAR,A.MEASUREID AMID FROM TBLAUTHORITY A WHERE A.USERID like ? AND YEAR=? ")
			         .append(" UNION ")
			         .append(" SELECT D.YEAR AYEAR,D.ID AMID  FROM TBLMEASUREDEFINE D WHERE D.UPDATEID  like ? AND YEAR=?) AUT ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,T.YEAR MTYEAR,D.MEASUREMENT,D.MEASUREID MSID,C.MEASCHAR  ")
			         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND MEASUREMENT='계량'  AND D.FREQUENCY IN ("+frq+") ) MEA ")
			         .append(" ON AUT.AMID=MEA.MCID AND AUT.AYEAR=MTYEAR ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
			         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
			         .append(" ON MEA.MPID=OBJ.OID ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
			         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
			         .append(" ON OBJ.OPID=PST.PID ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
			         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
			         .append(" ON PST.PPID=BSC.BID ")
			         .append(" LEFT JOIN ")
			         .append("(SELECT ROUND(D.ACTUAL,3) ACTUAL,D.PLANNED,D.PLANNEDBASE,D.BASE,D.BASELIMIT,D.LIMIT,FILEPATH,FILENAME,D.MEASUREID,ROUND(S.SCORE,3) SCORE,S.GRADE,S.GRADE_SCORE FROM TBLMEASUREDETAIL D, TBLMEASURESCORE S ")
			         .append(" WHERE D.MEASUREID=S.MEASUREID AND SUBSTR(D.STRDATE,1,6) = SUBSTR(S.STRDATE,1,6) ) DET ")
			         .append(" ON AUT.AMID=DET.MEASUREID ")
			         .append(" WHERE MID IS NOT NULL ORDER BY MNAME");

					params = new Object[] {userId,year,userId,year, year,year,year,year};
				}
			}

			rs = dbobject.executePreparedQuery(sb.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);
			System.out.println(sb);
			request.setAttribute("ds", ds);
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
}