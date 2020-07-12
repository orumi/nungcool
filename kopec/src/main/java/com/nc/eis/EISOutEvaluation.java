package com.nc.eis;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;

public class EISOutEvaluation {
	
    /**
     * Method Name : getEisEvalOrg
     * Description	  : 특정년도의 평가기관별 장려금지급, 사장성과급, 순위 등을 조회
     * Author		      : PHG
     * Create Date	  : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 
	public void getEisEvalOrg(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
				
		try {
			String eval_year = request.getParameter("eval_year");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
            sbSQL.append(" select nvl(a.sdiv_cd,'') org_cd,  \n") 
		              .append("        nvl(a.div_nm ,'') org_nm,  \n") 
		              .append("        b.emp_bonus     ,          \n") 
		              .append("        b.chief_bonus   ,          \n") 
		              .append("        b.eval_rank     ,          \n") 
		              .append("        b.eval_score    ,          \n") 
		              .append("        b.qty_meas      ,          \n") 
		              .append("        b.qly_meas                 \n") 
		              .append(" from   tz_comcode a,              \n") 
		              .append("        tg_evalorg b               \n") 
		              .append(" where  a.ldiv_cd = 'G01'          \n") 
		              .append(" and    a.use_yn  = 'Y'            \n") 
		              .append(" and    a.sdiv_cd = b.org_cd (+)   \n") 
		              .append(" and    b.eval_year(+) = ?         \n") 
		              .append(" order by a.ord, a.sdiv_cd         \n");

			//System.out.println(eval_year);
			//System.out.println(sbSQL);

			Object[] pmSQL =  {eval_year};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getGraphManCnt : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}//-- method getEisEvalOrg
	
	
    /**
     * Method Name : setEisEvalOrg
     * Description	  : 특정년도의 평가기관별 장려금지급, 사장성과급, 순위 등을 등록
     * Author		      : PHG
     * Create Date	  : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 	
	public void setEisEvalOrg(HttpServletRequest request, HttpServletResponse response){

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
			String eval_year = request.getParameter("eval_year");
			String userid = (String)request.getSession().getAttribute("userId");

			String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			// 전체 삭제...
			if ("D".equals(tag)){
					
					strSQL.append(" ");
					strSQL.append("delete  tg_evalorg  ");
					strSQL.append("where eval_year =? ");
					
					Object[] iPa = { eval_year};
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");				
			
			// 실적만 NULL처리		
			}else if ("D0".equals(tag)) {
				
					strSQL.append(" update  tg_evalorg set                               ");
					strSQL.append("         emp_bonus   =null,                            ");
					strSQL.append("         chief_bonus = null,                            ");
					strSQL.append("         eval_rank  = null,                            ");
					strSQL.append("         eval_score   = null,                             ");
					strSQL.append("         qty_meas = null  ,                             ") ;			
					strSQL.append("         qly_meas = null                                 ") ;						
					strSQL.append("  where  eval_year   = ?                              ");
					
					Object[] iPa = { eval_year};
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");		
			
			// Insert or Update....		
			} else {	
			// Insert or Update...처리.						

				String amld = request.getParameter("amld");   // ???
				String[] mIds = amld.split("`");
				
//			    System.out.println("========================" + amld);

				
				for (int i = 0; i < mIds.length; i++) {					

							String[] iPart = mIds[i].split(",");			
							
//							System.out.println("==============aaaa==========" + iPart);
							
							String org_cd          = iPart[0];
							String emp_bonus  = iPart[1].equals("")?"": iPart[1];
							String chief_bonus  = iPart[2].equals("")?"": iPart[2];
							String eval_rank       = iPart[3].equals("")?"": iPart[3];
							String eval_score    = iPart[4].equals("")?"": iPart[4];	
							String qty_meas       = iPart[5].equals("")?"": iPart[5];
							String qly_meas       = iPart[6].equals("")?"": iPart[6];	
														
//							System.out.println(" org_cd      = " + iPart[0]);
//							System.out.println(" emp_bonus   = " + iPart[1]);
//							System.out.println(" chief_bonus = " + iPart[2]);
//							System.out.println(" eval_rank   = " + iPart[3]);
//							System.out.println(" eval_score  = " + iPart[4]);
//							System.out.println(" qty_meas    = " + iPart[5]);
//							System.out.println(" qly_meas    = " + iPart[6]);
							
							
							strSQL = new StringBuffer();	
							strSQL.append("select 1 from tg_evalorg where  eval_year = ? and org_cd = ? ") ;
			
							Object[] dPaD = {eval_year, org_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);
														
							
							// Update
							if(ds.getRowCount() != 0)
							{
								    strSQL = new StringBuffer();	
								    strSQL.append(" update tg_evalorg  ");
									strSQL.append("       set emp_bonus = ?  ") ;
									strSQL.append("           , chief_bonus = ?  ") ;
									strSQL.append("           , eval_rank = ?  ") ;			
									strSQL.append("           , eval_score = ?  ") ;
									strSQL.append("           , qty_meas = ?  ") ;			
									strSQL.append("           , qly_meas = ?  ") ;									
									strSQL.append("           , upd_userid = ?  ") ;
									strSQL.append("           , upd_date = sysdate  ") ;				
									strSQL.append(" where eval_year =? ");
									strSQL.append(" and     org_cd    = ? ");
									
									Object[] iPa = { emp_bonus, 
												              chief_bonus, 
												              eval_rank, 
												              eval_score, 
												              qty_meas,
												              qly_meas,
												              userid, 
												              eval_year, 
												              org_cd};
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							
							// Insert 처리. 
							} else	{
								System.out.println("Insert .... " + org_cd);
								    
								    strSQL = new StringBuffer();	
									strSQL.append(" insert into tg_evalorg (  ") ;
									strSQL.append("  eval_year, org_cd, emp_bonus, chief_bonus, eval_rank, eval_score, qty_meas, qly_meas, inp_date, inp_userid, upd_date, upd_userid )  ") ;
									strSQL.append("  values ");
									strSQL.append(" (? ,?, ?, ?, ?, ?,?, ?, sysdate, ?, sysdate, ?)" );
			
									Object[] iPa = {eval_year, org_cd, emp_bonus, chief_bonus, eval_rank, eval_score, qty_meas, qly_meas, userid, userid};
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
	} //-- method setEvalOrg
		

    /**
     * Method Name : getEisEvalOrgMeas
     * Description	  : 특정년도의 평가기관의 지표을 조회
     * Author		      : PHG
     * Create Date	  : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 
	public void getEisEvalOrgMeas(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			String eval_year = request.getParameter("eval_year");
			String org_cd = request.getParameter("org_cd");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append("  select                                              ");
			sbSQL.append("         org_cd      ,                                ");
			sbSQL.append("         f_getcodenm('G01',org_cd) org_nm,            ");
			sbSQL.append("  	      meas_cd     ,                                ");
			sbSQL.append("  	      f_getcodenm('G04',meas_cd) meas_nm,          ");
			sbSQL.append("         meas_grp_cd ,                                ");
			sbSQL.append("  	      f_getcodenm('G03',meas_grp_cd) meas_grp_nm,  ");
			sbSQL.append("         meas_div_cd ,                                ");
			sbSQL.append("  	      f_getcodenm('G02',meas_div_cd) meas_div_nm,  ");
			sbSQL.append("         weight      ,                                ");
			sbSQL.append("         disp_ord    ,                                ");
			sbSQL.append("         eval_grade  ,                                ");
			sbSQL.append("         actual_value,                                ");
			sbSQL.append("         grade_score ,                                ");
			sbSQL.append("         eval_score                                   ");
			sbSQL.append("  from   tg_evalorgmeas                               ");
			sbSQL.append("  where  eval_year   = ?                         ");
			sbSQL.append("  and    org_cd   like ?||'%'                            ");
			sbSQL.append("  order by org_cd,meas_div_cd desc, disp_ord,  meas_grp_cd, meas_cd     ");

			//System.out.println(sbSQL);

			Object[] pmSQL =  {eval_year, org_cd};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getEisEvalOrgMeas : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}//-- method getEisEvalOrgMeas
	
	  /**
     * Method Name : setEisEvalOrgMeas
     * Description	  : 특정년도의 평가기관별 지표 등록
     * Author		      : PHG
     * Create Date	  : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 	
	public void setEisEvalOrgMeas(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null)
				dbobject = new DBObject(conn.getConnection());
			
			StringBuffer strSQL = new StringBuffer();			
			

			String eval_year = request.getParameter("eval_year");
			String org_cd     = request.getParameter("org_cd");
			String meas_cd  = request.getParameter("meas_cd");			
			String userid      = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";

			String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			System.out.println("setEisEvalOrgMeas ================> " + meas_cd);
			
			if ("D".equals(tag)){
					
			    	strSQL = new StringBuffer();	
					strSQL.append("delete  tg_evalorgmeas  ");
					strSQL.append("where eval_year =? ");
					strSQL.append("and     org_cd     =? ");
					strSQL.append("and     meas_cd =? ");					
					
					Object[] iPa = { eval_year, org_cd, meas_cd};
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");				
					
			} else {	
			// Insert or Update...처리.						

							String  meas_grp_cd   =  request.getParameter("meas_grp_cd"  );
							String  meas_div_cd   =  request.getParameter("meas_div_cd"  );
							String  weight        =  request.getParameter("weight"       );
							String  disp_ord      =  request.getParameter("disp_ord"     )== null ? "10" : (request.getParameter("disp_ord")).trim();	
							
							
							
//							System.out.println("setEisEvalOrgMeas Update : eval_year ================> " + eval_year);
//							System.out.println("setEisEvalOrgMeas Update : org_cd ================> " + org_cd);							
//							System.out.println("setEisEvalOrgMeas Update : meas_cd================> " + meas_cd);
//							System.out.println("setEisEvalOrgMeas Update : meas_grp_cd================> " + meas_grp_cd);
//							
//							System.out.println("setEisEvalOrgMeas Update : meas_div_cd================> " + meas_div_cd);									
//							System.out.println("setEisEvalOrgMeas Update : weight================> " + weight);									
//							System.out.println("setEisEvalOrgMeas Update : disp_ord================> " + disp_ord);									
//							System.out.println("setEisEvalOrgMeas Update : userid================> " + userid );			
						
					    	strSQL = new StringBuffer();	
							strSQL.append("select 1 from tg_evalorgmeas where  eval_year = ? and org_cd = ? and meas_cd = ?") ;
			
							Object[] dPaD = {eval_year, org_cd, meas_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);
														
							
							// Update
							if(ds.getRowCount() != 0)
							{
	
						    	    strSQL = new StringBuffer();	
									strSQL.append(" update  tg_evalorgmeas set                    ");
									strSQL.append("         meas_grp_cd  = ?,                            ");
									strSQL.append("         meas_div_cd  = ?,                            ");
									strSQL.append("         weight       = ?,                            ");
									strSQL.append("         disp_ord     = ?,                            ");
									strSQL.append("          upd_userid = ? ,                    ") ;
									strSQL.append("          upd_date = sysdate               ") ;		
									strSQL.append("  where  eval_year   = ?                              ");
									strSQL.append("  and    org_cd      = ?                              ");
									strSQL.append("  and    meas_cd     = ?                              ");
									
									Object[] iPa = {meas_grp_cd, meas_div_cd, weight, disp_ord, userid,  eval_year, org_cd, meas_cd};
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									
									conn.commit();
									request.setAttribute("proc", "ok");
							// Insert 처리. 
							} else	{
									strSQL = new StringBuffer();									
									strSQL.append(" insert into tg_evalorgmeas (   ") ;
									strSQL.append("   eval_year, org_cd, meas_cd,  meas_grp_cd, meas_div_cd, weight,  disp_ord,  inp_date,  inp_userid, upd_date, upd_userid )  ") ;
									strSQL.append("  values ");
									strSQL.append(" (? ,?, ?, ?, ?, ?, ?, sysdate, ?, sysdate, ?) " );
			
									Object[] iPa = {   eval_year, org_cd, meas_cd, meas_grp_cd, meas_div_cd, weight, 
											                    disp_ord,  userid, userid};
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							}					
							
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
	} //-- method setEvalOrgMeas		
	
	  /**
     * Method Name : setEisEvalOrgMeasValue
     * Description	  : 특정년도의 평가기관별 지표실적을 등록
     * Author		      : PHG
     * Create Date	  : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 	
	public void setEisEvalOrgMeasValue(HttpServletRequest request, HttpServletResponse response){

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
			String eval_year = request.getParameter("eval_year");
			String org_cd     = request.getParameter("org_cd");
			String userid      = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";

			String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			System.out.println("setEisEvalOrgMeasValue  TAG : " + tag); 
			
			// 기관의 모든 실적 초기화...
			if ("D".equals(tag)){
				    
					strSQL = new StringBuffer();							
					strSQL.append(" update tg_evalorgmeas set                      ");
					strSQL.append("         eval_grade   =null,                            ");
					strSQL.append("         actual_value = null,                            ");
					strSQL.append("         grade_score  = null,                            ");
					strSQL.append("         eval_score   = null ,                            ");
					strSQL.append("          upd_userid = ? ,                    ") ;
					strSQL.append("          upd_date = sysdate               ") ;							
					strSQL.append("  where  eval_year   = ?                              ");
					strSQL.append("  and    org_cd      = ?                              ");		
					
					Object[] iPa = { userid, eval_year, org_cd};
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");						
				
			} else {	
			// Insert or Update...처리.						

				System.out.println("setEisEvalOrgMeasValue Update Start " );
					
				String arrData = request.getParameter("arrData");   // ???
				String[] mIds = arrData.split("`");
				
				System.out.println("setEisEvalOrgMeasValue = amId ==========" + arrData);
				
				for (int i = 0; i < mIds.length; i++) {					
							
							String[] iPart = mIds[i].split(",");			
							
							System.out.println("setEisEvalOrgMeasValue ==============ipart==========" + iPart);
							
							String meas_cd          = iPart[0];
							String eval_grade  = iPart[1].equals("")?"": iPart[1];
							String actual_value  = iPart[2].equals("")?"": iPart[2];
							//String grade_score       = iPart[3].equals("")?"": iPart[3];
							String eval_score    = iPart[3].equals("")?"": iPart[3];	
					
							strSQL = new StringBuffer();			
							strSQL.append("select 1 from tg_evalorgmeas where  eval_year = ? and org_cd = ? and meas_cd = ?") ;
			
							Object[] dPaD = {eval_year, org_cd,  meas_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);
														
							
//							System.out.println("setEisEvalOrgMeasValue Update : eval_year ================> " + eval_year);
//							System.out.println("setEisEvalOrgMeasValue Update : org_cd ================> " + org_cd);							
//							System.out.println("setEisEvalOrgMeasValue Update : meas_cd================> " + meas_cd);
//							System.out.println("setEisEvalOrgMeasValue Update : userid================> " + userid );									
							
							// Update
							if(ds.getRowCount() != 0)
							{
									strSQL = new StringBuffer();			
									strSQL.append(" update  tg_evalorgmeas set                  ");
									strSQL.append("         eval_grade   = ?,                            ");
									strSQL.append("         actual_value = ?,                            ");
									//strSQL.append("         grade_score  = ?,                            ");
									strSQL.append("         eval_score   = ? ,                            ");
									strSQL.append("          upd_userid = ? ,                    ") ;
									strSQL.append("          upd_date = sysdate               ") ;											
									strSQL.append("  where  eval_year   = ?                              ");
									strSQL.append("  and    org_cd      = ?                              ");
									strSQL.append("  and    meas_cd     = ?                              ");

									
									Object[] iPa = { eval_grade, actual_value, eval_score, userid, eval_year, org_cd, meas_cd};
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
	} //-- method setEvalOrgMeasValue		
	
	
//	-----------------------------------------------------------------------------------------------------
	// 	지표복사(년 이관) 
	//-----------------------------------------------------------------------------------------------------

	public void setOutEvalMeasYearCopy(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
		
		try {   
			
			String fmyear = request.getParameter("fmyear")==null?"":request.getParameter("fmyear");
			String toyear = request.getParameter("toyear")==null?"":request.getParameter("toyear");			

			//fmyear = "2007";
			//toyear ="2008";
			if ("".equals(fmyear)||"".equals(toyear)){
				request.setAttribute("rslt","false");				
				return;
			}			

			// Connection 	
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());								
			
			System.out.println("\n\n" );			
			System.out.println("=========================================================================");			
			System.out.println("Meas Year Copy : From " + fmyear + " To " + toyear );						


			//-----------------------------------------------------------------------------
			// 0. 기관 삭제복사.
			//-----------------------------------------------------------------------------			
			// 0. 기존 자료를 삭제한다.
			String strD = "delete from tg_evalorg where eval_year = ? ";
			dbobject.executePreparedUpdate(strD,new Object[]{toyear});						

			String strSQL = " ";
			strSQL += " insert into tg_evalorg (                                                ";
			strSQL += "    eval_year, org_cd,  inp_date, inp_userid, upd_date, upd_userid)                         ";
			strSQL += " select                                                                      ";
			strSQL += " 	 ? eval_year, org_cd, sysdate, 'admin', sysdate, 'admin'                                       ";
			strSQL += " from tg_evalorg                                                          ";
			strSQL += " where  eval_year = ?	                                                ";

			dbobject.executePreparedUpdate(strSQL, new Object[]{toyear, fmyear});					
			
			// 0. 기존 자료를 삭제한다.
			strD = "delete from tg_evalorgmeas where eval_year = ? ";
			dbobject.executePreparedUpdate(strD,new Object[]{toyear});				
			
			System.out.println("1. Meas Year Copy : Delete Target Year's Meas");			

			//-----------------------------------------------------------------------------
			// 1. 지표복사 
			//-----------------------------------------------------------------------------
			strSQL = " ";
			strSQL += " insert into tg_evalorgmeas (                                                ";
			strSQL += "    eval_year, org_cd, meas_cd, meas_grp_cd, meas_div_cd, weight, disp_ord,  ";
			strSQL += "    inp_date, inp_userid, upd_date, upd_userid)                              ";
			strSQL += " select                                                                      ";
			strSQL += " 	 ? eval_year, org_cd, meas_cd, meas_grp_cd, meas_div_cd, weight, disp_ord,  ";
			strSQL += " 	 sysdate, 'admin', sysdate, 'admin'                                       ";
			strSQL += " from tg_evalorgmeas                                                         ";
			strSQL += " where  eval_year = ?	                                                ";

			dbobject.executePreparedUpdate(strSQL, new Object[]{toyear, fmyear});			
			
			System.out.println("Copy Out Eval Meas End...");						
			conn.commit();
			
			request.setAttribute("rslt","true");

			System.out.println("=========================================================================");			
			
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
	}		


//	-----------------------------------------------------------------------------------------------------
	// 	지표복사(년 이관) 
	//-----------------------------------------------------------------------------------------------------

	public void setOutEvalMeasGroupCopy(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
		
		try {   
			
			String year = request.getParameter("year")==null?"":request.getParameter("year");
			String fmOrgCd = request.getParameter("fmOrgCd")==null?"":request.getParameter("fmOrgCd");
			String toOrgCd = request.getParameter("toOrgCd")==null?"":request.getParameter("toOrgCd");

			if ("".equals(year)||"".equals("".equals(year))||"".equals(toOrgCd) ){
				request.setAttribute("rslt","false");				
				return;
			}			

			// Connection 	
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());								
			
			System.out.println("\n\n" );			
			System.out.println("=========================================================================");			
			System.out.println("Meas Year Copy : From " + fmOrgCd + " To " + toOrgCd );						


			// 0. 기존 자료를 삭제한다.
			String strD = "delete from tg_evalorgmeas where eval_year = ? and org_cd =? ";
			dbobject.executePreparedUpdate(strD,new Object[]{year,toOrgCd});				
			
			System.out.println("1. Meas Year Copy : Delete Target Year's Meas");			

			//-----------------------------------------------------------------------------
			// 1. 지표복사 
			//-----------------------------------------------------------------------------
			String strSQL = " ";
			strSQL += " insert into tg_evalorgmeas (                                                ";
			strSQL += "    eval_year, org_cd, meas_cd, meas_grp_cd, meas_div_cd, weight, disp_ord,  ";
			strSQL += "    inp_date, inp_userid, upd_date, upd_userid)                              ";
			strSQL += " select                                                                      ";
			strSQL += " 	 eval_year, ?, meas_cd, meas_grp_cd, meas_div_cd, weight, disp_ord,  ";
			strSQL += " 	 sysdate, 'admin', sysdate, 'admin'                                       ";
			strSQL += " from tg_evalorgmeas                                                         ";
			strSQL += " where  eval_year = ? and org_cd=?	                                                ";

			dbobject.executePreparedUpdate(strSQL, new Object[]{toOrgCd, year, fmOrgCd});			
			
			System.out.println("Copy Out Eval Meas End...");						
			conn.commit();
			
			request.setAttribute("rslt","true");

			System.out.println("=========================================================================");			
			
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
	}	
	
	
    /**
     * Method Name : addClassComCode
     * Description	  : 외부평가부분 등록
     * Author		      : PHG
     * Create Date	  : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 	
	public void addClassComCode(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null)
				dbobject = new DBObject(conn.getConnection());
			
			StringBuffer strSQL = new StringBuffer();			
			
			System.out.println("=========================================================================");	
			
			// Loop를 돌며 Insert,Update,Delete...
			String userid  = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String div_nm  = Util.getUTF(request.getParameter("div_nm"));
			//String div_nm = Util.getEUCKR((request.getParameter("div_nm"));			
	
			
			strSQL.append( "insert into tz_comcode ( ");
			strSQL.append( "           ldiv_cd, sdiv_cd, div_nm, ord,  use_yn, inp_date, inp_userid, upd_date, upd_userid )  "); 
			strSQL.append(" select ldiv_cd, nvl(ltrim(to_char(to_number(max(sdiv_cd)) + 1,'0')),'0'), ? div_nm, 1  ord, 'Y' use_yn,  ");  
			strSQL.append("           sysdate,  ?, sysdate, ?     "); 			
			strSQL.append(" from    tz_comcode      "); 
			strSQL.append(" where  ldiv_cd = 'G03'");
			strSQL.append(" group by ldiv_cd         ") ;

			System.out.println("addMeasComCode  ==  " + div_nm + ":" + strSQL.toString());	
			
			Object[] iPa = {div_nm,  userid, userid};
			dbobject.executePreparedUpdate(strSQL.toString(), iPa);
			conn.commit();
			
			request.setAttribute("proc", "ok");		
			
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
	} //-- method addComCode		
	
    /**
     * Method Name : addMeasComCode
     * Description	  : 외부평가지표 등록
     * Author		      : PHG
     * Create Date	  : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 	
	public void addMeasComCode(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null)
				dbobject = new DBObject(conn.getConnection());
			
			StringBuffer strSQL = new StringBuffer();			
			
			System.out.println("=========================================================================");	
			
			// Loop를 돌며 Insert,Update,Delete...
			String userid  = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String div_nm  = Util.getUTF(request.getParameter("div_nm"));
			//String div_nm = Util.getEUCKR((request.getParameter("div_nm"));			
	
			
			strSQL.append( "insert into tz_comcode ( ");
			strSQL.append( "           ldiv_cd, sdiv_cd, div_nm, ord,  use_yn, inp_date, inp_userid, upd_date, upd_userid )  "); 
			strSQL.append(" select ldiv_cd, nvl(ltrim(to_char(to_number(max(sdiv_cd)) + 1,'000')),'000'), ? div_nm, 1  ord, 'Y' use_yn,  ");  
			strSQL.append("           sysdate,  ?, sysdate, ?     "); 			
			strSQL.append(" from    tz_comcode      "); 
			strSQL.append(" where  ldiv_cd = 'G04'");
			strSQL.append(" group by ldiv_cd         ") ;

			System.out.println("addMeasComCode  ==  " + div_nm + ":" + strSQL.toString());	
			
			Object[] iPa = {div_nm,  userid, userid};
			dbobject.executePreparedUpdate(strSQL.toString(), iPa);
			conn.commit();
			
			request.setAttribute("proc", "ok");		
			
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
	} //-- method addComCode		
	
}

