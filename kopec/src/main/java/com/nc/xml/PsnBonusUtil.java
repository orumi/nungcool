package com.nc.xml;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;

public class PsnBonusUtil {

    /** -------------------------------------------------------------------------------------------------------
     * Method Name : PsnBonusUtil
     * Description : 개인성과급 지급률 계산 Util
     * Author	   : PHG
     * Create Date : 2008-03-19
     * History	          :
     * @throws SQLException
     *  -------------------------------------------------------------------------------------------------------
     */


    /**
     * Method Name : getPsnBaseLine
     * Description : 개인성과급 기준정보
     * Author	   : PHG
     * Create Date : 2008-03-19
     * History	          :
     * @throws SQLException
     */
	public void getPsnBaseLine(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			String year          = request.getParameter("year");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append(" select                 ");
			sbSQL.append(" 		r_co       ,      ");
			sbSQL.append(" 		r1_s       ,      ");
			sbSQL.append(" 		r1_a       ,      ");
			sbSQL.append(" 		r1_b       ,      ");
			sbSQL.append(" 		r1_c       ,      ");
			sbSQL.append(" 		r1_d       ,      ");
			sbSQL.append(" 		r2_s       ,      ");
			sbSQL.append(" 		r2_a       ,      ");
			sbSQL.append(" 		r2_b       ,      ");
			sbSQL.append(" 		r2_c       ,      ");
			sbSQL.append(" 		r2_d       ,      ");
			sbSQL.append(" 		except_mh  ,      ");
			sbSQL.append(" 		except_bscmh,          ");
			sbSQL.append(" 		nvl(close_yn,'N') close_yn ");
			sbSQL.append(" from   tblpsnbaseline  ");
			sbSQL.append(" where  year  = ?       ");

			Object[] pmSQL =  {year};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getPsnBaseLine : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}//-- method getPsnBaseLine


    /**
     * Method Name : getPsnJikgub
     * Description : 개인성과급 직급정보
     * Author	   : PHG
     * Create Date : 2009-12-13
     * History	          :
     * @throws SQLException
     */
	public void getPsnJikgub(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			String year          = request.getParameter("year");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append(" select a.jikgub_cd, a.jikgub_nm, nvl(b.use_yn,'N') use_yn     \n");
			sbSQL.append(" from   (                                                      \n");
			sbSQL.append("         select  distinct                                      \n");
			sbSQL.append("                 jikgub_cd   ,                                 \n");
			sbSQL.append("                 jikgub_nm                                     \n");
			sbSQL.append("         from    pa00.user_master@lnk_cpmis                    \n");
			sbSQL.append("         where   jikgub_cd is not null                         \n");
			sbSQL.append("         and     out_day   is null                             \n");
			sbSQL.append("         order by jikgub_cd                                    \n");
			sbSQL.append("         ) a,                                                  \n");
			sbSQL.append("         tblpsnjikgub b                                        \n");
			sbSQL.append(" where  a.jikgub_cd = b.jikgub_cd (+)                          \n");
			sbSQL.append(" and    b.year(+)   =  ?                                       \n");
			sbSQL.append(" order by a.jikgub_cd                                          \n");


			Object[] pmSQL =  {year};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getPsnJikgub : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}//-- method getPsnJikgub

	/*
	 *  Method : setPsnJikgub
	 *  Desc.  : 성과급 지급률 직급정보 등록
     *  Author	    : PHG
     *  Create Date : 2008-03-19
     *  History	    :
	 *
	 */
	public void setPsnJikgub(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year = request.getParameter("year");
			String mode = request.getParameter("mode");
			String val  = request.getParameter("val");


			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			//--------------------------------------------------------------------------------------------
			//  매핑정의
			//--------------------------------------------------------------------------------------------
			if (!"".equals(val.trim())){

				// 기존자료 삭제
				String strD = "DELETE FROM tblpsnjikgub WHERE year=?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});


				String   jikgub_cd ;
				String   jikgub_nm ;
				String   use_yn    ;

				String[] mapstr = val.split("`");

				System.out.println("mapStr : " + val);

				for (int m = 0; m < mapstr.length; m++) {
					String[] iPart = mapstr[m].split(",");

					jikgub_cd  = iPart[0];
					jikgub_nm  = iPart[1];
					use_yn     = iPart[2];

					System.out.println("tblpsnjikgub : " + jikgub_cd + "-" + jikgub_nm);

					String strUI  = " insert into tblpsnjikgub (year, jikgub_cd, jikgub_nm, use_yn)";
						   strUI += " values (?,?,?,?)" ;

					Object[] pmUI = {year, jikgub_cd, jikgub_nm, use_yn};
					dbobject.executePreparedUpdate(strUI,pmUI);
				}

				conn.commit();
			}

			request.setAttribute("rslt","true");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	//---- setPsnBaseLine

	/*
	 *  Method : setPsnBaseLine
	 *  Desc.  : 성과급 지급률 기준정보 등록
     *  Author	    : PHG
     *  Create Date : 2008-03-19
     *  History	    :
	 *
	 */
	public void setPsnBaseLine(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String userId		= (String)request.getSession().getAttribute("userId");
			String mode			= request.getParameter("mode")==null?"":request.getParameter("mode");

			String year     = request.getParameter("year");


			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			System.out.println(mode + "Year : " + year);

			if("U".equals(mode)){

				String r_co     = request.getParameter("r_co"     )==null?"":request.getParameter("r_co"     );
				String r1_s     = request.getParameter("r1_s"     )==null?"":request.getParameter("r1_s"     );
				String r1_a     = request.getParameter("r1_a"     )==null?"":request.getParameter("r1_a"     );
				String r1_b     = request.getParameter("r1_b"     )==null?"":request.getParameter("r1_b"     );
				String r1_c     = request.getParameter("r1_c"     )==null?"":request.getParameter("r1_c"     );
				String r1_d     = request.getParameter("r1_d"     )==null?"":request.getParameter("r1_d"     );
				String r2_s     = request.getParameter("r2_s"     )==null?"":request.getParameter("r2_s"     );
				String r2_a     = request.getParameter("r2_a"     )==null?"":request.getParameter("r2_a"     );
				String r2_b     = request.getParameter("r2_b"     )==null?"":request.getParameter("r2_b"     );
				String r2_c     = request.getParameter("r2_c"     )==null?"":request.getParameter("r2_c"     );
				String r2_d     = request.getParameter("r2_d"     )==null?"":request.getParameter("r2_d"     );
				String except_mh= request.getParameter("except_mh")==null?"":request.getParameter("except_mh");
				String except_bscmh= request.getParameter("except_bscmh")==null?"":request.getParameter("except_bscmh");
				String close_yn = request.getParameter("close_yn" )==null?"N":request.getParameter("close_yn" );

				StringBuffer sbU = new StringBuffer();

				sbU.append("update tblpsnbaseline   ");
				sbU.append("  set  r_co       = ?   ");
				sbU.append("     , r1_s       = ?   ");
				sbU.append("     , r1_a       = ?   ");
				sbU.append("     , r1_b       = ?   ");
				sbU.append("     , r1_c       = ?   ");
				sbU.append("     , r1_d       = ?   ");
				sbU.append("     , r2_s       = ?   ");
				sbU.append("     , r2_a       = ?   ");
				sbU.append("     , r2_b       = ?   ");
				sbU.append("     , r2_c       = ?   ");
				sbU.append("     , r2_d       = ?   ");
				sbU.append("     , except_mh  = ?   ");
				sbU.append("     , except_bscmh  = ?   ");
				sbU.append("     , close_yn   = ?   ");
				sbU.append("where  year       = ?   ");

				Object[] paramU = {r_co,r1_s,r1_a,r1_b,r1_c,r1_d,  r2_s,r2_a,r2_b,r2_c,r2_d,  except_mh,except_bscmh,close_yn,  year};

				StringBuffer sbI = new StringBuffer();
				sbI.append("insert into tblpsnbaseline (                       ");
				sbI.append("year     ,r_co     ,                               ");
				sbI.append("r1_s     ,r1_a     ,r1_b     ,r1_c     ,r1_d     , ");
				sbI.append("r2_s     ,r2_a     ,r2_b     ,r2_c     ,r2_d     , ");
				sbI.append("except_mh,except_bscmh, close_yn                                 ");
				sbI.append(") values (                                         ");
				sbI.append("?,?,   ?,?,?,?,?,   ?,?,?,?,?,   ?,?,?               ");
				sbI.append(")                                                  ");

				Object[] paramI = {year,r_co,  r1_s,r1_a,r1_b,r1_c,r1_d,  r2_s,r2_a,r2_b,r2_c,r2_d,  except_mh,except_bscmh,close_yn};

				int ret = dbobject.executePreparedUpdate(sbU.toString(),paramU);
		        if(ret<1){
		        	System.out.println("Insert ...");
					dbobject.executePreparedUpdate(sbI.toString(),paramI);
				}
		        conn.commit();
		        //System.out.println("ret:"+ret);

			}else if("D".equals(mode)){

				// 개인성과 지급률 관련 일괄삭제.
				String strD = "delete tblpsnbaseline where year = ? ";
				dbobject.executePreparedUpdate(strD, new Object[]{year});

				strD ="delete tblpsnbizmh where year = ? ";
				dbobject.executePreparedUpdate(strD,  new Object[]{year});

				strD ="delete tblpsnbscscore where year = ? ";
				dbobject.executePreparedUpdate(strD,  new Object[]{year});

				strD ="delete tblpsnscore where year = ? ";
				dbobject.executePreparedUpdate(strD,  new Object[]{year});

				conn.commit();
			}

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	//---- setPsnBaseLine

    /**
     * Method Name : getPsnSbuMapping
     * Description : 단본부 매핑 : SBU의 List를 가져옴
     * Author	   : PHG
     * Create Date : 2008-03-19
     * History	          :
     * @throws SQLException
     */
	public void getPsnSbuMapping(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			String year          = request.getParameter("year");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append("    select sid sbuid, sname  sbunm, bscid, f_getbscnm(2,bsccid) bscnm, scid sbucid, bsccid                             ");
			sbSQL.append("    from                                                                                                         ");
			sbSQL.append("            (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank                          ");
			sbSQL.append("            from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id  ) sbu,          ");
			sbSQL.append("            (select * from tblsbubscmapping where year = ? ) map                                                 ");
			sbSQL.append("    where  sbu.sid=map.sbuid (+)                                                                                 ");
			sbSQL.append("    and    sbu.scid not in ('1','2')                                                                             ");
			sbSQL.append("    order by sid, scid                                                                                           ");

			Object[] pmSQL =  {year, year};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getPsnBaseLine : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}//-- method getPsnSbuMapping


	 /**
     * Method Name : getPsnBscMapping
     * Description : 단본부를 구함 : 단본부의 부서 List를 가져옴, 하드코딩 : 단본부 = 2
     * Author	   : PHG
     * Create Date : 2008-03-19
     * History	          :
     * @throws SQLException
     */
	public void getPsnBscMapping(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			String year          = request.getParameter("year");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append("   select sid sbuid, sname  sbunm, bid bscid, bname  bscnm, scid  sbucid, bcid bsccid                             ");
			sbSQL.append("   from                                                                                                                      ");
			sbSQL.append("           (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank                                       ");
			sbSQL.append("           from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id  ) sbu,                       ");
			sbSQL.append("           (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank srank                                       ");
			sbSQL.append("            from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id  ) bsc                       ");
			sbSQL.append("   where  sbu.sid=bsc.bpid                                                                                                   ");
			// 감사실은 부서수가 2개 밖에 안됨.   sbSQL.append("   and    sbu.scid in ('2','15')                                                                                                  ");
			sbSQL.append("   and    sbu.scid in ('2')                                                                                                  ");
			sbSQL.append("   order by bid, bcid                                                                                                        ");

			Object[] pmSQL =  {year, year};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getPsnBaseLine : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}//-- method getPsnSbuMapping


	 /**
     * Method Name : setPsnMapping
     * Description : 단본부, 부서연결.
     * Author	   : PHG
     * Create Date : 2008-03-19
     * History	          :
     * @throws SQLException
     */
	public void setPsnMapping(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year = request.getParameter("year");
			String mode = request.getParameter("mode");
			String val  = request.getParameter("val");


			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			//--------------------------------------------------------------------------------------------
			//  매핑정의
			//--------------------------------------------------------------------------------------------
			if (!"".equals(val.trim())){

				// 기존자료 삭제
				String strD = "DELETE FROM tblsbubscmapping WHERE year=?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});


				String   sbuid ;
				String   bscid ;
				String   sbucid;
				String   bsccid;

				String[] mapstr = val.split("`");

				System.out.println("mapStr : " + val);

				for (int m = 0; m < mapstr.length; m++) {
					String[] iPart = mapstr[m].split(",");

					sbuid  = iPart[0];
					bscid  = iPart[1];
					sbucid = iPart[2];
					bsccid = iPart[3];

					System.out.println("tblsbubscmapping : " + sbuid + "-" + bscid);

					String strUI  = " insert into tblsbubscmapping (year, sbuid, bscid, sbucid, bsccid)";
						   strUI += " values (?,?,?,?,?)" ;

					Object[] pmUI = {year,sbuid,bscid,sbucid,bsccid};
					dbobject.executePreparedUpdate(strUI,pmUI);
				}

				conn.commit();
			}

			request.setAttribute("rslt","true");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	//--- setPsnMapping

    /**
     * Method Name : getPsnGradeBase
     * Description : 개인성과급 5등급 배부표
     * Author	   : PHG
     * Create Date : 2008-03-19
     * History	          :
     * @throws SQLException
     */
	public void getPsnGradeBase(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			String year          = request.getParameter("year");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append(" select                 ");
			sbSQL.append(" 		org_cnt    ,      ");
			sbSQL.append(" 		org_s      ,      ");
			sbSQL.append(" 		org_a      ,      ");
			sbSQL.append(" 		org_b      ,      ");
			sbSQL.append(" 		org_c      ,      ");
			sbSQL.append(" 		org_d             ");
			sbSQL.append(" from   tblpsngradebase ");
			sbSQL.append(" where  year  = ?       ");

			Object[] pmSQL =  {year};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getPsnGradeBase : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}//-- method getPsnGradeBase


	 /**
     * Method Name : setPsnGrade
     * Description : 평가년도 5등급 배부표 설정 : 등록없음.
     * Author	   : PHG
     * Create Date : 2008-03-19
     * History	          :
     * @throws SQLException
     */
	public void setPsnGrade(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year = request.getParameter("year");
			String mode = request.getParameter("mode");
			String val  = request.getParameter("val");


			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			//--------------------------------------------------------------------------------------------
			//  매핑정의
			//--------------------------------------------------------------------------------------------
			if (!"".equals(val.trim())){

				// 기존자료 삭제
				String   org_cnt ;
				String   org_s ;
				String   org_a ;
				String   org_b ;
				String   org_c ;
				String   org_d ;

				String[] LineStr = val.split("`");

				//System.out.println("setPsnGrade LineStr : " + val);

				for (int m = 0; m < LineStr.length; m++) {
					String[] iPart = LineStr[m].split(",");

					org_cnt = iPart[0];
					org_s   = iPart[1];
					org_a   = iPart[2];
					org_b   = iPart[3];
					org_c   = iPart[4];
					org_d   = iPart[5];

					//System.out.println("setPsnGrade : " + org_cnt);

					String strUI  = " update tblpsngradebase set ";
						   strUI += "         org_s = ? "  ;
						   strUI += "       , org_a = ? "  ;
						   strUI += "       , org_b = ? "  ;
						   strUI += "       , org_c = ? "  ;
						   strUI += "       , org_d = ? "  ;
						   strUI += "  where year    = ? " ;
						   strUI += "  and   org_cnt = ? " ;

					Object[] pmUI = {org_s, org_a, org_b, org_c, org_d,    year, org_cnt};
					dbobject.executePreparedUpdate(strUI,pmUI);
				}

				conn.commit();
			}

			request.setAttribute("rslt","true");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	//--- setPsnGrade


	/*
	 *  Method : getPsnBscScore
	 *  Desc.  :  부서성과 조회
     *  Author	    : PHG
     *  Create Date : 2008-03-19
     *  History	    :
	 *
	 */
	public void getPsnBscScore(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year    = request.getParameter("year");
			String sbuid  = request.getParameter("sbuid")==null?"%":request.getParameter("sbuid");

			System.out.println(" getPsnBscScore : " + year + "-" + sbuid);

			StringBuffer sbSQL = new StringBuffer();
			sbSQL.append("  select                                                                ");
			sbSQL.append("          sbuid     ,                                                   ");
			sbSQL.append("          f_getbscnm(1,sbucid)  sbunm,                                  ");
			sbSQL.append("          bscid     ,                                                   ");
			sbSQL.append("          f_getbscnm(2,bsccid)  bscnm,                                  ");
			sbSQL.append("          score_qty ,                                                   ");
			sbSQL.append("          score_qly ,                                                   ");
			sbSQL.append("          score_sum ,                                                   ");
			sbSQL.append("          score_add ,                                                   ");
			sbSQL.append("          score_tot ,                                                   ");
			sbSQL.append("          grp_rank  ,                                                   ");
			sbSQL.append("          grade1    ,                                                   ");
			sbSQL.append("          grade2    ,                                                   ");
			sbSQL.append("          div_rate1 ,                                                   ");
			sbSQL.append("          div_rate2 ,                                                   ");
			sbSQL.append("          r_co      ,                                                   ");
			sbSQL.append("          r_co + div_rate1                                org_rate1,    ");
			sbSQL.append("          case when grade1 is null then r_co + div_rate2                ");
			sbSQL.append("               else r_co + div_rate1 + div_rate2                        ");
			sbSQL.append("          end          org_rate2                                        ");
			sbSQL.append("  from   tblpsnbscscore  a,                                             ");
			sbSQL.append("         tblpsnbaseline  b                                              ");
			sbSQL.append("  where  a.year  = b.year                                               ");
			sbSQL.append("  and    a.year  = ?                                                    ");
			sbSQL.append("  and    a.sbuid like ?                                                 ");
			sbSQL.append("  order by sbuid, bscid                                                 ");


	        Object[] params = {year, sbuid};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sbSQL.toString(),params);

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
	 *  Method : setPsnBscScore
	 *  Desc.  : 평가기관별 성과급 지급률 생성
     *  Author	    : PHG
     *  Create Date : 2008-03-22
     *  History	    :
	 *
	 */
	public void setPsnBscScore(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String userId	= (String)request.getSession().getAttribute("userId");
			String mode		= request.getParameter("mode")==null?"":request.getParameter("mode");

			String year     = request.getParameter("year");


			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			System.out.println("setPsnBscScore : Year : " + year);

			// 1. 기존자료 삭제.
			Object[] param = {year};
			String strD = "delete tblpsnbscscore where year = ? ";
			dbobject.executePreparedUpdate(strD, param);


			// 2. BSC 점수생성.
			StringBuffer sbI = new StringBuffer();
			sbI.append("  INSERT INTO tblpsnbscscore (                                                                                                  ");
			sbI.append("   year, sbuid, sbucid, bscid, bsccid,                                                                                          ");
			sbI.append("   score_qty, score_qly, score_sum, score_add, score_tot,                                                                       ");
			sbI.append("   grp_cnt, grp_rank, grade2)                                                                                                   ");
			sbI.append("  SELECT ?, sid, scid, bid, bcid,                                                                                               ");
			sbI.append("         mscore1, mscore2, scoresum, scoreadd, scoretot,                                                                        ");
			sbI.append("         grp_cnt, grp_rank, f_getBonusGrade(?,grp_cnt,grp_rank) grade2                                                     ");
			sbI.append("  FROM   (                                                                                                                      ");
			sbI.append("  select sid, scid,spid, max(sname)  sname,                                                                                     ");
			sbI.append("         bid, bcid,bpid, max(bname)  bname,                                                                                     ");
			sbI.append("         sum(case when measurement='계량'   then grade_score     end)   mscore1 ,                                               ");
			sbI.append("         sum(case when measurement='비계량' then grade_score    end)    mscore2 ,                                               ");
			sbI.append("         sum(grade_score)                               scoresum  ,                                                             ");
			sbI.append("         max(addscr)                                    scoreadd  ,                                                             ");
			sbI.append("         nvl(sum(grade_score),0) + nvl(max(addscr),0)   scoretot  ,                                                             ");
			sbI.append("         count(*) over (partition by sid )                                                           grp_cnt ,                  ");
			sbI.append("         rank()   over (partition by sid order by nvl(sum(grade_score),0) + nvl(max(addscr),0) desc) grp_rank                   ");
			sbI.append("  from                                                                                                                          ");
			sbI.append("          (select c.name cname,t.id cid,t.contentid ccid,t.parentid cpid,t.rank crank                                           ");
			sbI.append("          from tblcompany c, tblhierarchy t where t.treelevel=0 and t.year=? and t.contentid=c.id) com,                         ");
			sbI.append("          (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank                                           ");
			sbI.append("          from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id  ) sbu,                           ");
			sbI.append("          (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank                                           ");
			sbI.append("          from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc,                            ");
			sbI.append("          (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank                                           ");
			sbI.append("          from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst,                           ");
			sbI.append("          (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank                                           ");
			sbI.append("          from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj,                      ");
			sbI.append("          (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.measureid,           ");
			sbI.append("                  detaildefine, d.unit measunit,                                                                                ");
			sbI.append("                 entrytype, measuretype,                                                                                        ");
			sbI.append("                 frequency, equation, equationdefine,                                                                           ");
			sbI.append("                 etlkey, measurement,                                                                                           ");
			sbI.append("                 trend, e.planned, e.plannedbase, e.base,e.baselimit, e.limit,                                                  ");
			sbI.append("                 e.actual, e.grade, e.grade_score, e.score, nvl(e.grade_score, 0) rank_score                                    ");
			sbI.append("          from tblmeasure c, tbltreescore t, tblmeasuredefine d, tblmeasurescore e                                              ");
			sbI.append("          where t.treelevel=5 and t.year=? and t.contentid=d.id                                                                 ");
			sbI.append("          and  d.measureid = c.id                                                                                               ");
			sbI.append("          and  d.id = e.measureid (+)                                                                                           ");
			sbI.append("          and  e.strdate(+) like ?||'12%' ) mea,                                                                                ");
			sbI.append("          (select bid ebid, addscr, addscr_cmt from tblevalresult where year = ? and month='12')   eval                         ");
			sbI.append("  where  com.cid=sbu.spid                                                                                                       ");
			sbI.append("  and    sbu.sid=bsc.bpid                                                                                                       ");
			sbI.append("  and    bsc.bid=pst.ppid                                                                                                       ");
			sbI.append("  and    pst.pid=obj.opid                                                                                                       ");
			sbI.append("  and    obj.oid=mea.mpid                                                                                                       ");
			sbI.append("  and    bsc.bid=eval.ebid(+)                                                                                                   ");
			sbI.append("  group by sid, scid, bid, bcid, spid, bpid                                                                                     ");
			sbI.append("  )                                                                                                                             ");
			sbI.append("  ORDER BY sid, scid, grp_rank, bid                                                                                             ");


			Object[] paramI = {year,year,year,year,year,year,year,year,year,year };
			dbobject.executePreparedUpdate(sbI.toString(),paramI);
			System.out.println("sbI"+ sbI.toString());

			// 3. BSC부서등급에 따른 가중치 배분.
			// 		직할부서와 단본부는 자신의 등급을 그대로 활용.
			// 		단본부가 평가그룹인 부서들은 단본부의 등급을 1단계로 가져옴.

			//-----------------------------------------------------------------------------------------------
			// 1) 직할부서와 단본부는 자신의 등급을 그대로 활용.
			//-----------------------------------------------------------------------------------------------

//			StringBuffer sbU1 = new StringBuffer();
//			sbU1.append(" Update tblpsnscore       ");
//			sbU1.append("   Set  grade1 = grade2   ");
//			sbU1.append(" Where  year   = ?        ");
//
//			Object[] paramU1 = {year};
//			dbobject.executePreparedUpdate(sbU1.toString(), paramU1);

			//-----------------------------------------------------------------------------------------------
			// 2) 단본부가 평가군인 부서의 등급을 설정
			//-----------------------------------------------------------------------------------------------
			StringBuffer sqlQ = new StringBuffer();
			sqlQ.append(" select a.sbuid, b.bscid, b.grade2 ");
			sqlQ.append(" from   tblsbubscmapping a,        ");
			sqlQ.append("        tblpsnbscscore   b         ");
			sqlQ.append(" where  a.year  = b.year           ");
			sqlQ.append(" and    a.bscid = b.bscid          ");
			sqlQ.append(" and    a.year  = ?                ");
			sqlQ.append(" and    a.bscid is not null        ");

			Object[] paramQ = {year};
			rs = dbobject.executePreparedQuery(sqlQ.toString(),paramQ);
			System.out.println("sqlQ : "+ sqlQ.toString());

			DataSet dsG = new DataSet();
			dsG.load(rs);
			System.out.println("rs : "+dsG.toString());
			while(dsG.next())	{


				String sbuid = dsG.getString("sbuid" );
				String grade = dsG.getString("grade2");

				System.out.println("sbuid = " + sbuid + ":" + grade);

				StringBuffer sbU = new StringBuffer();
				sbU.append(" Update tblpsnbscscore ");
				sbU.append("   Set  grade1 =?      ");
				sbU.append(" Where  year  = ?      ");
				sbU.append("   and  sbuid = ?      ");

				Object[] paramU = {grade, year, sbuid};
				dbobject.executePreparedUpdate(sbU.toString(), paramU);
			}

			//-----------------------------------------------------------------------------------------------
			// 3) 등급에 따른 배분db
			//-----------------------------------------------------------------------------------------------
			StringBuffer sbU2 = new StringBuffer();
			sbU2.append(" update tblpsnbscscore a                                                                         ");
			sbU2.append(" set    div_rate1 =( select rate                                                                 ");
			sbU2.append("                     from                                                                        ");
			sbU2.append("                     (                                                                           ");
			sbU2.append("                     select  'S' grade, r1_s  rate from tblpsnbaseline where year = ? union all  ");
			sbU2.append("                     select  'A' grade, r1_a  rate from tblpsnbaseline where year = ? union all  ");
			sbU2.append("                     select  'B' grade, r1_b  rate from tblpsnbaseline where year = ? union all  ");
			sbU2.append("                     select  'C' grade, r1_c  rate from tblpsnbaseline where year = ? union all  ");
			sbU2.append("                     select  'D' grade, r1_d  rate from tblpsnbaseline where year = ?            ");
			sbU2.append("                     ) b                                                                         ");
			sbU2.append("                     where  b.grade = a.grade1                                                   ");
			sbU2.append("                    )                                                                            ");
			sbU2.append("      , div_rate2 =( select rate                                                                 ");
			sbU2.append("                     from                                                                        ");
			sbU2.append("                     (                                                                           ");
			sbU2.append("                     select  'S' grade, r2_s  rate from tblpsnbaseline where year = ? union all  ");
			sbU2.append("                     select  'A' grade, r2_a  rate from tblpsnbaseline where year = ? union all  ");
			sbU2.append("                     select  'B' grade, r2_b  rate from tblpsnbaseline where year = ? union all  ");
			sbU2.append("                     select  'C' grade, r2_c  rate from tblpsnbaseline where year = ? union all  ");
			sbU2.append("                     select  'D' grade, r2_d  rate from tblpsnbaseline where year = ?            ");
			sbU2.append("                     ) b                                                                         ");
			sbU2.append("                     where  b.grade = a.grade2                                                   ");
			sbU2.append("                    )                                                                            ");
			sbU2.append(" where  year = ?                                                                                 ");

			Object[] paramU2 = {year,year,year,year,year, year,year,year,year,year, year};
			dbobject.executePreparedUpdate(sbU2.toString(), paramU2);
/*
			//-----------------------------------------------------------------------------------------------
			// 4) 직할부서는 회사지급률 적용(직할부서 구분을 위하여 하드코딩됨)
			//-----------------------------------------------------------------------------------------------

			StringBuffer sbU3 = new StringBuffer();
			sbU3.append(" Update tblpsnbscscore       ");
			sbU3.append("   Set  div_rate2 = 0        ");
			sbU3.append(" Where  year   = ?           ");
			sbU3.append(" and    sbucid = 3           ");

			Object[] paramU3 = {year};
			dbobject.executePreparedUpdate(sbU3.toString(), paramU3);
*/
			conn.commit();


		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	//---- setPsnBscScore

	/*
	 *  Method : setPsnBscGrade
	 *  Desc.  : 성과급 부서등급 수정 등록
     *  Author	    : PHG
     *  Create Date : 2009-12-13
     *  History	    :
	 *
	 */
	public void setPsnBscGrade(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year = request.getParameter("year");
			String mode = request.getParameter("mode");
			String val  = request.getParameter("val");


			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			//--------------------------------------------------------------------------------------------
			//  매핑정의
			//--------------------------------------------------------------------------------------------
			if (!"".equals(val.trim())){

				String   bscid  ;
				String   grade1 ;
				String   grade2 ;

				String[] mapstr = val.split("`");

				System.out.println("mapStr : " + val);

				for (int m = 0; m < mapstr.length; m++) {
					if(mapstr[m]!=null && !"".equals(mapstr[m])){
						String[] iPart = mapstr[m].split(",");

						bscid   = iPart[0];
						grade1  = iPart[1];
						grade2  = iPart[2];

						StringBuffer sbSQL =  new StringBuffer();
						sbSQL.append(" update tblpsnbscscore      ");
						sbSQL.append(" set    grade1  = ?  ,      ");
						sbSQL.append(" 		  grade2  = ?         ");
						sbSQL.append(" where  year  = ?           ");
						sbSQL.append(" and    bscid = ?           ");

						Object[] pmUI = {grade1, grade2, year, bscid};
						dbobject.executePreparedUpdate(sbSQL.toString(),pmUI);
					}
				}


				//-----------------------------------------------------------------------------------------------
				// 3) 등급에 따른 배분db
				//-----------------------------------------------------------------------------------------------
				StringBuffer sbU2 = new StringBuffer();
				sbU2.append(" update tblpsnbscscore a                                                                         ");
				sbU2.append(" set    div_rate1 =( select rate                                                                 ");
				sbU2.append("                     from                                                                        ");
				sbU2.append("                     (                                                                           ");
				sbU2.append("                     select  'S' grade, r1_s  rate from tblpsnbaseline where year = ? union all  ");
				sbU2.append("                     select  'A' grade, r1_a  rate from tblpsnbaseline where year = ? union all  ");
				sbU2.append("                     select  'B' grade, r1_b  rate from tblpsnbaseline where year = ? union all  ");
				sbU2.append("                     select  'C' grade, r1_c  rate from tblpsnbaseline where year = ? union all  ");
				sbU2.append("                     select  'D' grade, r1_d  rate from tblpsnbaseline where year = ?            ");
				sbU2.append("                     ) b                                                                         ");
				sbU2.append("                     where  b.grade = a.grade1                                                   ");
				sbU2.append("                    )                                                                            ");
				sbU2.append("      , div_rate2 =( select rate                                                                 ");
				sbU2.append("                     from                                                                        ");
				sbU2.append("                     (                                                                           ");
				sbU2.append("                     select  'S' grade, r2_s  rate from tblpsnbaseline where year = ? union all  ");
				sbU2.append("                     select  'A' grade, r2_a  rate from tblpsnbaseline where year = ? union all  ");
				sbU2.append("                     select  'B' grade, r2_b  rate from tblpsnbaseline where year = ? union all  ");
				sbU2.append("                     select  'C' grade, r2_c  rate from tblpsnbaseline where year = ? union all  ");
				sbU2.append("                     select  'D' grade, r2_d  rate from tblpsnbaseline where year = ?            ");
				sbU2.append("                     ) b                                                                         ");
				sbU2.append("                     where  b.grade = a.grade2                                                   ");
				sbU2.append("                    )                                                                            ");
				sbU2.append(" where  year = ?                                                                                 ");

				Object[] paramU2 = {year,year,year,year,year, year,year,year,year,year, year};
				dbobject.executePreparedUpdate(sbU2.toString(), paramU2);


				conn.commit();
			}

			request.setAttribute("rslt","true");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	//---- setPsnBscGrade


	/*
	 *  Method : getPsnBizMh
	 *  Desc.  : 개인별 인사 사업M/H
     *  Author	    : PHG
     *  Create Date : 2008-03-19
     *  History	    :
	 *
	 */
	public void getPsnBizMh(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year    = request.getParameter("year");
			String empnm   = request.getParameter("empnm")==null?"%":Util.getUTF(request.getParameter("empnm"));
			String exceptyn= request.getParameter("exceptyn")!="N"?"%":request.getParameter("exceptyn");

			System.out.println(" getPsnBizMh : " + year + ":" + empnm);

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT                                              ");
			sb.append("          emp_no                                     ");
			sb.append("       ,  emp_nm                                     ");
			sb.append("       ,  jikgb_cd                                   ");
			sb.append("       ,  jikgb_nm                                   ");
			sb.append("       ,  dept_cd                                    ");
			sb.append("       ,  dept_nm                                    ");
			sb.append("       ,  mh                                         ");
			sb.append("       ,  except_yn                                  ");
			sb.append("       ,  except_cmt                                 ");
			sb.append(" from   tblpsnbizmh                                  ");
			sb.append(" where  year      =    ?                             ");
			sb.append(" and    emp_nm    like ?||'%'                        ");
			sb.append(" and    except_yn like ?                             ");
			sb.append(" order by emp_nm                                     ");

	         Object[] params = {year,empnm, exceptyn};

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
	 *  Method : setPsnBizMh
	 *  Desc.  : 개인별 사업부서 M/H 집계
     *  Author	    : PHG
     *  Create Date : 2008-04-11
     *  History	    :
	 *
	 */
	public void setPsnBizMh(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String userId	= (String)request.getSession().getAttribute("userId");
			String mode		= request.getParameter("mode")==null?"":request.getParameter("mode");

			String year     = request.getParameter("year");


			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			System.out.println("setPsnBizMh : Year : " + year);

			// 1. 기존자료 삭제.
			Object[] param = {year};
			String strD = "delete tblpsnbizmh where year = ? ";
			dbobject.executePreparedUpdate(strD, param);


			// 2. BSC 점수생성.
			StringBuffer sbI = new StringBuffer();
			sbI.append(" INSERT INTO tblpsnbizmh  (                                                                        ");
			sbI.append("    year    , emp_no , emp_nm, in_day, out_day,                                                    ");
			sbI.append("    jikgb_cd,jikgb_nm,                                                                             ");
			sbI.append("    sosok_cd, dept_cd, dept_nm, mh )                                                               ");

			sbI.append("  SELECT /*+ ordered */ \n"  );
			sbI.append("           SUBSTR(TC04T_MASTER.TC_YYMM,1,4) YEAR    , \n"  );
			sbI.append("           TC04T_MASTER.TC_SABUN   USER_ID , \n"  );
			sbI.append("           USER_MASTER.USER_NM     , \n"  );
			sbI.append("           USER_MASTER.IN_DAY      , \n"  );
			sbI.append("           USER_MASTER.OUT_DAY     , \n"  );
			sbI.append("           USER_MASTER.JIKGUB_CD   , \n"  );
			sbI.append("           USER_MASTER.JIKGUB_NM   , \n"  );
			sbI.append("           NULL                    , \n"  );
			sbI.append("           TC04T_MASTER.TC_JOB_CODE, \n"  );
			sbI.append("           TC02T.TC_JOB_KNAME      , \n"  );
			sbI.append("           SUM(nvl(TC04T_MASTER.TC_1SUM_RT,0) + \n"  );
			sbI.append("               nvl(TC04T_MASTER.TC_2SUM_RT,0) + \n"  );
			sbI.append("               nvl(TC04T_MASTER.TC_1SUM_OT,0) + \n"  );
			sbI.append("               nvl(TC04T_MASTER.TC_2SUM_OT,0) )  MH \n"  );
			sbI.append("      FROM tc00.TC02T@lnk_cpmis , \n"  );
			sbI.append("           pa00.USER_MASTER@lnk_cpmis , \n"  );
			sbI.append("          -- TC00.TC15T@lnk_cpmis       , \n"  );
			sbI.append("           tc00.TC04T_MASTER@lnk_cpmis \n"  );
			sbI.append("     WHERE tc04t_master.tc_sabun      = user_master.user_id (+) \n"  );
			sbI.append("       --AND tc04t_master.tc_sabun      = tc00.tc15t.tc_sabun (+) \n"  );
			sbI.append("       AND tc04t_master.tc_job_code   = tc02t.tc_job_code   (+) \n"  );
			sbI.append("       AND TC04T_MASTER.TC_YYMM    LIKE ?||'%' \n"  );
			sbI.append("       AND tc04t_master.tc_sabun      < '90000' \n"  );
			sbI.append("       AND (TC04T_MASTER.TC_YYMM||TC04T_MASTER.TC_JOB_CODE)    IN \n"  );
			sbI.append("             (SELECT TC_YYMM||TC_JOB_CODE \n"  );
			sbI.append("              FROM (SELECT TC_JOB_CODE, TC_YYMM, COUNT(*) ALL_CNT, \n"  );
			sbI.append("                           COUNT(DECODE(TC_CONFIRM ,NULL, NULL, ' ', NULL, TC_CONFIRM)) NOT_CNT \n"  );
			sbI.append("                    FROM  tc00.TC04T_MASTER@lnk_cpmis \n"  );
			sbI.append("                    WHERE  TC_YYMM  LIKE ?||'%' \n"  );
			sbI.append("                    AND    TC_SABUN <  '90000' \n"  );
			sbI.append("                    GROUP BY TC_JOB_CODE, TC_YYMM \n"  );
			sbI.append("                    ) KK \n"  );
			sbI.append("              WHERE KK.TC_YYMM < '200401' OR (KK.TC_YYMM >= '200401' ))-- AND KK.ALL_CNT = KK.NOT_CNT)) \n"  );
			sbI.append("              -- and TC04T_MASTER.TC_JOB_CODE='CH560' and TC04T_MASTER.TC_SABUN='09805' \n"  );
			sbI.append("              and TC04T_MASTER.TC_CONFIRM IS NOT NULL \n"  );
			sbI.append("  GROUP BY SUBSTR(TC04T_MASTER.TC_YYMM,1,4) , \n"  );
			sbI.append("           TC04T_MASTER.TC_SABUN   , \n"  );
			sbI.append("           USER_MASTER.USER_NM     , \n"  );
			sbI.append("           USER_MASTER.IN_DAY      , \n"  );
			sbI.append("           USER_MASTER.OUT_DAY     , \n"  );
			sbI.append("           TC04T_MASTER.TC_JOB_CODE, \n"  );
			sbI.append("           TC02T.TC_JOB_KNAME      , \n"  );
			sbI.append("           USER_MASTER.JIKGUB_CD   , \n"  );
			sbI.append("           USER_MASTER.JIKGUB_NM \n"  );

			/*
			sbI.append(" SELECT /*+ ordered ///                                                                             ");
			sbI.append("          SUBSTR(TC04T_MASTER.TC_YYMM,1,4) YEAR    ,                                               ");
			sbI.append("          TC04T_MASTER.TC_SABUN            USER_ID ,                                               ");
			sbI.append("          USER_MASTER.USER_NM     ,                                                                ");
			sbI.append("          USER_MASTER.IN_DAY      ,                                                                ");
			sbI.append("          USER_MASTER.OUT_DAY     ,                                                                ");
			sbI.append("          USER_MASTER.JIKGUB_CD   ,                                                                ");
			sbI.append("          USER_MASTER.JIKGUB_NM   ,                                                                ");
//			sbI.append("          TC04T_MASTER.TC_SOSOK   ,                                                                ");
			sbI.append("          NULL                    ,                                                                ");
			sbI.append("          TC04T_MASTER.TC_JOB_CODE,                                                                ");
			sbI.append("          TC02T.TC_JOB_KNAME      ,                                                                ");
			sbI.append("          SUM(nvl(TC04T_MASTER.TC_1SUM_RT,0) +                                                     ");
			sbI.append("              nvl(TC04T_MASTER.TC_2SUM_RT,0) +                                                     ");
			sbI.append("              nvl(TC04T_MASTER.TC_1SUM_OT,0) +                                                     ");
			sbI.append("              nvl(TC04T_MASTER.TC_2SUM_OT,0) )  MH                                                 ");
			sbI.append("     FROM tc00.TC02T@lnk_cpmis ,                                                                   ");
			sbI.append("          pa00.USER_MASTER@lnk_cpmis ,                                                             ");
			sbI.append("          TC00.TC15T@lnk_cpmis       ,                                                             ");
			sbI.append("          tc00.TC04T_MASTER@lnk_cpmis                                                              ");
			sbI.append("    WHERE tc04t_master.tc_sabun      = user_master.user_id (+)                                     ");
			sbI.append("      AND tc04t_master.tc_sabun      = tc00.tc15t.tc_sabun (+)                                     ");
			sbI.append("      AND tc04t_master.tc_job_code   = tc02t.tc_job_code   (+)                                     ");
			sbI.append("      AND TC04T_MASTER.TC_YYMM    LIKE ?||'%'                                                      ");
			sbI.append("      AND tc04t_master.tc_sabun      < '90000'                                                     ");
			sbI.append("      AND (TC04T_MASTER.TC_YYMM||TC04T_MASTER.TC_JOB_CODE)    IN                                   ");
			sbI.append("            (SELECT TC_YYMM||TC_JOB_CODE                                                           ");
			sbI.append("             FROM (SELECT TC_JOB_CODE, TC_YYMM, COUNT(*) ALL_CNT,                                  ");
			sbI.append("                          COUNT(DECODE(TC_CONFIRM ,NULL, NULL, ' ', NULL, TC_CONFIRM)) NOT_CNT     ");
			sbI.append("                   FROM  tc00.TC04T_MASTER@lnk_cpmis                                               ");
			sbI.append("                   WHERE  TC_YYMM  LIKE ?||'%'                                                     ");
			sbI.append("                   AND    TC_SABUN <  '90000'                                                      ");
			sbI.append("                   GROUP BY TC_JOB_CODE, TC_YYMM                                                   ");
			sbI.append("                   ) KK                                                                            ");
			sbI.append("             WHERE KK.TC_YYMM < '200401' OR (KK.TC_YYMM >= '200401' AND KK.ALL_CNT = KK.NOT_CNT))  ");
			sbI.append(" GROUP BY SUBSTR(TC04T_MASTER.TC_YYMM,1,4) ,                                                       ");
			sbI.append("          TC04T_MASTER.TC_SABUN   ,                                                                ");
			sbI.append("          USER_MASTER.USER_NM     ,                                                                ");
			sbI.append("          USER_MASTER.IN_DAY      ,                                                                ");
			sbI.append("          USER_MASTER.OUT_DAY     ,                                                                ");
//			sbI.append("          TC04T_MASTER.TC_SOSOK   ,                                                                ");
			sbI.append("          TC04T_MASTER.TC_JOB_CODE,                                                                ");
			sbI.append("          TC02T.TC_JOB_KNAME      ,                                                                ");
			sbI.append("          USER_MASTER.JIKGUB_CD   ,                                                                ");
			sbI.append("          USER_MASTER.JIKGUB_NM                                                                    ");
			*/

			Object[] paramI = {year,year};
			dbobject.executePreparedUpdate(sbI.toString(),paramI);




			// 이전 직급 적용하기 이전직급 테이블에는 직접 입력후


			StringBuffer sbE = new StringBuffer();
			sbE.append(" update /*+ bypass_ujvc */ \n ")
			.append(" ( \n ")
			.append("     select * from \n ")
			.append("     ( \n ")
			.append("         select emp_no,JIKGB_CD from tblpsnbizmh where year=? \n ")
			.append("     ) a, \n ")
			.append("     ( \n ")
			.append("         select emp_no empno, JIKGUB_CD jg from tblpsnbizjg where year=? \n ")
			.append("     ) b \n ")
			.append("     where a.emp_no=b.empno \n ")
			.append(" ) set jikgb_cd=jg \n ");

			Object[] pmE = {year, year};

			dbobject.executePreparedUpdate(sbE.toString(), pmE);


			conn.commit();


		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	//---- setPsnBizMh


	/*
	 *  Method : getPsnScore
	 *  Desc.  : 개인별 성과급 지급률
     *  Author	    : PHG
     *  Create Date : 2008-03-19
     *  History	    :
	 *
	 */
	public void getPsnScore(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year   = request.getParameter("year");
			String sbuid  = request.getParameter("sbuid")==null?"%":request.getParameter("sbuid");
			String empnm  = request.getParameter("empnm")==null?"%":Util.getUTF(request.getParameter("empnm"));

			System.out.println(" getPsnScore : " + year + ":" + sbuid + ":"+ empnm);

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			StringBuffer sb = new StringBuffer();
			sb.append(" select  a.emp_no   , a.emp_nm  ,                                                                      \n");
			sb.append("         a.jikgb_cd , a.jikgb_nm,                                                                      \n");
			sb.append("         nvl(a.emp_rate , a.bsc_rate) emp_rate,                                                        \n");
			sb.append("         a.sbuid    , a.sbunm   ,                                                                      \n");
			sb.append("         a.bscid    , a.bscnm   ,  a.bsccid  ,                                                         \n");
			sb.append("         a.sbu_grade, a.bsc_grade, a.bsc_rate,                                                                      \n");
			sb.append("         a.bsc_mh   , a.bsc_mh_rate,                                                                   \n");
			sb.append("         sum(b.mh) over(partition by a.emp_no, a.emp_no) bsc_mh_sum,                                \n");
			// by mckang ;;;  sb.append("         sum(a.bsc_mh) over(partition by a.emp_no, a.bscid) bsc_mh_sum,                                \n");
			sb.append("         b.dept_cd  , b.dept_nm, b.mh                                                                  \n");
			sb.append(" from    (                                                                                             \n");
			sb.append("         select  emp_no   , emp_nm  ,                                                                  \n");
			sb.append("                 jikgb_cd , jikgb_nm,                                                                  \n");
			sb.append("                 round(sum(bsc_rate * bsc_mh) over(partition by emp_no)                                \n");
			sb.append("                       / sum(bsc_mh) over(partition by emp_no),3)  emp_rate,                           \n");
			sb.append("                 sbuid    , sbunm   ,                                                                  \n");
			sb.append("                 bscid    , bscnm   ,  bsccid  ,                                                       \n");
			sb.append("                 sbu_grade, bsc_grade, bsc_rate,                                                                  \n");
			sb.append("                 bsc_mh   ,                                                                            \n");
			sb.append("                 round(ratio_to_report(bsc_mh) over(partition by emp_no) * 100, 3)  bsc_mh_rate        \n");
			sb.append("         from                                                                                          \n");
			sb.append("               (                                                                                       \n");
			sb.append("               select                                                                                  \n");
			sb.append("                        emp_no                                                                         \n");
			sb.append("                     ,  emp_nm                                                                         \n");
			sb.append("                     ,  jikgb_cd                                                                       \n");
			sb.append("                     ,  jikgb_nm                                                                       \n");
			sb.append("                     ,  sbuid                                                                          \n");
			sb.append("                     ,  f_getbscnm(1,max(sbucid))  sbunm                                               \n");
			sb.append("                     ,  bscid   ,  bsccid                                                              \n");
			sb.append("                     ,  f_getbscnm(2,max(bsccid))  bscnm                                               \n");
			sb.append("                     ,  max(sbu_grade)             sbu_grade                                           \n");
			sb.append("                     ,  max(bsc_grade)             bsc_grade                                           \n");
			sb.append("                     ,  max(bsc_rate)              bsc_rate                                            \n");
			sb.append("                     ,  sum(mh)                    bsc_mh                                              \n");
			sb.append("               from   tblpsnscore    a                                                                 \n");
			sb.append("               where  year      =    ?                                                                 \n");
			sb.append("               and    nvl(sbuid,0)  like    ?||'%'                                                     \n");
			sb.append("               and    emp_nm        like    ?||'%'                                                     \n");
			sb.append("               and    bsc_grade is not null                                                            \n");
			sb.append("               group by emp_no                                                                         \n");
			sb.append("                     ,  emp_nm                                                                         \n");
			sb.append("                     ,  jikgb_cd                                                                       \n");
			sb.append("                     ,  jikgb_nm                                                                       \n");
			sb.append("                     ,  sbuid                                                                          \n");
			sb.append("                     ,  bscid   , bsccid                                                               \n");
			sb.append("               order by emp_nm, sbuid, bscid                                                           \n");
			sb.append("               )                                                                                       \n");
			sb.append("         order by emp_nm, sbuid, bscid                                                                 \n");
			sb.append("         ) a,                                                                                          \n");
			sb.append("         (select * from tblpsnscore where year = ?) b                                                  \n");
			sb.append(" where a.emp_no = b.emp_no                                                                             \n");
			sb.append(" and   a.sbuid  = b.sbuid                                                                              \n");
			sb.append(" and   a.bscid  = b.bscid                                                                              \n");
			sb.append(" order by emp_nm, sbuid, bscid                                                                         \n");

			Object[] params = {year, sbuid, empnm, year};
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
	 *  Method : getPsnScoreList
	 *  Desc.  : 개인별 성과급 지급률
     *  Author	    : PHG
     *  Create Date : 2008-03-19
     *  History	    :
	 *
	 */
	public void getPsnScoreList(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year   = request.getParameter("year");
			String empnm  = request.getParameter("empnm")==null?"%":Util.getUTF(request.getParameter("empnm"));

			System.out.println(" getPsnScoreList : " + year + ":" +  empnm);

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			StringBuffer sb = new StringBuffer();
			sb.append(" select  a.emp_no   , a.emp_nm  ,                                                                       ");
			sb.append("         a.jikgb_cd , a.jikgb_nm,                                                                       ");
			sb.append("         nvl(a.emp_rate , a.bsc_rate) emp_rate,                                                         ");
			sb.append("         a.sbuid    , a.sbunm   ,                                                                       ");
			sb.append("         a.bscid    , a.bscnm   ,  a.bsccid  ,                                                          ");
			sb.append("         a.sbu_grade, a.bsc_grade, a.bsc_rate,                                                          ");
			sb.append("         a.bsc_mh   , a.bsc_mh_rate,                                                                    ");
			sb.append("         sum(a.bsc_mh) over(partition by a.emp_no, a.bscid) bsc_mh_sum                                  ");
			sb.append(" from    (                                                                                              ");
			sb.append("         select  emp_no   , emp_nm  ,                                                                   ");
			sb.append("                 jikgb_cd , jikgb_nm,                                                                   ");
			sb.append("                 round(sum(bsc_rate * bsc_mh) over(partition by emp_no)                                 ");
			sb.append("                       / sum(bsc_mh) over(partition by emp_no),3)  emp_rate,                            ");
			sb.append("                 sbuid    , sbunm   ,                                                                   ");
			sb.append("                 bscid    , bscnm   ,  bsccid  ,                                                        ");
			sb.append("                 sbu_grade, bsc_grade, bsc_rate,                                                        ");
			sb.append("                 bsc_mh   ,                                                                             ");
			sb.append("                 round(ratio_to_report(bsc_mh) over(partition by emp_no) * 100, 3)  bsc_mh_rate         ");
			sb.append("         from                                                                                           ");
			sb.append("               (                                                                                        ");
			sb.append("               select                                                                                   ");
			sb.append("                        emp_no                                                                          ");
			sb.append("                     ,  emp_nm                                                                          ");
			sb.append("                     ,  jikgb_cd                                                                        ");
			sb.append("                     ,  jikgb_nm                                                                        ");
			sb.append("                     ,  sbuid                                                                           ");
			sb.append("                     ,  f_getbscnm(1,max(sbucid))  sbunm                                                ");
			sb.append("                     ,  bscid   ,  bsccid                                                               ");
			sb.append("                     ,  f_getbscnm(2,max(bsccid))  bscnm                                                ");
			sb.append("                     ,  max(sbu_grade)             sbu_grade                                            ");
			sb.append("                     ,  max(bsc_grade)             bsc_grade                                            ");
			sb.append("                     ,  max(bsc_rate)              bsc_rate                                             ");
			sb.append("                     ,  sum(mh)                    bsc_mh                                               ");
			sb.append("               from   tblpsnscore    a                                                                  ");
			sb.append("               where  year      =    ?                                                                  ");
			sb.append("               and    emp_nm        like    ?||'%'                                                      ");
			sb.append("               and    bsc_grade is not null                                                             ");
			sb.append("               group by emp_no                                                                          ");
			sb.append("                     ,  emp_nm                                                                          ");
			sb.append("                     ,  jikgb_cd                                                                        ");
			sb.append("                     ,  jikgb_nm                                                                        ");
			sb.append("                     ,  sbuid                                                                           ");
			sb.append("                     ,  bscid   , bsccid                                                                ");
			sb.append("               order by emp_nm, sbuid, bscid                                                            ");
			sb.append("               )                                                                                        ");
			sb.append("         order by emp_nm, sbuid, bscid                                                                  ");
			sb.append("         ) a                                                                                            ");
			sb.append(" order by emp_nm, sbuid, bscid                                                                          ");

			Object[] params = {year, empnm};
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
     * Method Name : setPsnScore
     * Description : 개인성과급계산
     * Author	   : PHG
     * Create Date : 2008-03-19
     * History	          :
     * @throws SQLException
     */
	public void setPsnScore(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year = request.getParameter("year");
			String mode = request.getParameter("mode");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			//--------------------------------------------------------------------------------------------
			//  개인성과급은 다음의 규칙을 적용한다.
			//  0. 특정 M/H 미만 제외.
			//  0.1 노조전임 제외 (TBLPSNLABOR)
			//  1. 직할부서는 기준지급률 적용 : 부서별 성과 비율 계산시 적용.
			//	2. 신규입사자(전전년 12월, 전년 입사자)는 회사지급률 적용
			//  3. 퇴사자는 제외.
			//  4. tblpsnjikgub의 use_yn인 직급만 산정.
			//  5. 평가부서 Not Mapping.
			//  6. 평가배분률 10 미만 제외 : 평가배분률 재계산.
			//  7. 2008년 원자로 설계사업단은 평가부서의 등급을 적용 : 사업부서 M/H적용안함.
			//--------------------------------------------------------------------------------------------

				// 0. 특정 M/H 미만제외
				StringBuffer sbU = new StringBuffer();
				sbU.append(" Update tblpsnbizmh               ");
				sbU.append("   Set  except_yn  = 'Y'          ");
				sbU.append("     ,  except_cmt = 'M/H 제외'   ");
				sbU.append(" Where  year   = ?                ");
				sbU.append(" and    mh     < (select except_mh from tblpsnbaseline where year = ?) ");

				Object[] paramU = {year, year};
				dbobject.executePreparedUpdate(sbU.toString(), paramU);


				// 0.1 노조전임자 제외
				StringBuffer sbU12 = new StringBuffer();
				sbU12.append(" Update tblpsnbizmh               ");
				sbU12.append("   Set  except_yn  = 'Y'          ");
				sbU12.append("     ,  except_cmt = '노조 전임 제외'   ");
				sbU12.append(" Where  year   = ?                ");
				sbU12.append(" and emp_no in (select emp_no from TBLPSNLABOR where year = ?) ");

				Object[] paramU12 = {year, year};
				dbobject.executePreparedUpdate(sbU12.toString(), paramU12);


				// 1. 퇴사자 제외
				StringBuffer sbU2 = new StringBuffer();
				sbU.append(" Update tblpsnbizmh               ");
				sbU.append("   Set  except_yn  = 'Y'          ");
				sbU.append("     ,  except_cmt = '퇴사자 제외'");
				sbU.append(" Where  year   = ?          ");
				sbU.append(" and    out_day like ?||'%' ");

				Object[] paramU2 = {year, year};
				dbobject.executePreparedUpdate(sbU2.toString(), paramU2);

				// 2. 신규입사자 제외
				StringBuffer sbU3 = new StringBuffer();
				sbU.append(" Update tblpsnbizmh               ");
				sbU.append("   Set  except_yn  = 'I'          ");
				sbU.append("     ,  except_cmt = '신규입사자' ");
				sbU.append(" Where  year   = ?         ");
				sbU.append(" and   (in_day like ?||'%' or in_day like ltrim(to_char(to_number(?)-1))||'12%')");

				Object[] paramU3 = {year, year, year};
				dbobject.executePreparedUpdate(sbU3.toString(), paramU3);

				// 2. 특정직급 대상자 제외
				sbU = new StringBuffer();
				sbU.append(" Update tblpsnbizmh               ");
				sbU.append("   Set  except_yn  = 'Y'          ");
				sbU.append("     ,  except_cmt = '호봉제 대상 직급 아님'");
				sbU.append(" Where  year       = ?            ");
				sbU.append(" And    jikgb_cd not in (SELECT jikgub_cd FROM tblpsnjikgub  ");
				sbU.append("                         WHERE year = ? AND use_yn = 'Y')    ");

				Object[] paramU4 = {year, year};
				dbobject.executePreparedUpdate(sbU.toString(), paramU4);


				// 4. 평가부서 Mapping안된 것...
				sbU = new StringBuffer();
				sbU.append(" Update tblpsnbizmh               ");
				sbU.append("   Set  except_yn  = 'Y'          ");
				sbU.append("     ,  except_cmt = '평가부서 연결안된 사업부서코드'");
				sbU.append(" Where  year       = ?            ");
				sbU.append(" And    except_yn  = 'N'          ");
				sbU.append(" And    dept_cd not in (SELECT distinct dept_cd FROM tbldeptmapping ");
				sbU.append("                         WHERE year = ? )    ");

				Object[] paramU5 = {year, year};
				dbobject.executePreparedUpdate(sbU.toString(), paramU5);

				// 5. 평가부서의 특정 M/H합 미만 제외 ...
				sbU = new StringBuffer();
				sbU.append(" update tblpsnbizmh                                                                           \n");
				sbU.append(" set     except_yn  = 'Y'                                                                     \n");
				sbU.append("       , except_cmt = (select '평가부서 M/H합계 : '|| except_bscmh||'미만 제외'               \n");
				sbU.append("                       from tblpsnbaseline where year = ?)                                    \n");
				sbU.append(" where  (year, emp_no, dept_cd) in (                                                          \n");
				sbU.append("             select  year, emp_no, dept_cd                                                    \n");
				sbU.append("             from                                                                             \n");
				sbU.append("                     (                                                                        \n");
				sbU.append("                     select a.year  ,                                                         \n");
				sbU.append("                            a.emp_no , a.emp_nm , a.jikgb_cd, a.jikgb_nm,                     \n");
				sbU.append("                            a.dept_cd, a.dept_nm, a.mh      , b.org_cd  ,                     \n");
				sbU.append("                            sum(a.mh) over (partition by a.emp_no,b.org_cd ) bscmh            \n");
				sbU.append("                     from  tblpsnbizmh    a,                                                  \n");
				sbU.append("                           tbldeptmapping b                                                   \n");
				sbU.append("                     where a.year      = b.year    (+)                                        \n");
				sbU.append("                     and   a.dept_cd   = b.dept_cd (+)                                        \n");
				sbU.append("                     and   a.year      = ?                                                    \n");
				sbU.append("                     and   a.except_yn = 'N'                                                  \n");
				sbU.append("                     order by a.emp_nm                                                        \n");
				sbU.append("                     )                                                                        \n");
				sbU.append("             where   bscmh < (select except_bscmh from tblpsnbaseline where year = ?     )    \n");
				sbU.append("             )                                                                                \n");

				Object[] paramU6 = {year, year, year};
				dbobject.executePreparedUpdate(sbU.toString(), paramU6);


				// 기존자료 삭제
				String strD = "DELETE FROM tblpsnscore WHERE year=?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});


				// 2. BSC 점수생성.
				//    예외처리 : 평가등급을 적용받는 사원(예, 원자로 설계사업단 등) 처리안함.
				StringBuffer sbI = new StringBuffer();

				sbI.append("  INSERT INTO tblpsnscore (                                                                ");
				sbI.append("      year       ,                                                                         ");
				sbI.append("      emp_no     ,  dept_cd    ,  emp_nm     ,  dept_nm    ,  jikgb_cd   , jikgb_nm ,      ");
				sbI.append("      bscid      ,  sbuid      ,  bsccid     ,  sbucid     ,                               ");
				sbI.append("      bsc_rate   ,  mh         ,  mh_rate    ,  bsc_grade  , sbu_grade     )               ");
				sbI.append("  select a.year  ,                                                                         ");
				sbI.append("         a.emp_no, a.dept_cd,  a.emp_nm , a.dept_nm, a.jikgb_cd,   a.jikgb_nm,             ");
				sbI.append("         a.bscid , a.sbuid  ,  a.bsccid , a.sbucid ,                                       ");
				sbI.append("         a.bsc_rate, a.mh   ,  a.mh_rate, a.grade2 , a.grade1                              ");
				sbI.append("  from   (                                                                                 ");
				sbI.append("  select a.year  ,                                                                         ");
				sbI.append("         a.emp_no , a.emp_nm , a.jikgb_cd, a.jikgb_nm,                                     ");
				sbI.append("         a.dept_cd, a.dept_nm   dept_nm,  a.mh,                                            ");
				sbI.append("         sum(a.mh) over (partition by a.emp_no) tot_mh,                                    ");
				sbI.append("         round(ratio_to_report(a.mh) over(partition by a.emp_no) * 100, 0) as mh_rate,     ");
				sbI.append("         c.sbuid,  c.sbucid, c.sbunm,                                                      ");
				sbI.append("         c.bscid,  c.bsccid, c.bscnm, c.bsc_rate, c.grade2 , c.grade1                      ");
				sbI.append("  from  tblpsnbizmh    a,                                                                  ");
				sbI.append("        tbldeptmapping b,                                                                  ");
				sbI.append("        (                                                                                  ");
				sbI.append("           select                                                                          ");
				sbI.append("                   sbuid     ,                                                             ");
				sbI.append("                   f_getbscnm(1,sbucid)  sbunm,                                            ");
				sbI.append("                   bscid     ,                                                             ");
				sbI.append("                   f_getbscnm(2,bsccid)  bscnm,                                            ");
				sbI.append("                   sbucid    ,                                                             ");
				sbI.append("                   bsccid    ,                                                             ");
				sbI.append("                   grade1, grade2    ,                                                     ");
				sbI.append("                   case when grade1 is null then r_co + div_rate2                          ");
				sbI.append("                        else r_co + div_rate1 + div_rate2                                  ");
				sbI.append("                   end bsc_rate                                                            ");
				sbI.append("           from   tblpsnbscscore  a,                                                       ");
				sbI.append("                  tblpsnbaseline  b                                                        ");
				sbI.append("           where  a.year  = b.year                                                         ");
				sbI.append("           and    a.year  = ?                                                              ");
				sbI.append("           order by sbuid, bscid                                                           ");
				sbI.append("         ) c                                                                               ");
				sbI.append("  where a.year      = b.year    (+)                                                        ");
				sbI.append("  and   a.dept_cd   = b.dept_cd (+)                                                        ");
				sbI.append("  and   b.org_cd    = c.bsccid  (+)                                                        ");
				sbI.append("  and   a.year      = ?                                                                    ");
				sbI.append("  and   a.emp_no not in (select emp_no from tblpsnexceptemp where year = ?)                ");
				sbI.append("  and   a.except_yn = 'N'                                                                  ");
				sbI.append("  order by a.emp_nm                                                                        ");
				sbI.append("  ) a                                                                                      ");
				sbI.append("  order by a.emp_nm                                                                        ");


				Object[] paramI = {year,year,year};
				dbobject.executePreparedUpdate(sbI.toString(),paramI);

				System.out.println(" setPsnScore : 평가부서 등급적용 부서 처리");

				// 3. BSC 점수생성.
				//    예외처리 : 원자로 설계사업단의 경우 BSC 평가부서의 등급을 적용한다.
				sbI = new StringBuffer();

				sbI.append("  INSERT INTO tblpsnscore (                                                                ");
				sbI.append("      year       ,                                                                         ");
				sbI.append("      emp_no     ,  dept_cd    ,  emp_nm     ,  dept_nm    ,  jikgb_cd   , jikgb_nm ,      ");
				sbI.append("      bscid      ,  sbuid      ,  bsccid     ,  sbucid     ,                               ");
				sbI.append("      bsc_rate   ,  mh         ,  mh_rate    ,  bsc_grade  , sbu_grade     )      ");
				sbI.append("  select a.year  ,                                                                ");
				sbI.append("         a.emp_no, a.dept_cd,  a.emp_nm , a.dept_nm, a.jikgb_cd,   a.jikgb_nm,    ");
				sbI.append("         c.bscid , c.sbuid  ,  c.bsccid , c.sbucid ,                              ");
				sbI.append("         c.bsc_rate, null  mh, null  mh_rate, c.grade2 , c.grade1                 ");
				sbI.append("  from                                                                            ");
				sbI.append("      (                                                                           ");
				sbI.append("      select distinct a.year, a.emp_no , a.emp_nm , a.jikgb_cd, a.jikgb_nm,       ");
				sbI.append("             '00000'  dept_cd, '평가부서 기준 성과급 비율 적용' dept_nm,          ");
				sbI.append("             b.sbuid, b.bscid                                                     ");
				sbI.append("      from   tblpsnbizmh a, tblpsnexceptemp b                                     ");
				sbI.append("      where  a.year      = b.year                                                 ");
				sbI.append("      and    a.emp_no    = b.emp_no                                               ");
				sbI.append("      and    a.year      = ?                                                      ");
				sbI.append("      and    a.jikgb_cd  in (SELECT jikgub_cd FROM tblpsnjikgub                   ");
				sbI.append("                             WHERE year = ? AND use_yn = 'Y')                     ");
				sbI.append("      ) a,                                                                        ");
				sbI.append("     (                                                                            ");
				sbI.append("       select                                                                     ");
				sbI.append("               sbuid     ,                                                        ");
				sbI.append("               f_getbscnm(1,sbucid)  sbunm,                                       ");
				sbI.append("               bscid     ,                                                        ");
				sbI.append("               f_getbscnm(2,bsccid)  bscnm,                                       ");
				sbI.append("               sbucid    ,                                                        ");
				sbI.append("               bsccid    ,                                                        ");
				sbI.append("               grade1, grade2    ,                                                ");
				sbI.append("               case when grade1 is null then r_co + div_rate2                     ");
				sbI.append("                    else r_co + div_rate1 + div_rate2                             ");
				sbI.append("               end bsc_rate                                                       ");
				sbI.append("       from   tblpsnbscscore  a,                                                  ");
				sbI.append("              tblpsnbaseline  b                                                   ");
				sbI.append("       where  a.year  = b.year                                                    ");
				sbI.append("       and    a.year  = ?                                                         ");
				sbI.append("       order by sbuid, bscid                                                      ");
				sbI.append("     ) c                                                                          ");
				sbI.append("  where  a.sbuid = c.sbuid                                                        ");
				sbI.append("  and    a.bscid = c.bscid                                                        ");
				sbI.append("  order by emp_nm                                                                 ");

				Object[] paramI3 = {year,year,year};
				dbobject.executePreparedUpdate(sbI.toString(),paramI3);


				// 신규입사자(구분 : 'I') 에 대한 처리... 필요... 구분필드 추가하고 담당자가 엑셀로 알아서 편집해라.
				// 2. BSC 점수생성.
				System.out.println(" setPsnBizMh : 신규입사자 처리");

				StringBuffer sbI2 = new StringBuffer();

				sbI2.append("  INSERT INTO tblpsnscore (                                                                ");
				sbI2.append("      year       ,                                                                         ");
				sbI2.append("      emp_no     ,  dept_cd    ,  emp_nm     ,  dept_nm    ,  jikgb_cd   ,                 ");
				sbI2.append("      bscid      ,  sbuid      ,  bsccid     ,  sbucid     ,                               ");
				sbI2.append("      bsc_rate   ,  mh         ,  mh_rate    )                                             ");
				sbI2.append("  select a.year  ,                                                                         ");
				sbI2.append("         a.emp_no, a.dept_cd,  a.emp_nm , a.dept_nm, a.jikgb_cd,                           ");
				sbI2.append("         a.bscid , a.sbuid  ,  a.bsccid , a.sbucid ,                                       ");
				sbI2.append("         a.bsc_rate, a.mh   ,  a.mh_rate                                                   ");
				sbI2.append("  from   (                                                                                 ");
				sbI2.append("  select a.year  ,                                                                         ");
				sbI2.append("         a.emp_no , a.emp_nm , a.jikgb_cd, a.jikgb_nm,                                     ");
				sbI2.append("         a.dept_cd, a.dept_nm||'(신규입사:'||a.in_day||')' dept_nm, a.mh,                  ");
				sbI2.append("         sum(a.mh) over (partition by a.emp_no) tot_mh,                                    ");
				sbI2.append("         round(ratio_to_report(a.mh) over(partition by a.emp_no) * 100, 0) as mh_rate,     ");
				sbI2.append("         c.sbuid,  c.sbucid, c.sbunm,                                                      ");
				sbI2.append("         c.bscid,  c.bsccid, c.bscnm, c.bsc_rate                                           ");
				sbI2.append("  from                                                                                     ");
				sbI2.append("      (                                                                                    ");
				sbI2.append("      select a.year    ,                                                                   ");
				sbI2.append("             a.emp_no  , a.emp_nm  , a.in_day ,                                            ");
				sbI2.append("             a.jikgb_cd, a.jikgb_nm,                                                       ");
				sbI2.append("             b.dept_cd , max(c.dept_nm) dept_nm,                                           ");
				sbI2.append("             sum(a.mh)   mh                                                                ");
				sbI2.append("      from   tblpsnbizmh a,                                                                ");
				sbI2.append("             tbluser     b,                                                                ");
				sbI2.append("             tbldept     c                                                                 ");
				sbI2.append("      where  a.emp_no    = b.userid                                                        ");
				sbI2.append("      and    b.dept_cd   = c.dept_cd                                                       ");
				sbI2.append("      and    a.year      = ?                                                               ");
				sbI2.append("      and    a.except_yn = 'I'                                                             ");
				sbI2.append("      group by a.year    ,                                                                 ");
				sbI2.append("               a.emp_no  , a.emp_nm  , a.in_day ,                                          ");
				sbI2.append("               a.jikgb_cd, a.jikgb_nm, b.dept_cd                                           ");
				sbI2.append("      ) a,                                                                                 ");
				sbI2.append("      tbldeptmapping b,                                                                    ");
				sbI2.append("      (                                                                                    ");
				sbI2.append("        select                                                                             ");
				sbI2.append("                sbuid     ,                                                                ");
				sbI2.append("                f_getbscnm(1,sbucid)  sbunm,                                               ");
				sbI2.append("                bscid     ,                                                                ");
				sbI2.append("                f_getbscnm(2,bsccid)  bscnm,                                               ");
				sbI2.append("                sbucid    ,                                                                ");
				sbI2.append("                bsccid    ,                                                                ");
				sbI2.append("                r_co      bsc_rate                                                         ");
				sbI2.append("        from   tblpsnbscscore  a,                                                          ");
				sbI2.append("               tblpsnbaseline  b                                                           ");
				sbI2.append("        where  a.year  = b.year                                                            ");
				sbI2.append("        and    a.year  = ?                                                                 ");
				sbI2.append("        order by sbuid, bscid                                                              ");
				sbI2.append("      ) c                                                                                  ");
				sbI2.append("  where a.year      = b.year    (+)                                                        ");
				sbI2.append("  and   a.dept_cd   = b.dept_cd (+)                                                        ");
				sbI2.append("  and   b.org_cd    = c.bsccid  (+)                                                        ");
				sbI2.append("  and   a.year      = ?                                                                    ");
				sbI2.append("  order by a.emp_nm                                                                        ");
				sbI2.append("  ) a                                                                                      ");
				sbI2.append("  order by a.emp_nm                                                                        ");

				Object[] paramI2 = {year,year,year };
				dbobject.executePreparedUpdate(sbI2.toString(),paramI2);



				conn.commit();

			request.setAttribute("rslt","true");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	//--- setPsnScore


	/*
	 *  Method : getPsnEmpScore
	 *  Desc.  : 개인별 성과급 지급률
     *  Author	    : PHG
     *  Create Date : 2008-03-19
     *  History	    :
	 *
	 */
	public void getPsnEmpScore(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year   = request.getParameter("year");
			String empno  = request.getParameter("empno")==null?"":request.getParameter("empno");
			if ("".equals(empno)){
				empno  = (String)request.getSession().getAttribute("userId");
			}

			if ("".equals(empno)) return;

			System.out.println(" getPsnEmpScore : " + year + ":" + empno);

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			StringBuffer sb = new StringBuffer();
			sb.append(" select  emp_no   , emp_nm  ,                                                                                          \n");
			sb.append("         jikgb_cd , jikgb_nm,                                                                                          \n");
			//sb.append("         round(sum(bsc_rate * bsc_mh) over(partition by emp_no) / sum(bsc_mh) over(partition by emp_no),3)  emp_rate,  \n");
			sb.append("         round(avg(bsc_rate) over(partition by emp_no),3)  emp_rate,                                                   \n");
			sb.append("         sbu_grade, sbuid    , sbunm   ,                                                                                          \n");
			sb.append("         bscid    , bscnm   ,  bsccid  ,                                                                               \n");
			sb.append("         bsc_grade, bsc_rate,                                                                                          \n");
			sb.append("         bsc_mh   ,                                                                                                    \n");
			sb.append("         round(ratio_to_report(bsc_mh) over(partition by emp_no) * 100, 3)  bsc_mh_rate                                \n");
			sb.append(" from                                                                                                                  \n");
			sb.append("       (                                                                                                               \n");
			sb.append("       select                                                                                                          \n");
			sb.append("                emp_no                                                                                                 \n");
			sb.append("             ,  emp_nm                                                                                                 \n");
			sb.append("             ,  jikgb_cd                                                                                               \n");
			sb.append("             ,  jikgb_nm                                                                                               \n");
			sb.append("             ,  sbuid                                                                                                  \n");
			sb.append("             ,  f_getbscnm(1,max(sbucid))  sbunm                                                                       \n");
			sb.append("             ,  bscid   ,  bsccid                                                                                      \n");
			sb.append("             ,  f_getbscnm(2,max(bsccid))  bscnm                                                                       \n");
			sb.append("             ,  max(sbu_grade)             sbu_grade                                                                   \n");
			sb.append("             ,  max(bsc_grade)             bsc_grade                                                                   \n");
			sb.append("             ,  max(bsc_rate)              bsc_rate                                                                    \n");
			sb.append("             ,  sum(mh)                    bsc_mh                                                                      \n");
			sb.append("       from   tblpsnscore    a                                                                                         \n");
			sb.append("       where  year      =    ?                                                                                    \n");
			sb.append("       and    emp_no    =    ?                                                                                   \n");
			sb.append("       and    bsc_grade is not null                                                                                    \n");
			sb.append("       group by emp_no                                                                                                 \n");
			sb.append("             ,  emp_nm                                                                                                 \n");
			sb.append("             ,  jikgb_cd                                                                                               \n");
			sb.append("             ,  jikgb_nm                                                                                               \n");
			sb.append("             ,  sbuid                                                                                                  \n");
			sb.append("             ,  bscid   , bsccid                                                                                       \n");
			sb.append("       order by emp_nm, sbuid, bscid                                                                                   \n");
			sb.append("       )                                                                                                               \n");
			sb.append(" order by emp_nm, sbuid, bscid                                                                                         \n");

			Object[] params = {year, empno};
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
	 *  Method : getPsnEmpDeptMh
	 *  Desc.  : 개인별 성과급 MH
     *  Author	    : PHG
     *  Create Date : 2008-03-19
     *  History	    :
	 *
	 */
	public void getPsnEmpDeptMh(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year   = request.getParameter("year");
			String empno  = request.getParameter("empno")==null?"":request.getParameter("empno");
			if ("".equals(empno)){
				empno  = (String)request.getSession().getAttribute("userId");
			}


			System.out.println(" getPsnEmpDeptMh : " + year + ":" + empno);

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			StringBuffer sb = new StringBuffer();

			sb.append(" select a.emp_no   , a.emp_nm , a.jikgb_cd, a.jikgb_nm,            ");
			sb.append("        a.dept_cd  , a.dept_nm   dept_nm,                          ");
			sb.append("        b.org_cd  bsccid,  nvl(f_getbscnm(2,b.org_cd),'-')  bscnm, ");
			sb.append("        a.mh,   a.except_yn, a.except_cmt                          ");
			sb.append(" from  tblpsnbizmh    a,                                           ");
			sb.append("       tbldeptmapping b                                            ");
			sb.append(" where a.year      = b.year   (+)                                  ");
			sb.append(" and   a.dept_cd   = b.dept_cd(+)                                  ");
			sb.append(" and   a.year      = ?                                             ");
			sb.append(" and   a.emp_no    = ?                                             ");
			sb.append(" order by a.emp_nm, b.org_cd, dept_cd                              ");


			Object[] params = {year, empno};
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
	 * Method : getUser
	 * Desc   : 개인성과 사원을 구함.
	 *
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화)
	 *
	 * @param request
	 * @param respons
	 */
	public void getUser(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year   = request.getParameter("year");
			String empnm  = request.getParameter("empnm")==null?"%":Util.getUTF(request.getParameter("empnm"));


			System.out.println("usernm : " + empnm);

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			StringBuffer sb = new StringBuffer();

			sb.append(" SELECT distinct emp_no userid, emp_nm usernm, jikgb_cd, jikgb_nm   ");
			sb.append(" FROM   tblpsnbizmh                                   ");
			sb.append(" WHERE  year = ?                                      ");
			sb.append(" AND    emp_nm like ?||'%'                            ");
			sb.append(" ORDER BY emp_nm                                      ");


			Object[] paramS = {year, empnm};
			rs = dbobject.executePreparedQuery(sb.toString(), paramS);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println("getUser : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/**
	 * Method : getLaborUser
	 * Desc   : 노조원인지 확인.
	 *
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화)
	 *
	 * @param request
	 * @param respons
	 */
	public void getLaborUser(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year   = request.getParameter("year");
			String empno  = request.getParameter("empno")==null?"":request.getParameter("empno");
			if ("".equals(empno)){
				empno  = (String)request.getSession().getAttribute("userId");
			}

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			StringBuffer sb = new StringBuffer();

			sb.append(" SELECT nvl(max('Y'),'N')   laboryn, max(emp_no) emp_no, max(f_getempnm(emp_no)) emp_nm   ");
			sb.append(" FROM   TBLPSNLABOR                 ");
			sb.append(" WHERE  year = ?                                      ");
			sb.append(" AND    emp_no = ?                               ");
			sb.append(" ORDER BY emp_nm                                      ");


			Object[] paramS = {year, empno};
			rs = dbobject.executePreparedQuery(sb.toString(), paramS);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println("getLaborUser : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/**
	 * Method : getLaborUserList
	 * Desc   : 노조원 리스트.
	 *
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화)
	 *
	 * @param request
	 * @param respons
	 */
	public void getLaborUserList(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year   = request.getParameter("year");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			StringBuffer sb = new StringBuffer();

			sb.append(" SELECT emp_no userid, f_getempnm(emp_no) usernm   ");
			sb.append(" FROM   TBLPSNLABOR                                ");
			sb.append(" WHERE  year = ?                                      ");
			sb.append(" ORDER BY 2                                      ");

			//System.out.println("getLaborUser : " + year +  " : " + sb.toString());

			Object[] paramS = {year};
			rs = dbobject.executePreparedQuery(sb.toString(), paramS);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println("getLaborUserList : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 *  Method : setLaborUser
	 *  Desc.  : 성과급 지급률 노조전임 등록
     *  Author	    : PHG
     *  Create Date : 2008-03-19
     *  History	    :
	 *
	 */
	public void setLaborUser(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year = request.getParameter("year");
			String mode = request.getParameter("mode");
			String val  = request.getParameter("val");


			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			// 기존자료 삭제
			String strD = "DELETE FROM tblpsnlabor WHERE year=?";
			dbobject.executePreparedUpdate(strD,new Object[]{year});

			//--------------------------------------------------------------------------------------------
			//  매핑정의
			//--------------------------------------------------------------------------------------------
			if (!"".equals(val.trim())){

				String   emp_no ;

				String[] mapstr = val.split("`");

				System.out.println("mapStr : " + val);

				for (int m = 0; m < mapstr.length; m++) {
					String[] iPart = mapstr[m].split(",");

					emp_no    = iPart[0];

					System.out.println("tblpsnlabor : " + year + "-" + emp_no);

					String strUI  = " insert into tblpsnlabor (year, emp_no)";
						   strUI += " values (?,?)" ;

					Object[] pmUI = {year, emp_no};
					dbobject.executePreparedUpdate(strUI,pmUI);
				}

			}

			conn.commit();

			request.setAttribute("rslt","true");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	//---- setPsnBaseLine


	/**
	 * Method : getExceptBscCd
	 * Desc   : 대전지역 부서 지정
	 *
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화)
	 *
	 * @param request
	 * @param respons
	 */
	public void getExceptBscCd(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year   = request.getParameter("year");
			String sid    = request.getParameter("sid" );

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			StringBuffer sb = new StringBuffer();

			sb.append(" select sid, scid,spid, sname  snm,  srank,                                                                                      ");
			sb.append("        bid, bcid,bpid, bname  bnm,  brank,                                                                                      ");
			sb.append("        count(x.emp_no)   empcnt                                                                                                 ");
			sb.append(" from                                                                                                                            ");
			sb.append("         (select c.name cname,t.id cid,t.contentid ccid,t.parentid cpid,t.rank crank                                             ");
			sb.append("         from tblcompany c, tblhierarchy t where t.treelevel=0 and t.year=? and t.contentid=c.id) com,                      ");
			sb.append("         (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank                                             ");
			sb.append("         from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id ) sbu,     ");
			sb.append("         (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank                                             ");
			sb.append("         from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc,                         ");
			sb.append("         (select * from TBLPSNEXCEPTEMP where year = ?) x                                                                   ");
			sb.append(" where  com.cid = sbu.spid                                                                                                         ");
			sb.append(" and    sbu.sid = bsc.bpid                                                                                                         ");
			sb.append(" and    sbu.sid like ?                                                                                                         ");
			sb.append(" and    bsc.bid = x.bscid(+)                                                                                                     ");
			sb.append(" group by sid, scid,spid, sname , srank,                                                                                         ");
			sb.append("          bid, bcid,bpid, bname , brank                                                                                          ");
			sb.append(" order by srank, sid, brank, bid                                                                                                 ");


			Object[] paramS = {year,year,year,year,sid};
			rs = dbobject.executePreparedQuery(sb.toString(), paramS);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println("getLaborUserList : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}


	/**
	 * Method : getExceptBscUser
	 * Desc   : 대전지역 부서사용자 지정
	 *
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화)
	 *
	 * @param request
	 * @param respons
	 */
	public void getExceptBscUser(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year   = request.getParameter("year");
			String sid    = request.getParameter("sid");
			String bid    = request.getParameter("bid");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			StringBuffer sb = new StringBuffer();

			sb.append(" SELECT sbuid, sbucid, f_getbscnm(1,sbucid)       sbunm,   ");
			sb.append("        bscid, bsccid, f_getbscnm(2,bsccid)       bscnm,   ");
			sb.append("        emp_no userid, f_getempnm(emp_no) usernm   ");
			sb.append(" FROM   TBLPSNEXCEPTEMP                            ");
			sb.append(" WHERE  year  = ?                                  ");
			sb.append(" AND    sbuid like ?||'%'                          ");
			sb.append(" AND    bscid like ?||'%'                          ");
			sb.append(" ORDER BY sbuid, bscid, usernm                     ");


			Object[] paramS = {year,sid,bid};
			rs = dbobject.executePreparedQuery(sb.toString(), paramS);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println("getLaborUserList : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/*
	 *  Method : setExceptBscUser
	 *  Desc.  : 성과급 지급률 평가부서 대상자  등록
     *  Author	    : PHG
     *  Create Date : 2008-03-19
     *  History	    :
	 *
	 */
	public void setExceptBscUser(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year   = request.getParameter("year"  );
			String sbuid  = request.getParameter("sbuid" );
			String sbucid = request.getParameter("sbucid");
			String bscid  = request.getParameter("bscid" );
			String bsccid = request.getParameter("bsccid");
			String mode   = request.getParameter("mode");
			String val    = request.getParameter("val");


			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			//--------------------------------------------------------------------------------------------
			//  매핑정의
			//--------------------------------------------------------------------------------------------
			String   emp_no = "";


			// 기존자료 삭제
			String strD = "DELETE FROM TBLPSNEXCEPTEMP WHERE year=? and bscid = ?";
			dbobject.executePreparedUpdate(strD,new Object[]{year, bscid});

			if (!"".equals(val.trim())){

				String[] mapstr = val.split("`");
				for (int m = 0; m < mapstr.length; m++) {
					String[] iPart = mapstr[m].split(",");

					emp_no    = iPart[0];

					System.out.println("TBLPSNEXCEPTEMP : " + year + "-" + emp_no);

					String strU = "UPDATE TBLPSNEXCEPTEMP SET sbuid = ?, sbucid=?, bscid=?, bsccid= ? WHERE year=? and emp_no = ?";
					Object[] paramU = {sbuid, sbucid, bscid, bsccid, year, emp_no};

					String strUI  = " insert into TBLPSNEXCEPTEMP (year, emp_no, sbuid, sbucid, bscid, bsccid)";
						   strUI += " values (?,?, ?,?,?,?)" ;

					int ret = dbobject.executePreparedUpdate(strU,paramU);
			        if(ret<1){
						Object[] pmUI = {year, emp_no, sbuid, sbucid, bscid, bsccid};
						dbobject.executePreparedUpdate(strUI,pmUI);
			        }
				}

				conn.commit();
			}

			request.setAttribute("rslt","true");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	//---- setPsnBaseLine

	//== End ===================================================================================================
}
