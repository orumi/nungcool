package com.nc.xml;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.StringTokenizer;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.security.action.GetBooleanAction;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;
import com.nc.math.Expression;
import com.nc.math.ExpressionParser;

public class BscTreeUtil {
	
	/**
	 * Method : getTreeMeasList
	 * Desc   : 년도의 조직과 지표리스트를 구하는 기본 SQL.
	 * 
	 * Rev.   : 1.2008.08.05 by PHG.  Init Version(모듈화) 
	 * 
	 * @param request
	 * @param respons
	 */
	
	public void getTreeMeasList(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT  cid, cpid, ccid, clevel, crank, cname,  cweight,                                                                   ");
			sb.append("         sid, spid, scid, slevel, srank, sname,  sweight,                                                                   ");
			sb.append("         bid, bpid, bcid, blevel, brank, bname,  bweight,                                                                   ");
			sb.append("         pid, ppid, pcid, plevel, prank, pname,  pweight,                                                                   ");
			sb.append("         oid, opid, ocid, olevel, orank, oname,  oweight,                                                                   ");
			sb.append("         mid, mpid, mcid, mlevel, mrank, mname,  mweight,                                                                   ");
			sb.append("         measureid, measurement, frequency, trend, etlkey, updateid                                                         ");
			sb.append(" FROM                                                                                                                       ");
			sb.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname    ");
			sb.append("         from   tblhierarchy t,tblcompany c                                                                                 ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                                      ");
			sb.append("        ) com,                                                                                                              ");
			sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname    ");
			sb.append("         from   tblhierarchy t,tblsbu c                                                                                     ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =?                                                      ");
			sb.append("        ) sbu,                                                                                                              ");
			sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname    ");
			sb.append("         from   tblhierarchy t,tblbsc c                                                                                     ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =?                                                           ");
			sb.append("        ) bsc,                                                                                                              ");
			sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname    ");
			sb.append("         from   tbltreescore t,tblpst c                                                                                     ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                                           ");
			sb.append("        ) pst  ,                                                                                                            ");
			sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname    ");
			sb.append("         from   tbltreescore t,tblobjective c                                                                               ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                                           ");
			sb.append("        ) obj ,                                                                                                             ");
			sb.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname, ");
			sb.append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey,                                      ");
			sb.append("                d.unit       , d.updateid,                                                                                  ");
			sb.append("                d.planned,d.base, d.limit                                                                                   ");
			sb.append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d                                                       ");
			sb.append("         where  t.contentid=d.id  and t.treelevel=5 and t.year =? and d.measureid=c.id                                      ");
			sb.append("        ) mea                                                                                                               ");
			sb.append(" where  cid = spid (+)                                                                                                      ");
			sb.append(" and    sid = bpid (+)                                                                                                      ");
			sb.append(" and    bid = ppid (+)                                                                                                      ");
			sb.append(" and    pid = opid (+)                                                                                                      ");
			sb.append(" and    oid = mpid (+)                                                                                                      ");
			sb.append(" order by crank,cid, srank,sid, brank,bid, prank, pid, orank, oid, mrank, mid                                               ");
			
	        Object[] params = {year,year,year, year,year,year};
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			rs = dbobject.executePreparedQuery(sb.toString(),params);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds", ds);
		} catch (Exception e) {
			System.out.println("getTreeMeasList Error : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	
	/**
	 * Method : getTreeOrgList
	 * Desc   : 년도의 조직을 구하는 기본 SQL.
	 * 
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version. 
	 * 
	 * @param request
	 * @param respons
	 */	
	public void getTreeOrgList(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT  cid, cpid, ccid, clevel, crank, cname,  cweight,                                                                   ");
			sb.append("         sid, spid, scid, slevel, srank, sname,  sweight,                                                                   ");
			sb.append("         bid, bpid, bcid, blevel, brank, bname,  bweight                                                                    ");
			sb.append(" FROM                                                                                                                       ");
			sb.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname    ");
			sb.append("         from   tblhierarchy t,tblcompany c                                                                                 ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                                           ");
			sb.append("        ) com,                                                                                                              ");
			sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname    ");
			sb.append("         from   tblhierarchy t,tblsbu c                                                                                     ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =?                                                           ");
			sb.append("        ) sbu,                                                                                                              ");
			sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname    ");
			sb.append("         from   tblhierarchy t,tblbsc c                                                                                     ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =?                                                           ");
			sb.append("        ) bsc                                                                                                               ");
			sb.append(" where  cid = spid (+)                                                                                                      ");
			sb.append(" and    sid = bpid                                                                                                          ");
			sb.append(" order by crank,cid, srank, sid, brank, bid                                                                                 ");
			
	        Object[] params = {year,year,year};
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			rs = dbobject.executePreparedQuery(sb.toString(),params);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds", ds);
		} catch (Exception e) {
			System.out.println("getTreeOrgList Error : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	/**
	 * Method : getTreeBscList
	 * Desc   : 년도의 특정조직의 관점,성과목표,지표를 구하는 기본 SQL.
	 * 
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화)
	 * 
	 * @param request
	 * @param respons
	 */	
	public void getTreeBscList(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year  = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			String bscid = request.getParameter("bscid");

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT  pid, ppid, pcid, plevel, prank, pname,  sum(mweight) over (partition by pid     ) pweight,                ");
			sb.append("         oid, opid, ocid, olevel, orank, oname,  sum(mweight) over (partition by pid, oid) oweight,                ");
			sb.append("         mid, mpid, mcid, mlevel, mrank, mname,  mweight,                                                                         ");
			sb.append("         measureid, measurement, frequency, trend, etlkey, updateid                                                         ");
			sb.append(" FROM                                                                                                                       ");
			sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname    ");
			sb.append("         from   tbltreescore t,tblpst c                                                                                     ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=3 and t.year =? and t.parentid = ?                                        ");
			sb.append("        ) pst  ,                                                                                                            ");
			sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname    ");
			sb.append("         from   tbltreescore t,tblobjective c                                                                               ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                                           ");
			sb.append("        ) obj ,                                                                                                             ");
			sb.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname, ");
			sb.append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey,                                      ");
			sb.append("                d.unit       , d.updateid,                                                                                  ");
			sb.append("                d.planned,d.base, d.limit                                                                                   ");
			sb.append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d                                                       ");
			sb.append("         where  t.contentid=d.id  and t.treelevel=5 and t.year =? and d.measureid=c.id                                      ");
			sb.append("        ) mea                                                                                                               ");
			sb.append(" where  pid = opid (+)                                                                                                      ");
			sb.append(" and    oid = mpid (+)                                                                                                      ");
			sb.append(" order by prank, pid, orank, oid, mrank, mid                                                                          ");
			
	        Object[] params = {year,bscid,year,year};
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			rs = dbobject.executePreparedQuery(sb.toString(),params);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds", ds);
		} catch (Exception e) {
			System.out.println("getTreeBscList Error : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	
	
	/**
	 * Method : getComponent
	 * Desc   : 조직,관점,성과목표,지표 코드를 구하는 기본 SQL.
	 * 
	 * Rev.   : 1.2008.08.05 by PHG.  Init Version(모듈화)
	 * 
	 * @param request
	 * @param respons
	 */		
	public void getComponent(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null; 
		try {

			StringBuffer sb = new StringBuffer();
			sb.append(" select 0 kd,id,name from tblcompany    ");
			sb.append(" union                                  ");
			sb.append(" select 1 kd,id,name from tblsbu        ");
			sb.append(" union                                  ");
			sb.append(" select 2 kd,id,name from tblbsc        ");
			sb.append(" union                                  ");
			sb.append(" select 3 kd,id,name from tblpst        ");
			sb.append(" union                                  ");
			sb.append(" select 4 kd,id,name from tblobjective  ");
			sb.append(" union                                  ");
			sb.append(" select 5 kd,id,name from tblmeasure    ");
			sb.append(" order by kd,name                       ");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			rs = dbobject.executeQuery(sb.toString());
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds", ds);
		} catch (Exception e) {
			System.out.println("getComponent Error : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	/**
	 * Method : getEquType
	 * Desc   : 목표구간값 구함.
	 * 
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화) 
	 * 
	 * @param request
	 * @param respons
	 */		
	public void getEquType (HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
		try {  
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			
			
			String strS = "SELECT * FROM TBLEQUATIONTYPE ORDER BY TYPE";
			
			rs = dbobject.executeQuery(strS);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}		
	
	/**
	 * Method : getBscUser
	 * Desc   : 성과담당자를 구함.
	 * 
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화) 
	 * 
	 * @param request
	 * @param respons
	 */	
	public void getBscUser(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
		try {  			
			
			String usernm = request.getParameter("usernm")==null?"%":request.getParameter("usernm");
			
			System.out.println("usernm : " + usernm);
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			
			StringBuffer sb = new StringBuffer();
			
			sb.append(" select b.dept_cd  orgcd, b.dept_nm orgnm, ");
			sb.append("        a.userid   ,    a.username usernm  ");
			sb.append(" from   tbluser a, tbldept b               ");
			sb.append(" where  a.dept_cd  = b.dept_cd (+)         ");
			sb.append(" and    a.groupid  < 4                     ");
			sb.append(" and    a.username like ?||'%'             ");
			sb.append(" order by 2, username                      ");
			
			Object[] paramS = {usernm};			
			rs = dbobject.executePreparedQuery(sb.toString(), paramS);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
		} catch (Exception e) {
			System.out.println("getBscUser : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	
		
	/**
	 * Method : getMeasUser
	 * Desc   : 지표 담당자를 구함.
	 * 
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화) 
	 * 
	 * @param request
	 * @param respons
	 */	
	public void getMeasUser(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
		try {  			
			
			String mcid= request.getParameter("mcid");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			
			StringBuffer sb = new StringBuffer();
			
			sb.append(" SELECT  distinct                                                                     ");
			sb.append("         b.orgcd, b.orgnm, b.userid, b.usernm, mngyn                                  ");
			sb.append(" FROM                                                                                 ");
			sb.append("         (                                                                            ");
			sb.append("         SELECT userid  , 'N' mngyn FROM tblauthority      WHERE measureid like ?     ");
			sb.append("         UNION ALL                                                                    ");
			sb.append("         SELECT updateid, 'Y' mngyn FROM tblmeasuredefine  WHERE id        like ?     ");
			sb.append("         ) a,                                                                         ");
			sb.append("         (                                                                            ");
			sb.append("         select b.dept_cd  orgcd,    b.dept_nm  orgnm,                                ");
			sb.append("                a.userid   ,    a.username usernm                                     ");
			sb.append("         from   tbluser a, tbldept b                                                  ");
			sb.append("         where  a.dept_cd = b.dept_cd (+)                                             ");
			sb.append("         and    a.groupid < 4                                                         ");
			sb.append("         order by 2, a.username                                                       ");
			sb.append("         ) b                                                                          ");
			sb.append(" WHERE a.userid = b.userid                                                            ");
			sb.append(" ORDER BY mngyn desc, orgnm, usernm                                                   ");
			
			System.out.println("MEAS USER : " + mcid + "/" + sb.toString());
			
			Object[] paramS = {mcid, mcid};
			
			rs = dbobject.executePreparedQuery(sb.toString(), paramS);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
		} catch (Exception e) {
			System.out.println("getMeasUser : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	
	
	/**
	 * Method : updateTreeNode
	 * Desc   : 조직,관점,성과목표,지표 코드 수정 기본 SQL.
	 * 
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화) 
	 * 
	 * @param request
	 * @param respons
	 */	
	public void updateTreeNode(HttpServletRequest request, HttpServletResponse response){
		
		CoolConnection conn = null;
		DBObject dbobject   = null;
		ResultSet rs = null; 
		Hashtable ht = new Hashtable();
		
		try {

			String tag      = request.getParameter("tag" );			
			String year     = request.getParameter("year");
			String level    = request.getParameter("level")!=null?request.getParameter("level"):"-1";
			String userInfo = (String)request.getSession().getAttribute("userId")+"_"+request.getSession().getAttribute("userName");
			int lvl = Integer.valueOf(level).intValue();			 
			
			System.out.println("updateTreeNode Proc TAG : " + tag + " level : " + level);
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			String tId = "";
			dbobject   = new DBObject(conn.getConnection());
			String tbl = "TBLHIERARCHY";

			if ("new".equals(tag)){
				
				String pid     = request.getParameter("pid"   );
				String cid     = request.getParameter("cid"   );
				String weight  = request.getParameter("weight");
				String rank    = request.getParameter("rank"  );
				
				lvl++;
				if (lvl==0) pid ="0";
				if (lvl >2) tbl ="TBLTREESCORE";
				
				tId = String.valueOf(dbobject.getNextId(tbl));		// Next ID
				String strI = "INSERT INTO "+tbl+" (ID,PARENTID,CONTENTID,TREELEVEL,RANK,INPUTDATE,YEAR,WEIGHT) VALUES (?,?,?,?,?,?,?,?)";
				Object[] paramI = {tId,pid,cid,String.valueOf(lvl),rank, Util.getToDayTime().substring(0,14),year,weight};
				dbobject.executePreparedUpdate(strI,paramI);
				
			} else if ("mod".equals(tag)){
				String id      = request.getParameter("id");
				String weight  = request.getParameter("weight");
				String rank    = request.getParameter("rank"  );
				tId            = id;
				
				if (lvl>2) tbl="TBLTREESCORE";
				String strU = "UPDATE "+tbl+" SET WEIGHT=?,RANK=? WHERE ID=? AND TREELEVEL=? AND YEAR=?";
				Object[] paramU = {weight,rank,id,level,year};				
				dbobject.executePreparedUpdate(strU,paramU);		
				
				if (lvl==5) {
					String strUD = "UPDATE tblmeasuredefine SET WEIGHT=? WHERE year=? and ID=(SELECT contentid FROM tbltreescore WHERE ID=? AND TREELEVEL=? AND YEAR=?)";
					Object[] paramUD = {weight,year,id,level,year};				
					dbobject.executePreparedUpdate(strUD,paramUD);		
					
					System.out.println("updateTreeNode Proc MeasureDefine");
				}
				
				System.out.println("updateTreeNode Proc strU : " + strU + "ID : " + id +" weight : " + weight);
				
			} else if ("del".equals(tag)){
				String id = request.getParameter("id");
				
				if (lvl>2) tbl ="TBLTREESCORE";
				
				String strD = "DELETE FROM "+tbl+" WHERE ID=? AND TREELEVEL=? AND YEAR=?";
				Object[] paramD = {id,level,year};				
				dbobject.executePreparedUpdate(strD,paramD);				
				request.setAttribute("result", "true");	
				
				
				
				
				
				
			// 컨텐츠 ID변경	
			} else if ("rep".equals(tag)){
				String id      = request.getParameter("id");
				String cid     = request.getParameter("cid"   );
				tId            = id;
				
				if (lvl>2) tbl="TBLTREESCORE";
				String strU = "UPDATE "+tbl+" SET contentid = ? WHERE ID=? AND TREELEVEL=? AND YEAR=?";
				Object[] paramU = {cid,id,level,year};				
				System.out.println("updateTreeNode Proc strU : " + strU + ", ID : " + id +" contentid : " + cid);
				
				dbobject.executePreparedUpdate(strU,paramU);		
			}	
			
			// 등록 수정인 경우에...	
			if ("new".equals(tag)||"mod".equals(tag)||"rep".equals(tag)){
					String      tblCom = "TBLCOMPANY";
					if      (lvl==1) tblCom ="TBLSBU";
					else if (lvl==2) tblCom="TBLBSC";
					else if (lvl==3) tblCom="TBLPST";
					else if (lvl==4) tblCom="TBLOBJECTIVE";
					
					StringBuffer sb = new StringBuffer();
					
					if (lvl<5){
						sb.append("SELECT T.ID,T.PARENTID,T.CONTENTID,T.TREELEVEL,T.RANK,T.YEAR,T.WEIGHT,C.NAME FROM "+tbl+" T,"+tblCom+" C WHERE T.CONTENTID=C.ID AND T.ID=? AND T.YEAR=?");
					}else{
						sb.append(" SELECT T.ID,T.PARENTID,T.CONTENTID,T.TREELEVEL,T.RANK,T.YEAR,T.WEIGHT,C.NAME ");
						sb.append(" FROM   TBLTREESCORE T,TBLMEASURE C, TBLMEASUREDEFINE D                       ");
						sb.append(" WHERE  T.CONTENTID= D.ID                                                     ");
						sb.append(" AND    D.MEASUREID= C.ID                                                     ");
						sb.append(" AND    T.ID= ? AND T.YEAR=?                                                  ");
					}
					Object[] params = {tId,year};
					
					System.out.println("SELECT Proc strU : " + sb.toString() + ", ID : " + tId);
					
					rs = dbobject.executePreparedQuery(sb.toString(),params);
					
					DataSet ds = new DataSet();
					ds.load(rs);
					
					request.setAttribute("ds", ds);	
			}
			
			conn.commit();
			
		} catch (Exception e) {
			System.out.println("updateTreeNode : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	
	/**
	 * Method : getMeasure : 지표정의서 상세정보 구하기
	 * Desc   :지표정의서 상세정보 구하기 기본 SQL.
	 * 
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화) 
	 * 
	 * @param request
	 * @param respons
	 */	
	public void getMeasure(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
		try {  
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			
			String mid  = request.getParameter("mid");
			String year = request.getParameter("year");
			
			//System.out.println(mid);
			
			// 지표정의서 정보
			StringBuffer sb = new StringBuffer();
			sb.append(" select  *                                                                                                                  ");
			sb.append(" from                                                                                                                       ");
			sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname    ");
			sb.append("         from   tbltreescore t,tblpst c                                                                                     ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                                           ");
			sb.append("        ) pst  ,                                                                                                            ");
			sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname    ");
			sb.append("         from   tbltreescore t,tblobjective c                                                                               ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                                           ");
			sb.append("        ) obj ,                                                                                                             ");
			sb.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname, ");
			sb.append("                d.id,d.measureid,d.detaildefine,d.weight,d.unit,d.planned,d.frequency,                                      ");
			sb.append("                d.equation,d.equationdefine,d.updateid,u.username updatenm,d.mean,d.etlkey,d.measurement,                   ");
			sb.append("                d.year,d.trend,d.base,d.limit, d.y,d.ya1,d.ya2,d.ya3,d.ya4,d.yb1,d.yb2,d.yb3,                               ");
			sb.append("                d.plannedbaseplus, d.baseplus, d.baselimitplus, d.limitplus,                                                ");
			sb.append("                d.equationtype, d.datasource, d.plannedbase, d.baselimit,d.ifsystem,                                        ");
			sb.append("                d.mngdeptnm, d.targetrationle, d.planned_flag,d.scorecode                                                   ");
			sb.append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d, tbluser u, tblscorelevel l                           ");
			sb.append("         where  t.contentid=d.id  and t.treelevel=5 and t.year =?      and d.measureid=c.id                                 ");
			sb.append("         and    d.updateid = u.userid(+)                                                                                    ");
			sb.append("         and    d.id       = ?                                                                                              ");
			sb.append("        ) mea                                                                                                               ");
			sb.append(" where  pid = opid                                                                                                          ");
			sb.append(" and    oid = mpid                                                                                                          ");
			sb.append(" order by prank, pid, orank, oid, mrank, mid                                                                                ");

			Object[] paramS = {year,year,year,mid};
			
			rs = dbobject.executePreparedQuery(sb.toString(),paramS);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
			// 지표항목정보
			String strItem ="SELECT * FROM TBLITEM WHERE MEASUREID=? ORDER BY CODE";
			Object[] param = {mid};
			
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strItem,param);
			
			DataSet dsItem = new DataSet();
			dsItem.load(rs);
			
			request.setAttribute("dsItem",dsItem);
			
			// 담당자 정보
			String strUpdater = "SELECT R.USERID,(SELECT USERNAME FROM TBLUSER U WHERE U.USERID=R.USERID) USERNAME FROM TBLAUTHORITY R WHERE MEASUREID=?";
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strUpdater,param);
			
			DataSet dsUpdater = new DataSet();
			dsUpdater.load(rs);
			
			request.setAttribute("dsUpdater",dsUpdater);
			
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	/**
	 * Method : insertMeasure : 지표정의서 등록
	 * 
	 * Desc   :지표정의서 등록.
	 * 
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화) 
	 * 
	 * @param request
	 * @param respons
	 */			
	public void insertMeasure(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			String year    = request.getParameter("year");
			String updater = (String)request.getSession().getAttribute("userId");
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			
			String tid   ="";
			String mcid  = request.getParameter("mcid" );
			String objid = request.getParameter("objid");

			// MeasureDefine ... : 가중치 5, 목표값 100로 설정, 
			StringBuffer sbI = new StringBuffer();
			sbI.append("INSERT INTO TBLMEASUREDEFINE (ID,MEASUREID,UPDATEID,  WEIGHT,PLANNED, PLANNEDBASEPLUS, PLANNEDBASE, BASEPLUS, BASE, BASELIMITPLUS, BASELIMIT, LIMITPLUS, LIMIT,FREQUENCY,MEASUREMENT,TREND,YEAR )");
			sbI.append(" VALUES (?,?,?,5, 100,95,90,85,80,75,70,65,65, '월','계량','상향' ,?)");
			
			String mid = String.valueOf(dbobject.getNextId("TBLMEASUREDEFINE"));
			Object[] paramI = {mid,mcid,updater,year};			
			dbobject.executePreparedQuery(sbI.toString(),paramI);
			
			// 
			String strI = "INSERT INTO TBLTREESCORE (ID,PARENTID,CONTENTID,TREELEVEL,RANK,INPUTDATE,YEAR,WEIGHT) VALUES (?,?,?,?,0,?,?,5)";
			
			tid=String.valueOf(dbobject.getNextId("TBLTREESCORE"));
			Object[] paramIC = {tid,objid,mid,"5",Util.getToDayTime().substring(0,14),year};
			dbobject.executePreparedQuery(strI.toString(),paramIC);
			
			String strUD = "DELETE FROM TBLAUTHORITY WHERE YEAR=? AND MEASUREID=? ";
			Object[] pmUD = {year,mid};
			dbobject.executePreparedUpdate(strUD,pmUD);		
			
			setMeasDetailValue(dbobject, year, mid);
			System.out.println("지표목표 자동생성");				
			
			conn.commit();

			StringBuffer strS = new StringBuffer();
			
			strS.append(" SELECT T.ID,T.PARENTID,T.CONTENTID,T.TREELEVEL,T.RANK,T.YEAR,T.WEIGHT,C.NAME ");
			strS.append(" FROM   TBLTREESCORE T,TBLMEASURE C,TBLMEASUREDEFINE D                        ");
			strS.append(" WHERE  T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.ID=? AND T.YEAR=?         ");
			Object[] paramS = {tid,year};
			rs = dbobject.executePreparedQuery(strS.toString(),paramS);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	

	/**
	 * Method : replaceMeasure : 지표정의서 지표코드 변경
	 * 
	 * Desc   :지표정의서 지표코드 등록.
	 * 
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화) 
	 * 
	 * @param request
	 * @param respons
	 */			
	public void replaceMeasure(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			String tag      = request.getParameter("tag" );			
			String year     = request.getParameter("year");
			String level    = request.getParameter("level");
			String id       = request.getParameter("id");				// tbltreescore 의 id.
			String cid      = request.getParameter("cid"   );			// tblmeasuredefine 의 Measureid			
			
			System.out.println("updateTreeNode Proc TAG : " + tag + " level : " + level);
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			
			// MeasureDefine ...  
			StringBuffer sbU = new StringBuffer();
			sbU.append(" update tblmeasuredefine set  measureid = ? ");
			sbU.append(" where year = ? and id = (select contentid from tbltreescore where year = ? and id = ? and treelevel=?)");
			
			Object[] pmU = {cid, year, year, id, level};
			dbobject.executePreparedUpdate(sbU.toString(),pmU);			

			conn.commit();

			StringBuffer strS = new StringBuffer();
			
			strS.append(" SELECT T.ID,T.PARENTID,T.CONTENTID,T.TREELEVEL,T.RANK,T.YEAR,T.WEIGHT,C.NAME ");
			strS.append(" FROM   TBLTREESCORE T,TBLMEASURE C,TBLMEASUREDEFINE D                        ");
			strS.append(" WHERE  T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.ID=? AND T.YEAR=?         ");
			Object[] paramS = {id,year};
			rs = dbobject.executePreparedQuery(strS.toString(),paramS);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	
	
	/**
	 * Method : updateMeasure : 지표정의서 수정
	 * 
	 * Desc   :지표정의서 지표코드 수정.
	 * 
	 * Rev.   : 1.2008.05.25 by PHG.  Init Version(모듈화) 
	 * 
	 * @param request
	 * @param respons
	 */			
	
	public void updateMeasure(HttpServletRequest request, HttpServletResponse reponse){
		CoolConnection conn = null;
		DBObject dbobject   = null;
		ResultSet rs        = null;   
		
		try {      

/*	Real SERVER */ 		
			String year      = request.getParameter("year");                                                                      
			String mode      = request.getParameter("tag" );                                                                      
			String level     = request.getParameter("level");                                                                     
			String mean      = request.getParameter("mean");                                                                      
			                                                                                                                      
			String detail    = request.getParameter("detail").trim();                                                             
			String etlkey    = request.getParameter("etlkey");                                                                    
			String equDefine = request.getParameter("equDefine").trim();                                                          
			String weight    = request.getParameter("weight");                                                                    
			String unit      = request.getParameter("unit").trim();                                                               
			String trend     = request.getParameter("trend");                                                                     
			String frequecny = request.getParameter("frequency");                                                                 
			String type      = request.getParameter("type");                                                                      
			String planned   = request.getParameter("planned");                                                                   
			String base      = request.getParameter("base");                                                                      
			String limit     = request.getParameter("limit");                                                                     
			String equation  = request.getParameter("equation").trim();                                                           
			String ya1       = request.getParameter("ya1");                                                                       
			String ya2       = request.getParameter("ya2");                                                                       
			String ya3       = request.getParameter("ya3");                                                                       
			String ya4       = request.getParameter("ya4");                                                                       
			String y         = request.getParameter("y");                                                                         
			String yb1       = request.getParameter("yb1");                                                                       
			String yb2       = request.getParameter("yb2");                                                                       
			String yb3       = request.getParameter("yb3");                                                                       
			String updateId  = request.getParameter("updateId");                                                                  
			                                                                                                                      
			String item      = request.getParameter("item");                                                                      
			String updater   = request.getParameter("updater");                                                                   
			                                                                                                                      
			String datasource     = request.getParameter("datasource")==null?"":request.getParameter("datasource").trim();			  
			String plannedbase    = request.getParameter("plannedbase")==null?"":request.getParameter("plannedbase");             
			String baselimit      = request.getParameter("baselimit")  ==null?"":request.getParameter("baselimit");		            
			String equType        = request.getParameter("equType")    ==null?"":request.getParameter("equType");                 
			String ifsystem       = request.getParameter("ifsystem")   ==null?"":request.getParameter("ifsystem").trim();         
			String mngdeptnm      = request.getParameter("mngdeptnm")  ==null?"":request.getParameter("mngdeptnm").trim();        
			String targetrationle = request.getParameter("targetrationle")==null?"":request.getParameter("targetrationle").trim();
			String plannedflag    = request.getParameter("plannedflag")==null?"":request.getParameter("plannedflag");             

			
			String plannedbaseplus    = request.getParameter("plannedbaseplus")  ==null?"":request.getParameter("plannedbaseplus");
			String baseplus           = request.getParameter("baseplus")  ==null?"":request.getParameter("baseplus");
			String baselimitplus      = request.getParameter("baselimitplus")  ==null?"":request.getParameter("baselimitplus");
			String limitplus          = request.getParameter("limitplus")  ==null?"":request.getParameter("limitplus");
			
			String scoreCode = request.getParameter("scoreCode")!=null?request.getParameter("scoreCode"):"";
	/*		
			// My PC
			String year      = request.getParameter("year");
			String mode      = request.getParameter("tag" );
			String level     = request.getParameter("level");
			String mean      = Util.getUTF(request.getParameter("mean"));
			
			String detail    = Util.getUTF(request.getParameter("detail")).trim();
			String etlkey    = request.getParameter("etlkey");
			String equDefine = Util.getUTF(request.getParameter("equDefine")).trim();
			String weight    = request.getParameter("weight");
			String unit      = Util.getUTF(request.getParameter("unit")).trim();
			String trend     = Util.getUTF(request.getParameter("trend"));
			String frequecny = Util.getUTF(request.getParameter("frequency"));
			String type      = Util.getUTF(request.getParameter("type"));
			String planned   = request.getParameter("planned");
			String base      = request.getParameter("base");
			String limit     = request.getParameter("limit");
			String equation  = request.getParameter("equation").trim();
			String ya1       = request.getParameter("ya1");
			String ya2       = request.getParameter("ya2");
			String ya3       = request.getParameter("ya3");
			String ya4       = request.getParameter("ya4");
			String y         = request.getParameter("y");
			String yb1       = request.getParameter("yb1");
			String yb2       = request.getParameter("yb2");
			String yb3       = request.getParameter("yb3");
			String updateId  = Util.getUTF(request.getParameter("updateId"));
			 
			String item      = Util.getUTF(request.getParameter("item"));
			String updater   = Util.getUTF(request.getParameter("updater"));
			
			String datasource     = request.getParameter("datasource")==null?"":Util.getUTF(request.getParameter("datasource")).trim();			
			String plannedbase    = request.getParameter("plannedbase")==null?"":request.getParameter("plannedbase");
			String baselimit      = request.getParameter("baselimit")  ==null?"":request.getParameter("baselimit");		
			String equType        = request.getParameter("equType")    ==null?"":Util.getUTF(request.getParameter("equType"));
			String ifsystem       = request.getParameter("ifsystem")   ==null?"":Util.getUTF(request.getParameter("ifsystem")).trim();
			String mngdeptnm      = request.getParameter("mngdeptnm")  ==null?"":Util.getUTF(request.getParameter("mngdeptnm")).trim();
			String targetrationle = request.getParameter("targetrationle")==null?"":Util.getUTF(request.getParameter("targetrationle")).trim();
			String plannedflag    = request.getParameter("plannedflag")==null?"":request.getParameter("plannedflag");
			
			String scoreCode = request.getParameter("scoreCode")!=null?request.getParameter("scoreCode"):"";
			
 /**/
			
			
			
			
			
			
			
			
			Hashtable ht = new Hashtable();
			String userInfo = (String)request.getSession().getAttribute("userId")+"_"+request.getSession().getAttribute("userName");
			
			// 산식 체크 if 			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			String tid="";
			
			if ("mod".equals(mode)) {
				tid              = request.getParameter("tid");
				String mid       = request.getParameter("mid");
				String objId     = request.getParameter("objId");
			
				System.out.println("updateMeasure : " + mode + "/" + mid + "/" + updater);		
				
				StringBuffer sbU = new StringBuffer();
				sbU.append(" UPDATE TBLMEASUREDEFINE SET MEAN=?,DETAILDEFINE=?,ETLKEY=?,UPDATEID=?,WEIGHT=?,PLANNED=?,BASE=?,LIMIT=?,");
				sbU.append("        FREQUENCY=?,MEASUREMENT=?,EQUATION=?,EQUATIONDEFINE=?,DATASOURCE=?,UNIT=?,TREND=?,YA1=?,YA2=?,YA3=?,YA4=?,Y=?,YB1=?,YB2=?,YB3=?, ");
				sbU.append("        PLANNEDBASE=?, BASELIMIT=?, IFSYSTEM=?,MNGDEPTNM=?,TARGETRATIONLE=?, PLANNED_FLAG=?,SCORECODE=?,PLANNEDBASEPLUS=?,BASEPLUS=?,BASELIMITPLUS=?,LIMITPLUS=? ");				
				sbU.append(" WHERE ID=? ");
						
				Object[] paramU = {mean,detail,etlkey,updateId,weight,planned,base,limit,
						           frequecny,type,equation,equDefine,datasource,unit,trend,ya1,ya2,ya3,ya4,y,yb1,yb2,yb3,
						           plannedbase,baselimit,ifsystem,mngdeptnm,targetrationle, plannedflag,scoreCode,
						           plannedbaseplus, baseplus, baselimitplus, limitplus,
						           mid};
				
				dbobject.executePreparedUpdate(sbU.toString(),paramU);				
				System.out.println("지표정의서 저장");
				
				setMeasDetailValue(dbobject, year, mid);
				System.out.println("지표목표 자동생성");				
				
				//-------------------------------------------------------------------------------------------
				// 지표항목 저장
				//-------------------------------------------------------------------------------------------				
				// store items
				if (!"".equals(item.trim())){
					String[] items = item.split("`");
					String strItem = "INSERT INTO TBLITEM (CODE,MEASUREID,ITEMNAME,ITEMENTRY,ITEMTYPE, ITEMFIXED) VALUES (?,?,?,?,?,?)";
					Object[] parItem = new Object[6];
					String strItemU ="UPDATE TBLITEM SET ITEMNAME=?,ITEMENTRY=?,ITEMTYPE=?,ITEMFIXED=? WHERE CODE=? AND MEASUREID=?";
					Object[] parItemU = new Object[6];
					
					ArrayList a = new ArrayList();
					for (int i = 0; i < items.length; i++) {
						String[] iPart = items[i].split(",");
						parItemU[0] = iPart[1];		// Name 
						parItemU[1] = iPart[2];		// Type.
						parItemU[2] = iPart[3];		// Entry.
						parItemU[3] = iPart[4];		// Fixed.
						
						parItemU[4] = iPart[0];		// Code.
						parItemU[5] = mid;
						
						if (dbobject.executePreparedUpdate(strItemU,parItemU)<1){
							parItem[0] = iPart[0];
							parItem[1] = mid;
							parItem[2] = iPart[1];
							parItem[3] = iPart[2];
							parItem[4] = iPart[3];
							parItem[5] = iPart[4];
							
							dbobject.executePreparedUpdate(strItem,parItem);
						}
						
						a.add(iPart[0]);						
					}
					String aId = "";
					for (int j = 0; j < a.size(); j++) {
						if (j==0) aId = "'"+(String)a.get(j)+"'";
						else aId += ",'"+(String)a.get(j)+"'";
					}
					
					String strD = "DELETE FROM TBLITEM WHERE MEASUREID=? AND CODE NOT IN ("+aId+")";
					if (a.size()==0) strD = "DELETE FROM TBLITEM WHERE MEASUREID=?";
					dbobject.executePreparedUpdate(strD,new Object[]{mid});
				} else {
					String strD = "DELETE FROM TBLITEM WHERE MEASUREID=?";
					dbobject.executePreparedUpdate(strD,new Object[]{mid});
				}
				System.out.println("지표항목 저장");
				
				//-------------------------------------------------------------------------------------------
				// 지표담당자(부) 저장
				//-------------------------------------------------------------------------------------------				
				String strUD = "DELETE FROM TBLAUTHORITY WHERE YEAR=? AND MEASUREID=? ";
				Object[] pmUD = {year,mid};				
				dbobject.executePreparedUpdate(strUD,pmUD);
				
				String strUI = "INSERT INTO TBLAUTHORITY (YEAR,MEASUREID,USERID) VALUES (?,?,?)";
				Object[] pmUI = {year,mid,null};
				if (!"".equals(updater.trim())){
					String[] updaters = updater.split("`");
					
					for (int m = 0; m < updaters.length; m++) {
						String[] tmpUserId = updaters[m].split(",");
						pmUI[2]=tmpUserId[0];
						
						dbobject.executePreparedUpdate(strUI,pmUI);
					}
				}				

				// add tbltreescore				
				String strU = "UPDATE TBLTREESCORE SET INPUTDATE=?,WEIGHT=? WHERE ID=? AND YEAR=?";				
				Object[] paramUC = {Util.getToDayTime().substring(0,14),weight,tid,year};
				dbobject.executePreparedUpdate(strU.toString(),paramUC);
				
				conn.commit();
			}
			
			StringBuffer strS = new StringBuffer();			
			strS.append(" SELECT T.ID,T.PARENTID,T.CONTENTID,T.TREELEVEL,T.RANK,T.YEAR,T.WEIGHT,C.NAME ");
			strS.append(" FROM TBLTREESCORE T,TBLMEASURE C,TBLMEASUREDEFINE D ");
			strS.append(" WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.ID=? AND T.YEAR=? ");
			Object[] paramS = {tid,year};
			
			rs = dbobject.executePreparedQuery(strS.toString(),paramS);			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
			request.setAttribute("equ","true");
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	/**
	 * Method : updateMeasure : 지표정의서 삭제 
	 * 
	 * Rev.   :  
	 * 
	 * @param request
	 * @param respons
	 */			
	public void deleteMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
		try {   
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			Hashtable ht = new Hashtable();
			String userInfo = (String)request.getSession().getAttribute("userId")+"_"+request.getSession().getAttribute("userName");

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			
			String year = request.getParameter("year");
			String mode = request.getParameter("tag");
			
			if ("del".equals(mode)){
				String tid = request.getParameter("tid");
				String mid = request.getParameter("mid");
				
				System.out.println("deleteMeasure : " + userInfo + "/" + mid);
				
				// 0. tblmeasuredetail : 주기별 실적 테이블 
				String strD = "delete from tblmeasuredetail where strdate like ?||'%' and measureid=?";
				dbobject.executePreparedUpdate(strD,new Object[]{year,mid});

				strD = "delete from tblmeasurescore where strdate like ?||'%'  and measureid=?";
				dbobject.executePreparedUpdate(strD,new Object[]{year, mid});
				
				// 2. tblauthority : 권한 테이블 
				strD = "delete from tblauthority where year = ? and measureid=?";
				dbobject.executePreparedUpdate(strD,new Object[]{year, mid});	

				// 1. tblitem : 항목 테이블
				strD = "delete from tblitemactual where  strdate like ?||'%'  and measureid=?";
				dbobject.executePreparedUpdate(strD,new Object[]{year, mid});				

				String strI = "DELETE FROM TBLITEM WHERE MEASUREID=?";
				Object[] par = {mid};
				dbobject.executePreparedUpdate(strI,par);
				
				String strM = "DELETE FROM TBLMEASUREDEFINE WHERE ID=?";
				dbobject.executePreparedUpdate(strM,par);
				
				String strT = "DELETE FROM TBLTREESCORE WHERE ID=? AND TREELEVEL=5 AND YEAR=?";
				Object[] parT = {tid,year};
				
				dbobject.executePreparedUpdate(strT,parT);
				conn.commit();
			}
			
			request.setAttribute("result", "true");
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	//--------------------------------------------------------------------------------------------------------------

	//-------------------------------------------------------------------------------------------------------
	// 지표복사를 위해서 사용함.
	//-------------------------------------------------------------------------------------------------------
	public void getOrgYear(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT  cid, cpid, ccid, clevel, crank, cname,  cweight,                                                                ");
			sb.append("         sid, spid, scid, slevel, srank, sname,  sweight,                                                                ");
			sb.append("         bid, bpid, bcid, blevel, brank, bname,  bweight                                                                 ");
			sb.append(" FROM                                                                                                                    ");
			sb.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ");
			sb.append("         from   tblhierarchy t,tblcompany c                                                                              ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year = ?                                                       ");
			sb.append("        ) com,                                                                                                           ");
			sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ");
			sb.append("         from   tblhierarchy t,tblsbu c                                                                                  ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year = ?                                                       ");
			sb.append("        ) sbu,                                                                                                           ");
			sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname ");
			sb.append("         from   tblhierarchy t,tblbsc c                                                                                  ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=2 and t.year = ?                                                       ");
			sb.append("        ) bsc                                                                                                            ");
			sb.append(" where  cid = spid (+)                                                                                                   ");
			sb.append(" and    sid = bpid (+)                                                                                                   ");
			sb.append(" order by crank, srank, brank                                                                                            ");

			Object[] params = {year,year,year};
			
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
	
	public void getMeasCopy(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year      = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			String ocid      = request.getParameter("ocid")!=null?request.getParameter("ocid"):"%";
			String mcid      = request.getParameter("mcid")!=null?request.getParameter("mcid"):"%";
			String measureid = request.getParameter("measureid")!=null?request.getParameter("measureid"):"%";			

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM  ")
	         .append(" (SELECT T.ID CID,T.PARENTID CPID,T.CONTENTID CCID,T.TREELEVEL CLEVEL,T.RANK CRANK,T.WEIGHT CWEIGHT,C.NAME CNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLCOMPANY C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=0 AND T.YEAR=? ) COM ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? ) SBU ")
	         .append(" ON COM.CID=SBU.SPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
	         .append(" ON SBU.SID=BSC.BPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
	         .append(" ON BSC.BID=PST.PPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? AND T.CONTENTID LIKE ?) OBJ ")
	         .append(" ON PST.PID=OBJ.OPID ")
	         .append("  JOIN ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.MEASUREID, D.ETLKEY ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND T.CONTENTID LIKE ? AND D.MEASUREID LIKE ?) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" ORDER BY CRANK,SRANK,SID,BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");
			
	         Object[] params = {year,year,year,year,year,ocid,year, mcid, measureid};
			
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
	
	public void getScoreLevel (HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM TBLSCORELEVEL ");
			
	        //Object[] params = {};
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			rs = dbobject.executeQuery(sb.toString());//(sb.toString(),params);
			
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
	//-----------------------------------------------------------------------------------------------------
	// 	지표복사
	//-----------------------------------------------------------------------------------------------------
	*/
	public void setMeasCopy(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
	    
		try {   
			
			String year = request.getParameter("year");
			String mode = request.getParameter("mode");
			
			// 지표정의서와 지표코드
			String mcid= request.getParameter("mcid");
			
			// 지표정의서 단일항목
			String mean       = request.getParameter("mean").trim()==null?"":request.getParameter("mean").trim();
			String detail     = request.getParameter("detail").trim()==null?"":request.getParameter("detail").trim();
			String datasource = request.getParameter("datasource")==null?"":request.getParameter("datasource").trim();		
			String weight     = request.getParameter("weight")==null?"":request.getParameter("weight");
			String unit       = request.getParameter("unit").trim()==null?"":request.getParameter("unit").trim();
			String trend      = request.getParameter("trend")==null?"":request.getParameter("trend");
			String frequecny  = request.getParameter("frequency")==null?"":request.getParameter("frequency");
			String mtype      = request.getParameter("mtype")==null?"":request.getParameter("mtype");
			String updateId   = request.getParameter("updateId")==null?"":request.getParameter("updateId");

			// kopec
			String ifsystem = request.getParameter("ifsystem")==null?"":request.getParameter("ifsystem").trim();
			String mngdeptnm = request.getParameter("mngdeptnm")==null?"":request.getParameter("mngdeptnm").trim();
			String targetrationle = request.getParameter("targetrationle")==null?"":request.getParameter("targetrationle").trim();			
			
			//	 Equation...
			String equation   = request.getParameter("equation").trim()==null?"":request.getParameter("equation").trim();
			
			// 목표값 : Grade
			String grade      = request.getParameter("grade")==null?"":request.getParameter("grade");
			
			// 항목
			String item       = request.getParameter("item")==null?"":request.getParameter("item");

			// 대상부서 (부서명, mcid)
			String orgdefineid = request.getParameter("orgdefineid")==null?"":request.getParameter("orgdefineid");
			
			
			// 점수구간
			String scorecode = request.getParameter("scorecode")==null?"":request.getParameter("scorecode");
			
			
			
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
		
			
			if ("U".equals(mode)) {

					//-----------------------------------------------------------------------------------------------
					// 지표정의서 복사원본을 구함
					//-----------------------------------------------------------------------------------------------
					StringBuffer sbI = new StringBuffer();
					  sbI.append(" select 	  id,measureid, detaildefine, weight, unit,          ") 
					 	 .append("            entrytype, measuretype, frequency,                 ")
						 .append("  		  equation, equationdefine, etlkey,                  ")
						 .append("            measurement, year, trend,                          ")
						 .append("            planned, base,limit,                               ")
						 .append("            plannedbaseplus, baseplus, baselimitplus, limitplus,                              ")
						 .append("            y, ya1, ya2, ya3, ya4, yb1, yb2, yb3,              ") 
						 .append("            mean, updateid, equationtype, datasource,	         ")
						 .append("            plannedbase,baselimit,scorecode,                             ")						 
						 .append("            ifsystem, mngdeptnm, targetrationle, planned_flag  ")									 
					     .append("   from  tblmeasuredefine                                      ")
					     .append(" where year =?                                                 ")
						 .append("   and id   =?                                                 ");
					Object[] paramS = {year,mcid};
					
					System.out.println("원본 : " + mcid);
					
					rs = dbobject.executePreparedQuery(sbI.toString(),paramS);
					
					// 지표정의서 복사원본 
					DataSet dsFrom = new DataSet();
					dsFrom.load(rs);								
					dsFrom.next();
					
					//-----------------------------------------------------------------------------------------------
					// 복사 Check Flag에 따라 Update SQL 문을 만듬.
					//-----------------------------------------------------------------------------------------------
					//System.out.println("Detail : " + dsFrom.getString("detaildefine") );					
					
					StringBuffer sbu = new StringBuffer();
					
					sbu.append(" Update tblmeasuredefine set year = year ");
					
					if ("1".equals(mean))      { sbu.append(", mean         = '" + (dsFrom.getString("mean")==null?"":dsFrom.getString("mean")) + "'" ); }
					//if ("1".equals(detail))        { sbu.append(", detaildefine = '" + (dsFrom.getString("detaildefine")==null?"":dsFrom.getString("detaildefine")) + "'" ); }			
					if ("1".equals(datasource)){ sbu.append(", datasource   = '" + (dsFrom.getString("datasource")==null?"":dsFrom.getString("datasource")) + "'" ); }
					if ("1".equals(unit))      { sbu.append(", unit         = '" + (dsFrom.getString("unit")==null?"":dsFrom.getString("unit")) + "'" ); }
					if ("1".equals(trend))     { sbu.append(", trend        = '" + (dsFrom.getString("trend")==null?"":dsFrom.getString("trend")) + "'" ); }					
					if ("1".equals(frequecny)) { sbu.append(", frequency    = '" + (dsFrom.getString("frequency")==null?"":dsFrom.getString("frequency")) + "'" ); }
					if ("1".equals(mtype))     { sbu.append(", measuretype  = '" + (dsFrom.getString("measuretype")==null?"":dsFrom.getString("measuretype")) + "'" ); }
					if ("1".equals(mtype))     { sbu.append(", entrytype    = '" + (dsFrom.getString("entrytype")==null?"":dsFrom.getString("entrytype")) + "'" ); }							
					if ("1".equals(mtype))     { sbu.append(", measurement  = '" + (dsFrom.getString("measurement")==null?"":dsFrom.getString("measurement")) + "'" ); }
					
					if ("1".equals(ifsystem))      { sbu.append(", ifsystem = '" + ( dsFrom.getString("ifsystem")==null?"":dsFrom.getString("ifsystem")) + "'" ); }
					if ("1".equals(mngdeptnm))     { sbu.append(", mngdeptnm = '" + (dsFrom.getString("mngdeptnm")==null?"":dsFrom.getString("mngdeptnm")) + "'" ); }							
					if ("1".equals(targetrationle)){ sbu.append(",  targetrationle = '" + (dsFrom.getString("targetrationle")==null?"":dsFrom.getString("targetrationle")) + "'" ); }

					if ("1".equals(equation)){ sbu.append(", equation = '" + (dsFrom.getString("equation")==null?"":dsFrom.getString("equation")) + "'" ); }
					if ("1".equals(equation)){ sbu.append(", equationdefine = '" + (dsFrom.getString("equationdefine")==null?"":dsFrom.getString("equationdefine")) + "'" ); }					
					
					if ("1".equals(updateId)){ sbu.append(", updateid = " + (dsFrom.getString("updateid")==null?"null":dsFrom.getString("updateid")) ); }		
					if ("1".equals(weight))  { sbu.append(", weight = " + (dsFrom.getString("weight")==null?"null":dsFrom.getString("weight")) ); }							

					if ("1".equals(grade))   { sbu.append(", planned = "         + (dsFrom.getString("planned")==null||dsFrom.isEmpty("planned")?"null":dsFrom.getString("planned")) ); }		
					if ("1".equals(grade))   { sbu.append(", plannedbaseplus = " + (dsFrom.getString("plannedbaseplus")==null||dsFrom.isEmpty("plannedbaseplus")?"null":dsFrom.getString("plannedbaseplus")) ); }
					if ("1".equals(grade))   { sbu.append(", plannedbase = "     + (dsFrom.getString("plannedbase")==null||dsFrom.isEmpty("plannedbase")?"null":dsFrom.getString("plannedbase")) ); }
					if ("1".equals(grade))   { sbu.append(", baseplus = "        + (dsFrom.getString("baseplus")==null||dsFrom.isEmpty("baseplus")?"null":dsFrom.getString("baseplus")) ); }							
					if ("1".equals(grade))   { sbu.append(", base = "            + (dsFrom.getString("base")==null||dsFrom.isEmpty("base")?"null":dsFrom.getString("base")) ); }							
					if ("1".equals(grade))   { sbu.append(", baselimitplus = "   + (dsFrom.getString("baselimitplus")==null||dsFrom.isEmpty("baselimitplus")?"null":dsFrom.getString("baselimitplus")) ); }		
					if ("1".equals(grade))   { sbu.append(", baselimit = "       + (dsFrom.getString("baselimit")==null||dsFrom.isEmpty("baselimit")?"null":dsFrom.getString("baselimit")) ); }		
					if ("1".equals(grade))   { sbu.append(", limitplus = "       + (dsFrom.getString("limitplus")==null||dsFrom.isEmpty("limitplus")?"null":dsFrom.getString("limitplus")) ); }					
					if ("1".equals(grade))   { sbu.append(", limit = "           + (dsFrom.getString("limit")==null||dsFrom.isEmpty("limit")?"null":dsFrom.getString("limit")) ); }					
					
					
					if ("1".equals(grade))   { sbu.append(", planned_flag = '" + (dsFrom.getString("planned_flag")==null||dsFrom.isEmpty("planned_flag")?"U":dsFrom.getString("planned_flag")) + "'" ); }
					
					
					// 점수구간 복사 추가.
					if ("1".equals(scorecode))   { sbu.append(", scoreCode = " + (dsFrom.getString("scorecode")==null||dsFrom.isEmpty("scorecode")?"1":dsFrom.getString("scorecode")) + " " ); }

					
					sbu.append(" where year =  " + year  );
					sbu.append(" and    id = ? ");
					
					//System.out.println("Update SQL : \n"  + sbu.toString());					
					
					
					// TreeScore 의 WEIGHT도 Update...
					StringBuffer sbtu = new StringBuffer();			
					
					if ("1".equals(weight)){						
							sbtu.append(" update tbltreescore  set weight = " + (dsFrom.getString("weight")==null?"null":dsFrom.getString("weight")) );
							sbtu.append(" where year = " + year   );
							sbtu.append(" and    contentid = ? "   );						
					}	
					
					StringBuffer sbdu = new StringBuffer();			
					
					if ("1".equals(detail)){						
							sbdu.append(" update tblmeasuredefine  set detaildefine = (select detaildefine from tblmeasuredefine where id = ? )"  );
							sbdu.append(" where year = " + year   );
							sbdu.append(" and   id   = ? "   );						
					}	
					
					//System.out.println("Update SQL2 : \n");
					
					//--------------------------------------------------------------------------------------------	
					//  부서별 Update.... 젠장 부서명에 ',' 이 들어가네...
					//--------------------------------------------------------------------------------------------
					if (!"".equals(orgdefineid.trim())){
						
						String    orgMcid ;
						
						String[] orgdefineids = orgdefineid.split("`");
						
						//System.out.println("MeasCopy1 : " + orgdefineids);
						
						for (int m = 0; m < orgdefineids.length; m++) {
							String[] iPart = orgdefineids[m].split("^");							
							orgMcid= iPart[0];
							
							System.out.println("MeasCopy : " + orgMcid);
							
							dbobject.executePreparedUpdate(sbu.toString(),new Object[]{orgMcid});

							// Weight 도 업데이트 하는 경우
							if ("1".equals(weight)){
								dbobject.executePreparedUpdate(sbtu.toString(),new Object[]{orgMcid});
							}
							
							// detailDefine에 특수문자가 들어가는 경우
							if ("1".equals(detail)){
								dbobject.executePreparedUpdate(sbdu.toString(),new Object[]{mcid, orgMcid});
							}							
							
							// 항목코드도 복사하는가?
							if ("1".equals(item)){ 

								
									String strD = "DELETE FROM TBLITEM WHERE MEASUREID=?";
									dbobject.executePreparedUpdate(strD,new Object[]{orgMcid});
									
									String strUI   = " insert into tblitem (measureid, code, itemname, itementry, itemtype, unit, itemfixed)";
											  strUI += " select ?, code, itemname, itementry, itemtype, unit, itemfixed  " ;
											  strUI += " from   tblitem ";
											  strUI += " where  measureid = ?" ;

									System.out.println("항목복사 SQL : \n"  + strUI);											  
											  
									Object[] pmUI = {orgMcid, mcid};
									dbobject.executePreparedUpdate(strUI,pmUI);
							}
							
							// 담당자
							if ("1".equals(updateId)){
								String strD1 = "DELETE FROM TBLAUTHORITY WHERE YEAR = ? AND MEASUREID=?";
								dbobject.executePreparedUpdate(strD1,new Object[]{year, orgMcid});
								
								String strUI1  = " insert into tblauthority (year, measureid, userid)";
									   strUI1 += " select year, ? measureid, userid  " ;
									   strUI1 += " from   tblauthority ";
									   strUI1 += " where  year = ? and measureid = ?" ;

								System.out.println("담당자 SQL : \n"  + strUI1);											  
										  
								Object[] pmUI1 = {orgMcid, year, mcid};
								dbobject.executePreparedUpdate(strUI1,pmUI1);								
							}
							
							//  등급구간 목표값 자동생성
							if ("1".equals(grade)){								
								System.out.println("등급구간 목표값 자동생성 : "  + mcid);	
								setMeasDetailValue(dbobject, year, orgMcid);
							}							
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
	}
	  
	//-----------------------------------------------------------------------------------------------------
	// 	 : setMeasDetailValue
	//   지표 목표값 생성시 관련 MeasureDetail에 Planned, Base, Limt을 주기에 맞게 자동생성.
	//-----------------------------------------------------------------------------------------------------
	public int setMeasDetailValue(DBObject dbobject, String year, String mcid) {

		ResultSet rs = null;   
		ResultSet rs2 = null;
		DataSet ds = new DataSet();
	    
		try {   		
				
				if ("".equals(year)){
					return -1;
				}

				// 0. 년도의 지표정의서 ID에 해당되는 정보를 구함.
				StringBuffer sb = new StringBuffer();				
				
				sb.append(" SELECT  a.id, a.measureid, a.frequency, a.weight, ?||b.ym ym,           ");
				sb.append("         a.planned, a.plannedbase, a.base , a.baselimit, a.limit,         ");
				sb.append("         a.plannedbaseplus, a.baseplus, a.baselimitplus , a.limitplus     ");
				sb.append(" FROM    tblmeasuredefine a,                                             ");
				sb.append("         (                                                               ");
				sb.append("         SELECT '년' freq, ltrim(to_char(rownum * 12,'00')) ym           ");
				sb.append("         FROM   tbluser WHERE rownum <= 1                                ");
				sb.append("         UNION ALL                                                       ");
				sb.append("         SELECT '반기' freq, ltrim(to_char(rownum * 6,'00')) ym          ");
				sb.append("         FROM   tbluser WHERE rownum <= 2                                ");
				sb.append("         UNION ALL                                                       ");
				sb.append("         SELECT '분기' freq, ltrim(to_char(rownum * 3,'00')) ym          ");
				sb.append("         FROM   tbluser WHERE rownum <= 4                                ");
				sb.append("         UNION ALL                                                       ");
				sb.append("         SELECT '월' freq, ltrim(to_char(rownum * 1,'00')) ym            ");
				sb.append("         FROM   tbluser WHERE rownum <= 12                               ");
				sb.append("         ) b                                                             ");
				sb.append(" WHERE  a.frequency = b.freq                                             ");
				sb.append(" AND    a.year      = ?                                                  ");
				sb.append(" AND    a.id        = ?                                                  ");				
				sb.append(" ORDER BY a.id, b.ym                                                     ");
				
				Object[] paramS = {year,year,mcid};
				rs = dbobject.executePreparedQuery(sb.toString(),paramS);
				ds.load(rs);
				rs = null;
				//System.out.println("Row Count : "+ ds.getRowCount());
				//System.out.println("MeasDetail 1.mcid : " + mcid );
				
				int     measureid  ;
				String  frequency  ;
				String  weight     ;
				String  ym         ;
				double planned    ;
				double base       ;
				double limit      ;
				double plannedbase    ;
				double baselimit      ;
				
				
				double plannedbaseplus ;
				double baseplus;
				double baselimitplus;
				double limitplus;
				
				
				// 지표정의서 Read... 
				int v_cnt = 0; 		
				int i = 0;
				
				while(ds.next()){
					
					System.out.println("	MeasDetail Loop : " + i++);
					System.out.println("	ds.getString('weight'     )   ===>   "+ds.getString("weight"     ));
					System.out.println("	ds.getString('planned'         )   ===>   "+String.valueOf(ds.isEmpty("planned")?0.0:ds.getDouble("planned"    )));
					System.out.println("	ds.getString('base'            )   ===>   "+String.valueOf(ds.isEmpty("base")?0.0:ds.getDouble("base"       )));
					System.out.println("	ds.getString('plannedbase'     )   ===>   "+String.valueOf(ds.isEmpty("plannedbase")?0.0:ds.getDouble("plannedbase"      )));
					System.out.println("	ds.getString('limit'     )   ===>   "+String.valueOf(ds.isEmpty("limit")?0.0:ds.getDouble("limit"      )));
					
					measureid   = ds.getInt("id"         );
					ym          = ds.getString("ym"         );
					frequency   = ds.getString("frequency"  );
					weight      = ds.getString("weight"     );
					planned     = ds.isEmpty("planned")?0.0:ds.getDouble("planned"    );
					base        = ds.isEmpty("base")?0.0:ds.getDouble("base"       );
					limit       = ds.isEmpty("limit")?0.0:ds.getDouble("limit"      );					
					
					plannedbase = ds.isEmpty("plannedbase")?0.0:ds.getDouble("plannedbase"    );
					baselimit   = ds.isEmpty("baselimit"  )?0.0:ds.getDouble("baselimit"      );
					
					
					plannedbaseplus   = ds.isEmpty("plannedbaseplus"  )?0.0:ds.getDouble("plannedbaseplus"      );
					baseplus          = ds.isEmpty("baseplus"  )?0.0:ds.getDouble("baseplus"      );
					baselimitplus     = ds.isEmpty("baselimitplus"  )?0.0:ds.getDouble("baselimitplus"      );
					limitplus         = ds.isEmpty("limitplus"  )?0.0:ds.getDouble("limitplus"      );
					
					//--------------------------------------------------------------
					// 1. MeasureDetail에 목표등급 데이타 Setting.
					//--------------------------------------------------------------					
					// 1-1. 주기에 맞지않는 목표값 삭제
					
					StringBuffer sbD = new StringBuffer();	
					
					if ("년".equals(frequency)){
						
						sbD.append(" delete tblmeasuredetail                               ");
						sbD.append(" where  measureid                = ?                   ");
						sbD.append(" and    strdate               like substr(?, 1,4)||'%' ");
						sbD.append(" and    substr(strdate,5,2) not in ('12')              ");
						
					} else if ("반기".equals(frequency)){
						sbD.append(" delete tblmeasuredetail                               ");
						sbD.append(" where  measureid                = ?                   ");
						sbD.append(" and    strdate               like substr(?, 1,4)||'%' ");
						sbD.append(" and    substr(strdate,5,2) not in  ('06','12')        ");						
						
					} else if ("분기".equals(frequency)){
						sbD.append(" delete tblmeasuredetail                                 ");
						sbD.append(" where  measureid                = ?                     ");
						sbD.append(" and    strdate               like substr(?, 1,4)||'%'   ");
						sbD.append(" and    substr(strdate,5,2) not in ('03','06','09','12') ");		
					}
					
					Object[] paramD = {String.valueOf(measureid),ym};					
					dbobject.executePreparedUpdate(sbD.toString(),paramD);
					
					//System.out.println("MeasDetail Delete : " + mcid + ", ym :" + ym);
					
					// 1-2. 주기에 맞는 목표값 자동 생성 					
					StringBuffer sbQ = new StringBuffer();				
					
					sbQ.append(" select count(*) cnt             ");
					sbQ.append(" from   tblmeasuredetail         ");
					sbQ.append(" where  measureid       = ?      ");
					sbQ.append(" and    strdate      like ?||'%' ");
			
					Object[] paramQ = {String.valueOf(measureid),ym};		
					
					rs2 = null;
					rs2 = dbobject.executePreparedQuery(sbQ.toString(),paramQ);
					rs2.next();
					
					v_cnt = rs2.getInt("cnt");
					rs2.close();
					
					//System.out.println("MeasDetail I/U Check : " + v_cnt);

					if (v_cnt > 0){
						StringBuffer sbU = new StringBuffer();						

						sbU.append(" update tblmeasuredetail                                         ");
						sbU.append(" set    weight      = ?                                          ");
						sbU.append("     ,  planned     = ?                                          ");
						sbU.append("     ,  base        = ?                                          ");
						sbU.append("     ,  limit       = ?                                          ");
						sbU.append("     ,  plannedbase = ?                                          ");
						sbU.append("     ,  baselimit   = ?                                          ");
						
						sbU.append("     ,  plannedbaseplus   = ?                                    ");
						sbU.append("     ,  baseplus          = ?                                    ");
						sbU.append("     ,  baselimitplus     = ?                                    ");
						sbU.append("     ,  limitplus         = ?                                    ");
						
						sbU.append("     ,  updatedate  = sysdate                                    ");
						sbU.append(" where  measureid       = ?                                      ");
						sbU.append(" and    strdate      like ?||'%'                                 ");
						
						Object[] paramU = {weight, String.valueOf(planned),  String.valueOf(base), String.valueOf(limit), 
										   String.valueOf(plannedbase), String.valueOf(baselimit),
										   String.valueOf(plannedbaseplus),String.valueOf(baseplus),String.valueOf(baselimitplus),String.valueOf(limitplus),
										   String.valueOf(measureid),ym};	
						dbobject.executePreparedUpdate(sbU.toString(),paramU);			
						
						//System.out.println("MeasDetail Update : " + mcid);
						
					}else{
						StringBuffer sbC = new StringBuffer();						

						sbC.append(" insert into tblmeasuredetail                                            ");
						sbC.append(" (id, measureid, strdate, weight,                                        ");
						sbC.append("  planned, base, limit, plannedbase, baselimit,                          ");
						sbC.append("  plannedbaseplus, baseplus, baselimitplus, limitplus, inputdate)        ");
						sbC.append(" SELECT nvl(max(id) + 1,0) id, ? measureid,?   ym,?  weight,             ");
						sbC.append("        ? planned, ? base, ? limit, ? plannedbase, ? baselimit,          ");
						sbC.append("        ? plannedbaseplus, ? baseplus, ? baselimitplus, ? limitplus, sysdate  ");
						sbC.append(" FROM   tblmeasuredetail                                                 ");						
						
						ym =  Util.getLastMonth(ym);
						Object[] paramI = {String.valueOf(measureid),ym,weight, String.valueOf(planned),  String.valueOf(base),  String.valueOf(limit), 
								 		   String.valueOf(plannedbase), String.valueOf(baselimit),
								 		   String.valueOf(plannedbaseplus),String.valueOf(baseplus),String.valueOf(baselimitplus),String.valueOf(limitplus)
								 		   };	
						dbobject.executePreparedUpdate(sbC.toString(),paramI);		
						
						//System.out.println("MeasDetail Insert : " + mcid);
					}					
						
				}
				
				//System.out.println("MeasDetail Planned Auto Create Sucess : " + mcid);				
				ds = null;
		

				return 0;

		} catch (Exception e) {
			System.out.println("setMeasDetailValue 에러 : " + e.toString()); 
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception ee){}
			try{if (rs2 != null) {rs2.close(); rs2 = null;} } catch (Exception ee){}
			try{if (ds != null) {ds = null;} } catch (Exception ee){}
			//e.printStackTrace();
			return -1;
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			try{if (rs2 != null) {rs2.close(); rs2 = null;} } catch (Exception e){}	
			try{if (ds != null) {ds = null;} } catch (Exception ee){}
		}		
		
	}
	
	//-----------------------------------------------------------------------------------------------------
	// 	 : setMeasWeight
	//     지표의 가중치를 상위 레벨로 Update한다.
	//-----------------------------------------------------------------------------------------------------
	public int setOrgMeasWeight(DBObject dbobject, String year, String bid) {


		ResultSet rs = null;   
		ResultSet rs2 = null;
		DataSet ds = new DataSet();
	    
		try {   		
				if ("".equals(year)) return -1;
				
				Object[] params = null;				
				
				
				
				
				System.out.println("   >>>> 1. 가중치 재계산 : 대상부서 - " + bid);
				
				// 0. 지표정의서의 가중치 Update : 지표레벨
				StringBuffer sb = new StringBuffer();
				
				sb.append(" update tblmeasuredefine d  ")
		          .append(" set d.weight = (  ")
		          .append("   select mweight from ")
		          .append("    (select distinct defineid, mweight from ")
		          .append("    (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
		          .append("    from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
		          .append("    (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank ")
		          .append("    from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
		          .append("    (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
		          .append("    from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
		          .append("    (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id defineid, d.measureid, etlkey ")
		          .append("    from tblmeasure c, tbltreescore t, tblmeasuredefine d  ")
		          .append("    where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
		          .append("   where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
		          .append("   and    BID = ?) Z where Z.defineid = d.id )")
		          .append(" WHERE EXISTS (select mweight from ")
		          .append("   (select distinct defineid, mweight from ")
		          .append("    (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
		          .append("    from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
		          .append("    (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank ")
		          .append("    from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
		          .append("    (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
		          .append("    from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
		          .append("    (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id defineid, d.measureid, etlkey ")
		          .append("    from tblmeasure c, tbltreescore t, tblmeasuredefine d  ")
		          .append("    where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
		          .append("   where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
		          .append("   and    BID = ?) Z where Z.defineid = d.id )");
				
				params = new Object[] {year,year,year,year,bid,year,year,year,year,bid};
				dbobject.executePreparedUpdate(sb.toString(),params);
				
				System.out.println("   >>>> 1. 가중치 재계산 : Measure - " + bid);				
				
				
				// 1. 전략목표 Update.
				sb = new StringBuffer();
				
				sb.append("update tbltreescore s ")
				  .append("set s.weight = (select oweight from ")
				  .append(" (select distinct oid, oname, sum(mweight) over (partition by bid, pid, oid) oweight from ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank ")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d  ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.oid) ")
				  .append("where exists (select oweight from ")
				  .append(" (select distinct oid, oname, sum(mweight) over (partition by bid, pid, oid) oweight from ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.oid) ");
				  
				params = new Object[] {year,year,year,year,bid,year,year,year,year,bid};
				dbobject.executePreparedUpdate(sb.toString(),params);
				  
				System.out.println("   >>>> 1. 가중치 재계산 : Object - " + bid);
				
				sb = new StringBuffer();
				
				sb.append("update tbltreescore s ")
				  .append("set s.weight = (select pweight from ")
				  .append(" (select distinct pid, pname, sum(mweight) over (partition by bid, pid)  pweight from ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank ")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d  ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.pid) ")
				  .append("where exists (select pweight from ")
				  .append(" (select distinct pid, pname, sum(mweight) over (partition by bid, pid)  pweight from ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.pid) ");
				
				params = new Object[] {year,year,year,year,bid,year,year,year,year,bid};
				dbobject.executePreparedUpdate(sb.toString(),params);
				
				System.out.println("   >>>> 1. 가중치 재계산 : Perspective - " + bid);				
				
				sb = new StringBuffer();
				
				sb.append("update tblhierarchy s ")
				  .append("set s.weight = (select bweight from ")
				  .append(" (select distinct bid, bname, sum(mweight) over (partition by cid, sid, bid) bweight from ")
				  .append("  (select c.name cname,t.id cid,t.contentid ccid,t.parentid cpid,t.rank crank ")
				  .append("  from tblcompany c, tblhierarchy t where t.treelevel=0 and t.year=? and t.contentid=c.id ) com, ")
				  .append("  (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank ")
				  .append("  from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id ) sbu, ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank ")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d  ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.bid) ")
				  .append("where exists (select bweight from ")
				  .append(" (select distinct bid, bname, sum(mweight) over (partition by cid, sid, bid) bweight from ")
				  .append("  (select c.name cname,t.id cid,t.contentid ccid,t.parentid cpid,t.rank crank ")
				  .append("  from tblcompany c, tblhierarchy t where t.treelevel=0 and t.year=? and t.contentid=c.id ) com, ")
				  .append("  (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank ")
				  .append("  from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id ) sbu, ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.bid) ");
				
				params = new Object[] {year,year,year,year,year,year,bid,
						               year,year,year,year,year,year,bid};
				dbobject.executePreparedUpdate(sb.toString(),params);
								
				System.out.println("   >>>> 1. 가중치 재계산 : BSC - " + bid);
				
				return 0;

		} catch (Exception e) {
			System.out.println("setMeasWeight 에러 : " + e.toString()); 
			//e.printStackTrace();
			return -1;
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			try{if (rs2 != null) {rs2.close(); rs2 = null;} } catch (Exception e){}	
		}		
		
	}
	
	//-----------------------------------------------------------------------------------------------------
	// 	 : setMeasWeight
	//     지표의 가중치를 상위 레벨로 Update한다.
	//-----------------------------------------------------------------------------------------------------
	public int setMeasWeight(DBObject dbobject, String year, String mcid) {


		ResultSet rs = null;   
		ResultSet rs2 = null;
		DataSet ds = new DataSet();
	    
		try {   		
				if ("".equals(year)) return -1;
				
				Object[] params = null;
				String   bid    = null;   // 지표 소유부서
				
				
				StringBuffer sb = new StringBuffer();
				
				sb.append(" SELECT  cid, ccid, clevel, crank, cname,  cweight,                                                                             ");
				sb.append("         sid, scid, slevel, srank, sname,  sweight,                                                                             ");
				sb.append("         bid, bcid, blevel, brank, bname,  sum(mweight) over (partition by cid, sid, bid          ) bweight,                    ");
				sb.append("         pid, pcid, plevel, prank, pname,  sum(mweight) over (partition by cid, sid, bid, pid     ) pweight,                    ");
				sb.append("         oid, ocid, olevel, orank, oname,  sum(mweight) over (partition by cid, sid, bid, pid, oid) oweight,                    ");
				sb.append("         mid, mcid, mlevel, mrank, mname,  mweight, measureid                                                                   ");
				sb.append(" FROM                                                                                                                           ");
				sb.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname        ");
				sb.append("         from   tblhierarchy t,tblcompany c                                                                                     ");
				sb.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                                               ");
				sb.append("        ) com,                                                                                                                  ");
				sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname        ");
				sb.append("         from   tblhierarchy t,tblsbu c                                                                                         ");
				sb.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =?                                                               ");
				sb.append("        ) sbu,                                                                                                                  ");
				sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname        ");
				sb.append("         from   tblhierarchy t,tblbsc c                                                                                         ");
				sb.append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =?                                                               ");
				sb.append("        ) bsc,                                                                                                                  ");
				sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname        ");
				sb.append("         from   tbltreescore t,tblpst c                                                                                         ");
				sb.append("         where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                                               ");
				sb.append("        ) pst  ,                                                                                                                ");
				sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname        ");
				sb.append("         from   tbltreescore t,tblobjective c                                                                                   ");
				sb.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                                               ");
				sb.append("        ) obj ,                                                                                                                 ");
				sb.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname,     ");
				sb.append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey                                           ");
				sb.append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d                                                           ");
				sb.append("         where  t.contentid=d.id  and t.treelevel=5 and t.year =? and d.measureid=c.id                                          ");
				sb.append("         and    t.contentid=?                                                                                                   ");
				sb.append("        ) mea                                                                                                                   ");
				sb.append(" where  cid = spid (+)                                                                                                          ");
				sb.append(" and    sid = bpid (+)                                                                                                          ");
				sb.append(" and    bid = ppid (+)                                                                                                          ");
				sb.append(" and    pid = opid (+)                                                                                                          ");
				sb.append(" and    oid = mpid                                                                                                              ");
				sb.append(" order by crank, srank, brank, prank, orank, mrank                                                                              ");
				
				Object[] paramS = {year,year,year, year,year,year, mcid};
				rs = dbobject.executePreparedQuery(sb.toString(),paramS);
				if (rs.next()) 	bid = rs.getString("bid");					
				
				System.out.println("1. 가중치 재계산 : orgMcid - " + mcid);				
				System.out.println("1. 가중치 재계산 : 대상부서구하기 - " + bid);
				
				// 0. 지표정의서의 가중치 Update : 지표레벨
				sb = new StringBuffer();
				
				sb.append(" update tblmeasuredefine d  ")
		          .append(" set d.weight = (  ")
		          .append("   select mweight from ")
		          .append("    (select distinct defineid, mweight from ")
		          .append("    (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
		          .append("    from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
		          .append("    (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank ")
		          .append("    from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
		          .append("    (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
		          .append("    from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
		          .append("    (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id defineid, d.measureid, etlkey ")
		          .append("    from tblmeasure c, tbltreescore t, tblmeasuredefine d  ")
		          .append("    where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
		          .append("   where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
		          .append("   and    BID = ?) Z where Z.defineid = d.id )")
		          .append(" WHERE EXISTS (select mweight from ")
		          .append("   (select distinct defineid, mweight from ")
		          .append("    (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
		          .append("    from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
		          .append("    (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank ")
		          .append("    from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
		          .append("    (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
		          .append("    from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
		          .append("    (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id defineid, d.measureid, etlkey ")
		          .append("    from tblmeasure c, tbltreescore t, tblmeasuredefine d  ")
		          .append("    where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
		          .append("   where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
		          .append("   and    BID = ?) Z where Z.defineid = d.id )");
				
				params = new Object[] {year,year,year,year,bid,year,year,year,year,bid};
				dbobject.executePreparedUpdate(sb.toString(),params);
				
				System.out.println("1. 가중치 재계산 : Measure - " + bid);				
				
				
				// 1. 전략목표 Update.
				sb = new StringBuffer();
				
				sb.append("update tbltreescore s ")
				  .append("set s.weight = (select oweight from ")
				  .append(" (select distinct oid, oname, sum(mweight) over (partition by bid, pid, oid) oweight from ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank ")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d  ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.oid) ")
				  .append("where exists (select oweight from ")
				  .append(" (select distinct oid, oname, sum(mweight) over (partition by bid, pid, oid) oweight from ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.oid) ");
				  
				params = new Object[] {year,year,year,year,bid,year,year,year,year,bid};
				dbobject.executePreparedUpdate(sb.toString(),params);
				  
				System.out.println("1. 가중치 재계산 : Object - " + bid);
				
				sb = new StringBuffer();
				
				sb.append("update tbltreescore s ")
				  .append("set s.weight = (select pweight from ")
				  .append(" (select distinct pid, pname, sum(mweight) over (partition by bid, pid)  pweight from ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank ")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d  ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.pid) ")
				  .append("where exists (select pweight from ")
				  .append(" (select distinct pid, pname, sum(mweight) over (partition by bid, pid)  pweight from ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.pid) ");
				
				params = new Object[] {year,year,year,year,bid,year,year,year,year,bid};
				dbobject.executePreparedUpdate(sb.toString(),params);
				
				System.out.println("1. 가중치 재계산 : Perspective - " + bid);				
				
				sb = new StringBuffer();
				
				sb.append("update tblhierarchy s ")
				  .append("set s.weight = (select bweight from ")
				  .append(" (select distinct bid, bname, sum(mweight) over (partition by cid, sid, bid) bweight from ")
				  .append("  (select c.name cname,t.id cid,t.contentid ccid,t.parentid cpid,t.rank crank ")
				  .append("  from tblcompany c, tblhierarchy t where t.treelevel=0 and t.year=? and t.contentid=c.id ) com, ")
				  .append("  (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank ")
				  .append("  from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id ) sbu, ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank ")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d  ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.bid) ")
				  .append("where exists (select bweight from ")
				  .append(" (select distinct bid, bname, sum(mweight) over (partition by cid, sid, bid) bweight from ")
				  .append("  (select c.name cname,t.id cid,t.contentid ccid,t.parentid cpid,t.rank crank ")
				  .append("  from tblcompany c, tblhierarchy t where t.treelevel=0 and t.year=? and t.contentid=c.id ) com, ")
				  .append("  (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank ")
				  .append("  from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id ) sbu, ")
				  .append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank ")
				  .append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc, ")
				  .append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank")
				  .append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst, ")
				  .append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank ")
				  .append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj, ")
				  .append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey ")
				  .append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d ")
				  .append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea ")
				  .append(" where  bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+) ")
				  .append(" and    BID = ?) z where s.id = z.bid) ");
				
				params = new Object[] {year,year,year,year,year,year,bid,year,year,year,year,year,year,bid};
				dbobject.executePreparedUpdate(sb.toString(),params);
								
				System.out.println("1. 가중치 재계산 : BSC - " + bid);
				
				return 0;

		} catch (Exception e) {
			System.out.println("setMeasWeight 에러 : " + e.toString()); 
			//e.printStackTrace();
			return -1;
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			try{if (rs2 != null) {rs2.close(); rs2 = null;} } catch (Exception e){}	
		}		
		
	}
		
	
	//-----------------------------------------------------------------------------------------------------
	// 	 : setMeasScoreValue
	//     지표연계시 관련 항목, 목표값, 실적값을 그대로 Copy(orgmcid => mcid)
	//-----------------------------------------------------------------------------------------------------
	public int setMeasScoreValue(DBObject dbobject, String year, String orgmcid, String mcid) {

		ResultSet rs = null;   
		ResultSet rs2 = null;
		DataSet ds = new DataSet();
	    
		try {   		
				
				if ("".equals(year)){
					return -1;
				}
				
				//------------------------------------------------------------------------------------
				// 0. tblitemactaul
				// 1. tblmeasuredetail
				// 2. tblmeasurescore 
				//------------------------------------------------------------------------------------
				String strD = "delete from tblitemactual where strdate like ?||'%' and measureid = ?";
				dbobject.executePreparedUpdate(strD,new Object[]{year, mcid});
				
				StringBuffer sb = new StringBuffer();				
				
				sb.append(" insert into tblitemactual (                                      ");
				sb.append("    measureid, code, strdate, inputdate, actual, accum, average)  ");
				sb.append(" select                                                           ");
				sb.append("    ? measureid, code, strdate, inputdate, actual, accum, average ");
				sb.append(" from  tblitemactual                                              ");
				sb.append(" where strdate    like ?||'%'                                     ");
				sb.append(" and   measureid     = ?                                          ");

				Object[] paramI = {mcid,year,orgmcid};
				dbobject.executePreparedUpdate(sb.toString(),paramI);
				
				// 1. tblmeasuredetail
				StringBuffer sbD = new StringBuffer();	
				sbD.append(" delete tblmeasuredetail              ");
				sbD.append(" where   strdate        like ?||'%'   ");
				sbD.append(" and     measureid      = ?           ");
							
				Object[] paramD = {year,mcid};					
				dbobject.executePreparedUpdate(sbD.toString(),paramD);
				
				String nextid = String.valueOf(dbobject.getNextId("TBLMEASUREDETAIL"));
				
				sbD = new StringBuffer();	
				sbD.append(" insert into tblmeasuredetail (                                                         ");
				sbD.append("    id, measureid, strdate, actual, weight, planned, comments, base, limit,plannedbase, baselimit,             ");
				sbD.append("    filepath, filename, inputid, updateid, inputdate, updatedate,conform)               ");
				sbD.append(" select                                                                                 ");
				sbD.append("    to_number(?) + rownum id, ? measureid, strdate, actual, weight, planned, comments, base, limit,plannedbase, baselimit,");
				sbD.append("    filepath, filename, inputid, updateid, inputdate, updatedate,conform                ");
				sbD.append(" from  tblmeasuredetail                                                                 ");
				sbD.append(" where   strdate        like ?||'%'   ");
				sbD.append(" and     measureid      = ?           ");	

				Object[] paramD1 = {nextid, mcid, year, orgmcid};					
				dbobject.executePreparedUpdate(sbD.toString(),paramD1);				
				
				// 2. tblmeasurescore 
				sbD = new StringBuffer();	
				sbD.append(" delete tblmeasurescore               ");
				sbD.append(" where   strdate        like ?||'%'   ");
				sbD.append(" and     measureid      = ?           ");
							
				Object[] paramS = {year,mcid};					
				dbobject.executePreparedUpdate(sbD.toString(),paramS);
				
				sbD = new StringBuffer();	
				sbD.append(" insert into tblmeasurescore (                                                          ");
				sbD.append("    measureid, strdate, actual, weight, planned, comments, base, limit, plannedbase, baselimit, plannedbase, baselimit,               ");
				sbD.append("    score, addscore  )                                                                  ");
				sbD.append(" select                                                                                 ");
				sbD.append("    ? measureid, strdate, actual, weight, planned, comments, base, limit, plannedbase, baselimit, plannedbase, baselimit,             ");
				sbD.append("    score, addscore                                                                     ");
				sbD.append(" from  tblmeasurescore                                                                  ");
				sbD.append(" where   strdate        like ?||'%'   ");
				sbD.append(" and     measureid      = ?           ");	

				Object[] paramS1 = {mcid, year, orgmcid};					
				dbobject.executePreparedUpdate(sbD.toString(),paramS1);		
				
				return 0;

		} catch (Exception e) {
			System.out.println("setMeasScoreValue 에러 : " + e.toString()); 
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception ee){}
			try{if (rs2 != null) {rs2.close(); rs2 = null;} } catch (Exception ee){}
			try{if (ds != null) {ds = null;} } catch (Exception ee){}
			//e.printStackTrace();
			return -1;
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			try{if (rs2 != null) {rs2.close(); rs2 = null;} } catch (Exception e){}	
			try{if (ds != null) {ds = null;} } catch (Exception ee){}
		}		
		
	}	
	
	//-----------------------------------------------------------------------------------------------------
	// 	지표복사(년 이관) http://127.0.0.1:7070/kopec/jsp/xml/hierarchy/copyMeasure.jsp?mode=U&div_gn=setMeasYearCopy
	//-----------------------------------------------------------------------------------------------------

	public void setMeasYearCopy(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
	    int rslt = 0;
		
		try {   
			
			String fmyear = request.getParameter("fmyear")==null?"":request.getParameter("fmyear");
			String toyear = request.getParameter("toyear")==null?"":request.getParameter("toyear");			

			//fmyear = "2007";
			//toyear ="2008";
			if ("".equals(fmyear)||"".equals(toyear)){
				request.setAttribute("rslt","false");				
				return;
			}			

			System.out.println("\n\n" );			
			System.out.println("=========================================================================");			
			System.out.println("Meas Year Copy : From " + fmyear + " To " + toyear );						
			
			// 0. 기존 자료를 삭제한다.
			//     0-1.tblitem,  tblauthority 의 경우 tblmeasuredefine의 년도 ID에 속한 항목들을 모두 삭제
			//     0-2.tblhierarchy, tbltreescore, tblmeasuredefine 테이블의 년도에 해당되는 되는 항목삭제.	
			if (setMeasYearDelete(toyear) < 0){
					System.out.println(" setMeasYearCopy - 지표 이관년도 삭제중 오류 :  "  + toyear);
					 conn.rollback();
					return;
			}
			
			System.out.println("1. Meas Year Copy : Delete Target Year's Meas");			

			//-----------------------------------------------------------------------------
			//  MAX ID...
			//-----------------------------------------------------------------------------			
			int v_mm = -1;     // TBLMeasureDefine 
			int v_hm = -1;      // TBLHIERARCHY 
			int v_sm = -1;      // TBLTREESCORE
			int v_dm = -1;		// TBLMEASUREDETAIL	

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());					

			// 1-1. 지표정의서 MAX ID : Query에서 년도 제거(2007 -> 2010)
			String strQry = "SELECT MAX(ID) as MM FROM TBLMEASUREDEFINE";
			rs = dbobject.executeQuery(strQry);
			while (rs.next()){
					v_mm = rs.getInt("MM");
			}			
			
			// 1-2. TREESCORE MAX ID.
			strQry = "SELECT MAX(ID) as SM FROM TBLTREESCORE";
			rs = dbobject.executeQuery(strQry);
			while (rs.next()){
					v_sm = rs.getInt("SM");
			}						
			
			// 1-3. TBLHIERARCHY  MAX ID.
			strQry = "SELECT MAX(ID) as HM FROM TBLHIERARCHY";
			rs = dbobject.executeQuery(strQry);
			while (rs.next()){
					v_hm = rs.getInt("HM");
			}			
			// 1-4. TBLMEASUREDETAIL  MAX ID.
			strQry = "SELECT MAX(ID) as DM FROM TBLMEASUREDETAIL ";
			rs = dbobject.executeQuery(strQry); 
			while (rs.next()){
					v_dm = rs.getInt("DM");
			}						
			
			System.out.println("2. Get Next MAX ID for Target Year.");			
			
			//-----------------------------------------------------------------------------
			// 2. 지표체계 복사 
			//-----------------------------------------------------------------------------
			// 2-1. 지표정의서 복사
			String strM = " ";
			strM += " insert into tblmeasuredefine (                   ";
			strM += "    id, measureid, detaildefine, weight, unit,    ";
			strM += "    entrytype, measuretype, frequency,            ";
			strM += "    equation, equationdefine, etlkey,             ";
			strM += "    measurement, year, trend,                     ";
			strM += "    planned, plannedbase, base, baselimit, limit, plannedbaseplus, baseplus, baselimitplus, limitplus, ";
			strM += "    y,   ya1, ya2, ya3, ya4, yb1, yb2, yb3,       ";
			strM += "    mean, updateid, equationtype, datasource,     ";
			strM += "    ifsystem, mngdeptnm, targetrationle, planned_flag, scorecode   )       ";			
			strM += " select                                           ";
			strM += "    id + ? id, measureid, detaildefine, weight, unit,    ";
			strM += "    entrytype, measuretype, frequency,            ";
			strM += "    equation, equationdefine, etlkey,             ";
			strM += "    measurement, ? year, trend,                   ";
			strM += "    planned, plannedbase, base, baselimit, limit, plannedbaseplus, baseplus, baselimitplus, limitplus,";
			strM += "    y,   ya1, ya2, ya3, ya4, yb1, yb2, yb3,       ";
			strM += "    mean, updateid, equationtype, datasource,     ";  
			strM += "    ifsystem, mngdeptnm, targetrationle, planned_flag, scorecode           ";   
			strM += " from  tblmeasuredefine                           ";
			strM += " where year = ?                                   ";
			strM += " order by id                                      ";
				
			dbobject.executePreparedUpdate(strM, new Object[]{String.valueOf(v_mm), toyear, fmyear});
			
			System.out.println("3. Meas Copy : 지표정의서");			
			
			// 2-2. 지표 TREESCORE  복사
			String strS = " ";
			strS += " insert into tbltreescore                                        "; 
			strS += " (id,parentid,contentid,treelevel,rank,year,weight)              ";
			strS += " select id+?, parentid,contentid,treelevel,rank,? year,weight    ";
			strS += " from tbltreescore where year=?                                  ";
			
			dbobject.executePreparedUpdate(strS, new Object[]{String.valueOf(v_sm), toyear, fmyear});
			System.out.println("3. Meas Copy : TREESCORE");					
			
			// 2-3. 지표 Hierarchy 복사
			String strH = " ";
			strH += " insert into tblhierarchy                                                           "; 
			strH += " (id,parentid,contentid,treelevel,rank,year,weight)                   ";
			strH += " select id+?, parentid,contentid,treelevel,rank,? year,weight    ";
			strH += " from tblhierarchy where year=?                                             ";
			dbobject.executePreparedUpdate(strH, new Object[]{String.valueOf(v_hm), toyear, fmyear});
			System.out.println("3. Meas Copy : Hierarchy");					
			
			
			// 2-4. parent ID정리.
			strH = " update tblhierarchy set parentid=parentid+? where year=? and treelevel in (1,2) ";
			dbobject.executePreparedUpdate(strH, new Object[]{String.valueOf(v_hm), toyear});
			
			strH = " update tbltreescore set parentid=parentid+? where year=? and treelevel in (3) ";
			dbobject.executePreparedUpdate(strH, new Object[]{String.valueOf(v_hm), toyear});

			strS = " update tbltreescore set parentid=parentid+? where year=? and treelevel in (4,5) ";
			dbobject.executePreparedUpdate(strS, new Object[]{String.valueOf(v_sm), toyear});

			strS = " update tbltreescore set contentid=contentid+? where year=? and treelevel in (5) ";
			dbobject.executePreparedUpdate(strS, new Object[]{String.valueOf(v_mm), toyear});
			
			System.out.println("3. Meas Copy : parent ID");					
			
			//-----------------------------------------------------------------------------
			// 3. 지표항목 복사 : 2007년 지표의 항목정보를 Update.
			//-----------------------------------------------------------------------------
			// 3-1. 지표항목 복사
			strS   = " insert into tblitem (code,measureid,itemname,itementry,itemtype,unit, itemfixed)       ";                       
			strS += " select code,measureid+?, itemname,itementry,itemtype,unit, itemfixed from tblitem "; 
			strS += " where measureid in  (select id from tblmeasuredefine where year=?)       ";                                               			

			dbobject.executePreparedUpdate(strS, new Object[]{String.valueOf(v_mm), fmyear});			
			System.out.println("3. Meas Copy : 지표항목");					
			
			//-----------------------------------------------------------------------------
			// 4. 지표사용자 정보 
			//-----------------------------------------------------------------------------
			// 4-1. 지표사용자 복사
			strS   = " insert into tblauthority (year,measureid,userid)       ";                       
			strS += " select ? year,  measureid+?,userid  from tblauthority "; 
			strS += " where year = ?  ";                                         			

			dbobject.executePreparedUpdate(strS, new Object[]{toyear, String.valueOf(v_mm), fmyear});			
			System.out.println("3. Meas Copy : 지표사용자");					
			
			// 6. 주기별 실적테이블의 목표값까지 설정.
			// 			
			// 4-1. 목표값  복사
			strS  = " insert into tblmeasuredetail (id,measureid,strdate, weight,planned, plannedbase, base, baselimit, limit, inputid, inputdate)  ";                       
			strS += " select id + ? id, measureid + ? measureid, ? ||substr(strdate,5) strdate, weight, planned, plannedbase, base, baselimit, limit, inputid, inputdate from tblmeasuredetail "; 
			strS += " where strdate like ? ||'%' ";                                                                         			

			dbobject.executePreparedUpdate(strS, new Object[]{String.valueOf(v_dm), String.valueOf(v_mm), toyear, fmyear});		
			System.out.println("3. Meas Copy : 목표값");					
			
			System.out.println("3. Copy and Restructure BSC Arch : Hierarchy,treescore, measuredefine, item, authority, target value.");			
			
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
	
	public void setMeasYearDeleteAll(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
	    int rslt = 0;
		
		try {   
			
			String year = request.getParameter("year")==null?"":request.getParameter("year");			

			//fmyear = "2007";
			//toyear ="2008";
			if ("".equals(year)){
				request.setAttribute("rslt","false");				
				return;
			}			

			System.out.println("\n\n" );			
			System.out.println("=========================================================================");			
			System.out.println("Meas Year Delete : " + year );						
			
			// 0. 기존 자료를 삭제한다.
			//     0-1.tblitem,  tblauthority 의 경우 tblmeasuredefine의 년도 ID에 속한 항목들을 모두 삭제
			//     0-2.tblhierarchy, tbltreescore, tblmeasuredefine 테이블의 년도에 해당되는 되는 항목삭제.	
			if (setMeasYearDelete(year) < 0){
					System.out.println(" setMeasYearCopy - 지표 이관년도 삭제중 오류 :  "  + year);
					 conn.rollback();
					return;
			}
			
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
	

	// 년도의 지표정의서 관련 삭제.
	public int setMeasYearDelete(String year){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
	    
		try {   		
				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);			
				if (dbobject==null) dbobject= new DBObject(conn.getConnection());		
				
				if ("".equals(year)){
					return -1;
				}

				// 0. tblmeasuredetail : 주기별 실적 테이블 
				String strD = "delete from tblmeasuredetail where strdate like ?||'%'";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				strD = "delete from tblmeasurescore where strdate like ?||'%'";
				dbobject.executePreparedUpdate(strD,new Object[]{year});
				
				// 1. tblitem : 항목 테이블
				strD = "delete from tblitem where measureid in (select  id from tblmeasuredefine where  year = ?) ";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				strD = "delete from tblitemactual where measureid in (select  id from tblmeasuredefine where  year = ?) ";
				dbobject.executePreparedUpdate(strD,new Object[]{year});				

				// 2. tblauthority : 권한 테이블 
				strD = "delete from tblauthority where year = ?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});
				
				// 3. tblmeasuredefine : 지표정의서 테이블 
				strD = "delete from tblmeasuredefine where year = ?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				// 4. tbltreescore : TREESCORE 테이블 
				strD = "delete from tbltreescore where year = ?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				// 4. tblhierarchy : Hierachy 테이블 
				strD = "delete from tblhierarchy where year = ?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});
				
				conn.commit();				
				return 0;
		
		} catch (Exception e) {
			System.out.println(e);
			return -1;
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}		
		
	}
	
	// 년도의 지표정의서 부서에 지표생성 및 실적연계처리.
	public int setMeasOrgCreate(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
		String year = "";
	    
		try {   		
				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);			
				if (dbobject==null) dbobject= new DBObject(conn.getConnection());		
				
				if ("".equals(year)){
					return -1;
				}

				// 0. tblmeasuredetail : 주기별 실적 테이블 
				String strD = "delete from tblmeasuredetail where strdate like ?||'%'";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				strD = "delete from tblmeasurescore where strdate like ?||'%'";
				dbobject.executePreparedUpdate(strD,new Object[]{year});
				
				// 1. tblitem : 항목 테이블
				strD = "delete from tblitem where measureid in (select  id from tblmeasuredefine where  year = ?) ";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				strD = "delete from tblitemactual where measureid in (select  id from tblmeasuredefine where  year = ?) ";
				dbobject.executePreparedUpdate(strD,new Object[]{year});				

				// 2. tblauthority : 권한 테이블 
				strD = "delete from tblauthority where year = ?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});
				
				// 3. tblmeasuredefine : 지표정의서 테이블 
				strD = "delete from tblmeasuredefine where year = ?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				// 4. tbltreescore : TREESCORE 테이블 
				strD = "delete from tbltreescore where year = ?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});

				// 4. tblhierarchy : Hierachy 테이블 
				strD = "delete from tblhierarchy where year = ?";
				dbobject.executePreparedUpdate(strD,new Object[]{year});
				
				conn.commit();				
				return 0;
		
		} catch (Exception e) {
			System.out.println(e);
			return -1;
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	/*
	//-----------------------------------------------------------------------------------------------------
	// 	지표자동생성...
	//-----------------------------------------------------------------------------------------------------
	*/
	public void setMeasCreate(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
	    
		try {   
			String strT = null;
			String tbl = "TBLTREESCORE";

			String year = request.getParameter("year");
			String mode = request.getParameter("mode");
			
			// 지표정의서와 지표코드
			String pcid = request.getParameter("pcid");
			String ocid = request.getParameter("ocid");
			String mcid = request.getParameter("mcid");
			String mcode= request.getParameter("mcode");
			
			
			// 대상부서 (부서명, mcid)
			String orgstr = request.getParameter("orgstr")==null?"":request.getParameter("orgstr");
			
			System.out.println("======================================================");
			System.out.println("==            MeasCreate :" + mcid);
			System.out.println("======================================================");					
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			
			//--------------------------------------------------------------------------------------------	
			//  부서별 Update.... 젠장 부서명에 ',' 이 들어가네...
			//--------------------------------------------------------------------------------------------
			
			System.out.println(orgstr);
			if (!"".equals(orgstr.trim())){
				
				String   orgBid   =null;
				String   orgBcid  =null;						
				String   orgWeight=null;						
				String   orgDefendent=null ;
				
				String   slevel=null;
				String   orgPid=null;
				String   orgOid=null;
				String   orgMid=null;
				String   orgMcid=null;
				
				String[] orgdefineids = orgstr.split("\\`");	
				
				for (int m = 0; m < orgdefineids.length; m++) {
					
					orgBid   =null;
					orgBcid  =null;						
					orgWeight=null;						
					orgDefendent=null ;
					
					slevel=null;
					orgPid=null;
					orgOid=null;
					orgMid=null;
					orgMcid=null;
					
					String[] iPart = orgdefineids[m].split("\\^");							
					
					orgBid      = iPart[0];			// 부서 TREE ID
					orgBcid     = iPart[1];			// 부서 ContentID
					orgWeight   = iPart[2];			// 부서 지표가중치
					orgDefendent= iPart[3];					
										
					System.out.println("	MeasCreate : orgBid / orgBcid / orgWeight / orgDefendent ="  + iPart[0] + "/"+ iPart[1] + "/"+ iPart[2] + "/"+ iPart[3] );
					
					// 1. 대상부서에 관점이 존재하는가?
					//    parentid = bscid...
					
					slevel = "3";
					orgPid = getExistPstId(dbobject, year,slevel,orgBid,pcid);		
					
					if ("".equals(orgPid)) {
						orgPid = String.valueOf(dbobject.getNextId(tbl));
						
						strT  = "";
						strT += " insert into tbltreescore                           "; 
						strT += " (id,parentid,contentid,treelevel,rank,year,weight) ";
						strT += " values (?,?,?,?,?,?,?)                             ";
						
						Object[] paramU = {orgPid,orgBid,pcid,slevel,"10",year,orgWeight };
						dbobject.executePreparedUpdate(strT, paramU );
					}
					System.out.println("1. Meas Create : TREESCORE Perspective : " + orgPid);
					
					// 2. 대상부서에 전략목표가 존재하는가?
					slevel = "4";
					orgOid = getExistObjId(dbobject, year,orgBid,orgPid,ocid);							
					if ("".equals(orgOid)) {
						orgOid = String.valueOf(dbobject.getNextId(tbl));
						
						strT  = "";
						strT += " insert into tbltreescore                           "; 
						strT += " (id,parentid,contentid,treelevel,rank,year,weight) ";
						strT += " values (?,?,?,?,?,?,?)                             ";
						
						Object[] paramU = {orgOid,orgPid,ocid,slevel,"10",year,orgWeight };
						dbobject.executePreparedUpdate(strT, paramU );
					}							
					System.out.println("2. Meas Create : TREESCORE Object : " + orgOid);
					
					// 3. 대상부서에 지표가 존재하니?		
					//  3-1.ContentId를 어떻게 구하지? 아는 것은 ParentId, Measureid.
					
					slevel = "5";
					StringBuffer sb = new StringBuffer();
					
					sb.append(" select t.id mid,t.parentid mpid,t.contentid mcid, c.name mname,      ");
					sb.append("        c.id mcd,d.measureid                                          ");
					sb.append(" from   tbltreescore    t, tblmeasure c,  tblmeasuredefine d          ");
					sb.append(" where  t.contentid=d.id  and t.treelevel=5 and d.measureid=c.id      ");
					sb.append(" and    t.year      =?                                                ");
					sb.append(" and    t.parentid  =?                                                ");
					//sb.append(" and    d.measureid =?                                                ");
					sb.append(" and    c.id =?                                                ");
					
					Object[] params = new Object[] {year, orgOid, mcode};
					rs = dbobject.executePreparedQuery(sb.toString(),params);
					if (rs.next()) {
						orgMid  = rs.getString("mid");
						orgMcid = rs.getString("mcid");						
					}					

					if ("".equals(orgMid)||orgMid==null) {
						orgMid  = String.valueOf(dbobject.getNextId(tbl));
						orgMcid = String.valueOf(dbobject.getNextId("TBLMEASUREDEFINE"));
						
						strT  = "";
						strT += " insert into tbltreescore                           "; 
						strT += " (id,parentid,contentid,treelevel,rank,year,weight) ";
						strT += " values (?,?,?,?,?,?,?)                             ";
						
						Object[] paramU = {orgMid,orgOid,orgMcid,slevel,"10",year,orgWeight };
						dbobject.executePreparedUpdate(strT, paramU );
					}					

					System.out.println("3. Meas Create : TREESCORE Measure : orgMcid " + orgMcid);					
					
					//-------------------------------------------------------------------------
					// 4. 지표정의서를 삭제후  새롭게 등록.
					//-------------------------------------------------------------------------
					String strD = "delete from tblmeasuredefine where year = ? and id = ?";
					dbobject.executePreparedUpdate(strD,new Object[]{year,orgMcid});
					
					String strM = " ";
					strM += " insert into tblmeasuredefine (                   ";
					strM += "    id, measureid, detaildefine, weight, unit,    ";
					strM += "    entrytype, measuretype, frequency,            ";
					strM += "    equation, equationdefine, etlkey,             ";
					strM += "    measurement, year, trend,                     ";
					strM += "    planned, plannedbase, base, baselimit, limit, plannedbaseplus, baseplus, baselimitplus, limitplus,";
					strM += "    y,   ya1, ya2, ya3, ya4, yb1, yb2, yb3,       ";
					strM += "    mean, updateid, equationtype, datasource,     ";  
					strM += "    ifsystem, mngdeptnm, targetrationle, planned_flag,scorecode )          ";   	
					strM += " select                                           ";
					strM += "    ? id, measureid, detaildefine, weight, unit,  ";
					strM += "    entrytype, measuretype, frequency,            ";
					strM += "    equation, equationdefine, etlkey,             ";
					strM += "    measurement, year, trend,                     ";
					strM += "    planned, plannedbase, base, baselimit, limit, plannedbaseplus, baseplus, baselimitplus, limitplus, ";
					strM += "    y,   ya1, ya2, ya3, ya4, yb1, yb2, yb3,       ";
					strM += "    mean, updateid, equationtype, datasource,     ";  
					strM += "    ifsystem, mngdeptnm, targetrationle, planned_flag,scorecode           ";   
					strM += " from  tblmeasuredefine                           ";
					strM += " where year = ?                                   ";
					strM += " and   id   = ?                                   ";							
					strM += " order by id                                      ";
						
					dbobject.executePreparedUpdate(strM, new Object[]{orgMcid, year, mcid});
					System.out.println("4. Meas Create : MeasureDefine : " + mcid);

					
					//-------------------------------------------------------------------------
					// 5. 항목코드도 복사하는가?
					//-------------------------------------------------------------------------
					strD = "DELETE FROM TBLITEM WHERE MEASUREID=?";
					dbobject.executePreparedUpdate(strD,new Object[]{orgMcid});
					
					String strUI  = " insert into tblitem (measureid, code, itemname, itementry, itemtype, unit, itemfixed)";
						   strUI += " select ?, code, itemname, itementry, itemtype, unit, itemfixed  " ;
						   strUI += " from   tblitem ";
						   strUI += " where  measureid = ?" ;
							  
					Object[] pmUI = {orgMcid, mcid};
					dbobject.executePreparedUpdate(strUI,pmUI);							
					System.out.println("5. Meas Create : ITEM");
					
					//-------------------------------------------------------------------------
					// 6. 지표사용자 복사
					//-------------------------------------------------------------------------	
					strD  = " delete tblauthority where year = ? and measureid = ?" ;
					dbobject.executePreparedUpdate(strD,new Object[]{year,mcid});			
					   
					strUI  = " insert into tblauthority (year,measureid,userid)    ";                       
					strUI += " select year, ? measureid, userid  from tblauthority "; 
					strUI += " where year = ?  "; 
					strUI += " and   measureid = ?" ;

					dbobject.executePreparedUpdate(strUI, new Object[]{year, orgMcid, mcid});			
					System.out.println("6. Meas Create : 지표사용자 복사");		
					
					//-------------------------------------------------------------------------
					// 6. 지표 목표값 생성
					//-------------------------------------------------------------------------					
					setMeasDetailValue(dbobject,year,orgMcid);
					System.out.println("7. Meas Create : 목표값 생성");		
		
					//-------------------------------------------------------------------------
					// 8. 지표실적연계
					//-------------------------------------------------------------------------
					if ("Y".equals(orgDefendent)){
						   strD  = " delete tblmeasuredependent where childid = ?" ;
						   dbobject.executePreparedUpdate(strD,new Object[]{orgMcid});						
						
						   strUI  = " insert into tblmeasuredependent (parentid, childid) values (?,?)" ;
						   dbobject.executePreparedUpdate(strUI,new Object[]{mcid, orgMcid});
						   System.out.println("8. Meas Create : 지표실적연계");	
						   
						   // From : mcid, To : orgMcid : KOPEC은 없음.
						   //setMeasScoreValue(dbobject,year,mcid,orgMcid);
						   System.out.println("8-1. Meas Create : 실적값 생성 " + mcid + " => " + orgMcid);
						   
						   // 가중치가 달라지면... tblmeasuredetail, tblmeasurescore에 Update한다.
						   strUI = " update tblmeasuredetail set weight = ? where strdate like ?||'%' and meausreid = ?";
						   dbobject.executePreparedUpdate(strUI,new Object[]{orgWeight, year, orgMcid});

						   strUI = " update tblmeasurescore set weight = ? where strdate like ?||'%' and meausreid = ?";
						   dbobject.executePreparedUpdate(strUI,new Object[]{orgWeight, year, orgMcid});						   
					}

					
					//-------------------------------------------------------------------------
					// 9. 지표가중치 Update				
					//-------------------------------------------------------------------------
					setOrgMeasWeight(dbobject,year,orgBid);
					System.out.println("9. Meas Create : 가중치 재적용 : " + orgBid);	
					
				}	// Loop End ----------------------------------------------------------------
				
			}
			
			conn.commit();
			
			request.setAttribute("rslt","true");

		} catch (Exception e) {
			System.out.println("setMeasCreate : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	/*
	//-----------------------------------------------------------------------------------------------------
	// 	지표자동생성...
	//-----------------------------------------------------------------------------------------------------
	*/
	public void setMeasCreateAll(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
	    
		try {   
			String strT = null;
			String tbl = "TBLTREESCORE";

			String year = request.getParameter("year");
			String mode = request.getParameter("mode");
			
			// 대상부서 (부서명, mcid)
			String srcstr = request.getParameter("srcstr")==null?"":request.getParameter("srcstr");			
			String orgstr = request.getParameter("orgstr")==null?"":request.getParameter("orgstr");
			
			System.out.println("scrstr " + srcstr);
					
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			
			if (!"".equals(srcstr.trim())){
				
				//--------------------------------------------------------------------------------------------	
				//  부서별 Update.... 젠장 부서명에 ',' 이 들어가네...
				//--------------------------------------------------------------------------------------------
				if (!"".equals(orgstr.trim())){
					
					String   orgBid   =null;
					String   orgBcid  =null;						
					String   orgWeight=null;						
					String   orgDefendent=null ;
					
					String   slevel=null;
					String   orgPid=null;
					String   orgOid=null;
					String   orgMid=null;
					String   orgMcid=null;					
					
					String[] orgdefineids = orgstr.split("\\`");	
					
					// 부서로 ...
					for (int m = 0; m < orgdefineids.length; m++) {
						
						String[] iPart = orgdefineids[m].split("\\^");							
						
						orgBid      = iPart[0];			// 부서 TREE ID
						orgBcid     = iPart[1];			// 부서 ContentID
						orgWeight   = iPart[2];			// 부서 지표가중치
						orgDefendent= iPart[3];		

						System.out.println("\n\n\n\n");
						System.out.println("===================================================================");
						System.out.println("	setMeasCreateAll : orgBid / orgBcid / orgWeight / orgDefendent ="  + iPart[0] + "/"+ iPart[1] + "/"+ iPart[2] + "/"+ iPart[3] );						System.out.println("===================================================================");							
						System.out.println("===================================================================");

						// 지표정의서와 지표코드 초기화.
						String pcid    = null;
						String ocid    = null;
						String mcid    = null;
						String mcode   = null;
						String mweight = null;				
						String[] srcdefineids = srcstr.split("\\`");
						
						// 1. 대상부서에 관점이 존재하는가?
						//    parentid = bscid...
							
						for (int k = 0; k < srcdefineids.length; k++) {
							
							// 초기화.
							orgPid=null; orgOid=null;orgMid=null;orgMcid=null;							
							
							String[] sPart = srcdefineids[k].split("\\^");							
							
							pcid    = sPart[0];			
							ocid    = sPart[1];			
							mcid    = sPart[2];			// 부서 TREE ID
							mcode   = sPart[3];			// 부서 ContentID
							mweight = sPart[4];         // 부서 지표가중치

							System.out.println("==   MeasCreate :" + pcid + "/" + ocid + "/" + mcid + "/" + mcode + "/" + mweight);
							
							slevel = "3";
							orgPid = getExistPstId(dbobject, year,slevel,orgBid,pcid);		
							
							if ("".equals(orgPid)) {
								orgPid = String.valueOf(dbobject.getNextId(tbl));
								
								strT  = "";
								strT += " insert into tbltreescore                           "; 
								strT += " (id,parentid,contentid,treelevel,rank,year,weight) ";
								strT += " values (?,?,?,?,?,?,?)                             ";
								
								Object[] paramU = {orgPid,orgBid,pcid,slevel,"10",year,orgWeight };
								dbobject.executePreparedUpdate(strT, paramU );
							}
							System.out.println("1. Meas Create : TREESCORE Perspective : " + orgPid);
							
							// 2. 대상부서에 전략목표가 존재하는가?
							slevel = "4";
							orgOid = getExistObjId(dbobject, year,orgBid,orgPid,ocid);							
							if ("".equals(orgOid)) {
								orgOid = String.valueOf(dbobject.getNextId(tbl));
								
								strT  = "";
								strT += " insert into tbltreescore                           "; 
								strT += " (id,parentid,contentid,treelevel,rank,year,weight) ";
								strT += " values (?,?,?,?,?,?,?)                             ";
								
								Object[] paramU = {orgOid,orgPid,ocid,slevel,"10",year,orgWeight };
								dbobject.executePreparedUpdate(strT, paramU );
							}							
							System.out.println("2. Meas Create : TREESCORE Object : " + orgOid);
							
							// 3. 대상부서에 지표가 존재하니?		
							//  3-1.ContentId를 어떻게 구하지? 아는 것은 ParentId, Measureid.
							
							slevel = "5";
							StringBuffer sb = new StringBuffer();
							
							sb.append(" select t.id mid,t.parentid mpid,t.contentid mcid, c.name mname,      ");
							sb.append("        c.id mcd,d.measureid, t.weight mweight                        ");
							sb.append(" from   tbltreescore    t, tblmeasure c,  tblmeasuredefine d          ");
							sb.append(" where  t.contentid=d.id  and t.treelevel=5 and d.measureid=c.id      ");
							sb.append(" and    t.year      =?                                                ");
							sb.append(" and    t.parentid  =?                                                ");
							sb.append(" and    d.measureid =?                                                ");
							
							Object[] params = new Object[] {year, orgOid, mcode};
							rs = dbobject.executePreparedQuery(sb.toString(),params);
							if (rs.next()) {
								orgMid    = rs.getString("mid");
								orgMcid   = rs.getString("mcid");	
							}					
		
							if ("".equals(orgMid)||orgMid==null) {
								orgMid  = String.valueOf(dbobject.getNextId("TBLTREESCORE"    ));
								orgMcid = String.valueOf(dbobject.getNextId("TBLMEASUREDEFINE"));
								
								strT  = "";
								strT += " insert into tbltreescore                           "; 
								strT += " (id,parentid,contentid,treelevel,rank,year,weight) ";
								strT += " values (?,?,?,?,?,?,?)                             ";
								
								Object[] paramU = {orgMid,orgOid,orgMcid,slevel,"10",year, mweight };
								dbobject.executePreparedUpdate(strT, paramU );
							}					
		
							System.out.println("3. Meas Create : TREESCORE Measure : orgMcid " + orgMid +"/" + orgOid +"/" + orgMcid);					
							
							//-------------------------------------------------------------------------
							// 4. 지표정의서를 삭제후  새롭게 등록.
							//-------------------------------------------------------------------------
							String strD = "delete from tblmeasuredefine where year = ? and id = ?";
							dbobject.executePreparedUpdate(strD,new Object[]{year,orgMcid});
							
							String strM = " ";
							strM += " insert into tblmeasuredefine (                   ";
							strM += "    id, measureid, detaildefine, weight, unit,    ";
							strM += "    entrytype, measuretype, frequency,            ";
							strM += "    equation, equationdefine, etlkey,             ";
							strM += "    measurement, year, trend,                     ";
							strM += "    planned, plannedbase, base, baselimit, limit, plannedbaseplus, baseplus, baselimitplus, limitplus, ";
							strM += "    y,   ya1, ya2, ya3, ya4, yb1, yb2, yb3,       ";
							strM += "    mean, updateid, equationtype, datasource,     ";  
							strM += "    ifsystem, mngdeptnm, targetrationle, planned_flag,scorecode )        ";   		
							strM += " select                                           ";
							strM += "    ? id, measureid, detaildefine, weight, unit,  ";
							strM += "    entrytype, measuretype, frequency,            ";
							strM += "    equation, equationdefine, etlkey,             ";
							strM += "    measurement, year, trend,                     ";
							strM += "    planned, plannedbase, base, baselimit, limit, plannedbaseplus, baseplus, baselimitplus, limitplus, ";
							strM += "    y,   ya1, ya2, ya3, ya4, yb1, yb2, yb3,       ";
							strM += "    mean, updateid, equationtype, datasource,     ";  
							strM += "    ifsystem, mngdeptnm, targetrationle, planned_flag,scorecode           ";   
							strM += " from  tblmeasuredefine                           ";
							strM += " where year = ?                                   ";
							strM += " and   id   = ?                                   ";							
							strM += " order by id                                      ";
								
							dbobject.executePreparedUpdate(strM, new Object[]{orgMcid, year, mcid});
							System.out.println("4. Meas Create : MeasureDefine : " + mcid);
		
							
							//-------------------------------------------------------------------------
							// 5. 항목코드도 복사하는가?
							//-------------------------------------------------------------------------
							strD = "DELETE FROM TBLITEM WHERE MEASUREID=?";
							dbobject.executePreparedUpdate(strD,new Object[]{orgMcid});
							
							String strUI  = " insert into tblitem (measureid, code, itemname, itementry, itemtype, unit, itemfixed)";
								   strUI += " select ?, code, itemname, itementry, itemtype, unit, itemfixed  " ;
								   strUI += " from   tblitem ";
								   strUI += " where  measureid = ?" ;
									  
							Object[] pmUI = {orgMcid, mcid};
							dbobject.executePreparedUpdate(strUI,pmUI);							
							System.out.println("5. Meas Create : ITEM");
							
							//-------------------------------------------------------------------------
							// 6. 지표사용자 복사
							//-------------------------------------------------------------------------	
							strD  = " delete tblauthority where year = ? and measureid = ?" ;
							dbobject.executePreparedUpdate(strD,new Object[]{year,mcid});			
							   
							strUI  = " insert into tblauthority (year,measureid,userid)    ";                       
							strUI += " select year, ? measureid, userid  from tblauthority "; 
							strUI += " where year = ?  "; 
							strUI += " and   measureid = ?" ;
		
							dbobject.executePreparedUpdate(strUI, new Object[]{year, orgMcid, mcid});			
							System.out.println("6. Meas Create : 지표사용자 복사");		
							
							//-------------------------------------------------------------------------
							// 6. 지표 목표값 생성
							//-------------------------------------------------------------------------					
							setMeasDetailValue(dbobject,year,orgMcid);
							System.out.println("7. Meas Create : 목표값 생성");	
							
							//-------------------------------------------------------------------------
							// 8. 지표실적연계
							//-------------------------------------------------------------------------
							if ("Y".equals(orgDefendent)){
								   strD  = " delete tblmeasuredependent where childid = ?" ;
								   dbobject.executePreparedUpdate(strD,new Object[]{orgMcid});						
								
								   strUI  = " insert into tblmeasuredependent (parentid, childid) values (?,?)" ;
								   dbobject.executePreparedUpdate(strUI,new Object[]{mcid, orgMcid});
								   System.out.println("8. Meas Create : 지표실적연계");	
								   
								   // 실적 재적용 : XX 짜증만땅... : tblitemactual, tblmeasuredetail, tblmeasurescore
								   
								   // From : mcid, To : orgMcid
								   //setMeasScoreValue(dbobject,year,mcid,orgMcid);
								   System.out.println("8-1. Meas Create : 실적값 생성 " + mcid + " => " + orgMcid);		
							}
					
						}	// Loop End ----------------------------------------------------------------
						
						//-------------------------------------------------------------------------
						// 9. 지표가중치 Update				
						//-------------------------------------------------------------------------
						setOrgMeasWeight(dbobject,year,orgBid);
						System.out.println("9. Meas Create : 가중치 재적용 " + orgBid);	
						
					}	// orgStr End
				
				} // srcSTR Loop End.	
			
			}	// srcStr End.
			conn.commit();			
			request.setAttribute("rslt","true");

		} catch (Exception e) {
			System.out.println("setMeasCreate : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
		
	/*
	//-----------------------------------------------------------------------------------------------------
	// 	부서의 지표 전체삭제.
	//-----------------------------------------------------------------------------------------------------
	*/
	public void OrgMeasDeleteAll(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
	    
		try {   
			String strT = null;
			String tbl = "TBLTREESCORE";
				
			String year  = request.getParameter("year");
			String bid   = request.getParameter("bid");		// 삭제대상 부서 BSCID

			System.out.println("=================================================");
			System.out.println("             OrgMeasDeleteAll BSC :" + bid);
			System.out.println("=================================================");
			
			if ("".equals("bid")) return;

			// 
			// 1. 부서에 해당하는 지표 List를 구한다. 
			
			// 2. 삭제대상 테이블 
			// 	2.1 tblmeasuredetail, tblmeasurescore    , tblitemactual
			//  2.2 tblmeasuredefine, tblmeasuredefendent, tblauthority
			//  2.3 tbltreescore    : 단계별 삭제진행
					
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			
			//--------------------------------------------------------------------------------------------	
			// 	2.1 tblmeasuredetail, tblmeasurescore, tblitemactual
			//--------------------------------------------------------------------------------------------
			StringBuffer sb = new StringBuffer();
			
			sb.append(" delete tblmeasuredetail                                                                                   ");
			sb.append(" where  strdate   like ?||'%'                                                                              ");
			sb.append(" and    measureid in (                                                                                     ");
			sb.append("         SELECT mcid FROM                                                                                  ");
			sb.append("         (                                                                                                 ");
			sb.append("         SELECT  cid, ccid, clevel, cname,                                                                 ");
			sb.append("                 sid, scid, slevel, sname,                                                                 ");
			sb.append("                 bid, bcid, blevel, bname,                                                                 ");
			sb.append("                 pid, pcid, plevel, pname,                                                                 ");
			sb.append("                 oid, ocid, olevel, oname,                                                                 ");
			sb.append("                 mid, mcid, mlevel                                                                         ");
			sb.append("         FROM                                                                                              ");
			sb.append("                (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, c.name cname         ");
			sb.append("                 from   tblhierarchy t,tblcompany c                                                        ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                  ");
			sb.append("                ) com,                                                                                     ");
			sb.append("                (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, c.name sname         ");
			sb.append("                 from   tblhierarchy t,tblsbu c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=1 and t.year =?                                  ");
			sb.append("                ) sbu,                                                                                     ");
			sb.append("                (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, c.name bname         ");
			sb.append("                 from   tblhierarchy t,tblbsc c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=2 and t.year =? and t.id = ?                     ");			// 특정부서 
			sb.append("                ) bsc,                                                                                     ");
			sb.append("                (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, c.name pname         ");
			sb.append("                 from   tbltreescore t,tblpst c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                  ");
			sb.append("                ) pst  ,                                                                                   ");
			sb.append("                (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, c.name oname         ");
			sb.append("                 from   tbltreescore t,tblobjective c                                                      ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                  ");
			sb.append("                ) obj ,                                                                                    ");
			sb.append("                (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel                       ");
			sb.append("                 from    tbltreescore t                                                                    ");
			sb.append("                 where  t.treelevel=5 and t.year =?                                                        ");
			sb.append("                ) mea                                                                                      ");
			sb.append("         where  cid = spid (+)                                                                             ");
			sb.append("         and    sid = bpid (+)                                                                             ");
			sb.append("         and    bid = ppid (+)                                                                             ");
			sb.append("         and    pid = opid (+)                                                                             ");
			sb.append("         and    oid = mpid                                                                                 ");
			sb.append("         )                                                                                                 ");
			sb.append("         )                                                                                                 ");			

					
			Object[] paramD = {year,	year,year,year,bid, 	year,year,year};
			dbobject.executePreparedUpdate(sb.toString(), paramD );
			
			System.out.println("1. tblmeasuredetail :" + bid);
			
			//--------------------------------------------------------------------------------------------	
			// 	2.1 tblmeasuredetail, tblmeasurescore, tblitemactual
			//--------------------------------------------------------------------------------------------
			sb = new StringBuffer();
			
			sb.append(" delete tblmeasurescore                                                                                    ");
			sb.append(" where  strdate   like ?||'%'                                                                              ");
			sb.append(" and    measureid in (                                                                                     ");
			sb.append("         SELECT mcid FROM                                                                                  ");		// 지표정의서 
			sb.append("         (                                                                                                 ");
			sb.append("         SELECT  cid, ccid, clevel, cname,                                                                 ");
			sb.append("                 sid, scid, slevel, sname,                                                                 ");
			sb.append("                 bid, bcid, blevel, bname,                                                                 ");
			sb.append("                 pid, pcid, plevel, pname,                                                                 ");
			sb.append("                 oid, ocid, olevel, oname,                                                                 ");
			sb.append("                 mid, mcid, mlevel                                                                         ");
			sb.append("         FROM                                                                                              ");
			sb.append("                (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, c.name cname         ");
			sb.append("                 from   tblhierarchy t,tblcompany c                                                        ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                  ");
			sb.append("                ) com,                                                                                     ");
			sb.append("                (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, c.name sname         ");
			sb.append("                 from   tblhierarchy t,tblsbu c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=1 and t.year =?                                  ");
			sb.append("                ) sbu,                                                                                     ");
			sb.append("                (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, c.name bname         ");
			sb.append("                 from   tblhierarchy t,tblbsc c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=2 and t.year =? and t.id = ?                     ");		// 특정부서 
			sb.append("                ) bsc,                                                                                     ");
			sb.append("                (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, c.name pname         ");
			sb.append("                 from   tbltreescore t,tblpst c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                  ");
			sb.append("                ) pst  ,                                                                                   ");
			sb.append("                (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, c.name oname         ");
			sb.append("                 from   tbltreescore t,tblobjective c                                                      ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                  ");
			sb.append("                ) obj ,                                                                                    ");
			sb.append("                (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel                       ");
			sb.append("                 from    tbltreescore t                                                                    ");
			sb.append("                 where  t.treelevel=5 and t.year =?                                                        ");
			sb.append("                ) mea                                                                                      ");
			sb.append("         where  cid = spid (+)                                                                             ");
			sb.append("         and    sid = bpid (+)                                                                             ");
			sb.append("         and    bid = ppid (+)                                                                             ");
			sb.append("         and    pid = opid (+)                                                                             ");
			sb.append("         and    oid = mpid                                                                                 ");
			sb.append("         )                                                                                                 ");
			sb.append("         )                                                                                                 ");			

			paramD = new Object[] {year,	year,year,year,bid, 	year,year,year};
			dbobject.executePreparedUpdate(sb.toString(), paramD );			
			
			System.out.println("2. tblmeasurescore :" + bid);
			
			//--------------------------------------------------------------------------------------------	
			// 	2.1 tblmeasuredetail, tblmeasurescore, tblitemactual
			//--------------------------------------------------------------------------------------------
			sb = new StringBuffer();
			
			sb.append(" delete tblitemactual                                                                                    ");
			sb.append(" where  strdate   like ?||'%'                                                                              ");
			sb.append(" and    measureid in (                                                                                     ");
			sb.append("         SELECT mcid FROM                                                                                  ");		// 지표정의서 
			sb.append("         (                                                                                                 ");
			sb.append("         SELECT  cid, ccid, clevel, cname,                                                                 ");
			sb.append("                 sid, scid, slevel, sname,                                                                 ");
			sb.append("                 bid, bcid, blevel, bname,                                                                 ");
			sb.append("                 pid, pcid, plevel, pname,                                                                 ");
			sb.append("                 oid, ocid, olevel, oname,                                                                 ");
			sb.append("                 mid, mcid, mlevel                                                                         ");
			sb.append("         FROM                                                                                              ");
			sb.append("                (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, c.name cname         ");
			sb.append("                 from   tblhierarchy t,tblcompany c                                                        ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                  ");
			sb.append("                ) com,                                                                                     ");
			sb.append("                (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, c.name sname         ");
			sb.append("                 from   tblhierarchy t,tblsbu c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=1 and t.year =?                                  ");
			sb.append("                ) sbu,                                                                                     ");
			sb.append("                (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, c.name bname         ");
			sb.append("                 from   tblhierarchy t,tblbsc c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=2 and t.year =? and t.id = ?                     ");		// 특정부서 
			sb.append("                ) bsc,                                                                                     ");
			sb.append("                (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, c.name pname         ");
			sb.append("                 from   tbltreescore t,tblpst c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                  ");
			sb.append("                ) pst  ,                                                                                   ");
			sb.append("                (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, c.name oname         ");
			sb.append("                 from   tbltreescore t,tblobjective c                                                      ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                  ");
			sb.append("                ) obj ,                                                                                    ");
			sb.append("                (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel                       ");
			sb.append("                 from    tbltreescore t                                                                    ");
			sb.append("                 where  t.treelevel=5 and t.year =?                                                        ");
			sb.append("                ) mea                                                                                      ");
			sb.append("         where  cid = spid (+)                                                                             ");
			sb.append("         and    sid = bpid (+)                                                                             ");
			sb.append("         and    bid = ppid (+)                                                                             ");
			sb.append("         and    pid = opid (+)                                                                             ");
			sb.append("         and    oid = mpid                                                                                 ");
			sb.append("         )                                                                                                 ");
			sb.append("         )                                                                                                 ");			

			paramD = new Object[] {year,	year,year,year,bid, 	year,year,year};
			dbobject.executePreparedUpdate(sb.toString(), paramD );			

			System.out.println("3. tblitemactual :" + bid);
			
			//--------------------------------------------------------------------------------------------	
			//		  2.2 tblmeasuredefine, tblmeasuredefendent, tblauthority
			//--------------------------------------------------------------------------------------------
			sb = new StringBuffer();
			
			sb.append(" delete tblmeasuredependent                                                                                ");
			sb.append(" where  childid in (                                                                                       ");
			sb.append("         SELECT mcid FROM                                                                                  ");		// 지표정의서 
			sb.append("         (                                                                                                 ");
			sb.append("         SELECT  cid, ccid, clevel, cname,                                                                 ");
			sb.append("                 sid, scid, slevel, sname,                                                                 ");
			sb.append("                 bid, bcid, blevel, bname,                                                                 ");
			sb.append("                 pid, pcid, plevel, pname,                                                                 ");
			sb.append("                 oid, ocid, olevel, oname,                                                                 ");
			sb.append("                 mid, mcid, mlevel                                                                         ");
			sb.append("         FROM                                                                                              ");
			sb.append("                (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, c.name cname         ");
			sb.append("                 from   tblhierarchy t,tblcompany c                                                        ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                  ");
			sb.append("                ) com,                                                                                     ");
			sb.append("                (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, c.name sname         ");
			sb.append("                 from   tblhierarchy t,tblsbu c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=1 and t.year =?                                  ");
			sb.append("                ) sbu,                                                                                     ");
			sb.append("                (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, c.name bname         ");
			sb.append("                 from   tblhierarchy t,tblbsc c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=2 and t.year =? and t.id = ?                     ");		// 특정부서 
			sb.append("                ) bsc,                                                                                     ");
			sb.append("                (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, c.name pname         ");
			sb.append("                 from   tbltreescore t,tblpst c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                  ");
			sb.append("                ) pst  ,                                                                                   ");
			sb.append("                (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, c.name oname         ");
			sb.append("                 from   tbltreescore t,tblobjective c                                                      ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                  ");
			sb.append("                ) obj ,                                                                                    ");
			sb.append("                (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel                       ");
			sb.append("                 from    tbltreescore t                                                                    ");
			sb.append("                 where  t.treelevel=5 and t.year =?                                                        ");
			sb.append("                ) mea                                                                                      ");
			sb.append("         where  cid = spid (+)                                                                             ");
			sb.append("         and    sid = bpid (+)                                                                             ");
			sb.append("         and    bid = ppid (+)                                                                             ");
			sb.append("         and    pid = opid (+)                                                                             ");
			sb.append("         and    oid = mpid                                                                                 ");
			sb.append("         )                                                                                                 ");
			sb.append("         )                                                                                                 ");			

			paramD = new Object[] {year,year,year,bid, 	year,year,year};
			dbobject.executePreparedUpdate(sb.toString(), paramD );			

			System.out.println("4. tblmeasuredefendent :" + bid);
						
			
			//--------------------------------------------------------------------------------------------	
			//		  2.2 tblmeasuredefine, tblmeasuredefendent, tblauthority
			//--------------------------------------------------------------------------------------------
			sb = new StringBuffer();
			
			sb.append(" delete tblauthority                                                                                       ");
			sb.append(" where  year   like ?                                                                                      ");
			sb.append(" and    measureid in (                                                                                     ");
			sb.append("         SELECT mcid FROM                                                                                  ");		// 지표정의서 
			sb.append("         (                                                                                                 ");
			sb.append("         SELECT  cid, ccid, clevel, cname,                                                                 ");
			sb.append("                 sid, scid, slevel, sname,                                                                 ");
			sb.append("                 bid, bcid, blevel, bname,                                                                 ");
			sb.append("                 pid, pcid, plevel, pname,                                                                 ");
			sb.append("                 oid, ocid, olevel, oname,                                                                 ");
			sb.append("                 mid, mcid, mlevel                                                                         ");
			sb.append("         FROM                                                                                              ");
			sb.append("                (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, c.name cname         ");
			sb.append("                 from   tblhierarchy t,tblcompany c                                                        ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                  ");
			sb.append("                ) com,                                                                                     ");
			sb.append("                (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, c.name sname         ");
			sb.append("                 from   tblhierarchy t,tblsbu c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=1 and t.year =?                                  ");
			sb.append("                ) sbu,                                                                                     ");
			sb.append("                (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, c.name bname         ");
			sb.append("                 from   tblhierarchy t,tblbsc c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=2 and t.year =? and t.id = ?                     ");		// 특정부서 
			sb.append("                ) bsc,                                                                                     ");
			sb.append("                (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, c.name pname         ");
			sb.append("                 from   tbltreescore t,tblpst c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                  ");
			sb.append("                ) pst  ,                                                                                   ");
			sb.append("                (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, c.name oname         ");
			sb.append("                 from   tbltreescore t,tblobjective c                                                      ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                  ");
			sb.append("                ) obj ,                                                                                    ");
			sb.append("                (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel                       ");
			sb.append("                 from    tbltreescore t                                                                    ");
			sb.append("                 where  t.treelevel=5 and t.year =?                                                        ");
			sb.append("                ) mea                                                                                      ");
			sb.append("         where  cid = spid (+)                                                                             ");
			sb.append("         and    sid = bpid (+)                                                                             ");
			sb.append("         and    bid = ppid (+)                                                                             ");
			sb.append("         and    pid = opid (+)                                                                             ");
			sb.append("         and    oid = mpid                                                                                 ");
			sb.append("         )                                                                                                 ");
			sb.append("         )                                                                                                 ");			

			paramD = new Object[] {year,	year,year,year,bid, 	year,year,year};
			dbobject.executePreparedUpdate(sb.toString(), paramD );				
			
			System.out.println("5. tblauthority :" + bid);
			
			//--------------------------------------------------------------------------------------------	
			//		  2.2 tblmeasuredefine, tblmeasuredefendent, tblauthority
			//--------------------------------------------------------------------------------------------
			sb = new StringBuffer();
			
			sb.append(" delete tblmeasuredefine                                                                                   ");
			sb.append(" where  year   like ?                                                                                      ");
			sb.append(" and    id in (                                                                                            ");
			sb.append("         SELECT mcid FROM                                                                                  ");		// 지표정의서 
			sb.append("         (                                                                                                 ");
			sb.append("         SELECT  cid, ccid, clevel, cname,                                                                 ");
			sb.append("                 sid, scid, slevel, sname,                                                                 ");
			sb.append("                 bid, bcid, blevel, bname,                                                                 ");
			sb.append("                 pid, pcid, plevel, pname,                                                                 ");
			sb.append("                 oid, ocid, olevel, oname,                                                                 ");
			sb.append("                 mid, mcid, mlevel                                                                         ");
			sb.append("         FROM                                                                                              ");
			sb.append("                (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, c.name cname         ");
			sb.append("                 from   tblhierarchy t,tblcompany c                                                        ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                  ");
			sb.append("                ) com,                                                                                     ");
			sb.append("                (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, c.name sname         ");
			sb.append("                 from   tblhierarchy t,tblsbu c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=1 and t.year =?                                  ");
			sb.append("                ) sbu,                                                                                     ");
			sb.append("                (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, c.name bname         ");
			sb.append("                 from   tblhierarchy t,tblbsc c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=2 and t.year =? and t.id = ?                     ");		// 특정부서 
			sb.append("                ) bsc,                                                                                     ");
			sb.append("                (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, c.name pname         ");
			sb.append("                 from   tbltreescore t,tblpst c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                  ");
			sb.append("                ) pst  ,                                                                                   ");
			sb.append("                (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, c.name oname         ");
			sb.append("                 from   tbltreescore t,tblobjective c                                                      ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                  ");
			sb.append("                ) obj ,                                                                                    ");
			sb.append("                (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel                       ");
			sb.append("                 from    tbltreescore t                                                                    ");
			sb.append("                 where  t.treelevel=5 and t.year =?                                                        ");
			sb.append("                ) mea                                                                                      ");
			sb.append("         where  cid = spid (+)                                                                             ");
			sb.append("         and    sid = bpid (+)                                                                             ");
			sb.append("         and    bid = ppid (+)                                                                             ");
			sb.append("         and    pid = opid (+)                                                                             ");
			sb.append("         and    oid = mpid                                                                                 ");
			sb.append("         )                                                                                                 ");
			sb.append("         )                                                                                                 ");			

			paramD = new Object[] {year,	year,year,year,bid, 	year,year,year};
			dbobject.executePreparedUpdate(sb.toString(), paramD );
			
			System.out.println("6. tblmeasuredefine :" + bid);
			
			
			//--------------------------------------------------------------------------------------------	
			//		  2.3 tbltreescore    : 단계별 삭제진행 : MEAS
			//--------------------------------------------------------------------------------------------
			sb = new StringBuffer();
			
			sb.append(" delete tbltreescore                                                                                       ");
			sb.append(" where  year   like ?                                                                                      ");
			sb.append(" and    treelevel = 5                                                                                      ");
			sb.append(" and    parentid in (                                                                                      ");
			sb.append("         SELECT oid FROM                                                                                   ");		// 지표정의서 
			sb.append("         (                                                                                                 ");
			sb.append("         SELECT  cid, ccid, clevel, cname,                                                                 ");
			sb.append("                 sid, scid, slevel, sname,                                                                 ");
			sb.append("                 bid, bcid, blevel, bname,                                                                 ");
			sb.append("                 pid, pcid, plevel, pname,                                                                 ");
			sb.append("                 oid, ocid, olevel, oname                                                                  ");
			sb.append("         FROM                                                                                              ");
			sb.append("                (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, c.name cname         ");
			sb.append("                 from   tblhierarchy t,tblcompany c                                                        ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                  ");
			sb.append("                ) com,                                                                                     ");
			sb.append("                (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, c.name sname         ");
			sb.append("                 from   tblhierarchy t,tblsbu c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=1 and t.year =?                                  ");
			sb.append("                ) sbu,                                                                                     ");
			sb.append("                (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, c.name bname         ");
			sb.append("                 from   tblhierarchy t,tblbsc c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=2 and t.year =? and t.id = ?                     ");		// 특정부서 
			sb.append("                ) bsc,                                                                                     ");
			sb.append("                (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, c.name pname         ");
			sb.append("                 from   tbltreescore t,tblpst c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                  ");
			sb.append("                ) pst  ,                                                                                   ");
			sb.append("                (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, c.name oname         ");
			sb.append("                 from   tbltreescore t,tblobjective c                                                      ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                  ");
			sb.append("                ) obj                                                                                      ");
			sb.append("         where  cid = spid (+)                                                                             ");
			sb.append("         and    sid = bpid (+)                                                                             ");
			sb.append("         and    bid = ppid (+)                                                                             ");
			sb.append("         and    pid = opid                                                                                 ");
			sb.append("         )                                                                                                 ");
			sb.append("         )                                                                                                 ");			

			paramD = new Object[] {year,	year,year,year,bid, 	year,year};
			dbobject.executePreparedUpdate(sb.toString(), paramD );

			System.out.println("7. tbltreescore Level 5:" + bid);
						
			//--------------------------------------------------------------------------------------------	
			//		  2.3 tbltreescore    : 단계별 삭제진행 : OBJ
			//--------------------------------------------------------------------------------------------
			sb = new StringBuffer();
			
			sb.append(" delete tbltreescore                                                                                       ");
			sb.append(" where  year   like ?                                                                                      ");
			sb.append(" and    treelevel = 4                                                                                      ");
			sb.append(" and    parentid in (                                                                                      ");
			sb.append("         SELECT pid FROM                                                                                   ");		// 지표정의서 
			sb.append("         (                                                                                                 ");
			sb.append("         SELECT  cid, ccid, clevel, cname,                                                                 ");
			sb.append("                 sid, scid, slevel, sname,                                                                 ");
			sb.append("                 bid, bcid, blevel, bname,                                                                 ");
			sb.append("                 pid, pcid, plevel, pname                                                                  ");
			sb.append("         FROM                                                                                              ");
			sb.append("                (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, c.name cname         ");
			sb.append("                 from   tblhierarchy t,tblcompany c                                                        ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                  ");
			sb.append("                ) com,                                                                                     ");
			sb.append("                (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, c.name sname         ");
			sb.append("                 from   tblhierarchy t,tblsbu c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=1 and t.year =?                                  ");
			sb.append("                ) sbu,                                                                                     ");
			sb.append("                (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, c.name bname         ");
			sb.append("                 from   tblhierarchy t,tblbsc c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=2 and t.year =? and t.id = ?                     ");		// 특정부서 
			sb.append("                ) bsc,                                                                                     ");
			sb.append("                (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, c.name pname         ");
			sb.append("                 from   tbltreescore t,tblpst c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                  ");
			sb.append("                ) pst                                                                                      ");
			sb.append("         where  cid = spid (+)                                                                             ");
			sb.append("         and    sid = bpid (+)                                                                             ");
			sb.append("         and    bid = ppid                                                                                 ");
			sb.append("         )                                                                                                 ");
			sb.append("         )                                                                                                 ");			

			paramD = new Object[] {year,	year,year,year,bid, 	year};
			dbobject.executePreparedUpdate(sb.toString(), paramD );

			System.out.println("7. tbltreescore Level 4:" + bid);
			
			//--------------------------------------------------------------------------------------------	
			//		  2.3 tbltreescore    : 단계별 삭제진행 : PST
			//--------------------------------------------------------------------------------------------
			sb = new StringBuffer();
			
			sb.append(" delete tbltreescore                                                                                       ");
			sb.append(" where  year   like ?                                                                                      ");
			sb.append(" and    treelevel = 3                                                                                      ");
			sb.append(" and    parentid in (                                                                                      ");
			sb.append("         SELECT bid FROM                                                                                   ");		// 지표정의서 
			sb.append("         (                                                                                                 ");
			sb.append("         SELECT  cid, ccid, clevel, cname,                                                                 ");
			sb.append("                 sid, scid, slevel, sname,                                                                 ");
			sb.append("                 bid, bcid, blevel, bname                                                                  ");
			sb.append("         FROM                                                                                              ");
			sb.append("                (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, c.name cname         ");
			sb.append("                 from   tblhierarchy t,tblcompany c                                                        ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                  ");
			sb.append("                ) com,                                                                                     ");
			sb.append("                (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, c.name sname         ");
			sb.append("                 from   tblhierarchy t,tblsbu c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=1 and t.year =?                                  ");
			sb.append("                ) sbu,                                                                                     ");
			sb.append("                (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, c.name bname         ");
			sb.append("                 from   tblhierarchy t,tblbsc c                                                            ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=2 and t.year =? and t.id = ?                     ");		// 특정부서 
			sb.append("                ) bsc                                                                                     ");
			sb.append("         where  cid = spid (+)                                                                             ");
			sb.append("         and    sid = bpid                                                                                 ");
			sb.append("         )                                                                                                 ");
			sb.append("         )                                                                                                 ");			

			paramD = new Object[] {year,	year,year,year,bid};
			dbobject.executePreparedUpdate(sb.toString(), paramD );

			System.out.println("7. tbltreescore Level 3:" + bid);	
			

			// 
			conn.commit();
			
			request.setAttribute("rslt","true");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	

	
	/**
	*   getExistTreeId : TREESCORE에 있는 TREEID를 구함.
	*/
	public String getExistPstId(DBObject  dbobject, String year, String level, String parentid, String contentid) throws SQLException{
		
		ResultSet rs = null;
		try {
			
			String sql  = " select id from tbltreescore "  
				        + "  where year     =? "
				        + "    and treelevel=? "
				        + "    and parentid =? " 
				        + "    and contentid=? ";
			
			System.out.println("	level/parentid/contentid = " +level +"/"+parentid+"/"+contentid);
			
			
			Object[] paramS = {year,level,parentid,contentid};
			rs = dbobject.executePreparedQuery(sql,paramS);
			if (rs.next()) return rs.getString("id");
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			if(rs !=null){rs.close(); rs = null;}
		}
		return "";
	}	
	
	/**
	*   getExistObjId : TREESCORE에 있는 TREEID를 구함.
	*/
	public String getExistObjId(DBObject  dbobject, String year, String bscid, String pstid, String contentid) throws SQLException{
		
		ResultSet rs = null;
		try {
			StringBuffer sb = new StringBuffer();
			
			sb.append(" SELECT  pid, ppid, pcid, plevel, pname,                                                      ");
			sb.append("         oid, opid, ocid, olevel, oname                                                       ");
			sb.append(" FROM                                                                                         ");
			sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, c.name pname    ");
			sb.append("         from   tbltreescore t,tblpst c                                                       ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=3 and t.year =?                             ");
			sb.append("         and    t.parentid  = ?                                                               ");
			sb.append("        ) pst  ,                                                                              ");
			sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, c.name oname    ");
			sb.append("         from   tbltreescore t,tblobjective c                                                 ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year =?                             ");
			sb.append("         and    t.parentid  = ?                                                               ");
			sb.append("         and    t.contentid = ?                                                               ");
			sb.append("        ) obj                                                                                 ");
			sb.append(" WHERE  pid = opid                                                                            ");
			sb.append(" ORDER BY pid,oid                                                                             ");

			
			Object[] paramS = {year,bscid,year,pstid,contentid};
			rs = dbobject.executePreparedQuery(sb.toString(),paramS);
			if (rs.next()) return rs.getString("oid");
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			if(rs !=null){rs.close(); rs = null;}
		}
		return "";
	}		
}

