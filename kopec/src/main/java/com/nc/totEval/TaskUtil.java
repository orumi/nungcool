package com.nc.totEval;

import java.io.File;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.ServerStatic;
import com.nc.util.Util;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.ByUserIdFileRenamePolicy;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FilePart;
import com.oreilly.servlet.multipart.MultipartParser;
import com.oreilly.servlet.multipart.ParamPart;
import com.oreilly.servlet.multipart.Part;

public class TaskUtil {
	public void setDivision(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT ID,NAME,PARENTID FROM TBLBSC ORDER BY PARENTID DESC,ID ");
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
	}//-- method getDivision by jsp/web/totEval/task.jsp
	
	public void setTaskList(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String type = request.getContentType()!=null?request.getContentType():"";
			
			String userId = (String)request.getSession().getAttribute("userId");
			if (type.indexOf(";")>0) {
				int ik = type.indexOf(";");
				
				type = type.substring(0,ik);
			}
			if ("multipart/form-data".equals(type)) {
				int sizeLimit = 10 * 1024 * 1024; // 10M, 파일 사이즈 제한, 제한 사이즈 초과시 exception발생.
				String UPLOADROOT = ServerStatic.REAL_CONTEXT_ROOT+"/upload/totEval"; // 경로 지정(절대 경로 | ROOT를 기준으로 한 상대경로)
				
				String UPLOADPATH = UPLOADROOT + File.separator;
				//MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit, new DefaultFileRenamePolicy()); // 이부분에서 upload가 됨.
				//MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit,"euc-kr", new DefaultFileRenamePolicy()); // 이부분에서 upload가 됨. 한글 깨짐 현상 
				
				//MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit,"euc-kr", new ByUserIdFileRenamePolicy(userId));
				MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit, new ByUserIdFileRenamePolicy(userId));      // 한연 서버 한글 깨짐 ...
				
				ArrayList filename = new ArrayList();
				int cnt = 0;
				   
				Enumeration filenames = multi.getFileNames();
	
	//		 while문은 넘겨 받은 파일들의 파일명을 얻습니다.
	//		 파일을 넘겨주는 form 이름을 다르게 해줘야 된대.
	//		 upload할 파일이 2개 이상이면 배열로 받으면 됩니다.
				
				while(filenames.hasMoreElements())   {
					String formName = (String)filenames.nextElement();
				    filename.add(multi.getFilesystemName(formName));
				    
				}
				
			    String tag = multi.getParameter("tag");
			    String year = multi.getParameter("year");
			    String bscId = multi.getParameter("bscId");
			    String pBscId = multi.getParameter("pBscId");
			    
			    
			    String divCode = "-1".equals(bscId)?pBscId:bscId;
			    

				if ("U".equals(tag)){
					
					String tp =  multi.getParameter("type");
					if ("plan".equals(tp)){
						String planned = Util.getEUCKR(multi.getParameter("planned"));
						
						String file1=Util.getEUCKR((String)filename.get(2)); 
						String file2=Util.getEUCKR((String)filename.get(1)); 
						String file3=Util.getEUCKR((String)filename.get(0));
						
						String str = "SELECT PLANNEDFILE FROM TBLESTTASK WHERE DIVCODE=? AND YEAR=? ";
						Object[] obj = {divCode,year};
						
						if (rs !=null){rs.close(); rs=null;}
						
						rs = dbobject.executePreparedQuery(str,obj);
						
						if (rs.next()){
							String file = rs.getString("PLANNEDFILE");
							if ((file!=null)&&(!"".equals(file))){
								if (file1!=null) file += "|"+file1;
								if (file2!=null) file += "|"+file2;
								if (file3!=null) file += "|"+file3;
							} else {
								file="";
								if (file1!=null) file += file1;
								if (file2!=null) file += (("".equals(file))?"":"|")+file2;
								if (file3!=null) file += (("".equals(file))?"":"|")+file3;
							}
							
							StringBuffer strU = new StringBuffer();
							strU.append("UPDATE TBLESTTASK SET PLANNED=?,PLANNEDFILE=? WHERE DIVCODE=? AND YEAR=? ");
							Object[] objU = {planned,file,divCode,year};
							
							dbobject.executePreparedQuery(strU.toString(),objU);
						} else {
							String file = "";
							if (file1!=null) file += file1;
							if (file2!=null) file += (("".equals(file))?"":"|")+file2;
							if (file3!=null) file += (("".equals(file))?"":"|")+file3;
							
							StringBuffer strI = new StringBuffer();
							strI.append("INSERT INTO TBLESTTASK (DIVCODE,YEAR,PLANNED,PLANNEDFILE) VALUES (?,?,?,?)");
							Object[] objI = {divCode,year,planned,file};							
						}
						
					} else if ("act".equals(tp)) {
						String actual = Util.getEUCKR(multi.getParameter("actual"));
						String perform = Util.getEUCKR(multi.getParameter("perform"));
						
						
						String file1=Util.getEUCKR((String)filename.get(5)); 
						String file2=Util.getEUCKR((String)filename.get(4)); 
						String file3=Util.getEUCKR((String)filename.get(3));
						
						String file4=Util.getEUCKR((String)filename.get(2));
						String file5=Util.getEUCKR((String)filename.get(1));
						String file6=Util.getEUCKR((String)filename.get(0));
						
						String str = "SELECT ACTUALFILE,PERFORMFILE FROM TBLESTTASK WHERE DIVCODE=? AND YEAR=? ";
						Object[] obj = {divCode,year};
						
						if (rs !=null){rs.close(); rs=null;}
						
						rs = dbobject.executePreparedQuery(str,obj);
						
						if (rs.next()){
							String afile = rs.getString("ACTUALFILE");
							if ((afile!=null)&&(!"".equals(afile))){
								if (file1!=null) afile += "|"+file1;
								if (file2!=null) afile += "|"+file2;
								if (file3!=null) afile += "|"+file3;
							} else {
								afile="";
								if (file1!=null) afile += file1;
								if (file2!=null) afile += (("".equals(afile))?"":"|")+file2;
								if (file3!=null) afile += (("".equals(afile))?"":"|")+file3;
							}
							
							String pfile = rs.getString("PERFORMFILE");
							if ((pfile!=null)&&(!"".equals(pfile))){
								if (file4!=null) pfile += "|"+file4;
								if (file5!=null) pfile += "|"+file5;
								if (file6!=null) pfile += "|"+file6;
							} else {
								pfile="";
								if (file4!=null) pfile += file4;
								if (file5!=null) pfile += (("".equals(pfile))?"":"|")+file5;
								if (file6!=null) pfile += (("".equals(pfile))?"":"|")+file6;
							}
							
							StringBuffer strU = new StringBuffer();
							strU.append("UPDATE TBLESTTASK SET ACTUAL=?,PERFORM=?,ACTUALFILE=?,PERFORMFILE=? WHERE DIVCODE=? AND YEAR=? ");
							Object[] objU = {actual,perform,afile,pfile,divCode,year};
							
							dbobject.executePreparedQuery(strU.toString(),objU);
						} else {
							String afile = "";
							if (file1!=null) afile += file1;
							if (file2!=null) afile += (("".equals(afile))?"":"|")+file2;
							if (file3!=null) afile += (("".equals(afile))?"":"|")+file3;
							
							String pfile = "";
							if (file4!=null) pfile += file4;
							if (file5!=null) pfile += (("".equals(pfile))?"":"|")+file5;
							if (file6!=null) pfile += (("".equals(pfile))?"":"|")+file6;							
							
							StringBuffer strI = new StringBuffer();
							strI.append("INSERT INTO TBLESTTASK (DIVCODE,YEAR,ACTUAL,PERFORM,ACTUALFILE,PERFORMFILE) VALUES (?,?,?,?,?,?)");
							Object[] objI = {divCode,year,actual,perform,afile,pfile};							
						}
					}
					
					
					conn.commit();
				} else if ("FD".equals(tag)){
					String kind = Util.getEUCKR(multi.getParameter("kind"));
					if (kind!=null){
						int intKind = Integer.parseInt(kind);
						String paramFile = Util.getEUCKR(multi.getParameter("fName"));
						
						String strG = "SELECT PLANNEDFILE,ACTUALFILE,PERFORMFILE FROM TBLESTTASK WHERE DIVCODE=? AND YEAR=?";
						Object[] objG = {divCode,year};
						if (rs!=null){rs.close(); rs=null;}
						
						String delFile = "";
						rs = dbobject.executePreparedQuery(strG,objG);
						while(rs.next()){
							delFile = rs.getString(intKind);
						}
						
						String[] aFile = delFile.split("\\|");
						String saveFiles = "";
						
						for (int i = 0; i < aFile.length; i++) {
							if (!paramFile.equals(aFile[i])){
								saveFiles += (("".equals(saveFiles))?"":"|")+aFile[i];
							}
						}
						
						File file = new File(UPLOADPATH+""+paramFile);
						
						if ((file.exists())&&(file.isFile())){
							file.delete();
						}	
						StringBuffer strU = new StringBuffer();
						Object[] objU = {saveFiles,divCode,year};
						strU.append("UPDATE TBLESTTASK SET ");
						if (intKind==1) strU.append(" PLANNEDFILE=? ");
						else if (intKind==2) strU.append(" ACTUALFILE=? ");
						else if (intKind==3) strU.append( "PERFORMFILE=? ");
						strU.append(" WHERE DIVCODE=? AND YEAR=?");
						
						dbobject.executePreparedUpdate(strU.toString(),objU);
							
					}
					conn.commit();
				}
				
				
				StringBuffer sb = new StringBuffer();
				sb.append("SELECT * FROM TBLESTTASK WHERE DIVCODE=? AND YEAR=? ");
				Object[] obj = {divCode,year};
				
				if(rs!=null){rs.close(); rs=null;}
				rs = dbobject.executePreparedQuery(sb.toString(),obj);
				
				DataSet ds = new DataSet();
				ds.load(rs);
				
				request.setAttribute("ds",ds);
				
				StringBuffer sbSP = new StringBuffer();
				sbSP.append("SELECT * FROM ( ")
					.append(" SELECT I.BSCID,I.OBJID,I.DETAILID DID,I.PROJECTID PID, ")
					.append(" (SELECT NAME FROM TBLBSC C WHERE C.ID=I.BSCID) DNAME FROM TBLINITIATIVE I WHERE BSCID=?) INI ")
					.append(" LEFT JOIN ")
					.append(" (SELECT * FROM ")
					.append(" (SELECT PI.PROJECTID,PC.NAME,PI.FIELDID,PI.TYPEID FROM TBLSTRATPROJECT PC, TBLSTRATPROJECTINFO PI WHERE PC.ID=PI.CONTENTID) PRO ")
					.append(" 		LEFT JOIN ")
					.append(" 		(SELECT DETAILID, EXECWORK,PROJECTID DPID FROM TBLSTRATPROJECTDETAIL) DTL ")
					.append(" 		ON PRO.PROJECTID=DTL.DPID ")
					.append(" 		LEFT JOIN ")
					.append(" 		(SELECT DETAILID WDID, DTLID,DTLNAME FROM TBLSTRATWORK) WRK ")
					.append(" 		ON DTL.DETAILID=WRK.WDID ) PRO ")
					.append(" ON INI.DID=PRO.DETAILID ")
					.append(" LEFT JOIN ")
					.append(" (SELECT DETAILID ADTLID,YEAR,DRVGOAL,DRVACHV FROM TBLSTRATDRV WHERE YEAR=?) ACT ")
					.append(" ON PRO.DTLID=ACT.ADTLID ")
					.append(" WHERE NAME IS NOT NULL AND ((TYPEID=1 AND DTLNAME IS NOT NULL) OR (TYPEID=2))")
					.append(" ORDER BY NAME,EXECWORK,DTLNAME ");
				
				if(rs!=null) {rs.close(); rs=null;}
				rs = dbobject.executePreparedQuery(sbSP.toString(),obj);
				
				DataSet dsSP = new DataSet();
				dsSP.load(rs);
				
				request.setAttribute("dsSP",dsSP);
			    
			}


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
	}//-- method getDivision by jsp/web/totEval/taskList.jsp
	
	
	public void setTaskPrint(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String type = request.getContentType()!=null?request.getContentType():"";
			
			String userId = (String)request.getSession().getAttribute("userId");
			if (type.indexOf(";")>0) {
				int ik = type.indexOf(";");
				
				type = type.substring(0,ik);
			}

				
			    String year = request.getParameter("year");
			    String bscId = request.getParameter("bscId");
			    String pBscId = request.getParameter("pBscId");
			    
			    
			    String divCode = "-1".equals(bscId)?pBscId:bscId;
			    

				StringBuffer sb = new StringBuffer();
				sb.append("SELECT * FROM TBLESTTASK WHERE DIVCODE=? AND YEAR=? ");
				Object[] obj = {divCode,year};
				
				if(rs!=null){rs.close(); rs=null;}
				rs = dbobject.executePreparedQuery(sb.toString(),obj);
				
				DataSet ds = new DataSet();
				ds.load(rs);
				
				request.setAttribute("ds",ds);
				
				StringBuffer sbSP = new StringBuffer();
				sbSP.append("SELECT * FROM ( ")
					.append(" SELECT I.BSCID,I.OBJID,I.DETAILID DID,I.PROJECTID PID, ")
					.append(" (SELECT NAME FROM TBLBSC C WHERE C.ID=I.BSCID) DNAME FROM TBLINITIATIVE I WHERE BSCID=?) INI ")
					.append(" LEFT JOIN ")
					.append(" (SELECT * FROM ")
					.append(" (SELECT PI.PROJECTID,PC.NAME,PI.FIELDID,PI.TYPEID FROM TBLSTRATPROJECT PC, TBLSTRATPROJECTINFO PI WHERE PC.ID=PI.CONTENTID) PRO ")
					.append(" 		LEFT JOIN ")
					.append(" 		(SELECT DETAILID, EXECWORK,PROJECTID DPID FROM TBLSTRATPROJECTDETAIL) DTL ")
					.append(" 		ON PRO.PROJECTID=DTL.DPID ")
					.append(" 		LEFT JOIN ")
					.append(" 		(SELECT DETAILID WDID, DTLID,DTLNAME FROM TBLSTRATWORK) WRK ")
					.append(" 		ON DTL.DETAILID=WRK.WDID ) PRO ")
					.append(" ON INI.DID=PRO.DETAILID ")
					.append(" LEFT JOIN ")
					.append(" (SELECT DETAILID ADTLID,YEAR,DRVGOAL,DRVACHV FROM TBLSTRATDRV WHERE YEAR=?) ACT ")
					.append(" ON PRO.DTLID=ACT.ADTLID ")
					.append(" WHERE NAME IS NOT NULL AND ((TYPEID=1 AND DTLNAME IS NOT NULL) OR (TYPEID=2))")
					.append(" ORDER BY NAME,EXECWORK,DTLNAME ");
				
				if(rs!=null) {rs.close(); rs=null;}
				rs = dbobject.executePreparedQuery(sbSP.toString(),obj);
				
				DataSet dsSP = new DataSet();
				dsSP.load(rs);
				
				request.setAttribute("dsSP",dsSP);
			    
				String strD = "SELECT NAME FROM TBLBSC WHERE ID=?";
				Object[] objD = {divCode};
				
				if (rs!=null) {rs.close(); rs=null;}
				rs = dbobject.executePreparedQuery(strD,objD);
				
				DataSet dsD = new DataSet();
				dsD.load(rs);
				
				request.setAttribute("dsD",dsD);

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
	}//-- method getDivision by jsp/web/totEval/taskList.jsp	
	
	
	
	
	
	
	
	
	
}

