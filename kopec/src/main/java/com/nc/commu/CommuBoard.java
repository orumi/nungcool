package com.nc.commu;

import java.io.File;
import java.sql.ResultSet;
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
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
public class CommuBoard {
 
 public void setConnection(HttpServletRequest request, HttpServletResponse response) {
  CoolConnection conn = null;
  DBObject dbobject = null;
  ResultSet rs = null;
  
  try {
   conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
   conn.createStatement(false);
   
   dbobject = new DBObject(conn.getConnection());
   
   
   StringBuffer sbSQL =  new StringBuffer();
   sbSQL.append("SELECT ID, NAME FROM TBLCONNECTION ");
   
   rs = dbobject.executeQuery(sbSQL.toString());
   
   DataSet ds = new DataSet();
   ds.load(rs);
   
   request.setAttribute("ds",ds);
  } catch (Exception e) {
   try{ conn.rollback(); } catch (Exception ex) {};
   System.out.println(e);
  } finally {
   try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
   if (dbobject != null){dbobject.close(); dbobject = null;}
   if (conn != null) {conn.close(); conn = null;}
  } 
 }
 public void setCommuBoardList(HttpServletRequest request, HttpServletResponse response, String userId, String div_cd) {
  CoolConnection conn = null;
  DBObject dbobject = null;
  ResultSet rs = null;
  
     int startPage  = Integer.parseInt(request.getParameter("startpage") == null ? "1" : (request.getParameter("startpage")).trim());
     int lines   = Integer.parseInt(request.getParameter("lines") == null ? "15" : (request.getParameter("lines")).trim());
     String searchCode = request.getParameter("searchCode") == null ? "" : Util.getEUCKR((request.getParameter("searchCode")).trim());
     if(searchCode == null || searchCode.trim().equals("")) searchCode = "";
     String keyWord  = request.getParameter("keyWord") == null ? "" : Util.getEUCKR((request.getParameter("keyWord")).trim());
     String keywordPrefix = "";
     if(keyWord == null || keyWord.trim().equals("")) { 
         keyWord = "";
     } else {
     }
     
     int fromRows = 0;
     int toRows = 0;
     String currentPage  = request.getParameter("currentPage") == null ? "" : (request.getParameter("currentPage")).trim();
     if(currentPage == null || currentPage.trim().equals("")) currentPage = "1";
  fromRows = ((Integer.parseInt(currentPage) - 1) * lines) + 1;
  toRows = fromRows + lines - 1;
  
  try {
   conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
   conn.createStatement(false);
   
   dbobject = new DBObject(conn.getConnection());
   
   
   // GET DETAIL;;
   StringBuffer sbSQL =  new StringBuffer();
   sbSQL.append(" SELECT a.RN,        ") 
         .append("   a.SEQ,        ")  
         .append("   a.REGIDATE,       ")   
         .append("   a.REGIR,       ")  
         .append("   a.RPTREGIR,       ")   
         .append("   a.TITLE,       ")  
         .append("   a.READNUM,       ")   
         .append("   a.QSTNSEQ,       ")  
         .append("   a.ANSRSEQ,       ")   
         .append("   a.DEPTH,       ")   
         .append("   a.FILES,       ")  
         .append("   (         ")  
         .append("   SELECT USERNAME     ")   
         .append("   FROM TBLUSER      ")  
         .append("   WHERE USERID = a.REGIR   ")  
         .append("   ) AS USERNAME      ")  
         .append(" FROM  (         ")   
         .append("   SELECT ROWNUM RN,     ")   
         .append("     a.SEQ,      ")   
         .append("     a.REGIDATE,     ")   
         .append("     a.REGIR,     ")   
         .append("     a.RPTREGIR,     ")   
         .append("     a.TITLE,     ")   
         .append("     a.READNUM,     ")   
         .append("     a.QSTNSEQ,     ")  
         .append("     a.ANSRSEQ,     ")   
         .append("     a.DEPTH,     ")   
         .append("     a.FILES      ")  
         .append("   FROM (       ")  
         .append("     SELECT  SEQ,   ")  
         .append("        REGIDATE,  ")  
         .append("        REGIR,   ")   
         .append("        RPTREGIR,  ")  
         .append("        TITLE,   ")  
         .append("        READNUM,  ")  
         .append("        QSTNSEQ,  ")  
         .append("        ANSRSEQ,  ")  
         .append("        DEPTH,   ")  
         .append("        FILES   ")  
         .append("     FROM   TBLEISBOARD  ")
         .append("     WHERE  1 = 1   ")
            .append("     AND   DIV_CD = ?  "); 
   if(keyWord.length()>0) {
    sbSQL.append("    AND ").append(searchCode).append(" LIKE '%' || ? || '%' ");
   }
   sbSQL.append("     ORDER BY QSTNSEQ DESC, ") 
         .append("        ANSRSEQ ASC  ") 
         .append("     ) a       ")
         .append("   ) a         ")
         .append(" WHERE a.RN BETWEEN ? AND ?    "); 
      
   if(keyWord.length()>0) {
    Object[] pmSQL = {div_cd,keyWord,String.valueOf(fromRows),String.valueOf(toRows)};
    rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);
   }else {
    Object[] pmSQL = {div_cd,String.valueOf(fromRows),String.valueOf(toRows)};
    rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);
   }
   DataSet ds = new DataSet();
   ds.load(rs);
   
   request.setAttribute("ds",ds);
   
   
   String pageList = getCommuPageList(dbobject, request, response, userId, div_cd);
   
   request.setAttribute("pageList",pageList);
   
   
   int totalNum = getCommuRecordCount(dbobject, request, response, userId, div_cd);
   request.setAttribute("totalNum",new Integer(totalNum));
   
  } catch (Exception e) {
   try{ conn.rollback(); } catch (Exception ex) {};
   System.out.println("setCommuBoardList : " + e);
  } finally {
   try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
   if (dbobject != null){dbobject.close(); dbobject = null;}
   if (conn != null) {conn.close(); conn = null;}
  } 
 }
 public void setCommuBoardRead(HttpServletRequest request, HttpServletResponse response, String userId, String div_cd, String seq) {
  CoolConnection conn = null;
  DBObject dbobject = null;
  ResultSet rs = null;
  
  try {
   conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
   conn.createStatement(false);
   
   dbobject = new DBObject(conn.getConnection());
   
   
   // GET DETAIL;;
   StringBuffer sbSQL =  new StringBuffer();
   sbSQL.append(" SELECT a.SEQ,        ")  
         .append("   a.REGIDATE,       ")   
         .append("   a.REGIR,       ")  
         .append("   a.RPTREGIR,       ")   
         .append("   a.TITLE,       ")  
         .append("   a.EMAIL,       ")  
         .append("   a.CONTENT,       ")  
         .append("   a.READNUM,       ")   
         .append("   a.QSTNSEQ,       ")  
         .append("   a.ANSRSEQ,       ")   
         .append("   a.DEPTH,       ")   
         .append("   a.FILEPATH,       ")  
         .append("   a.FILES,       ")  
         .append("   a.REGIR,       ")   
         .append("   (         ")  
         .append("   SELECT USERNAME     ")   
         .append("   FROM TBLUSER      ")  
         .append("   WHERE USERID = a.REGIR   ")  
         .append("   ) AS USERNAME,      ")  
         .append("   DECODE(        ")  
         .append("   (         ")  
         .append("   SELECT EMAIL      ")   
         .append("   FROM TBLUSER      ")  
         .append("   WHERE USERID = a.REGIR   ")  
         .append("   ),NULL,'',       ")  
         .append("   (         ")  
         .append("   SELECT EMAIL      ")   
         .append("   FROM TBLUSER      ")  
         .append("   WHERE USERID = a.REGIR   ")  
         .append("   )) AS USEREMAIL      ")
         .append(" FROM  TBLEISBOARD a      ")
         .append(" WHERE a.SEQ = ").append(seq);
      
   rs = dbobject.executeQuery(sbSQL.toString());   
   DataSet ds = new DataSet();
   ds.load(rs);
   
   StringBuffer sbS = new StringBuffer();
   sbS.append("UPDATE  TBLEISBOARD SET  ")
      .append(" READNUM = READNUM + 1 ")
      .append("WHERE SEQ = ?    ")
      .append("AND  DIV_CD = ?   ");
    
   Object[] pmS = {seq,div_cd};
   dbobject.executePreparedUpdate(sbS.toString(),pmS);
   
   request.setAttribute("ds",ds);
   
   conn.commit();
  } catch (Exception e) {
   try{ conn.rollback(); } catch (Exception ex) {};
   System.out.println("setCommuBoardRead : " + e);
  } finally {
   try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
   if (dbobject != null){dbobject.close(); dbobject = null;}
   if (conn != null) {conn.close(); conn = null;}
  } 
 }
 
 public int setCommuBoardReadNum(String div_cd, String seq) {
  CoolConnection conn = null;
  DBObject dbobject = null;
  int result = 0;
  try {
   conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
   conn.createStatement(false);
   
   dbobject = new DBObject(conn.getConnection());
   
   StringBuffer sbS = new StringBuffer();
   sbS.append("UPDATE  TBLEISBOARD SET  ")
      .append(" READNUM = READNUM + 1 ")
      .append("WHERE SEQ = ?    ")
      .append("AND  DIV_CD = ?   ");
    
   Object[] pmS = {seq,div_cd};
   result = dbobject.executePreparedUpdate(sbS.toString(),pmS);
   conn.commit();
   
  } catch (Exception e) {
   try{ conn.rollback(); } catch (Exception ex) {};
   System.out.println("setCommuBoardReadNum : " + e);
  } finally {
   if (dbobject != null){dbobject.close(); dbobject = null;}
   if (conn != null) {conn.close(); conn = null;}
  } 
  return result;
 }
 
 public String getCommuPageList(DBObject dbobject , HttpServletRequest request, HttpServletResponse response, String userId, String div_cd) {
  ResultSet rs = null;
  
  String result   ="";
  int recordCount  = 0;
  int postcount   = 0;
  int totpage   = 0;
  int startpagenum  = 0;
  
     String searchCode = request.getParameter("searchCode") == null ? "" : Util.getEUCKR((request.getParameter("searchCode")).trim());
     if(searchCode == null || searchCode.trim().equals("")) searchCode = "";
     String keyWord  = request.getParameter("keyWord") == null ? "" : Util.getEUCKR((request.getParameter("keyWord")).trim());
  String enKeyWord  = "";
     int lines   = Integer.parseInt(request.getParameter("lines") == null ? "15" : (request.getParameter("lines")).trim());
  int pages   = Integer.parseInt(request.getParameter("pages") == null ? "10" : (request.getParameter("pages")).trim());
     int currentPage  = Integer.parseInt(request.getParameter("currentPage") == null ? "1" : (request.getParameter("currentPage")).trim());
  
     String imgUri = request.getRequestURI();
  imgUri = imgUri.substring(1);
  imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
     
  String jspName  = request.getServletPath() == null ? "" : (request.getServletPath()).trim();
     int startPage  = Integer.parseInt(request.getParameter("startpage") == null ? "1" : (request.getParameter("startpage")).trim());
  
  if (keyWord != null) {
   enKeyWord = keyWord;
  }
  
  try{  
   // GET DETAIL;;
   StringBuffer sbSQL =  new StringBuffer();
   sbSQL.append(" SELECT COUNT(SEQ)  ")
        .append(" FROM  TBLEISBOARD ")
        .append(" WHERE  DIV_CD = '").append(div_cd).append("' ");
   if(keyWord.length()>0){
    sbSQL.append(" AND ").append(searchCode).append(" like '%' || '").append(keyWord).append("' || '%' ");
   }
   rs = dbobject.executeQuery(sbSQL.toString());   
   
   while(rs.next()){
    recordCount = rs.getInt(1);
   }
   /*
   DataSet ds = new DataSet();
   ds.load(rs);
   */
   
   postcount = recordCount;
   totpage= (postcount/lines);
   if( (totpage * lines) != postcount){
    totpage = totpage + 1;
   }
   startpagenum=(totpage/pages);
   
   if((startpagenum*pages) != totpage){
    startpagenum=startpagenum+1;
   }
   
   int lastpg=0, nextpg=0, prevpg=0, endpg=0, startpg=0;
   
   lastpg =1+((postcount-1)/lines);
   if( currentPage>lastpg ){
    currentPage=lastpg;
   }
   nextpg  = currentPage+1;
   prevpg  = currentPage-1;
   endpg  = currentPage*lines;
   startpg  = endpg-lines+1;
   if( currentPage==1) {
    result = "<img src='../images/arrow_first.gif' border=0 align='absmiddle'>";
   }else {
    result = "<a href='" + imgUri + jspName + "?currentPage=1&startpage=1&div_cd="+div_cd;
    if(keyWord.length() > 0) {
     result +="&keyWord="+keyWord+"&searchCode="+searchCode;
    }
    result +="'><img src='../images/arrow_first.gif' border=0 align='absmiddle'></a>";
   }
   result += "&nbsp;";
   
   if(totpage>pages){
    if(startPage==1){
    }else {
     result += "<a href='" + imgUri + jspName + "?currentPage="+(startPage-pages)+"&amp;startpage="+(startPage-pages)+"&amp;div_cd="+div_cd;
     if(!keyWord.equals("@#$%")){
      result +="&keyWord="+keyWord+"&searchCode="+searchCode;
     }
     result +="'>" + "<img src='../images/arrow_back.gif' border=0 align='absmiddle'></a>";
    }
   }
   result += "&nbsp;";
   int nextTenPagesStartingPoint = 0;
   for(int i=startPage ; i <= startPage+pages-1 ; i++){
    if(i > totpage) {
     break;
    }else if(i == currentPage) {
     result += "<b>[" + i +"]</b>";
    }else {
     result += "<a href='" + imgUri + jspName + "?currentPage="+i+"&amp;startpage="+startPage+"&div_cd="+div_cd;
     if(!keyWord.equals("@#$%")) {
      result +="&keyWord="+keyWord+"&searchCode="+searchCode;
      result +="'> ["+i+"] </a>";
     }
    }
    nextTenPagesStartingPoint = i+1;
   }
   result += "&nbsp;";  
   if(totpage>pages){
    if((startPage+pages) > lastpg){
    }else {
     result += "<a href='" + imgUri + jspName + "?currentPage="+nextTenPagesStartingPoint+"&amp;startpage="+nextTenPagesStartingPoint+"&div_cd="+div_cd;
     if(!keyWord.equals("@#$%")) {
      result +="&keyWord="+keyWord+"&searchCode="+searchCode;
      result+="'>" + "<img src='../images/arrow_next.gif' border=0 align='absmiddle'></a>";
     }
    }
   }
   result += "&nbsp;";  
   if( nextpg <= lastpg){
    result += "<a href='" + imgUri + jspName + "?currentPage="+totpage+"&startpage="+(pages*(startpagenum-1)+1)+"&div_cd="+div_cd;
    if(!keyWord.equals("@#$%")) {
     result +="&keyWord="+(keyWord)+"&searchCode="+searchCode;
     result +="'><img src='../images/arrow_last.gif' border=0 align='absmiddle'></a>";
    }
   }else {
    result += "<img src='../images/arrow_last.gif' border=0 align='absmiddle'>";     
   }
  } catch (Exception e) {
   System.out.println("getCommuPageList : " + e);
  } finally {
   try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
  } 
  return result;  
 }
 public int getCommuRecordCount(DBObject dbobject, HttpServletRequest request, HttpServletResponse response, String userId, String div_cd){
  ResultSet rs = null;
  
     String searchCode = request.getParameter("searchCode") == null ? "" : Util.getEUCKR((request.getParameter("searchCode")).trim());
     if(searchCode == null || searchCode.trim().equals("")) searchCode = "";
     String keyWord  = request.getParameter("keyWord") == null ? "" : Util.getEUCKR((request.getParameter("keyWord")).trim());
     String keywordPrefix = "";
  int maxValue = 0;
  
  try{  
   // GET DETAIL;;
   StringBuffer sbSQL =  new StringBuffer();
   sbSQL.append(" SELECT COUNT(SEQ) AS SEQ_NUM  ")
        .append(" FROM  TBLEISBOARD    ")
        .append(" WHERE  DIV_CD = '").append(div_cd).append("' ");
   if(keyWord.length()>0){
    sbSQL.append(" AND ").append(searchCode).append(" like '%' || '").append(keyWord).append("' || '%' ");
   }
   rs = dbobject.executeQuery(sbSQL.toString());   
   
   while(rs.next()){
    maxValue = rs.getInt(1);
   }
   DataSet ds = new DataSet();
   ds.load(rs);
  } catch (Exception e) {
   System.out.println("getCommuRecordCount : " + e);
  } finally {
   try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
  }
  
  return maxValue;  
 } 
 
 public String setCommuRecordSave (
         HttpServletRequest request, 
         HttpServletResponse response
         ) {
  CoolConnection conn = null;
  DBObject dbobject = null;
  String result = "";
     int child = 0;
     int nextDepth = 0;
  try {
   String type = request.getContentType()!=null?request.getContentType():"";
   String toDayTime = Util.getToDayTime();
   
   if (type.indexOf(";")>0) {
    int ik = type.indexOf(";"); 
    
    type = type.substring(0,ik);
   }
   
   if ("multipart/form-data".equals(type)) {
    int sizeLimit = 10 * 1024 * 1024; // 10M, 
    String UPLOADROOT = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"bsc_pdsfile"; // 
    String UPLOADPATH = UPLOADROOT + File.separator;
    
    //MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit,"euc-kr", new ByUserIdFileRenamePolicy(toDayTime)); //  
    MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit,"euc-kr", new DefaultFileRenamePolicy()); // 
    
    String fileChk    = multi.getParameter("fileChk") == null ? "" : multi.getParameter("div_cd").trim();
    String file;

    if(!fileChk.equals("")) {
     ArrayList filename     = new ArrayList();    
     Enumeration filenames  = multi.getFileNames();
     
     while(filenames.hasMoreElements())   {
	         String formName = (String)filenames.nextElement();
	         filename.add(multi.getFilesystemName(formName)); 
	         //filename.add(multi.getOriginalFileName(formName));
	     }
	     
	     file = (String)filename.get(0);

         System.out.println("formName   ===>   "+file);	     
    }else {
    	 file = null;
    }
    
    conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
    conn.createStatement(false);
    
    dbobject = new DBObject(conn.getConnection());
    
    String groupId  = (String)request.getSession().getAttribute("groupId");
    String userName = (String)request.getSession().getAttribute("userName");
    String userId   = (String)request.getSession().getAttribute("userId");
    
    String div_cd   = multi.getParameter("div_cd") == null ? "" : multi.getParameter("div_cd").trim();
    if (div_cd == null || div_cd.equals("null")) div_cd = "1";
    
    String tag     = multi.getParameter("tag");   // DBÃ³¸®
    String seq     = multi.getParameter("seq") == null ? "" : multi.getParameter("seq").trim();
    String title   = multi.getParameter("title");   // 
    String email   = multi.getParameter("email");   // 
    String content = multi.getParameter("content");  // 
    
    String currentPage = multi.getParameter("currentPage") == null ? "" : multi.getParameter("currentPage").trim();
    String qstnSeq     = multi.getParameter("qstnSeq")     == null ? "" : multi.getParameter("qstnSeq").trim();
    String ansrSeq     = multi.getParameter("ansrSeq")     == null ? "" : multi.getParameter("ansrSeq").trim();
    String depth       = multi.getParameter("depth")       == null ? "" : multi.getParameter("depth").trim();
    String keyWord     = multi.getParameter("keyWord")     == null ? "" : multi.getParameter("keyWord").trim();
    String searchCode  = multi.getParameter("searchCode")  == null ? "" : multi.getParameter("searchCode").trim();
    
    String tmpFileName = multi.getParameter("tmpFileName") == null ? "" : multi.getParameter("tmpFileName").trim();
//    String tmpFileName = file;
    System.out.println("tmpFileName   ===>   "+tmpFileName);
    
    String getDivCd   = "";
    if(div_cd.equals("")) {
    	getDivCd = "nullVal";
    }else {
    	getDivCd = div_cd;
    }
    String getSeq   = "";
    if(seq.equals("")) {
    	getSeq = "nullVal";
    }else {
    	getSeq = seq;
    }
    String getCurrentPage = "";
    if(currentPage.equals("")) {
    	getCurrentPage = "nullVal";
    }else {
    	getCurrentPage = currentPage;
    }
    String getKeyWord  = "";
    if(keyWord.equals("")) {
    	getKeyWord = "nullVal";
    }else {
    	getKeyWord = keyWord;
    }
    String getSearchCode = "";
    if(searchCode.equals("")) {
    	getSearchCode = "nullVal";
    }else {
    	getSearchCode = searchCode;
    }
        
    if ("C".equals(tag)) {
     StringBuffer sbS = new StringBuffer();
     sbS.append("INSERT INTO TBLEISBOARD (      ")
        .append(" SEQ,          ")
        .append(" QSTNSEQ,         ")
        .append(" ANSRSEQ,         ")
        .append(" TITLE,          ")
        .append(" EMAIL,          ")
        .append(" CONTENT,         ")
        .append(" DEPTH,          ")
        .append(" READNUM,         ")
        .append(" FILEPATH,         ");
     if(!(file == null)) {
      sbS.append(" FILES,         ");
     }
     sbS.append(" REGIR,          ")
        .append(" REGIDATE,         ")
        .append(" DIV_CD          ")
        .append(") VALUES (         ")
        .append(" DECODE (         ")
        .append("   (         ")
        .append("   SELECT MAX(SEQ)      ")
        .append("   FROM   TBLEISBOARD     ")
        .append("   ),NULL,0,       ")
        .append("   (         ")
        .append("   SELECT MAX(SEQ)      ")
        .append("   FROM   TBLEISBOARD     ")
        .append("   )         ")
        .append("   ) + 1,        ")   
        .append(" DECODE (         ")
        .append("   (         ")
        .append("   SELECT MAX(SEQ)      ")
        .append("   FROM   TBLEISBOARD     ")
        .append("   ),NULL,0,       ")
        .append("   (         ")
        .append("   SELECT MAX(SEQ)      ")
        .append("   FROM   TBLEISBOARD     ")
        .append("   )         ")
        .append("   ) + 1,        ")   
        .append(" 0,           ")
        .append(" ?,           ")
        .append(" ?,           ")
        .append(" ?,           ")
        .append(" 0,           ")
        .append(" 0,           ")
           .append(" ?,           ");
     if(!(file == null)) {
         sbS.append(" ?,          ");
     }
     sbS.append(" ?,           ")
        .append(" sysdate,         ")
        .append(" ?           ")
        .append(")            ");
          
     if(!(file == null)) {
    	 Object[] pmS = {title,email,content,UPLOADPATH,file,userId,div_cd};
     	 dbobject.executePreparedUpdate(sbS.toString(),pmS);
     }else {
    	 Object[] pmS = {title,email,content,UPLOADPATH,userId,div_cd};
    	 dbobject.executePreparedUpdate(sbS.toString(),pmS);
     }
     result = "C" + "@#@" + getDivCd + "@#@" + getSeq + "@#@" + getCurrentPage + "@#@" + getKeyWord + "@#@" + getSearchCode;
     
       
     conn.commit();
    }else if ("U".equals(tag)) {
     StringBuffer sbS = new StringBuffer();
     sbS.append("UPDATE TBLEISBOARD SET       ")
        .append(" TITLE = ?,         ")
        .append(" EMAIL = ?,         ")
        .append(" CONTENT = ?,        ");
     if(!(file == null)) {
    	sbS.append(" FILES = ?,        ");
     }
     sbS.append(" MODIR = ?,         ")
        .append(" MODIDATE = sysdate       ")
        .append("WHERE SEQ = ?         ")
        .append("AND DIV_CD = ?         ");
     
     if(file != null) {
      if(file.length() > 1) {
       if(!tmpFileName.equals("")) {
        File tmpfile = new File(UPLOADROOT +File.separator+ tmpFileName);
        if(tmpfile.exists()){
        	tmpfile.delete(); 
        }
       }
      }
     }
     
     if(!(file == null)) {
    	 System.out.println("File : " + file + " : " +tmpFileName );
    	 
      Object[] pmS = {title,email,content,file,userId,seq,div_cd};
      dbobject.executePreparedUpdate(sbS.toString(),pmS);
     }else {
      Object[] pmS = {title,email,content,userId,seq,div_cd};
      dbobject.executePreparedUpdate(sbS.toString(),pmS);
     }
     result = "U" + "@#@" + getDivCd + "@#@" + getSeq + "@#@" + getCurrentPage + "@#@" + getKeyWord + "@#@" + getSearchCode;
     conn.commit();
    } else if ("FD".equals(tag)){
      File tmpfile = new File(UPLOADROOT +File.separator+ tmpFileName);
      if(tmpfile.exists()){
       tmpfile.delete(); 
      }
     
     String strFD = "UPDATE TBLEISBOARD SET FILES=NULL WHERE SEQ=?";
     Object[] pmFD = {seq};
     dbobject.executePreparedUpdate(strFD,pmFD);
     result = "FD" + "@#@" + getDivCd + "@#@" + getSeq + "@#@" + getCurrentPage + "@#@" + getKeyWord + "@#@" + getSearchCode;
     conn.commit();
    }else if ("R".equals(tag)) {
     
     StringBuffer sbS = new StringBuffer();
     sbS.append("UPDATE TBLEISBOARD SET       ")
        .append(" ANSRSEQ = ANSRSEQ + 1      ")
        .append("WHERE QSTNSEQ = ?        ")
        .append("AND  ANSRSEQ > ?        ")
        .append("AND  DIV_CD = ?        ");
     
     //System.out.println(sbS);
     
     Object[] pmS = {qstnSeq,ansrSeq,div_cd};
     dbobject.executePreparedUpdate(sbS.toString(),pmS);
     conn.commit();
     
     ansrSeq = String.valueOf(Integer.parseInt(ansrSeq) + 1);
     depth = String.valueOf(Integer.parseInt(depth) + 1);
      
     StringBuffer sbI = new StringBuffer();
     sbI.append("INSERT INTO TBLEISBOARD (      ")
        .append(" SEQ,          ")
        .append(" QSTNSEQ,         ")
        .append(" ANSRSEQ,         ")
        .append(" TITLE,          ")
        .append(" EMAIL,          ")
        .append(" CONTENT,         ")
        .append(" DEPTH,          ")
        .append(" READNUM,         ")
        .append(" FILES,          ")
        .append(" REGIR,          ")
        .append(" REGIDATE,         ")
        .append(" DIV_CD          ")
        .append(") VALUES (         ")
        .append(" DECODE (         ")
        .append("   (         ")
        .append("   SELECT MAX(SEQ)      ")
        .append("   FROM   TBLEISBOARD     ")
        .append("   ),NULL,0,       ")
        .append("   (         ")
        .append("   SELECT MAX(SEQ)      ")
        .append("   FROM   TBLEISBOARD     ")
        .append("   )         ")
        .append("   ) + 1,        ")   
        .append(" ?,           ")   
        .append(" ?,           ")
        .append(" ?,           ")
        .append(" ?,           ")
        .append(" ?,           ")
        .append(" ?,           ")
        .append(" 0,           ")
        .append(" ?,           ")
        .append(" ?,           ")
        .append(" sysdate,          ")
        .append(" ?           ")
        .append(")            ");
     
     //System.out.println(sbI);
     
     
     Object[] pmI = {qstnSeq,ansrSeq,title,email,content,depth,file,userId,div_cd};
     dbobject.executePreparedUpdate(sbI.toString(),pmI);
     conn.commit();   
     result = "R" + "@#@" + getDivCd + "@#@" + getSeq + "@#@" + getCurrentPage + "@#@" + getKeyWord + "@#@" + getSearchCode;
     //System.out.println("result="+result);
    }
   }
  } catch (Exception e) {
   try{ conn.rollback(); } catch (Exception ex) {};
   System.out.println("setCommuRecordSave : " + e);
  } finally {
   if (dbobject != null){dbobject.close(); dbobject = null;}
   if (conn != null) {conn.close(); conn = null;}
  } 
  return result;
 }
 
 public int setCommuRecordDelete(HttpServletRequest request, HttpServletResponse response) {  
  CoolConnection conn = null;
  DBObject dbobject = null;
  int result = 0;
  try {
   String div_cd   = request.getParameter("div_cd") == null ? "" : (request.getParameter("div_cd").trim()); 
   String seq    = request.getParameter("seq") == null ? "" : (request.getParameter("seq").trim()); 
   String tmpFileName  = request.getParameter("tmpFileName") == null ? "" : Util.getEUCKR((request.getParameter("tmpFileName")).trim()); 
   String UPLOADROOT = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"bsc_pdsfile"; // 
   String UPLOADPATH = UPLOADROOT + File.separator;
   conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
   conn.createStatement(false);
   
   dbobject = new DBObject(conn.getConnection());
   
   StringBuffer sbS = new StringBuffer();
   sbS.append("DELETE  FROM TBLEISBOARD ")
      .append("WHERE SEQ = ?    ")
      .append("AND  DIV_CD = ?   ");
    
   Object[] pmS = {seq,div_cd};
   result = dbobject.executePreparedUpdate(sbS.toString(),pmS);
   conn.commit();
   if(!tmpFileName.equals("")) {
    File tmpfile = new File(UPLOADROOT +File.separator+ tmpFileName);
    if(tmpfile.exists()){
     tmpfile.delete(); 
    }
   }
  } catch (Exception e) {
   try{ conn.rollback(); } catch (Exception ex) {};
   System.out.println("setCommuRecordDelete : " + e);
  } finally {
   if (dbobject != null){dbobject.close(); dbobject = null;}
   if (conn != null) {conn.close(); conn = null;}
  } 
  return result;
 }
 public int getMaxDepth(String tableName, String qstnSeq, String ansrSeq){
  CoolConnection conn = null;
  DBObject dbobject = null;
  ResultSet rs = null;
  int maxValue = 1;
  
  try{  
   conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
   conn.createStatement(false);   
   dbobject = new DBObject(conn.getConnection());
   // GET DETAIL;;
   StringBuffer sbSQL =  new StringBuffer();
   sbSQL.append(" SELECT MAX(DEPTH) ")
      .append(" FROM ").append(tableName)
     .append(" WHERE QSTNSEQ = ").append(qstnSeq).append(" AND ANSRSEQ = ").append(ansrSeq);
   rs = dbobject.executeQuery(sbSQL.toString());   
   
   while(rs.next()){
    maxValue = rs.getInt(1);
   }
   DataSet ds = new DataSet();
   ds.load(rs);
  } catch (Exception e) {
   try{ conn.rollback(); } catch (Exception ex) {};
   System.out.println("getMaxDepth : " + e);
  } finally {
   try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
   if (dbobject != null){dbobject.close(); dbobject = null;}
   if (conn != null) {conn.close(); conn = null;}
  }
  
  return maxValue;  
 } 
 public int getNextDepth(String tableName, String qstnSeq, String ansrSeq, String depth){
  CoolConnection conn = null;
  DBObject dbobject = null;
  ResultSet rs = null;
  int maxValue = 1;
  
  try{  
   conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
   conn.createStatement(false);   
   dbobject = new DBObject(conn.getConnection());
   // GET DETAIL;;
   StringBuffer sbSQL =  new StringBuffer();
   sbSQL.append(" SELECT DEPTH ")
      .append(" FROM ").append(tableName)
     .append(" WHERE QSTNSEQ = ").append(qstnSeq).append(" AND ANSRSEQ = ").append(ansrSeq)
      .append(" AND  DEPTH > ").append(depth).append(" ORDER BY DEPTH ASC ");
   rs = dbobject.executeQuery(sbSQL.toString());   
   
   while(rs.next()){
    maxValue = rs.getInt(1);
   }
   DataSet ds = new DataSet();
   ds.load(rs);
  } catch (Exception e) {
   try{ conn.rollback(); } catch (Exception ex) {};
   System.out.println("getNextDepth : " + e);
  } finally {
   try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
   if (dbobject != null){dbobject.close(); dbobject = null;}
   if (conn != null) {conn.close(); conn = null;}
  }
  
  return maxValue;  
 } 
 
 public static int getRepHasChild(String tableName, String qstnSeq, String ansrSeq, int depth){
  CoolConnection conn = null;
  DBObject dbobject = null;
  ResultSet rs = null;
  int result = 0;
  try{  
   conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
   conn.createStatement(false);   
   dbobject = new DBObject(conn.getConnection());
   
   StringBuffer sbSQL =  new StringBuffer();
   sbSQL.append(" SELECT  COUNT(SEQ) ")
     .append(" FROM  ").append(tableName)
     .append(" WHERE QSTNSEQ = ").append(qstnSeq)
     .append(" AND   ANSRSEQ = ").append(Integer.parseInt(ansrSeq)+1)
     .append(" AND   depth = ").append(depth+1);
   rs = dbobject.executeQuery(sbSQL.toString());   
   
   while(rs.next()){
    result = rs.getInt(1);
   }
  } catch (Exception e) {
   try{ conn.rollback(); } catch (Exception ex) {};
   System.out.println("getRepHasChild : " + e);
  } finally {
   try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
   if (dbobject != null){dbobject.close(); dbobject = null;}
   if (conn != null) {conn.close(); conn = null;}
  }
  return result;  
 }
 
 public static int getOverLine(String tableName, String qstnSeq, String ansrSeq, String start,int end){
  CoolConnection conn = null;
  DBObject dbobject = null;
  ResultSet rs = null;
  int maxValue = 0;
  try{  
   conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
   conn.createStatement(false);   
   dbobject = new DBObject(conn.getConnection());
   
   StringBuffer sbSQL =  new StringBuffer();
   
   sbSQL.append(" SELECT  DEPTH ")
     .append(" FROM  ").append(tableName)
     .append(" WHERE  QSTNSEQ = ").append(qstnSeq)
     .append(" AND   ANSRSEQ < ").append(ansrSeq)
     .append(" AND   DEPTH BETWEEN ").append(start).append(" AND ").append(end)
     .append(" ORDER BY DEPTH ASC ");
   rs = dbobject.executeQuery(sbSQL.toString());   
   
   if(rs.next()){
    maxValue = rs.getInt(1);
   }
  } catch (Exception e) {
   try{ conn.rollback(); } catch (Exception ex) {};
   System.out.println("getRepHasChild : " + e);
  } finally {
   try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
   if (dbobject != null){dbobject.close(); dbobject = null;}
   if (conn != null) {conn.close(); conn = null;}
  }
  return maxValue;  
 }
 public int setPlusDepth(String tableName, String qstnSeq, String depth){
  CoolConnection conn = null;
  DBObject dbobject = null;
  int result = 0;
  try{  
   conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
   conn.createStatement(false);   
   dbobject = new DBObject(conn.getConnection());
   
   StringBuffer sbSQL =  new StringBuffer();
   
   sbSQL.append("UPDATE  ").append(tableName).append(" SET  ")
     .append("  DEPTH = DEPTH+1       ")
     .append("WHERE  QSTNSEQ = ?       ")
     .append("AND   DEPTH >= ?       ");
   
   Object[] pmS = {qstnSeq,depth};
   result = dbobject.executePreparedUpdate(sbSQL.toString(),pmS);
   conn.commit();
  } catch (Exception e) {
   try{ conn.rollback(); } catch (Exception ex) {};
   System.out.println("setPlusDepth : " + e);
  } finally {
   if (dbobject != null){dbobject.close(); dbobject = null;}
   if (conn != null) {conn.close(); conn = null;}
  } 
  return result;
 }
 
 
 
 /*
  * ETL
  */
 public DataSet getETL(String sETLKey, String sItemCode)
 {
  DataSet ds1 = null;
  String sql = "";
  
  sql = "SELECT z1.etlkey, z1.itemcode, z1.frequency, z1.paramremk, z1.remk, z1.sql, z1.useyn  \n"
   + "   , (SELECT deptname FROM tblorganization WHERE deptcode=z1.deptcode) deptname  \n"
   + "   , (SELECT name FROM tblmeasurepool WHERE id=z1.contentid ) contentname        \n"
   + "   , (SELECT itemname FROM tblmeasureitem WHERE measureid=z1.contentid AND itemcode=z1.itemcode ) itemname  \n"
   + " FROM  \n" 
   + " (     \n"
   + "  SELECT a.etlkey, a.itemcode, a.paramremk, a.remk, a.sql, a.useyn  \n"
   + "    , (SELECT max(frequency)  FROM tblmeasuredefine WHERE etlkey=a.etlkey ) frequency  \n"
   + "    , (SELECT max(contentid)  FROM tbltreescore  WHERE treecls='BSC_ALIAS' AND  measuredefineid=(SELECT MAX(id)  FROM tblmeasuredefine WHERE etlkey=a.etlkey) ) contentid  \n"
   + "    , (SELECT max(deptcode)  FROM tbltreescore  WHERE treecls='BSC_ALIAS' AND  measuredefineid=(SELECT MAX(id)  FROM tblmeasuredefine WHERE etlkey=a.etlkey) ) deptcode    \n"     
   + "  FROM tbletlsql a                       \n"
   + "  Where etlkey = '" + sETLKey + "'       \n"
   + "      AND itemcode = '" + sItemCode + "' \n"
   + "  ) z1                                   \n"
   ;
  
  return ds1;  
 }
 /*
  * ETL rundate
  */
 public DataSet getETLRunDate(String sETLKey, String sItemCode)
 {
  DataSet ds1 = null;
  String sql = "";
  String sYYYY = Util.getToDay().substring(0,4);
  
  for(int i=0 ; i<24 ; i++)
  {
   if(i >= 1){ sql += "\n union \n"; }
   sql += "SELECT TO_CHAR(ADD_MONTHS('" + sYYYY + "-01-01'," + i + "),'yyyymm')  rundate   , (SELECT COUNT(*) FROM TBLETLRUNDATE WHERE etlkey='" + sETLKey + "'  AND itemcode='" + sItemCode + "' AND rundate=TO_CHAR(ADD_MONTHS('" + sYYYY + "-01-01'," + i + "),'yyyymm'))  cnt  FROM dual  \n";
  }
  sql += " order by rundate \n";
  
  return ds1;  
 }
 
 /*
  * ETL param
  */
 public DataSet getETLParam(String sETLKey, String sItemCode)
 {
  DataSet ds1 = null;
  String sql = "";
  
  sql = "SELECT param, val  FROM TBLETLPARAM  \n"
   + " WHERE etlkey='" + sETLKey + "'      \n"
   + "   AND itemcode='" + sItemCode + "'  \n"
   + " ORDER BY param                      \n"
   ;
  
  return ds1;  
 }
 public int setETLDel(String sETLKey, String sItemCode)
 {
  int ret = 0;
  String sql = "";
  try{
   sql = "Delete From tbletlsql Where etlkey='" + sETLKey + "' and itemcode='" + sItemCode + "' ";
   if(ret<=0){
    return -1;
   }
   
   sql = "Delete From tbletlrundate Where etlkey='" + sETLKey + "' and itemcode='" + sItemCode + "' ";
   if(ret<0){
    return -1;
   }
   
   sql = "Delete From tbletlparam Where etlkey='" + sETLKey + "' and itemcode='" + sItemCode + "' ";
   if(ret<0){
    return -1;
   }
   
   
  }catch(Exception e){
   return -1;
  }
  
  return ret;
 }
 
 
}
