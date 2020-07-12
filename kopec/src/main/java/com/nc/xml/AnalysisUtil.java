package com.nc.xml;

import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.tree.TreeNode;
import com.nc.tree.TreeUtil;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class AnalysisUtil {


	public void setScoreTable(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		TreeUtil treeutil = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String year = request.getParameter("year");
			String bscId = request.getParameter("bscId");

			System.out.println(bscId);
			treeutil = new TreeUtil(conn.getConnection());

			TreeNode treenode = treeutil.getTreeRoot(year,bscId);

			StringBuffer sb = new StringBuffer();
			treenode.buildTextNode(sb,5);

			request.setAttribute("sb",sb);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (treeutil != null){treeutil.close(); treeutil = null; }
			if (dbobject != null){dbobject.close(); dbobject = null; }
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public void setScoreDivision(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		TreeUtil treeutil = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String year = request.getParameter("year");
			String sbuId = request.getParameter("sbuId");

			treeutil = new TreeUtil(conn.getConnection());

			TreeNode treenode = treeutil.getTreeDivision(year,sbuId);

			StringBuffer sb = new StringBuffer();
			treenode.buildTextNode(sb,2);

			request.setAttribute("sb",sb);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (treeutil!=null) {treeutil.close(); treeutil=null;}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public JSONArray selectScoreDivision(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String year = request.getParameter("year");
			String sbuId = request.getParameter("sbuId");

			TreeUtil treeutil = new TreeUtil(conn.getConnection());

			TreeNode treenode = treeutil.getTreeDivision(year,sbuId);

			JSONArray jArray = new JSONArray();

			treenode.buildJsonNode(jArray, 2);

			return jArray;
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}

		return null;
	}


	public void setAnnually(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		TreeUtil treeutil = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String fYear = request.getParameter("fYear");
			String tYear = request.getParameter("tYear");
			String sbuId = request.getParameter("cid");

			int iFyear = Integer.parseInt(fYear);
			int iTyear = Integer.parseInt(tYear);

			treeutil = new TreeUtil(conn.getConnection());

			StringBuffer sb = new StringBuffer();

			for(int i=iFyear;i<=iTyear;i++){
				sb.append("year|"+i+"|"+"\r\n");
				TreeNode treenode = treeutil.getTreeAnnually(String.valueOf(i),sbuId);
				treenode.buildTextNode(sb,2);
			}

			request.setAttribute("sb",sb);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (treeutil != null){treeutil.close(); treeutil = null; }
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public JSONArray selectAnnually(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		TreeUtil treeutil = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String fYear = request.getParameter("fYear");
			String tYear = request.getParameter("tYear");
			String sbuId = request.getParameter("cid");

			int iFyear = Integer.parseInt(fYear);
			int iTyear = Integer.parseInt(tYear);

			treeutil = new TreeUtil(conn.getConnection());

			JSONArray jArray = new JSONArray();

			for(int i=iFyear;i<=iTyear;i++){
				JSONObject jObj = new JSONObject();
				jObj.put("year", i);
				jArray.add(jObj);

				TreeNode treenode = treeutil.getTreeAnnually(String.valueOf(i),sbuId);
				treenode.buildJsonNode(jArray, 2);
			}

			return jArray;

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (treeutil != null){treeutil.close(); treeutil = null; }
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}

		return null;

	}

	public void setTaskActual(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			String bscId = request.getParameter("bscId");
			String year = request.getParameter("year");

			if (bscId==null){
				return;
			}

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM ( ")
	         .append(" SELECT DISTINCT(I.DETAILID) DETAILID FROM TBLINITIATIVE I WHERE BSCID=? )INI ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT D.DETAILID DID,D.EXECWORK,D.PROJECTID PID,C.NAME,P.TYPEID TID,T.TYPENAME TNAME,P.FIELDID,F.FIELDNAME, ")
	         .append(" D.SYEAR||'년 '||D.SQTR||'분기 ~'||D.EYEAR||'년 '||D.EQTR||'분기' PERIOD FROM  ")
	         .append(" TBLSTRATPROJECT C, TBLSTRATPROJECTINFO P, TBLSTRATPROJECTDETAIL D,TBLSTRATTYPEINFO T,TBLSTRATFIELDINFO F  ")
	         .append(" WHERE C.ID=P.CONTENTID AND D.PROJECTID=P.PROJECTID AND P.TYPEID=T.TYPEID AND P.FIELDID=F.FIELDID ) P ")
	         .append(" ON INI.DETAILID=P.DID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT DETAILID QDID1,QTRGOAL GOAL1,QTRACHV ACHV1,REALIZE R1 FROM TBLSTRATACHVREGI WHERE YEAR=? AND QTR=1 ) Q1 ")
	         .append(" ON INI.DETAILID=Q1.QDID1 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT DETAILID QDID2,QTRGOAL GOAL2,QTRACHV ACHV2,REALIZE R2 FROM TBLSTRATACHVREGI WHERE YEAR=? AND QTR=2 ) Q2 ")
	         .append(" ON INI.DETAILID=Q2.QDID2 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT DETAILID QDID3,QTRGOAL GOAL3,QTRACHV ACHV3,REALIZE R3 FROM TBLSTRATACHVREGI WHERE YEAR=? AND QTR=3 ) Q3 ")
	         .append(" ON INI.DETAILID=Q3.QDID3 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT DETAILID QDID4,QTRGOAL GOAL4,QTRACHV ACHV4,REALIZE R4 FROM TBLSTRATACHVREGI WHERE YEAR=? AND QTR=4 ) Q4 ")
	         .append(" ON INI.DETAILID=Q4.QDID4 WHERE DID IS NOT NULL ORDER BY TID,NAME,FIELDID");

			Object[] paramS = {bscId,year,year,year,year};

			rs = dbobject.executePreparedQuery(sb.toString(),paramS);

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


	public void setTaskObjective(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		TreeUtil treeutil = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String year = request.getParameter("year");
			String bscId = request.getParameter("bscId");
			String qtr = request.getParameter("qtr");
			String bcId = request.getParameter("bcId");


			if (qtr==null ) return;

			int iQtr = Integer.parseInt(qtr);

			treeutil = new TreeUtil(conn.getConnection());

			TreeNode treenode = treeutil.getTreeRoot(year,bscId);
			ArrayList list = new ArrayList();

			for (int i = 0; i < treenode.childs.size(); i++) {
				TreeNode pst = (TreeNode)treenode.childs.get(i);
				for (int j = 0; j < pst.childs.size(); j++) {
					TreeNode obj = (TreeNode)pst.childs.get(j);
					AnalyObjective objective = new AnalyObjective();
					objective.ocId = obj.cid;
					objective.otId = obj.id;
					objective.bname = treenode.name;
					objective.pname = pst.name;
					objective.oname = obj.name;
					objective.score = obj.score[(iQtr*3)-1];

					list.add(objective);
				}
			}
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());

			StringBuffer sbR = new StringBuffer();
			sbR.append(" SELECT * FROM ( ")
	         .append(" SELECT I.BSCID,I.OBJID,I.DETAILID,I.PROJECTID FROM TBLINITIATIVE I WHERE BSCID=? )INI ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT D.DETAILID DID,D.EXECWORK,D.PROJECTID PID,C.NAME,P.TYPEID TID,T.TYPENAME TNAME,P.FIELDID,F.FIELDNAME, ")
	         .append(" D.SYEAR||'년 '||D.SQTR||'분기 ~'||D.EYEAR||'년 '||D.EQTR||'분기' PERIOD FROM  ")
	         .append(" TBLSTRATPROJECT C, TBLSTRATPROJECTINFO P, TBLSTRATPROJECTDETAIL D,TBLSTRATTYPEINFO T,TBLSTRATFIELDINFO F  ")
	         .append(" WHERE C.ID=P.CONTENTID AND D.PROJECTID=P.PROJECTID AND P.TYPEID=T.TYPEID AND P.FIELDID=F.FIELDID ) P ")
	         .append(" ON INI.DETAILID=P.DID AND INI.PROJECTID=P.PID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT DETAILID QDID,QTRGOAL GOAL,QTRACHV ACHV,REALIZE R FROM TBLSTRATACHVREGI WHERE YEAR=? AND QTR=? ) Q ")
	         .append(" ON INI.DETAILID=Q.QDID ")
	         .append(" WHERE EXECWORK IS NOT NULL")
	         .append(" ORDER BY FIELDID,PID ");
			Object[] pmR = {bcId,year,qtr};

			rs = dbobject.executePreparedQuery(sbR.toString(),pmR);

			while (rs.next()){
				AnalyObjective obj = getObjective(list, rs.getInt("OBJID"));
				if (obj!=null){
					obj.exec = (obj.exec!=null?obj.exec:"")+"`" + rs.getString("EXECWORK")+"^"+rs.getString("TNAME")+"^"+rs.getDouble("GOAL")+"^"+rs.getDouble("ACHV")+"^"+rs.getDouble("R");
				}
			}

			request.setAttribute("list",list);

			StringBuffer sbStat = new StringBuffer();
			sbStat.append(" SELECT * FROM ( ")
	         .append(" SELECT I.BSCID,I.OBJID,I.DETAILID,I.PROJECTID FROM TBLINITIATIVE I WHERE BSCID=? )INI ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT D.DETAILID DID,D.EXECWORK,D.PROJECTID PID,C.NAME,P.TYPEID TID,T.TYPENAME TNAME,P.FIELDID,F.FIELDNAME, ")
	         .append(" D.SYEAR||'년 '||D.SQTR||'분기 ~'||D.EYEAR||'년 '||D.EQTR||'분기' PERIOD,D.SYEAR,D.EYEAR FROM  ")
	         .append(" TBLSTRATPROJECT C, TBLSTRATPROJECTINFO P, TBLSTRATPROJECTDETAIL D,TBLSTRATTYPEINFO T,TBLSTRATFIELDINFO F  ")
	         .append(" WHERE C.ID=P.CONTENTID AND D.PROJECTID=P.PROJECTID AND P.TYPEID=T.TYPEID AND P.FIELDID=F.FIELDID ) P ")
	         .append(" ON INI.DETAILID=P.DID AND INI.PROJECTID=P.PID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT DETAILID ADID,REALIZE REAL,QTRGOAL,QTRACHV FROM TBLSTRATACHVREGI WHERE YEAR=? AND QTR=?) ACH ")
	         .append(" ON INI.DETAILID=ACH.ADID ")
	         .append(" WHERE EXECWORK IS NOT NULL");
			Object[] pmStat = {bcId,year,qtr};

			if (rs!=null){rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(sbStat.toString(),pmStat);
			DataSet dsStat = new DataSet();
			dsStat.load(rs);

			request.setAttribute("dsStat",dsStat);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (treeutil != null){treeutil.close(); treeutil = null; }
			if (dbobject != null){dbobject.close(); dbobject = null; }
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	private AnalyObjective getObjective(ArrayList list, int objId){
		for (int i = 0; i < list.size(); i++) {
			AnalyObjective tmp = (AnalyObjective) list.get(i);
			if (tmp.ocId==objId) return tmp;
		}
		return null;
	}

	//---------------------------------------------------------------------------------------------
	// 부서별 지표현황
	//---------------------------------------------------------------------------------------------
	public void getOrgMeasureStatus(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			String year = request.getParameter("year");
			String stype = request.getParameter("stype");				// 1: 지표, 2:가중치

			System.out.println("year:"+year+"/stype:"+stype);

			StringBuffer sbStat = new StringBuffer();
			if(stype.equals("1")) {

				sbStat.append(" select sid, sname, srank, bid, bname, brank,                                                                                                  ");
				sbStat.append("        sum(case when pcode in ('P01','P05') then 1 end)    obj1,                                                                             ");
				sbStat.append("        sum(case when pcode in ('P02','P06') then 1 end)    obj2,                                                                             ");
				sbStat.append("        sum(case when pcode in ('P03'      ) then 1 end)    obj3,                                                                             ");
				sbStat.append("        sum(case when pcode in ('P04','P07','P08') then 1 end)    obj4,                                                                             ");
				sbStat.append("        sum(case when measurement in ('계량'  ) then 1 end)    val1,                                                                          ");
				sbStat.append("        sum(case when measurement in ('비계량') then 1 end)    val2                                                                           ");
				sbStat.append(" from                                                                                                                                          ");
				sbStat.append("  (select c.name cname,t.id cid,t.contentid ccid,t.parentid cpid,t.rank crank                                                                  ");
				sbStat.append("  from tblcompany c, tblhierarchy t where t.treelevel=0 and t.year=? and t.contentid=c.id ) com,                                               ");
				sbStat.append("  (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank                                                                  ");
				sbStat.append("  from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id ) sbu,                                                   ");
				sbStat.append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank                                                                  ");
				sbStat.append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc,                                                   ");
				sbStat.append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank, c.code pcode                                                    ");
				sbStat.append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst,                                                  ");
				sbStat.append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank                                                                  ");
				sbStat.append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj,                                             ");
				sbStat.append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey, d.measurement      ");
				sbStat.append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d                                                                                        ");
				sbStat.append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea                                                          ");
				sbStat.append(" where  com.cid=sbu.spid and    sbu.sid=bsc.bpid (+) and    bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+)       ");
				sbStat.append(" group by sid, sname, srank, bid, bname, brank                                                                                                 ");
				sbStat.append(" order by sid, srank, bid, brank                                                                                                               ");

			} else {

				sbStat.append(" select sid, sname, srank, bid, bname, brank,                                                                                                  ");
				sbStat.append("        sum(case when pcode in ('P01','P05') then mweight end)    obj1,                                                                       ");
				sbStat.append("        sum(case when pcode in ('P02','P06') then mweight end)    obj2,                                                                       ");
				sbStat.append("        sum(case when pcode in ('P03'      ) then mweight end)    obj3,                                                                       ");
				sbStat.append("        sum(case when pcode in ('P04','P07','P08') then mweight end)    obj4,                                                                       ");
				sbStat.append("        sum(case when measurement in ('계량'  ) then mweight end)    val1,                                                                    ");
				sbStat.append("        sum(case when measurement in ('비계량') then mweight end)    val2                                                                     ");
				sbStat.append(" from                                                                                                                                          ");
				sbStat.append("  (select c.name cname,t.id cid,t.contentid ccid,t.parentid cpid,t.rank crank                                                                  ");
				sbStat.append("  from tblcompany c, tblhierarchy t where t.treelevel=0 and t.year=? and t.contentid=c.id ) com,                                               ");
				sbStat.append("  (select c.name sname,t.id sid,t.contentid scid,t.parentid spid,t.rank srank                                                                  ");
				sbStat.append("  from tblsbu c, tblhierarchy t where t.treelevel=1 and t.year=? and t.contentid=c.id ) sbu,                                                   ");
				sbStat.append("  (select c.name bname,t.id bid,t.contentid bcid,t.parentid bpid,t.rank brank                                                                  ");
				sbStat.append("  from tblbsc c, tblhierarchy t where t.treelevel=2 and t.year=? and t.contentid=c.id ) bsc,                                                   ");
				sbStat.append("  (select c.name pname,t.id pid,t.contentid pcid,t.parentid ppid,t.rank prank, c.code pcode                                                    ");
				sbStat.append("  from  tblpst c, tbltreescore t where t.treelevel=3 and t.year=? and t.contentid=c.id ) pst,                                                  ");
				sbStat.append("  (select c.name oname,t.id oid,t.contentid ocid,t.parentid opid,t.rank orank                                                                  ");
				sbStat.append("  from tblobjective c, tbltreescore t where t.treelevel=4 and t.year=? and t.contentid=c.id ) obj,                                             ");
				sbStat.append("  (select c.name mname,t.id mid,t.contentid mcid,t.parentid mpid,t.rank mrank, t.weight mweight, d.id, d.measureid, etlkey, d.measurement      ");
				sbStat.append("  from tblmeasure c, tbltreescore t, tblmeasuredefine d                                                                                        ");
				sbStat.append("  where t.treelevel=5 and t.year=? and t.contentid=d.id and   d.measureid = c.id) mea                                                          ");
				sbStat.append(" where  com.cid=sbu.spid and    sbu.sid=bsc.bpid (+) and    bsc.bid=pst.ppid (+) and    pst.pid=obj.opid (+) and    obj.oid=mea.mpid (+)       ");
				sbStat.append(" group by sid, sname, srank, bid, bname, brank                                                                                                 ");
				sbStat.append(" order by sid, srank, bid, brank                                                                                                               ");


			}

			Object[] pmStat = {year,year,year,year,year,year};

			if (rs!=null){rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(sbStat.toString(),pmStat);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null; }
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	public void getGubun(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if (dbobject==null) dbobject= new DBObject(conn.getConnection());

			String gMode = request.getParameter("mode");

			StringBuffer sbStat = new StringBuffer();

			sbStat.append("select SDIV_CD, DIV_NM FROM TZ_COMCODE WHERE USE_YN = 'Y' and LDIV_CD = ?");

			Object[] pmStat = {gMode};
			//System.out.println(sbStat.toString());

			if (rs!=null){rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(sbStat.toString(),pmStat);

			DataSet dsStat = new DataSet();
			dsStat.load(rs);

			request.setAttribute("dsStat",dsStat);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null; }
			if (conn != null) {conn.close(); conn = null;}
		}
	}
}
