/**
 * ���ϸ� : PeriodUtil.java
 * Desciption: ��������� ���� Utility Java
 * 2008.11.13 �򰡾��� �߰��۾��� ACES
 */

package com.nc.cool;

import java.sql.ResultSet;
import com.nc.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;
import com.nc.cool.ReqUtil;

/**
 * Class �� : AppConfigUtil
 * Description : �ý����� ȯ���� ����
 */

public class AppConfigUtil {

	public AppConfigUtil()
	{

	}

	/**
	 * Description: �ý����� ����Ÿ ������ ���Ѵ�.
	 * Method: insertPeriod
	 *
	 * @param request
	 * @param response
	 */
	public void getConfig (HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		DataSet ds = null;
		try {

			StringBuffer sb = new StringBuffer();

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			// �������, ������, ȭ��� ǥ���� ����.
			sb.append(" SELECT substr(nvl(fixedym, sysdt),1,6)    fixedym  ,                              ");
			sb.append("        nvl(curymyn, 'Y'              )    curymyn  ,                              ");
			sb.append("        sysdt                              sysdt    ,                              ");
			sb.append("        substr(nvl(showym,  sysdt),1,6)    showym   ,                              ");
			sb.append("        substr(nvl(showym,  sysdt),1,4)    showyear ,                              ");
			sb.append("        substr(nvl(showym,  sysdt),5,2)    showmonth                               ");
			sb.append(" FROM   (                                                                          ");
			sb.append("         SELECT max(fixedym)                                             fixedym,  ");
			sb.append("                max(curymyn)                                             curymyn,  ");
			sb.append("                to_char(sysdate,'yyyymmdd')                              sysdt  ,  ");
			sb.append("                max(case when curymyn = 'Y' then to_char(sysdate, 'yyyymm')        ");
			sb.append("                         else fixedym end)                               showym    ");
			sb.append("         FROM   tbzconfig                                                          ");
			sb.append("         WHERE  sysid = ?                                                          ");
			sb.append("         )                                                                         ");

			String sysid = request.getParameter("sysid")==""?"BSC":request.getParameter("sysid");

			Object[] paramQ = {sysid};

			rs = dbobject.executePreparedQuery(sb.toString(), paramQ);
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
	 * Description: ȭ�鿡 ������ YM�� ��ȸ�Ѵ�. JSP������ ȣ���մϴ�.
	 * Method: validatePeriod
	 *
	 * @param
	 * @param
	 * @return showym
	 */
	public String getShowYM () {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		String showym = "";
		String sysid = "BSC";

		try {
			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			sb.append(" SELECT substr(nvl(fixedym, sysdt),1,6)    fixedym  ,                              ");
			sb.append("        nvl(curymyn, 'Y'              )    curymyn  ,                              ");
			sb.append("        sysdt                              sysdt    ,                              ");
			sb.append("        substr(nvl(showym,  sysdt),1,6)    showym   ,                              ");
			sb.append("        substr(nvl(showym,  sysdt),1,4)    showyear ,                              ");
			sb.append("        substr(nvl(showym,  sysdt),5,2)    showmonth                               ");
			sb.append(" FROM   (                                                                          ");
			sb.append("         SELECT max(fixedym)                                             fixedym,  ");
			sb.append("                max(curymyn)                                             curymyn,  ");
			sb.append("                to_char(sysdate,'yyyymmdd')                              sysdt  ,  ");
			sb.append("                max(case when curymyn = 'Y' then to_char(sysdate, 'yyyymm')        ");
			sb.append("                         else fixedym end)                               showym    ");
			sb.append("         FROM   tbzconfig                                                          ");
			sb.append("         WHERE  sysid = ?                                                          ");
			sb.append("         )                                                                         ");

			params = new Object[] { sysid };

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

			if (rs != null) {
				while (rs.next()) {
					showym  = rs.getString("showym");
					String curymyn = rs.getString("curymyn");

					// �������� ǥ���ϴ� ��� ���б�� ǥ���մϴ�.
					if ("Y".equals(curymyn)){
						String year  = showym.substring(0,4);
						String month = showym.substring(4,6);

						if ("01".equals(month)||"02".equals(month)||"03".equals(month) ) month = "12";
						if ("04".equals(month)||"05".equals(month)||"06".equals(month) ) month = "03";
						if ("07".equals(month)||"08".equals(month)||"09".equals(month) ) month = "06";
						if ("10".equals(month)||"11".equals(month)||"12".equals(month) ) month = "09";

						// 1 �б��� ��� ���⵵�� ��������.
						if ("01".equals(month)||"02".equals(month)||"03".equals(month) ) {
							int iYear = Integer.parseInt(year) - 1;
							year = String.valueOf(iYear);
						}

						showym = year + month;
					}

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

		return showym;
	}


	/**
	 * Description: �ý����� ����Ÿ ������ �����Ѵ�.
	 * Method: insertPeriod
	 *
	 * @param request
	 * @param response
	 */
	public void setConfig(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject   = new DBObject(conn.getConnection());

			request.setAttribute("rslt" ,"false");

			// SYSID = BSC�� ����
			//String sysid   = request.getParameter("sysid")==""?"BSC":request.getParameter("sysid");

			String sysid   = "BSC";
			String fixedym = request.getParameter("fixedym")==""?"":request.getParameter("fixedym");
			String curymyn = request.getParameter("curymyn")==""?"":request.getParameter("curymyn");

			// Update ...
			StringBuffer sbU = new StringBuffer();

			sbU.append(" UPDATE tbzconfig SET                 ");
		    sbU.append("        fixedym      = ?              ");
		    sbU.append("       ,curymyn      = ?              ");
		    sbU.append(" WHERE  sysid        = ?              ");

			Object[] paramU = {fixedym, curymyn, sysid};

			if (dbobject.executePreparedUpdate(sbU.toString(),paramU) < 0) {

				StringBuffer sbI = new StringBuffer();

				sbI.append(" INSERT INTO tbzconfig                ");
			    sbI.append(" (sysid, fixedym, curymyn )           ");
			    sbU.append(" VALUES (?,?,?)                       ");

				Object[] paramI = {fixedym, curymyn};

				dbobject.executePreparedUpdate(sbI.toString(), paramI);
			}

			conn.commit();
			request.setAttribute("rslt" ,"true");

		} catch (Exception e) {
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
}
