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

public class EISBizUtil {
	
    /**
     * Method Name : getBizManCnt
     * Description : 사업단 인원 구하기
     * Author	   : PHG
     * Create Date : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 
	public void getBizManCnt(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
				
		try {
			String 	ym = request.getParameter("ym");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append(" SELECT a.dept_cd, a.dept_nm, a.man_gbn_cd, a.man_gbn_nm,             ");
			sbSQL.append("        b.full_cnt, b.curr_cnt, 'Q' flag                              ");
			sbSQL.append(" FROM   (                                                             ");
			sbSQL.append("         SELECT dept_cd, dept_nm, man_gbn_cd, man_gbn_nm,             ");
			sbSQL.append("                a.ord ord1, b.ord ord2                                ");
			sbSQL.append("         FROM    (                                                    ");
			sbSQL.append("                 select '00'   dept_cd, '한국전력기술' dept_nm, 1 ord ");
			sbSQL.append("                 from   dual                                          ");
			sbSQL.append("                 ) a,                                                 ");
			sbSQL.append("                 (                                                    ");
			sbSQL.append("                 select sdiv_cd  man_gbn_cd, div_nm  man_gbn_nm, ord  ");
			sbSQL.append("                 from   tz_comcode                                    ");
			sbSQL.append("                 where  ldiv_cd = 'E10'                               ");
			sbSQL.append("                 and    use_yn  = 'Y'                                 ");
			sbSQL.append("                 order by ord, sdiv_cd                                ");
			sbSQL.append("                 ) b                                                  ");
			sbSQL.append("         ) a,                                                         ");
			sbSQL.append("         te_mancnt b                                                  ");
			sbSQL.append(" WHERE   a.dept_cd    = b.dept_cd (+)                                 ");
			sbSQL.append(" AND     a.man_gbn_cd = b.man_gbn_cd (+)                              ");
			sbSQL.append(" AND     b.eis_year(+)= ?                                             ");
			sbSQL.append(" ORDER BY a.ord1, a.dept_cd, a. ord2, a.man_gbn_cd                    ");

			//System.out.println(sbSQL);

			Object[] pmSQL =  {ym};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getBizManCnt : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}//-- method getBizManCnt
	
	
    /**
     * Method Name : setBizManCnt
     * Description : 월별 사업단의 인원을 등록, 수정
     * Autho       : PHG
     * Create Date : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 	
	public void setBizManCnt(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }
			
			StringBuffer strSQL = new StringBuffer();			
			
			// Loop를 돌며 Insert,Update,Delete...
			String ym     = request.getParameter("ym");
			String userid = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String tag    = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			// 전체 삭제...
			if ("D".equals(tag)){

					strSQL.append("DELETE te_mancnt WHERE eis_year =? ");
					
					Object[] iPa = {ym};
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");				
			
			// Insert or Update....		
			} else {	
				String   arrData = request.getParameter("arrData");   
				String[] recData = arrData.split("`");
				
				for (int i = 0; i < recData.length; i++) {					

							String[] iPart = recData[i].split(",");			
							
							//System.out.println("setBizManCnt : " + iPart);
							
							String dept_cd      = iPart[0];
							String man_gbn_cd   = iPart[1];
							String full_cnt     = iPart[2].equals("")?"": iPart[2];
							String curr_cnt     = iPart[3].equals("")?"": iPart[3];

//							System.out.println(" ym           = " + ym      );							
//							System.out.println(" dept_cd      = " + iPart[0]);
//							System.out.println(" man_gbn_cd   = " + iPart[1]);
//							System.out.println(" full_cnt     = " + iPart[2]);
//							System.out.println(" cur_cnt      = " + iPart[3]);
							
						if(dept_cd != null && man_gbn_cd != null){		
							strSQL = new StringBuffer();	
							strSQL.append("select 1 from te_mancnt where eis_year = ? and dept_cd = ? and man_gbn_cd = ? ") ;
			
//							System.out.println("setBizManCnt : " + strSQL.toString());
							
							Object[] dPaD = {ym, dept_cd, man_gbn_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);
														
							
							// Update
							if(ds.getRowCount() != 0)
							{
								    strSQL = new StringBuffer();	
								    strSQL.append(" update te_mancnt set         ");
									strSQL.append("        full_cnt = ?          ") ;
									strSQL.append("       ,curr_cnt = ?          ") ;									
									strSQL.append("       ,upd_userid = ?        ") ;
									strSQL.append("       ,upd_date   = sysdate  ") ;				
									strSQL.append(" where eis_year   = ? ");
									strSQL.append(" and   dept_cd    = ? ");
									strSQL.append(" and   man_gbn_cd = ? ");
									
									Object[] iPa = { full_cnt, curr_cnt, userid, ym, dept_cd, man_gbn_cd };
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							
							// Insert 처리. 
							} else	{
//									System.out.println("Insert .... " + dept_cd);
								    
								    strSQL = new StringBuffer();	
									strSQL.append(" insert into te_mancnt (  ") ;
									strSQL.append("  eis_year, dept_cd, man_gbn_cd, full_cnt, curr_cnt, inp_date, inp_userid, upd_date, upd_userid )  ") ;
									strSQL.append("  values ");
									strSQL.append(" (? ,?, ?, ?, ?, sysdate, ?, sysdate, ?)" );

//									System.out.println("Insert .... " + strSQL.toString());
									
									Object[] iPa = {ym, dept_cd, man_gbn_cd, full_cnt, curr_cnt, userid, userid};
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							}	
						}	// key가 널이 아닌 경우만 입력 	
							
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
     * Method Name : getBizDeptCd
     * Description : 사업단 코드 구하기
     * Author	   : PHG
     * Create Date : 2008-04-04
     * History	          :	
     * @throws SQLException 
     */ 
	public void getBizDeptCd(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
				
		try {
			String 	ldiv_cd = "E05";
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append(" SELECT sdiv_cd   dept_cd, div_nm   dept_nm             ");
			sbSQL.append(" FROM   tz_comcode                                      ");
			sbSQL.append(" WHERE  ldiv_cd = ?                                     ");
			sbSQL.append(" ORDER BY sdiv_cd                                       ");

			//System.out.println(sbSQL);

			Object[] pmSQL =  {ldiv_cd};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getBizDeptCd : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}//-- method getBizDeptCd
	
    /**
     * Method Name : getBizYearDept
     * Description : 특정년도 사업단 코드 구하기
     * Author	   : PHG
     * Create Date : 2008-04-04
     * History	          :	
     * @throws SQLException 
     */ 
	public void getBizYearDept(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
				
		try {
			String 	year = request.getParameter("year");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append(" SELECT dept_cd, dept_nm, year             ");
			sbSQL.append(" FROM   te_dept                            ");
			sbSQL.append(" WHERE  year = ?                           ");
			sbSQL.append(" ORDER BY dept_cd                          ");

			//System.out.println(sbSQL);

			Object[] pmSQL =  {year};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getBizDeptCd : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}//-- method getBizYearDept	
	
	
    /**
     * Method Name : setBizYearDept
     * Description : 년도 사업단 등록, 수정
     * Autho       : PHG
     * Create Date : 2008-04-04
     * History	          :	
     * @throws SQLException 
     */ 	
	public void setBizYearDept(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }
			
			StringBuffer strSQL = new StringBuffer();			
			
			// Loop를 돌며 Insert,Update,Delete...
			String year   = request.getParameter("year");
			String userid = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String tag    = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			

			// 삭제후 처리...	
			strSQL.append("DELETE te_dept WHERE year =? ");
			
			Object[] iPaD = {year};
			dbobject.executePreparedUpdate(strSQL.toString(), iPaD);
						
			// Insert or Update....		
			// 전체 삭제...
			if ("U".equals(tag)){	
				String   arrData = request.getParameter("arrData");   
				String[] recData = arrData.split("`");
				
				for (int i = 0; i < recData.length; i++) {					

							String[] iPart = recData[i].split(",");			
							
							//System.out.println("setBizManCnt : " + iPart);
							
							String dept_cd      = iPart[0];
							String dept_nm      = Util.getUTF(iPart[1]);

							
						if(dept_cd != null){		
							strSQL = new StringBuffer();	
							strSQL.append("select 1 from te_dept where year = ? and dept_cd = ? ") ;
			
//							System.out.println("setBizManCnt : " + strSQL.toString());
							
							Object[] dPaD = {year, dept_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);														
							
							// Update
							if(ds.getRowCount() != 0)
							{
								    strSQL = new StringBuffer();	
								    strSQL.append(" update te_dept set           ");
									strSQL.append("        dept_nm  = ?          ") ;								
									strSQL.append("       ,upd_userid = ?        ") ;
									strSQL.append("       ,upd_date   = sysdate  ") ;				
									strSQL.append(" where year       = ? ");
									strSQL.append(" and   dept_cd    = ? ");
									
									Object[] iPa = { dept_nm, userid, year, dept_cd };
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
							
							// Insert 처리. 
							} else	{
//									System.out.println("Insert .... " + dept_cd);
								    
								    strSQL = new StringBuffer();	
									strSQL.append(" insert into te_dept (  ") ;
									strSQL.append("  year, dept_cd, dept_nm, inp_date, inp_userid, upd_date, upd_userid )  ") ;
									strSQL.append("  values ");
									strSQL.append(" (? ,?, ?,  sysdate, ?, sysdate, ?)" );

//									System.out.println("Insert .... " + strSQL.toString());
									
									Object[] iPa = {year, dept_cd, dept_nm, userid, userid};
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);

							}	
						}	// key가 널이 아닌 경우만 입력 	
							
				}	// Loop End.
				
			} // if ~ end.
			
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
	} //-- method setEvalOrg
	
    /**
     * Method Name : getBizDept
     * Description : 영업현황을 조회
     * Author      : PHG
     * Create Date : 2008-03-06
     * History	          :	
     * @throws SQLException 
     */ 
	public void getBizDept(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			String ym = request.getParameter("ym");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append(" SELECT a.dept_cd               ,       ");
			sbSQL.append("        a.dept_nm               ,       ");
			sbSQL.append("        b.cont_plan_svc         ,       ");
			sbSQL.append("        b.cont_actual_svc       ,       ");
			sbSQL.append("        b.cont_forecast_svc     ,       ");
			sbSQL.append("        b.cont_plan_const       ,       ");
			sbSQL.append("        b.cont_actual_const     ,       ");
			sbSQL.append("        b.cont_forecast_const   ,       ");
			sbSQL.append("        b.sales_plan_svc        ,       ");
			sbSQL.append("        b.sales_actual_svc      ,       ");
			sbSQL.append("        b.sales_forecast_svc    ,       ");
			sbSQL.append("        b.sales_plan_const      ,       ");
			sbSQL.append("        b.sales_actual_const    ,       ");
			sbSQL.append("        b.sales_forecast_const  ,       ");
			sbSQL.append("        b.contract_amt          ,       ");
			sbSQL.append("        b.sales_cost_plan       ,       ");
			sbSQL.append("        b.sales_cost_actual     ,       ");
			sbSQL.append("        b.sales_cost_forecast   ,       ");
			sbSQL.append("        b.sales_profit_plan     ,       ");
			sbSQL.append("        b.sales_profit_actual   ,       ");
			sbSQL.append("        b.sales_profit_forecast         ");
			sbSQL.append(" FROM (                                 ");
			sbSQL.append(" 	 select DEPT_CD, DEPT_NM, DEPT_CD ord ");
			sbSQL.append(" 	 FROM   TE_DEPT               	  	  ");
			sbSQL.append(" 	 WHERE  YEAR=?           	  	  	  ");
			sbSQL.append(" 	 order by DEPT_CD            	  	  ");
			sbSQL.append(" 	) a,                             	  ");
			sbSQL.append(" 	te_deptbiz b                     	  ");
			sbSQL.append(" WHERE  a.dept_cd = b.dept_cd (+)       ");
			sbSQL.append(" AND    b.ym(+)   = ?                   ");
			sbSQL.append(" ORDER BY a.ord, a.dept_cd              ");


			//System.out.println(sbSQL);

			Object[] pmSQL =  {ym.substring(0, 4),ym};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getBizDept : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}//-- method getBizDeptSales
	
	
    /**
     * Method Name : getBizSonYik
     * Description : 손익을 조회
     * Author      : PHG
     * Create Date : 2008-03-06
     * History	          :	
     * @throws SQLException 
     */ 
	public void getBizSonYik(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			String ym = request.getParameter("ym");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append(" SELECT a.dept_cd               ,                                                          ");
			sbSQL.append("         a.dept_nm               ,                                                         ");
			sbSQL.append("         c.sales_plan_svc        ,                                                         ");
			sbSQL.append("         c.sales_actual_svc      ,                                                         ");
			sbSQL.append("         c.sales_forecast_svc    ,                                                         ");
			sbSQL.append("         b.sales_cost_plan       ,                                                         ");
			sbSQL.append("         b.sales_cost_actual     ,                                                         ");
			sbSQL.append("         b.sales_cost_forecast   ,                                                         ");
			sbSQL.append("         nvl(c.sales_plan_svc  ,0) - nvl(b.sales_cost_plan  ,0)   sales_profit_plan     ,  ");
			sbSQL.append("         nvl(c.sales_actual_svc,0) - nvl(b.sales_cost_actual,0)   sales_profit_actual   ,  ");
			sbSQL.append("         b.sales_profit_forecast                                                           ");
			sbSQL.append("  FROM (                                                                                   ");
			sbSQL.append("         SELECT '99'  DEPT_CD, '전사' DEPT_NM, 1 ord                                       ");
			sbSQL.append("         FROM    DUAL                                                                      ");
			sbSQL.append("         ) a,                                                                              ");
			sbSQL.append("         (                                                                                 ");
			sbSQL.append("         SELECT '99'                   dept_cd     ,                                       ");
			sbSQL.append("                 sum(sales_plan_svc)   sales_plan_svc  ,                                   ");
			sbSQL.append("                 sum(sales_actual_svc) sales_actual_svc,                                   ");
			sbSQL.append("                 sum(sales_forecast_svc) sales_forecast_svc                                ");			
			sbSQL.append("          FROM   te_deptbiz                                                                ");
			sbSQL.append("          WHERE  ym LIKE ?                                                                 ");
			sbSQL.append("          ) c,                                                                             ");
			sbSQL.append("         te_deptbiz b                                                                      ");
			sbSQL.append("  WHERE  a.dept_cd = b.dept_cd (+)                                                         ");
			sbSQL.append("  AND    a.dept_cd = c.dept_cd (+)                                                         ");
			sbSQL.append("  AND    b.ym(+)   = ?                                                                     ");
			sbSQL.append("  ORDER BY a.ord, a.dept_cd                                                                ");



			//System.out.println(sbSQL);

			Object[] pmSQL =  {ym,ym};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getBizSonYik : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}//-- method getBizDeptSales
	
	
	/**
     * Method Name : setBizDeptSales
     * Description : 기관별 실적입력 - 매출액
     * Author      : PHG
     * Create Date : 2008-03-06
     * History	   :	
     * @throws SQLException 
     */ 	
	public void setBizDeptSales(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }
			
			StringBuffer strSQL = new StringBuffer();			
			
			// Loop를 돌며 Insert,Update,Delete...
			String ym     = request.getParameter("ym");
			String userid = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String tag    = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			// 전체 삭제 : 데이타 Null처리...
			if ("D".equals(tag)){

				    strSQL.append(" update te_deptbiz set         ");
				    strSQL.append("         sales_plan_svc        = null       ");
					strSQL.append("       , sales_actual_svc      = null       ");
					strSQL.append("       , sales_forecast_svc    = null       ");
					strSQL.append("       , sales_plan_const      = null       ");
					strSQL.append("       , sales_actual_const    = null       ");
					strSQL.append("       , sales_forecast_const  = null       ");								
					strSQL.append("       , upd_userid = ?        ") ;
					strSQL.append("       , upd_date   = sysdate  ") ;				
					strSQL.append(" where ym          = ? ");
					
					Object[] iPa = {userid, ym};
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");				
			
			// Insert or Update....		
			} else {	
				String   arrData = request.getParameter("arrData");   
				String[] recData = arrData.split("`");
				
				for (int i = 0; i < recData.length; i++) {					

							String[] iPart = recData[i].split(",");			
							
//							System.out.println("setBizDeptSales : " + iPart);
							
							String dept_cd              = iPart[0];
							String sales_plan_svc       = iPart[1].equals("")?"": iPart[1];
							String sales_actual_svc     = iPart[2].equals("")?"": iPart[2];
							String sales_forecast_svc   = iPart[3].equals("")?"": iPart[3];
							String sales_plan_const     = iPart[4].equals("")?"": iPart[4];
							String sales_actual_const   = iPart[5].equals("")?"": iPart[5];
							String sales_forecast_const = iPart[6].equals("")?"": iPart[6];
							
							strSQL = new StringBuffer();	
							strSQL.append("SELECT 1 FROM te_deptbiz WHERE ym = ? AND dept_cd = ? ") ;

							//System.out.println("setBizDeptSales : " + dept_cd);							
							
							Object[] dPaD = {ym, dept_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);														
							
							// Update
							if(ds.getRowCount() != 0)
							{
								    strSQL = new StringBuffer();	
								    strSQL.append(" update te_deptbiz set         ");
								    strSQL.append("         sales_plan_svc        = ?       ");
									strSQL.append("       , sales_actual_svc      = ?       ");
									strSQL.append("       , sales_forecast_svc    = ?       ");
									strSQL.append("       , sales_plan_const      = ?       ");
									strSQL.append("       , sales_actual_const    = ?       ");
									strSQL.append("       , sales_forecast_const  = ?       ");								
									strSQL.append("       , upd_userid = ?        ") ;
									strSQL.append("       , upd_date   = sysdate  ") ;				
									strSQL.append(" where ym          = ? ");
									strSQL.append(" and   dept_cd     = ? ");
									
									Object[] iPa = { sales_plan_svc  , sales_actual_svc  , sales_forecast_svc  , 
													 sales_plan_const, sales_actual_const, sales_forecast_const, 
													 userid, ym, dept_cd };
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							
							// Insert 처리. 
							} else	{
									//System.out.println("Insert .... " + dept_cd);
								    
								    strSQL = new StringBuffer();	
									strSQL.append(" insert into te_deptbiz ("                                  );
									strSQL.append("  ym, dept_cd,"                                             ); 
									strSQL.append("  sales_plan_svc, sales_actual_svc, sales_forecast_svc, "   ); 
									strSQL.append("  sales_plan_const,sales_actual_const,sales_forecast_const,");
									strSQL.append("  inp_date, inp_userid, upd_date, upd_userid )  "           );
									strSQL.append(" values "                                                   );
									strSQL.append(" (?,?,  ?,?,?, ?,?,?, "                                     );
									strSQL.append(" sysdate, ?, sysdate, ?)"                                   );
			
									Object[] iPa = {ym, dept_cd, 
													sales_plan_svc  , sales_actual_svc  , sales_forecast_svc  , 
													sales_plan_const, sales_actual_const, sales_forecast_const, 
													userid, userid};
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
	} //-- method setBizDeptSales
	
	/**
     * Method Name : setBizDeptCost
     * Description : 기관별 실적입력 - 손익(비용+이익)
     * Author      : PHG
     * Create Date : 2008-03-06
     * History	   :	
     * @throws SQLException 
     */ 	
	public void setBizDeptCost(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }
			
			StringBuffer strSQL = new StringBuffer();			
			
			// Loop를 돌며 Insert,Update,Delete...
			String ym     = request.getParameter("ym");
			String userid = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String tag    = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			// 전체 삭제 : 데이타 Null처리...
			if ("D".equals(tag)){

				    strSQL.append(" update te_deptbiz set         ");
				    strSQL.append("         sales_cost_plan        = null       ");
					strSQL.append("       , sales_cost_actual      = null       ");
					strSQL.append("       , sales_cost_forecast    = null       ");
					strSQL.append("       , sales_profit_plan      = null       ");
					strSQL.append("       , sales_profit_actual    = null       ");
					strSQL.append("       , sales_profit_forecast  = null       ");								
					strSQL.append("       , upd_userid = ?        ") ;
					strSQL.append("       , upd_date   = sysdate  ") ;				
					strSQL.append(" where ym          = ? ");
					
					Object[] iPa = {userid, ym};
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");				
			
			// Insert or Update....		
			} else {	
				String   arrData = request.getParameter("arrData");   
				String[] recData = arrData.split("`");
				
				for (int i = 0; i < recData.length; i++) {					

							String[] iPart = recData[i].split(",");			
							
//							System.out.println("setBizManCnt : " + iPart);
							
							String dept_cd               = iPart[0];
							String sales_cost_plan       = iPart[1].equals("")?"": iPart[1];
							String sales_cost_actual     = iPart[2].equals("")?"": iPart[2];
							String sales_cost_forecast   = iPart[3].equals("")?"": iPart[3];
							String sales_profit_plan     = iPart[4].equals("")?"": iPart[4];
							String sales_profit_actual   = iPart[5].equals("")?"": iPart[5];
							String sales_profit_forecast = iPart[6].equals("")?"": iPart[6];
							
							strSQL = new StringBuffer();	
							strSQL.append("SELECT 1 FROM te_deptbiz WHERE ym = ? AND dept_cd = ? ") ;
			
							Object[] dPaD = {ym, dept_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);														
							
							// Update
							if(ds.getRowCount() != 0)
							{
								    strSQL = new StringBuffer();	
								    strSQL.append(" update te_deptbiz set         ");
								    strSQL.append("         sales_cost_plan        = ?       ");
									strSQL.append("       , sales_cost_actual      = ?       ");
									strSQL.append("       , sales_cost_forecast    = ?       ");
									strSQL.append("       , sales_profit_plan      = ?       ");
									strSQL.append("       , sales_profit_actual    = ?       ");
									strSQL.append("       , sales_profit_forecast  = ?       ");							
									strSQL.append("       , upd_userid = ?        ") ;
									strSQL.append("       , upd_date   = sysdate  ") ;				
									strSQL.append(" where ym          = ? ");
									strSQL.append(" and   dept_cd     = ? ");
									
									Object[] iPa = { sales_cost_plan  , sales_cost_actual  , sales_cost_forecast  , 
													 sales_profit_plan, sales_profit_actual, sales_profit_forecast, 
													 userid, ym, dept_cd };
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							
							// Insert 처리. 
							} else	{
								    
								    strSQL = new StringBuffer();	
									strSQL.append(" insert into te_deptbiz ("                               );
									strSQL.append("  ym, dept_cd,"                                          ); 
									strSQL.append("  sales_cost_plan  , sales_cost_actual  , sales_cost_forecast,  "); 
									strSQL.append("  sales_profit_plan, sales_profit_actual, sales_profit_forecast,");
									strSQL.append("  inp_date, inp_userid, upd_date, upd_userid )  "        );
									strSQL.append(" values "                                                );
									strSQL.append(" (?,?,  ?,?,?, ?,?,?, "                                  );
									strSQL.append(" sysdate, ?, sysdate, ?)"                                );
			
									Object[] iPa = {ym, dept_cd, 
											        sales_cost_plan  , sales_cost_actual  , sales_cost_forecast  , 
											        sales_profit_plan, sales_profit_actual, sales_profit_forecast,  
													userid, userid};
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
	} //-- method setBizDeptCost

	/**
     * Method Name : setBizDeptCont
     * Description : 기관별 실적입력 - 수주 및 계약잔고
     * Author      : PHG
     * Create Date : 2008-03-06
     * History	   :	
     * @throws SQLException 
     */ 	
	public void setBizDeptCont(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }
			
			StringBuffer strSQL = new StringBuffer();			
			
			// Loop를 돌며 Insert,Update,Delete...
			String ym     = request.getParameter("ym");
			String userid = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String tag    = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			// 전체 삭제 : 데이타 Null처리...
			if ("D".equals(tag)){

				    strSQL.append(" update te_deptbiz set         ");
				    strSQL.append("         cont_plan_svc        = null       ");
					strSQL.append("       , cont_actual_svc      = null       ");
					strSQL.append("       , cont_forecast_svc    = null       ");
					strSQL.append("       , cont_plan_const      = null       ");
					strSQL.append("       , cont_actual_const    = null       ");
					strSQL.append("       , cont_forecast_const  = null       ");								
					strSQL.append("       , contract_amt         = null       ");	
					strSQL.append("       , upd_userid = ?        ") ;
					strSQL.append("       , upd_date   = sysdate  ") ;				
					strSQL.append(" where ym          = ? ");
					
					Object[] iPa = {userid, ym};
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");				
			
			// Insert or Update....		
			} else {	
				String   arrData = request.getParameter("arrData");   
				String[] recData = arrData.split("`");
				
				for (int i = 0; i < recData.length; i++) {					

							String[] iPart = recData[i].split(",");			
							
//							System.out.println("setBizManCnt : " + iPart);
							
							String dept_cd              = iPart[0];
							String cont_plan_svc       = iPart[1].equals("")?"": iPart[1];
							String cont_actual_svc     = iPart[2].equals("")?"": iPart[2];
							String cont_forecast_svc   = iPart[3].equals("")?"": iPart[3];
							String cont_plan_const     = iPart[4].equals("")?"": iPart[4];
							String cont_actual_const   = iPart[5].equals("")?"": iPart[5];
							String cont_forecast_const = iPart[6].equals("")?"": iPart[6];
							String contract_amt        = iPart[7].equals("")?"": iPart[7];
							
							strSQL = new StringBuffer();	
							strSQL.append("SELECT 1 FROM te_deptbiz WHERE ym = ? AND dept_cd = ? ") ;
			
							Object[] dPaD = {ym, dept_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);														
							
							// Update
							if(ds.getRowCount() != 0)
							{
								    strSQL = new StringBuffer();	
								    strSQL.append(" update te_deptbiz set         ");
								    strSQL.append("         cont_plan_svc        = ?       ");
									strSQL.append("       , cont_actual_svc      = ?       ");
									strSQL.append("       , cont_forecast_svc    = ?       ");
									strSQL.append("       , cont_plan_const      = ?       ");
									strSQL.append("       , cont_actual_const    = ?       ");
									strSQL.append("       , cont_forecast_const  = ?       ");								
									strSQL.append("       , contract_amt         = ?       ");	
									strSQL.append("       , upd_userid = ?        ") ;
									strSQL.append("       , upd_date   = sysdate  ") ;				
									strSQL.append(" where ym          = ? ");
									strSQL.append(" and   dept_cd     = ? ");
									
									//System.out.println("Update .... " + strSQL.toString());
									
									Object[] iPa = { cont_plan_svc  , cont_actual_svc  , cont_forecast_svc  , 
													 cont_plan_const, cont_actual_const, cont_forecast_const, contract_amt, 
													 userid, ym, dept_cd };
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							
							// Insert 처리. 
							} else	{
									//System.out.println("Insert .... " + dept_cd);
								    
								    strSQL = new StringBuffer();	
									strSQL.append(" insert into te_deptbiz ("                                  );
									strSQL.append("  ym, dept_cd,"                                             ); 
									strSQL.append("  cont_plan_svc, cont_actual_svc, cont_forecast_svc, "      ); 
									strSQL.append("  cont_plan_const,cont_actual_const,cont_forecast_const,"   );
									strSQL.append("  contract_amt,"                                            );
									strSQL.append("  inp_date, inp_userid, upd_date, upd_userid )  "           );
									strSQL.append(" values "                                                   );
									strSQL.append(" (?,?,  ?,?,?, ?,?,?, ?, "                                     );
									strSQL.append(" sysdate, ?, sysdate, ?)"                                   );
			
									Object[] iPa = {ym, dept_cd, 
													cont_plan_svc  , cont_actual_svc  , cont_forecast_svc  , 
													cont_plan_const, cont_actual_const, cont_forecast_const, 
													contract_amt   ,
													userid, userid};
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
	} //-- method setBizDeptCont	
	
}

