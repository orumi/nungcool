/**
 * ���ϸ� : PeriodUtil.java
 * Desciption: ��������� ���� Utility Java
 */

package com.nc.cool;

import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;

/**
 * Class �� : PeriodUtil
 * Description : ���������� ���� Utility Class
 */
public class PeriodUtil {
	/**
	 * Description: ���������� ó���Ѵ�.
	 * Method: insertPeriod
	 *
	 * @param request
	 * @param response
	 */
	public void processPeriod (HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		DataSet ds = null;
		try {
			StringBuffer sbI = new StringBuffer();
			StringBuffer sbU = new StringBuffer();
			StringBuffer sbD = new StringBuffer();
			StringBuffer sbQ = new StringBuffer();
			String year   = request.getParameter("year")==null?"":request.getParameter("year");
			String div_cd = request.getParameter("div_cd")==null?"":request.getParameter("div_cd");
			String div_nm = request.getParameter("div_nm")==null?"":Util.getUTF(request.getParameter("div_nm"));

			String mode       = request.getParameter("mode")==null?"":request.getParameter("mode");
			String start_dt   = request.getParameter("start_dt")==null?"":request.getParameter("start_dt").replaceAll("-", "");
			String end_dt     = request.getParameter("end_dt")==null?"":request.getParameter("end_dt").replaceAll("-", "");
			String inp_userid = (String)request.getSession().getAttribute("userId");
			String upd_userid = inp_userid;

			String q1        = request.getParameter("q1" )==null?"N":request.getParameter("q1");
			String q2        = request.getParameter("q2" )==null?"N":request.getParameter("q2");
			String q3        = request.getParameter("q3" )==null?"N":request.getParameter("q3");
			String q4        = request.getParameter("q4" )==null?"N":request.getParameter("q4");

			String m01       = request.getParameter("m01" )==null?"N":request.getParameter("m01");
			String m02       = request.getParameter("m02" )==null?"N":request.getParameter("m02");
			String m03       = request.getParameter("m03" )==null?"N":request.getParameter("m03");
			String m04       = request.getParameter("m04" )==null?"N":request.getParameter("m04");
			String m05       = request.getParameter("m05" )==null?"N":request.getParameter("m05");
			String m06       = request.getParameter("m06" )==null?"N":request.getParameter("m06");
			String m07       = request.getParameter("m07" )==null?"N":request.getParameter("m07");
			String m08       = request.getParameter("m08" )==null?"N":request.getParameter("m08");
			String m09       = request.getParameter("m09" )==null?"N":request.getParameter("m09");
			String m10       = request.getParameter("m10" )==null?"N":request.getParameter("m10");
			String m11       = request.getParameter("m11" )==null?"N":request.getParameter("m11");
			String m12       = request.getParameter("m12" )==null?"N":request.getParameter("m12");

			Object[] paramsI;
			Object[] paramsU;
			Object[] paramsD;
			Object[] paramsQ;

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			if (mode.equals("P")) {

				sbI.append("INSERT INTO tbzperiod (year, div_cd, div_nm, start_dt, end_dt, inp_userid, upd_userid,  ");
				sbI.append("                       q1, q2, q3, q4,m01,m02,m03,m04,m05,m06,m07,m08,m09,m10,m11,m12 ) ");
				sbI.append("VALUES (?,?,?,?,?,?,?,?,?,?,??,?,?,?,?,?,?,?,?,?,?,?)");
				paramsI = new Object[] { year, div_cd, div_nm, start_dt, end_dt, inp_userid, upd_userid,
										 q1, q2, q3, q4,m01,m02,m03,m04,m05,m06,m07,m08,m09,m10,m11,m12};

				sbU.append("UPDATE tbzperiod      ");
				sbU.append("   SET year       = ? ");
				sbU.append("     , div_nm     = ? ");
				sbU.append("     , start_dt   = ? ");
				sbU.append("     , end_dt     = ? ");
				sbU.append("     , upd_userid = ? ");
				sbU.append("     , q1  = ?        ");
				sbU.append("     , q2  = ?        ");
				sbU.append("     , q3  = ?        ");
				sbU.append("     , q4  = ?        ");
	 			sbU.append("     , m01 = ?        ");
				sbU.append("     , m02 = ?        ");
				sbU.append("     , m03 = ?        ");
				sbU.append("     , m04 = ?        ");
				sbU.append("     , m05 = ?        ");
				sbU.append("     , m06 = ?        ");
				sbU.append("     , m07 = ?        ");
				sbU.append("     , m08 = ?        ");
				sbU.append("     , m09 = ?        ");
				sbU.append("     , m10 = ?        ");
				sbU.append("     , m11 = ?        ");
				sbU.append("     , m12 = ?        ");
				sbU.append("WHERE div_cd = ? and year = ? ");

				paramsU = new Object[] { year, div_nm, start_dt, end_dt, upd_userid,
										 q1, q2, q3, q4,m01,m02,m03,m04,m05,m06,m07,m08,m09,m10,m11,m12,
										 div_cd, year };


				if(dbobject.executePreparedUpdate(sbU.toString(), paramsU) < 1)
					dbobject.executePreparedUpdate(sbI.toString(), paramsI);
			}
			else if(mode.equals("D")){
				sbD.append("DELETE FROM tbzperiod WHERE year = ? and div_cd = ? ");
				paramsD = new Object[] { year, div_cd };
				dbobject.executePreparedUpdate(sbD.toString(), paramsD);
			}
			else if(mode.equals("yCopy")){



			}
			conn.commit();

			sbQ.append(" SELECT   year, div_cd, div_nm,                                                                              ");
			sbQ.append("              to_char(to_date(start_dt,'YYYYMMDD'),'yyyy')||'-'||                                            ");
			sbQ.append("              to_char(to_date(start_dt,'YYYYMMDD'),'mm')||'-'||                                              ");
			sbQ.append("              to_char(to_date(start_dt,'YYYYMMDD'),'dd') as start_dt,                                        ");
			sbQ.append("              to_char(to_date(end_dt,'YYYYMMDD'),'yyyy')||'-'||                                              ");
			sbQ.append("              to_char(to_date(end_dt,'YYYYMMDD'),'mm')||'-'||                                                ");
			sbQ.append("              to_char(to_date(end_dt,'YYYYMMDD'),'dd') as end_dt,                                            ");
			sbQ.append("          inp_userid, inp_date, upd_userid, upd_date,                                                        ");
			sbQ.append("           CASE WHEN start_dt <= TO_CHAR (SYSDATE, 'yyyyMMdd') and end_dt >= TO_CHAR (SYSDATE, 'yyyyMMdd')   ");
			sbQ.append("                THEN 'Y'                                                                                     ");
			sbQ.append("           WHEN end_dt < TO_CHAR (SYSDATE, 'yyyyMMdd')                                                       ");
			sbQ.append("                THEN 'E'                                                                                     ");
			sbQ.append("           WHEN start_dt > TO_CHAR (SYSDATE, 'yyyyMMdd')                                                     ");
			sbQ.append("                THEN 'C'                                                                                     ");
			sbQ.append("            ELSE 'E'                                                                                         ");
			sbQ.append("         END AS div_yn ,                                                                                     ");
			sbQ.append("         q1, q2, q3, q4,                                                                                     ");
			sbQ.append("         m01,m02,m03,m04,m05,m06,m07,m08,m09,m10,m11,m12                                                     ");
			sbQ.append("     FROM tbzperiod where year = ?                                                                      ");
			sbQ.append(" ORDER BY YEAR, div_cd                                                                                       ");

			paramsQ = new Object[]{year};
			rs = dbobject.executePreparedQuery(sbQ.toString(), paramsQ);
			ds = new DataSet();
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

	/**
	 * Description: ���������� �����Ѵ�.
	 * Method: insertPeriod
	 *
	 * @param request
	 * @param response
	 */
	public void updatePeriod (HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			StringBuffer sb = new StringBuffer();
			Object[] params = null;
			String year = request.getParameter("year");
			String div_cd = request.getParameter("div_cd");
			String div_nm = request.getParameter("div_nm");
			String start_dt = request.getParameter("start_dt");
			String end_dt = request.getParameter("end_dt");
			String upd_userid = (String)request.getSession().getAttribute("userId");

			if (div_cd == null || "".equals(div_cd)) {
			} else {
				sb.append("UPDATE tbzperiod ")
				  .append("   SET year = ? ")
				  .append(",      div_nm = ? ")
				  .append(",      start_dt = ? ")
				  .append(",      end_dt = ? ")
				  .append(",      upd_userid = ? ")
				  .append("WHERE div_cd = ? ");
				params = new Object[] { year, div_nm, start_dt, end_dt, upd_userid, div_cd };

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);

				dbobject = new DBObject(conn.getConnection());
				dbobject.executePreparedUpdate(sb.toString(), params);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/**
	 * Description: ���������� �����Ѵ�.
	 * Method: deletePeriod
	 *
	 * @param request
	 * @param response
	 */
	public void deletePeriod (HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			String div_cd = null;
			div_cd = request.getParameter("div_cd");

			if (div_cd == null || "".equals(div_cd)) {
			} else {
				StringBuffer sb = new StringBuffer();
				Object[] params = null;
				sb.append("DELETE FROM tbzperiod WHERE div_cd = ? ");
				params = new Object[] { div_cd };

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);

				dbobject = new DBObject(conn.getConnection());
				dbobject.executePreparedUpdate(sb.toString(), params);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/**
	 * Description: ���������� �˻��Ѵ�.
	 * Method: selectPeriodList
	 *
	 * @param request
	 * @param response
	 */
	public void selectPeriodList (HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			sb.append(" SELECT   year, div_cd, div_nm, start_dt, end_dt,  ")
			  .append("          inp_userid, inp_date, upd_userid, upd_date ")
			  .append("     FROM tbzperiod ")
			  .append(" ORDER BY YEAR, div_cd ");

			//params = new Object[] { };
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

	/**
	 * Description: [�Ǵ�] div_cd, year�� �Է¹޾� �������� ���� ���θ� �Ǵ��Ѵ�.
	 * Method: validatePeriod
	 *
	 * @param div_cd
	 * @param year
	 * @return periodvalidate
	 */
	public String validatePeriod (String div_cd, String year) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		String periodvalidate = "N";

		try {
			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			sb.append(" SELECT NVL(MAX(CASE ")
			.append("            WHEN start_dt <= TO_CHAR (SYSDATE, 'yyyyMMdd') AND TO_CHAR (SYSDATE, 'yyyyMMdd') <= end_dt ")
			.append("                THEN 'Y' ")
			.append("            ELSE 'N' ")
			.append("         END),'N') AS div_yn ")
			.append("   FROM tbzperiod p ")
			.append("  WHERE div_cd = ? AND YEAR = ? ");

			params = new Object[] { div_cd, year };
			//System.out.println(" div : "+ div_cd);
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sb.toString(),params);

			if (rs != null) {
				while (rs.next()) {
					periodvalidate = rs.getString("DIV_YN");
					//System.out.println("Y N Ȯ�� : "+periodvalidate);
					break;
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}

		return periodvalidate;
	}

	/**
	 * Description: [�Ǵ�] div_cd, year, mm�� �Է¹޾� �������� ���� ���θ� �Ǵ��Ѵ�.(JSP ȣ��)
	 * Method: getCheckCloseMM
	 *
	 * @param div_cd
	 * @param year
	 * @return periodvalidate
	 */
	public String getCheckCloseMM(String year, String div_cd, String mm) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		String mm_yn = "N";

		try {
			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			sb.append(" SELECT NVL(MAX(M" + mm + "),'N')     mm_yn  ");
			sb.append("   FROM tbzperiod                            ");
			sb.append("  WHERE YEAR = ? AND div_cd = ?              ");

			params = new Object[] {year, div_cd};
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

			if (rs != null) {
				while (rs.next()) {
					mm_yn = rs.getString("mm_yn");
					break;
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
		return mm_yn;
	}

	/**
	 * Description: [�Ǵ�] div_cd, year�� �Է¹޾� �������� ���� ���θ� �Ǵ��Ѵ�.
	 * Method: validatePeriod
	 *
	 * @param div_cd
	 * @param year
	 * @return periodvalidate
	 */
	public void CheckPeriod(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			String year   = request.getParameter("year"  );
			String div_cd = request.getParameter("div_cd");

			System.out.println("Year : " + year + ", div_cd :" + div_cd);

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// GET DETAIL;
			StringBuffer sb =  new StringBuffer();
			sb.append(" SELECT NVL(MAX(CASE ")
			.append("            WHEN start_dt <= TO_CHAR (SYSDATE, 'yyyyMMdd') AND TO_CHAR (SYSDATE, 'yyyyMMdd') <= end_dt ")
			.append("                THEN 'Y' ")
			.append("            ELSE 'N' ")
			.append("         END),'N') AS div_yn ")
			.append("   FROM tbzperiod p ")
			.append("  WHERE div_cd = ? AND YEAR = ? ");

			System.out.println(sb.toString());

			Object[] pmSQL =  {div_cd, year};
			rs = dbobject.executePreparedQuery(sb.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("CheckPeriod : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}//-- method getComCode


	public void setPeriodYearCopy(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
	    int rslt = 0;

		try {

			String fmyear = request.getParameter("fmyear")==null?"":request.getParameter("fmyear");
			String toyear = request.getParameter("toyear")==null?"":request.getParameter("toyear");
			String userId   = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
//			String userId = "admin";
			//fmyear = "2007";
			//toyear ="2008";

			if ("".equals(fmyear)||"".equals(toyear)){
				request.setAttribute("rslt","false");
				return;
			}

			System.out.println("\n\n" );
			System.out.println("=========================================================================");
			System.out.println("Period Year Copy : From " + fmyear + " To " + toyear );

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

//			 2-2. ��ǥ TREESCORE  ����
			String strD = " ";
			strD += " delete tbzperiod where year=?  ";
			dbobject.executePreparedUpdate(strD, new Object[]{toyear});


			// 2-2. ��ǥ TREESCORE  ����
			String strS = " ";
			strS += " insert into tbzperiod                                        ";
			strS += " (YEAR, DIV_CD, DIV_NM, START_DT, END_DT, INP_USERID, UPD_USERID)              ";
			strS += " select ? YEAR, DIV_CD, DIV_NM, ?||substr(START_DT,5,4),?||substr(END_DT,5,4), ?, ?  ";
			strS += " from tbzperiod where year=?  ";

			dbobject.executePreparedUpdate(strS, new Object[]{toyear, toyear, toyear, userId, userId,  fmyear});
			conn.commit();

			request.setAttribute("rslt","true");

			System.out.println("=========================================================================");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

}
