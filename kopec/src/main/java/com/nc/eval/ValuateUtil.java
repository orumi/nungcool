package com.nc.eval;

import java.io.File;



import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.actual.MeasureDetail;
import com.nc.cool.AppConfigUtil;
import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.Common_Data;
import com.nc.util.CoolFile;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.SmartUpload;
import com.nc.util.Util;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.ByUserIdFileRenamePolicy;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.nc.util.ServerStatic;


public class ValuateUtil {




	public void setMeasure(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("DataSetddddddd : ");
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String schDate = request.getParameter("schDate");
			String year    = schDate.substring(0,4);
			String month   = schDate.substring(4,6);
			String bscId   = request.getParameter("bscId");

			int groupId = new Integer((String)request.getSession().getAttribute("groupId")).intValue();

			String userId = (String)request.getSession().getAttribute("userId");
			String frq = getFrequecny(new Integer(month).intValue());
			if (groupId==1) userId = "%";
			System.out.println("userid:    ===>>   "+userId);

			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			sb.append(" SELECT * FROM    \n")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME   \n")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? AND T.ID=? ) BSC   \n")
	         .append(" LEFT JOIN   \n")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME    \n")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST   \n")
	         .append(" ON BSC.BID=PST.PPID   \n")
	         .append(" LEFT JOIN   \n")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME    \n")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ   \n")
	         .append(" ON PST.PID=OBJ.OPID   \n")
	         .append(" LEFT JOIN   \n")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,D.MEASUREMENT    \n")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.FREQUENCY IN ("+frq+") \n")
	         .append(" AND  D.ID   IN (SELECT ID MCID   FROM TBLMEASUREDEFINE WHERE YEAR = ? AND UPDATEID LIKE ?         \n")
	         .append("           UNION SELECT MEASUREID FROM TBLAUTHORITY     WHERE YEAR = ? AND USERID   LIKE ? )) MEA  \n")
	         .append(" ON OBJ.OID=MEA.MPID   \n")
	         .append(" LEFT JOIN    \n")
	         .append(" (SELECT MEASUREID,EFFECTIVEDATE,PLANNED,DETAIL,FILEPATH,FILENAME,PCONFIRM,ACONFIRM,FILEPATH_PLAN,FILENAME_PLAN FROM TBLEVALMEASUREDETAIL WHERE EFFECTIVEDATE=?) DET  \n")
	         .append(" ON MEA.MCID=DET.MEASUREID   \n")
	         .append(" WHERE MEASUREMENT='비계량' AND MID IS NOT NULL   \n")
	         .append(" ORDER BY BRANK,BID,PRANK,PID,ORANK,OID,MRANK  \n");

	         params = new Object[] {year,bscId,year,year,year,year,userId,year,userId, schDate};

	         System.out.println("sb.toString() List ====="+sb.toString());

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
		try {
			Common_Data cd = new Common_Data();

			ServletConfig config = (ServletConfig)request.getAttribute("config");
			String type = request.getContentType()!=null?request.getContentType():"";
			if (type.indexOf(";")>0) {
				int ik = type.indexOf(";");
				type = type.substring(0,ik);
			}

			if ("multipart/form-data".equals(type)) {
			    int sizeLimit = 10 * 1024 * 1024; // 10M, 파일 사이즈 제한, 제한 사이즈 초과시 exception발생.
			    String UPLOADROOT = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"actual"+File.separator+"measurement"; // 경로 지정(절대 경로 | ROOT를 기준으로 한 상대경로)
			    String UPLOADPATH = UPLOADROOT + File.separator;
			    String PYSICALPATH = File.separator+"actual"+File.separator+"measurement"+File.separator;

				File upfolder = new File(UPLOADROOT);

				if(!upfolder.isDirectory()){upfolder.mkdir();}

				//MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit,"EUC-KR", new DefaultFileRenamePolicy()); // 이부분에서 upload가 됨.
				MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit,"EUC-KR", new ByUserIdFileRenamePolicy());      // 서버 한글 깨짐 ...


				String tag     = cd.ReplaceCode(multi.getParameter("tag"));
				String schDate = cd.ReplaceCode(multi.getParameter("schDate"));
				String mid     = cd.ReplaceCode(multi.getParameter("contentId"));	// 지표정의서 ID


				if ((schDate==null)||(mid==null)) return;

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);

				dbobject = new DBObject(conn.getConnection());

				String year  = schDate.substring(0,4);
				String month = schDate.substring(4,6);
				System.out.println("schDate22222   ===>>   "+schDate);
				if ("U".equals(tag)){
					ArrayList fileList = new ArrayList();
					ArrayList originalFilename = new ArrayList();
					Enumeration filenames = multi.getFileNames();

					while(filenames.hasMoreElements())   {
						String formName = (String)filenames.nextElement();
						fileList.add(multi.getFilesystemName(formName));
					    originalFilename.add(cd.ReplaceCode1(multi.getOriginalFileName(formName)));
					}

					String fileName = (String)fileList.get(0);
					fileName = cd.ReplaceCode1(fileName);             //String 에서 ' 를 제가 하는 함수
					String originalFile = (String)originalFilename.get(0);


					String actual = (cd.ReplaceCode(multi.getParameter("actual")));
					actual = actual.replaceAll("<br>","\n");
					//System.out.println("con:"+actual);
					//String filename = myfile.getFileName();
					//String filetype = myfile.getFileExt();
					//String filesize = Long.toString(myfile.getSize());
					//String savepath = File.separator+"actual"+File.separator+"measurement"+File.separator;
					//String new_filename = "";
					//filename = cd.ReplaceCode1(filename);
					//System.out.println("확장자를뺀파일 이름 : "+filename);


					String pysicalPath = PYSICALPATH + fileName;
					if("WINDOWS".equals(ServerStatic.SERVER_OS)){
						pysicalPath = pysicalPath.replace("\\", "\\\\");
					}


					if (!("".equals(fileName))) {
						int pos = 0;

						if((pos=fileName.indexOf(".")) != -1){
							String left  = fileName.substring(0, pos);
						  	String right = fileName.substring(pos, fileName.length());
						}
						// if isExit File delete file;;;

						String strU = "UPDATE TBLEVALMEASUREDETAIL SET DETAIL=?,ACONFIRM=0,FILEPATH=?,FILENAME=? WHERE MEASUREID=? AND EFFECTIVEDATE=?";
						Object[] pmU = {actual,pysicalPath,originalFile,mid,schDate};

						String strI = "INSERT INTO TBLEVALMEASUREDETAIL (MEASUREID,EFFECTIVEDATE,DETAIL,ACONFIRM,FILEPATH,FILENAME) VALUES (?,?,?,0,?,?)";
						Object[] pmI = {mid,schDate,actual,pysicalPath,originalFile};

						if (dbobject.executePreparedUpdate(strU,pmU)<1){
							dbobject.executePreparedUpdate(strI,pmI);
						}
					} else {

						String strU = "UPDATE TBLEVALMEASUREDETAIL SET DETAIL=?,ACONFIRM=0 WHERE MEASUREID=? AND EFFECTIVEDATE=?";
						Object[] pmU = {actual,mid,schDate};

						String strI = "INSERT INTO TBLEVALMEASUREDETAIL (MEASUREID,EFFECTIVEDATE,DETAIL,ACONFIRM) VALUES (?,?,?,0)";
						Object[] pmI = {mid,schDate,actual};

						if (dbobject.executePreparedUpdate(strU,pmU)<1){
							dbobject.executePreparedUpdate(strI,pmI);
						}
					}
				} else if ("D".equals(tag) ) {

					String strD = "DELETE FROM TBLEVALMEASUREDETAIL WHERE MEASUREID=? AND EFFECTIVEDATE=?";
					Object[] pmD = {mid,schDate};

					dbobject.executePreparedUpdate(strD,pmD);

				} else if ("T".equals(tag)){     // save tempo
					//String actual = Util.getEUCKR(cd.ReplaceCode(smart.getRequest().getParameter("actual")));
					String actual = (cd.ReplaceCode(multi.getParameter("actual")));
					actual = actual.replaceAll("<br>","\n");

					ArrayList fileList = new ArrayList();
					ArrayList originalFilename = new ArrayList();
					Enumeration filenames = multi.getFileNames();

					while(filenames.hasMoreElements())   {
						String formName = (String)filenames.nextElement();
						fileList.add(multi.getFilesystemName(formName));
					    originalFilename.add(cd.ReplaceCode1(multi.getOriginalFileName(formName)));
					}

					String fileName = (String)fileList.get(0);
					fileName = cd.ReplaceCode1(fileName);             //String 에서 ' 를 제가 하는 함수
					String originalFile = (String)originalFilename.get(0);

					/*
					CoolFile myfile = smart.getFiles().getFile(0);
					String filename = myfile.getFileName();
					String filetype = myfile.getFileExt();
					String filesize = Long.toString(myfile.getSize());
					String savepath = File.separator+"actual"+File.separator+"measurement"+File.separator;
					String new_filename = "";*/

					if (!("".equals(fileName))) {
						int pos = 0;

						if((pos=fileName.indexOf(".")) != -1){
							String left = fileName.substring(0, pos);
							String right = fileName.substring(pos, fileName.length());
						}

						String pysicalPath = PYSICALPATH + fileName;
						if("WINDOWS".equals(ServerStatic.SERVER_OS)){
							pysicalPath = pysicalPath.replace("\\", "\\\\");
						}


						String strU = "UPDATE TBLEVALMEASUREDETAIL SET DETAIL=?,ACONFIRM=0,FILEPATH=?,FILENAME=? WHERE MEASUREID=? AND EFFECTIVEDATE=?";
						Object[] pmU = {actual,pysicalPath,originalFile,mid,schDate};

						String strI = "INSERT INTO TBLEVALMEASUREDETAIL (MEASUREID,EFFECTIVEDATE,DETAIL,ACONFIRM,FILEPATH,FILENAME) VALUES (?,?,?,0,?,?)";
						Object[] pmI = {mid,schDate,actual,pysicalPath,originalFile};

						if (dbobject.executePreparedUpdate(strU,pmU)<1){
							dbobject.executePreparedUpdate(strI,pmI);
						}
					} else {
						String strU = "UPDATE TBLEVALMEASUREDETAIL SET DETAIL=?,ACONFIRM=0WHERE MEASUREID=? AND EFFECTIVEDATE=?";
						Object[] pmU = {actual,mid,schDate};

						String strI = "INSERT INTO TBLEVALMEASUREDETAIL (MEASUREID,EFFECTIVEDATE,DETAIL,ACONFIRM) VALUES (?,?,?,0)";
						Object[] pmI = {mid,schDate,actual};

						if (dbobject.executePreparedUpdate(strU,pmU)<1){
							dbobject.executePreparedUpdate(strI,pmI);
						}
					}
				} else if ("P".equals(tag)){      // save planned
					String planned = (cd.ReplaceCode(multi.getParameter("planned")));
					planned = planned.replaceAll("<br>","\n");

					String strU = "UPDATE TBLEVALMEASUREDETAIL SET PLANNED=?,PCONFIRM=1 WHERE MEASUREID=? AND EFFECTIVEDATE=?";
					Object[] pmU = {planned,mid,schDate};

					String strI = "INSERT INTO TBLEVALMEASUREDETAIL (MEASUREID,EFFECTIVEDATE,PLANNED,PCONFIRM) VALUES (?,?,?,1)";
					Object[] pmI = {mid,schDate,planned};

					if (dbobject.executePreparedUpdate(strU,pmU)<1){
						dbobject.executePreparedUpdate(strI,pmI);
					}
				} else if ("RP".equals(tag)){     // reset planned
					String strU = "UPDATE TBLEVALMEASUREDETAIL SET PCONFIRM=0 WHERE MEASUREID=? AND EFFECTIVEDATE=?";
					Object[] pmU = {mid,schDate};

					dbobject.executePreparedUpdate(strU,pmU);
				} else if ("RA".equals(tag)){     // reset actual
					String strU = "UPDATE TBLEVALMEASUREDETAIL SET ACONFIRM=0, DETAIL=NULL, FILEPATH=NULL, FILENAME=NULL WHERE MEASUREID=? AND EFFECTIVEDATE=?";
					Object[] pmU = {mid,schDate};

					dbobject.executePreparedUpdate(strU,pmU);
				} else if ("E".equals(tag)){	//save estimate
					String estimate = (cd.ReplaceCode(multi.getParameter("estimate")));
					estimate = estimate.replaceAll("<br>","\n");
					String estigrade = cd.ReplaceCode(multi.getParameter("rdoEst"));

					String strU = "UPDATE TBLEVALMEASUREDETAIL SET ESTIMATE=?,PCONFIRM=1,ESTIGRADE=? WHERE MEASUREID=? AND EFFECTIVEDATE=?";
					Object[] pmU = {estimate,estigrade,mid,schDate};

					String strI = "INSERT INTO TBLEVALMEASUREDETAIL (ESTIMATE,EFFECTIVEDATE,PLANNED,PCONFIRM,ESTIGRADE) VALUES (?,?,?,1,?)";
					Object[] pmI = {mid,schDate,estimate,estigrade};

					if (dbobject.executePreparedUpdate(strU,pmU)<1){
						dbobject.executePreparedUpdate(strI,pmI);
					}

					if(!estigrade.equals("")){
						String strC = "SELECT ESTIRSLT FROM TBLMEASUREDEFINE WHERE ID=?";
						Object[] pmC = {mid};
						if (rs!=null){rs.close(); rs=null;}
						rs = dbobject.executePreparedQuery(strC,pmC);
						String estirslt="";
						while(rs.next()){
							estirslt = rs.getString("ESTIRSLT");
						}

						if(estirslt.equals("Y")){

							String strEqu = "SELECT EQUATION,WEIGHT,TREND,FREQUENCY,MEASUREID FROM TBLMEASUREDEFINE WHERE ID=?";
							Object[] pmEqu = {mid};

							if (rs!=null){rs.close(); rs=null;}

							rs = dbobject.executePreparedQuery(strEqu,pmEqu);
							String equ = "";
							String weight = null;
							String trend = null;
							String frequency = null;
							String measureid = "";
							while(rs.next()){
								equ = rs.getString("EQUATION");
								weight = rs.getString("WEIGHT");
								trend = rs.getString("TREND");
								frequency = rs.getString("FREQUENCY");
								measureid = rs.getString("MEASUREID");
							}

							double actual=0;
							double score=0;
							if(estigrade.equals("S")){
				   				score = ServerStatic.UPPER;
				   				actual = ServerStatic.UPPER;
				   			}else if(estigrade.equals("A")){
				   				score = ServerStatic.HIGH;
				   				actual = ServerStatic.HIGH;
				   			}else if(estigrade.equals("B")){
				   				score = ServerStatic.LOW;
				   				actual = ServerStatic.LOW;
				   			}else if(estigrade.equals("C")){
				   				score = ServerStatic.LOWER;
				   				actual = ServerStatic.LOWER;
				   			}else if(estigrade.equals("D")){
				   				score = ServerStatic.LOWST;
				   				actual = ServerStatic.LOWST;
				   			}else {
				   				score = 0;
				   				actual = 0;
				   			}

							//System.out.println("Save:"+i+"/"+mIds[i]+"/"+measureid+"/"+actual+"/"+score+"/"+grade);

							MeasureDetail measuredetail = getMeasureDetail (dbobject,mid,year+month);
							measuredetail.actual = actual;
							measuredetail.strDate = Util.getLastMonth(year+month);
							measuredetail.weight = new Float(weight).floatValue();
							//measuredetail.id = new Integer(mIds[i]).intValue();
							measuredetail.measureId = new Integer(mid).intValue();
							measuredetail.trend = (trend==null)?"상향":trend;
							measuredetail.frequency = frequency;
							measuredetail.score = score;
							measuredetail.grade = estigrade;
							//System.out.println("chek:"+measuredetail.measureId+"/"+measuredetail.strDate);
							updateMeasureDetail(dbobject,measuredetail);
						}
					}
				}


				StringBuffer sbMea = new StringBuffer();
				sbMea.append(" SELECT * FROM ")
					.append(" (SELECT D.ID, C.NAME,D.EQUATION,D.TREND,D.UPDATEID FROM TBLMEASUREDEFINE D, TBLMEASURE C WHERE D.MEASUREID=C.ID AND D.ID=?) DEF ")
					.append(" LEFT JOIN  ")
					.append(" (SELECT MEASUREID,EFFECTIVEDATE,PLANNED,DETAIL,FILEPATH,FILENAME,PCONFIRM,ACONFIRM,ESTIMATE,ESTIGRADE FROM TBLEVALMEASUREDETAIL ) ACT ")
					.append(" ON DEF.ID=ACT.MEASUREID AND ACT.EFFECTIVEDATE=? ");

				Object[] pmMea = {mid,schDate};

				if (rs!=null){rs.close(); rs=null;}
				rs = dbobject.executePreparedQuery(sbMea.toString(),pmMea);

				DataSet dsMea = new DataSet();
				dsMea.load(rs);

				request.setAttribute("dsMea", dsMea);

				request.setAttribute("mid",mid);
				request.setAttribute("schDate",schDate);

				conn.commit();
			}
		} catch (IOException ie){
			System.out.print(ie);
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
			String s = "SELECT * FROM TBLMEASUREDETAIL WHERE MEASUREID=? AND SUBSTR(STRDATE,0,6)=?";
			Object[] p = {mid,date.substring(0,6)};

			MeasureDetail detail = new MeasureDetail();
			rs = dbobject.executePreparedQuery(s,p);
			while(rs.next()){
				detail.id = rs.getInt("ID");
				detail.measureId = rs.getInt("MEASUREID");
				detail.strDate = rs.getString("STRDATE");
				detail.actual = rs.getDouble("ACTUAL");
				detail.weight = rs.getFloat("WEIGHT");
				detail.planned = rs.getDouble("PLANNED");
				detail.plannedbase = rs.getDouble("PLANNEDBASE");
				detail.base = rs.getDouble("BASE");
				detail.baselimit = rs.getDouble("BASELIMIT");
				detail.limit = rs.getDouble("LIMIT");
				detail.filePath = rs.getString("FILEPATH");
				detail.fileName = rs.getString("FILENAME");
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


				String str = "UPDATE TBLMEASUREDETAIL SET ACTUAL=NULL,FILEPATH=NULL,FILENAME=NULL WHERE ID=? ";
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
//			double score = measuredetail.getScoreVariable();
			double grade_score = measuredetail.score * measuredetail.weight / 100;

			if (measuredetail.id==0){
				String str = "INSERT INTO TBLMEASUREDETAIL (ID,MEASUREID,STRDATE,ACTUAL,WEIGHT,PLANNED,PLANNEDBASE,BASE,BASELIMIT,LIMIT,FILEPATH,FILENAME,GRADE_SCORE) VALUES (?,?,?,?,?, ?,?,?,?,?, ?,?,?)";
				Object[] pm = new Object[13];

				measuredetail.id = dbobject.getNextId("TBLMEASUREDETAIL");
				pm[0] = new Integer(measuredetail.id);
				pm[1] = new Integer(measuredetail.measureId);
				pm[2] = measuredetail.strDate;
				pm[3] = new Double(measuredetail.actual);
				pm[4] = new Float(measuredetail.weight);
				pm[5] = new Double(measuredetail.planned);
				pm[6] = new Double(measuredetail.plannedbase);
				pm[7] = new Double(measuredetail.base);
				pm[8] = new Double(measuredetail.baselimit);
				pm[9] = new Double(measuredetail.limit);
				pm[10] = measuredetail.grade;
				pm[11] = measuredetail.fileName;
				pm[12] = new Double(grade_score);

				reval=dbobject.executePreparedUpdate(str,pm);
			} else {
				String str = "UPDATE TBLMEASUREDETAIL SET ACTUAL=?,WEIGHT=?,PLANNED=?,PLANNEDBASE=?,BASE=?,BASELIMIT=?,LIMIT=?,FILEPATH=?,FILENAME=?,GRADE=?,GRADE_SCORE=? WHERE ID=? ";
				Object[] pm = new Object[12];
				pm[0] = new Double(measuredetail.actual);
				pm[1] = new Float(measuredetail.weight);
				pm[2] = new Double(measuredetail.planned);
				pm[3] = new Double(measuredetail.plannedbase);
				pm[4] = new Double(measuredetail.base);
				pm[5] = new Double(measuredetail.baselimit);
				pm[6] = new Double(measuredetail.limit);
				pm[7] = measuredetail.filePath;
				pm[8] = measuredetail.fileName;
				pm[9] = measuredetail.grade;
				pm[10] = new Double(grade_score);
				pm[11] = new Integer(measuredetail.id);

				reval=dbobject.executePreparedUpdate(str,pm);
			}

			// update measurescore;

			if (grade_score !=-1){
				String strU = "UPDATE TBLMEASURESCORE SET ACTUAL=?,WEIGHT=?,PLANNED=?,PLANNEDBASE=?,BASE=?,BASELIMIT=?,LIMIT=?,GRADE_SCORE=?,GRADE=?,SCORE=? WHERE MEASUREID=? AND STRDATE=?";
				Object[] pmU = new Object[12];
				pmU[0] = new Double(measuredetail.actual);
				pmU[1] = new Float(measuredetail.weight);
				pmU[2] = new Double(measuredetail.planned);
				pmU[3] = new Double(measuredetail.plannedbase);
				pmU[4] = new Double(measuredetail.base);
				pmU[5] = new Double(measuredetail.baselimit);
				pmU[6] = new Double(measuredetail.limit);
				pmU[7] = new Double(grade_score);
				pmU[8] = measuredetail.grade;
				pmU[9] = new Double(measuredetail.score);
				pmU[10] = new Integer(measuredetail.measureId);
				pmU[11] = null;

				String strI = "INSERT INTO TBLMEASURESCORE (MEASUREID,STRDATE,ACTUAL,WEIGHT,PLANNED,PLANNEDBASE,BASE,BASELIMIT,LIMIT,GRADE_SCORE,GRADE,SCORE) VALUES (?,?,?,?,?, ?,?,?,?,?, ?,?)";
				Object[] pmI = new Object[12];
				pmI[0] = pmU[10];
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

				ArrayList list = getMonths(dbobject,measuredetail);

				for (int i = 0; i < list.size(); i++) {
					pmU[11] = Util.getLastMonth((String)list.get(i));
					if (dbobject.executePreparedUpdate(strU,pmU)<1){
						pmI[1] = pmU[11];
						dbobject.executePreparedUpdate(strI,pmI);
					}
					//System.out.println("up(Score):"+measuredetail.grade+"/"+measuredetail.score);
				}
			}
			dbobject.getConnection().commit();
			return reval;
		} catch (SQLException e) {
			throw e;
		} finally {

		}
	}

	public ArrayList getMonths(DBObject dbobject,MeasureDetail measuredetail) throws SQLException {
		ResultSet rs = null;
		ArrayList list = new ArrayList();
		String year = measuredetail.strDate.substring(0,4);
		String month = measuredetail.strDate.substring(4,6);
		int m = new Integer(month).intValue();
		try {

			String str = "SELECT SCORE FROM TBLMEASURESCORE WHERE MEASUREID=? AND STRDATE=?";
			Object[] pm = {new Integer(measuredetail.measureId),null};
			if (measuredetail.frequency.equals("월")){
				list.add(year+month);
			} else if (measuredetail.frequency.equals("분기")){
				if (m==3){
					list.add(year+"01"); list.add(year+"02"); list.add(year+"03");
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
					list.add(year+"04"); list.add(year+"05"); list.add(year+"06");
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
					list.add(year+"07"); list.add(year+"08"); list.add(year+"09");
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
					list.add(year+"10"); list.add(year+"11"); list.add(year+"12");
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
					list.add(year+"01"); list.add(year+"02"); list.add(year+"03");list.add(year+"04"); list.add(year+"05"); list.add(year+"06");
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
					list.add(year+"07"); list.add(year+"08"); list.add(year+"09"); list.add(year+"10"); list.add(year+"11"); list.add(year+"12");
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
				list.add(year+"01"); list.add(year+"02"); list.add(year+"03");list.add(year+"04"); list.add(year+"05"); list.add(year+"06");
				list.add(year+"07"); list.add(year+"08"); list.add(year+"09");list.add(year+"10"); list.add(year+"11"); list.add(year+"12");

				int nYear = new Integer(year).intValue()+1;
				pm[1]=String.valueOf(nYear)+"12";
				rs = dbobject.executePreparedQuery(str,pm);
				double score=-1;
				while(rs.next()){
					score = rs.getDouble("SCORE");
				}
				if (score ==-1){
					list.add(String.valueOf(nYear)+"01"); list.add(String.valueOf(nYear)+"02"); list.add(String.valueOf(nYear)+"03"); list.add(String.valueOf(nYear)+"04"); list.add(String.valueOf(nYear)+"05");list.add(String.valueOf(nYear)+"06");
					list.add(String.valueOf(nYear)+"07"); list.add(String.valueOf(nYear)+"08"); list.add(String.valueOf(nYear)+"09"); list.add(String.valueOf(nYear)+"10"); list.add(String.valueOf(nYear)+"11");
				}
			}

			return list;
		} catch (SQLException e) {
			throw e;
		} finally {
			if (rs!=null) {rs.close(); rs=null;}
		}
	}





	public void setEvalDetail(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String year = request.getParameter("year");
			String month = request.getParameter("month");

			String mId = request.getParameter("mId");

			String userId = (String)request.getSession().getAttribute("userId");

			String frq = getFrequecny(new Integer(month).intValue());


			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM  ")
	         .append(" (SELECT D.ID,D.MEASUREID,D.WEIGHT,D.UNIT,D.FREQUENCY,D.MEASUREMENT,D.TREND,C.NAME FROM TBLMEASUREDEFINE D,TBLMEASURE C WHERE D.MEASUREID=C.ID AND D.ID=?) MEA ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT MEASUREID MID,PLANNED,DETAIL,FILEPATH,PCONFIRM,ACONFIRM FROM TBLEVALMEASUREDETAIL WHERE EFFECTIVEDATE=?) DTL ")
	         .append(" ON MEA.ID=DTL.MID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT * FROM TBLMEAEVALDETAIL WHERE EVALRID=? AND YEAR=? AND MONTH=?) EVAL ")
	         .append(" ON MEA.ID=EVAL.EVALID ");

			Object[] pm = {mId,year+month,userId,year,month};


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


	/////////////////////////////////////////////////////////////////////////////////////
	/*
	 *  new version kosep ;;
	 */

	public void setDivision(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year")!=null?request.getParameter("year"):null;
			if (year == null){
				//year = request.getAttribute("year")!= null?request.getAttribute("year").toString():Util.getPrevQty(null).substring(0,4);
				AppConfigUtil app = new AppConfigUtil();
				String showym = app.getShowYM()!= null?app.getShowYM():Util.getPrevQty(null);
				String qtr    = showym.substring(0,6);
				year   = qtr.substring(0,4);
			}
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
	public void setEvalGroup2(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String schDate = request.getParameter("schDate");
			String year = schDate.substring(0,4);
			System.out.println("year    ===>>   "+year);
			String month = schDate.substring(4,6);
			System.out.println("month    ===>>   "+month);

//평가 그룹 가져오기

			String userId = (String)request.getSession().getAttribute("userId");
			//userId = "admin";
			StringBuffer sbGrp = new StringBuffer();
			sbGrp.append("SELECT * FROM TBLMEAEVALGRP WHERE GRPID IN (SELECT GRPID FROM TBLMEAEVALR WHERE EVALRID=?) AND YEAR=? AND MONTH=?");
			Object[] params = {userId,year,month};

			System.out.println(sbGrp);

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sbGrp.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);
			request.setAttribute("dsGrp", ds);

//지표명 가져오기

			System.out.println("-----------------------------------------------------------------");
			StringBuffer strDetail = new StringBuffer();
			strDetail.append(" SELECT DISTINCT(MEASUREID),MNAME,GRPID,GRPNM FROM  ")
	         .append(" (SELECT GRPID,GRPNM,YEAR,MONTH FROM TBLMEAEVALGRP WHERE GRPID IN (SELECT GRPID FROM TBLMEAEVALR WHERE EVALRID=?)   ")
	         .append(" AND YEAR=? AND MONTH=? ) GRP  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT D.GRPID GID,D.EVALDEPTID,B.ID,B.NAME FROM TBLMEAEVALDEPT D, TBLBSC B ) DEP  ") //Tblbsc b 뒤에 지워줌 WHERE D.EVALDEPTID=B.ID
	         .append(" ON GRP.GRPID=DEP.GID   ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID,  ")
	         .append(" CASE WHEN (C.MEASCHAR='I') THEN '고유' ELSE '공통' END MKIND, C.MEASCHAR, D.MEASUREMENT ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND MEASUREMENT='비계량' ) MEA  ")
	         .append(" ON DEP.EVALDEPTID=MEA.MEASUREID   ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME   ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ  ")
	         .append(" ON MEA.MPID=OBJ.OID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME   ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST  ")
	         .append(" ON OBJ.OPID=PST.PID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME   ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC  ")
	         .append(" ON PST.PPID=BSC.BID  ")
	         //.append(" WHERE MID IS NOT NULL AND MEASCHAR='C' ");
	         .append(" WHERE MID IS NOT NULL  ");

			Object[] obj = {userId,year,month,year,year,year,year};
			if (rs!=null) {rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(strDetail.toString(),obj);

			DataSet dsDtl = new DataSet();
			dsDtl.load(rs);
			System.out.println("-"+strDetail.toString());
			System.out.println("-----------------------------------------------------------------");
			System.out.println("++"+dsDtl);
			request.setAttribute("dsDtl",dsDtl);
			System.out.println("-----------------------------------------------------------------");


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
			if ((appraiser==null)||(!"1".equals(appraiser))) return;

			//String qtr = Util.getPrevQty(null);

			//String year = request.getParameter("year")!=null?request.getParameter("year"):qtr.substring(0,4);
			String year  = request.getParameter("year")!=null?request.getParameter("year"):Util.getPrevQty(null).substring(0,4);
			String month = request.getParameter("month")!=null?request.getParameter("month"):Util.getPrevQty(null).substring(4,6);

			String userId = (String)request.getSession().getAttribute("userId");
			System.out.println("id"+userId);
			System.out.println("월"+month);
			System.out.println("년"+year);

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
	         .append(" AND YEAR=? AND MONTH=? ) GRP  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT D.GRPID GID,D.EVALDEPTID,B.ID,B.NAME FROM TBLMEAEVALDEPT D, TBLBSC B WHERE D.EVALDEPTID=B.ID) DEP  ")
	         .append(" ON GRP.GRPID=DEP.GID   ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID,  ")
	         .append(" CASE WHEN (C.MEASCHAR='I') THEN '고유' ELSE '공통' END MKIND, C.MEASCHAR, D.MEASUREMENT ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND MEASUREMENT='비계량' ) MEA  ")
	         .append(" ON DEP.EVALDEPTID=MEA.MEASUREID   ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME   ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ  ")
	         .append(" ON MEA.MPID=OBJ.OID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME   ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST  ")
	         .append(" ON OBJ.OPID=PST.PID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME   ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC  ")
	         .append(" ON PST.PPID=BSC.BID  ")
	         //.append(" WHERE MID IS NOT NULL AND MEASCHAR='C' ");
	         .append(" WHERE MID IS NOT NULL  ");

			Object[] obj = {userId,year,month,year,year,year,year};
			if (rs!=null) {rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(strDetail.toString(),obj);

			DataSet dsDtl = new DataSet();
			dsDtl.load(rs);

			request.setAttribute("dsDtl", dsDtl);
			request.setAttribute("month", month);
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	//플렉스용  비계량 년평가  처리 부분
	public void flexsetEvalMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			System.out.println("month   ===>   "+month);
			if (year==null || month==null) return;

			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			String grpId = request.getParameter("grpId");
			String measureId = request.getParameter("measureId");

			String userId = (String)request.getSession().getAttribute("userId");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			String[] grade=null;
			if ("I".equals(mode)){
				//System.out.println("I");
				String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
				String[] mids = aMCID.split("\\|");
				System.out.println(aMCID);
				String strU = "UPDATE TBLMEAEVALDETAIL SET EVALGRADE=?,EVALSCORE=?,MODIR=?,MODIDATE=SYSDATE,CONFIRM=1 WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=?";
				Object[] pmU = {null,null,userId,null,userId,year,month};

				String strI = "INSERT INTO TBLMEAEVALDETAIL (EVALID,EVALRID,YEAR,MONTH,EVALGRADE,EVALSCORE,REGIR,CONFIRM) VALUES (?,?,?,?,?,?,?,1)";
				Object[] pmI = {null,userId,year,month,null,null,userId};

				for (int i = 0; i < mids.length; i++) {
					if (!"".equals(mids[i])){
						//System.out.println("I1 : "+ i);
						String grades = request.getParameter("appraise");

						//System.out.println("I2 : "+ grades);
						grade = grades.split(",");

						String grd = grade[i-1];
						int scr = 0;
						if(grd.equals("S")){
							scr = 5;
						}else if(grd.equals("A")){
							scr = 4;
						}else if(grd.equals("B")){
							scr = 3;
						}else if(grd.equals("C")){
							scr = 2;
						}else if(grd.equals("D")){
							scr = 1;
						}
						//String scr = grade[1];
						System.out.println("등급 :   " + grd + "    점수 :   "+ scr);
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
			} else if ("E".equals(mode)){
				String strD = "DELETE FROM TBLMEAEVALDETAIL WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=?";
				Object[] objD = {null,userId,year,month};
				String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
				String[] mids = aMCID.split("\\|");

				for (int i = 0; i < mids.length; i++) {
					if (!"".equals(mids[i])){
						objD[0]=mids[i];
						dbobject.executePreparedUpdate(strD,objD);
					}
				}
			}
			System.out.println("list:"+grpId+"/"+measureId);
			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			sb.append(" SELECT * FROM ")
	         .append(" (SELECT GRPID,GRPNM,YEAR,MONTH FROM TBLMEAEVALGRP WHERE GRPID IN (SELECT GRPID FROM TBLMEAEVALR WHERE EVALRID=?)  ")
	         .append(" AND YEAR=? AND MONTH=? AND GRPID=?) GRP ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT D.GRPID GID,D.EVALDEPTID,B.ID,B.NAME FROM TBLMEAEVALDEPT D, TBLMEASURE B WHERE D.EVALDEPTID=B.ID AND ID=?) DEP ")
	         .append(" ON GRP.GRPID=DEP.GID  ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID, ")
	         .append(" CASE WHEN (C.MEASCHAR='I') THEN '고유' ELSE '공통' END MKIND,C.MEASCHAR  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.MEASUREMENT='비계량' ) MEA ")
	         .append(" ON DEP.EVALDEPTID=MEA.MEASUREID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
	         .append(" ON PST.PID=OBJ.OPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
	         .append(" ON BSC.BID=PST.PPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? ) SBU ")
	         .append(" ON BSC.BPID=SBU.SID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT EVALGRADE,EVALSCORE,EVALID FROM TBLMEAEVALDETAIL WHERE YEAR=? AND MONTH=? AND EVALRID=?) EVAL ")
	         .append(" ON MEA.MCID=EVALID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT MEASUREID AMID,FILEPATH,FILENAME, FILEPATH_PLAN, FILENAME_PLAN FROM TBLEVALMEASUREDETAIL WHERE EFFECTIVEDATE=?) ATT ")
	         .append(" ON MEA.MCID=ATT.AMID ")
	         .append(" ORDER BY SRANK,BRANK,BID ");

	         params = new Object[] {userId,year,month,grpId, measureId,year,year,year,year,year,year,month,userId,year+month};

			rs = dbobject.executePreparedQuery(sb.toString(),params);
			System.out.println("-----"+sb.toString());
			System.out.println("-----"+userId);
			System.out.println("-----"+year);
			System.out.println("-----"+month);
			System.out.println("-----"+grpId);
			System.out.println("-----"+measureId);

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
			//System.out.println(""+ds);
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
//원 jsp 비계량 년평가 처리 부분
	public void setEvalMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			System.out.println("month   ===>   "+month);
			if (year==null || month==null) return;

			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			String grpId = request.getParameter("grpId");
			String measureId = request.getParameter("measureId");

			String userId = (String)request.getSession().getAttribute("userId");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			String[] grade=null;
			if ("I".equals(mode)){
				System.out.println("I");
				String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
				String[] mids = aMCID.split("\\|");

				String strU = "UPDATE TBLMEAEVALDETAIL SET EVALGRADE=?,EVALSCORE=?,MODIR=?,MODIDATE=SYSDATE,CONFIRM=1 WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=?";
				Object[] pmU = {null,null,userId,null,userId,year,month};

				String strI = "INSERT INTO TBLMEAEVALDETAIL (EVALID,EVALRID,YEAR,MONTH,EVALGRADE,EVALSCORE,REGIR,CONFIRM) VALUES (?,?,?,?,?,?,?,1)";
				Object[] pmI = {null,userId,year,month,null,null,userId};
				System.out.println("I "+ aMCID);
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
						System.out.println("===="+grades);
					}
				}


			} else if ("D".equals(mode)){
				String strD = "DELETE FROM TBLMEAEVALDETAIL WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=?";
				Object[] objD = {null,userId,year,month};
				String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
				String[] mids = aMCID.split("\\|");

				for (int i = 0; i < mids.length; i++) {
					if (!"".equals(mids[i])){
						objD[0]=mids[i];
						dbobject.executePreparedUpdate(strD,objD);
					}
				}
			}
			System.out.println("list:"+grpId+"/"+measureId);
			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			sb.append(" SELECT * FROM ")
	         .append(" (SELECT GRPID,GRPNM,YEAR,MONTH FROM TBLMEAEVALGRP WHERE GRPID IN (SELECT GRPID FROM TBLMEAEVALR WHERE EVALRID=?)  ")
	         .append(" AND YEAR=? AND MONTH=? AND GRPID=?) GRP ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT D.GRPID GID,D.EVALDEPTID,B.ID,B.NAME FROM TBLMEAEVALDEPT D, TBLMEASURE B WHERE D.EVALDEPTID=B.ID AND ID=?) DEP ")
	         .append(" ON GRP.GRPID=DEP.GID  ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID, ")
	         .append(" CASE WHEN (C.MEASCHAR='I') THEN '고유' ELSE '공통' END MKIND,C.MEASCHAR  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.MEASUREMENT='비계량' ) MEA ")
	         .append(" ON DEP.EVALDEPTID=MEA.MEASUREID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
	         .append(" ON PST.PID=OBJ.OPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
	         .append(" ON BSC.BID=PST.PPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? ) SBU ")
	         .append(" ON BSC.BPID=SBU.SID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT EVALGRADE,EVALSCORE,EVALID FROM TBLMEAEVALDETAIL WHERE YEAR=? AND MONTH=? AND EVALRID=?) EVAL ")
	         .append(" ON MEA.MCID=EVALID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT MEASUREID AMID,FILEPATH,FILENAME, FILEPATH_PLAN, FILENAME_PLAN FROM TBLEVALMEASUREDETAIL WHERE EFFECTIVEDATE=?) ATT ")
	         .append(" ON MEA.MCID=ATT.AMID ")
	         .append(" ORDER BY SRANK,BRANK,BID ");

	         params = new Object[] {userId,year,month,grpId, measureId,year,year,year,year,year,year,month,userId,year+month};

			rs = dbobject.executePreparedQuery(sb.toString(),params);
			System.out.println("-----"+sb.toString());
			System.out.println("-----"+userId);
			System.out.println("-----"+year);
			System.out.println("-----"+month);
			System.out.println("-----"+grpId);
			System.out.println("-----"+measureId);

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
			System.out.println(""+ds);
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

	/**
	 * 비계량 지표평가(부서)2008
	 *
	 * @param request
	 * @param response
	 */
    public void setEvalMeasureOrg(HttpServletRequest request, HttpServletResponse response) {
        CoolConnection conn = null;
        DBObject dbobject = null;
        ResultSet rs = null;
        try {
               String year  = request.getParameter("year");
               String month = request.getParameter("month");
               if (year==null || month==null) return;

               String mode      = request.getParameter("mode")!=null?request.getParameter("mode"):"";
               String grpId     = request.getParameter("grpId");
               String measureId = request.getParameter("measureId");

               String userId = (String)request.getSession().getAttribute("userId");

               //System.out.println("setEvalMeasureOrg : ym " + year + month + " : " + grpId);
               int groupId = new Integer((String)request.getSession().getAttribute("groupId")).intValue();

               System.out.println("setEvalMeasureOrg : ym " + year + month + " , mcid " + measureId + ", User " + userId);

               conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
               conn.createStatement(false);

               dbobject = new DBObject(conn.getConnection());

               String[] grade=null;
               if ("I".equals(mode)){
                      String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
                      String[] mids = aMCID.split("\\|");

                      String strU  = "UPDATE TBLMEAEVALDETAIL SET EVALGRADE=?,EVALSCORE=?,MODIR=?,MODIDATE=SYSDATE,CONFIRM=1 WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=?";
                      Object[] pmU = {null,null,userId,null,userId,year,month};

                      // 중간평가인 경우
                      String strDM = "DELETE TBLMEAEVALDETAIL WHERE EVALID=? AND YEAR=? AND MONTH=?";
                      Object[] pmDM  = {null,year,month};

                      String strI = "INSERT INTO TBLMEAEVALDETAIL (EVALID,EVALRID,YEAR,MONTH,EVALGRADE,EVALSCORE,REGIR,CONFIRM) VALUES (?,?,?,?,?,?,?,1)";
                      Object[] pmI = {null,userId,year,month,null,null,userId};

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

                                         // 중간평가인 경우 : 부서장만 입력함...
                                         //if ("06".equals(month)){
                                                //pmDM[0]=mids[i];
                                                //dbobject.executePreparedUpdate(strDM,pmDM);
                                         //}

                                         pmI[0]=mids[i];
                                         pmI[4]=grd;
                                         pmI[5]=scr;
                                         dbobject.executePreparedUpdate(strI,pmI);
                                   }
                                   System.out.println("Meas : " + mids[i] + "Grade :" + grd);
                            }
                      }


               } else if ("D".equals(mode)){
                      String strD = "DELETE FROM TBLMEAEVALDETAIL WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=?";
                      Object[] objD = {null,userId,year,month};
                      String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
                      String[] mids = aMCID.split("\\|");

                      for (int i = 0; i < mids.length; i++) {
                            if (!"".equals(mids[i])){
                                   objD[0]=mids[i];
                                   dbobject.executePreparedUpdate(strD,objD);
                            }
                      }
               }

/*               if (groupId == 1) {
                   userId = "%";
               }  */
               //System.out.println("list:"+grpId+"/"+measureId);
               StringBuffer sb = new StringBuffer();
               Object[] params = null;

               sb.append(" SELECT   ")
               .append("         cid, ccid, clevel, crank, cname,   ")
               .append("         sid, scid, slevel, srank, sname,   ")
               .append("         bid, bcid, blevel, brank, bname,   ")
               .append("         mid, mcid, mlevel, mrank, mname,  mweight, ")
               .append("         measureid,  ")
               .append("         amid, filepath, filename, evalgrade, evalscore, evalid  ")
               .append(" FROM ")
               .append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ")
               .append("         from   tblhierarchy t,tblcompany c ")
               .append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =? ")
               .append("        ) com, ")
               .append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
               .append("         from   tblhierarchy t,tblsbu c ")
               .append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =? and t.contentid = ? ")
               .append("        ) sbu, ")
               .append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname ")
               .append("         from   tblhierarchy t,tblbsc c ")
               .append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =? ")
               .append("        ) bsc, ")
               .append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname ")
               .append("         from   tbltreescore t,tblpst c ")
               .append("         where  t.contentid=c.id  and t.treelevel=3 and t.year =? ")
               .append("        ) pst  , ")
               .append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname ")
               .append("         from   tbltreescore t,tblobjective c ")
               .append("         where  t.contentid=c.id  and t.treelevel=4 and t.year =? ")
               .append("        ) obj , ")
               .append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname, ")
               .append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey, ")
               .append("                d.unit       , ")
               .append("                d.planned,d.plannedbase, d.base, d.baselimit, d.limit ")
               .append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d ")
               .append("         where  t.contentid=d.id  and t.treelevel=5 and t.year =? and d.measureid=c.id ")
               .append("         and    d.measurement = '비계량' ")
               .append("         and    d.measureid = ? ")
               .append("        ) mea,  ")
               .append("        ( ")
               .append("         select  a.effectivedate, a.measureid  amid,  max(a.filepath) filepath, max(a.filename) filename ,  ")
               .append("                 max(b.evalgrade) evalgrade, max(b.evalscore) evalscore, max(b.evalid)  evalid  ")
               .append("         from   tblevalmeasuredetail a, tblmeaevaldetail b  ")
               .append("         where  a.effectivedate = b.year(+)||b.month(+) ")
               .append("         and    a.measureid     = b.evalid(+) ")
               .append("         and    a.effectivedate = ?    ")
               .append("         group by a.effectivedate, a.measureid ")
               .append("         ) act                         ")
               .append(" where  cid  = spid (+) ")
               .append(" and    sid  = bpid (+) ")
               .append(" and    bid  = ppid (+) ")
               .append(" and    pid  = opid (+) ")
               .append(" and    oid  = mpid ")
               .append(" and    mcid = amid (+)   ")
               .append(" order by crank, srank, brank, prank, orank, mrank ");

               params = new Object[] {year,year,grpId,year,year,year,year, measureId, year+month};

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

	/**
	 * 비계량 지표평가 2007
	 *
	 * @param request
	 * @param response
	 */
	public void setEvalMeasure2007(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {


			String year  = request.getParameter("year");
			String month = request.getParameter("month");
			System.out.println("setEvalMeasure2007 : ym   ===>   " + year +month);
			if (year==null || month==null) return;

			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			String grpId = request.getParameter("grpId");
			String measureId = request.getParameter("measureId");

			String userId = (String)request.getSession().getAttribute("userId");
//			int groupId = new Integer((String)request.getSession().getAttribute("groupId")).intValue();
//			if (groupId == 1) {
//				userId = "%";
//			}
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			String[] grade=null;
			if ("I".equals(mode)){
				String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
				String[] mids = aMCID.split("\\|");

				String strU = "UPDATE TBLMEAEVALDETAIL SET EVALGRADE=?,EVALSCORE=?,MODIR=?,MODIDATE=SYSDATE,CONFIRM=1 WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=?";
				Object[] pmU = {null,null,userId,null,userId,year,month};

				String strI = "INSERT INTO TBLMEAEVALDETAIL (EVALID,EVALRID,YEAR,MONTH,EVALGRADE,EVALSCORE,REGIR,CONFIRM) VALUES (?,?,?,?,?,?,?,1)";
				Object[] pmI = {null,userId,year,month,null,null,userId};

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
						//System.out.println(grades);
					}
				}


			} else if ("D".equals(mode)){
				String strD = "DELETE FROM TBLMEAEVALDETAIL WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=?";
				Object[] objD = {null,userId,year,month};
				String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
				String[] mids = aMCID.split("\\|");

				for (int i = 0; i < mids.length; i++) {
					if (!"".equals(mids[i])){
						objD[0]=mids[i];
						dbobject.executePreparedUpdate(strD,objD);
					}
				}
			}
			System.out.println("list:"+grpId+"/"+measureId);
			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			sb.append(" SELECT  grpid, evaldeptid, year,  month, ")
			.append("         cid, ccid, clevel, crank, cname,   ")
			.append("         sid, scid, slevel, srank, sname,   ")
			.append("         bid, bcid, blevel, brank, bname,   ")
			.append("         mid, mcid, mlevel, mrank, mname,  mweight, ")
			.append("         measureid,  ")
			.append("         amid, filepath, filename, evalgrade, evalscore, evalid  ")
			.append(" FROM ")
			.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ")
			.append("         from   tblhierarchy t,tblcompany c ")
			.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =? ")
			.append("        ) com, ")
			.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
			.append("         from   tblhierarchy t,tblsbu c ")
			.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =? and c.id = ? ")
			.append("        ) sbu, ")
			.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname ")
			.append("         from   tblhierarchy t,tblbsc c ")
			.append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =? ")
			.append("        ) bsc, ")
			.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname ")
			.append("         from   tbltreescore t,tblpst c ")
			.append("         where  t.contentid=c.id  and t.treelevel=3 and t.year =? ")
			.append("        ) pst  , ")
			.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname ")
			.append("         from   tbltreescore t,tblobjective c ")
			.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year =? ")
			.append("        ) obj , ")
			.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname, ")
			.append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey, ")
			.append("                d.unit       , ")
			.append("                d.planned,d.plannedbase, d.base, d.baselimit, d.limit ")
			.append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d ")
			.append("         where  t.contentid=d.id  and t.treelevel=5 and t.year =? and d.measureid=c.id ")
			.append("         and    d.measurement = '비계량' ")
			.append("         and    d.measureid = ? ")
			.append("        ) mea,  ")
			.append("        ( ")
			.append("         select a.grpid, evaldeptid, year, month ")
			.append("         from   tblmeaevaldept a,  tblmeaevalr  b ")
			.append("         where  a.grpid = b.grpid  ")
			.append("         and    b.evalrid like ?  ")
			.append("         and    b.year = ?  ")
			.append("         and    b.month = ? ")
			.append("        ) emp,  ")
			.append("        ( ")
			.append("         select  a.effectivedate, a.measureid  amid,  a.filepath, a.filename, b.evalgrade, b.evalscore, b.evalid  ")
			.append("         from   tblevalmeasuredetail a, tblmeaevaldetail b  ")
			.append("         where  a.effectivedate = b.year(+)||b.month(+) ")
			.append("         and    a.measureid= b.evalid(+) ")
			.append("         and    a.effectivedate = ? ")
			.append("         and    b.evalrid(+)    like ? ")
			.append("         ) act                      ")
			.append(" where  cid  = spid (+) ")
			.append(" and    sid  = bpid (+) ")
			.append(" and    bid  = ppid (+) ")
			.append(" and    pid  = opid (+) ")
			.append(" and    oid  = mpid ")
			.append(" and    scid = evaldeptid ")
			.append(" and    mcid = amid (+)   ")
			.append(" order by crank, srank, brank, prank, orank, mrank ");

			params = new Object[] {year,year,grpId,year,year,year,year, measureId, userId, year,month, year+month, userId};

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

	public void setEvalExecutive(HttpServletRequest request, HttpServletResponse response) {
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
			if ("I".equals(mode)){  // 단순 평가 결과 입력 과정
				String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
				String[] mids = aMCID.split("\\|");

				String strU = "UPDATE TBLMEAEVALDETAIL SET EVALGRADE=?,EVALSCORE=?,MODIR=?,MODIDATE=SYSDATE,CONFIRM=1 WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=?";
				Object[] pmU = {null,null,userId,null,"executive",year,"12"};

				String strI = "INSERT INTO TBLMEAEVALDETAIL (EVALID,EVALRID,YEAR,MONTH,EVALGRADE,EVALSCORE,REGIR,CONFIRM) VALUES (?,?,?,?,?,?,?,1)";
				Object[] pmI = {null,"executive",year,"12",null,null,userId};

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
			} else if("A".equals(mode)){  // 평가 결과 입력 후 BSC 실적 반영 과정
				String aMCID = request.getParameter("aMCID")!=null?request.getParameter("aMCID"):"";
				String[] mids = aMCID.split("\\|");

				String strU = "UPDATE TBLMEAEVALDETAIL SET EVALGRADE=?,EVALSCORE=?,MODIR=?,MODIDATE=SYSDATE,CONFIRM=1 WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=?";
				Object[] pmU = {null,null,userId,null,"executive",year,"12"};

				String strI = "INSERT INTO TBLMEAEVALDETAIL (EVALID,EVALRID,YEAR,MONTH,EVALGRADE,EVALSCORE,REGIR,CONFIRM) VALUES (?,?,?,?,?,?,?,1)";
				Object[] pmI = {null,"executive",year,"12",null,null,userId};

				for (int i = 0; i < mids.length; i++) {
					if (!"".equals(mids[i])){

						// 평가 점수 입력 과정
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

						//////////////////////////////// bsc 실적 반영 과정
						String strEqu = "SELECT EQUATION,WEIGHT,TREND,FREQUENCY FROM TBLMEASUREDEFINE WHERE ID=?";
						Object[] pmEqu = {mids[i]};

						if (rs!=null){rs.close(); rs=null;}

						rs = dbobject.executePreparedQuery(strEqu,pmEqu);
						String equ = "";
						String weight = null;
						String trend = null;
						String frequency = null;
						while(rs.next()){
							equ = rs.getString("EQUATION");
							weight = rs.getString("WEIGHT");
							trend = rs.getString("TREND");
							frequency = rs.getString("FREQUENCY");
						}



						MeasureDetail measuredetail = getMeasureDetail (dbobject,mids[i],year+"12");
						measuredetail.actual = new Double(scr).doubleValue();
						measuredetail.strDate = Util.getLastMonth(year+"12");
						measuredetail.weight = new Float(weight).floatValue();
						measuredetail.measureId = new Integer(mids[i]).intValue();
						measuredetail.trend = (trend==null)?"상향":trend;
						measuredetail.frequency = frequency;

						updateMeasureDetail(dbobject,measuredetail);
					}

				}


			} else if ("D".equals(mode)){
				String strD = "DELETE FROM TBLMEAEVALDETAIL WHERE EVALID=? AND EVALRID=? AND YEAR=? AND MONTH=12";
				Object[] objD = {null,"executive",year};
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
	         .append(" LEFT JOIN ")
	         .append(" (SELECT MEASUREID DMID,ACTUAL FROM TBLMEASUREDETAIL WHERE SUBSTR(STRDATE,0,6)=?) DTL ")
	         .append(" ON MEA.MCID=DTL.DMID  ")
	         .append(" WHERE MID IS NOT NULL AND MEASCHAR='E' ")
	         .append(" ORDER BY BRANK,BID  ");

	         params = new Object[] {userId,year,grpId,year,year,year,year,year,"executive",year+"12",year+"12"};

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
	public void setEvalInn(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String appraiser = (String)request.getSession().getAttribute("appraiser");
			if ((appraiser==null)||(!"1".equals(appraiser)) ) return;

			String userId = (String)request.getSession().getAttribute("userId");
			if (userId==null) return;

			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);

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
			String month = request.getParameter("month");
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

			Object[] pm = {mid,year,year,year,year+month};
			rs = dbobject.executePreparedQuery(sb.toString(),pm);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds", ds);
			System.out.println(""+ds.toString());


		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public void setOpinionDetail(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year")!=null?request.getParameter("year"):"";
			String month = request.getParameter("month")!=null?request.getParameter("month"):"";
			String grpId = request.getParameter("grpId")!=null?request.getParameter("grpId"):"";
			String measureId = request.getParameter("measureId")!=null?request.getParameter("measureId"):"";
			String mcId = request.getParameter("mcId")!=null?request.getParameter("mcId"):"";
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			//String opinion = request.getParameter("txtOpn")!=null?Util.getUTF(request.getParameter("txtOpn")):"";
			String opinion = request.getParameter("txtOpn")!=null?Util.getEUCKR(request.getParameter("txtOpn")):"";
			System.out.println("setOpinionDetail :"+mode+"/"+year+"/"+month + "/" + mcId+"/"+measureId);
			if (year==null || month==null) return;

			String userId = (String)request.getSession().getAttribute("userId");


			System.out.println("mcId : "+mcId);
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);


			dbobject = new DBObject(conn.getConnection());

			if ("A".equals(mode)) {

				String strU = "UPDATE TBLMEAEVALDETAIL SET EVALOPINION=? WHERE EVALID=? AND YEAR=? AND EVALRID=? ";
				Object[] objU = {opinion, mcId, year,userId};

				String strI = "INSERT INTO TBLMEAEVALDETAIL (EVALID,YEAR,Month,EVALRID,EVALOPINION) VALUES (?,?,?,?,?)";
				Object[] objI = {mcId,year,month,userId,opinion};

				if(dbobject.executePreparedUpdate(strU,objU)<1)
					dbobject.executePreparedUpdate(strI,objI);

			} else if ("D".equals(mode)) {
				String strD = "UPDATE TBLMEAEVALDETAIL SET EVALOPINION='' WHERE EVALID=? AND YEAR=? AND EVALRID=? ";
				Object[] objU = {mcId, year,userId};

				dbobject.executePreparedUpdate(strD,objU);
			}
			StringBuffer sb = new StringBuffer();

				sb.append(" SELECT * FROM TBLMEAEVALDETAIL WHERE YEAR=? AND EVALID=?  ");//2008년 11월 3일 비계량"평가 의견서 출력때문에 수정
				Object[] pm = {year,mcId};
				rs = dbobject.executePreparedQuery(sb.toString(),pm);

				//sb.append(" SELECT * FROM TBLMEAEVALDETAIL WHERE YEAR=? AND EVALID=? AND EVALRID=? ");
				//Object[] pm = {year,mcId,userId};



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


	//===================================================  inje ===============================================
	public void setMeasure2(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String schDate = request.getParameter("schDate");

			String year = schDate.substring(0,4);
			//String month = schDate.substring(4,6);
			String month = "12";
			String bscId = request.getParameter("bscId");
			//System.out.println(bscId);

			int groupId = new Integer((String)request.getSession().getAttribute("groupId")).intValue();

			String userId = (String)request.getSession().getAttribute("userId");



			String frq = getFrequecny(new Integer(month).intValue());
			System.out.println("schDate    ===>>   "+schDate);

			System.out.println("year  ======="+year);
			System.out.println("month  ======="+month);
			System.out.println("userId  ======="+userId);
			System.out.println("bscId  ======="+bscId);
			System.out.println("groupId  ======="+groupId);
			System.out.println("groupId  ======="+groupId);
			System.out.println("frq  ======="+frq);

			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			sb.append(" SELECT * FROM   ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME   ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? AND T.ID=? ) BSC  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME   ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST  ")
	         .append(" ON BSC.BID=PST.PPID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME   ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ  ")
	         .append(" ON PST.PID=OBJ.OPID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,D.MEASUREMENT   ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND D.FREQUENCY IN ("+frq+")) MEA  ")
	         .append(" ON OBJ.OID=MEA.MPID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT MEASUREID,EFFECTIVEDATE,PLANNED,DETAIL,FILEPATH,FILENAME,PCONFIRM,ACONFIRM FROM TBLEVALMEASUREDETAIL WHERE EFFECTIVEDATE LIKE  ?% ) DET ")
	         .append(" ON MEA.MCID=DET.MEASUREID ")
	         .append(" WHERE MEASUREMENT='비계량' AND MID IS NOT NULL  ")
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

	public void UpdadePland(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String mid = Util.getUTF(request.getParameter("Mid"));
			String year = Util.getUTF(request.getParameter("year"));//year
			String jugi = Util.getUTF(request.getParameter("jugi"));
			String planned4 = Util.getUTF(request.getParameter("PLANNED"));

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			System.out.println("MId : "+mid);
			System.out.println("year : "+year);
			System.out.println("jugi : "+jugi);
			System.out.println("PLANNED4 : "+planned4);

				System.out.println("주기 출력 : "+jugi);
			// 반기일 경우  계획 입력 받은 값(4/4)를 2/4분기에도 저장을함


			// 2008.10.02 JJJ 배광진 요청
			// 1. 지표의 주기를 구한다.(JSP에서 전달받음)
			// 2. 지표의 주기에 따라 4/4분기(12월)계획을 해당 지표주기의 월에 자동생성

			String planned1 = planned4;
			String planned2 = planned4;
			String planned3 = planned4;

			planned1 = planned1.replaceAll("<br>","\n");
			planned2 = planned2.replaceAll("<br>","\n");
			planned3 = planned3.replaceAll("<br>","\n");
			planned4 = planned4.replaceAll("<br>","\n");

			System.out.println("planned1   ===>>   "+planned1);
			System.out.println("planned2   ===>>   "+planned2);
			System.out.println("planned3   ===>>   "+planned3);
			System.out.println("planned4   ===>>   "+planned4);

			String new_filename = "dd";
			String filename = "dd";
			//==UPDATE (03)
			System.out.println("체크0");

			if(jugi.equals("분기")){
				System.out.println("체크0-1");
				String strU1 = "UPDATE TBLEVALMEASUREDETAIL SET PLANNED=?,PCONFIRM=1, FILEPATH_PLAN=?, FILENAME_PLAN=? WHERE MEASUREID=? AND EFFECTIVEDATE=?";
				Object[] pmU1 = {planned1,new_filename, filename,mid,year+"03"};
				rs = dbobject.executePreparedQuery(strU1,pmU1);

				System.out.println("체크1");
			}
			//==UPDATE (06)
			if(jugi.equals("반기")||jugi.equals("분기")){
				String strU2 = "UPDATE TBLEVALMEASUREDETAIL SET PLANNED=?,PCONFIRM=1, FILEPATH_PLAN=?, FILENAME_PLAN=? WHERE MEASUREID=? AND EFFECTIVEDATE=?";
				Object[] pmU2 = {planned2,new_filename, filename,mid,year+"06"};
				rs = dbobject.executePreparedQuery(strU2,pmU2);
				System.out.println("체크2");
			}

			// 09월
			if(jugi.equals("분기")){
				String strU3 = "UPDATE TBLEVALMEASUREDETAIL SET PLANNED=?,PCONFIRM=1, FILEPATH_PLAN=?, FILENAME_PLAN=? WHERE MEASUREID=? AND EFFECTIVEDATE=?";
				Object[] pmU3 = {planned3,new_filename, filename,mid,year+"09"};
				rs = dbobject.executePreparedQuery(strU3,pmU3);
				System.out.println("체크3");
			}

			// 12월
			if(jugi.equals("년")||jugi.equals("반기")||jugi.equals("분기")){
				String strU4 = "UPDATE TBLEVALMEASUREDETAIL SET PLANNED=?,PCONFIRM=1, FILEPATH_PLAN=?, FILENAME_PLAN=? WHERE MEASUREID=? AND EFFECTIVEDATE=?";
				Object[] pmU4 = {planned4,new_filename, filename,mid,year+"12"};
				System.out.println("---------------"+strU4);
				System.out.println("+++++++++++++++"+planned2 +"/"+ new_filename+"/" + filename+"/"+mid+"/"+ year+"06");

				rs = dbobject.executePreparedQuery(strU4,pmU4);
				System.out.println("체크4");
			}

			conn.commit();


		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}




	public void setActual2(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			Common_Data cd = new Common_Data();

			ServletConfig config = (ServletConfig)request.getAttribute("config");
			String type = request.getContentType()!=null?request.getContentType():"";
			if (type.indexOf(";")>0) {
				int ik = type.indexOf(";");
				type = type.substring(0,ik);
			}

			if ("multipart/form-data".equals(type)) {
			    int sizeLimit = 10 * 1024 * 1024; // 10M, 파일 사이즈 제한, 제한 사이즈 초과시 exception발생.
			    String UPLOADROOT = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"actual"+File.separator+"measurementplan"; // 경로 지정(절대 경로 | ROOT를 기준으로 한 상대경로)
			    String UPLOADPATH = UPLOADROOT + File.separator;
			    String PYSICALPATH = File.separator+"actual"+File.separator+"measurementplan"+File.separator;

				File upfolder = new File(UPLOADROOT);

				if(!upfolder.isDirectory()){upfolder.mkdir();}

				//MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit,"EUC-KR", new DefaultFileRenamePolicy()); // 이부분에서 upload가 됨.
				MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit,"EUC-KR", new ByUserIdFileRenamePolicy());      // 서버 한글 깨짐 ...


				String tag     = cd.ReplaceCode(multi.getParameter("tag"));
				String schDate = cd.ReplaceCode(multi.getParameter("schDate"));
				String mid     = cd.ReplaceCode(multi.getParameter("contentId"));	// 지표정의서 ID
				String jugi    = cd.ReplaceCode(multi.getParameter("qtr"));		// 주기




				if ((schDate==null)||(mid==null)) return;

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);

				dbobject = new DBObject(conn.getConnection());

				String year = schDate.substring(0,4);//
				String month = schDate.substring(4,6);

				request.setAttribute("year", year);

				System.out.println("schDate22222   ===>>   "+schDate);
				System.out.println("year   ===>>   "+year);
				System.out.println("month   ===>>   "+month);

				if ("P".equals(tag)){      // save planned
					ArrayList fileList = new ArrayList();
					ArrayList originalFilename = new ArrayList();
					Enumeration filenames = multi.getFileNames();

					while(filenames.hasMoreElements())   {
						String formName = (String)filenames.nextElement();
						fileList.add(multi.getFilesystemName(formName));
					    originalFilename.add(cd.ReplaceCode1(multi.getOriginalFileName(formName)));
					}

					String fileName = (String)fileList.get(0);
					fileName = cd.ReplaceCode1(fileName);             //String 에서 ' 를 제가 하는 함수
					String originalFile = (String)originalFilename.get(0);


					String planned1 = (cd.ReplaceCode(multi.getParameter("planned1")));
					String planned2 = (cd.ReplaceCode(multi.getParameter("planned2")));
					String planned3 = (cd.ReplaceCode(multi.getParameter("planned3")));
					String planned4 = (cd.ReplaceCode(multi.getParameter("planned4")));

					// System.out.println("출력 : "+jugi);
					// 반기일 경우  계획 입력 받은 값(4/4)를 2/4분기에도 저장을함


					// 2008.10.02 JJJ 배광진 요청
					// 1. 지표의 주기를 구한다.(JSP에서 전달받음)
					// 2. 지표의 주기에 따라 4/4분기(12월)계획을 해당 지표주기의 월에 자동생성
					planned1 = planned4;
					planned2 = planned4;
					planned3 = planned4;

					planned1 = planned1.replaceAll("<br>","\n");
					planned2 = planned2.replaceAll("<br>","\n");
					planned3 = planned3.replaceAll("<br>","\n");
					planned4 = planned4.replaceAll("<br>","\n");


					String pysicalPath = PYSICALPATH + fileName;
					if("WINDOWS".equals(ServerStatic.SERVER_OS)){
						pysicalPath = pysicalPath.replace("\\", "\\\\");
					}

					//==UPDATE (03)
					if(jugi.equals("분기")){

						String strU1 = "UPDATE TBLEVALMEASUREDETAIL SET PLANNED=?,PCONFIRM=1, FILEPATH_PLAN=?, FILENAME_PLAN=? WHERE MEASUREID=? AND EFFECTIVEDATE=?";
						Object[] pmU1 = {planned1, pysicalPath, originalFile, mid,year+"03"};
						String strI1 = "INSERT INTO TBLEVALMEASUREDETAIL (MEASUREID,EFFECTIVEDATE,PLANNED,PCONFIRM, FILEPATH_PLAN, FILENAME_PLAN) VALUES (?,?,?,1,?,?)";
						Object[] pmI1 = {mid,year+"03", planned1, pysicalPath, originalFile};
							if (dbobject.executePreparedUpdate(strU1,pmU1)<1){
								dbobject.executePreparedUpdate(strI1,pmI1);
							}
					}

					//==UPDATE (06)
					if(jugi.equals("반기")||jugi.equals("분기")){
						String strU2 = "UPDATE TBLEVALMEASUREDETAIL SET PLANNED=?,PCONFIRM=1, FILEPATH_PLAN=?, FILENAME_PLAN=? WHERE MEASUREID=? AND EFFECTIVEDATE=?";
						Object[] pmU2 = {planned2,pysicalPath, originalFile,mid,year+"06"};
						String strI2 = "INSERT INTO TBLEVALMEASUREDETAIL (MEASUREID,EFFECTIVEDATE,PLANNED,PCONFIRM, FILEPATH_PLAN, FILENAME_PLAN) VALUES (?,?,?,1,?,?)";
						Object[] pmI2 = {mid,year+"06", planned2, pysicalPath, originalFile};
						if (dbobject.executePreparedUpdate(strU2,pmU2)<1){
							dbobject.executePreparedUpdate(strI2,pmI2);
						}
					}

					// 09월
					if(jugi.equals("분기")){
						String strU3 = "UPDATE TBLEVALMEASUREDETAIL SET PLANNED=?,PCONFIRM=1, FILEPATH_PLAN=?, FILENAME_PLAN=? WHERE MEASUREID=? AND EFFECTIVEDATE=?";
						Object[] pmU3 = {planned3,pysicalPath, originalFile,mid,year+"09"};
						String strI3 = "INSERT INTO TBLEVALMEASUREDETAIL (MEASUREID,EFFECTIVEDATE,PLANNED,PCONFIRM, FILEPATH_PLAN, FILENAME_PLAN) VALUES (?,?,?,1,?,?)";
						Object[] pmI3 = {mid,year+"09", planned3, pysicalPath, originalFile};
							if (dbobject.executePreparedUpdate(strU3,pmU3)<1){
								dbobject.executePreparedUpdate(strI3,pmI3);
							}
					}

					// 12월
					if(jugi.equals("년")||jugi.equals("반기")||jugi.equals("분기")){
						String strU4 = "UPDATE TBLEVALMEASUREDETAIL SET PLANNED=?,PCONFIRM=1, FILEPATH_PLAN=?, FILENAME_PLAN=? WHERE MEASUREID=? AND EFFECTIVEDATE=?";
						Object[] pmU4 = {planned4,pysicalPath, originalFile,mid,year+"12"};
						String strI4 = "INSERT INTO TBLEVALMEASUREDETAIL (MEASUREID,EFFECTIVEDATE,PLANNED,PCONFIRM, FILEPATH_PLAN, FILENAME_PLAN) VALUES (?,?,?,1,?,?)";
						Object[] pmI4 = {mid,year+"12", planned4, pysicalPath, originalFile};
							if (dbobject.executePreparedUpdate(strU4,pmU4)<1){
								dbobject.executePreparedUpdate(strI4,pmI4);
							}


					}

				} else if ("RP".equals(tag)){     // reset planned

					//String strU = "UPDATE TBLEVALMEASUREDETAIL SET PCONFIRM=0 WHERE MEASUREID=? AND EFFECTIVEDATE=?";
					//Object[] pmU = {mid,schDate};
					String strQ = "SELECT FILEPATH_PLAN,FILENAME_PLAN FROM TBLEVALMEASUREDETAIL WHERE MEASUREID=? AND EFFECTIVEDATE LIKE ?";
					rs = dbobject.executePreparedQuery(strQ, new Object[]{mid,year+month});
					rs.next();
					/*String fi = request.getRealPath(File.separator)+savepath+File.separator+rs.getString("FILEPATH_PLAN");
					File f = new File(fi);
					f.delete();*/
					String strU = "UPDATE TBLEVALMEASUREDETAIL SET PLANNED='',PCONFIRM=0, FILEPATH_PLAN='' ,FILENAME_PLAN='' WHERE MEASUREID=? AND EFFECTIVEDATE LIKE ?||'%'";
					Object[] pmU = {mid, year};

					dbobject.executePreparedUpdate(strU,pmU);
				}


				StringBuffer sbMea = new StringBuffer();
				sbMea.append(" SELECT * FROM ")
					.append(" (SELECT D.ID, C.NAME,D.EQUATION,D.TREND,D.UPDATEID, D.FREQUENCY FROM TBLMEASUREDEFINE D, TBLMEASURE C WHERE D.MEASUREID=C.ID AND D.ID=?) DEF ")
					.append(" LEFT JOIN  ")
					.append(" (SELECT MEASUREID,EFFECTIVEDATE,PLANNED,DETAIL,FILEPATH,FILENAME,PCONFIRM,ACONFIRM,ESTIMATE,ESTIGRADE, FILEPATH_PLAN, FILENAME_PLAN FROM TBLEVALMEASUREDETAIL ) ACT ")
					.append(" ON DEF.ID=ACT.MEASUREID AND ACT.EFFECTIVEDATE LIKE ? ");

				Object[] pmMea = {mid,year+"%"};

				if (rs!=null){rs.close(); rs=null;}
				rs = dbobject.executePreparedQuery(sbMea.toString(),pmMea);

				DataSet dsMea = new DataSet();
				dsMea.load(rs);

				request.setAttribute("dsMea", dsMea);
				System.out.println("dsMea : " + dsMea);

				request.setAttribute("mid",mid);

				conn.commit();

			}
		} catch (IOException ie){
			System.out.print(ie);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/**
	 * 비계량 지표 부서 평가 (2008년 이후)
	 *
	 * @param request
	 * @param response
	 */
	public void setEvalGroupOrg(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		try {
			String appraiser = (String)request.getSession().getAttribute("appraiser");
			if ((appraiser==null)||(!"1".equals(appraiser))) return;

			String qtr = Util.getPrevQty(null);

			String ym    = request.getParameter("curDate")!=null?request.getParameter("curDate"):null;
			if (ym == null){
				ym = request.getAttribute("curDate")!= null?request.getAttribute("curDate").toString():qtr.substring(0,6);
			}
			String year  = ym.substring(0,4);
			String month = ym.substring(4,6);

			if ("01".equals(month)||"02".equals(month)||"03".equals(month)) month = "03";
			if ("04".equals(month)||"05".equals(month)||"06".equals(month)) month = "06";
			if ("07".equals(month)||"08".equals(month)||"09".equals(month)) month = "09";
			if ("10".equals(month)||"11".equals(month)||"12".equals(month)) month = "12";

			String userId  = (String)request.getSession().getAttribute("userId");
			String groupId = (String)request.getSession().getAttribute("groupId");
			int group = 5;

			if (groupId!=null) group = Integer.parseInt(groupId);
			if (group==1){
				userId = "%";
			}
			String frq = getFrequecny(new Integer(month).intValue());

			System.out.println("1.setEvalGroupOrg : " + year + month + ", userId :" + userId);

			StringBuffer sbGrp = new StringBuffer();

			sbGrp.append(" SELECT  distinct cid, ccid, clevel, crank, cname,    ")
				 .append("          sid, scid GRPID, slevel, srank, sname GRPNM ")
				 .append(" FROM ")
				 .append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ")
				 .append("         from   tblhierarchy t,tblcompany c ")
				 .append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =? ")
				 .append("        ) com, ")
				 .append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
				 .append("         from   tblhierarchy t,tblsbu c ")
				 .append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =? ")
				 .append("        ) sbu, ")
				 .append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname ")
				 .append("         from   tblhierarchy t,tblbsc c ")
				 .append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =? ")
				 .append("        ) bsc ")
				 .append(" where  cid  = spid        ")
				 .append(" and    sid  = bpid        ")
				 .append(" order by crank, srank     ");

			Object[] params = {year,year,year};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sbGrp.toString(),params);
			DataSet ds = new DataSet();
			ds.load(rs);
			request.setAttribute("dsGrp", ds);

			System.out.println("GRPID LOOP ==> " + year + month + frq);

			rs2 = dbobject.executePreparedQuery(sbGrp.toString(),params);
			String scidTemp = "";

			while(rs2.next()){
				scidTemp = rs2.getString("GRPID");
				System.out.println("GRPID LOOP ==> " + rs2.getString("GRPID"));
				break;
			}

			String scid = request.getParameter("scid");
			if (scid == null || "".equals(scid)) {
				scid = scidTemp;
			}

			StringBuffer strDetail = new StringBuffer();
			//strDetail.append(" SELECT distinct measureid, mname, scid GRPID                                                                                     ");
			strDetail.append(" SELECT measureid, mname, scid grpid, min(crank) crnk, min(srank) srnk, min(brank) brnk, min(prank) prnk, min(orank) ornk, min(mrank) mrnk                                                                                    ");
			strDetail.append("  FROM   (                                                                                                                        ");
			strDetail.append("  SELECT  cid, ccid, clevel, crank, cname,  cweight,                                                                              ");
			strDetail.append("          sid, scid, slevel, srank, sname,  sweight,                                                                              ");
			strDetail.append("          bid, bcid, blevel, brank, bname,  sum(mweight) over (partition by cid, sid, bid          ) bweight,                     ");
			strDetail.append("          pid, pcid, plevel, prank, pname,  sum(mweight) over (partition by cid, sid, bid, pid     ) pweight,                     ");
			strDetail.append("          oid, ocid, olevel, orank, oname,  sum(mweight) over (partition by cid, sid, bid, pid, oid) oweight,                     ");
			strDetail.append("          mid, mcid, mlevel, mrank, mname,  mweight,                                                                              ");
			strDetail.append("          measureid                                                                                                               ");
			strDetail.append("  FROM                                                                                                                            ");
			strDetail.append("         (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname         ");
			strDetail.append("          from   tblhierarchy t,tblcompany c                                                                                      ");
			strDetail.append("          where  t.contentid=c.id  and t.treelevel=0 and t.year = ?                                                               ");
			strDetail.append("         ) com,                                                                                                                   ");
			strDetail.append("         (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname         ");
			strDetail.append("          from   tblhierarchy t,tblsbu c                                                                                          ");
			strDetail.append("          where  t.contentid=c.id  and t.treelevel=1 and t.year = ? and c.id = " + scid + "                                       ");
			strDetail.append("         ) sbu,                                                                                                                   ");
			strDetail.append("         (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname         ");
			strDetail.append("          from   tblhierarchy t,tblbsc c                                                                                          ");
			strDetail.append("          where  t.contentid=c.id  and t.treelevel=2 and t.year = ?                                                               ");
			strDetail.append("         ) bsc,                                                                                                                   ");
			strDetail.append("         (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname         ");
			strDetail.append("          from   tbltreescore t,tblpst c                                                                                          ");
			strDetail.append("          where  t.contentid=c.id  and t.treelevel=3 and t.year = ?                                                               ");
			strDetail.append("         ) pst  ,                                                                                                                 ");
			strDetail.append("         (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname         ");
			strDetail.append("          from   tbltreescore t,tblobjective c                                                                                    ");
			strDetail.append("          where  t.contentid=c.id  and t.treelevel=4 and t.year = ?                                                               ");
			strDetail.append("         ) obj ,                                                                                                                  ");
			strDetail.append("         (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname,      ");
			strDetail.append("                 c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey,                                           ");
			strDetail.append("                 d.unit       ,                                                                                                   ");
			strDetail.append("                 d.planned,d.plannedbase, d.base, d.baselimit, d.limit                                                            ");
			strDetail.append("          from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d                                                            ");
			strDetail.append("          where  t.contentid=d.id  and t.treelevel=5 and t.year = ? and d.measureid=c.id                                          ");
			strDetail.append("          and    d.measurement = '비계량' and d.frequency IN ("+frq+")                                                             ");
			strDetail.append("         ) mea                                                                                                                 ");
			strDetail.append("  where  cid = spid (+)                                                                                                           ");
			strDetail.append("  and    sid = bpid (+)                                                                                                           ");
			strDetail.append("  and    bid = ppid (+)                                                                                                           ");
			strDetail.append("  and    pid = opid (+)                                                                                                           ");
			strDetail.append("  and    oid = mpid                                                                                                               ");
			strDetail.append("  order by crank, srank, brank, prank, orank, mrank                                                                               ");
			strDetail.append("  )                                                                                                                               ");
			strDetail.append("  group by measureid, mname, scid order by crnk, srnk, brnk, prnk, ornk, mrnk                                                                                  ");

			Object[] obj = {year,year,year,year,year,year};
			if (rs!=null) {rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(strDetail.toString(),obj);

			DataSet dsDtl = new DataSet();
			dsDtl.load(rs);

			request.setAttribute("dsDtl", dsDtl);
			request.setAttribute("month", month);
			request.setAttribute("scid" , scid );
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/**
	 * 비계량 지표 사장 평가 (2007)
	 *
	 * @param request
	 * @param response
	 */
	public void setEvalGroup2007_1(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		try {

			String appraiser = (String)request.getSession().getAttribute("appraiser");
			if ((appraiser==null)||(!"1".equals(appraiser))) return;

			//String qtr = Util.getPrevQty(null);

			//String year = request.getParameter("year")!=null?request.getParameter("year"):qtr.substring(0,4);
			String year  = "2007";//request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			String month = request.getParameter("month")!=null?request.getParameter("month"):Util.getToDay().substring(4,6);

			String userId = (String)request.getSession().getAttribute("userId");

			StringBuffer sbGrp = new StringBuffer();

			sbGrp.append(" SELECT  cid, ccid, clevel, crank, cname, ")
				.append("         sid, scid GRPID, slevel, srank, sname GRPNM ")
				.append(" FROM ")
				.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ")
				.append("         from   tblhierarchy t,tblcompany c ")
				.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year ='2007' ")
				.append("        ) com, ")
				.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
				.append("         from   tblhierarchy t,tblsbu c ")
				.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year ='2007' ")
				.append("        ) sbu, ")
				.append("         ( ")
				.append("         select evaldeptid from tblmeaevaldept  ")
				.append("         where  grpid in (select grpid from tblmeaevalr  ")
				.append("                          where evalrid like '"+userId+"' and year = '2007' and month = '12') ")
				.append("         ) emp ")
				.append(" where  cid  = spid (+) ")
				.append(" and    scid = evaldeptid  ")
				.append(" order by crank, srank ");
			Object[] params = {userId};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sbGrp.toString(),null);
			DataSet ds = new DataSet();
			ds.load(rs);

			rs2 = dbobject.executePreparedQuery(sbGrp.toString(),null);

			String scidTemp = "";

			while(rs2.next()){
				scidTemp = rs2.getString("GRPID");
				System.out.println("GRPID LOOP ==> " + rs2.getString("GRPID"));
				break;
			}


			request.setAttribute("dsGrp", ds);


			String scid = request.getParameter("scid");
			if (scid == null || "".equals(scid)) {
				scid = scidTemp;
			}

			StringBuffer strDetail = new StringBuffer();
			strDetail.append(" SELECT distinct measureid, mname, scid GRPID ")
					.append(" FROM   ( ")
					.append(" SELECT  cid, ccid, clevel, crank, cname,  cweight, ")
					.append("         sid, scid, slevel, srank, sname,  sweight, ")
					.append("         bid, bcid, blevel, brank, bname,  sum(mweight) over (partition by cid, sid, bid          ) bweight, ")
					.append("         pid, pcid, plevel, prank, pname,  sum(mweight) over (partition by cid, sid, bid, pid     ) pweight, ")
					.append("         oid, ocid, olevel, orank, oname,  sum(mweight) over (partition by cid, sid, bid, pid, oid) oweight, ")
					.append("         mid, mcid, mlevel, mrank, mname,  mweight, ")
					.append("         measureid ")
					.append(" FROM ")
					.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ")
					.append("         from   tblhierarchy t,tblcompany c ")
					.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year = ? ")
					.append("        ) com, ")
					.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
					.append("         from   tblhierarchy t,tblsbu c ")
					.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year = ? and c.id = '" + scid + "' ")
					.append("        ) sbu, ")
					.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname ")
					.append("         from   tblhierarchy t,tblbsc c ")
					.append("         where  t.contentid=c.id  and t.treelevel=2 and t.year = ? ")
					.append("        ) bsc, ")
					.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname ")
					.append("         from   tbltreescore t,tblpst c ")
					.append("         where  t.contentid=c.id  and t.treelevel=3 and t.year = ? ")
					.append("        ) pst  , ")
					.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname ")
					.append("         from   tbltreescore t,tblobjective c ")
					.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year = ? ")
					.append("        ) obj , ")
					.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname, ")
					.append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey, ")
					.append("                d.unit       , ")
					.append("                d.planned,d.plannedbase, d.base, d.baselimit, d.limit ")
					.append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d ")
					.append("         where  t.contentid=d.id  and t.treelevel=5 and t.year = ? and d.measureid=c.id ")
					.append("         and    d.measurement = '비계량' ")
					.append("        ) mea ")
					.append(" where  cid = spid (+) ")
					.append(" and    sid = bpid (+) ")
					.append(" and    bid = ppid (+) ")
					.append(" and    pid = opid (+) ")
					.append(" and    oid = mpid ")
					.append(" order by crank, srank, brank, prank, orank, mrank ")
					.append(" ) ")
					.append(" order by 2 ");

			Object[] obj = {year,year,year,year,year,year};
			if (rs!=null) {rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(strDetail.toString(),obj);

			DataSet dsDtl = new DataSet();
			dsDtl.load(rs);

			request.setAttribute("dsDtl",dsDtl);
			request.setAttribute("month", month);
			request.setAttribute("scid", scid);
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/**
	 * 비계량 지표 사장 평가 (2007)
	 *
	 * @param request
	 * @param response
	 */
	public void setEvalGroup2007_2(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String appraiser = (String)request.getSession().getAttribute("appraiser");
			if ((appraiser==null)||(!"1".equals(appraiser))) return;

			//String qtr = Util.getPrevQty(null);

			//String year = request.getParameter("year")!=null?request.getParameter("year"):qtr.substring(0,4);
			String year = "2007";//request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			String month = request.getParameter("month")!=null?request.getParameter("month"):Util.getToDay().substring(4,6);

			String userId = (String)request.getSession().getAttribute("userId");

			StringBuffer sbGrp = new StringBuffer();
			sbGrp.append("SELECT  cid, ccid, clevel, crank, cname,  ")
				.append("        sid, scid GRPID, slevel, srank, sname GRPNM ")
				.append(" FROM ")
				.append("       (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ")
				.append("        from   tblhierarchy t,tblcompany c ")
				.append("        where  t.contentid=c.id  and t.treelevel=0 and t.year = ? ")
				.append("       ) com, ")
				.append("       (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
				.append("        from   tblhierarchy t,tblsbu c ")
				.append("        where  t.contentid=c.id  and t.treelevel=1 and t.year = ? ")
				.append("       ) sbu ")
				.append(" where  cid = spid (+) ")
				.append("       and scid not in (16,3,1) ")
				.append(" order by crank, srank ");
			Object[] params = {year,year};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sbGrp.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("dsGrp", ds);
			String measureId = null;
			measureId = request.getParameter("measureId");
			String cidsql = "";

			if (measureId == null || "".equals(measureId)) {
				cidsql = "and c.id not in (16,3,1)"; //
			} else {
				cidsql = "and c.id = " + measureId;
			}

			StringBuffer strDetail = new StringBuffer();
			strDetail.append(" SELECT distinct measureid, mname, scid GRPID ")
					.append(" FROM   ( ")
					.append(" SELECT  cid, ccid, clevel, crank, cname,  cweight, ")
					.append("         sid, scid, slevel, srank, sname,  sweight, ")
					.append("         bid, bcid, blevel, brank, bname,  sum(mweight) over (partition by cid, sid, bid          ) bweight, ")
					.append("         pid, pcid, plevel, prank, pname,  sum(mweight) over (partition by cid, sid, bid, pid     ) pweight, ")
					.append("         oid, ocid, olevel, orank, oname,  sum(mweight) over (partition by cid, sid, bid, pid, oid) oweight, ")
					.append("         mid, mcid, mlevel, mrank, mname,  mweight, ")
					.append("         measureid ")
					.append(" FROM ")
					.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ")
					.append("         from   tblhierarchy t,tblcompany c ")
					.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year = ? ")
					.append("        ) com, ")
					.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
					.append("         from   tblhierarchy t,tblsbu c ")
					.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year = ? " + cidsql + " ")
					.append("        ) sbu, ")
					.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname ")
					.append("         from   tblhierarchy t,tblbsc c ")
					.append("         where  t.contentid=c.id  and t.treelevel=2 and t.year = ? ")
					.append("        ) bsc, ")
					.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname ")
					.append("         from   tbltreescore t,tblpst c ")
					.append("         where  t.contentid=c.id  and t.treelevel=3 and t.year = ? ")
					.append("        ) pst  , ")
					.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname ")
					.append("         from   tbltreescore t,tblobjective c ")
					.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year = ? ")
					.append("        ) obj , ")
					.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname, ")
					.append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey, ")
					.append("                d.unit       , ")
					.append("                d.planned,d.plannedbase, d.base, d.baselimit, d.limit ")
					.append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d ")
					.append("         where  t.contentid=d.id  and t.treelevel=5 and t.year = ? and d.measureid=c.id ")
					.append("         and    d.measurement = '비계량' ")
					.append("        ) mea ")
					.append(" where  cid = spid (+) ")
					.append(" and    sid = bpid (+) ")
					.append(" and    bid = ppid (+) ")
					.append(" and    pid = opid (+) ")
					.append(" and    oid = mpid ")
					.append(" order by crank, srank, brank, prank, orank, mrank ")
					.append(" ) ")
					.append(" order by 2 ");

			Object[] obj = {year,year,year,year,year,year};
			if (rs!=null) {rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(strDetail.toString(),obj);

			DataSet dsDtl = new DataSet();
			dsDtl.load(rs);

			request.setAttribute("dsDtl",dsDtl);
			request.setAttribute("month", month);
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
}
