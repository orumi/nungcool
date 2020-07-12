package com.nc.mbo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;

/* KOPEC : 성과책임
 * DESC  : 성과책임 조회 프로그램 개발
 * Rev
 * ----------------------------------------------
 * 2009.01.29 by PHG
 *  1. 초기 Class 정의 : 조직구성
 *     1) 조직 TREE 구성    - 년도별 조직을 구성해야 함(고민스러움)
 *     2) 조직별 성과책임 조회
 *
 */

public class mboPsnUtil {

	/*
	 * Method : 부서의 성과책임 List
	 */
	public void getPsnList(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			// Argument...
			String year     = request.getParameter("year"    );
			String organcd  = request.getParameter("organcd" )==null?"%":request.getParameter("organcd" );
			String saupcd   = request.getParameter("saupcd"  )==null?"%":request.getParameter("saupcd"  );
			String empnm    = request.getParameter("empnm"   )==null?"%":request.getParameter("empnm"  );

			//String empnm    = Util.getUTF(request.getParameter("empnm"   ));
			if (year==null) return;

			//System.out.println("organcd :" + organcd +", " + "saupcd :" + saupcd +", " + "empnm :" + empnm );

			StringBuffer sb = new StringBuffer();

			// SQL 작성
			sb.append(" SELECT a.in_year   , a.in_seq, a.in_rev,                          ");
			sb.append("        a.in_sabun emp_no, x.emp_nm , in_jikmu,    ");
			sb.append("        a.organ_cd  , f_OrganNm(a.organ_cd)   organ_nm,              ");
			sb.append("        a.saup_cd   , ' ' saup_nm                                  ");
			//sb.append(" FROM   pa00.t_payb005t@lnk_cpmis a,                               ");
			sb.append(" FROM   t_payb005t a,                               ");
			sb.append("         (                                                         ");
			sb.append("         SELECT in_year, in_sabun, f_getempnm(in_sabun) emp_nm,     ");
			sb.append("                 in_seq, max(in_rev) in_rev                        ");
			//sb.append("         FROM   pa00.t_payb005t@lnk_cpmis                          ");
			sb.append("         FROM   t_payb005t                          ");
			sb.append("         WHERE  in_year     = ?                                    ");
			sb.append("         AND    in_pyung_gb = 'P'                                  ");
			sb.append("         AND    nvl(organ_cd,' ')    like ?||'%'                   ");
			sb.append("         AND    nvl(saup_cd ,' ')    like ?||'%'                   ");
			sb.append("         GROUP BY in_year, in_sabun, in_seq                        ");
			sb.append("         ) x                                                       ");
			sb.append(" WHERE  a.in_year  = x.in_year                                     ");
			sb.append(" AND    a.in_sabun = x.in_sabun                                    ");
			sb.append(" AND    a.in_seq   = x.in_seq                                      ");
			sb.append(" AND    a.in_rev   = x.in_rev                                      ");
			sb.append(" AND    x.emp_nm   like ?||'%'                                     ");
			sb.append(" ORDER BY a.in_jikchk, a.in_sabun                                  ");


			// Connection
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// 조회
			Object[] param = {year,organcd, saupcd, empnm};
			rs = dbobject.executePreparedQuery(sb.toString(), param);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}



	/*
	 * Method : 개인의 성과책임 List
	 */
	public void getPsnAccountList(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			// Argument...
			String year    = request.getParameter("year"  );
			String empno   = request.getParameter("empno" );
			String in_seq  = request.getParameter("in_seq");
			String in_rev  = request.getParameter("in_rev");

			if (year==null) return;

			StringBuffer sb = new StringBuffer();

			// SQL 작성
			sb.append(" SELECT in_sabun  emp_no, f_getempnm(in_sabun) emp_nm,   ");
			sb.append("        in_seq, in_rev, a_no, accountability, a_weight,  ");
			sb.append("        success_key,  success_key2, success_key3     ");
			//sb.append(" FROM   pa00.t_payb006t@lnk_cpmis                    ");
			sb.append(" FROM   t_payb006t                    ");
			sb.append(" WHERE  in_year  = ?                                 ");
			sb.append(" AND    in_sabun = ?                                 ");
			sb.append(" AND    in_seq   = ?                                 ");
			sb.append(" AND    in_rev   = ?                                 ");
			sb.append(" ORDER BY a_no                                       ");

			// Connection
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// 조회
			Object[] param = {year,empno,in_seq, in_rev};
			rs = dbobject.executePreparedQuery(sb.toString(), param);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 * Method : 개인 성과책임 -> 성과목표
	 */
	public void getPsnObject(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			// Argument...
			String year    = request.getParameter("year"  );
			String empno   = request.getParameter("empno" );
			String in_seq  = request.getParameter("in_seq");
			String in_rev  = request.getParameter("in_rev");
			String a_no    = request.getParameter("a_no"  );

			if (year==null) return;

			System.out.println("empnm : " + empno + "," + in_seq + "," + in_rev + "," + a_no);

			StringBuffer sb = new StringBuffer();

			// SQL 작성
			sb.append(" SELECT in_sabun emp_no, in_seq, in_rev, a_no, o_no, o_weight,");
			sb.append("        object, plan, result,                              ");
			sb.append("        achieve_ex,                                        ");
			sb.append("        achieve_vg,                                        ");
			sb.append("        achieve_g ,                                        ");
			sb.append("        achieve_ni,                                        ");
			sb.append("        achieve_un,                                        ");
			sb.append("        score1                                             ");
			//sb.append(" FROM   pa00.t_payb008t@lnk_cpmis                          ");
			sb.append(" FROM   t_payb008t                          ");
			sb.append(" WHERE  in_year  = ?                                       ");
			sb.append(" AND    in_sabun = ?                                       ");
			sb.append(" AND    in_seq   = ?                                       ");
			sb.append(" AND    in_rev   = ?                                       ");
			sb.append(" AND    a_no     = ?                                       ");
			sb.append(" ORDER BY a_no                                             ");


			// Connection
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// 조회
			Object[] param = {year,empno,in_seq, in_rev, a_no};
			rs = dbobject.executePreparedQuery(sb.toString(), param);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 * Method : 개인 성과책임과  성과목표
	 */
	public void getPsnAccountObjectList(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			// Argument...
			String year    = request.getParameter("year"  );
			String empno   = request.getParameter("empno" );
			String in_seq  = request.getParameter("in_seq");
			String in_rev  = request.getParameter("in_rev");

			if (year==null) return;

			System.out.println("empnm : " + empno + "," + in_seq + "," + in_rev );

			StringBuffer sb = new StringBuffer();

			// SQL 작성
			sb.append(" SELECT a.in_sabun  emp_no, f_getempnm(a.in_sabun) emp_nm,          ");
			sb.append("        a.in_seq, a.in_rev, a.a_no, a.accountability, a.a_weight,   ");
			sb.append("        a.success_key,  a.success_key2, a.success_key3,             ");
			sb.append("        b.o_no , b.object, b.o_weight, b.plan, b.result             ");
			//sb.append(" FROM   pa00.t_payb006t@lnk_cpmis a,                                ");
			sb.append(" FROM   t_payb006t a,                                ");
			//sb.append("        pa00.t_payb008t@lnk_cpmis b                                 ");
			sb.append("        t_payb008t b                                 ");
			sb.append(" WHERE  a.in_year  = b.in_year  (+)                                 ");
			sb.append(" AND    a.in_sabun = b.in_sabun (+)                                 ");
			sb.append(" AND    a.in_seq   = b.in_seq   (+)                                 ");
			sb.append(" AND    a.in_rev   = b.in_rev   (+)                                 ");
			sb.append(" AND    a.a_no     = b.a_no     (+)                                 ");
			sb.append(" AND    a.in_year  = ?                                              ");
			sb.append(" AND    a.in_sabun = ?                                              ");
			sb.append(" AND    a.in_seq   = ?                                              ");
			sb.append(" AND    a.in_rev   = ?                                              ");
			sb.append(" ORDER BY a.a_no, b.o_no                                            ");


			// Connection
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// 조회
			Object[] param = {year,empno,in_seq, in_rev};
			rs = dbobject.executePreparedQuery(sb.toString(), param);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 * Method : 사장님 부터 성과책임 List BlackDown
	 */
	public void getAccountRoot(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			// Argument...
			String year    = request.getParameter("year"  );
			String empno   = "00000";
			String in_seq  = "";
			String in_rev  = "";

//			empno   = "01129";
//			in_seq  = "1";
//			in_rev  = "1";

			if (year==null) return;

			// Connection
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			StringBuffer sb = new StringBuffer();

			// 사번이 사장인 경우 직책 : '01'로 사장의 사번을 찾는다.
			if ("00000".equals(empno)){

			    sb.append(" SELECT in_year, in_sabun, in_seq, max(in_rev) in_rev   ");
		        //sb.append(" FROM   pa00.t_payb005t@lnk_cpmis                       ");
			    sb.append(" FROM   t_payb005t                       ");
		        sb.append(" WHERE  in_year     = ?                                 ");
		        sb.append(" AND    in_seq     <> '0'                               ");
		        sb.append(" AND    in_pyung_gb = 'P'                               ");
		        sb.append(" AND    in_jikchk   =  '01'                             ");
		        sb.append(" GROUP BY in_year, in_sabun, in_seq                     ");

		        System.out.println(sb.toString());

				// 조회
				Object[] param = {year};
				rs = dbobject.executePreparedQuery(sb.toString(), param);



				DataSet dsBoss = new DataSet();
				dsBoss.load(rs);
				dsBoss.next();

				empno  = dsBoss.getString("in_sabun");
				in_seq = dsBoss.getString("in_seq");
				in_rev = dsBoss.getString("in_rev");
			}

			System.out.println("Boss Info : " + empno + "," + in_seq + "," + in_rev);

			sb = new StringBuffer();

			// SQL 작성
			sb.append(" SELECT a.in_sabun  emp_no, f_getempnm(a.in_sabun) emp_nm,   b.in_jikmu,  ");
			sb.append("        b.in_jikchk, j.code_name1   jikchk_nm,                            ");
			sb.append("        b.organ_cd, f_OrganNm(b.organ_cd) organ_nm, b.saup_cd , ' ' saup_nm,               ");
			sb.append("        a.in_seq, a.in_rev, a.a_no, a.accountability, a.a_weight,         ");
			sb.append("        success_key,  success_key2, success_key3                          ");
			//sb.append(" FROM   pa00.t_payb006t@lnk_cpmis a,                                      ");
			//sb.append("        pa00.t_payb005t@lnk_cpmis b,                                      ");
			//sb.append("        pa00.v_jikchk_r@lnk_cpmis j                                       ");

			sb.append(" FROM   t_payb006t a,                                      ");
			sb.append("        t_payb005t b,                                      ");
			sb.append("        v_jikchk_r j                                       ");

			sb.append(" WHERE  a.in_year  = b.in_year                                            ");
			sb.append(" AND    a.in_sabun = b.in_sabun                                           ");
			sb.append(" AND    a.in_seq   = b.in_seq                                             ");
			sb.append(" AND    a.in_rev   = b.in_rev                                             ");
			sb.append(" AND    b.in_jikchk= j.code   (+)                                         ");
			sb.append(" AND    a.in_year  = ?                                                    ");
			sb.append(" AND    a.in_sabun = ?                                                    ");
			sb.append(" AND    a.in_seq   = ?                                                    ");
			sb.append(" AND    a.in_rev   = ?                                                    ");
			sb.append(" ORDER BY a_no                                                            ");

			// 조회
			Object[] param = {year, empno, in_seq, in_rev};
			rs = dbobject.executePreparedQuery(sb.toString(), param);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 * Method : 하위 성과책임 List BlackDown
	 */
	public void getAccountTree(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			// Argument...
			String year    = request.getParameter("year"  );
			String u_empno = request.getParameter("empno" );		// 상위자사번
			String a_no_up = request.getParameter("a_no"  );		// 상위자 성과책임
			if (year==null) return;

			// Connection
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			System.out.println("getAccountTree : " + u_empno + "," + a_no_up);

			StringBuffer sb = new StringBuffer();

			// SQL 작성
			sb.append(" SELECT a.in_sabun  emp_no    , f_getempnm(a.in_sabun  )      emp_nm   ,                   ");
			sb.append("        a.in_seq  , a.in_rev  ,                                                            ");
			sb.append("        a.organ_cd, f_OrganNm(a.organ_cd) organ_nm, a.saup_cd , ' ' saup_nm,               ");
			sb.append("        a.in_jikmu,  a.in_jikchk, j.code_name1 jikchknm,                                   ");
			sb.append("        b.a_no    , b.a_weight, b.accountability,  b.success_key, b.success_key2, b.success_key3, b.finish  ,              ");
			sb.append("        a.in_1_sabun emp_no1, f_getempnm(a.in_1_sabun) emp_nm1, in_1_saupdan,              ");
			sb.append("        b.in_seq_up, b.in_rev_up, b.a_no_up,                                               ");
			sb.append("        a.in_2_sabun emp_no2, f_getempnm(a.in_2_sabun) emp_nm2, in_2_saupdan,              ");
			sb.append("       (SELECT NVL(MAX('Y'),'N')  child                      ");
			//sb.append("        FROM   pa00.t_payb005t@lnk_cpmis x,                  ");
			//sb.append("               pa00.t_payb006t@lnk_cpmis y                   ");
			sb.append("        FROM   t_payb005t x,                  ");
			sb.append("               t_payb006t y                   ");

			sb.append("        WHERE  x.in_year  = y.in_year                        ");
			sb.append("        AND    x.in_sabun = y.in_sabun                       ");
			sb.append("        AND    x.in_seq   = y.in_seq                         ");
			sb.append("        AND    x.in_rev   = y.in_rev                         ");
			sb.append("        AND    x.in_year     = ?                             ");
			sb.append("        AND    x.in_seq     <> '0'                           ");
			sb.append("        AND    x.in_pyung_gb = 'P'                           ");
			sb.append("        AND    x.in_1_sabun  = a.in_sabun                    ");
//			sb.append("        AND    y.in_seq_up   = a.in_seq                      ");
//			sb.append("        AND    y.in_rev_up   = a.in_rev                      ");
			sb.append("        AND    y.a_no_up     = b.a_no                        ");
			sb.append("        AND    rownum      = 1 ) child                       ");
			//sb.append(" FROM   pa00.t_payb005t@lnk_cpmis a,                                                       ");
			//sb.append("        pa00.t_payb006t@lnk_cpmis b,                                                       ");
			//sb.append("        pa00.v_jikchk_r@lnk_cpmis j,                                                       ");

			sb.append(" FROM   t_payb005t a,                                                       ");
			sb.append("        t_payb006t b,                                                       ");
			sb.append("        v_jikchk_r j,                                                       ");


			sb.append("        (                                                                                  ");
			sb.append("         SELECT in_year, in_sabun, in_seq, max(in_rev) in_rev                              ");
			//sb.append("         FROM   pa00.t_payb005t@lnk_cpmis                                                  ");
			sb.append("         FROM   t_payb005t                                                  ");
			sb.append("         WHERE  in_year     =  ?                                                         ");
			sb.append("         AND    in_seq     <> '0'                                                          ");
			sb.append("         AND    in_pyung_gb = 'P'                                                          ");
			sb.append("         AND    in_1_sabun  =  ?                                                         ");
			sb.append("         GROUP BY in_year, in_sabun, in_seq                                                ");
			sb.append("        ) x                                                                                ");
			sb.append(" WHERE  x.in_year  = a.in_year                                                             ");
			sb.append(" AND    x.in_sabun = a.in_sabun                                                            ");
			sb.append(" AND    x.in_seq   = a.in_seq                                                              ");
			sb.append(" AND    x.in_rev   = a.in_rev                                                              ");
			sb.append(" AND    a.in_pyung_gb = 'P'                                                                ");
			sb.append(" AND    a.in_year  = b.in_year                                                             ");
			sb.append(" AND    a.in_sabun = b.in_sabun                                                            ");
			sb.append(" AND    a.in_seq   = b.in_seq                                                              ");
			sb.append(" AND    a.in_rev   = b.in_rev                                                              ");
			sb.append(" AND    a.in_jikchk= j.code   (+)                                                          ");
			sb.append(" AND    nvl(b.a_no_up,0) = ?                                                      ");
			sb.append(" ORDER BY a.organ_cd, a.in_sabun, b.a_no                                                  ");

			// 조회
			Object[] param = {year, year, u_empno, a_no_up};
			rs = dbobject.executePreparedQuery(sb.toString(), param);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 * Method : 개인 성과책임 -> 성과목표
	 */
	public void getAccountObject(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			// Argument...
			String year    = request.getParameter("year"  );
			String empno   = request.getParameter("empno" );
			String in_seq  = request.getParameter("in_seq");
			String in_rev  = request.getParameter("in_rev");
			String a_no    = request.getParameter("a_no"  );

			if (year==null) return;

			System.out.println("empnm : " + empno + "," + in_seq + "," + in_rev + "," + a_no);

			StringBuffer sb = new StringBuffer();

			// SQL 작성
			sb.append(" SELECT in_sabun emp_no, in_seq, in_rev, a_no, o_no, o_weight,");
			sb.append("        object, plan, result,                              ");
			sb.append("        achieve_ex,                                        ");
			sb.append("        achieve_vg,                                        ");
			sb.append("        achieve_g ,                                        ");
			sb.append("        achieve_ni,                                        ");
			sb.append("        achieve_un,                                        ");
			sb.append("        score1    ,                                        ");
			sb.append("        bsc_acct_cd   ocid ,                               ");
			sb.append("        f_getbscnm(4,bsc_acct_cd)  oname                   ");
			//sb.append(" FROM   pa00.t_payb008t@lnk_cpmis                          ");
			sb.append(" FROM   t_payb008t                          ");
			sb.append(" WHERE  in_year  = ?                                       ");
			sb.append(" AND    in_sabun = ?                                       ");
			sb.append(" AND    in_seq   = ?                                       ");
			sb.append(" AND    in_rev   = ?                                       ");
			sb.append(" AND    a_no     = ?                                       ");
			sb.append(" ORDER BY a_no                                             ");


			// Connection
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// 조회
			Object[] param = {year,empno,in_seq, in_rev, a_no};
			rs = dbobject.executePreparedQuery(sb.toString(), param);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 * Method : 사장님 부터 성과책임목표 List BlackDown
	 */
	public void getTargetRoot(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			// Argument...
			String year    = request.getParameter("year"  );
			String empno   = "00000";
			String in_seq  = "";
			String in_rev  = "";

//			empno   = "01129";
//			in_seq  = "1";
//			in_rev  = "1";

			if (year==null) return;

			// Connection
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			StringBuffer sb = new StringBuffer();

			// 사번이 사장인 경우 직책 : '01'로 사장의 사번을 찾는다.
			if ("00000".equals(empno)){

			    sb.append(" SELECT in_year, in_sabun, in_seq, max(in_rev) in_rev   ");
		        //sb.append(" FROM   pa00.t_payb005t@lnk_cpmis                       ");
			    sb.append(" FROM   t_payb005t                       ");
		        sb.append(" WHERE  in_year     = ?                                 ");
		        sb.append(" AND    in_seq     <> '0'                               ");
		        sb.append(" AND    in_pyung_gb = 'P'                               ");
		        sb.append(" AND    in_jikchk   =  '01'                             ");
		        sb.append(" GROUP BY in_year, in_sabun, in_seq                     ");

				// 조회
				Object[] param = {year};
				rs = dbobject.executePreparedQuery(sb.toString(), param);

				DataSet dsBoss = new DataSet();
				dsBoss.load(rs);
				dsBoss.next();

				empno  = dsBoss.getString("in_sabun");
				in_seq = dsBoss.getString("in_seq");
				in_rev = dsBoss.getString("in_rev");
			}

			System.out.println("Boss Info : " + empno + "," + in_seq + "," + in_rev);

			sb = new StringBuffer();

			// SQL 작성
			sb.append(" SELECT a.in_sabun  emp_no, f_getempnm(a.in_sabun) emp_nm,   b.in_jikmu,        ");
			sb.append("        b.in_jikchk, j.code_name1   jikchk_nm,                                  ");
			sb.append("        b.organ_cd, f_OrganNm(b.organ_cd) organ_nm, b.saup_cd , ' ' saup_nm,    ");
			sb.append("        a.in_seq, a.in_rev, a.a_no, a.accountability, a.a_weight,               ");
			sb.append("        success_key,  success_key2, success_key3,                               ");
			sb.append("        c.o_no  , c.object  , c.o_weight, c.plan, c.result                      ");
			//sb.append(" FROM   pa00.t_payb006t@lnk_cpmis a,                                            ");
			//sb.append("        pa00.t_payb005t@lnk_cpmis b,                                            ");
			//sb.append("        pa00.t_payb008t@lnk_cpmis c,                                            ");
			//sb.append("        pa00.v_jikchk_r@lnk_cpmis j                                             ");

			sb.append(" FROM   t_payb006t a,                                            ");
			sb.append("        t_payb005t b,                                            ");
			sb.append("        t_payb008t c,                                            ");
			sb.append("        v_jikchk_r j                                             ");


			sb.append(" WHERE  a.in_year  = b.in_year                                                  ");
			sb.append(" AND    a.in_sabun = b.in_sabun                                                 ");
			sb.append(" AND    a.in_seq   = b.in_seq                                                   ");
			sb.append(" AND    a.in_rev   = b.in_rev                                                   ");
			sb.append(" AND    b.in_jikchk= j.code   (+)                                               ");
			sb.append(" AND    a.in_year  = c.in_year                                                  ");
			sb.append(" AND    a.in_sabun = c.in_sabun                                                 ");
			sb.append(" AND    a.in_seq   = c.in_seq                                                   ");
			sb.append(" AND    a.in_rev   = c.in_rev                                                   ");
			sb.append(" AND    a.a_no     = c.a_no                                                     ");
			sb.append(" AND    a.in_year  = ?                                                          ");
			sb.append(" AND    a.in_sabun = ?                                                          ");
			sb.append(" AND    a.in_seq   = ?                                                          ");
			sb.append(" AND    a.in_rev   = ?                                                          ");
			sb.append(" ORDER BY a_no, o_no                                                            ");

			// 조회
			Object[] param = {year, empno, in_seq, in_rev};
			rs = dbobject.executePreparedQuery(sb.toString(), param);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 * Method : 하위 성과책임목표  List BlackDown
	 */
	public void getTargetTree(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			// Argument...
			String year    = request.getParameter("year"  );
			String u_empno = request.getParameter("empno" );		// 상위자사번
			String a_no_up = request.getParameter("a_no"  );		// 상위자 성과책임
			String o_no_up = request.getParameter("o_no"  );		// 상위자 성과책임목표
			if (year==null) return;

			// Connection
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			System.out.println("getTargetTree : " + u_empno + "," + a_no_up +","+ o_no_up);

			StringBuffer sb = new StringBuffer();

			// SQL 작성
			sb.append("  SELECT a.in_sabun  emp_no    , f_getempnm(a.in_sabun  )      emp_nm   ,                      ");
			sb.append("         a.in_seq  , a.in_rev  ,                                                               ");
			sb.append("         a.organ_cd, f_OrganNm(a.organ_cd) organ_nm, a.saup_cd , ' ' saup_nm,                  ");
			sb.append("         a.in_jikmu,  a.in_jikchk, j.code_name1 jikchknm,                                      ");
			sb.append("         b.a_no    , b.a_weight, b.accountability,  b.success_key, b.success_key2, b.success_key3, b.finish  ,                 ");
			sb.append("         c.o_no    , c.object  , c.o_weight, c.plan, c.result,                                 ");
			sb.append("         a.in_1_sabun emp_no1, f_getempnm(a.in_1_sabun) emp_nm1, in_1_saupdan,                 ");
			sb.append("         b.in_seq_up, b.in_rev_up, b.a_no_up, c.o_no_up,                                       ");
			sb.append("         a.in_2_sabun emp_no2, f_getempnm(a.in_2_sabun) emp_nm2, in_2_saupdan,                 ");
			sb.append("        (SELECT NVL(MAX('Y'),'N')  child                                                       ");
			//sb.append("         FROM   pa00.t_payb005t@lnk_cpmis x,                                                   ");
			//sb.append("                pa00.t_payb006t@lnk_cpmis y,                                                   ");
			//sb.append("                pa00.t_payb008t@lnk_cpmis z                                                    ");

			sb.append("         FROM   t_payb005t x,                                                   ");
			sb.append("                t_payb006t y,                                                   ");
			sb.append("                t_payb008t z                                                    ");


			sb.append("         WHERE  x.in_year  = y.in_year                                                         ");
			sb.append("         AND    x.in_sabun = y.in_sabun                                                        ");
			sb.append("         AND    x.in_seq   = y.in_seq                                                          ");
			sb.append("         AND    x.in_rev   = y.in_rev                                                          ");
			sb.append("         AND    y.in_year  = z.in_year                                                         ");
			sb.append("         AND    y.in_sabun = z.in_sabun                                                        ");
			sb.append("         AND    y.in_seq   = z.in_seq                                                          ");
			sb.append("         AND    y.in_rev   = z.in_rev                                                          ");
			sb.append("         AND    x.in_year     = ?                                                              ");
			sb.append("         AND    x.in_seq     <> '0'                                                            ");
			sb.append("         AND    x.in_pyung_gb = 'P'                                                            ");
			sb.append("         AND    x.in_1_sabun  = a.in_sabun                                                     ");
			sb.append("         AND    z.in_seq_up   = a.in_seq                                                       ");
			sb.append("         AND    z.in_rev_up   = a.in_rev                                                       ");
			sb.append("         AND    y.a_no_up     = b.a_no                                                         ");
			sb.append("         AND    z.o_no_up     = c.o_no                                                         ");
			sb.append("         AND    rownum      = 1 ) child                                                        ");
			//sb.append("  FROM   pa00.t_payb005t@lnk_cpmis a,                                                          ");
			//sb.append("         pa00.t_payb006t@lnk_cpmis b,                                                          ");
			//sb.append("         pa00.t_payb008t@lnk_cpmis c,                                                          ");
			//sb.append("         pa00.v_jikchk_r@lnk_cpmis j,                                                          ");

			sb.append("  FROM   t_payb005t a,                                                          ");
			sb.append("         t_payb006t b,                                                          ");
			sb.append("         t_payb008t c,                                                          ");
			sb.append("         v_jikchk_r j,                                                          ");


			sb.append("         (                                                                                     ");
			sb.append("          SELECT in_year, in_sabun, in_seq, max(in_rev) in_rev                                 ");
			//sb.append("          FROM   pa00.t_payb005t@lnk_cpmis                                                     ");
			sb.append("          FROM   t_payb005t                                                     ");

			sb.append("          WHERE  in_year     =  ?                                                              ");
			sb.append("          AND    in_seq     <> '0'                                                             ");
			sb.append("          AND    in_pyung_gb = 'P'                                                             ");
			sb.append("          AND    in_1_sabun  = ?                                                               ");
			sb.append("          GROUP BY in_year, in_sabun, in_seq                                                   ");
			sb.append("         ) x                                                                                   ");
			sb.append("  WHERE  x.in_year  = a.in_year                                                                ");
			sb.append("  AND    x.in_sabun = a.in_sabun                                                               ");
			sb.append("  AND    x.in_seq   = a.in_seq                                                                 ");
			sb.append("  AND    x.in_rev   = a.in_rev                                                                 ");
			sb.append("  AND    a.in_pyung_gb = 'P'                                                                   ");
			sb.append("  AND    a.in_year  = b.in_year                                                                ");
			sb.append("  AND    a.in_sabun = b.in_sabun                                                               ");
			sb.append("  AND    a.in_seq   = b.in_seq                                                                 ");
			sb.append("  AND    a.in_rev   = b.in_rev                                                                 ");
			sb.append("  AND    a.in_jikchk= j.code   (+)                                                             ");
			sb.append("  AND    a.in_year  = c.in_year                                                                ");
			sb.append("  AND    a.in_sabun = c.in_sabun                                                               ");
			sb.append("  AND    a.in_seq   = c.in_seq                                                                 ");
			sb.append("  AND    a.in_rev   = c.in_rev                                                                 ");
			sb.append("  AND    b.a_no     = c.a_no                                                                   ");
			sb.append("  AND    nvl(b.a_no_up,0) like ?||'%'                                                          ");
			sb.append("  AND    nvl(c.o_no_up,0) like ?||'%'                                                          ");
			sb.append("  ORDER BY a.organ_cd, a.in_sabun, c.object, b.a_no                                                      ");

			// 조회
			Object[] param = {year, year, u_empno, a_no_up, o_no_up};
			rs = dbobject.executePreparedQuery(sb.toString(), param);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	//--- END -----------------------------------------------------------------------------------------
}
