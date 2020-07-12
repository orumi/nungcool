package com.nc.tree;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.nc.cool.CoolServer;
import com.nc.cool.ScorecardUtil;
import com.nc.util.DBObject;

public class TreeUtil extends DBObject{

	public TreeUtil(Connection connection) {
		super(connection);
	}

	public TreeNode getTreeRoot(String year, String bscId) throws SQLException{

		TreeNode treeroot = null;
		try{
			StringBuffer sql = new StringBuffer();

		  sql.append(" SELECT * FROM   ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME   ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? AND T.ID=? ) BSC  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME   ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST  ")
	         .append(" ON BSC.BID=PST.PPID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME   ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ  ")
	         .append(" ON PST.PID=OBJ.OPID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.UNIT,D.FREQUENCY, D.MEASUREMENT, D.PLANNED,D.BASE,D.LIMIT, D.PLANNEDBASE, D.BASELIMIT   ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA  ")
	         .append(" ON OBJ.OID=MEA.MPID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT S.SCORE S1, S.MEASUREID M1,S.GRADE G1, ROUND(D.ACTUAL,2) A1 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND SUBSTR(S.STRDATE,0,6)=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC1  ")
	         .append(" ON MEA.MCID=SC1.M1  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT S.SCORE S2, S.MEASUREID M2,S.GRADE G2,ROUND(D.ACTUAL,2) A2 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND SUBSTR(S.STRDATE,0,6)=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC2  ")
	         .append(" ON MEA.MCID=SC2.M2  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT S.SCORE S3, S.MEASUREID M3,S.GRADE G3,ROUND(D.ACTUAL,2) A3 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND SUBSTR(S.STRDATE,0,6)=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC3  ")
	         .append(" ON MEA.MCID=SC3.M3  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT S.SCORE S4, S.MEASUREID M4,S.GRADE G4,ROUND(D.ACTUAL,2) A4 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND SUBSTR(S.STRDATE,0,6)=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC4  ")
	         .append(" ON MEA.MCID=SC4.M4  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT S.SCORE S5, S.MEASUREID M5,S.GRADE G5,ROUND(D.ACTUAL,2) A5 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND SUBSTR(S.STRDATE,0,6)=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC5  ")
	         .append(" ON MEA.MCID=SC5.M5  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT S.SCORE S6, S.MEASUREID M6,S.GRADE G6,ROUND(D.ACTUAL,2) A6 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND SUBSTR(S.STRDATE,0,6)=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC6  ")
	         .append(" ON MEA.MCID=SC6.M6  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT S.SCORE S7, S.MEASUREID M7,S.GRADE G7,ROUND(D.ACTUAL,2) A7 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND SUBSTR(S.STRDATE,0,6)=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC7  ")
	         .append(" ON MEA.MCID=SC7.M7  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT S.SCORE S8, S.MEASUREID M8,S.GRADE G8,ROUND(D.ACTUAL,2) A8 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND SUBSTR(S.STRDATE,0,6)=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC8  ")
	         .append(" ON MEA.MCID=SC8.M8  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT S.SCORE S9, S.MEASUREID M9,S.GRADE G9,ROUND(D.ACTUAL,2) A9 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND SUBSTR(S.STRDATE,0,6)=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC9  ")
	         .append(" ON MEA.MCID=SC9.M9  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT S.SCORE S10, S.MEASUREID M10,S.GRADE G10,ROUND(D.ACTUAL,2) A10 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND SUBSTR(S.STRDATE,0,6)=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC10  ")
	         .append(" ON MEA.MCID=SC10.M10  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT S.SCORE S11, S.MEASUREID M11,S.GRADE G11,ROUND(D.ACTUAL,2) A11 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND SUBSTR(S.STRDATE,0,6)=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC11  ")
	         .append(" ON MEA.MCID=SC11.M11  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT S.SCORE S12, S.MEASUREID M12,S.GRADE G12,ROUND(D.ACTUAL,2) A12 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND SUBSTR(S.STRDATE,0,6)=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC12  ")
	         .append(" ON MEA.MCID=SC12.M12  ")
	         .append(" ORDER BY BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");

			ResultSet rs = executePreparedQuery(sql.toString(),new Object[]{year,bscId,year,year,year,year+"01",year+"02",year+"03",year+"04",year+"05",year+"06",year+"07",year+"08",year+"09",year+"10",year+"11",year+"12"});

			treeroot = new TreeNode();
			treeroot.id=-1;
			TreeNode pst=null; TreeNode obj=null; TreeMeasure mea=null;
			while (rs.next()){
				if (treeroot==null || treeroot.id != rs.getInt("BID")){
					if (0!=rs.getInt("BID")){
						treeroot.id  = rs.getInt("BID");
						treeroot.pid = rs.getInt("BPID");
						treeroot.cid = rs.getInt("BCID");
						treeroot.name = rs.getString("BNAME");
						//treeroot.weight = rs.getDouble("BWEIGHT");
						treeroot.level = 2;
						treeroot.orderby = rs.getInt("BRANK");
					}
				}
				if (pst==null||pst.id != rs.getInt("PID")){
					pst = null;
					if (0!=rs.getInt("PID")){
						pst = new TreeNode();
						pst.id = rs.getInt("PID");
						pst.pid = rs.getInt("PPID");
						pst.cid = rs.getInt("PCID");
						pst.name = rs.getString("PNAME");
						//pst.weight = rs.getDouble("PWEIGHT");
						pst.level = 3;
						pst.orderby = rs.getInt("PRANK");
						pst.parent = treeroot;
						if (treeroot != null) treeroot.addChild(pst);
					}
				}
				if (obj==null||obj.id !=rs.getInt("oid")){
					obj = null;
					if (0!= rs.getInt("OID")){
						obj = new TreeNode();
						obj.id = rs.getInt("OID");
						obj.pid = rs.getInt("OPID");
						obj.cid = rs.getInt("OCID");
						obj.name = rs.getString("ONAME");
						//obj.weight = rs.getDouble("OWEIGHT");
						obj.level = 4;
						obj.orderby = rs.getInt("ORANK");
						obj.parent = pst;
						if (pst!= null) pst.addChild(obj);
					}
				}
				if (0!=rs.getInt("MID")){
					mea = new TreeMeasure();
					mea.id = rs.getInt("MID");
					mea.pid = rs.getInt("MPID");
					mea.cid = rs.getInt("MCID");
					mea.name = rs.getString("MNAME");
					mea.weight = rs.getDouble("MWEIGHT");
					mea.level = 5;
					mea.orderby = rs.getInt("MRANK");
					mea.parent = obj;
					mea.unit      = rs.getObject("UNIT")!=null?rs.getString("UNIT"):"";
					mea.frequency = rs.getObject("FREQUENCY")!=null?rs.getString("FREQUENCY"):"";
					mea.measurement = rs.getObject("MEASUREMENT")!=null?rs.getString("MEASUREMENT"):"";


					mea.planned     = rs.getDouble("PLANNED");
					mea.plannedbase = rs.getDouble("PLANNEDBASE");
					mea.base        = rs.getDouble("BASE");
					mea.baselimit   = rs.getDouble("BASELIMIT");
					mea.limit       = rs.getDouble("LIMIT");

					if (obj!= null) obj.addChild(mea);

					for (int m=0;m<12;m++){
						if (rs.getObject("S"+(m+1))!=null)
							mea.setScore(m, rs.getDouble("S"+(m+1)));

						if (rs.getObject("A"+(m+1))!=null)
							mea.actual[m]=rs.getDouble("A"+(m+1));

						if (rs.getObject("G"+(m+1))!=null)
							mea.grade[m]=rs.getString("G"+(m+1));
					}
				}
			}

		} catch (SQLException se){
			System.out.println(se);
			throw se;
		} catch (Exception e){
			System.out.println(e);
		}
		return treeroot;
	}

	public TreeNode getTreeRootAll(String year) throws SQLException{

		TreeNode treeroot = null;
		try{
			StringBuffer sql = new StringBuffer();

			sql.append(" SELECT * FROM   ")
	         .append(" (SELECT T.ID CID,T.PARENTID CPID,T.CONTENTID CCID,T.TREELEVEL CLEVEL,T.RANK CRANK,T.WEIGHT CWEIGHT,C.NAME CNAME   ")
	         .append(" FROM TBLHIERARCHY T,TBLCOMPANY C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=0 AND T.YEAR=? ) COM ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME   ")
	         .append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? ) SBU  ")
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
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.UNIT,D.FREQUENCY,D.PLANNED,D.BASE,D.LIMIT  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S1, MEASUREID M1 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC1 ")
	         .append(" ON MEA.MCID=SC1.M1 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S2, MEASUREID M2 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC2 ")
	         .append(" ON MEA.MCID=SC2.M2 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S3, MEASUREID M3 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC3 ")
	         .append(" ON MEA.MCID=SC3.M3 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S4, MEASUREID M4 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC4 ")
	         .append(" ON MEA.MCID=SC4.M4 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S5, MEASUREID M5 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC5 ")
	         .append(" ON MEA.MCID=SC5.M5 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S6, MEASUREID M6 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC6 ")
	         .append(" ON MEA.MCID=SC6.M6 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S7, MEASUREID M7 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC7 ")
	         .append(" ON MEA.MCID=SC7.M7 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S8, MEASUREID M8 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC8 ")
	         .append(" ON MEA.MCID=SC8.M8 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S9, MEASUREID M9 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC9 ")
	         .append(" ON MEA.MCID=SC9.M9 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S10, MEASUREID M10 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC10 ")
	         .append(" ON MEA.MCID=SC10.M10 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S11, MEASUREID M11 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC11 ")
	         .append(" ON MEA.MCID=SC11.M11 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S12, MEASUREID M12 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC12 ")
	         .append(" ON MEA.MCID=SC12.M12 ")
	         .append(" ORDER BY BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");

			ResultSet rs = executePreparedQuery(sql.toString(),new Object[]{year,year,year,year,year,year,year+"01",year+"02",year+"03",year+"04",year+"05",year+"06",year+"07",year+"08",year+"09",year+"10",year+"11",year+"12"});

			treeroot = new TreeNode();
			treeroot.id=-1;
			treeroot.level=-1;

			TreeNode com=null; TreeNode sbu=null; TreeNode bsc=null;
			TreeNode pst=null; TreeNode obj=null; TreeMeasure mea=null;
			while (rs.next()){
				if (com==null || com.id != rs.getInt("CID")){
					if (0!=rs.getInt("CID")){
						com = new TreeNode();
						com.id = rs.getInt("CID");
						com.pid = rs.getInt("CPID");
						com.cid = rs.getInt("CCID");
						com.name = rs.getString("CNAME");
						//com.weight = rs.getDouble("CWEIGHT");
						com.level = 0;
						com.orderby = rs.getInt("CRANK");
						com.parent = treeroot;
						if (treeroot !=null) treeroot.addChild(com);
					}
				}
				if (sbu==null || sbu.id != rs.getInt("SID")){
					if (0!=rs.getInt("SID")){
						sbu = new TreeNode();
						sbu.id = rs.getInt("SID");
						sbu.pid = rs.getInt("SPID");
						sbu.cid = rs.getInt("SCID");
						sbu.name = rs.getString("SNAME");
						//sbu.weight = rs.getDouble("SWEIGHT");
						sbu.level = 1;
						sbu.orderby = rs.getInt("SRANK");
						sbu.parent = com;
						if (com !=null) com.addChild(sbu);
					}
				}
				if (bsc==null || bsc.id != rs.getInt("BID")){
					if (0!=rs.getInt("BID")){
						bsc = new TreeNode();
						bsc.id = rs.getInt("BID");
						bsc.pid = rs.getInt("BPID");
						bsc.cid = rs.getInt("BCID");
						bsc.name = rs.getString("BNAME");
						//bsc.weight = rs.getDouble("BWEIGHT");
						bsc.level = 2;
						bsc.orderby = rs.getInt("BRANK");
						bsc.parent = sbu;
						if (sbu !=null) sbu.addChild(bsc);
					}
				}
				if (pst==null||pst.id != rs.getInt("PID")){
					pst = null;
					if (0!=rs.getInt("PID")){
						pst = new TreeNode();
						pst.id = rs.getInt("PID");
						pst.pid = rs.getInt("PPID");
						pst.cid = rs.getInt("PCID");
						pst.name = rs.getString("PNAME");
						//pst.weight = rs.getDouble("PWEIGHT");
						pst.level = 3;
						pst.orderby = rs.getInt("PRANK");
						pst.parent = sbu;
						if (treeroot != null) bsc.addChild(pst);
					}
				}
				if (obj==null||obj.id !=rs.getInt("oid")){
					obj = null;
					if (0!= rs.getInt("OID")){
						obj = new TreeNode();
						obj.id = rs.getInt("OID");
						obj.pid = rs.getInt("OPID");
						obj.cid = rs.getInt("OCID");
						obj.name = rs.getString("ONAME");
						//obj.weight = rs.getDouble("OWEIGHT");
						obj.level = 4;
						obj.orderby = rs.getInt("ORANK");
						obj.parent = pst;
						if (pst!= null) pst.addChild(obj);
					}
				}
				if (0!=rs.getInt("MID")){
					mea = new TreeMeasure();
					mea.id = rs.getInt("MID");
					mea.pid = rs.getInt("MPID");
					mea.cid = rs.getInt("MCID");
					mea.name = rs.getString("MNAME");
					mea.weight = rs.getDouble("MWEIGHT");
					mea.level = 5;
					mea.orderby = rs.getInt("MRANK");
					mea.parent = obj;
					mea.unit = rs.getObject("UNIT")!=null?rs.getString("UNIT"):"";
					mea.frequency = rs.getObject("FREQUENCY")!=null?rs.getString("FREQUENCY"):"";

					mea.planned = rs.getDouble("PLANNED");
					mea.base = rs.getDouble("BASE");
					mea.limit = rs.getDouble("LIMIT");

					if (obj!= null) obj.addChild(mea);

					for (int m=0;m<12;m++){
						if (rs.getObject("S"+(m+1))!=null)
							mea.setScore(m,rs.getDouble("S"+(m+1)));
					}
				}
			}

		} catch (SQLException se){
			System.out.println(se);
			throw se;
		} catch (Exception e){
			System.out.println(e);
		}
		return treeroot;
	}

	public TreeNode getTreeDivision(String year,String sbuId) throws SQLException{

		TreeNode treeroot = null;
		try{
			StringBuffer sql = new StringBuffer();

			sql.append(" SELECT * FROM   ")
	         .append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME   ")
	         .append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? AND T.ID=? ) SBU  ")
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
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.UNIT,D.FREQUENCY,D.PLANNED,D.BASE,D.LIMIT  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S1, MEASUREID M1 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC1 ")
	         .append(" ON MEA.MCID=SC1.M1 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S2, MEASUREID M2 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC2 ")
	         .append(" ON MEA.MCID=SC2.M2 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S3, MEASUREID M3 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC3 ")
	         .append(" ON MEA.MCID=SC3.M3 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S4, MEASUREID M4 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC4 ")
	         .append(" ON MEA.MCID=SC4.M4 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S5, MEASUREID M5 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC5 ")
	         .append(" ON MEA.MCID=SC5.M5 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S6, MEASUREID M6 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC6 ")
	         .append(" ON MEA.MCID=SC6.M6 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S7, MEASUREID M7 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC7 ")
	         .append(" ON MEA.MCID=SC7.M7 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S8, MEASUREID M8 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC8 ")
	         .append(" ON MEA.MCID=SC8.M8 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S9, MEASUREID M9 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC9 ")
	         .append(" ON MEA.MCID=SC9.M9 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S10, MEASUREID M10 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC10 ")
	         .append(" ON MEA.MCID=SC10.M10 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S11, MEASUREID M11 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC11 ")
	         .append(" ON MEA.MCID=SC11.M11 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S12, MEASUREID M12 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC12 ")
	         .append(" ON MEA.MCID=SC12.M12 ")
	         .append(" ORDER BY BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");

			ResultSet rs = executePreparedQuery(sql.toString(),new Object[]{year,sbuId,year,year,year,year,year+"01",year+"02",year+"03",year+"04",year+"05",year+"06",year+"07",year+"08",year+"09",year+"10",year+"11",year+"12"});

			treeroot = new TreeNode();
			treeroot.id=-1;
			treeroot.level=-1;

			TreeNode com=null; TreeNode sbu=null; TreeNode bsc=null;
			TreeNode pst=null; TreeNode obj=null; TreeMeasure mea=null;
			while (rs.next()){

				if (sbu==null || sbu.id != rs.getInt("SID")){
					if (0!=rs.getInt("SID")){
						sbu = new TreeNode();
						sbu.id = rs.getInt("SID");
						sbu.pid = rs.getInt("SPID");
						sbu.cid = rs.getInt("SCID");
						sbu.name = rs.getString("SNAME");
						//sbu.weight = rs.getDouble("SWEIGHT");
						sbu.level = 1;
						sbu.orderby = rs.getInt("SRANK");
						sbu.parent = treeroot;
						if (treeroot !=null) treeroot.addChild(sbu);
					}
				}
				if (bsc==null || bsc.id != rs.getInt("BID")){
					if (0!=rs.getInt("BID")){
						bsc = new TreeNode();
						bsc.id = rs.getInt("BID");
						bsc.pid = rs.getInt("BPID");
						bsc.cid = rs.getInt("BCID");
						bsc.name = rs.getString("BNAME");
						//bsc.weight = rs.getDouble("BWEIGHT");
						bsc.level = 2;
						bsc.orderby = rs.getInt("BRANK");
						bsc.parent = sbu;
						if (sbu !=null) sbu.addChild(bsc);
					}
				}
				if (pst==null||pst.id != rs.getInt("PID")){
					pst = null;
					if (0!=rs.getInt("PID")){
						pst = new TreeNode();
						pst.id = rs.getInt("PID");
						pst.pid = rs.getInt("PPID");
						pst.cid = rs.getInt("PCID");
						pst.name = rs.getString("PNAME");
						//pst.weight = rs.getDouble("PWEIGHT");
						pst.level = 3;
						pst.orderby = rs.getInt("PRANK");
						pst.parent = treeroot;
						if (bsc != null) bsc.addChild(pst);
					}
				}
				if (obj==null||obj.id !=rs.getInt("oid")){
					obj = null;
					if (0!= rs.getInt("OID")){
						obj = new TreeNode();
						obj.id = rs.getInt("OID");
						obj.pid = rs.getInt("OPID");
						obj.cid = rs.getInt("OCID");
						obj.name = rs.getString("ONAME");
						//obj.weight = rs.getDouble("OWEIGHT");
						obj.level = 4;
						obj.orderby = rs.getInt("ORANK");
						obj.parent = pst;
						if (pst!= null) pst.addChild(obj);
					}
				}
				if (0!=rs.getInt("MID")){
					mea = new TreeMeasure();
					mea.id = rs.getInt("MID");
					mea.pid = rs.getInt("MPID");
					mea.cid = rs.getInt("MCID");
					mea.name = rs.getString("MNAME");
					mea.weight = rs.getDouble("MWEIGHT");
					mea.level = 5;
					mea.orderby = rs.getInt("MRANK");
					mea.parent = obj;
					mea.unit = rs.getObject("UNIT")!=null?rs.getString("UNIT"):"";
					mea.frequency = rs.getObject("FREQUENCY")!=null?rs.getString("FREQUENCY"):"";

					mea.planned = rs.getDouble("PLANNED");
					mea.base = rs.getDouble("BASE");
					mea.limit = rs.getDouble("LIMIT");

					if (obj!= null) obj.addChild(mea);

					for (int m=0;m<12;m++){
						if (rs.getObject("S"+(m+1))!=null)
							mea.setScore(m,rs.getDouble("S"+(m+1)));
					}
				}
			}

		} catch (SQLException se){
			System.out.println(se);
			throw se;
		} catch (Exception e){
			System.out.println(e);
		}
		return treeroot;
	}
	public TreeNode getTreeAnnually (String year,String sbuId) throws SQLException{

		TreeNode treeroot = null;
		try{
			StringBuffer sql = new StringBuffer();

			sql.append(" SELECT * FROM   ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? AND T.CONTENTID=?) BSC ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
	         .append(" ON BSC.BID=PST.PPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
	         .append(" ON PST.PID=OBJ.OPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.UNIT,D.FREQUENCY,D.PLANNED,D.BASE,D.LIMIT  ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA ")
	         .append(" ON OBJ.OID=MEA.MPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S1, MEASUREID M1 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC1 ")
	         .append(" ON MEA.MCID=SC1.M1 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S2, MEASUREID M2 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC2 ")
	         .append(" ON MEA.MCID=SC2.M2 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S3, MEASUREID M3 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC3 ")
	         .append(" ON MEA.MCID=SC3.M3 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S4, MEASUREID M4 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC4 ")
	         .append(" ON MEA.MCID=SC4.M4 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S5, MEASUREID M5 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC5 ")
	         .append(" ON MEA.MCID=SC5.M5 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S6, MEASUREID M6 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC6 ")
	         .append(" ON MEA.MCID=SC6.M6 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S7, MEASUREID M7 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC7 ")
	         .append(" ON MEA.MCID=SC7.M7 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S8, MEASUREID M8 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC8 ")
	         .append(" ON MEA.MCID=SC8.M8 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S9, MEASUREID M9 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC9 ")
	         .append(" ON MEA.MCID=SC9.M9 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S10, MEASUREID M10 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC10 ")
	         .append(" ON MEA.MCID=SC10.M10 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S11, MEASUREID M11 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC11 ")
	         .append(" ON MEA.MCID=SC11.M11 ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT SCORE S12, MEASUREID M12 FROM TBLMEASURESCORE WHERE SUBSTR(STRDATE,0,6)=? ) SC12 ")
	         .append(" ON MEA.MCID=SC12.M12 ")
	         .append(" ORDER BY BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");

			ResultSet rs = executePreparedQuery(sql.toString(),new Object[]{year,sbuId,year,year,year,year+"01",year+"02",year+"03",year+"04",year+"05",year+"06",year+"07",year+"08",year+"09",year+"10",year+"11",year+"12"});

			treeroot = new TreeNode();
			treeroot.id=-1;
			treeroot.level=-1;

			TreeNode com=null; TreeNode sbu=null; TreeNode bsc=null;
			TreeNode pst=null; TreeNode obj=null; TreeMeasure mea=null;
			while (rs.next()){

				if (bsc==null || bsc.id != rs.getInt("BID")){
					if (0!=rs.getInt("BID")){
						bsc = new TreeNode();
						bsc.id = rs.getInt("BID");
						bsc.pid = rs.getInt("BPID");
						bsc.cid = rs.getInt("BCID");
						bsc.name = rs.getString("BNAME");
						//bsc.weight = rs.getDouble("BWEIGHT");
						bsc.level = 2;
						bsc.orderby = rs.getInt("BRANK");
						bsc.parent = treeroot;
						if (treeroot !=null) treeroot.addChild(bsc);
					}
				}
				if (pst==null||pst.id != rs.getInt("PID")){
					pst = null;
					if (0!=rs.getInt("PID")){
						pst = new TreeNode();
						pst.id = rs.getInt("PID");
						pst.pid = rs.getInt("PPID");
						pst.cid = rs.getInt("PCID");
						pst.name = rs.getString("PNAME");
						//pst.weight = rs.getDouble("PWEIGHT");
						pst.level = 3;
						pst.orderby = rs.getInt("PRANK");
						pst.parent = treeroot;
						if (bsc != null) bsc.addChild(pst);
					}
				}
				if (obj==null||obj.id !=rs.getInt("oid")){
					obj = null;
					if (0!= rs.getInt("OID")){
						obj = new TreeNode();
						obj.id = rs.getInt("OID");
						obj.pid = rs.getInt("OPID");
						obj.cid = rs.getInt("OCID");
						obj.name = rs.getString("ONAME");
						//obj.weight = rs.getDouble("OWEIGHT");
						obj.level = 4;
						obj.orderby = rs.getInt("ORANK");
						obj.parent = pst;
						if (pst!= null) pst.addChild(obj);
					}
				}
				if (0!=rs.getInt("MID")){
					mea = new TreeMeasure();
					mea.id = rs.getInt("MID");
					mea.pid = rs.getInt("MPID");
					mea.cid = rs.getInt("MCID");
					mea.name = rs.getString("MNAME");
					mea.weight = rs.getDouble("MWEIGHT");
					mea.level = 5;
					mea.orderby = rs.getInt("MRANK");
					mea.parent = obj;
					mea.unit = rs.getObject("UNIT")!=null?rs.getString("UNIT"):"";
					mea.frequency = rs.getObject("FREQUENCY")!=null?rs.getString("FREQUENCY"):"";

					mea.planned = rs.getDouble("PLANNED");
					mea.base = rs.getDouble("BASE");
					mea.limit = rs.getDouble("LIMIT");

					if (obj!= null) obj.addChild(mea);

					for (int m=0;m<12;m++){
						if (rs.getObject("S"+(m+1))!=null)
							mea.setScore(m,rs.getDouble("S"+(m+1)));
					}
				}
			}

		} catch (SQLException se){
			System.out.println(se);
			throw se;
		} catch (Exception e){
			System.out.println(e);
		}
		return treeroot;
	}

	public TreeNode getCylinderScore(String year) throws SQLException{

		TreeNode treeroot = null;
		try{
			StringBuffer sql = new StringBuffer();

			sql.append(" SELECT * FROM   ")
			 .append(" (SELECT * FROM TBLMAPPROPERTY) PRO ")
			 .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME   ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC  ")
	         .append(" ON PRO.DIVID=BSC.BCID ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME   ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST  ")
	         .append(" ON BSC.BID=PST.PPID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME   ")
	         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ  ")
	         .append(" ON PST.PID=OBJ.OPID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.UNIT,D.FREQUENCY,D.PLANNED,D.BASE,D.LIMIT   ")
	         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA  ")
	         .append(" ON OBJ.OID=MEA.MPID  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT SCORE S1, S.MEASUREID M1,ROUND(D.ACTUAL,2) A1 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND S.STRDATE=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC1  ")
	         .append(" ON MEA.MCID=SC1.M1  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT SCORE S2, S.MEASUREID M2,ROUND(D.ACTUAL,2) A2 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND S.STRDATE=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC2  ")
	         .append(" ON MEA.MCID=SC2.M2  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT SCORE S3, S.MEASUREID M3,ROUND(D.ACTUAL,2) A3 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND S.STRDATE=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC3  ")
	         .append(" ON MEA.MCID=SC3.M3  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT SCORE S4, S.MEASUREID M4,ROUND(D.ACTUAL,2) A4 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND S.STRDATE=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC4  ")
	         .append(" ON MEA.MCID=SC4.M4  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT SCORE S5, S.MEASUREID M5,ROUND(D.ACTUAL,2) A5 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND S.STRDATE=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC5  ")
	         .append(" ON MEA.MCID=SC5.M5  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT SCORE S6, S.MEASUREID M6,ROUND(D.ACTUAL,2) A6 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND S.STRDATE=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC6  ")
	         .append(" ON MEA.MCID=SC6.M6  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT SCORE S7, S.MEASUREID M7,ROUND(D.ACTUAL,2) A7 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND S.STRDATE=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC7  ")
	         .append(" ON MEA.MCID=SC7.M7  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT SCORE S8, S.MEASUREID M8,ROUND(D.ACTUAL,2) A8 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND S.STRDATE=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC8  ")
	         .append(" ON MEA.MCID=SC8.M8  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT SCORE S9, S.MEASUREID M9,ROUND(D.ACTUAL,2) A9 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND S.STRDATE=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC9  ")
	         .append(" ON MEA.MCID=SC9.M9  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT SCORE S10, S.MEASUREID M10,ROUND(D.ACTUAL,2) A10 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND S.STRDATE=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC10  ")
	         .append(" ON MEA.MCID=SC10.M10  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT SCORE S11, S.MEASUREID M11,ROUND(D.ACTUAL,2) A11 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND S.STRDATE=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC11  ")
	         .append(" ON MEA.MCID=SC11.M11  ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT SCORE S12, S.MEASUREID M12,ROUND(D.ACTUAL,2) A12 FROM TBLMEASURESCORE S, TBLMEASUREDETAIL D WHERE S.MEASUREID=D.MEASUREID(+) AND S.STRDATE=D.STRDATE(+) AND SUBSTR(S.STRDATE,0,6)=? ) SC12  ")
	         .append(" ON MEA.MCID=SC12.M12  ")
	         .append(" ORDER BY KINDLEVEL,BRANK,BID,PRANK,PID,ORANK,OID,MRANK ");

			ResultSet rs = executePreparedQuery(sql.toString(),new Object[]{year,year,year,year,year+"01",year+"02",year+"03",year+"04",year+"05",year+"06",year+"07",year+"08",year+"09",year+"10",year+"11",year+"12"});

			treeroot = new TreeNode();
			treeroot.id=-1;
			TreeNode bsc=null; TreeNode pst=null; TreeNode obj=null; TreeMeasure mea=null;
			while (rs.next()){
				if (bsc==null || bsc.id != rs.getInt("BID")){
					if (0!=rs.getInt("BID")){
						bsc = new TreeNode();
						bsc.id  = rs.getInt("BID");
						bsc.pid = rs.getInt("BPID");
						bsc.cid = rs.getInt("BCID");
						bsc.name = rs.getString("BNAME");
						//bsc.weight = rs.getDouble("BWEIGHT");
						bsc.level = 2;
						bsc.orderby = rs.getInt("BRANK");
						bsc.parent=treeroot;
						bsc.cylinderId = rs.getInt("CYLINDERID");
						if (treeroot!=null)treeroot.addChild(bsc);
					}
				}
				if (pst==null||pst.id != rs.getInt("PID")){
					pst = null;
					if (0!=rs.getInt("PID")){
						pst = new TreeNode();
						pst.id = rs.getInt("PID");
						pst.pid = rs.getInt("PPID");
						pst.cid = rs.getInt("PCID");
						pst.name = rs.getString("PNAME");
						//pst.weight = rs.getDouble("PWEIGHT");
						pst.level = 3;
						pst.orderby = rs.getInt("PRANK");
						pst.parent = treeroot;
						if (bsc != null) bsc.addChild(pst);
					}
				}
				if (obj==null||obj.id !=rs.getInt("oid")){
					obj = null;
					if (0!= rs.getInt("OID")){
						obj = new TreeNode();
						obj.id = rs.getInt("OID");
						obj.pid = rs.getInt("OPID");
						obj.cid = rs.getInt("OCID");
						obj.name = rs.getString("ONAME");
						//obj.weight = rs.getDouble("OWEIGHT");
						obj.level = 4;
						obj.orderby = rs.getInt("ORANK");
						obj.parent = pst;
						if (pst!= null) pst.addChild(obj);
					}
				}
				if (0!=rs.getInt("MID")){
					mea = new TreeMeasure();
					mea.id = rs.getInt("MID");
					mea.pid = rs.getInt("MPID");
					mea.cid = rs.getInt("MCID");
					mea.name = rs.getString("MNAME");
					mea.weight = rs.getDouble("MWEIGHT");
					mea.level = 5;
					mea.orderby = rs.getInt("MRANK");
					mea.parent = obj;
					mea.unit = rs.getObject("UNIT")!=null?rs.getString("UNIT"):"";
					mea.frequency = rs.getObject("FREQUENCY")!=null?rs.getString("FREQUENCY"):"";

					mea.planned = rs.getDouble("PLANNED");
					mea.base = rs.getDouble("BASE");
					mea.limit = rs.getDouble("LIMIT");

					if (obj!= null) obj.addChild(mea);

					for (int m=0;m<12;m++){
						if (rs.getObject("S"+(m+1))!=null)
							mea.setScore(m,rs.getDouble("S"+(m+1)));

						if (rs.getObject("A"+(m+1))!=null)
							mea.actual[m]=rs.getDouble("A"+(m+1));
					}
				}
			}

		} catch (SQLException se){
			System.out.println(se);
			throw se;
		} catch (Exception e){
			System.out.println(e);
		}
		return treeroot;
	}
}
