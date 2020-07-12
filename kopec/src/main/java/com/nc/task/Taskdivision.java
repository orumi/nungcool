package com.nc.task;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class Taskdivision {
	
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
				.append(" FROM TBLSTRATPROJECTINFO P ORDER BY TYPEID,FIELDID");
			
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
	}//-- method setDivision
	
	public void setDetail(HttpServletRequest request, HttpServletResponse response) {
		ResultSet rs = null;
		DataSet ds = null;
		CoolConnection conn = null;
		DBObject dbobject = null;

		try {
			ds = new DataSet();
			StringBuffer strSQL = new StringBuffer();
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if (dbobject==null) dbobject = new DBObject(conn.getConnection());

			String bscId = request.getParameter("bscId");
			String pBscId = request.getParameter("pBscId");
			String typeid = request.getParameter("typeId");
			if ((bscId==null)||(pBscId==null)) return;

			strSQL.append(" select ")
	         .append(" min(SYEAR) as minYear, ")
	         .append(" max(EYEAR) as maxYear  ")
	         .append(" from tblstratprojectdetail where DETAILID IN ( ")
	         .append(" SELECT DETAILID FROM ( ")
	         .append(" SELECT ID,NAME FROM TBLOBJECTIVE WHERE ID IN ( ")
	         .append(" SELECT OCID FROM  ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
	         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.CONTENTID=? ) BSC ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
	         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 ) PST ")
	         .append(" ON BSC.BID=PST.PPID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
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
	         .append(" ON OBJ.ID=INI.OBJID AND INI.BSCID=? WHERE DETAILID IS NOT NULL ")
	         .append(" GROUP BY DETAILID ")
	         .append(" ) ");

			String bId = "-1".equals(bscId)?pBscId:bscId;
			Object param[] = {bId,bId};

			rs = dbobject.executePreparedQuery(strSQL.toString(), param);
			ds.load(rs);
			request.setAttribute("year", ds);


			strSQL = null; strSQL = new StringBuffer();
			ds = new DataSet();

			StringBuffer strSQLS = new StringBuffer();
			strSQLS.append("SELECT *  ") ;
			strSQLS.append("FROM  ") ;
			strSQLS.append("(  ") ;
			strSQLS.append("      (  ") ;
			strSQLS.append("      SELECT STOPYN, PROJECTNAME, PROJECTID, EXECWORK, DNAME, SYEAR, EYEAR,SQTR, EQTR,DETAILID,DYEAR,DID,ROUND(QTRGOAL,2) AS QTRGOAL,ROUND(QTRACHV,2) AS QTRACHV,round(REALIZE,2) as REALIZE,AYEAR,AQTR, DETAILID ADID, 0 SDTLID, 0 LEV  ") ;
			strSQLS.append("      FROM  ") ;
			strSQLS.append("            (  ") ;
			strSQLS.append("            SELECT SP.NAME  PROJECTNAME,  ") ;
			strSQLS.append("                   P.PROJECTID,  ") ;
			strSQLS.append("                   D.EXECWORK,  ") ;
			strSQLS.append("                   (SELECT TRIM(NAME) FROM TBLBSC WHERE ID= D.MGRDEPT ) DNAME,    ") ;
			strSQLS.append("                   D.SYEAR, DECODE(D.STOPYN, 'Y', D.STOPYEAR, D.EYEAR) AS EYEAR,  ") ;
			strSQLS.append("                   D.SQTR, DECODE(D.STOPYN, 'Y', D.STOPQTR, D.EQTR) AS EQTR,  ") ;
			strSQLS.append("                   D.DETAILID,  ") ;
			strSQLS.append("                   D.STOPYN  ") ;
			strSQLS.append("            FROM TBLSTRATPROJECTDETAIL D, TBLSTRATPROJECTINFO P,TBLSTRATPROJECT SP  ") ;
			strSQLS.append("            WHERE D.PROJECTID=P.PROJECTID  ") ;
			strSQLS.append("              AND p.typeid = ?                            ") ;
			strSQLS.append("              AND SP.ID = P.CONTENTID  ") ;
			strSQLS.append("              AND D.DETAILID IN (  ") ;
			strSQLS.append("                     SELECT DETAILID  ") ;
			strSQLS.append("                     FROM  ") ;
			strSQLS.append("                         (  ") ;
			strSQLS.append("                          SELECT ID,NAME  ") ;
			strSQLS.append("                          FROM TBLOBJECTIVE  ") ;
			strSQLS.append("                          WHERE ID IN (  ") ;
			strSQLS.append("                                 SELECT OCID FROM  ") ;
			strSQLS.append("                                 ( SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ") ;
			strSQLS.append("                                  FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.CONTENTID=?) BSC    ") ;
			strSQLS.append("                                  LEFT JOIN  ") ;
			strSQLS.append("                                 (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ") ;
			strSQLS.append("                                 FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 ) PST  ") ;
			strSQLS.append("                                  ON BSC.BID=PST.PPID  ") ;
			strSQLS.append("                                  LEFT JOIN  ") ;
			strSQLS.append("                                 (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ") ;
			strSQLS.append("                                  FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 ) OBJ  ") ;
			strSQLS.append("                                  ON PST.PID=OBJ.OPID  ") ;
			strSQLS.append("                           )  ") ;
			strSQLS.append("                          ) OBJ  ") ;
			strSQLS.append("                           LEFT JOIN  ") ;
			strSQLS.append("                          (  ") ;
			strSQLS.append("                            SELECT I.BSCID,I.OBJID,I.DETAILID,I.PROJECTID,D.EXECWORK,D.NAME PNAME,D.TNAME FROM (SELECT I.BSCID,I.OBJID,I.DETAILID,I.PROJECTID FROM TBLINITIATIVE I) I  ") ;
			strSQLS.append("                            LEFT JOIN  ") ;
			strSQLS.append("                             ( SELECT D.PROJECTID,D.DETAILID, D.EXECWORK,C.NAME,(SELECT TYPENAME FROM TBLSTRATTYPEINFO T WHERE T.TYPEID=P.TYPEID) TNAME  ") ;
			strSQLS.append("                               FROM TBLSTRATPROJECTDETAIL D, TBLSTRATPROJECTINFO P,TBLSTRATPROJECT C  ") ;
			strSQLS.append("                               WHERE D.PROJECTID=P.PROJECTID AND P.CONTENTID=C.ID ) D  ") ;
			strSQLS.append("                               ON I.PROJECTID=D.PROJECTID AND I.DETAILID=D.DETAILID  ") ;
			strSQLS.append("                           ) INI  ") ;
			strSQLS.append("                           ON OBJ.ID=INI.OBJID AND INI.BSCID=? WHERE DETAILID IS NOT NULL     ") ;
			strSQLS.append("                       )  ") ;
			strSQLS.append("            ) D  ") ;
			strSQLS.append("            LEFT JOIN  ") ;
			strSQLS.append("            (  ") ;
			strSQLS.append("             SELECT CASE WHEN (MAX(YEAR||QTR) > case when to_number(to_char(sysdate,'mm')) >= 1 and to_number(to_char(sysdate, 'mm')) <= 3 then to_char(sysdate,'yyyy')||1  ") ;
			strSQLS.append("                                                     when to_number(to_char(sysdate,'mm')) >= 4 and to_number(to_char(sysdate, 'mm')) <= 6 then to_char(sysdate,'yyyy')||2  ") ;
			strSQLS.append("                                                     when to_number(to_char(sysdate,'mm')) >= 7 and to_number(to_char(sysdate, 'mm')) <= 9 then to_char(sysdate,'yyyy')||3  ") ;
			strSQLS.append("                                                     when to_number(to_char(sysdate,'mm')) >= 10 and to_number(to_char(sysdate, 'mm')) <= 12 then to_char(sysdate,'yyyy')||4  ") ;
			strSQLS.append("                                                end  ") ;
			strSQLS.append("                              )  ") ;
			strSQLS.append("                         THEN case when to_number(to_char(sysdate,'mm')) >= 1 and to_number(to_char(sysdate, 'mm')) <= 3 then to_char(sysdate,'yyyy')||1  ") ;
			strSQLS.append("                                   when to_number(to_char(sysdate,'mm')) >= 4 and to_number(to_char(sysdate, 'mm')) <= 6 then to_char(sysdate,'yyyy')||2  ") ;
			strSQLS.append("                                   when to_number(to_char(sysdate,'mm')) >= 7 and to_number(to_char(sysdate, 'mm')) <= 9 then to_char(sysdate,'yyyy')||3  ") ;
			strSQLS.append("                                   when to_number(to_char(sysdate,'mm')) >= 10 and to_number(to_char(sysdate, 'mm')) <= 12 then to_char(sysdate,'yyyy')||4  ") ;
			strSQLS.append("                              end  ") ;
			strSQLS.append("                         ELSE MAX(YEAR||QTR) END DYEAR, DETAILID DID  ") ;
			strSQLS.append("             FROM TBLSTRATACHVREGI  ") ;
			strSQLS.append("             WHERE REALIZE<>0  ") ;
			strSQLS.append("             GROUP BY DETAILID  ") ;
			strSQLS.append("            ) A  ") ;
			strSQLS.append("            ON A.DID=D.DETAILID  ") ;
			strSQLS.append("            LEFT JOIN  ") ;
			strSQLS.append("            (  ") ;
			strSQLS.append("            SELECT QTRGOAL,  ") ;
			strSQLS.append("                   QTRACHV,  ") ;
			strSQLS.append("                   REALIZE,  ") ;
			strSQLS.append("                   YEAR AYEAR,  ") ;
			strSQLS.append("                   QTR AQTR,  ") ;
			strSQLS.append("                   DETAILID ADID  ") ;
			strSQLS.append("            FROM TBLSTRATACHVREGI  ") ;
			strSQLS.append("            ) ACH  ") ;
			strSQLS.append("            ON A.DYEAR=ACH.AYEAR||AQTR AND A.DID=ACH.ADID  ") ;
			strSQLS.append("      )  ") ;
			strSQLS.append("      UNION ALL  ") ;
			strSQLS.append("      (  ") ;
			strSQLS.append("      SELECT STOPYN, PROJECTNAME, PROJECTID, EXECWORK,DNAME, SYEAR, EYEAR,SQTR, EQTR,DETAILID,DYEAR,DID,ROUND(QTRGOAL,2) AS QTRGOAL,ROUND(QTRACHV,2) AS QTRACHV ,round(REALIZE,2) as REALIZE,AYEAR,AQTR, DETAILID ADID , SDTLID, 1 LEV  ") ;
			strSQLS.append("      FROM  ") ;
			strSQLS.append("          (SELECT A.PROJECTNAME, A.MGRDEPT, (SELECT NAME FROM TBLBSC WHERE TBLBSC.ID = B.MGRDEPT) DNAME,  ") ;
			strSQLS.append("                  A.PROJECTID, B.DTLNAME EXECWORK, B.STOPYN, B.SYEAR, DECODE(B.STOPYN, 'Y', B.STOPYEAR, B.EYEAR) AS EYEAR, B.SQTR, DECODE(B.STOPYN, 'Y', B.STOPQTR, B.EQTR) AS EQTR, B.DETAILID DETAILID, B.DTLID SDTLID  ") ;
			strSQLS.append("            FROM  ") ;
			strSQLS.append("              ") ;
			strSQLS.append("             ( SELECT SP.NAME PROJECTNAME,  ") ;
			strSQLS.append("                       P.PROJECTID,  ") ;
			strSQLS.append("                       D.EXECWORK,                         ") ;
			strSQLS.append("                       D.SYEAR,D.EYEAR,  ") ;
			strSQLS.append("                       D.SQTR,D.EQTR,  ") ;
			strSQLS.append("                       D.DETAILID,  ") ;
			strSQLS.append("                       D.MGRDEPT  ") ;
			strSQLS.append("                FROM TBLSTRATPROJECTDETAIL D, TBLSTRATPROJECTINFO P,TBLSTRATPROJECT SP  ") ;
			strSQLS.append("                WHERE D.PROJECTID=P.PROJECTID  ") ;
			strSQLS.append("                  AND typeid = ?                          ") ;
			strSQLS.append("                  AND SP.ID = P.CONTENTID  ") ;
			strSQLS.append("                  AND D.DETAILID IN (  ") ;
			strSQLS.append("                     SELECT DETAILID  ") ;
			strSQLS.append("                     FROM  ") ;
			strSQLS.append("                         (  ") ;
			strSQLS.append("                          SELECT ID,NAME  ") ;
			strSQLS.append("                          FROM TBLOBJECTIVE  ") ;
			strSQLS.append("                          WHERE ID IN (  ") ;
			strSQLS.append("                                 SELECT OCID FROM  ") ;
			strSQLS.append("                                 ( SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ") ;
			strSQLS.append("                                  FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.CONTENTID=?) BSC      ") ;
			strSQLS.append("                                  LEFT JOIN  ") ;
			strSQLS.append("                                 (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ") ;
			strSQLS.append("                                 FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 ) PST  ") ;
			strSQLS.append("                                  ON BSC.BID=PST.PPID  ") ;
			strSQLS.append("                                  LEFT JOIN  ") ;
			strSQLS.append("                                 (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ") ;
			strSQLS.append("                                  FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 ) OBJ  ") ;
			strSQLS.append("                                  ON PST.PID=OBJ.OPID  ") ;
			strSQLS.append("                           )  ") ;
			strSQLS.append("                          ) OBJ  ") ;
			strSQLS.append("                           LEFT JOIN  ") ;
			strSQLS.append("                          (  ") ;
			strSQLS.append("                            SELECT I.BSCID,I.OBJID,I.DETAILID,I.PROJECTID,D.EXECWORK,D.NAME PNAME,D.TNAME FROM (SELECT I.BSCID,I.OBJID,I.DETAILID,I.PROJECTID FROM TBLINITIATIVE I) I  ") ;
			strSQLS.append("                            LEFT JOIN  ") ;
			strSQLS.append("                             ( SELECT D.PROJECTID,D.DETAILID, D.EXECWORK,C.NAME,(SELECT TYPENAME FROM TBLSTRATTYPEINFO T WHERE T.TYPEID=P.TYPEID) TNAME  ") ;
			strSQLS.append("                               FROM TBLSTRATPROJECTDETAIL D, TBLSTRATPROJECTINFO P,TBLSTRATPROJECT C  ") ;
			strSQLS.append("                               WHERE D.PROJECTID=P.PROJECTID AND P.CONTENTID=C.ID ) D  ") ;
			strSQLS.append("                               ON I.PROJECTID=D.PROJECTID AND I.DETAILID=D.DETAILID  ") ;
			strSQLS.append("                           ) INI  ") ;
			strSQLS.append("                           ON OBJ.ID=INI.OBJID AND INI.BSCID=? WHERE DETAILID IS NOT NULL      ") ;
			strSQLS.append("                       )  ") ;
			strSQLS.append("              )A,TBLSTRATWORK B                ") ;
			strSQLS.append("              WHERE A.DETAILID = B.DETAILID   ") ;
			strSQLS.append("                AND B.MGRDEPT IN ( SELECT MGRDEPT FROM TBLSTRATWORK WHERE MGRDEPT = CASE WHEN ( ? = A.MGRDEPT OR ?=1 OR ?=2 OR ?=7 OR ?=16) THEN MGRDEPT    ") ;
			strSQLS.append("                                                                                       ELSE to_number(?)   ") ;
			strSQLS.append("                                                                                      END  ") ;
			strSQLS.append("                                )    ") ;
			strSQLS.append("          )D   ") ;
			strSQLS.append("          LEFT JOIN  ") ;
			strSQLS.append("          (  ") ;
			strSQLS.append("          SELECT CASE WHEN (MAX(YEAR||QTR) > case when to_number(to_char(sysdate,'mm')) >= 1 and to_number(to_char(sysdate, 'mm')) <= 3 then to_char(sysdate,'yyyy')||1  ") ;
			strSQLS.append("                                                   when to_number(to_char(sysdate,'mm')) >= 4 and to_number(to_char(sysdate, 'mm')) <= 6 then to_char(sysdate,'yyyy')||2  ") ;
			strSQLS.append("                                                   when to_number(to_char(sysdate,'mm')) >= 7 and to_number(to_char(sysdate, 'mm')) <= 9 then to_char(sysdate,'yyyy')||3  ") ;
			strSQLS.append("                                                   when to_number(to_char(sysdate,'mm')) >= 10 and to_number(to_char(sysdate, 'mm')) <= 12 then to_char(sysdate,'yyyy')||4  ") ;
			strSQLS.append("                                              end  ") ;
			strSQLS.append("                            )  ") ;
			strSQLS.append("                       THEN case when to_number(to_char(sysdate,'mm')) >= 1 and to_number(to_char(sysdate, 'mm')) <= 3 then to_char(sysdate,'yyyy')||1  ") ;
			strSQLS.append("                                 when to_number(to_char(sysdate,'mm')) >= 4 and to_number(to_char(sysdate, 'mm')) <= 6 then to_char(sysdate,'yyyy')||2  ") ;
			strSQLS.append("                                 when to_number(to_char(sysdate,'mm')) >= 7 and to_number(to_char(sysdate, 'mm')) <= 9 then to_char(sysdate,'yyyy')||3  ") ;
			strSQLS.append("                                 when to_number(to_char(sysdate,'mm')) >= 10 and to_number(to_char(sysdate, 'mm')) <= 12 then to_char(sysdate,'yyyy')||4  ") ;
			strSQLS.append("                            end  ") ;
			strSQLS.append("                       ELSE MAX(YEAR||QTR) END DYEAR,DTLID DID  ") ;
			strSQLS.append("           FROM TBLSTRATWORKACHV  ") ;
			strSQLS.append("           WHERE REALIZE<>0  ") ;
			strSQLS.append("           GROUP BY DTLID  ") ;
			strSQLS.append("          ) A  ") ;
			strSQLS.append("          ON A.DID=D.DETAILID  ") ;
			strSQLS.append("          LEFT JOIN  ") ;
			strSQLS.append("          (SELECT QTRGOAL,  ") ;
			strSQLS.append("                 QTRACHV,  ") ;
			strSQLS.append("                 REALIZE,  ") ;
			strSQLS.append("                 YEAR AYEAR,  ") ;
			strSQLS.append("                 QTR AQTR,  ") ;
			strSQLS.append("                 DTLID ADID  ") ;
			strSQLS.append("           FROM TBLSTRATWORKACHV  ") ;
			strSQLS.append("          ) ACH  ") ;
			strSQLS.append("          ON A.DYEAR=ACH.AYEAR||AQTR AND A.DID=ACH.ADID  ") ;
			strSQLS.append("      )  ") ;
			strSQLS.append(")  ") ;
			strSQLS.append("ORDER BY  PROJECTNAME, ADID, LEV, SDTLID  ") ;

			Object params[] = {typeid, bId, bId, typeid, bId, bId, bId, bId, bId, bId, bId, bId }; 

			rs = dbobject.executePreparedQuery(strSQLS.toString(), params);
			ds.load(rs);
			request.setAttribute("proc", ds);

		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			request.setAttribute("result","false");
			System.out.println(se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			request.setAttribute("result","false");
			System.out.println(e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}
	}//-- getDeptList
} //-- class Taskdivision
