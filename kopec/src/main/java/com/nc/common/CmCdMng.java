package com.nc.common;

import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.cool.ReqUtil;
import com.nc.sql.CoolConnection;
import com.nc.util.ConvUtil;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class CmCdMng {
	//생성자
	public CmCdMng(){

	}

	/**
	 * 코드 리스트 조회
	 * @param request
	 * @param response
	 * @throws UnsupportedEncodingException
	 */
	public void getCodeList(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try{
			String ldiv_cd = ReqUtil.getParamu(request, "ldiv_cd", "");
			String sdiv_cd = ReqUtil.getParamu(request, "sdiv_cd", "");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			StringBuffer sql = new StringBuffer();
			sql.append("select ldiv_cd, sdiv_cd, div_nm, div_snm, mng1, mng2, ord, use_yn from TZ_COMCODE where ldiv_cd = ? and sdiv_cd like ? order by nvl(ord, 999), sdiv_cd, sdiv_cd");
			Object[] params = {ldiv_cd, "".equals(sdiv_cd)?"%":sdiv_cd};
			rs = dbobject.executePreparedQuery(sql.toString(),params);
			DataSet ds = new DataSet();
			ds.load(rs);
			request.setAttribute("ds", ds);

		}catch(Exception e){
		}finally{
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/**
	 * 코드 설정 수정, 추가, 삭제
	 * @param request
	 * @param response
	 */
	public void setCodeDefine(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try{
			String actGubn = ReqUtil.getParamu(request, "actGubn", "");
			String ldiv_cd = ReqUtil.getParamu(request, "ldiv_cd", "");
			String sdiv_cd = ReqUtil.getParamu(request, "sdiv_cd", "");
			String div_nm = ReqUtil.getParamu(request, "div_nm", "");
			String div_short_mn = ReqUtil.getParamu(request, "div_short_mn", "");
			String mng1 = ReqUtil.getParamu(request, "mng1", "");
			String mng2 = ReqUtil.getParamu(request, "mng2", "");
			String ord = ReqUtil.getParamu(request, "sort_seq", "");
			String use_yn = ReqUtil.getParamu(request, "use_yn", "");
			String userId = (String)request.getSession().getAttribute("userId");

			if("".equals(actGubn)){return;}

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			StringBuffer sql = new StringBuffer();

			String sMsg = "실패";

			if("save".equals(actGubn)){
				sql.setLength(0);
				sql.append("update TZ_COMCODE set ");
				sql.append("div_nm= ?, div_snm= ?, mng1= ?, mng2= ?, ord= ?,  use_yn=?, upd_date = sysdate, upd_userid=?");
				sql.append("where  ldiv_cd = ? and sdiv_cd = ?");
				Object[] params = {div_nm, div_short_mn, mng1, mng2, ord,  use_yn, userId, ldiv_cd, sdiv_cd};
				int iURet = dbobject.executePreparedUpdate(sql.toString(),params);
				if(iURet > 0){
					sMsg = "성공적으로 수정되었습니다.";
				}else{
					sql.setLength(0);
					sql.append("insert into TZ_COMCODE (LDIV_CD, SDIV_CD, DIV_NM, DIV_SNM, MNG1, MNG2, ORD, USE_YN, INP_DATE, INP_USERID) ");
					sql.append("values(?,?,?,?,?,?,?,?,sysdate,?)");
					Object[] paramI = {ldiv_cd, sdiv_cd, div_nm, div_short_mn, mng1, mng2, ord,  use_yn, userId};
					int iIRet = dbobject.executePreparedUpdate(sql.toString(),paramI);
					if(iIRet < 1){
						sMsg = "실패";
					}else{
						sMsg = "성공적으로 등록되었습니다.";
					}
				}
				if("실패".equals(sMsg)){
					sMsg = "요청하신 작업을 수행하는 데 실패했습니다.";
					conn.rollback();
				}else{
					conn.commit();
				}
			}else if("del".equals(actGubn)){
				sql.setLength(0);
				sql.append("delete TZ_COMCODE where LDIV_CD = ? and SDIV_CD = ?");
				Object[] params = {ldiv_cd, sdiv_cd};
				if(dbobject.executePreparedUpdate(sql.toString(),params) < 0){
					sMsg = "실패";
				}else{
					sMsg = "성공적으로 삭제되었습니다.";
				}
				if("실패".equals(sMsg)){
					sMsg = "코드를 삭제하는 데 실패했습니다.";
					conn.rollback();
				}else{
					conn.commit();
				}
			}
			request.setAttribute("sMsg", sMsg);

		}catch(Exception e){
			request.setAttribute("sMsg", "다음과 같은 에러가 발생하였습니다. \\n("+e.toString().replaceAll("\"", "").replaceAll("\'", "").replaceAll("\n", "\\\\n")+")");
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}finally{
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}


}
