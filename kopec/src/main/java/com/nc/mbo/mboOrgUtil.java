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


public class mboOrgUtil {

	/*
	 * Method : 조직 TREE 구성 - 단/본부
	 * Desc   : 2008년 이후 해마다 조직이 개편되므로 년도별 조직을 구성해야 함, History를 위해서라도.
	 */
	public void getOrgDan(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			// Argument...
			String year  = request.getParameter("year");
			if (year==null) return;

			StringBuffer sb = new StringBuffer();

			// SQL 작성
			sb.append(" SELECT A.CODE         dan_cd,                                                                                ");
			sb.append("        A.CODE_NAME1   dan_nm,                                                                                ");
			sb.append("        DECODE(SUBSTR(A.CODE,1,1),'D','P10','E','P20','G','P30','F','P40','J','P70','B','','P60') GROUP_CD,   ");
			sb.append("        'Y'            child                                                                                  ");
			sb.append(" FROM   CD00.CD03T@LNK_CPMIS A,                                                                               ");
			sb.append("        (SELECT  distinct a.organ_cd                                                                          ");
			sb.append("         FROM   pa00.T_PAOR001T@lnk_cpmis a,                                                                  ");
			sb.append("                 (                                                                                            ");
			sb.append("                 SELECT  organ_id, organ_cd, organ_name,                                                      ");
			sb.append("                         substr(st_date,1,4)   org_year, st_date, sday,                                       ");
			sb.append("                         case when eday is null then '99999999' else eday end eday, close_day                 ");
			sb.append("                 FROM    pa00.T_PAOR001T@lnk_cpmis                                                            ");
			sb.append("                 ) b                                                                                          ");
			sb.append("         WHERE b.sday    <= ?||'0101'                                                                    ");
			sb.append("         AND   b.eday    >= ?||'1231'                                                                    ");
			sb.append("         AND   a.organ_id = b.organ_id                                                                        ");
			sb.append("         AND   a.organ_cd = b.organ_cd                                                                        ");
			sb.append("         AND   a.organ_cd like '__000'                                                                        ");
			sb.append("        ) B                                                                                                   ");
			sb.append(" WHERE ( A.SYSGB   = 'IN' )                                                                                   ");
			sb.append(" AND   ( A.CODE_GB = '05' )                                                                                   ");
			sb.append(" AND   ( SUBSTR(A.CODE,3,3) = '000' )                                                                         ");
			sb.append(" AND   A.CODE      = B.ORGAN_CD                                                                               ");
			sb.append(" ORDER BY 1                                                                                                   ");

			// Connection
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// 조회
			Object[] param = {year,year};
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
	 * Method : 조직 TREE 구성 - 단/본부
	 * Desc   : 2008년 이후 해마다 조직이 개편되므로 년도별 조직을 구성해야 함, History를 위해서라도.
	 */
	public void getOrgJobGroup(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			// Argument...
			String groupcd  = request.getParameter("jobgroupcd");
			if (groupcd==null) return;

			System.out.println("GROUP_CD : " + groupcd);

			StringBuffer sb = new StringBuffer();

			// SQL 작성

			/* 2 : 단본부의 하위조직 구함 : P40 */
			sb.append(" SELECT A.TC_JOB_GROUP    job_group_cd,                            ");
			sb.append("        A.TC_CODE_NAME    job_group_nm,                            ");
			sb.append(" 			(SELECT NVL(MAX('Y'),'N')  child                      ");
			sb.append("        FROM   pa00.T_PAOR001T@lnk_cpmis B                         ");
			sb.append("        WHERE  B.GROUP_CD = A.TC_JOB_GROUP AND ROWNUM = 1) CHILD   ");
			sb.append(" FROM  TC00.TC21T_JOB_GROUP_CD@lnk_cpmis  A                        ");
			sb.append(" WHERE ( A.TC_JOB_GUBUN1 = ?  )                                    ");
			sb.append(" AND   ( A.PE_GB = '1' )                                           ");
			sb.append(" AND   TRIM(A.TC_CODE_NAME) <> 'CH900'                             ");

			// Connection
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// 조회
			Object[] param = {groupcd};
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
	 * Method : 조직 TREE 구성 - 3 레벨 조직
	 * Desc   : 2008년 이후 해마다 조직이 개편되므로 년도별 조직을 구성해야 함, History를 위해서라도.
	 */
	public void getOrgDivision(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			// Argument...
			String dancd  = request.getParameter("dancd");
			String groupcd  = request.getParameter("groupcd");

			if (dancd  ==null) return;
			if (groupcd==null) return;

			StringBuffer sb = new StringBuffer();

			/* 3-1 : 그룹의 하위 조직 : F, 422 : 단과 GroupID로 구함.*/
			sb.append(" SELECT   A.ORGAN_CD    org_cd  ,                ");
			sb.append("          A.ORGAN_NAME  org_nm  ,                ");
			sb.append("          A.GROUP_CD    group_cd,                ");
			sb.append("     	 (SELECT NVL(MAX('Y'),'N')  child       ");
			sb.append("         FROM   PA00.T_PAOR001T@lnk_cpmis B      ");
			sb.append("         WHERE  B.OWNER_ORGAN_CD = A.ORGAN_CD    ");
			sb.append("         AND    ROWNUM = 1) CHILD                ");
			sb.append(" FROM  pa00.T_PAOR001T@lnk_cpmis A               ");
			sb.append(" WHERE A.DAN_CD     like substr(?,1,1)||'%'      ");
			sb.append(" AND   A.ORGAN_LEVEL   = '3'                     ");
			sb.append(" AND   A.GROUP_CD      = ?                       ");
			sb.append(" ORDER BY A.ORGAN_ID                             ");


			// Connection
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// 조회
			Object[] param = {dancd, groupcd};
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
	 * Method : 조직 TREE 구성 - 부모조직 아래 아무거나...
	 * Desc   : 2008년 이후 해마다 조직이 개편되므로 년도별 조직을 구성해야 함, History를 위해서라도.
	 */
	public void getOrgInfo(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			// Argument...
			String year   = request.getParameter("year" );
			String orgcd  = request.getParameter("orgcd");
			if (orgcd==null) return;

			StringBuffer sb = new StringBuffer();

			/* 3-2 : 조직의 하위조직
			sb.append(" select a.organ_cd          org_cd      ,                                                                             ");
			sb.append("        a.organ_name        org_nm      ,                                                                           ");
			sb.append("        a.owner_organ_cd    owner_org_cd,                                                                       ");
			sb.append(" 	    (select NVL(MAX('Y'),'N')  child                                                       ");
			sb.append("        from   pa00.t_paor001t@lnk_cpmis b                                                      ");
			sb.append("        where  b.owner_organ_cd = a.organ_cd                                                    ");
			sb.append("        and    rownum = 1  ) child                                                              ");
			sb.append(" from  pa00.t_paor001t@lnk_cpmis a ,                                                            ");
			sb.append("       (select  distinct a.organ_id, a.organ_cd                                                 ");
			sb.append("         from   pa00.t_paor001t@lnk_cpmis a,                                                    ");
			sb.append("                 (                                                                              ");
			sb.append("                 select  organ_id, organ_cd, organ_name,                                        ");
			sb.append("                         substr(st_date,1,4)   org_year, st_date, sday,                         ");
			sb.append("                         case when eday is null then '99999999' else eday end eday, close_day   ");
			sb.append("                 from    pa00.t_paor001t@lnk_cpmis                                              ");
			sb.append("                 ) b                                                                            ");
			sb.append("         where b.sday    <= ?||'0101'                                                      ");
			sb.append("         and   b.eday    >= ?||'1231'                                                      ");
			sb.append("         and   a.organ_id = b.organ_id                                                          ");
			sb.append("         and   a.organ_cd = b.organ_cd                                                          ");
			sb.append("         ) b                                                                                    ");
			sb.append(" where a.owner_organ_cd like ?                                                             ");
			sb.append(" and   a.seq = (select max(seq) from pa00.t_paor001t@lnk_cpmis c                                ");
			sb.append("                where a.organ_cd = c.organ_cd                                                   ");
			sb.append("                and   a.organ_id = c.organ_id                                                   ");
			sb.append("                and   c.st_date  = (select max(st_date)                                         ");
			sb.append("                                    from   pa00.t_paor001t@lnk_cpmis d                          ");
			sb.append("                                    where  a.organ_cd = d.organ_cd                              ");
			sb.append("                                    and    a.organ_id = d.organ_id))                            ");
			sb.append(" and   a.organ_cd <> a.owner_organ_cd                                                           ");
			sb.append(" and   a.organ_id = b.organ_id                                                                  ");
			sb.append(" and   a.organ_cd = b.organ_cd                                                                  ");
			sb.append(" order by a.organ_id ,  a.dept_order                                                             ");
			*/

			/*
			 * 년도별 조직 TREE를 구하자...
			 * 1. 년 조직이 변경되면 st_date가 변경되면서 seq + 1이 된다.
			 * 2. sday, eday를 체크해야한다.
			 */

			sb.append("  select org_cd, org_nm, owner_org_cd, child                                                                        ");
			sb.append("  from   (                                                                                                          ");
			sb.append("  select a.organ_id ,                                                                                               ");
			sb.append("         a.organ_cd          org_cd      ,                                                                          ");
			sb.append("         a.organ_name        org_nm      ,                                                                          ");
			sb.append("         a.owner_organ_cd    owner_org_cd, a.dept_order ,                                                           ");
			sb.append("         a.sday,                                                                                                    ");
			sb.append("         case when ltrim(a.eday) is null then ?||'1231' else eday end eday,                                    ");
			sb.append("         case when a.sday <= ?||'0101' and nvl(ltrim(a.eday),?||'1231') >= ?||'0101' then 'Y'        ");
			sb.append("              when a.sday >= ?||'0101' and nvl(ltrim(a.eday),?||'1231') <= ?||'1231' then 'Y'        ");
			sb.append("              else 'N' end checkyear,                                                                               ");
			sb.append("        (select NVL(MAX('Y'),'N')  child                                                                            ");
			sb.append("         from   pa00.t_paor001t@lnk_cpmis b                                                                         ");
			sb.append("         where  b.owner_organ_cd = a.organ_cd                                                                       ");
			sb.append("         and    rownum = 1  ) child                                                                                 ");
			sb.append("  from  pa00.t_paor001t@lnk_cpmis a ,                                                                               ");
			sb.append("       (                                                                                                            ");
			sb.append("         select organ_id, organ_cd, max(organ_name) organ_nm, max(seq)  seq                                         ");
			sb.append("         from   pa00.t_paor001t@lnk_cpmis d                                                                         ");
			sb.append("         where  d.owner_organ_cd     = ?                                                                    ");
			sb.append("         and    (case when d.st_date = '00000000' then ?||'0101' else d.st_date end) <= ?||'1231'         ");
			sb.append("         group by organ_id, organ_cd                                                                                ");
			sb.append("       ) b                                                                                                          ");
			sb.append("  where  a.organ_id = b.organ_id                                                                                    ");
			sb.append("  and    a.organ_cd = b.organ_cd                                                                                    ");
			sb.append("  and    a.seq      = b.seq                                                                                         ");
			sb.append("  and    a.organ_cd <> a.owner_organ_cd                                                                             ");
			sb.append("  ) a                                                                                                               ");
			sb.append("  where  checkyear = 'Y'                                                                                            ");
			sb.append("  order by a.org_cd, a.dept_order                                                                                   ");

			// Connection
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// 조회
			Object[] param = {year,   year, year, year,   year, year, year,   orgcd, year, year};
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
