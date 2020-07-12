package com.nc.eval;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.Util;

public class EvalAdminUtil {
	public void setAdminInit(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			String sn = request.getParameter("sn")!=null?request.getParameter("sn"):"";
			if ("".equals(sn)) throw new Exception("sevice is nothing");
			
			conn.createStatement(false);
			
			String strDate = request.getParameter("strDate")!=null?request.getParameter("strDate"):Util.getToDay();
			String year = strDate.substring(0,4);
			String semi = Util.getSemi(strDate.substring(0,6));
			
			StringBuffer sb1 = new StringBuffer();
			StringBuffer sb2 = new StringBuffer();
			Object[] pm1 = null;
			Object[] pm2 = null;
			
			sb1.append("select g.grpid,g.name from tblevalgroup g where g.effectivedate=? ");
			pm1 = new Object[]{semi};
			sb2.append("select t.grpid, t.sbuid, s.name from tblevalgroupdetail t, tblsbu s where t.sbuid=s.id ") 
				.append("and t.grpid in ")
				.append("(select g.grpid from tblevalgroup g where g.effectivedate=?)");
			pm2 = new Object[]{semi};

			
			if (dbobject== null) dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb1.toString(),pm1);
			DataSet grp = new DataSet();
			grp.load(rs);
			
			request.setAttribute("grp",grp);
			
			if(rs!=null){rs.close();rs=null;}
			rs = dbobject.executePreparedQuery(sb2.toString(),pm2);
			DataSet dtl = new DataSet();
			dtl.load(rs);
			
			request.setAttribute("dtl",dtl);
		} catch (Exception e) {
			System.out.println("EvalAdminUtil setAdminInit : "+e);
		} finally {
			if (rs!=null){try{rs.close();rs=null;} catch (Exception se){} }
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}
	}
	
	public void setAdminMeasure(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try{
			String sn = request.getParameter("sn")!=null?request.getParameter("sn"):"";
			if ("".equals(sn)) throw new Exception("sn parameter is nothing");
			conn.createStatement(false);
			
			String strDate = request.getParameter("strDate");
			String year = (strDate!=null)?strDate.substring(0,4):"";
			String month = (strDate!=null)?strDate.substring(4,6):"";

			String comId = request.getParameter("comId");
			String sbuId = request.getParameter("sbuId");
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			
			if (dbobject == null) dbobject = new DBObject(conn.getConnection());
			
			if("C".equals(mode)){
				String[] measureId = request.getParameterValues("measureId");
				String[] evalWeight = request.getParameterValues("evalWeight");
				String[] mname = request.getParameterValues("mname");
				String[] pname = request.getParameterValues("pname");
				String[] bscActual = request.getParameterValues("bscActual");
				String[] bscScore = request.getParameterValues("bscScore");
				
				String param = request.getParameter("param");
				String[] p = param.split("\\|");

				StringBuffer strD = new StringBuffer();
				
				strD.append("DELETE FROM TBLEVALMEASURE WHERE EFFECTIVEDATE=? AND MEASUREID IN ( ")
					.append(" SELECT MEA.MCID FROM ")
					.append(" (SELECT H.ID SID,H.PARENTID SPID,H.CONTENTID SCID,H.TREELEVEL SLEVEL,H.WEIGHT SWEIGHT,H.RANK SRANK,C.NAME SNAME ")
					.append(" FROM HIERARCHYVIEW H, TBLSBU C WHERE H.CONTENTID=C.ID AND H.TREELEVEL=1 AND H.YYYY=? AND H.CONTENTID=?) SBU ")
					.append(" LEFT JOIN ")
					.append(" (SELECT H.ID BID,H.PARENTID BPID,H.CONTENTID BCID,H.TREELEVEL BLEVEL,H.WEIGHT BWEIGHT,H.RANK BRANK,TRIM(C.NAME) BNAME ")
					.append(" FROM HIERARCHYVIEW H, TBLBSC C WHERE H.CONTENTID=C.ID AND H.TREELEVEL=2 AND H.YYYY=? ) BSC ")
					.append(" ON SBU.SID=BSC.BPID ")
					.append(" LEFT JOIN ")
					.append(" (SELECT H.ID PID,H.PARENTID PPID,H.CONTENTID PCID,H.TREELEVEL PLEVEL,H.WEIGHT PWEIGHT,H.RANK PRANK,C.NAME PNAME ")
					.append(" FROM TREESCOREVIEW H, TBLPST C WHERE H.CONTENTID=C.ID AND H.TREELEVEL=3 AND H.YYYY=? ) PST ")
					.append(" ON BSC.BID=PST.PPID ")
					.append(" LEFT JOIN ")
					.append(" (SELECT H.ID OID,H.PARENTID OPID,H.CONTENTID OCID,H.TREELEVEL OLEVEL,H.WEIGHT OWEIGHT,H.RANK ORANK,C.NAME ONAME ")
					.append(" FROM TREESCOREVIEW H, TBLOBJECTIVE C WHERE H.CONTENTID=C.ID AND H.TREELEVEL=4 AND H.YYYY=? ) OBJ ")
					.append(" ON PST.PID=OBJ.OPID ")
					.append(" LEFT JOIN ")
					.append(" (SELECT H.ID MID,H.PARENTID MPID,H.CONTENTID MCID,H.TREELEVEL MLEVEL,H.WEIGHT MWEIGHT,H.RANK MRANK,C.NAME MNAME, ")
					.append(" D.WEIGHT WEIGHTING, D.PLANNED,D.BEST,D.WORST,D.ENTRYTYPE,D.FREQUENCY,D.EQUATION,D.ETLKEY ")
					.append(" FROM TREESCOREVIEW H, TBLMEASURE C, TBLMEASUREDEFINE D WHERE H.CONTENTID=D.ID AND D.MEASUREID=C.ID ") 
					.append(" AND H.TREELEVEL=5 AND H.YYYY=?) MEA ")
					.append(" ON OBJ.OID=MEA.MPID ")
					.append(" WHERE MID IS NOT NULL )");
				Object[] paraD = new Object[]{year+month,year,sbuId,year,year,year,year};
				
				dbobject.executePreparedUpdate(strD.toString(),paraD);
				
				StringBuffer strI = new StringBuffer();
				strI.append("INSERT INTO TBLEVALMEASURE (EFFECTIVEDATE,DIVCODE,MEASUREID,PNAME,MNAME,EVALWEIGHT,ORDERBY,BSCACTUAL,BSCSCORE,INPUTDATE) VALUES (?,?,?,?,?,?,?,?,?,SYSDATE)");
				Object[] paraI =new Object[]{year+month,sbuId,null,null,null,null,null,null,null};
				
				for(int i=0;i<measureId.length;i++){
					if ("1".equals(p[i+1])){
						paraI[2] = measureId[i];
						paraI[3] = Util.getEUCKR(pname[i]);
						paraI[4] = Util.getEUCKR(mname[i]);
						paraI[5] = evalWeight[i];
						paraI[6] = new Integer(i);
						paraI[7] = bscActual[i];
						paraI[8] = bscScore[i];
						
						dbobject.executePreparedUpdate(strI.toString(),paraI);
					}
				}
			}
			
        	if ((comId != null)&&(sbuId !=null)) {
				StringBuffer sb = new StringBuffer();  
	        	sb.append("SELECT SBU.*,BSC.*,PST.*,OBJ.*,MEA.*,(MEA.WEIGHTING*OBJ.OWEIGHT*PST.PWEIGHT*BSC.BWEIGHT)/1000000 DIVWEIGHT,  ")
	        	  .append(" SCR.ACTUAL,SCR.SCORE,EVA.EVALWEIGHT,EVA.EVALSCORE FROM ")
	        	  .append(" (SELECT H.ID SID,H.PARENTID SPID,H.CONTENTID SCID,H.TREELEVEL SLEVEL,H.WEIGHT SWEIGHT,H.RANK SRANK,C.NAME SNAME  ")
	        	  .append(" FROM HIERARCHYVIEW H, TBLSBU C WHERE H.CONTENTID=C.ID AND H.TREELEVEL=1 AND H.YYYY=?  AND H.CONTENTID = ?) SBU  ")
	        	  .append(" LEFT JOIN  ")
	        	  .append(" (SELECT H.ID BID,H.PARENTID BPID,H.CONTENTID BCID,H.TREELEVEL BLEVEL,H.WEIGHT BWEIGHT,H.RANK BRANK,TRIM(C.NAME) BNAME  ")
	        	  .append(" FROM HIERARCHYVIEW H, TBLBSC C WHERE H.CONTENTID=C.ID AND H.TREELEVEL=2 AND H.YYYY=? ) BSC  ")
	        	  .append(" ON SBU.SID=BSC.BPID  ")
	        	  .append(" LEFT JOIN  ")
	        	  .append(" (SELECT H.ID PID,H.PARENTID PPID,H.CONTENTID PCID,H.TREELEVEL PLEVEL,H.WEIGHT PWEIGHT,H.RANK PRANK,C.NAME PNAME  ")
	        	  .append(" FROM TREESCOREVIEW H, TBLPST C WHERE H.CONTENTID=C.ID AND H.TREELEVEL=3 AND H.YYYY=? ) PST  ")
	        	  .append(" ON BSC.BID=PST.PPID  ")
	        	  .append(" LEFT JOIN  ")
	        	  .append(" (SELECT H.ID OID,H.PARENTID OPID,H.CONTENTID OCID,H.TREELEVEL OLEVEL,H.WEIGHT OWEIGHT,H.RANK ORANK,C.NAME ONAME  ")
	        	  .append(" FROM TREESCOREVIEW H, TBLOBJECTIVE C WHERE H.CONTENTID=C.ID AND H.TREELEVEL=4 AND H.YYYY=? ) OBJ  ")
	        	  .append(" ON PST.PID=OBJ.OPID  ")
	        	  .append(" LEFT JOIN  ")
	        	  .append(" (SELECT H.ID MID,H.PARENTID MPID,H.CONTENTID MCID,H.TREELEVEL MLEVEL,H.WEIGHT MWEIGHT,H.RANK MRANK,C.NAME MNAME,C.MEASCHAR,  ")
	        	  .append(" D.WEIGHT WEIGHTING, D.PLANNED,D.BEST,D.WORST,D.ENTRYTYPE,D.FREQUENCY,D.EQUATION,D.ETLKEY,D.UNIT  ")
	        	  .append(" FROM TREESCOREVIEW H, TBLMEASURE C, TBLMEASUREDEFINE D WHERE H.CONTENTID=D.ID AND D.MEASUREID=C.ID   ")
	        	  .append(" AND H.TREELEVEL=5 AND H.YYYY=? ) MEA  ")
	        	  .append(" ON OBJ.OID=MEA.MPID  ")
	        	  .append(" LEFT JOIN  ");
	        	Object[] p = null;
				if("06".equals(month)){
					sb.append("(SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='월') ")
						.append(" AND SUBSTR(STRDATE,1,6)>=? AND SUBSTR(STRDATE,1,6)<=?) SCR  ")
						.append(" GROUP BY MEASUREID ")
						.append(" UNION ")
						.append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY<>'월') ")
						.append(" AND SUBSTR(STRDATE,1,6)=?) SCR  ")
						.append(" GROUP BY MEASUREID ");
					p = new Object[] {year,sbuId,year,year,year,year,year+"04",year+"06",year+"06",year+month};
				} else if("07".equals(month)){
					sb.append("(SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='월') ")
						.append(" AND SUBSTR(STRDATE,1,6)>=? AND SUBSTR(STRDATE,1,6)<=?) SCR  ")
						.append(" GROUP BY MEASUREID ")
						.append(" UNION ")
						.append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='분기') ")
						.append(" AND SUBSTR(STRDATE,1,6)=?) SCR  ")
						.append(" GROUP BY MEASUREID ");
					p = new Object[] {year,sbuId,year,year,year,year,year+"07",year+"09",year+"09",year+month};
				} else if("10".equals(month)){
					sb.append("(SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='월') ")
						.append(" AND SUBSTR(STRDATE,1,6)>=? AND SUBSTR(STRDATE,1,6)<=?) SCR  ")
						.append(" GROUP BY MEASUREID ")
						.append(" UNION ")
						.append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='분기') ")
						.append(" AND SUBSTR(STRDATE,1,6)=?) SCR  ")
						.append(" GROUP BY MEASUREID ")
						.append(" UNION ")
						.append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='반기') ")
						.append(" AND SUBSTR(STRDATE,1,6)=?) SCR  ")
						.append(" GROUP BY MEASUREID ")
						.append(" UNION ")
						.append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='년') ")
						.append(" AND SUBSTR(STRDATE,1,6)=?) SCR  ")
						.append(" GROUP BY MEASUREID ");
					p = new Object[] {year,sbuId,year,year,year,year,year+"10",year+"12",year+"12",year+"12",year+"12",year+month};					
				} else if("12".equals(month)){
					sb.append("(SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='월') ")
						.append(" AND SUBSTR(STRDATE,1,6)>=? AND SUBSTR(STRDATE,1,6)<=?) SCR  ")
						.append(" GROUP BY MEASUREID ")
						.append(" UNION ")
						.append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='분기') ")
						.append(" AND (SUBSTR(STRDATE,1,6)=? OR SUBSTR(STRDATE,1,6)=?) ) SCR  ")
						.append(" GROUP BY MEASUREID ")
						.append(" UNION ")
						.append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='반기') ")
						.append(" AND SUBSTR(STRDATE,1,6)=?) SCR  ")
						.append(" GROUP BY MEASUREID ")
						.append(" UNION ")
						.append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='년') ")
						.append(" AND SUBSTR(STRDATE,1,6)=?) SCR  ")
						.append(" GROUP BY MEASUREID ");
					p = new Object[] {year,sbuId,year,year,year,year,year+"07",year+"12",year+"09",year+"12",year+"12",year+"12",year+month};
				} else if("00".equals(month)){
					sb.append("(SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='월') ")
						.append("AND SUBSTR(STRDATE,1,6)>=? AND SUBSTR(STRDATE,1,6)<=?) SCR  ")
						.append("GROUP BY MEASUREID ")
						.append("UNION ")
						.append("SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append("(SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='분기') ")
						.append("AND (SUBSTR(STRDATE,1,6)=? OR SUBSTR(STRDATE,1,6)=? OR SUBSTR(STRDATE,1,6)=?) ) SCR  ")
						.append("GROUP BY MEASUREID ")
						.append("UNION ")
						.append("SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append("(SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='반기') ")
						.append("AND (SUBSTR(STRDATE,1,6)=? OR SUBSTR(STRDATE,1,6)=?)) SCR  ")
						.append("GROUP BY MEASUREID ")
						.append("UNION ")
						.append("SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM ")
						.append("(SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='년') ")
						.append("AND SUBSTR(STRDATE,1,6)=?) SCR  ")
						.append("GROUP BY MEASUREID");
					p = new Object[] {year,sbuId,year,year,year,year,year+"04",year+"12",year+"06",year+"09",year+"12",year+"06",year+"12",year+"12",year+month};
				}
	        	  sb.append(" ) SCR  ")
	        	  .append(" ON MEA.MCID=SCR.MEASUREID  ")
	        	  .append(" LEFT JOIN  ")
	        	  .append(" (SELECT * FROM TBLEVALMEASURE WHERE EFFECTIVEDATE=? ) EVA  ")
	        	  .append(" ON MEA.MCID=EVA.MEASUREID   ")
	        	  .append(" WHERE MID IS NOT NULL  ")
	        	  .append(" ORDER BY SID,SRANK,BID,BRANK,PID,PRANK,OID,ORANK,MRANK  ");
	        	
	        	
	
	        	rs = dbobject.executePreparedQuery(sb.toString(),p);
	        	DataSet ds = new DataSet();
	        	ds.load(rs);
	        	
	        	request.setAttribute("ds",ds);
        	}
        	conn.commit();
		} catch(Exception e){
			System.out.println("InnerEvalUtil setWeightList :"+e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close(); dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}
	}
	
	public void setAdminGroup(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			String tag = request.getParameter("tag");
			if (tag == null) return;
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";

			String strDate = request.getParameter("strDate");
			String year = strDate.substring(0,4);
			String month = strDate.substring(4,6);
			
			
			Object[] p = new Object[]{strDate};
			if ("GI".equals(mode)){
				String groupName = Util.getEUCKR(request.getParameter("groupName"));
				if (groupName != null){
					try {
						String s = "INSERT INTO TBLMEAEVALGRP (GRPID,YEAR,MONTH,GRPNM) VALUES (?,?,?,?)";
						Object[] p1 = new Object[]{new Integer(dbobject.getNextId("TBLMEAEVALGRP","GRPID")),year,month,groupName};
						dbobject.executePreparedUpdate(s,p1);
						conn.commit();	
					} catch(SQLException e) {
						e.getMessage();
					}
				}
			} else if ("GM".equals(mode)){
				String groupNameR = Util.getEUCKR(request.getParameter("groupNameR"));
				String grpcode = request.getParameter("grpCode");
				if (grpcode!=null && groupNameR!=null){
					String s = "UPDATE TBLMEAEVALGRP SET GRPNM=?,MODIDATE=SYSDATE WHERE GRPID=?";
					Object[] p1 = new Object[]{groupNameR,grpcode};
					dbobject.executePreparedUpdate(s,p1);
					conn.commit();
				}
			} else if ("GD".equals(mode)){
				String grpCode = request.getParameter("grpCode");
				if (grpCode != null){
					String s = "DELETE FROM TBLMEAEVALDEPT WHERE GRPID=?";
					Object[] p1 = new Object[]{grpCode};
					dbobject.executePreparedUpdate(s,p1);
					s = "DELETE FROM TBLMEAEVALGRP WHERE GRPID=?";
					dbobject.executePreparedUpdate(s,p1);
					conn.commit();
				}
				
			} else if ("DI".equals(mode)){
				String grpCode = request.getParameter("grpCode");
				String divCode = request.getParameter("divCode");
				if (grpCode!=null&&divCode!=null){
					try {
						String s = "INSERT INTO TBLMEAEVALDEPT (GRPID,EVALDEPTID) VALUES (?,?)";
						Object[] p1 = new Object[]{grpCode,divCode};
						dbobject.executePreparedUpdate(s,p1);
						
						conn.commit();
					} catch(SQLException e) {
						e.getMessage();
					}
				}
				
			} else if ("DD".equals(mode)){
				String grpCode = request.getParameter("grpCode");
				String divCode = request.getParameter("divCode");
				if (grpCode!=null&&divCode!=null){
					String s = "DELETE FROM TBLMEAEVALDEPT WHERE GRPID=? AND EVALDEPTID=?";
					Object[] p1 = new Object[]{grpCode, divCode};
					dbobject.executePreparedUpdate(s,p1);
					
					conn.commit();
				}
			}
			
			StringBuffer sb = new StringBuffer();
			//sb.append("SELECT ID,NAME FROM TBLBSC WHERE ID IN ")
			//	.append(" (SELECT CONTENTID FROM TBLHIERARCHY WHERE TREELEVEL=2 AND YEAR=?) ")
			//	.append(" AND ID NOT IN (SELECT EVALDEPTID FROM TBLMEAEVALDEPT WHERE GRPID IN (SELECT GRPID FROM TBLMEAEVALGRP WHERE YEAR=? AND MONTH=?)) ")
			//	.append(" ORDER BY NAME");
			//rs = dbobject.executePreparedQuery(sb.toString(),new Object[]{year,year,month});
			
			if ("2007".equals(year)) {
				sb.append(" SELECT  cid, ccid, clevel, crank, cname,  ")
				.append("         sid, scid ID, slevel, srank, sname NAME ")
				.append(" FROM ")
				.append("        (select t.id cid,t.parentid cpid,t.contentid ccid,t.treelevel clevel, t.rank crank,t.weight cweight,c.name cname ")
				.append("         from   tblhierarchy t,tblcompany c ")
				.append("         where  t.contentid=c.id  and t.treelevel=0 and t.year ='2007' ")
				.append("        ) com, ")
				.append("        (select t.id sid,t.parentid spid,t.contentid scid,t.treelevel slevel, t.rank srank,t.weight sweight,c.name sname ")
				.append("         from   tblhierarchy t,tblsbu c ")
				.append("         where  t.contentid=c.id  and t.treelevel=1 and t.year ='2007' ")
				.append("        ) sbu ")
				.append(" where  cid = spid (+) ")
				.append("        and scid != 1  ")
				.append(" order by crank, srank ");
				rs = dbobject.executePreparedQuery(sb.toString(),null);
			} else {
				sb.append("SELECT DISTINCT MID ID, MNAME NAME FROM ")
				  .append(" (SELECT C.ID MID, C.NAME MNAME, D.MEASUREMENT   ")
		          .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND MEASUREMENT='비계량' ) MEA ")
		          .append(" ORDER BY NAME");
				rs = dbobject.executePreparedQuery(sb.toString(),new Object[]{year});
			}
			
			DataSet dsDiv = new DataSet();
			dsDiv.load(rs);
			
			request.setAttribute("dsDiv",dsDiv);
			
			
			StringBuffer sbGrp = new StringBuffer();
			sbGrp.append("SELECT * FROM TBLMEAEVALGRP WHERE YEAR=? AND MONTH=?");
			Object[] pm = {year,month};
			if (rs!=null){rs.close(); rs = null;}
			
			rs = dbobject.executePreparedQuery(sbGrp.toString(),pm);
			
			DataSet dsGrp = new DataSet();
			dsGrp.load(rs);
			
			request.setAttribute("dsGrp",dsGrp);
			
			StringBuffer sbDetail = new StringBuffer();
			
			if ("2007".equals(year)) {
				sbDetail.append("SELECT D.GRPID, D.EVALDEPTID,B.NAME FROM TBLMEAEVALDEPT D, TBLSBU B WHERE D.EVALDEPTID=B.ID AND GRPID IN (SELECT GRPID FROM TBLMEAEVALGRP WHERE YEAR=? AND MONTH=?)");
			} else {
				sbDetail.append("SELECT D.GRPID, D.EVALDEPTID,B.NAME FROM TBLMEAEVALDEPT D, TBLMEASURE B WHERE D.EVALDEPTID=B.ID AND GRPID IN (SELECT GRPID FROM TBLMEAEVALGRP WHERE YEAR=? AND MONTH=?)");
			}
			
			if (rs!=null){rs.close(); rs = null;}
			rs = dbobject.executePreparedQuery(sbDetail.toString(),pm);
			
			DataSet dsDetail = new DataSet();
			dsDetail.load(rs);
			
			request.setAttribute("dsDetail",dsDetail);
			
		} catch (Exception e) {
			if (conn!=null) try{conn.rollback();}catch(Exception se){};
			System.out.println("EvalAdminUtil setAdminGroup : "+e);
		} finally {
			if (rs!=null){try{rs.close();rs=null;} catch (Exception se){} }
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}
	}
	
	public void setAdminAppraiser(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			
			String tag = request.getParameter("tag");
			if (tag == null) return;
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";

			String strDate = request.getParameter("strDate")!=null?request.getParameter("strDate"):Util.getToDay();
			String year = strDate.substring(0,4);
			String month = strDate.substring(4,6);
			if (dbobject== null) dbobject = new DBObject(conn.getConnection());
			
			
			System.out.println("inje  :: year  ========="+year);
			System.out.println("inje  :: month  ========="+month);
			Object[] p = new Object[]{year,month};
		    
			if ("AI".equals(mode)){
				String grpCode = request.getParameter("grpCode");
				String userId = request.getParameter("userId");
				if (grpCode!=null&&userId!=null){
					String s = "INSERT INTO TBLMEAEVALR (YEAR,MONTH,EVALRID,GRPID) VALUES (?,?,?,?)";
					Object[] p1 = new Object[]{year,month,userId,grpCode};
					dbobject.executePreparedUpdate(s,p1);
					conn.commit();	
				}
				
			} else if ("AD".equals(mode)){
				String grpCode = request.getParameter("grpCode");
				String appCode = request.getParameter("appCode");
				if (grpCode!=null&&appCode!=null){
					String s = "DELETE FROM TBLMEAEVALR WHERE EVALRID=? AND YEAR=? AND MONTH=? AND GRPID=?";
					Object[] p1 = new Object[]{appCode,year,month,grpCode};
					dbobject.executePreparedUpdate(s,p1);
					conn.commit();
				}
			}
			
			System.out.println("tag  =================================="+tag);
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT * FROM TBLUSER WHERE APPRAISER=1 OR APPRAISER=2 "); 
			
			rs = dbobject.executeQuery(sb.toString());
			
			DataSet dsUser = new DataSet();
			dsUser.load(rs);
			
			request.setAttribute("dsUser",dsUser);
			
			
			StringBuffer sbGrp = new StringBuffer();
			sbGrp.append("SELECT * FROM TBLMEAEVALGRP WHERE YEAR=? AND MONTH=?");
			if (rs!=null){rs.close(); rs = null;}
			
			rs = dbobject.executePreparedQuery(sbGrp.toString(),p);
			
			DataSet dsGrp = new DataSet();
			dsGrp.load(rs);
			
			request.setAttribute("dsGroup",dsGrp);
			
			StringBuffer sbDetail = new StringBuffer();
			sbDetail.append("  SELECT A.*,U.USERNAME FROM TBLMEAEVALR A, TBLUSER U WHERE A.EVALRID=U.USERID AND A.YEAR=? AND A.MONTH=?");
			if (rs!=null){rs.close(); rs = null;}
			rs = dbobject.executePreparedQuery(sbDetail.toString(),p);
			
			DataSet dsDetail = new DataSet();
			dsDetail.load(rs);
			
			request.setAttribute("dsAppraiser",dsDetail);
			
		} catch (Exception e) {
			if (conn!=null) try{conn.rollback();}catch(Exception se){};
			System.out.println("EvalAdminUtil setAdminGroup : "+e);
		} finally {
			if (rs!=null){try{rs.close();rs=null;} catch (Exception se){} }
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}
	}
	
	public void setAdminView(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			String sn = request.getParameter("sn")!=null?request.getParameter("sn"):"";
			if ("".equals(sn)) throw new Exception("sevice is nothing");
			
			conn.createStatement(false);
			
			String strDate = request.getParameter("strDate")!=null?request.getParameter("strDate"):Util.getToDay();
			String semi = strDate.substring(4,6);
			String year = strDate.substring(0,4);
			if (dbobject== null) dbobject = new DBObject(conn.getConnection());
			
			
			StringBuffer sb = new StringBuffer();
			Object[] param = null;
			if ("06".equals(semi)){
				sb.append(" SELECT B.*,RANK() OVER (PARTITION BY GRPID ORDER BY FSCORE DESC) RANK FROM ( ")
			         .append(" SELECT GRPID,NAME,SBUID,DNAME,ROUND(SUM(WESCORE),3) WESCORE,ROUND(SUM(WSCORE),3) WSCORE,NVL(ROUND(SUM(FSCORE),3),-1) FSCORE FROM ( ")
			         .append(" SELECT GRP.*,DTL.*,MEA.*,EVAL.*,S.*,EVALWEIGHT/10*EVALSCORE WESCORE,EVALWEIGHT/10*SCORE WSCORE, ")
			         .append(" EVALWEIGHT/10*EVALSCORE*0.5+EVALWEIGHT/10*SCORE*0.5 FSCORE FROM ")
			         .append(" (SELECT * FROM TBLEVALGROUP WHERE EFFECTIVEDATE=? ) GRP  ")
			         .append(" LEFT JOIN  ")
			         .append(" (SELECT GRPID GID,SBUID,NAME DNAME FROM TBLEVALGROUPDETAIL) DTL  ")
			         .append(" ON GRP.GRPID=DTL.GID ")
			         .append(" 	LEFT JOIN  ")
			         .append(" 	(SELECT MEASUREID,PNAME,MNAME,EVALWEIGHT,ORDERBY,BSCACTUAL,BSCSCORE,DIVCODE FROM TBLEVALMEASURE WHERE EFFECTIVEDATE=?) MEA  ")
			         .append(" 	ON DTL.SBUID=MEA.DIVCODE  ")
			         .append(" 		LEFT JOIN  ")
			         .append(" 		(SELECT ROUND(AVG(SCORE),3) EVALSCORE,DIVCODE DCODE,MEASUREID MID FROM TBLEVALSCORE WHERE EFFECTIVEDATE=?   ")
			         .append(" 		GROUP BY MEASUREID,DIVCODE ) EVAL  ")
			         .append(" 		ON MEA.DIVCODE=EVAL.DCODE AND MEA.MEASUREID=EVAL.MID  ")
			         .append(" 			LEFT JOIN ( ")
			         .append(" 			SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM  ")
			         .append(" 			(SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='월')  ")
			         .append(" 			AND SUBSTR(STRDATE,1,6)>=? AND SUBSTR(STRDATE,1,6)<=?) SCR   ")
			         .append(" 			GROUP BY MEASUREID  ")
			         .append(" 			UNION  ")
			         .append(" 			SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM  ")
			         .append(" 			(SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY<>'월')  ")
			         .append(" 			AND SUBSTR(STRDATE,1,6)=?) SCR   ")
			         .append(" 			GROUP BY MEASUREID ")
			         .append(" 			) S ")
			         .append(" 			ON MEA.MEASUREID=S.MEASUREID			 ")
			         .append(" 			 ) A ")
			         .append(" GROUP BY GRPID,NAME,SBUID,DNAME ) B ");
			
				param = new Object[]{strDate,strDate,strDate,year+"03",strDate,strDate};
			} else {
				sb.append(" SELECT B.*,RANK() OVER (PARTITION BY GRPID ORDER BY FSCORE DESC) RANK FROM ( ")
		         .append(" SELECT GRPID,NAME,SBUID,DNAME,ROUND(SUM(WESCORE),3) WESCORE,ROUND(SUM(WSCORE),3) WSCORE,NVL(ROUND(SUM(FSCORE),3)	,-1) FSCORE FROM ( ")
		         .append(" SELECT GRP.*,DTL.*,MEA.*,EVAL.*,S.*,EVALWEIGHT/10*EVALSCORE WESCORE,EVALWEIGHT/10*SCORE WSCORE, ")
		         .append(" EVALWEIGHT/10*EVALSCORE*0.5+EVALWEIGHT/10*SCORE*0.5 FSCORE FROM ")
		         .append(" (SELECT * FROM TBLEVALGROUP WHERE EFFECTIVEDATE=? ) GRP  ")
		         .append(" LEFT JOIN  ")
		         .append(" (SELECT GRPID GID,SBUID,NAME DNAME FROM TBLEVALGROUPDETAIL) DTL  ")
		         .append(" ON GRP.GRPID=DTL.GID ")
		         .append(" 	LEFT JOIN  ")
		         .append(" 	(SELECT MEASUREID,PNAME,MNAME,EVALWEIGHT,ORDERBY,BSCACTUAL,BSCSCORE,DIVCODE FROM TBLEVALMEASURE WHERE EFFECTIVEDATE=?) MEA  ")
		         .append(" 	ON DTL.SBUID=MEA.DIVCODE  ")
		         .append(" 		LEFT JOIN  ")
		         .append(" 		(SELECT ROUND(AVG(SCORE),3) EVALSCORE,DIVCODE DCODE,MEASUREID MID FROM TBLEVALSCORE WHERE EFFECTIVEDATE=?   ")
		         .append(" 		GROUP BY MEASUREID,DIVCODE ) EVAL  ")
		         .append(" 		ON MEA.DIVCODE=EVAL.DCODE AND MEA.MEASUREID=EVAL.MID  ")
		         .append(" 			LEFT JOIN ( ")
		         .append(" 				SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM  ")
		         .append(" 				(SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='월')  ")
		         .append(" 				AND SUBSTR(STRDATE,1,6)>=? AND SUBSTR(STRDATE,1,6)<=?) SCR   ")
		         .append(" 				GROUP BY MEASUREID  ")
		         .append(" 				UNION  ")
		         .append(" 				SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM  ")
		         .append(" 				(SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='분기')  ")
		         .append(" 				AND (SUBSTR(STRDATE,1,6)=? OR SUBSTR(STRDATE,1,6)=?) ) SCR   ")
		         .append(" 				GROUP BY MEASUREID  ")
		         .append(" 				UNION  ")
		         .append(" 				SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM  ")
		         .append(" 				(SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='반기')  ")
		         .append(" 				AND SUBSTR(STRDATE,1,6)=?) SCR   ")
		         .append(" 				GROUP BY MEASUREID  ")
		         .append(" 				UNION  ")
		         .append(" 				SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM  ")
		         .append(" 				(SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='년')  ")
		         .append(" 				AND SUBSTR(STRDATE,1,6)=?) SCR   ")
		         .append(" 				GROUP BY MEASUREID ")
		         .append(" 			) S ")
		         .append(" 			ON MEA.MEASUREID=S.MEASUREID			 ")
		         .append(" 			 ) A ")
		         .append(" GROUP BY GRPID,NAME,SBUID,DNAME ) B ");
				
				param = new Object[]{strDate,strDate,strDate,year+"07",strDate,year+"09",strDate,strDate,strDate};
			}

			rs = dbobject.executePreparedQuery(sb.toString(),param);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
		} catch (Exception e) {
			System.out.println("EvalAdminUtil setAdminView : "+e);
		} finally {
			if (rs!=null){try{rs.close();rs=null;} catch (Exception se){} }
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}		
	}
	
	public void setAdminDetailView(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			String sn = request.getParameter("sn")!=null?request.getParameter("sn"):"";
			if ("".equals(sn)) throw new Exception("sevice is nothing");
			
			conn.createStatement(false);
			
			String strDate = request.getParameter("strDate")!=null?request.getParameter("strDate"):Util.getToDay();
			String sbuId = request.getParameter("sbuId");
			String grpId = request.getParameter("grpId");
			String year = strDate.substring(0,4);
			String semi = strDate.substring(4,6);
			
			StringBuffer sb = new StringBuffer();
			Object[] param = null;
			if ("06".equals(semi)){
				sb.append(" SELECT GRPID,NAME,EFFECTIVEDATE,SBUID,DNAME,MEA.MEASUREID,PNAME,MNAME,ROUND(EVALWEIGHT,3) EVALWEIGHT,ORDERBY,ROUND(S.SCORE,3) BSCSCORE, ")
		         .append(" ROUND(EVALSCORE,3) EVALSCORE,ROUND((S.SCORE*0.5+EVALSCORE*0.5),3) FSCORE,ROUND((S.SCORE*0.5+EVALSCORE*0.5)*EVALWEIGHT/10,3) WSCORE FROM   ")
		         .append(" (SELECT * FROM TBLEVALGROUP WHERE EFFECTIVEDATE=? ) GRP  ")
		         .append(" LEFT JOIN  ")
		         .append(" (SELECT GRPID GID,SBUID,NAME DNAME FROM TBLEVALGROUPDETAIL) DTL  ")
		         .append(" ON GRP.GRPID=DTL.GID AND SBUID=? ")
		         .append(" LEFT JOIN  ")
		         .append(" (SELECT MEASUREID,PNAME,MNAME,EVALWEIGHT,ORDERBY,BSCACTUAL,BSCSCORE,DIVCODE FROM TBLEVALMEASURE WHERE EFFECTIVEDATE=?) MEA  ")
		         .append(" ON DTL.SBUID=MEA.DIVCODE  ")
		         .append(" LEFT JOIN  ")
		         .append(" (SELECT ROUND(AVG(SCORE),3) EVALSCORE,DIVCODE DCODE,MEASUREID MID FROM TBLEVALSCORE WHERE EFFECTIVEDATE=?   ")
		         .append(" GROUP BY MEASUREID,DIVCODE ) EVAL  ")
		         .append(" ON MEA.DIVCODE=EVAL.DCODE AND MEA.MEASUREID=EVAL.MID  ")
		         .append(" LEFT JOIN ( ")
		         .append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM  ")
		         .append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='월')  ")
		         .append(" AND SUBSTR(STRDATE,1,6)>=? AND SUBSTR(STRDATE,1,6)<=?) SCR   ")
		         .append(" GROUP BY MEASUREID  ")
		         .append(" UNION  ")
		         .append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM  ")
		         .append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY<>'월')  ")
		         .append(" AND SUBSTR(STRDATE,1,6)=?) SCR   ")
		         .append(" GROUP BY MEASUREID ")
		         .append(" ) S ")
		         .append(" ON MEA.MEASUREID=S.MEASUREID ")
		         .append(" WHERE SBUID IS NOT NULL ORDER BY ORDERBY ");
			
				param = new Object[]{strDate,sbuId,strDate,strDate,year+"03",strDate,strDate};
			} else {
				sb.append(" SELECT GRPID,NAME,EFFECTIVEDATE,SBUID,DNAME,MEA.MEASUREID,PNAME,MNAME,ROUND(EVALWEIGHT,3) EVALWEIGHT,ORDERBY,ROUND(S.SCORE,3) BSCSCORE, ")
		         .append(" ROUND(EVALSCORE,3) EVALSCORE,ROUND((S.SCORE*0.5+EVALSCORE*0.5),3) FSCORE,ROUND((S.SCORE*0.5+EVALSCORE*0.5)*EVALWEIGHT/10,3) WSCORE FROM   ")
		         .append(" (SELECT * FROM TBLEVALGROUP WHERE EFFECTIVEDATE=? ) GRP  ")
		         .append(" LEFT JOIN  ")
		         .append(" (SELECT GRPID GID,SBUID,NAME DNAME FROM TBLEVALGROUPDETAIL) DTL  ")
		         .append(" ON GRP.GRPID=DTL.GID AND SBUID=? ")
		         .append(" LEFT JOIN  ")
		         .append(" (SELECT MEASUREID,PNAME,MNAME,EVALWEIGHT,ORDERBY,BSCACTUAL,BSCSCORE,DIVCODE FROM TBLEVALMEASURE WHERE EFFECTIVEDATE=?) MEA  ")
		         .append(" ON DTL.SBUID=MEA.DIVCODE  ")
		         .append(" LEFT JOIN  ")
		         .append(" (SELECT ROUND(AVG(SCORE),3) EVALSCORE,DIVCODE DCODE,MEASUREID MID FROM TBLEVALSCORE WHERE EFFECTIVEDATE=?   ")
		         .append(" GROUP BY MEASUREID,DIVCODE ) EVAL  ")
		         .append(" ON MEA.DIVCODE=EVAL.DCODE AND MEA.MEASUREID=EVAL.MID  ")
		         .append(" LEFT JOIN ( ")
		         .append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM  ")
		         .append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='월')  ")
		         .append(" AND SUBSTR(STRDATE,1,6)>=? AND SUBSTR(STRDATE,1,6)<=?) SCR   ")
		         .append(" GROUP BY MEASUREID  ")
		         .append(" UNION  ")
		         .append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM  ")
		         .append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='분기')  ")
		         .append(" AND (SUBSTR(STRDATE,1,6)=? OR SUBSTR(STRDATE,1,6)=?) ) SCR   ")
		         .append(" GROUP BY MEASUREID  ")
		         .append(" UNION  ")
		         .append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM  ")
		         .append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='반기')  ")
		         .append(" AND SUBSTR(STRDATE,1,6)=?) SCR   ")
		         .append(" GROUP BY MEASUREID  ")
		         .append(" UNION  ")
		         .append(" SELECT MEASUREID, AVG(ACTUAL) ACTUAL, AVG(SCORE) SCORE FROM  ")
		         .append(" (SELECT MEASUREID,ACTUAL,SCORE FROM TBLMEASURESCORE WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE FREQUENCY='년')  ")
		         .append(" AND SUBSTR(STRDATE,1,6)=?) SCR   ")
		         .append(" GROUP BY MEASUREID ")
		         .append(" ) S ")
		         .append(" ON MEA.MEASUREID=S.MEASUREID ")
		         .append(" WHERE SBUID IS NOT NULL ORDER BY ORDERBY ");
				
				param = new Object[]{strDate,sbuId,strDate,strDate,year+"07",strDate,year+"09",strDate,strDate,strDate};
			}
			
			if (dbobject== null) dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(),param);
			
			//EvalMeasureUtil evalmeasureutil = new EvalMeasureUtil();
			while(rs.next()){
				//evalmeasureutil.AddMeasure(rs);
			}
			
			String str = "SELECT A.*,(SELECT USERNAME FROM TBLUSER U WHERE A.USERID=U.USERID) UNAME FROM TBLEVALAPPRAISER A WHERE GROUPID=? AND EFFECTIVEDATE=?";
			Object[] par = {grpId,strDate};
			if (rs !=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(str,par);
			while(rs.next()){
				//evalmeasureutil.setAppName(rs);
			}
			
			String strS = "SELECT S.*,(SELECT USERNAME FROM TBLUSER U WHERE U.USERID=S.APPID) UNAME FROM TBLEVALSCORE S WHERE EFFECTIVEDATE=? AND DIVCODE=?";
			Object[] parS = {strDate,sbuId};
			if (rs!=null){rs.close();rs=null;}
			rs = dbobject.executePreparedQuery(strS,parS);
			
			while(rs.next()){
				//evalmeasureutil.setActual(rs);
			}
			
			//request.setAttribute("util",evalmeasureutil);

			
			
		} catch (Exception e) {
			System.out.println("EvalAdminUtil setAdminView : "+e);
		} finally {
			if (rs!=null){try{rs.close();rs=null;} catch (Exception se){} }
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}		
	}
	
	public void setEvalOpinion(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			String sn = request.getParameter("sn")!=null?request.getParameter("sn"):"";
			if ("".equals(sn)) throw new Exception("sevice is nothing");
			
			conn.createStatement(false);
			
			String strDate = request.getParameter("strDate")!=null?request.getParameter("strDate"):Util.getToDay();
			String grpId = request.getParameter("grpId");
			String sbuId = request.getParameter("sbuId");
			String userId = request.getParameter("userId");
			if (dbobject== null) dbobject = new DBObject(conn.getConnection());
			
			String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
			String msg = "";
			if ("OI".equals(mode)){
				String opinion = Util.getEUCKR(request.getParameter("opinion"));
				String sU = "UPDATE TBLEVALOPINION SET OPINION=?,INPUTDATE=? WHERE GRPID=? AND SBUID=? AND APPID=? AND EFFECTIVEDATE=?";
				Object[] pU = {opinion,Util.getToDay(),grpId,sbuId,userId,strDate};
				if (dbobject.executePreparedUpdate(sU,pU)<1){
					String sI = "INSERT INTO TBLEVALOPINION (GRPID,SBUID,APPID,EFFECTIVEDATE,OPINION,INPUTDATE) VALUES (?,?,?,?,?,?)";
					Object[] pI = {grpId,sbuId,userId,strDate,opinion,Util.getToDay()};
					dbobject.executePreparedUpdate(sI,pI);
				}
				msg = "ok";
			}
			
			
			request.setAttribute("msg",msg);
			
			StringBuffer sb = new StringBuffer();
			sb.append("select grp.*,opn.appid,opn.opinion,opn.inputdate from ")
				.append(" (select g.grpid,g.name gname,g.effectivedate,d.sbuid,d.name dname ") 
				.append(" from tblevalgroup g, tblevalgroupdetail d where g.grpid=d.grpid and g.grpid=? and sbuid=?) grp ")
				.append(" left join ")
				.append(" (select * from tblevalopinion  o where o.appid=? and o.effectivedate=?) opn ")
				.append(" on grp.grpid=opn.grpid and grp.sbuid=opn.sbuid ");
			Object[] param = new Object[]{grpId,sbuId,userId,strDate};
			rs = dbobject.executePreparedQuery(sb.toString(),param);
			DataSet ds = new DataSet();
			ds.load(rs);
			request.setAttribute("ds",ds);

			String s = "select username from tbluser where userid=?";
			if (rs!=null) rs.close();
			rs = dbobject.executePreparedQuery(s, new Object[]{userId});
			DataSet dsUser = new DataSet();
			dsUser.load(rs);
			request.setAttribute("dsUser",dsUser);
			
			conn.commit();
		} catch (Exception e) {
			System.out.println("EvalAdminUtil setEvalOpinion : "+e);
		} finally {
			if (rs!=null){try{rs.close();rs=null;} catch (Exception se){} }
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}		
	}
	
	
	
}
