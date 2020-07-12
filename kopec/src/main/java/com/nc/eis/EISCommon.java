package com.nc.eis;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.*;

public class EISCommon {
	
    /**
     * Method Name : getComCode
     * Description	  : 코드 List를 구함.
     * Author		      : PHG
     * Create Date	  : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 
	public void getComCode(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			String ldiv_cd = request.getParameter("ldiv_cd");
			// REAL SERVER 
			String div_nm = request.getParameter("div_nm")==null?"%":(request.getParameter("div_nm")) ;
			// MY PC
			//String div_nm = request.getParameter("div_nm")==null?"%":Util.getUTF(request.getParameter("div_nm")) ;
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			 
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
            sbSQL.append(" select nvl(a.ldiv_cd,'') ldiv_cd,  \n")             
			          .append("        nvl(a.sdiv_cd,'') div_cd,  \n") 
		              .append("        nvl(a.div_nm ,'') div_nm,  \n") 
		              .append("        nvl(a.div_snm ,'') div_snm,  \n")
		              .append("        nvl(a.mng1 ,'') mng1,  \n") 
		              .append("        nvl(a.mng2 ,'') mng2  \n")
		              .append(" from   tz_comcode a        \n")
		              .append(" where  a.ldiv_cd = ?            \n")
		              .append(" and    a.div_nm like '%'||?||'%'     \n") 		              
		              .append(" and    a.use_yn  = 'Y'            \n") 
		              .append(" order by a.ord, a.sdiv_cd         \n");

			//System.out.println(sbSQL);

			Object[] pmSQL =  {ldiv_cd, div_nm};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getComCode : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}//-- method getComCode
	
    /**
     * Method Name : setComCode
     * Description	  : 공통코드 등록, 수정
     * Author		      : PHG
     * Create Date	  : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 	
	public void setComCode(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null)
				dbobject = new DBObject(conn.getConnection());
			
			StringBuffer strSQL = new StringBuffer();			
			
			// Loop를 돌며 Insert,Update,Delete...
			String ldiv_cd = request.getParameter("ldiv_cd");
			String sdiv_cd = request.getParameter("sdiv_cd");			
			String userid = (String)request.getSession().getAttribute("userId");

			String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			if ("D".equals(tag)){
					
					strSQL.append(" ");
					strSQL.append("delete  tz_comcode  ");
					strSQL.append("where ldiv_cd =? ");
					strSQL.append("and     sdiv_cd =?||'%' ");					
					
					Object[] iPa = { ldiv_cd, sdiv_cd };
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");				
					
			}else{
			// Insert or Update...처리.						

				String amId = request.getParameter("amId");   // ???
				String[] mIds = amId.split("\\|");
				
				for (int i = 0; i < mIds.length; i++) {					
					
							String div_nm = request.getParameter("div_nm");
							String div_snm  = request.getParameter("div_snm")== null ? "" : (request.getParameter("div_snm")).trim();		
							String mng1  = request.getParameter("mng1")== null ? "" : (request.getParameter("mng1")).trim();				
							String mng2  = request.getParameter("mng2")== null ? "" : (request.getParameter("mng2")).trim();										
							String ord    = request.getParameter("ord") == null ? "1" : (request.getParameter("ord")).trim();			
							String use_yn  = request.getParameter("use_yn") == null ? "Y" : (request.getParameter("use_yn")).trim();			
							
							strSQL.append(" ");
							strSQL.append("select 1 from tz_comcode where  ldiv_cd = ? and sdiv_cd = ? ") ;
			
							Object[] dPaD = {ldiv_cd, sdiv_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);
														
							strSQL.append(" ");
							
							// Update
							if(ds.getRowCount() != 0)
							{
									strSQL.append("update tz_comcode  ");
									strSQL.append("      set div_nm = ?  ") ;
									strSQL.append("          , div_snm = ?  ") ;
									strSQL.append("          , mng1 = ?  ") ;			
									strSQL.append("          , mng2 = ?  ") ;
									strSQL.append("          , ord = ?  ") ;
									strSQL.append("          , use_yn = ?  ") ;
									strSQL.append("          , upd_userid = ?  ") ;
									strSQL.append("          , upd_date = sysdate  ") ;				
									strSQL.append("where ldiv_cd =? ");
									strSQL.append("and     sdiv_cd    = ? ");
									
									Object[] iPa = { div_nm, div_snm, mng1, mng2, ord, use_yn, userid, ldiv_cd, sdiv_cd};
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							
							// Insert 처리. 
							} else	{
									strSQL.append(" insert into tz_comcode (  ") ;
									strSQL.append(" (   ldiv_cd, sdiv_cd, div_nm,   div_snm, mng1, mng2,  ord, use_yn, inp_date, inp_userid, upd_date, upd_userid)   ") ;
									strSQL.append("  values ");
									strSQL.append(" (? ,?, ?, ?, ?, ?, ?, ?, sysdate, ?, sysdate, ?);" );
			
									Object[] iPa = {ldiv_cd, sdiv_cd, div_nm,   div_snm, mng1, mng2,  ord, use_yn, userid, userid};
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							}					
							
				}	// Loop End.
				
			} // if ~ end.			
			
			
		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			request.setAttribute("result","false");
			System.out.println(se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			request.setAttribute("result","false");
			System.out.println(e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}
	} //-- method setComCode	
	
}

