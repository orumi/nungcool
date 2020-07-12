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

public class MeasUtil {
	
	public void getMeasTree(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;   
		
		try {  			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			
			// 조회조건 
			String year  = request.getParameter("year");
			String sbuId = request.getParameter("sbuid");   // 평가그룹
			String bscId = request.getParameter("bscid");	// 평가조직
			
			if (bscId==null) return;
			
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT  cid, ccid, clevel, crank, cname,  cweight,                                                                                ");
			sb.append("         sid, scid, slevel, srank, sname,  sweight,                                                                                ");
			sb.append("         bid, bcid, blevel, brank, bname,  sum(mweight) over (partition by cid, sid, bid          ) bweight,                       ");
			sb.append("         pid, pcid, plevel, prank, pname,  sum(mweight) over (partition by cid, sid, bid, pid     ) pweight,                       ");
			sb.append("         oid, ocid, olevel, orank, oname,  sum(mweight) over (partition by cid, sid, bid, pid, oid) oweight,                       ");
			sb.append("         mid, mcid, mlevel, mrank, mname,  mweight,                                                                                ");
			sb.append("         measureid, frequency                                                                                                      ");
			sb.append(" FROM                                                                                                                              ");
			sb.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname           ");
			sb.append("         from   tblhierarchy t,tblcompany c                                                                                        ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year =?                                                                  ");
			sb.append("        ) com,                                                                                                                     ");
			sb.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname           ");
			sb.append("         from   tblhierarchy t,tblsbu c                                                                                            ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year =? and t.id like ?                                                  ");
			sb.append("        ) sbu,                                                                                                                     ");
			sb.append("        (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel, t.rank brank,t.weight bweight,c.name bname           ");
			sb.append("         from   tblhierarchy t,tblbsc c                                                                                            ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=2 and t.year =? and t.id like ?                                                  ");
			sb.append("        ) bsc,                                                                                                                     ");
			sb.append("        (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel, t.rank prank,t.weight pweight,c.name pname           ");
			sb.append("         from   tbltreescore t,tblpst c                                                                                            ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                                                  ");
			sb.append("        ) pst  ,                                                                                                                   ");
			sb.append("        (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname           ");
			sb.append("         from   tbltreescore t,tblobjective c                                                                                      ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                                                  ");
			sb.append("        ) obj ,                                                                                                                    ");
			sb.append("        (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel, t.rank mrank, t.weight mweight, c.name mname,        ");
			sb.append("                c.id mcd,d.measureid  , d.measurement, d.frequency, d.trend, d.etlkey,                                             ");
			sb.append("                d.unit       ,                                                                                                     ");
			sb.append("                d.planned, d.base, d.limit                                                                                         ");
			sb.append("         from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d                                                              ");
			sb.append("         where  t.contentid=d.id  and t.treelevel=5 and t.year =? and d.measureid=c.id                                             ");
			sb.append("        ) mea                                                                                                                      ");
			sb.append(" where  cid = spid (+)                                                                                                             ");
			sb.append(" and    sid = bpid (+)                                                                                                             ");
			sb.append(" and    bid = ppid (+)                                                                                                             ");
			sb.append(" and    pid = opid (+)                                                                                                             ");
			sb.append(" and    oid = mpid (+)                                                                                                             ");
			sb.append(" order by crank, srank, brank, prank, orank, mrank                                                                                 ");

			Object[] paramS = {year, year,sbuId, year,bscId, year,year,year};
			
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

}
