package com.nc.cool;

import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.cool.Log;


public class LoginUtil {
    
    public void doAction(HttpServletRequest request, HttpServletResponse response){
        String userId = request.getParameter("userId");
        String passwd = request.getParameter("passwd");
        String flag   = request.getParameter("flag");
         
        if (userId !=null){ 
            CoolConnection conn = null;
            DBObject dbobject = null;
            ResultSet rs = null;
            Object[] params = null;
            try {
                StringBuffer sb = new StringBuffer();
                
                // 사용자 전환에 의한 처리... 
                if(userId.equals("admin")){
                    sb.append("SELECT USERID,USERNAME,NVL(DEPT_CD,'') DEPTCD, f_HrDeptNm(dept_cd) DEPTNM, GROUPID,AUTH01,DIVCODE,APPRAISER, F_PASSWD('D',PASSWORD) InPass, '' OtPass  FROM TBLUSER WHERE USERID=? ");
                    params = new Object[] {userId};
                }else if("Y".equals(flag)){
                    sb.append("SELECT USERID,USERNAME,NVL(DEPT_CD,'') DEPTCD, f_HrDeptNm(dept_cd) DEPTNM, GROUPID,AUTH01,DIVCODE,APPRAISER, F_PASSWD('D',PASSWORD) InPass, '' OtPass  FROM TBLUSER WHERE USERID=? ");
                    params = new Object[] {userId};
                }else {
                    sb.append("SELECT USERID,USERNAME,NVL(DEPT_CD,'') DEPTCD, f_HrDeptNm(dept_cd) DEPTNM, GROUPID,AUTH01,DIVCODE,APPRAISER, F_PASSWD('D',PASSWORD) InPass, ? OtPass FROM TBLUSER WHERE USERID=? AND F_PASSWD('D',PASSWORD) = ? ");
                    params = new Object[] {passwd, userId, passwd}; 
                }           
                
                conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
                conn.createStatement(false);
                
                dbobject = new DBObject(conn.getConnection());
                rs = dbobject.executePreparedQuery(sb.toString(),params);
                
                Log.debug("login: "+userId+"/"+passwd + "/" + flag + "\n" + sb.toString());             
                
                if (rs.next()) {
                    String userName  = rs.getString("USERNAME");
                    String groupId   = String.valueOf(rs.getInt("GROUPID"));
                                        
                    String deptCd    = rs.getString("DEPTCD");
                    String deptNm    = "".equals(rs.getString("DEPTNM"))||"null".equals(rs.getString("DEPTNM"))?"":rs.getString("DEPTNM");
                    String divcode   = String.valueOf(rs.getInt("DIVCODE"));
                    String auth01    = String.valueOf(rs.getInt("AUTH01"));
                    String appraiser = String.valueOf(rs.getInt("APPRAISER"));
                    
                    String groupNm   = "";

                    if ("3".equals(groupId)) groupNm = "성과담당자";
                    if ("5".equals(groupId)) groupNm = "일반사용자";
                    
                    if ("1".equals(appraiser)) groupNm = "평가자";     // 레벨이 그런가...
                    
                    if ("1".equals(groupId))   groupNm = "관리자";
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("userId"   , userId   );
                    session.setAttribute("userName" , userName );
                    session.setAttribute("groupId"  , groupId  );
                    session.setAttribute("groupNm"  , groupNm  );
                    session.setAttribute("deptCd"   , deptCd   );
                    session.setAttribute("deptNm"   , deptNm   );
                    session.setAttribute("auth01"   , auth01   );
                    session.setAttribute("divcode"  , divcode  );
                    session.setAttribute("appraiser", appraiser);
                    
                    Log.info("=========================================================");
                    Log.info("User Info  : " + userName + " (" +  userId + ")");
                    Log.info("User Dept  : " + deptCd + ":" + deptNm);
                    Log.info("User Bsc   : " + divcode );
                    Log.info("User Auth  : Group - " + groupId + ", Evaler - " + appraiser );
                    Log.info("=========================================================");
                    
                    request.setAttribute("tag","true");
                } else {
                    request.setAttribute("tag","false");
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
    
    public void doActionSLO(HttpServletRequest request, HttpServletResponse response){
        String userId = (String)request.getSession().getAttribute("loginUserId");
        String flag   = (String)request.getSession().getAttribute("loginFlag");
         
        if (userId !=null){ 
            CoolConnection conn = null;
            DBObject dbobject = null;
            ResultSet rs = null;
            Object[] params = null;
            try {
                StringBuffer sb = new StringBuffer();
                
                // 사용자 전환에 의한 처리... 
                sb.append("SELECT USERID,USERNAME,NVL(DEPT_CD,'') DEPTCD, f_HrDeptNm(dept_cd) DEPTNM, GROUPID,AUTH01,DIVCODE,APPRAISER, F_PASSWD('D',PASSWORD) InPass, '' OtPass  FROM TBLUSER WHERE USERID=? ");
                params = new Object[] {userId};
                
                conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
                conn.createStatement(false);
                
                dbobject = new DBObject(conn.getConnection());
                rs = dbobject.executePreparedQuery(sb.toString(),params);
                
                Log.debug("login: "+userId+"/"+ flag + "\n" + sb.toString());               
                
                if (rs.next()) {
                    String userName  = rs.getString("USERNAME");
                    String groupId   = String.valueOf(rs.getInt("GROUPID"));
                                        
                    String deptCd    = rs.getString("DEPTCD");
                    String deptNm    = "".equals(rs.getString("DEPTNM"))||"null".equals(rs.getString("DEPTNM"))?"":rs.getString("DEPTNM");
                    String divcode   = String.valueOf(rs.getInt("DIVCODE"));
                    String auth01    = String.valueOf(rs.getInt("AUTH01"));
                    String appraiser = String.valueOf(rs.getInt("APPRAISER"));
                    
                    String groupNm   = "";

                    if ("3".equals(groupId)) groupNm = "성과담당자";
                    if ("5".equals(groupId)) groupNm = "일반사용자";
                    
                    if ("1".equals(appraiser)) groupNm = "평가자";     // 레벨이 그런가...
                    
                    if ("1".equals(groupId))   groupNm = "관리자";
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("userId"   , userId   );
                    session.setAttribute("userName" , userName );
                    session.setAttribute("groupId"  , groupId  );
                    session.setAttribute("groupNm"  , groupNm  );
                    session.setAttribute("deptCd"   , deptCd   );
                    session.setAttribute("deptNm"   , deptNm   );
                    session.setAttribute("auth01"   , auth01   );
                    session.setAttribute("divcode"  , divcode  );
                    session.setAttribute("appraiser", appraiser);
                    
                    Log.info("=========================================================");
                    Log.info("User Info  : " + userName + " (" +  userId + ")");
                    Log.info("User Dept  : " + deptCd + ":" + deptNm);
                    Log.info("User Bsc   : " + divcode );
                    Log.info("User Auth  : Group - " + groupId + ", Evaler - " + appraiser );
                    Log.info("=========================================================");
                    
                    request.setAttribute("tag","true");
                } else {
                    request.setAttribute("tag","false");
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
    
    
    public void chack_pass(HttpServletRequest request, HttpServletResponse response){

        HttpSession session = request.getSession();//세션 함수 생성 
        String userId = (String)session.getAttribute("userId");
        String passwd = request.getParameter("passwd");
        
        System.out.println("java_pass : "+passwd);

        if (userId !=null){ 
            CoolConnection conn = null;
            DBObject dbobject = null;
            ResultSet rs = null;
            Object[] params = null;
            try {
                StringBuffer sb = new StringBuffer();


                sb.append("SELECT USERID,USERNAME,GROUPID,AUTH01,DIVCODE,APPRAISER, F_PASSWD('D',PASSWORD) InPass, ? OtPass FROM TBLUSER WHERE USERID=? AND F_PASSWD('D',PASSWORD) = ? ");
                params = new Object[] {passwd, userId, passwd}; 

                
                conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
                conn.createStatement(false);
                
                dbobject = new DBObject(conn.getConnection());
                System.out.println(sb.toString());
                rs = dbobject.executePreparedQuery(sb.toString(),params);
                
                if (rs.next()) {
                    request.setAttribute("chack","true");
                } else {
                    request.setAttribute("chack","false");
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


    
    public void pass_change(HttpServletRequest request, HttpServletResponse response){
        
        HttpSession session = request.getSession();//세션 함수 생성 
        
        String userId = (String)session.getAttribute("userId");
        String passwd = request.getParameter("passwd");
        String npass  = request.getParameter("npass");
        String cnpass = request.getParameter("cnpass");
    

        
        if (userId !=null){ 
            CoolConnection conn = null;
            DBObject dbobject = null;
            ResultSet rs = null;
            Object[] params = null;
            try {
                
                System.out.println("java_userId :" + userId);
                System.out.println("java_pass   :" + passwd);
                System.out.println("java_npass  :" + npass);
                System.out.println("java_cnpass :" + cnpass);
                
                String str ="update tbluser set PASSWORD = F_PASSWD('E',?) where userid = ?";
                params = new Object[] {npass,userId};
                
                conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
                conn.createStatement(false);
                dbobject = new DBObject(conn.getConnection());
                dbobject.executePreparedUpdate(str, params);
                
                
                
                
                //System.out.println("str :"+str);
                
                
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
    
    public void pass_find(HttpServletRequest request, HttpServletResponse response){
        String userId = request.getParameter("find_pass");
        if (userId !=null){
            CoolConnection conn = null;
            DBObject dbobject = null;
            ResultSet rs = null;
            Object[] params = null;
            try {
                
                System.out.println("java_userId :" + userId);

                String str ="update tbluser set PASSWORD = F_PASSWD('E','kopec') where userid = ?";
                params = new Object[] {userId};
                
                conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
                conn.createStatement(false);
                dbobject = new DBObject(conn.getConnection());
                dbobject.executePreparedUpdate(str, params);

                System.out.println("str :"+str);
                
                
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
    
    public void doActionSimga(HttpServletRequest request, HttpServletResponse response){
        String userId = request.getParameter("userId");
        if (userId !=null){
            CoolConnection conn = null;
            DBObject dbobject = null;
            ResultSet rs = null;
            try {
                StringBuffer sb = new StringBuffer();
                sb.append("select id, username, name, groupid, authsrc from c_user where username=?");
                Object[] params = {userId};
                
                conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
                conn.createStatement(false);
                
                dbobject = new DBObject(conn.getConnection());
                
                rs = dbobject.executePreparedQuery(sb.toString(),params);
                
                if (rs.next()) {
                    String id = String.valueOf(rs.getInt("id"));
                    String userName = rs.getString("name");
                    String userGroup = String.valueOf(rs.getInt("groupid"));
                    String bcid = String.valueOf(rs.getInt("authsrc"));
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("id", id);
                    session.setAttribute("userId", userId);
                    session.setAttribute("userName", userName);
                    session.setAttribute("userGroup", userGroup);
                    session.setAttribute("bcid",bcid);
                    
                    request.setAttribute("tag","true");
                    
                    String etlkey = request.getParameter("etlkey")!=null?request.getParameter("etlkey"):"";
                    String strDate = request.getParameter("strDate")!=null?request.getParameter("strDate"):"";
                    
                    String s = "select t.id from a_measure a, viewscorecard t where a.id=t.contentid and t.treelevel=5 and t.yyyy=? and a.etlkey=?";
                    Object[] p = new Object[]{strDate.substring(0,4),etlkey};
                    if (rs != null) { rs.close(); rs = null;}
                    rs = dbobject.executePreparedQuery(s,p);
                    
                    if (rs.next()){
                        request.setAttribute("mid", String.valueOf(rs.getInt("id")));
                    }
                } else {
                    request.setAttribute("tag","false");
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
}
