package com.nc.imports;

import java.sql.Connection;
import java.sql.ResultSet;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;
import com.nc.util.PostExcel;
import com.nc.util.Util;


public class ExportUtil {
	

	public boolean createExActual(String filePath, String fileName){
		boolean reval = true;
		Connection con = null;
		try {
			
			
			StringBuffer sb = new StringBuffer();
			sb.append("select d.measureid,"+"d.strdate,1,6) effectivedate,d.actual,d.planned,d.best,d.worst,f.etlkey,m.name ")
				.append(" from tblmeasuredetail d ")
				.append(" left join tblmeasuredefine f ")
				.append(" on d.measureid=f.id ")
				.append(" left join tblmeasure m ")
				.append(" on f.measureid=m.id ");
			
			String year = Util.getToDay().substring(0,4);

			
			String SheetName = "actual";
			String[] column = {"name","etlkey","effectivedate","worst","best","planned","actual"};
			String[] columnName = {"name","etlkey","effectivedate","worst","best","planned","actual"};
			int[] columntype    = {0,0,0,0,0,0,0};   

			PostExcel pxl = new PostExcel();
			pxl.CreateExcelFile(null, column, columnName, columntype, filePath+"/"+fileName, SheetName);
			
		} catch (Exception e) {
			System.out.println(e);
			reval = false;			
		} finally {
			//DBUtil.close(con);
		}
		return reval;
	}
	
	public boolean createExUser(String filePath, String fileName){
		boolean reval = true;
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT U.USERID,U.USERNAME,U.GROUPID,DIVCODE,(SELECT NAME FROM TBLBSC B WHERE B.ID=U.DIVCODE) DIVNAME FROM TBLUSER U") ;
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(), null);
			
			DataSet ds = new DataSet(rs);
			
			String SheetName = "user";
			String[] xlscolumn = {"userid","username","groupid","divcode","divname"};
			String[] columnName = {"userid","username","groupid","divcode","divname"};
			int[] columntype    = {0,0,0,0,0};   

			PostExcel pxl = new PostExcel();
			pxl.CreateExcelFile(ds, xlscolumn, columnName, columntype, filePath+"/"+fileName, SheetName);
			
		} catch (Exception e) {
			System.out.println(e);
			reval = false;			
		} finally {
			if (dbobject!=null){dbobject.close(); dbobject = null;}
			if (conn!=null){conn.close(); conn = null;}
		}
		return reval;
	}
	
	public boolean createExHierachy(String filePath, String fileName){
		boolean reval = true;
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
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
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.TREND, ")
	         .append(" D.DETAILDEFINE,D.UNIT,D.PLANNED,D.BASE,D.LIMIT,D.FREQUENCY,D.EQUATIONDEFINE,D.EQUATION,D.ETLKEY,D.MEAN,D.MEASUREMENT,D.UPDATEID, ")
	         .append(" D.DATASOURCE,D.PLANNEDBASE,D.BASELIMIT, D.TARGETRATIONLE, D.MNGDEPTNM, D.IFSYSTEM, ")
	         .append(" (SELECT USERNAME FROM TBLUSER WHERE USERID=D.UPDATEID) UPDATER,")
	         .append(" D.Y,D.YB1,D.YB2,D.YB3,D.YA1,D.YA2,D.YA3,D.YA4 ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=?) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID ORDER BY CID,SRANK,SID,BRANK,BID,PRANK,PID,ORANK,OID,MRANK");
			
			
			String year = Util.getToDay().substring(0,4);
			Object[] params = new Object[]{year,year,year,year,year,year};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(), params);
			
			DataSet ds = new DataSet(rs);
			
			String SheetName = "hierarchy";
			String[] xlscolumn = {"company","companyweight","sbu","sbuweight","bsc","bscweight","pst","pstweight","obj","objweight",
					"measure","measureupdater","weighting","frequency","mean","measuredefine","unit","measurement","etlkey","trend",
					"targetrationle", "mngdeptnm", "ifsystem",
					"equationdefine","equation","datasource","planned","plannedbase","base","baselimit","limit" };
					//"y","yb1","yb2","yb3","ya1","ya2","ya3","ya4"};
			String[] columnName = {"cname","cweight","sname","sweight","bname","bweight","pname","pweight","oname","oweight",
					"mname","updateid","mweight","frequency","mean","detaildefine","unit","measurement","etlkey","trend",
					"targetrationle", "mngdeptnm", "ifsystem",
					"equationdefine","equation","datasource","planned","plannedbase","base","baselimit","limit"}; 
					//"y","yb1","yb2","yb3","ya1","ya2","ya3","ya4"};
			int[] columntype    = {0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0, 	0,0,0, 	0,0,0,0,0,0,0,0} ;    

			PostExcel pxl = new PostExcel();
			pxl.CreateExcelFile(ds, xlscolumn, columnName, columntype, filePath+"/"+fileName, SheetName);
			
		} catch (Exception e) {
			System.out.println(e);
			reval = false;			
		} finally {
			if (dbobject!=null){dbobject.close(); dbobject = null;}
			if (conn!=null){conn.close(); conn = null;}
		}
		return reval;
	}
	
	
	public boolean createExMeasure(String filePath, String fileName,String bscId,String year){
		boolean reval = true;
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			
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
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? AND T.ID=? ) BSC ")
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
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.TREND, ")
	         .append(" D.DETAILDEFINE,D.UNIT,D.PLANNED,D.BASE,D.LIMIT,D.FREQUENCY,D.EQUATIONDEFINE,D.EQUATION,D.ETLKEY,D.MEAN,D.MEASUREMENT,D.UPDATEID, ")
	         .append(" (SELECT USERNAME FROM TBLUSER WHERE USERID=D.UPDATEID) UPDATER,")
	         .append(" D.Y,D.YB1,D.YB2,D.YB3,D.YA1,D.YA2,D.YA3,D.YA4, D.DATASOURCE, D.PLANNEDBASE, D.BASELIMIT,D.IFSYSTEM, D.MNGDEPTNM, D.TARGETRATIONLE ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=?) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID")
	         .append(" WHERE MCID IS NOT NULL ORDER BY CID,SRANK,SID,BRANK,BID,PRANK,PID,ORANK,OID,MRANK");
			
			Object[] params = new Object[]{year,year,year,bscId,year,year,year};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());
			rs = dbobject.executePreparedQuery(sb.toString(), params);
			
			DataSet ds = new DataSet(rs);
			
			String SheetName = "MEASURE";
			String[] xlscolumn = {"company","companyweight","sbu","sbuweight","bsc","bscweight","pst","pstweight","obj","objweight",
					"measure","measureupdater","weighting","frequency","mean","measuredefine","unit","measurement","etlkey",
					"trend","equationdefine","equation","planned","plannedbase","base","baselimit","limit",
					"y","yb1","yb2","yb3","ya1","ya2","ya3","ya4", "datasource", "ifsystem", "mngdeptnm", "targetationle"};
			String[] columnName = {"cname","cweight","sname","sweight","bname","bweight","pname","pweight","oname","oweight",
					"mname","updateid","mweight","frequency","mean","detaildefine","unit","measurement","etlkey",
					"trend","equationdefine","equation","planned","plannedbase","base","baselimit","limit",
					"y","yb1","yb2","yb3","ya1","ya2","ya3","ya4", "datasource", "ifsystem", "mngdeptnm", "targetationle"};
			int[] columntype    = {0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0};   

			PostExcel pxl = new PostExcel();
			pxl.CreateFormedExcelFile(ds, xlscolumn, columnName, columntype, filePath+"/"+fileName, SheetName);
			
		} catch (Exception e) {
			System.out.println(e);
			reval = false;			
		} finally {
			if (dbobject!=null){dbobject.close(); dbobject = null;}
			if (conn!=null){conn.close(); conn = null;}
		}
		return reval;
	}
}

