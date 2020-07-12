package com.nc.xml;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Vector;
import javax.servlet.GenericServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;
import com.nc.util.ServerStatic;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ValuateGroupUtil {

	/**
	 * Method : getValuateGroup
	 * Desc   : 년월 조직의 평가그룹을 구함.
	 * 
	 * Rev.   : 1.2008.08.12 by PHG.  Init Version 
	 * 
	 * @param request
	 * @param respons
	 */

	public void getValuateOrgGroup(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			String ym     = request.getParameter("ym" );
			String sid    = request.getParameter("sid");
			
			String year   = ym.substring(0,4);
			String month  = ym.substring(4,6);
			String userId = (String)request.getSession().getAttribute("userId");

			System.out.println("SID : " + sid);
			
			StringBuffer sb = new StringBuffer();
			
			sb.append(" SELECT  cid, ccid, clevel, crank, cname,                                                                                      ");
			sb.append("         sid, scid, slevel, srank, sname,                                                                                      ");
			sb.append("         bid, bcid, blevel, brank, bname,                                                                                      ");
			sb.append("         year, month, grpid, grpnm, orgcd, orgnm, empno, empnm                                                                 ");
			sb.append(" FROM                                                                                                                          ");
			sb.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname       ");
			sb.append("         from   tblhierarchy t,tblcompany c                                                                                    ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                                         ");
			sb.append("        ) com,                                                                                                                 ");
			sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname       ");
			sb.append("         from   tblhierarchy t,tblsbu c                                                                                        ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =? and t.id like ?                                                    ");
			sb.append("        ) sbu,                                                                                                                 ");
			sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname       ");
			sb.append("         from   tblhierarchy t,tblbsc c                                                                                        ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =?                                                         ");
			sb.append("        ) bsc,                                                                                                                 ");
			sb.append("        (                                                                                                                      ");
			sb.append("         SELECT a.year, a.month, a.grpid, a.grpnm,                                                                             ");
			sb.append("                b.evaldeptid  orgcd, c.name                orgnm,                                                              ");
			sb.append("                d.evalrid     empno, f_getempnm(d.evalrid) empnm                                                               ");
			sb.append("         FROM   tblmeaevalgrp  a,                                                                                              ");
			sb.append("                tblmeaevaldept b,                                                                                              ");
			sb.append("                tblbsc         c,                                                                                              ");
			sb.append("                tblmeaevalr    d                                                                                               ");
			sb.append("         WHERE  a.grpid      = b.grpid                                                                                         ");
			sb.append("         AND    b.evaldeptid = c.id                                                                                            ");
			sb.append("         AND    a.year       = d.year (+)                                                                                      ");
			sb.append("         AND    a.month      = d.month(+)                                                                                      ");
			sb.append("         AND    a.grpid      = d.grpid(+)                                                                                      ");
			sb.append("         AND    a.year       = ?                                                                                          ");
			sb.append("         AND    a.month      = ?                                                                                            ");
			sb.append("         ORDER BY a.grpid, b.evaldeptid                                                                                        ");
			sb.append("         ) est                                                                                                                 ");
			sb.append(" WHERE  cid  = spid (+)                                                                                                        ");
			sb.append(" AND    sid  = bpid                                                                                                            ");
			sb.append(" AND    bcid = orgcd (+)                                                                                                       ");
			sb.append(" ORDER BY crank, srank, brank                                                                                                  ");

			Object[] params = null;
	        params = new Object[] {year,year,sid,year,year,month };

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds", ds);
		} catch (Exception e) {
			System.out.println("getValuateOrgGroup : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	
	/**
	 * Method : getValuator
	 * Desc   : 평가위원을 구함.
	 * 
	 * Rev.   : 1.2008.08.12 by PHG.  Init Version 
	 * 
	 * @param request
	 * @param respons
	 */

	public void getValuator(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			String auth = "1";			
			StringBuffer sb = new StringBuffer();
			
			sb.append("SELECT a.userid, a.username usernm,                     ");
			sb.append("       a.dept_cd deptcd, b.dept_nm  deptnm	           ");		
			sb.append("FROM   tbluser a, tbldept b                             ");
			sb.append("WHERE  a.dept_cd = b.dept_cd (+)                        ");
			sb.append("AND    a.appraiser = ?                                  ");
			sb.append("ORDER BY a.dept_cd                                      ");

			Object[] params = null;
	        params = new Object[] {auth};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds", ds);
		} catch (Exception e) {
			System.out.println("getValuator : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	/**
	 * Method : setOrgValuator
	 * Desc   : 부서별 평가위원 설정
	 * 
	 * Rev.   : 1.2008.08.12 by PHG.  Init Version 
	 * 
	 * @param request
	 * @param respons
	 */	
	public void setOrgValuator(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			/* 1. 평가그룹 설정 (tblmeaevalgrp)
			 * 2. 평가그룹별 부서설정 (tblmeaevaldept)
			 * 3. 평가그룹별 평가위원설정 (tblmeaevalr)
			 * 
			 */
			
			String tag    = request.getParameter("tag"  );
			String ym     = request.getParameter("ym"   );
			String sid    = request.getParameter("sid"  );
			String scid   = request.getParameter("scid" );
			String sname  = request.getParameter("sname");			
			String bid    = request.getParameter("bid"  );
			String bcid   = request.getParameter("bcid" );
			String bname  = request.getParameter("bname");			
			String grpid  = request.getParameter("grpid");
			String empno  = request.getParameter("empno");
			
			if ((ym==null)) return;

			String year   = ym.substring(0,4);
			String month  = ym.substring(4,6);
			String userId = (String)request.getSession().getAttribute("userId");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			System.out.println("setOrgValuator : "+ ym + ":" + tag);
			
			String strU = null;
			String strI = null;
			Object[] pmI = null;
			Object[] pmU = null;

			//----------------------------------------------------------------------------
			// UPDATE & INSERT.ALL..
			//----------------------------------------------------------------------------
			if ("UA".equals(tag)){
					
					String orgstr = request.getParameter("orgstr")==null?"":request.getParameter("orgstr");
					if (!"".equals(orgstr.trim())){
						
						grpid   = null;			
						bid     = null;			
						bcid    = null;			// 부서 TREE ID
						bname   = null;			// 부서 ContentID
						empno   = null; 
						
						String[] orgdefineids = orgstr.split("\\`");	
						
						// 부서로 ...
						for (int m = 0; m < orgdefineids.length; m++) {
							
							String[] iPart = orgdefineids[m].split("\\^");	
						
							grpid   = iPart[0];			
							bid     = iPart[1];			
							bcid    = iPart[2];							// ContentID
							bname   = iPart[3];			// 부서명
							empno   = iPart[4]; 
							
							System.out.println("setOrgValuator Update All : "+ ym + ":" + grpid + ":" + bcid + ":"+empno);
							
						 	// 1. 평가그룹 설정 (tblmeaevalgrp) : GRP ID는 BSC Content ID로 설정함.
							strU = "update tblmeaevalgrp set grpnm = ?, modir = ?, modidate = sysdate where grpid = ? and year = ? and month = ? ";
							pmU = new Object[]{bname,userId,grpid,year,month};

							if (dbobject.executePreparedUpdate(strU,pmU)<1){
								
								grpid = getMaxGrpId(dbobject);
								
								strI = "INSERT INTO tblmeaevalgrp (grpid,year,month,grpnm,regir,modir) VALUES (?,?,?,?,?,?)";
								pmI = new Object[] {grpid,year,month,bname,userId,userId};						

								dbobject.executePreparedUpdate(strI,pmI);
							}

							// 2. 평가그룹별 부서설정 (tblmeaevaldept)
							strU = "update tblmeaevaldept set modir = ?, modidate = sysdate where grpid = ? and evaldeptid = ?";
							pmU = new Object[] {userId,grpid,bcid};

							if (dbobject.executePreparedUpdate(strU,pmU)<1){						
								strI = "INSERT INTO tblmeaevaldept (grpid,evaldeptid,regir,modir) VALUES (?,?,?,?)";
								pmI = new Object[] {grpid,bcid,userId,userId};
								
								dbobject.executePreparedUpdate(strI,pmI);
							}					

							// 3. 평가그룹별 평가위원설정 (tblmeaevalr)
							strU = "update tblmeaevalr set modir = ?, modidate = sysdate where grpid = ? and year = ? and month = ? and evalrid =?";
							pmU = new Object[] {userId,grpid,year,month,empno};

							if (dbobject.executePreparedUpdate(strU,pmU)<1){
							
								strI = "INSERT INTO tblmeaevalr (grpid,year,month,evalrid,regir,modir) VALUES (?,?,?,?,?,?)";
								pmI = new Object[] {grpid,year,month,empno,userId,userId};
								
								dbobject.executePreparedUpdate(strI,pmI);
							}								
						}	
						
					}				
					
			//----------------------------------------------------------------------------
			// UPDATE & INSERT...
			//----------------------------------------------------------------------------
			} else if ("U".equals(tag)){

				 	// 1. 평가그룹 설정 (tblmeaevalgrp) : GRP ID는 BSC Content ID로 설정함.
					strU = "update tblmeaevalgrp set grpnm = ?, modir = ?, modidate = sysdate where grpid = ? and year = ? and month = ? ";
					pmU = new Object[]{bname,userId,grpid,year,month};

					if (dbobject.executePreparedUpdate(strU,pmU)<1){
						
						grpid = getMaxGrpId(dbobject);
						
						strI = "INSERT INTO tblmeaevalgrp (grpid,year,month,grpnm,regir,modir) VALUES (?,?,?,?,?,?)";
						pmI = new Object[] {grpid,year,month,bname,userId,userId};						

						dbobject.executePreparedUpdate(strI,pmI);
					}
					System.out.println("setOrgValuator 1 : "+ ym + ":" + grpid);

					// 2. 평가그룹별 부서설정 (tblmeaevaldept)
					strU = "update tblmeaevaldept set modir = ?, modidate = sysdate where grpid = ? and evaldeptid = ?";
					pmU = new Object[] {userId,grpid,bcid};

					if (dbobject.executePreparedUpdate(strU,pmU)<1){						
						strI = "INSERT INTO tblmeaevaldept (grpid,evaldeptid,regir,modir) VALUES (?,?,?,?)";
						pmI = new Object[] {grpid,bcid,userId,userId};
						
						dbobject.executePreparedUpdate(strI,pmI);
					}					
					System.out.println("setOrgValuator 2 : "+ ym + ":" + grpid);
					
					// 3. 평가그룹별 평가위원설정 (tblmeaevalr)
					strU = "update tblmeaevalr set modir = ?, modidate = sysdate where grpid = ? and year = ? and month = ? and evalrid =?";
					pmU = new Object[] {userId,grpid,year,month,empno};

					if (dbobject.executePreparedUpdate(strU,pmU)<1){
					
						strI = "INSERT INTO tblmeaevalr (grpid,year,month,evalrid,regir,modir) VALUES (?,?,?,?,?,?)";
						pmI = new Object[] {grpid,year,month,empno,userId,userId};
						
						dbobject.executePreparedUpdate(strI,pmI);
					}			
					System.out.println("setOrgValuator 3 : "+ ym + ":" + grpid);
					
			//----------------------------------------------------------------------------
			// DELETE ...
			//----------------------------------------------------------------------------
			} else if ("D".equals(tag) ) {
			 	// GRP ID는 BSC ID로 설정하기 때문에 굳이 BSCID를 삭제할 이유없음.
				String strD = "delete tblmeaevalr where grpid = ? and year = ? and month = ? and evalrid =?";
				Object[] pmD = {grpid,year,month,empno};
				dbobject.executePreparedUpdate(strD,pmD);
				
				System.out.println("setOrgValuator 3 : "+ ym + ":" + grpid + ":" + empno);

			//----------------------------------------------------------------------------
			// DELETE All...
			//----------------------------------------------------------------------------
			} else if ("DA".equals(tag) ) {
			 	// GRP ID는 BSC ID로 설정하기 때문에 굳이 BSCID를 삭제할 이유없음.
				StringBuffer sb = new StringBuffer();
				
				sb.append(" DELETE tblmeaevalr                                                                          ");
				sb.append(" WHERE  year = ?                                                                             ");
				sb.append(" AND    month = ?                                                                            ");
				sb.append(" AND    grpid in (                                                                           ");
				sb.append(" 				SELECT distinct grpid FROM (                                                        ");
				sb.append(" 				SELECT                                                                              ");
				sb.append(" 				        sid, scid,  sname,                                                          ");
				sb.append(" 				        bid, bcid,  bname,                                                          ");
				sb.append(" 				        year, month, grpid, grpnm, orgcd                                            ");
				sb.append(" 				FROM                                                                                ");
				sb.append(" 				       (select t.id sid,t.parentid spid,t.contentid scid,c.name sname               ");
				sb.append(" 				        from   tblhierarchy t,tblsbu c                                              ");
				sb.append(" 				        where  t.contentid=c.id  and t.treelevel=1 and t.year =? and t.id like ?    ");
				sb.append(" 				       ) sbu,                                                                       ");
				sb.append(" 				       (select t.id bid,t.parentid bpid,t.contentid bcid,c.name bname               ");
				sb.append(" 				        from   tblhierarchy t,tblbsc c                                              ");
				sb.append(" 				        where  t.contentid=c.id  and t.treelevel=2 and t.year =?                    ");
				sb.append(" 				       ) bsc,                                                                       ");
				sb.append(" 				       (                                                                            ");
				sb.append(" 				        SELECT a.year, a.month, a.grpid, a.grpnm,                                   ");
				sb.append(" 				               b.evaldeptid  orgcd                                                  ");
				sb.append(" 				        FROM   tblmeaevalgrp  a,                                                    ");
				sb.append(" 				               tblmeaevaldept b                                                     ");
				sb.append(" 				        WHERE  a.grpid      = b.grpid                                               ");
				sb.append(" 				        AND    a.year       = ?                                                     ");
				sb.append(" 				        AND    a.month      = ?                                                     ");
				sb.append(" 				        ORDER BY a.grpid, b.evaldeptid                                              ");
				sb.append(" 				        ) est                                                                       ");
				sb.append(" 				WHERE  sid  = bpid                                                                  ");
				sb.append(" 				AND    bcid = orgcd                                                                 ");
				sb.append(" 				) )                                                                                 ");

				Object[] pmD = {year,month,year,sid,year,year,month};				
				dbobject.executePreparedUpdate(sb.toString(),pmD);
				
				System.out.println("setOrgValuator 3 : "+ ym + ":" + sid);
			} 

			request.setAttribute("rslt","true");

			conn.commit();
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("setOrgValuator :" + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	/**
	*   getMaxGrpId : tblmeaevalgrp 있는 MAX GRPID 구함.
	*/
	public String getMaxGrpId(DBObject  dbobject) throws SQLException{
		
		ResultSet rs = null;
		try {
			StringBuffer sb = new StringBuffer();
			
			sb.append(" SELECT ltrim(to_char(nvl(to_number(MAX(grpid)),0) + 1)) maxid FROM tblmeaevalgrp ");
			rs = dbobject.executeQuery(sb.toString());
			if (rs.next()) return rs.getString("maxid");
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			if(rs !=null){rs.close(); rs = null;}
		}
		return "1";
	}		
}
