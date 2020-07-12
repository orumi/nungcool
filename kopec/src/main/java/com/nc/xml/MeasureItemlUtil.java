package com.nc.xml;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.math.Expression;
import com.nc.math.ExpressionParser;
import com.nc.sql.CoolConnection;
import com.nc.util.Common_Data;
import com.nc.util.CoolFile;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.ServerStatic;
import com.nc.util.SmartUpload;
import com.nc.util.Util;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.ByUserIdFileRenamePolicy;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
//import com.sun.corba.se.ActivationIDL.Server;

public class MeasureItemlUtil {

	public MeasureItemlUtil() {
		// TODO Auto-generated constructor stub
	}

	/*
	 * Method : getUserMeasure
	 * Desc   : 사용자에게 할당된 지표List를 가져옴.
	 */

	public void getUserMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year      = request.getParameter("year");
			String sbuid     = request.getParameter("sbuid")==null?"%":request.getParameter("sbuid");
			String itemfixed = request.getParameter("itemfixed")==null?"N":request.getParameter("itemfixed");

			if (year==null) return;

			String groupId = (String)request.getSession().getAttribute("groupId");
			String userId  = (String)request.getSession().getAttribute("userId");

			//int group = 1;
			int group = 5;

			if (groupId!=null) group = Integer.parseInt(groupId);
			if (group>3) return;

			if (group==1) userId="%";

			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			sb.append(" SELECT * FROM                                                                                                                                                        ");
			sb.append(" (SELECT A.YEAR AYEAR,A.MEASUREID AMID FROM TBLAUTHORITY A WHERE A.USERID LIKE ? AND YEAR=?                                                            ");
			sb.append(" UNION                                                                                                                                                                ");
			sb.append(" SELECT D.YEAR AYEAR,D.ID AMID FROM TBLMEASUREDEFINE D WHERE D.UPDATEID LIKE ? AND YEAR=?) AUT                                                       ");
			sb.append(" LEFT JOIN                                                                                                                                                            ");
			sb.append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,T.YEAR MTYEAR,D.MEASUREMENT,             ");
			sb.append("          COUNT(I.CODE) ITEMCOUNT, SUM(CASE WHEN ITEMFIXED = 'Y' THEN 1 ELSE null END) ITEMFIXED, D.UNIT                                                                    ");
			sb.append("  FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C, TBLITEM I                                                                                                ");
			sb.append(" WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND MEASUREMENT='계량' AND  D.ID =I.MEASUREID (+)                               ");
			sb.append(" GROUP BY T.ID ,T.PARENTID,T.CONTENTID,T.TREELEVEL,T.RANK,T.WEIGHT,C.NAME,D.FREQUENCY,T.YEAR,D.MEASUREMENT,D.UNIT                             ) MEA                              ");
			sb.append(" ON AUT.AMID=MEA.MCID AND AUT.AYEAR=MTYEAR                                                                                                                            ");
			sb.append(" LEFT JOIN                                                                                                                                                            ");
			sb.append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME                                                      ");
			sb.append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ                                                                  ");
			sb.append(" ON MEA.MPID=OBJ.OID                                                                                                                                                  ");
			sb.append(" LEFT JOIN                                                                                                                                                            ");
			sb.append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME                                                      ");
			sb.append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST                                                                        ");
			sb.append(" ON OBJ.OPID=PST.PID                                                                                                                                                  ");
			sb.append(" LEFT JOIN                                                                                                                                                            ");
			sb.append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME                                                      ");
			sb.append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC                                                                        ");
			sb.append(" ON PST.PPID=BSC.BID                                                                                                                                                  ");
			sb.append(" LEFT JOIN                                                                                                                                                            ");
			sb.append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME                                                      ");
			sb.append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? AND T.ID LIKE ?||'%') SBU                                                                        ");
			sb.append(" ON BSC.BPID=SBU.SID                                                                                                                                                  ");
			sb.append(" WHERE MID IS NOT NULL                                                                                                                                                ");


			// 고정항목만 조회하는 경우
			if ("Y".equals(itemfixed)){
					sb.append(" AND   ITEMFIXED > 0                                                                                                                                          ");
			}

			sb.append(" ORDER BY SRANK, BRANK,ORANK,PRANK,MRANK                                                                                                                                   ");

	         params = new Object[] {userId,year,userId,year,  year,year,year,year,year, sbuid};

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


	/*
	 * Method : getMeasItem
	 * Desc   : 사용자에게 할당된 지표List를 가져옴.
	 */

	public void getMeasItem(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year  = request.getParameter("year");
			String mcid  = request.getParameter("mcid");

			if (year==null) return;


			StringBuffer sb = new StringBuffer();
			Object[] params = null;
			sb.append(" select * from tblitem where measureid = ? order by code ");

	        params = new Object[] {mcid};

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

	/*
	 * Method : getMeasItemFixedValue
	 * Desc   : 주기별 지표항목값을 가져옴.
	 */

	public void getMeasItemFixedValue(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year     = request.getParameter("year");
			String mcid     = request.getParameter("mcid");
			String itemcode = request.getParameter("itemcode");

			//System.out.println("year :" + year + ", mcid:" + mcid + "itemcode : "+ itemcode);

			if (year==null) return;

			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			sb.append(" SELECT a.ym strdate, a.mcid measureid, a.frequency, a.code, a.itemname, a.itementry, a.itemfixed, b.actual                   ");
			sb.append(" FROM   (                                                                                                                     ");
			sb.append("         SELECT a.year||c.mm  ym, a.id  mcid, a.frequency, b.code, b.itemname, b.itementry, b.itemfixed                       ");
			sb.append("         FROM   tblmeasuredefine a, tblitem b,                                                                                ");
			sb.append("                 (                                                                                                            ");
			sb.append("                 select '년'   freq, ltrim(to_char(rownum*12, '00')) mm from tblmeasuredefine where rownum  = 1   union all   ");
			sb.append("                 select '반기' freq, ltrim(to_char(rownum*6 , '00')) mm from tblmeasuredefine where rownum <= 2   union all   ");
			sb.append("                 select '분기' freq, ltrim(to_char(rownum*3 , '00')) mm from tblmeasuredefine where rownum <= 4   union all   ");
			sb.append("                 select '월'   freq, ltrim(to_char(rownum*1 , '00')) mm from tblmeasuredefine where rownum <= 12              ");
			sb.append("                 ) c                                                                                                          ");
			sb.append("         WHERE  a.id        = b.measureid                                                                                     ");
			sb.append("         AND    a.frequency = c.freq                                                                                          ");
			sb.append("         AND    a.year = ?                                                                                                    ");
			sb.append("         AND    a.id   = ?                                                                                                    ");
			sb.append("         AND    b.code = ?                                                                                                    ");
			sb.append("         ) a,                                                                                                              	 ");
			sb.append("         tblitemactual b                                                                                                      ");
			sb.append(" where  a.ym   = substr(b.strdate(+),1,6)                                                                                     ");
			sb.append(" and    a.mcid = b.measureid(+)                                                                                               ");
			sb.append(" and    a.code = b.code     (+)                                                                                               ");
			sb.append(" order by ym                                                                                                                  ");


	         params = new Object[] {year, mcid, itemcode};

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
     * Method Name : setMeasItemFixedValue
     * Description : 년도 사업단 등록, 수정
     * Autho       : PHG
     * Create Date : 2008-04-04
     * History	          :
     * @throws SQLException
     */
	public void setMeasItemFixedValue(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }

			StringBuffer strSQL = new StringBuffer();

			// Loop를 돌며 Insert,Update,Delete...
			String year     = request.getParameter("year");
			String mcid     = request.getParameter("mcid");
			String itemcode = request.getParameter("itemcode");

			String userid = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String tag    = request.getParameter("tag")!=null?request.getParameter("tag"):"";



			// 삭제후 처리...
			if ("U".equals(tag)||"D".equals(tag)){
				strSQL.append("DELETE tblitemactual WHERE strdate LIKE ?||'%' and measureid = ? and code = ? ");

				System.out.println("DELETE ....TAG : "+tag+ ", year : " + year + ", measureid : " + mcid + ", code :" + itemcode);

				Object[] iPaD = {year, mcid, itemcode};
				dbobject.executePreparedUpdate(strSQL.toString(), iPaD);
			}

			// Insert or Update....
			if ("U".equals(tag)){

				// 저장
				String   arrData = request.getParameter("arrData");
				String[] recData = arrData.split("`");

				for (int i = 0; i < recData.length; i++) {

							String[] iPart = recData[i].split(",");

							String measureid    = iPart[0];
							String code         = iPart[1];
							String strdate      = iPart[2];
							String actual       = iPart[3];


							if(measureid != null){
								    strSQL = new StringBuffer();
									strSQL.append(" insert into tblitemactual (  ") ;
									strSQL.append("  measureid, code, strdate, inputdate, actual )  ") ;
									strSQL.append("  values ");
									strSQL.append(" (? ,?, ?,  to_char(sysdate,'YYYYMMDD'), ?   )" );

									Object[] iPa = {measureid, code, strdate, actual};
									dbobject.executePreparedUpdate(strSQL.toString(), iPa);

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

}