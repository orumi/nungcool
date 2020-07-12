package com.nc.xml;

import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;
import com.nc.cool.ReqUtil;

public class CodeUtil {

	/**
	 * Method : getCodeList
	 * Desc   : �ڵ������� ������.
	 *
	 * Rev.   : 1.2008.10.31 by PHG.  Init Version.
	 *
	 * @param request
	 * @param respons
	 */
	public void getCodeList(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			// ��з��ڵ�� ldiv_cd = '000', �Һз��ڵ�� ldiv_cd = '��з��ڵ�'
			String div_cd = request.getParameter("div_cd")==null?"%":request.getParameter("div_cd");
			String div_nm  = Util.getUTF(request.getParameter("div_nm"))==null?"%":Util.getUTF(request.getParameter("div_nm"));


			StringBuffer sb = new StringBuffer();

			sb.append(" SELECT ldiv_cd, sdiv_cd, div_nm, div_snm, ord, use_yn  ");
			sb.append(" FROM   tz_comcode                                      ");
			sb.append(" WHERE  ldiv_cd like ?                                  ");
			sb.append(" AND    div_nm  like ?||'%'                             ");
			sb.append(" ORDER BY ord, ldiv_cd                                  ");

			Object[] params = {div_cd,div_nm};

	       	conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sb.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds", ds);
		} catch (Exception e) {
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}


	/**
	 * Method : setCodeInfo
	 * Desc   : �ڵ������� ������.
	 *
	 * Rev.   : 1.2008.10.31 by PHG.  Init Version.
	 *
	 * @param request
	 * @param respons
	 */
	public void setCodeInfo(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject   = new DBObject(conn.getConnection());

			request.setAttribute("rslt" ,"false");

			// ��з��ڵ�� ldiv_cd = '000', �Һз��ڵ�� ldiv_cd = '��з��ڵ�'
			String tag     = request.getParameter("tag"  );
			String ldiv_cd = request.getParameter("ldiv_cd");
			String sdiv_cd = request.getParameter("sdiv_cd");

			String userId = (String)request.getSession().getAttribute("userId");

			// ���,����
			if ("U".equals(tag)){

				/*String div_nm  = Util.getUTF(request.getParameter("div_nm"));
				String div_snm = Util.getUTF(request.getParameter("div_snm"));*/

				String div_nm  = request.getParameter("div_nm");
				String div_snm = request.getParameter("div_snm");

				//String div_nm  = Util.getEUCKR(request.getParameter("div_nm"));
				//String div_snm = Util.getEUCKR(request.getParameter("div_snm"));


				String ord     = request.getParameter("ord"    );
				String use_yn  = request.getParameter("use_yn" );


				// Insert...
				StringBuffer sbU = new StringBuffer();

				sbU.append(" update tz_comcode set       ");
				sbU.append("        div_nm     = ? ,     ");
				sbU.append("        div_snm    = ? ,     ");
				sbU.append("        ord        = ? ,     ");
				sbU.append("        use_yn     = ? ,     ");
				sbU.append("        upd_userid = ? ,     ");
				sbU.append("        upd_date  =  sysdate ");
				sbU.append(" where  ldiv_cd  = ?         ");
				sbU.append(" and    sdiv_cd  = ?         ");

				Object[] paramU = {div_nm, div_snm, ord, use_yn, userId, ldiv_cd, sdiv_cd };

				// Update ������ ������ return = 0 �̹Ƿ� �Ʒ� Insert�Ѵ�.
				if (dbobject.executePreparedUpdate(sbU.toString(),paramU) < 1){

					StringBuffer sbI = new StringBuffer();

					sbI.append(" insert into tz_comcode (                                          ");
					sbI.append("   ldiv_cd     ,  sdiv_cd     ,  div_nm      ,  div_snm     ,      ");
					sbI.append("   ord         ,  use_yn      ,                                    ");
					sbI.append("   inp_date    ,  inp_userid  ,  upd_date    , upd_userid      )   ");
					sbI.append(" values (?,?,?,?,   ?,?,          ");
					sbI.append("         sysdate, ?, sysdate, ? ) ");

					Object[] paramI = {ldiv_cd    ,  sdiv_cd    , div_nm       ,  div_snm      ,
					              		ord       ,  use_yn     , userId       , userId        };

					dbobject.executePreparedUpdate(sbI.toString(),paramI);
				}

			// ����ó��...
			} else if ("D".equals(tag)){
				String strD = "DELETE FROM tz_comcode WHERE ldiv_cd=? AND sdiv_cd = ? ";
				Object[] param = {ldiv_cd, sdiv_cd};
				dbobject.executePreparedUpdate(strD,param);

				if ("000".equals(ldiv_cd)){
					String strD2 = "DELETE FROM tbzcomcode WHERE ldiv_cd=? ";
					Object[] param2 = {sdiv_cd};
					dbobject.executePreparedUpdate(strD2,param2);
				}
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
