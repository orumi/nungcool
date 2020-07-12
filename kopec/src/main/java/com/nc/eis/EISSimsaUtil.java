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

public class EISSimsaUtil {
	
    /**
     * Method Name : getSimaContractAmt
     * Description : 사업단별 계약잔고 구하기
     * Author	   : PHG
     * Create Date : 2008-03-07
     * History	          :	
     * @throws SQLException 
     */ 
	public void getSimaContractAmt(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
				
		try {
			String 	eis_year = request.getParameter("eis_year");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
 			sbSQL.append("  SELECT a.dept_cd, a.dept_nm,                                                          ");
			sbSQL.append("         b.bef_cont_amt, b.sale_amt,b.cont_amt,  'Q' flag                               ");
			sbSQL.append("  FROM   (                                                                              ");
			sbSQL.append("          SELECT dept_cd, dept_nm,                                                      ");
			sbSQL.append("              a.ord ord1                                                                ");
			sbSQL.append("          FROM    (                                                                     ");
			sbSQL.append("                  select DEPT_CD, DEPT_NM, DEPT_CD ord                        		  ");
			sbSQL.append("                  FROM   TE_DEPT                                                     	  ");
			sbSQL.append("                  WHERE  YEAR=?                                                		  ");
			sbSQL.append("                  order by DEPT_CD                                                 	  ");
			sbSQL.append("                  ) a                                                                   ");
			sbSQL.append("          ) a,                                                                          ");
			sbSQL.append("          te_contractamt b                                                              ");
			sbSQL.append("  WHERE   a.dept_cd    = b.dept_cd (+)                                                  ");
			sbSQL.append("  AND     b.eis_year(+)= ?                                                              ");
			sbSQL.append("  ORDER BY a.ord1, a.dept_cd                                                            ");

			//System.out.println(sbSQL);

			Object[] pmSQL =  {eis_year,eis_year};
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
	}//-- method getSimaContractAmt
	
	   /**
     * Method Name : setSimaContractAmt
     * Description : 사업단별 계약잔고 등록, 수정
     * Autho       : PHG
     * Create Date : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 	
	public void setSimaContractAmt(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }
			
			StringBuffer strSQL = new StringBuffer();			
			
			// Loop를 돌며 Insert,Update,Delete...
			String eis_year  = request.getParameter("eis_year");
			String userid    = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String tag       = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			// 전체 삭제...
			if ("D".equals(tag)){
					strSQL.append("DELETE te_contractamt WHERE eis_year = ? ");
					
					//System.out.println(" setSimaContractAmt      = " + strSQL.toString());			
					
					Object[] iPa = {eis_year};
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");				
			
			// Insert or Update....		
			} else {	
				String   arrData = request.getParameter("arrData");   
				String[] recData = arrData.split("`");

				//System.out.println(" arrData      = " + arrData);				
				
				for (int i = 0; i < recData.length; i++) {					

							String[] iPart = recData[i].split(",");			
							
							String dept_cd      = iPart[0];
							String bef_cont_amt = iPart[1];
							String sale_amt     = iPart[2].equals("")?"": iPart[2];
							String cont_amt     = iPart[3].equals("")?"": iPart[3];

					
//							System.out.println(" dept_cd      = " + iPart[0]);
//							System.out.println(" bef_cont_amt   = " + iPart[1]);
//							System.out.println(" sale_amt     = " + iPart[2]);
//							System.out.println(" cont_amt      = " + iPart[3]);
							
						if(dept_cd != null){		
							strSQL = new StringBuffer();	
							strSQL.append("select 1 from te_contractamt where eis_year = ? and dept_cd = ? ") ;
			
//							System.out.println("setBizManCnt : " + strSQL.toString());
							
							Object[] dPaD = {eis_year, dept_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);
														
							
							// Update
							if(ds.getRowCount() != 0)
							{
								    strSQL = new StringBuffer();	
								    strSQL.append(" update te_contractamt set    ") ;
									strSQL.append("        bef_cont_amt = ?      ") ;
									strSQL.append("       ,sale_amt     = ?      ") ;									
									strSQL.append("       ,cont_amt     = ?      ") ;
									strSQL.append("       ,upd_userid = ?        ") ;
									strSQL.append("       ,upd_date   = sysdate  ") ;				
									strSQL.append(" where eis_year   = ? ");
									strSQL.append(" and   dept_cd    = ? ");
									
									Object[] iPa = { bef_cont_amt, sale_amt, cont_amt, userid, eis_year, dept_cd };
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							
							// Insert 처리. 
							} else	{
//									System.out.println("Insert .... " + dept_cd);
								    
								    strSQL = new StringBuffer();	
									strSQL.append(" insert into te_contractamt (  ") ;
									strSQL.append("  eis_year, dept_cd, bef_cont_amt, sale_amt, cont_amt, inp_date, inp_userid, upd_date, upd_userid )  ") ;
									strSQL.append("  values ");
									strSQL.append(" (? ,?, ?, ?, ?, sysdate, ?, sysdate, ?)" );

//									System.out.println("Insert .... " + strSQL.toString());
									
									Object[] iPa = {eis_year, dept_cd, bef_cont_amt, sale_amt, cont_amt, userid, userid};
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
	} //-- method setSimaContractAmt
	
	
	
    /**
     * Method Name : getSimsaSalesAmt
     * Description : 사업단별 계약잔고 구하기
     * Author	   : PHG
     * Create Date : 2008-03-07
     * History	          :	
     * @throws SQLException 
     */ 
	public void getSimsaSalesAmt(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
				
		try {
			String 	eis_year = request.getParameter("eis_year");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
 			sbSQL.append("  SELECT a.biz_ldiv_cd, a.biz_ldiv_nm, a.biz_sdiv_cd, a.biz_sdiv_nm,                  ");
			sbSQL.append("         b.bef_sale_amt, b.plan_amt, b.actual_amt                                     ");
			sbSQL.append("  FROM                                                                                ");
			sbSQL.append("         (                                                                            ");
			sbSQL.append("         select a.sdiv_cd  biz_ldiv_cd, a.div_nm  biz_ldiv_nm , a.ord ord1,           ");
			sbSQL.append("                b.sdiv_cd  biz_sdiv_cd, b.div_nm  biz_sdiv_nm , b.ord ord2            ");
			sbSQL.append("         from   tz_comcode a, tz_comcode b                                            ");
			sbSQL.append("         where  a.ldiv_cd = 'E06'                                                     ");
			sbSQL.append("         and    a.sdiv_cd = '01'                                                       ");
			sbSQL.append("         and    a.use_yn  = 'Y'                                                       ");
			sbSQL.append("         and    b.ldiv_cd = 'E07'                                                     ");
			sbSQL.append("         and    b.use_yn  = 'Y'                                                       ");
			sbSQL.append("         union all                                                                    ");
			sbSQL.append("         select a.sdiv_cd  biz_ldiv_cd, a.div_nm  biz_ldiv_nm , a.ord,                ");
			sbSQL.append("                b.sdiv_cd  biz_sdiv_cd, b.div_nm  biz_sdiv_nm , b.ord                 ");
			sbSQL.append("         from   tz_comcode a, tz_comcode b                                            ");
			sbSQL.append("         where  a.ldiv_cd = 'E06'                                                     ");
 			sbSQL.append("         and    a.sdiv_cd = '02'                                                       ");
			sbSQL.append("         and    a.use_yn  = 'Y'                                                       ");
			sbSQL.append("         and    b.ldiv_cd = 'E08'                                                     ");
			sbSQL.append("         and    b.use_yn  = 'Y'                                                       ");
			sbSQL.append("         ) a,                                                                         ");
			sbSQL.append("         te_salesamt b                                                                ");
			sbSQL.append("  WHERE  a.biz_ldiv_cd = b.biz_ldiv_cd (+)                                            ");
			sbSQL.append("  AND    a.biz_sdiv_cd = b.biz_sdiv_cd (+)                                            ");
			sbSQL.append("  AND    b.eis_year (+) = ?                                                           ");
			sbSQL.append("  ORDER BY a.ord1, a.biz_ldiv_cd, a.ord2, a.biz_sdiv_cd                               ");

			//System.out.println(sbSQL);

			Object[] pmSQL =  {eis_year};
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
	}//-- method getSimsaSalesAmt
	
	   /**
     * Method Name : setSimsaSalesAmt
     * Description : 사업단별  등록, 수정
     * Autho       : PHG
     * Create Date : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 	
	public void setSimsaSalesAmt(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }
			
			StringBuffer strSQL = new StringBuffer();			
			
			// Loop를 돌며 Insert,Update,Delete...
			String eis_year = request.getParameter("eis_year");
			String userid   = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String tag      = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			// 전체 삭제...
			if ("D".equals(tag)){

					strSQL.append("DELETE te_salesamt WHERE eis_year =? ");
					
					Object[] iPa = {eis_year};
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
							
							String biz_ldiv_cd  = iPart[0];
							String biz_sdiv_cd  = iPart[1];
							String bef_cont_amt = iPart[2].equals("")?"": iPart[2];
							String sale_amt     = iPart[3].equals("")?"": iPart[3];
							String cont_amt     = iPart[4].equals("")?"": iPart[4];							

//							System.out.println(" ym           = " + ym      );							
//							System.out.println(" dept_cd      = " + iPart[0]);
//							System.out.println(" man_gbn_cd   = " + iPart[1]);
//							System.out.println(" full_cnt     = " + iPart[2]);
//							System.out.println(" cur_cnt      = " + iPart[3]);
							
						if(biz_ldiv_cd != null && biz_sdiv_cd != null){		
							strSQL = new StringBuffer();	
							strSQL.append("select 1 from te_salesamt where eis_year = ? and biz_ldiv_cd = ? and biz_sdiv_cd = ?  ") ;
			
//							System.out.println("setBizManCnt : " + strSQL.toString());
							
							Object[] dPaD = {eis_year, biz_ldiv_cd, biz_sdiv_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);
														
							
							// Update
							if(ds.getRowCount() != 0)
							{
								    strSQL = new StringBuffer();	
								    strSQL.append(" update te_salesamt set       ") ;
									strSQL.append("        bef_sale_amt = ?      ") ;
									strSQL.append("       ,plan_amt     = ?      ") ;									
									strSQL.append("       ,actual_amt   = ?      ") ;
									strSQL.append("       ,upd_userid = ?        ") ;
									strSQL.append("       ,upd_date   = sysdate  ") ;				
									strSQL.append(" where eis_year   = ? ");
									strSQL.append(" and   biz_ldiv_cd= ? ");
									strSQL.append(" and   biz_sdiv_cd= ? ");
									
									Object[] iPa = { bef_cont_amt, sale_amt, cont_amt, userid, eis_year, biz_ldiv_cd, biz_sdiv_cd };
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							
							// Insert 처리. 
							} else	{
//									System.out.println("Insert .... " + dept_cd);
								    
								    strSQL = new StringBuffer();	
									strSQL.append(" insert into te_salesamt (  ") ;
									strSQL.append("  eis_year, biz_ldiv_cd, biz_sdiv_cd, bef_sale_amt, plan_amt, actual_amt, inp_date, inp_userid, upd_date, upd_userid )  ") ;
									strSQL.append("  values ");
									strSQL.append(" (? ,?, ?, ?, ?, ?, sysdate, ?, sysdate, ?)" );

//									System.out.println("Insert .... " + strSQL.toString());
									
									Object[] iPa = {eis_year, biz_ldiv_cd, biz_sdiv_cd, bef_cont_amt, sale_amt, cont_amt, userid, userid};
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
	} //-- method setSimaContractAmt
	
    /**
     * Method Name : getSimaIntellActual
     * Description : 지적재산권
     * Author	   : PHG
     * Create Date : 2008-03-07
     * History	          :	
     * @throws SQLException 
     */ 
	public void getSimaIntellActual(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
				
		try {
			String 	eis_year = request.getParameter("eis_year");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
 			sbSQL.append("   SELECT a.nat_gbn_cd, a.nat_gbn_nm,                                  ");
			sbSQL.append("          b.patent_apply, b.patent_regi, b.brend_regi,                 ");
			sbSQL.append("          b.tech_regi, b.copyright, b.program                          ");
			sbSQL.append("   FROM   (                                                            ");
			sbSQL.append("           SELECT sdiv_cd  nat_gbn_cd, div_nm  nat_gbn_nm , ord        ");
			sbSQL.append("           FROM   tz_comcode                                           ");
			sbSQL.append("           WHERE  ldiv_cd = 'E09'                                      ");
			sbSQL.append("           AND     use_yn  = 'Y'                                       ");
			sbSQL.append("           ) a,                                                        ");
			sbSQL.append("           te_intellactual b                                           ");
			sbSQL.append("   WHERE   a.nat_gbn_cd = b.nat_gbn_cd (+)                             ");
			sbSQL.append("   AND     b.eis_year(+)= ?                                            ");
			sbSQL.append("   ORDER BY a.ord, a.nat_gbn_cd                                        ");

			//System.out.println(sbSQL);

			Object[] pmSQL =  {eis_year};
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
	}//-- method getSimaIntellActual
	
	   /**
     * Method Name : setSimaContractAmt
     * Description : 사업단별 계약잔고 등록, 수정
     * Autho       : PHG
     * Create Date : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 	
	public void setSimaIntellActual(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }
			
			StringBuffer strSQL = new StringBuffer();			
			
			// Loop를 돌며 Insert,Update,Delete...
			String eis_year = request.getParameter("eis_year");
			String userid   = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String tag      = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			// 전체 삭제...
			if ("D".equals(tag)){

					strSQL.append("DELETE te_intellactual WHERE eis_year =? ");
					
					Object[] iPa = {eis_year};
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");				
			
			// Insert or Update....		
			} else {	
				String   arrData = request.getParameter("arrData");   
				String[] recData = arrData.split("`");
				
//				System.out.println("setSimaIntellActual : " + arrData );
				
				for (int i = 0; i < recData.length; i++) {					

							String[] iPart = recData[i].split(",");			
							
							
							String nat_gbn_cd   = iPart[0];
							String patent_apply = iPart[1].equals("")?"": iPart[1];
							String patent_regi  = iPart[2].equals("")?"": iPart[2];
							String brend_regi   = iPart[3].equals("")?"": iPart[3];
							String tech_regi    = iPart[4].equals("")?"": iPart[4];
							String copyright    = iPart[5].equals("")?"": iPart[5];
							String program      = iPart[6].equals("")?"": iPart[6];			
							
						if(nat_gbn_cd != null){		
							strSQL = new StringBuffer();	
							strSQL.append("select 1 from te_intellactual where eis_year = ? and nat_gbn_cd = ? ") ;
			
//							System.out.println("setBizManCnt : " + strSQL.toString());
							
							Object[] dPaD = {eis_year, nat_gbn_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);
														
							
							// Update
							if(ds.getRowCount() != 0)
							{
								    strSQL = new StringBuffer();	
								    strSQL.append(" update te_intellactual set   ") ;
									strSQL.append("        patent_apply = ?      ") ;
									strSQL.append("       ,patent_regi  = ?      ") ;									
									strSQL.append("       ,brend_regi   = ?      ") ;
									strSQL.append("       ,tech_regi    = ?      ") ;
									strSQL.append("       ,copyright    = ?      ") ;									
									strSQL.append("       ,program      = ?      ") ;									
									strSQL.append("       ,upd_userid = ?        ") ;
									strSQL.append("       ,upd_date   = sysdate  ") ;				
									strSQL.append(" where eis_year   = ? ");
									strSQL.append(" and   nat_gbn_cd = ? ");
									
									Object[] iPa = { patent_apply, patent_regi, brend_regi, tech_regi,copyright, program, userid, eis_year, nat_gbn_cd };
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							
							// Insert 처리. 
							} else	{
//									System.out.println("Insert .... " + dept_cd);
								    
								    strSQL = new StringBuffer();	
									strSQL.append(" insert into te_intellactual (  ") ;
									strSQL.append("  eis_year, nat_gbn_cd, patent_apply, patent_regi, brend_regi, tech_regi, copyright, program,  ") ;
									strSQL.append("  inp_date, inp_userid, upd_date, upd_userid )  ") ;
									strSQL.append("  values ");
									strSQL.append(" (? ,?,  ?,?,?,?,?,?, sysdate, ?, sysdate, ?)" );

									//System.out.println("Insert .... " + strSQL.toString());
									
									Object[] iPa = {eis_year, nat_gbn_cd, patent_apply, patent_regi, brend_regi, tech_regi,copyright, program, userid, userid};
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
	} //-- method setSimaContractAmt
	
    /**
     * Method Name : getSimsaRptForm
     * Description : 정형화된 심사 ReportForm을 가져옴.
     * Author      : PHG
     * Create Date : 2008-03-06
     * History	          :	
     * @throws SQLException 
     */ 
	public void getSimsaRpt(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			String eis_no = request.getParameter("eis_no");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
 			sbSQL.append("  select a.eis_no, f_getcodenm('E02', a.eis_no)  eis_nm,     ");
			sbSQL.append("         a.ldiv_cd, a.div_nm  ldiv_nm                        ");
			sbSQL.append("  from   te_eisrpt a                                         ");
			sbSQL.append("  where  a.eis_no like ?||'%'                                ");
			sbSQL.append("  order by a.eis_no, a.ldiv_cd                               ");

			//System.out.println(sbSQL);

			Object[] pmSQL =  {eis_no};
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
	}//-- method getSimsaRpt
	
    /**
     * Method Name : setSimaEisNo
     * Description : EIS Code 등록
     * Author	   : PHG
     * Create Date : 2008-02-04
     * History	          :	
     * @throws SQLException 
     */ 	
	public void setSimaEisNo(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null)
				dbobject = new DBObject(conn.getConnection());
			
			StringBuffer strSQL = new StringBuffer();			
			
			//System.out.println("=========================================================================");	
			
			// Loop를 돌며 Insert,Update,Delete...
			String tag      = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			String userid   = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";

			String eis_no = request.getParameter("eis_no")!=null?request.getParameter("eis_no"):"";
			
			// 전체 삭제 : 데이타 Null처리...
			if ("D".equals(tag)){
				
				strSQL.append( " delete tz_comcode      ");
				strSQL.append( " where  ldiv_cd = 'E02' ");
				strSQL.append("  and    sdiv_cd = ?     ") ;
	
				//System.out.println("setSimaNo : Delete  ==  " + strSQL.toString());	
				
				Object[] iPa = {eis_no};
				dbobject.executePreparedUpdate(strSQL.toString(), iPa);				
			
			}else{
				String div_nm = request.getParameter("div_nm");
				
				//System.out.println("eis_no" + eis_no);
				if (eis_no.equals("")){
				
						strSQL.append( "insert into tz_comcode ( ");
						strSQL.append( "       ldiv_cd, sdiv_cd, div_nm, ord,  use_yn, inp_date, inp_userid, upd_date, upd_userid )  "); 
						strSQL.append(" select ldiv_cd, nvl(ltrim(to_char(to_number(max(sdiv_cd)) + 1,'00')),'00'), ? div_nm, 1  ord, 'Y' use_yn,  ");  
						strSQL.append("           sysdate,  ?, sysdate, ?     "); 			
						strSQL.append(" from    tz_comcode      "); 
						strSQL.append(" where  ldiv_cd = 'E02' ");
						strSQL.append(" group by ldiv_cd         ") ;
		
						//System.out.println("setSimaEisNo  ==  " + strSQL.toString());	
						
						Object[] iPa = {div_nm,  userid, userid};				
						dbobject.executePreparedUpdate(strSQL.toString(), iPa);
				}else{
						strSQL.append(" update  tz_comcode      "); 
						strSQL.append(" set     div_nm = ?      ");
						strSQL.append(" where  ldiv_cd = 'E02' ");
						strSQL.append(" and    sdiv_cd = ?     ");
		
						//System.out.println("setSimaEisNo  ==  " + strSQL.toString());	
						
						Object[] iPa = {div_nm, eis_no};				
						dbobject.executePreparedUpdate(strSQL.toString(), iPa);					
					
				}
			}			

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
	} //-- method setSimaEisCode		
	
	/**
     * Method Name : setSimaEisRpt
     * Description : 정형화된 심사 Report 대분류항목
     * Author      : PHG
     * Create Date : 2008-03-06
     * History	   :	
     * @throws SQLException 
     */ 	
	public void setSimaEisRpt(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }
			
			StringBuffer strSQL = new StringBuffer();			
			
			// Loop를 돌며 Insert,Update,Delete...
			String eis_no   = request.getParameter("eis_no");
			String ldiv_cd  = request.getParameter("ldiv_cd")!=null?request.getParameter("ldiv_cd"):"";
			String div_nm   = Util.getUTF(request.getParameter("div_nm" ));
			String userid   = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String tag      = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			// 전체 삭제 : 데이타 Null처리...
			if ("D".equals(tag)){

				    strSQL.append(" delete te_eisrpt      ");		
					strSQL.append(" where eis_no      = ? ");
					strSQL.append(" and   ldiv_cd     = ? ");	
					
					Object[] iPa = {eis_no, ldiv_cd};
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");				
			
			// Insert or Update....		
			} else {	
											
							strSQL = new StringBuffer();	
							strSQL.append("SELECT 1 FROM te_eisrpt WHERE eis_no = ? AND ldiv_cd = ? ") ;

							//System.out.println("setSimsaEisRpt : " + eis_no + "-" + ldiv_cd);							
							
							Object[] dPaD = {eis_no, ldiv_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);														
							
							// Update
							if(ds.getRowCount() != 0)
							{
								    strSQL = new StringBuffer();	
								    strSQL.append(" update te_eisrpt set          ");
								    strSQL.append("         div_nm     = ?        ");
									strSQL.append("       , upd_userid = ?        ") ;
									strSQL.append("       , upd_date   = sysdate  ") ;				
									strSQL.append(" where eis_no      = ? ");
									strSQL.append(" and   ldiv_cd     = ? ");								
									
									//System.out.println("Update .... " );
									
									Object[] iPa = { div_nm  ,
													 userid, eis_no, ldiv_cd };
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							
							// Insert 처리. 
							} else	{
									//System.out.println("Insert .... " );
								    
								    strSQL = new StringBuffer();	
									strSQL.append(" insert into te_eisrpt ("                                  );
									strSQL.append("  eis_no, ldiv_cd, div_nm, "                                ); 
									strSQL.append("  inp_date, inp_userid, upd_date, upd_userid )  "           );
									strSQL.append(" select ? eis_no, nvl(ltrim(to_char(to_number(max(ldiv_cd)) + 1,'00')),'01'), ? div_nm, ");  
									strSQL.append("        sysdate,  ?, sysdate, ?     "); 			
									strSQL.append(" from    te_eisrpt      "); 
									strSQL.append(" where   eis_no = ?     ");
									//strSQL.append(" group by eis_no        ") ;
			
									Object[] iPa = {eis_no, div_nm,
													userid, userid, eis_no};
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
	} //-- method setSimaEisRpt
	
    /**
     * Method Name : getSimsaRptForm
     * Description : 정형화된 심사 ReportForm을 가져옴.
     * Author      : PHG
     * Create Date : 2008-03-06
     * History	          :	
     * @throws SQLException 
     */ 
	public void getSimsaRptForm(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			String eis_no = request.getParameter("eis_no");
			String ldiv_cd = request.getParameter("ldiv_cd")==null?"%":request.getParameter("ldiv_cd");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
 			sbSQL.append("  select a.eis_no, f_getcodenm('E02', a.eis_no)  eis_nm,     ");
			sbSQL.append("         a.ldiv_cd, a.div_nm ldiv_nm, b.sdiv_cd, b.div_nm sdiv_nm,   ");
			sbSQL.append("         b.eis_div_cd, b.unit, b.dot_pos, b.disp_ord,        ");
			sbSQL.append("         12345   value                                       ");
			sbSQL.append("  from   te_eisrpt a, te_eisrptform b                        ");
			sbSQL.append("  where  a.eis_no  = b.eis_no (+)                            ");
			sbSQL.append("  and    a.ldiv_cd = b.ldiv_cd(+)                            ");
			sbSQL.append("  and    a.eis_no  like ?||'%'                               ");
			sbSQL.append("  and    a.ldiv_cd like ?||'%'                               ");			
			sbSQL.append("  order by a.eis_no, a.ldiv_cd, b.disp_ord, b.sdiv_cd        ");

			//System.out.println(sbSQL);

			Object[] pmSQL =  {eis_no, ldiv_cd};
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
	}//-- method getSimsaRptForm

	/**
     * Method Name : setSimaEisRptForm
     * Description : 정형화된 심사 Report 소분류항목
     * Author      : PHG
     * Create Date : 2008-03-06
     * History	   :	
     * @throws SQLException 
     */ 	
	public void setSimaEisRptForm(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }
			
			StringBuffer strSQL = new StringBuffer();			
			
			// Loop를 돌며 Insert,Update,Delete...
			String eis_no   = request.getParameter("eis_no");
			String ldiv_cd  = request.getParameter("ldiv_cd");
			String sdiv_cd  = request.getParameter("sdiv_cd")!=null?request.getParameter("sdiv_cd"):"";			
			String div_nm   = Util.getUTF(request.getParameter("div_nm" ));
			String eis_div_cd   = request.getParameter("eis_div_cd" )!=null?request.getParameter("eis_div_cd"):"00";
			String unit         = request.getParameter("unit" );
			String dot_pos      = request.getParameter("dot_pos" );
			String disp_ord     = request.getParameter("disp_ord" );			
			String userid       = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String tag          = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			// 전체 삭제 : 데이타 Null처리...
			if ("D".equals(tag)){

				    strSQL.append(" delete te_eisrptform  ");		
					strSQL.append(" where eis_no      = ? ");
					strSQL.append(" and   ldiv_cd     = ? ");
					strSQL.append(" and   sdiv_cd     = ? ");	
					
					Object[] iPa = {eis_no, ldiv_cd, sdiv_cd};
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");				
			
			// Insert or Update....		
			} else {	
											
							strSQL = new StringBuffer();	
							strSQL.append("SELECT 1 FROM te_eisrptform WHERE eis_no = ? AND ldiv_cd = ? AND sdiv_cd = ? ") ;

							//System.out.println("setBizDeptSales : " + dept_cd);							
							
							Object[] dPaD = {eis_no, ldiv_cd, sdiv_cd};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);														
							
							// Update
							if(ds.getRowCount() != 0)
							{
								    strSQL = new StringBuffer();	
								    strSQL.append(" update te_eisrptform set              ");
								    strSQL.append("         div_nm      = ?       ") ;
								    strSQL.append("       , eis_div_cd  = ?       ") ;
								    strSQL.append("       , unit        = ?       ") ;
								    strSQL.append("       , dot_pos     = ?       ") ;
								    strSQL.append("       , disp_ord    = ?       ") ;										    
								    strSQL.append("       , upd_userid = ?        ") ;
									strSQL.append("       , upd_date   = sysdate  ") ;				
									strSQL.append(" where eis_no      = ? ");
									strSQL.append(" and   ldiv_cd     = ? ");
									strSQL.append(" and   sdiv_cd     = ? ");										
									
									Object[] iPa = { div_nm  , eis_div_cd, unit, dot_pos, disp_ord, 
													 userid, eis_no, ldiv_cd, sdiv_cd };
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							
							// Insert 처리. 
							} else	{
									//System.out.println("Insert .... ");
								    
								    strSQL = new StringBuffer();	
									strSQL.append(" insert into te_eisrptform ("                                  );
									strSQL.append("  eis_no, ldiv_cd, sdiv_cd, div_nm, "                          );
									strSQL.append("  eis_div_cd, unit, dot_pos, disp_ord,  "                      ); 									
									strSQL.append("  inp_date, inp_userid, upd_date, upd_userid )  "              );
									strSQL.append(" select ? eis_no, ? ldiv_cd, nvl(ltrim(to_char(to_number(max(sdiv_cd)) + 1,'00')),'01'), ? div_nm, ");  
									strSQL.append("        ? eis_div_cd, ? unit, ? dot_pos, ? disp_ord,   ");
									strSQL.append("        sysdate,  ?, sysdate, ?                "); 			
									strSQL.append(" from    te_eisrptform    "); 
									strSQL.append(" where   eis_no = ?       ");
									strSQL.append(" and     ldiv_cd = ?      ");
			
									Object[] iPa = {eis_no, ldiv_cd, div_nm,eis_div_cd, unit, dot_pos, disp_ord,
													userid, userid, eis_no, ldiv_cd};
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
	} //-- method setSimaEisRptForm
	
    /**
     * Method Name : getSimsaRptRslt
     * Description : 정형화된 심사 Report 실적
     * Author      : PHG
     * Create Date : 2008-03-06
     * History	          :	
     * @throws SQLException 
     */ 
	public void getSimsaRptRslt(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			String eis_no   = request.getParameter("eis_no");
			String eis_year = request.getParameter("eis_year");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append(" select a.eis_no, f_getcodenm('E02', a.eis_no)  eis_nm,        ");
			sbSQL.append("        a.ldiv_cd, a.div_nm  ldiv_nm, b.sdiv_cd, b.div_nm sdiv_nm,      ");
			sbSQL.append("        b.eis_div_cd, b.unit, b.dot_pos, b.disp_ord,           ");
			sbSQL.append("        c.actual_value    value                                ");
			sbSQL.append(" from   te_eisrpt a, te_eisrptform b, te_eisrptrslt c          ");
			sbSQL.append(" where  a.eis_no  = b.eis_no                                   ");
			sbSQL.append(" and    a.ldiv_cd = b.ldiv_cd                                  ");
 			sbSQL.append(" and    b.eis_no  = c.eis_no  (+)                              ");
			sbSQL.append(" and    b.ldiv_cd = c.ldiv_cd (+)                              ");
			sbSQL.append(" and    b.sdiv_cd = c.sdiv_cd (+)                              ");
			sbSQL.append(" and    a.eis_no like ?||'%'                                   ");
			sbSQL.append(" and    c.eis_year(+) = ?                                      ");
			sbSQL.append(" order by a.eis_no, a.ldiv_cd, b.disp_ord, b.sdiv_cd           ");


			//System.out.println(sbSQL);

			Object[] pmSQL =  {eis_no, eis_year};
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
	}//-- method getSimsaRptRslt
 
	/**
     * Method Name : setSimsaRptRslt
     * Description : 정형화된 심사 Report 실적
     * Author      : PHG
     * Create Date : 2008-03-06
     * History	   :	
     * @throws SQLException 
     */ 	
	public void setSimsaRptRslt(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }
			
			StringBuffer strSQL = new StringBuffer();			
			
			// Loop를 돌며 Insert,Update,Delete...
			String eis_no   = request.getParameter("eis_no");
			String eis_year = request.getParameter("eis_year");
			String userid   = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String tag      = request.getParameter("tag")!=null?request.getParameter("tag"):"";
			
			// 전체 삭제 : 데이타 Null처리...
			if ("D".equals(tag)){
				
				    strSQL.append(" delete te_eisrptrslt  ");		
					strSQL.append(" where eis_no      = ? ");
					strSQL.append(" and   eis_year    = ? ");
					
					//System.out.println("setSimsaRptRslt : " + eis_no + " : " + strSQL.toString());	
					
					Object[] iPa = {eis_no, eis_year};
					dbobject.executePreparedUpdate(strSQL.toString(), iPa);
					conn.commit();
					request.setAttribute("proc", "ok");				
			
			// Insert or Update....		
			} else {	
				String   arrData = request.getParameter("arrData");   
				String[] recData = arrData.split("`");
				
				for (int i = 0; i < recData.length; i++) {					

							String[] iPart = recData[i].split(",");			
							
							String ldiv_cd              = iPart[0];
							String sdiv_cd              = iPart[1];
							String actual_value         = iPart[2].equals("")?"": iPart[2];
							
							strSQL = new StringBuffer();	
							strSQL.append("SELECT 1 FROM te_eisrptrslt WHERE eis_no = ? AND ldiv_cd = ? AND sdiv_cd = ? AND eis_year = ? ") ;

							//System.out.println("setBizDeptSales : " + dept_cd);							
							
							Object[] dPaD = {eis_no, ldiv_cd, sdiv_cd, eis_year};
							rs = dbobject.executePreparedQuery(strSQL.toString(), dPaD);
							DataSet ds = new DataSet();
							ds.load(rs);														
							
							// Update
							if(ds.getRowCount() != 0)
							{
								    strSQL = new StringBuffer();	
								    strSQL.append(" update te_eisrptrslt set              ");
								    strSQL.append("         actual_value        = ?       ");
									strSQL.append("       , upd_userid = ?        ") ;
									strSQL.append("       , upd_date   = sysdate  ") ;				
									strSQL.append(" where eis_no      = ? ");
									strSQL.append(" and   ldiv_cd     = ? ");
									strSQL.append(" and   sdiv_cd     = ? ");
									strSQL.append(" and   eis_year    = ? ");									
									
									Object[] iPa = { actual_value  ,
													 userid, eis_no, ldiv_cd, sdiv_cd, eis_year };
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);
									conn.commit();
									request.setAttribute("proc", "ok");
							
							// Insert 처리. 
							} else	{
									//System.out.println("Insert .... " + dept_cd);
								    
								    strSQL = new StringBuffer();	
									strSQL.append(" insert into te_eisrptrslt ("                               );
									strSQL.append("  eis_no, ldiv_cd, sdiv_cd, eis_year, "                     ); 
									strSQL.append("  actual_value,                                            ");
									strSQL.append("  inp_date, inp_userid, upd_date, upd_userid )  "           );
									strSQL.append(" values "                                                   );
									strSQL.append(" (?,?,?,?, ?, "                                             );
									strSQL.append(" sysdate, ?, sysdate, ?)"                                   );
			
									Object[] iPa = {eis_no, ldiv_cd, sdiv_cd, eis_year, 
													actual_value  ,  
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
	
}

