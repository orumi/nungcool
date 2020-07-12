package com.nc.xml;

import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.tree.TreeNode;
import com.nc.tree.TreeUtil;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.ServerStatic;
import com.nc.util.Util;

public class MapUtil {
	public void getMapTree(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);

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
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
	         .append(" ON PST.PID=OBJ.OPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" ORDER BY CRANK,SRANK,SID,BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");
			
	         Object[] params = {year,year,year,year,year,year};
			
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
	
	public void getMapList(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String mapKind = request.getParameter("mapkind");			
			String year    = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			StringBuffer sb = new StringBuffer();
			if ("-1".equals(mapKind)){
				sb.append(" SELECT * FROM ")
					.append(" (SELECT ID,MAPNAME,BACKGROUND,ICONPROPS,MAPRANK,MAPDIVISION,MAPKIND FROM TBLMAP WHERE YEAR LIKE ?) MAP ")
					.append(" LEFT JOIN ")
					.append(" (SELECT T.ID TID,C.NAME, T.CONTENTID TCID FROM TBLHIERARCHY T, TBLBSC C WHERE T.CONTENTID=C.ID AND YEAR=? AND TREELEVEL=2) DIV ")
					.append(" ON MAP.MAPDIVISION=DIV.TID ")
					.append(" ORDER BY MAPRANK ");
				Object[] param = {year, year};
				rs = dbobject.executePreparedQuery(sb.toString(),param);
			} else {
				sb.append(" SELECT * FROM ")
				.append(" (SELECT ID,MAPNAME,BACKGROUND,ICONPROPS,MAPRANK,MAPDIVISION,MAPKIND FROM TBLMAP WHERE MAPKIND=? AND YEAR LIKE ?) MAP ")
				.append(" LEFT JOIN ")
				.append(" (SELECT T.ID TID,C.NAME, T.CONTENTID TCID FROM TBLHIERARCHY T, TBLBSC C WHERE T.CONTENTID=C.ID AND YEAR=? AND TREELEVEL=2) DIV ")
				.append(" ON MAP.MAPDIVISION=DIV.TID ")
				.append(" ORDER BY MAPRANK ");
				Object[] param = {mapKind,year,year};
				
				rs = dbobject.executePreparedQuery(sb.toString(),param);
				
			}
			
			if (rs!=null){
				DataSet ds = new DataSet();
				ds.load(rs);
				
				request.setAttribute("ds", ds);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	public void updateMap(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String mapId = request.getParameter("id");
			if (mapId == null) return;
			
			String mapName = request.getParameter("mapName");
			String image = request.getParameter("image");
			String order = request.getParameter("order");
			String width = request.getParameter("width");
			String height = request.getParameter("height");
			String shape = request.getParameter("shape");
			String showText = request.getParameter("showText");
			String showScore = request.getParameter("showScore");
			String mapKind = request.getParameter("mapKind");
			String division = request.getParameter("division");
			String mapYear  = request.getParameter("mapYear");
			
			String props = width+","+height+","+shape+","+showText+","+showScore;
			
			if ("0".equals(mapId)){
				String strC = "INSERT INTO TBLMAP (ID,MAPNAME,BACKGROUND,ICONPROPS,MAPRANK,MAPKIND,MAPDIVISION, YEAR) VALUES (?,?,?,?,?,?,?,?)";
				Object[] params = {(new Integer(dbobject.getNextId("TBLMAP"))),mapName,image,props,order,mapKind,division,mapYear};
				dbobject.executePreparedUpdate(strC,params);
			} else {
				String strU = "UPDATE TBLMAP SET MAPNAME=?,BACKGROUND=?,ICONPROPS=?,MAPRANK=?,MAPKIND=?,MAPDIVISION=? WHERE ID=?";
				Object[] params = {mapName,image,props,order,mapKind,division,mapId};
				dbobject.executePreparedUpdate(strU,params);
			}
			
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT ID,MAPNAME,BACKGROUND,ICONPROPS,MAPRANK,MAPKIND,MAPDIVISION,YEAR FROM TBLMAP WHERE YEAR = ? ORDER BY MAPRANK ");
			
			Object[] params = {mapYear};
			rs = dbobject.executePreparedQuery(sb.toString(),params);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds", ds);
			
			conn.commit();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	public void getMapIcon(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			String mapId = request.getParameter("mapId");
			
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT ID,MAPID,ICONSTYLE,ICONTEXT,X,Y,WIDTH,HEIGHT,TREEID,TREELEVEL,SHOWTEXT,SHOWSCORE FROM TBLMAPICON WHERE MAPID=? ");
			Object[] params = {mapId};
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			rs = dbobject.executePreparedQuery(sb.toString(),params);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds", ds);
			
			String strLine = "SELECT * FROM TBLMAPLINE WHERE MAPID = ?";
			Object[] pmLine = {mapId};
			
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(strLine,pmLine);
			
			DataSet dsLine = new DataSet();
			dsLine.load(rs);
			
			request.setAttribute("dsLine",dsLine);
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	public void deleteMap(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String year  = request.getParameter("year");
			String mapId = request.getParameter("mapId");
			if (mapId == null) return;
						
			String str = "DELETE FROM TBLMAP WHERE ID=?";
			Object[] params = {mapId};
			dbobject.executePreparedUpdate(str,params);
			
			String strIcon = "DELETE FROM TBLMAPICON WHERE MAPID=?";
			dbobject.executePreparedUpdate(strIcon,params);

			String strLine = "DELETE FROM TBLMAPLINE WHERE MAPID=?";
			dbobject.executePreparedUpdate(strLine,params);
			
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT ID,MAPNAME,BACKGROUND,ICONPROPS,MAPRANK FROM TBLMAP WHERE year = ? ORDER BY MAPRANK ");
			Object[] pmQ = {year};
			
			rs = dbobject.executePreparedQuery(sb.toString(), pmQ);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds", ds);
			
			conn.commit();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	public void updateIcon(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			String mapId = request.getParameter("mapId");
			String icons = request.getParameter("icons")!=null?request.getParameter("icons"):"";			
			String lines = request.getParameter("lines")!=null?request.getParameter("lines"):"";
			
			System.out.println("icons : " + icons);
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());			
			
			StringBuffer sbI = new StringBuffer();
			sbI.append("INSERT INTO TBLMAPICON (ID,MAPID,ICONSTYLE,ICONTEXT,X,Y,WIDTH,HEIGHT,TREELEVEL,TREEID,SHOWTEXT,SHOWSCORE) VALUES (?,?,?,substr(?,1,255),?, ?,?,?,?,?, ?,?)");
			Object[] paramI = new Object[12];
			paramI[1] = mapId;
			
			StringBuffer sbU = new StringBuffer();
			sbU.append("UPDATE TBLMAPICON SET ICONSTYLE=?,ICONTEXT=substr(?,1,250),X=?,Y=?,WIDTH=?,HEIGHT=?,TREELEVEL=?,TREEID=?,SHOWTEXT=?,SHOWSCORE=?  WHERE ID=? AND MAPID=? ");
			Object[] paramU = new Object[12];
			paramU[11] = mapId;
			
			String[] str = icons.split(ServerStatic.ROW_DELIMITER);
			ArrayList a = new ArrayList();
			for (int i = 0; i < str.length; i++) {
				if (!str[i].equals("")){
					String[] prop = str[i].split(ServerStatic.COL_DELIMITER);
					
					//Util.setTestEncode(prop[2]);
					
					if (prop[11].equals("new")) {
						paramI[0] = String.valueOf(dbobject.getNextIconId(mapId));
						paramI[2] = prop[1]; //style
						paramI[3] = Util.getEncode(prop[2]); //text
						paramI[4] = prop[3];  //x
						paramI[5] = prop[4];  // y
						paramI[6] = prop[5];  //width
						paramI[7] = prop[6];  //height
						paramI[8] = prop[10];  //treelevel
						paramI[9] = prop[9];  //treeid
						paramI[10] = prop[7]!=null?("null".equals(prop[7])?"0":prop[7]):"0";  //showtext
						paramI[11] = prop[8]!=null?("null".equals(prop[8])?"0":prop[8]):"0";  //showscore
						dbobject.executePreparedQuery(sbI.toString(),paramI);
						a.add(paramI[0]);
					} else {
						paramU[0] = prop[1]; //style;
						paramU[1] = Util.getEncode(prop[2]); //text;
						paramU[2] = prop[3]; //x;
						paramU[3] = prop[4]; //y;
						paramU[4] = prop[5]; //width;
						paramU[5] = prop[6]; //height;
						paramU[6] = prop[10]; //treelevel;
						paramU[7] = prop[9]; //treeid;
						paramU[8] = prop[7]!=null?("null".equals(prop[7])?"0":prop[7]):"0"; //showtext;
						paramU[9] = prop[8]!=null?("null".equals(prop[8])?"0":prop[8]):"0"; //showscore;
						paramU[10] = prop[0]; //id;
						dbobject.executePreparedQuery(sbU.toString(),paramU);
						a.add(paramU[10]);
					}
				}
			}
			
			String aId = "";
			for (int j = 0; j < a.size(); j++) {
				if (j==0) aId = (String)a.get(j);
				else aId += ","+(String)a.get(j);
			}
			
			String strD = "DELETE FROM TBLMAPICON WHERE MAPID=? AND ID NOT IN ("+aId+")";
			if (a.size()==0) strD = "DELETE FROM TBLMAPICON WHERE MAPID=?";
			dbobject.executePreparedUpdate(strD,new Object[]{mapId});

			String strLD = "DELETE FROM TBLMAPLINE WHERE MAPID=?";
			Object[] pmLD = {mapId};
			
			dbobject.executePreparedQuery(strLD,pmLD);
			
			String strLI = "INSERT INTO TBLMAPLINE (MAPID,X,Y,WIDTH,HEIGHT,  CURVEX,CURVEY,HEADERX,HEADERY) VALUES (?,?,?,?,?, ?,?,?,?)";
			Object[] pmLI = {mapId,null,null,null,null,null,null,null,null};
			
			String[] line = lines.split(ServerStatic.ROW_DELIMITER);
			for (int i = 0; i < line.length; i++) {
				if (!"".equals(line[i])){
					String[] prop = line[i].split(ServerStatic.COL_DELIMITER);
					pmLI[1]=prop[1];  // x;
					pmLI[2]=prop[2];  // y;
					pmLI[3]=prop[5];  // width;
					pmLI[4]=prop[6];  // height;
					pmLI[5]=prop[3];  // cur x;
					pmLI[6]=prop[4];  // cur y;
					pmLI[7]=prop[7];  // header x;
					pmLI[8]=prop[8];  // header y;
					
					dbobject.executePreparedQuery(strLI,pmLI);
				}
			}
			
			System.out.println("MapIcon저장");
			
			conn.commit();

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	public void getMapIconScore(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String mapId = request.getParameter("mapId");
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			
			String strQry = "SELECT MAPKIND,MAPDIVISION FROM TBLMAP WHERE ID=?";
			Object[] params = {mapId};
			
			rs = dbobject.executePreparedQuery(strQry,params);
			int mapKind = -1; String division=null;
			while (rs.next()){
				mapKind  = rs.getInt("MAPKIND");
				division = rs.getString("MAPDIVISION");
			}
			
			ArrayList iconList = new ArrayList();
			if (mapKind==1){

				StringBuffer sb = new StringBuffer();
				sb.append(" SELECT ID,MAPID,ICONSTYLE,ICONTEXT,X,Y,WIDTH,HEIGHT,TREEID,TREELEVEL,SHOWTEXT,SHOWSCORE FROM TBLMAPICON WHERE MAPID=? ");
				rs = dbobject.executePreparedQuery(sb.toString(),params);
				
				while (rs.next()){
					Icon icon = new Icon();
					icon.id        = rs.getLong("ID");
					icon.mapId     = rs.getLong("MAPID");
					icon.style     = rs.getString("ICONSTYLE");
					icon.text      = rs.getString("ICONTEXT");
					icon.x         = rs.getInt("X");
					icon.y         = rs.getInt("Y");
					icon.width     = rs.getInt("WIDTH");
					icon.height    = rs.getInt("HEIGHT");
					icon.treeId    = rs.getInt("TREEID");
					icon.treeLevel = rs.getInt("TREELEVEL");
					icon.showText  = rs.getInt("SHOWTEXT");
					icon.showScore = rs.getInt("SHOWSCORE");
					
					iconList.add(icon);					
				}
				
				if (iconList.size()>0){
					TreeUtil treeutil = new TreeUtil(conn.getConnection());

					TreeNode node = treeutil.getTreeRoot(year,division);
					TreeNode tmp = null;
					for (int i = 0; i < iconList.size(); i++) {
						Icon icn = (Icon)iconList.get(i);
						tmp = node.getNodebyId(icn.treeId,icn.treeLevel);
						if (tmp!=null){
							icn.score = tmp.score;
						}
					}
				}
				
				request.setAttribute("iconList", iconList);
			} else if (mapKind==0){
				StringBuffer sb = new StringBuffer();

				sb.append(" SELECT ID,MAPID,ICONSTYLE,ICONTEXT,X,Y,WIDTH,HEIGHT,TREEID,TREELEVEL,SHOWTEXT,SHOWSCORE FROM TBLMAPICON WHERE MAPID=? ");
				rs = dbobject.executePreparedQuery(sb.toString(),params);
				
				while (rs.next()){
					Icon icon = new Icon();
					icon.id        = rs.getLong("ID");
					icon.mapId     = rs.getLong("MAPID");
					icon.style     = rs.getString("ICONSTYLE");
					icon.text      = rs.getString("ICONTEXT");
					icon.x         = rs.getInt("X");
					icon.y         = rs.getInt("Y");
					icon.width     = rs.getInt("WIDTH");
					icon.height    = rs.getInt("HEIGHT");
					icon.treeId    = rs.getInt("TREEID");
					icon.treeLevel = rs.getInt("TREELEVEL");
					icon.showText  = rs.getInt("SHOWTEXT");
					icon.showScore = rs.getInt("SHOWSCORE");
					
					iconList.add(icon);
					
				}
				
				if (iconList.size()>0){
					TreeUtil treeutil = new TreeUtil(conn.getConnection());
					
					TreeNode node = treeutil.getTreeRootAll(year);
					
					TreeNode tmp = null;
					for (int i = 0; i < iconList.size(); i++) {
						Icon icn = (Icon)iconList.get(i);
						tmp = node.getNodebyId(icn.treeId,icn.treeLevel);
						if (tmp!=null){
							icn.score = tmp.score;
						}
					}
				}
				
				request.setAttribute("iconList", iconList);
				
			}
			
			String strLine = "SELECT * FROM TBLMAPLINE WHERE MAPID=?";
			Object[] pmLine = {mapId};
			
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strLine,pmLine);
			
			DataSet dsLine = new DataSet(rs);
			
			request.setAttribute("dsLine",dsLine);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	
	
	public void getMapIconScoreJunSa(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String mapId = request.getParameter("mapId");
			String year  = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			String ym    = request.getParameter("ym")!=null?request.getParameter("ym"):Util.getToDay().substring(0,4);			
			
			StringBuffer sb = new StringBuffer();
			
			System.out.println("전사 전략맵(본부평균)");
			
			// 
			// Hard Coding 이 필요함 : 본부(단)/단본부에 속한 하위조직을 가져오기 위하여 tblsbu의 본부그룹의 ID를 설정함.
			//
			
			sb.append(" select id, mapid, iconstyle style, icontext text, x, y, width, height, showText, showScore, treeid,                          ");
			sb.append("        treelevel, b.oid, b.ocid, b.oname, nvl(oscore,-1) score                                                                       ");
			sb.append(" from   tblmapicon a,                                                                                                         ");
			sb.append("         (                                                                                                                    ");
			sb.append("         select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel, t.rank orank,t.weight oweight,c.name oname      ");
			sb.append("         from   tbltreescore t,tblobjective c                                                                                 ");
			sb.append("         where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                                             ");
			sb.append("         ) b,                                                                                                                 ");
			sb.append("         (                                                                                                                    ");
			sb.append("         SELECT  ocid, oname,                                                                                                 ");
			sb.append("                 round(avg(oscore),2) oscore                                                                                  ");
			sb.append("         FROM    (                                                                                                            ");
			sb.append("         SELECT  cid, ccid, clevel, crank, cname,  cweight,                                                                   ");
			sb.append("                 sid, scid, slevel, srank, sname,  sum(mweight) over (partition by cid, sid               )         sweight , ");
			sb.append("                 bid, bcid, blevel, brank, bname,  sum(mweight) over (partition by cid, sid, bid          )         bweight , ");
			sb.append("                 sum(case when mscore>0 and mweight>0 then mweight end) over(partition by bid)                      bcweight, ");
			sb.append("                 sum(mgscore) over(partition by bid)                                                                bgscore , ");
			sb.append("                 round(sum(mcscore) over(partition by bid)/                                                                   ");
			sb.append("                       sum(case when mscore > 0 and mweight>0 then mweight end) over(partition by bid),2)           bscore  , ");
			sb.append("                 pid, pcid, plevel, prank, pname,  sum(mweight) over (partition by cid, sid, bid, pid     )         pweight , ");
			sb.append("                 sum(case when mscore>0 and mweight>0 then mweight end) over(partition by bid,pid)                  pcweight, ");
			sb.append("                 round(sum(mcscore) over(partition by bid,pid)/                                                               ");
			sb.append("                       sum(case when mscore > 0 and mweight>0 then mweight end) over(partition by bid,pid),2)       pscore  , ");
			sb.append("                 oid, ocid, olevel, orank, oname,  sum(mweight) over (partition by cid, sid, bid, pid, oid)         oweight , ");
			sb.append("                 sum(case when mscore>0 and mweight>0 then mweight end) over(partition by bid,pid,oid)              ocweight, ");
			sb.append("                 round(sum(mcscore) over(partition by bid,pid,oid)/                                                           ");
			sb.append("                       sum(case when mscore > 0 and mweight>0 then mweight end) over(partition by bid,pid,oid),2)   oscore  , ");
			sb.append("                 mid, mcid, mlevel, mrank, mname,  mweight, measid,                                                           ");
			sb.append("                 ym,  mm, mactual, mgrade, mscore, mgscore, mcscore                                                           ");
			sb.append("         FROM                                                                                                                 ");
			sb.append("                (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel,                                         ");
			sb.append("                        t.rank crank,t.weight cweight,c.name cname                                                            ");
			sb.append("                 from   tblhierarchy t,tblcompany c                                                                           ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=0 and t.year = ?                                                    ");
			sb.append("                ) com,                                                                                                        ");
			sb.append("                (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel,                                         ");
			sb.append("                        t.rank srank,t.weight sweight,c.name sname                                                            ");
			sb.append("                 from   tblhierarchy t,tblsbu c                                                                               ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=1 and t.year =? and t.contentid in ('2','16')                       ");  // 본부단 
			sb.append("                ) sbu,                                                                                                        ");
			sb.append("                (select t.id bid,t.parentid bpid,t.contentid bcid,t.treelevel blevel,                                         ");
			sb.append("                        t.rank brank,t.weight bweight,c.name bname                                                            ");
			sb.append("                 from   tblhierarchy t,tblbsc c                                                                               ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=2 and t.year =?                                                     ");
			sb.append("                ) bsc,                                                                                                        ");
			sb.append("                (select t.id pid,t.parentid ppid,t.contentid pcid,t.treelevel plevel,                                         ");
			sb.append("                        t.rank prank,t.weight pweight,c.name pname                                                            ");
			sb.append("                 from   tbltreescore t,tblpst c                                                                               ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=3 and t.year =?                                                     ");
			sb.append("                ) pst  ,                                                                                                      ");
			sb.append("                (select t.id oid,t.parentid opid,t.contentid ocid,t.treelevel olevel,                                         ");
			sb.append("                        t.rank orank,t.weight oweight,c.name oname                                                            ");
			sb.append("                 from   tbltreescore t,tblobjective c                                                                         ");
			sb.append("                 where  t.contentid=c.id  and t.treelevel=4 and t.year =?                                                     ");
			sb.append("                ) obj ,                                                                                                       ");
			sb.append("                (select t.id mid,t.parentid mpid,t.contentid mcid,t.treelevel mlevel,                                         ");
			sb.append("                        t.rank mrank , t.weight     mweight, c.name mname,                                                    ");
			sb.append("                        d.measureid  measid,                                                                                  ");
			sb.append("                        d.measurement, d.frequency, d.trend, d.etlkey,                                                        ");
			sb.append("                        d.unit       ,                                                                                        ");
			sb.append("                        d.planned,d.plannedbase, d.base, d.baselimit, d.limit,                                                ");
			sb.append("                        substr(s.strdate,1,6) ym, substr(s.strdate,5,2) mm,                                                   ");
			sb.append("                        round(s.actual,2) mactual, s.grade  mgrade,                                                           ");
			sb.append("                        s.score mscore,  s.grade_score ,                                                                      ");
			sb.append("                        s.score * t.weight/100  mgscore, s.score * t.weight  mcscore                                          ");
			sb.append("                 from    tbltreescore    t, tblmeasure c,  tblmeasuredefine d,                                                ");
			sb.append("                         tblmeasurescore s, tblmeasuredetail ds                                                               ");
			sb.append("                 where  t.contentid=d.id  and t.treelevel=5 and t.year =?                                                     ");
			sb.append("                 and    d.measureid=c.id                                                                                      ");
			sb.append("                 and    d.id         =s.measureid  (+)                                                                        ");
			sb.append("                 and    s.measureid  =ds.measureid (+)                                                                        ");
			sb.append("                 and    substr(s.strdate,1,6) =substr(ds.strdate(+),1,6)                                                      ");
			sb.append("                 and    s.strdate(+) like ?||'%'                                                                              ");
			sb.append("                ) mea                                                                                                         ");
			sb.append("         where  cid = spid (+)                                                                                                ");
			sb.append("         and    sid = bpid (+)                                                                                                ");
			sb.append("         and    bid = ppid (+)                                                                                                ");
			sb.append("         and    pid = opid (+)                                                                                                ");
			sb.append("         and    oid = mpid (+)                                                                                                ");
			sb.append("         order by crank, srank, brank, prank, orank, mrank                                                                    ");
			sb.append("         )                                                                                                                    ");
			sb.append("         where mm in ('03','06','09','12')                                                                                    ");
			sb.append("         group by ocid, oname                                                                                                 ");
			sb.append("         ) obj                                                                                                                ");
			sb.append(" where  mapid  = ?                                                                                                          ");
			sb.append(" and    treeid = b.oid                                                                                                        ");
			sb.append(" and    b.ocid = obj.ocid (+)                                                                                                 ");

			Object[] params = {year,year,year,year,year,year,year,ym, mapId};

			if (rs!=null){rs.close(); rs=null;}			
			rs = dbobject.executePreparedQuery(sb.toString(),params);

			DataSet dsIcon = new DataSet(rs);			
			request.setAttribute("dsIcon",dsIcon);
			
			
			String strLine = "SELECT * FROM TBLMAPLINE WHERE MAPID=?";
			Object[] pmLine = {mapId};
			
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(strLine,pmLine);
			
			DataSet dsLine = new DataSet(rs);			
			request.setAttribute("dsLine",dsLine);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}		
	
	public void getCylinderScore (HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());
			
			String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
			System.out.println(year);
			TreeUtil treeutil = new TreeUtil(conn.getConnection());
			
			TreeNode node = treeutil.getCylinderScore(year);
					
			request.setAttribute("node", node);
			

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}		
}
