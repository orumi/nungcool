package com.nc.task;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.tree.TreeNode;
import com.nc.tree.TreeUtil;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.xml.AnalyObjective;
import com.nc.util.*;

public class TaskInitiative {
	public void setTaskObjective(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		TreeUtil treeutil = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			String schDate = request.getParameter("schDate");
			if (schDate==null) return;
			
			String year = schDate.substring(0,4);
			String qtr = schDate.substring(4,5);
			
			String month = "";
			if ("1".equals(qtr)){
				month="3";
			} else if ("2".equals(qtr)) {
				month="6";
			} else if ("3".equals(qtr)) {
				month="9";
			} else if ("4".equals(qtr)) {
				month="12";
			}
			int intM = Integer.parseInt(month);
			String bscId = request.getParameter("bscId");
			String sbuId = request.getParameter("sbuId");
			
			treeutil = new TreeUtil(conn.getConnection());
			
			TreeNode treenode = treeutil.getTreeRoot(year,bscId);
			ArrayList list = new ArrayList();
			
			for (int i = 0; i < treenode.childs.size(); i++) {
				TreeNode pst = (TreeNode)treenode.childs.get(i);
				for (int j = 0; j < pst.childs.size(); j++) {
					TreeNode obj = (TreeNode)pst.childs.get(j);
					for (int k = 0; k < obj.childs.size(); k++) {
						TreeNode mea = (TreeNode)obj.childs.get(k);
						AnalyObjective objective = new AnalyObjective();
						objective.ocId = mea.cid;
						objective.otId = mea.id;
						objective.bname = treenode.name;
						objective.pname = pst.name;
						objective.mname = mea.name;
						objective.oname = obj.name;
						objective.score = mea.score[intM-1];
						
						list.add(objective);
					}
				}
			}
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			StringBuffer sbR = new StringBuffer();
			sbR.append("SELECT * FROM (	")		 
				.append(" SELECT * FROM TBLINITIATIVE WHERE OBJID IN (	")
				.append(" 	SELECT MCID FROM	")
				.append(" 	(SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,C.NAME BNAME	") 
				.append(" 	FROM TBLBSC C, TBLHIERARCHY T WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.ID=?	")
				.append(" 	) BSC	")
				.append(" 	LEFT JOIN	")
				.append(" 	(SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,C.NAME PNAME	")
				.append(" 	FROM TBLPST C, TBLTREESCORE T WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 	")
				.append(" 	) PST	")
				.append(" 	ON BSC.BID=PST.PPID	")
				.append(" 	LEFT JOIN	")
				.append(" 	(SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,C.NAME ONAME	")
				.append(" 	FROM TBLOBJECTIVE C, TBLTREESCORE T WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4	")
				.append(" 	) OBJ	")
				.append(" 	ON PST.PID=OBJ.OPID	")
				.append(" 	LEFT JOIN ")
		        .append(" 	(SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,D.UNIT  ")
		        .append(" 	FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ")
		        .append(" 	) MEA ")
		        .append(" ON OBJ.OID=MEA.MPID ")
				.append("  )	")
				.append(" ) INI	")
				.append(" LEFT JOIN	")
				.append(" (SELECT DETAILID DID,PROJECTID PID,EXECWORK FROM TBLSTRATPROJECTDETAIL ) DTL	")
				.append(" ON INI.DETAILID=DTL.DID	")
				.append(" LEFT JOIN	")
				.append(" (SELECT P.*,(SELECT TYPENAME FROM TBLSTRATTYPEINFO WHERE TYPEID=P.TYPEID) TYPENAME	")
				.append(" FROM TBLSTRATPROJECT P 	")
				.append(" ) PRJ	")
				.append(" ON DTL.PID=PRJ.ID ")
				.append(" LEFT JOIN ")
				.append(" ( SELECT ACHVID,DETAILID ADID,REALIZE FROM TBLSTRATACHVREGI WHERE YEAR=? AND QTR=? ) ACH ")
				.append(" ON INI.DETAILID=ACH.ADID ");
			
			Object[] pmR = {bscId,year,year,qtr};
			
			rs = dbobject.executePreparedQuery(sbR.toString(),pmR);
			
			while (rs.next()){
				AnalyObjective obj = getObjective(list, rs.getInt("OBJID"));
				if (obj!=null){
					obj.exec = (obj.exec!=null?obj.exec:"")+" ("+rs.getDouble("REALIZE")+") <strong><font  color='#003366'>" + rs.getString("EXECWORK")+"</font></strong> ["+rs.getString("NAME")+"] "+"<hr>";
				}
			}
			
			request.setAttribute("list",list);
			
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
	
	public void setDivision(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT ID,NAME,PARENTID FROM TBLBSC ORDER BY PARENTID DESC,ID ");
			rs = dbobject.executeQuery(sb.toString());
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);

			StringBuffer sbType = new StringBuffer();
			sbType.append("SELECT TYPEID,TYPENAME FROM TBLSTRATTYPEINFO");

			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executeQuery(sbType.toString());
			
			DataSet dsType = new DataSet();
			dsType.load(rs);
			
			request.setAttribute("dsType",dsType);
			
			StringBuffer sbProj = new StringBuffer();
			sbProj.append("SELECT PROJECTID,TYPEID,CONTENTID, ")
				.append(" (SELECT NAME FROM TBLSTRATPROJECT WHERE ID=CONTENTID) PNAME, ")
				.append(" FIELDID, (SELECT FIELDNAME FROM TBLSTRATFIELDINFO F WHERE F.FIELDID=P.FIELDID) FNAME ") 
				.append(" FROM TBLSTRATPROJECTINFO P ORDER BY PNAME");
			
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executeQuery(sbProj.toString());
			
			DataSet dsProj = new DataSet();
			dsProj.load(rs);
			
			request.setAttribute("dsProj",dsProj);
			
		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			System.out.println(this.toString()+" : "+se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			System.out.println(this.toString()+" : "+e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}
	}
	
	public void setObjective(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			String pBscId = request.getParameter("pBscId");
			String bscId = request.getParameter("bscId");
			
			if ((bscId!=null)&&(pBscId!=null)) {
			
				if(dbobject==null) dbobject = new DBObject(conn.getConnection());
				
				
				
				StringBuffer sb = new StringBuffer();
				sb.append(" SELECT * FROM ( ")
					.append(" SELECT ID,NAME,? DID FROM TBLOBJECTIVE WHERE ID IN ( ")
					.append(" SELECT OCID FROM  ")
					.append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME ") 
					.append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.CONTENTID=? ) BSC ")
					.append(" LEFT JOIN ")
					.append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME ") 
					.append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 ) PST ")
					.append(" ON BSC.BID=PST.PPID ")
					.append(" LEFT JOIN ")
					.append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME ") 
					.append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 ) OBJ ")
					.append(" ON PST.PID=OBJ.OPID ) ")
					.append(" ) OBJ ")
					.append(" LEFT JOIN ")
					.append(" (SELECT I.BSCID,I.OBJID,I.DETAILID,I.PROJECTID,D.EXECWORK,D.NAME PNAME,D.TNAME FROM ( ")
					.append(" SELECT I.BSCID,I.OBJID,I.DETAILID,I.PROJECTID FROM TBLINITIATIVE I ")
					.append(" ) I LEFT JOIN ")
					.append(" (SELECT D.PROJECTID,D.DETAILID, D.EXECWORK,C.NAME,(SELECT TYPENAME FROM TBLSTRATTYPEINFO T WHERE T.TYPEID=P.TYPEID) TNAME ")
					.append(" FROM TBLSTRATPROJECTDETAIL D, TBLSTRATPROJECTINFO P,TBLSTRATPROJECT C  ")
					.append(" WHERE D.PROJECTID=P.PROJECTID AND P.CONTENTID=C.ID ) D ")
					.append(" ON I.PROJECTID=D.PROJECTID AND I.DETAILID=D.DETAILID ) INI ")
					.append(" ON OBJ.ID=INI.OBJID AND INI.BSCID=? ");
				
				String did = "-1".equals(bscId)?pBscId:bscId;
				Object[] pm = {did,did, did};
				rs = dbobject.executePreparedQuery(sb.toString(),pm);
				
				DataSet ds = new DataSet();
				ds.load(rs);
				
				request.setAttribute("ds",ds);
			}
			
		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			System.out.println(this.toString()+" : "+se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			System.out.println(this.toString()+" : "+e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}	
	}
	
	public void setTaskDetail(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getPrevMonth(null).substring(0,4);;
			String projectId = request.getParameter("projectId")!=null?request.getParameter("projectId"):"";
			String detailId = request.getParameter("detailId")!=null?request.getParameter("detailId"):"";
			String bscId = request.getParameter("bscId")!=null?request.getParameter("bscId"):"";
			
			if ("U".equals(mode)){
				String upProjectId = request.getParameter("projectId")!=null?request.getParameter("projectId"):"";
				String upDetailId = request.getParameter("detailId")!=null?request.getParameter("detailId"):"";
				String[] val = request.getParameterValues("chkObj");
				
				String strD= "DELETE FROM TBLINITIATIVE WHERE PROJECTID=? AND DETAILID=?";
				Object[] pmD = {upProjectId,upDetailId};
				dbobject.executePreparedQuery(strD,pmD);
				
				String strI = "INSERT INTO TBLINITIATIVE (BSCID, OBJID,PROJECTID,DETAILID) VALUES (0,?,?,?)";
				Object[] pmU = {null,upProjectId,upDetailId};
				
				for (int i = 0; i < val.length; i++) {
					if ((val[i]!=null)&&(!"".equals(val[i]))){
						pmU[0] = val[i];
						
						dbobject.executePreparedQuery(strI,pmU);
					}
				}
				
				conn.commit();
			}
			
			StringBuffer str = new StringBuffer();
			str.append("SELECT * FROM ( ")
				.append(" SELECT P.*,(SELECT TYPENAME FROM TBLSTRATTYPEINFO WHERE TYPEID=P.TYPEID) TYPENAME ")
				.append(" FROM TBLSTRATPROJECT P WHERE ID=? ")
				.append(" ) PRJ ")
				.append(" LEFT JOIN ")
				.append(" (SELECT * FROM TBLSTRATPROJECTDETAIL WHERE DETAILID=? ) DTL ")
				.append(" ON PRJ.ID = DTL.PROJECTID ");
			
			Object[] pmT = {projectId, detailId};
			if(rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(str.toString(),pmT);
			
			DataSet dsTask = new DataSet();
			dsTask.load(rs);
			
			request.setAttribute("dsTask",dsTask);
			
			
			StringBuffer sb = new StringBuffer();
			Object[] params = null;
						
			sb.append(" SELECT * FROM  ")
	          .append("   (SELECT T.ID BID, C.NAME BNAME  ")
	          .append("   FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? AND T.ID=? ) BSC ")
	          .append("    LEFT JOIN ")
	          .append("  (SELECT T.ID PID,T.PARENTID PPID,C.NAME PNAME  ")
	          .append("   FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
	          .append("    ON BSC.BID=PST.PPID ")
	          .append("    LEFT JOIN ")
	          .append("  (SELECT T.ID OID,T.PARENTID OPID,C.NAME ONAME  ")
	          .append("   FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
	          .append("    ON PST.PID=OBJ.OPID ")
	          .append("    LEFT JOIN ")
	          .append("  (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,C.NAME MNAME ")
	          .append("   FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C  WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA ")
	          .append("    ON OBJ.OID=MEA.MPID ")
	          .append("     LEFT JOIN ")
	          .append("   (SELECT OBJID,DETAILID DID,PROJECTID PID FROM TBLINITIATIVE WHERE PROJECTID=? AND DETAILID=?) INI ")
	          .append("     ON MEA.MCID=INI.OBJID ")
			  .append(" ORDER BY MNAME ");
			
			params = new Object[] {year,bscId,year,year,year,projectId,detailId};
			
			if(rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(sb.toString(),params);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			System.out.println(this.toString()+" : "+se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			System.out.println(this.toString()+" : "+e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}
	}
	
	public void setInitiative(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			if(dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			String year = request.getParameter("year");
			String bscId = request.getParameter("bscId");
			String objId = request.getParameter("objId");
			
			if(!year.equals("")){
				StringBuffer sb = new StringBuffer();
				sb.append("SELECT * FROM ( ")
				  .append(" SELECT P.*,(SELECT TYPENAME FROM TBLSTRATTYPEINFO WHERE TYPEID=P.TYPEID) TYPENAME ")
				  .append(" FROM TBLSTRATPROJECT P ")
				  .append(" ) PRJ ")
				  .append(" LEFT JOIN ")
				  .append(" (SELECT * FROM TBLSTRATPROJECTDETAIL ) DTL ")
				  .append(" ON PRJ.ID = DTL.PROJECTID ")
				  .append(" LEFT JOIN ")
				  .append(" (SELECT OBJID,DETAILID DID,PROJECTID PID, ")
				  .append(" (SELECT MNAME FROM ")
				  .append("  (SELECT MCID,MNAME FROM ")
				  .append("   (SELECT T.ID BID, C.NAME BNAME  ")
		          .append("    FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? AND T.ID=? ) BSC ")
		          .append("     LEFT JOIN ")
		          .append("    (SELECT T.ID PID,T.PARENTID PPID,C.NAME PNAME  ")
		          .append("    FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
		          .append("     ON BSC.BID=PST.PPID ")
		          .append("     LEFT JOIN ")
		          .append("    (SELECT T.ID OID,T.PARENTID OPID,C.NAME ONAME  ")
		          .append("    FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
		          .append("     ON PST.PID=OBJ.OPID ")
		          .append("     LEFT JOIN ")
		          .append("    (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,C.NAME MNAME ")
		          .append("     FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C  WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA ")
		          .append("      ON OBJ.OID=MEA.MPID ")
				  .append("  ) MEAS WHERE MCID=OBJID ) ONAME ")
				  .append(" FROM TBLINITIATIVE) INT ")
				  .append(" ON DTL.DETAILID=INT.DID ")
				  .append(" ORDER BY TYPEID,NAME,EXECWORK,OBJID ");
				Object[] param = {year,bscId,year,year,year};
				
				rs = dbobject.executePreparedQuery(sb.toString(), param);
				
				DataSet ds = new DataSet();
				ds.load(rs);
				
				request.setAttribute("ds",ds);
			}
			
		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			System.out.println(this.toString()+" : "+se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			System.out.println(this.toString()+" : "+e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}	
	}
	
}
