package com.nc.etl;


import java.io.OutputStream;
import java.io.Reader;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.jdbc.OracleResultSet;
import oracle.sql.CLOB;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.*;

public class ET010101 {
	
	public void setConnection(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append("SELECT ID, NAME FROM TBLCONNECTION ");
			
			rs = dbobject.executeQuery(sbSQL.toString());
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}

	public void setETLList(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append("SELECT S.*,(SELECT COUNT(*) FROM TBLETLDATA D WHERE D.ETLKEY=S.ETLKEY AND D.ITEMCODE=S.ITEMCODE) CN, ")
				.append(" D.FREQUENCY,M.NAME,(SELECT ITEMNAME FROM TBLITEM I WHERE D.ID=I.MEASUREID AND S.ITEMCODE=I.CODE) INAME  ")
				.append(" FROM TBLETLSQL S, TBLMEASUREDEFINE D, TBLMEASURE M ")
				.append(" WHERE S.ETLKEY=D.ETLKEY AND D.MEASUREID=M.ID AND D.YEAR=? ");
			
			Object[] pmSQL = {Util.getToDay().substring(0,4)};
			
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}
	
	
	/*
	 * ETL
	 */
	public DataSet getETL(String sETLKey, String sItemCode)
	{
		DataSet ds1 = null;
		String sql = "";
		
		sql = "SELECT z1.etlkey, z1.itemcode, z1.frequency, z1.paramremk, z1.remk, z1.sql, z1.useyn  \n"
			+ "   , (SELECT deptname FROM tblorganization WHERE deptcode=z1.deptcode) deptname  \n"
			+ "   , (SELECT name FROM tblmeasurepool WHERE id=z1.contentid ) contentname        \n"
			+ "   , (SELECT itemname FROM tblmeasureitem WHERE measureid=z1.contentid AND itemcode=z1.itemcode ) itemname  \n"
			+ " FROM  \n" 
			+ " (     \n"
			+ "  SELECT a.etlkey, a.itemcode, a.paramremk, a.remk, a.sql, a.useyn  \n"
			+ "    , (SELECT max(frequency)  FROM tblmeasuredefine WHERE etlkey=a.etlkey ) frequency  \n"
			+ "    , (SELECT max(contentid)  FROM tbltreescore  WHERE treecls='BSC_ALIAS' AND  measuredefineid=(SELECT MAX(id)  FROM tblmeasuredefine WHERE etlkey=a.etlkey) ) contentid  \n"
			+ "    , (SELECT max(deptcode)  FROM tbltreescore  WHERE treecls='BSC_ALIAS' AND  measuredefineid=(SELECT MAX(id)  FROM tblmeasuredefine WHERE etlkey=a.etlkey) ) deptcode    \n"     
			+ "  FROM tbletlsql a                       \n"
			+ "  Where etlkey = '" + sETLKey + "'       \n"
			+ "      AND itemcode = '" + sItemCode + "' \n"
			+ "  ) z1                                   \n"
			;
		//myUtil.myLog(sql);
		//ds1 = db1.getSelect(sql);
		
		return ds1;		
	}

	/*
	 * ETL rundate
	 */
	public DataSet getETLRunDate(String sETLKey, String sItemCode)
	{
		DataSet ds1 = null;
		String sql = "";
		String sYYYY = Util.getToDay().substring(0,4);
		//String sYYYY = myUtil.getCurYear();
		
		for(int i=0 ; i<24 ; i++)
		{
			if(i >= 1){	sql += "\n union \n";	}
			sql += "SELECT TO_CHAR(ADD_MONTHS('" + sYYYY + "-01-01'," + i + "),'yyyymm')  rundate   , (SELECT COUNT(*) FROM TBLETLRUNDATE WHERE etlkey='" + sETLKey + "'  AND itemcode='" + sItemCode + "' AND rundate=TO_CHAR(ADD_MONTHS('" + sYYYY + "-01-01'," + i + "),'yyyymm'))  cnt  FROM dual  \n";
		}
		sql += " order by rundate \n";
		//myUtil.myLog(sql);
		//ds1 = db1.getSelect(sql);
		
		return ds1;		
	}

	
	/*
	 * ETL param
	 */
	public DataSet getETLParam(String sETLKey, String sItemCode)
	{
		DataSet ds1 = null;
		String sql = "";
		
		sql = "SELECT param, val  FROM TBLETLPARAM  \n"
			+ " WHERE etlkey='" + sETLKey + "'      \n"
			+ "   AND itemcode='" + sItemCode + "'  \n"
			+ " ORDER BY param                      \n"
			;
		//myUtil.myLog(sql);
		//ds1 = db1.getSelect(sql);
		
		return ds1;		
	}
	
	/*
	 * 저장
	 */
	
	public void setETLKeySave( HttpServletRequest request, HttpServletResponse response ) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;
			String etl=null;
			String item=null;
			try {
				//System.out.println("this is ET 0 point");
				
				String sETLKey = request.getParameter("sETLKey");
				String sItemCode = request.getParameter("sItemCode");
				String sSQL = request.getParameter("sSql")!=null?Util.getEUCKR(request.getParameter("sSql").replaceAll("'","\\\\'")):null;
				String sRemk = Util.getEUCKR(request.getParameter("sRemk"));
				String sParamRemk = Util.getEUCKR(request.getParameter("sParamRemk"));
				String sUseYN = request.getParameter("sUseYN");
				String sInFRQ = request.getParameter("sInFRQ");
				//String db = request.getParameter("db");
				
				String sParam1 = request.getParameter("sParam1");
				String sParam2 = request.getParameter("sParam2");
				String sParam3 = request.getParameter("sParam3");
				String sParam4 = request.getParameter("sParam4");
				String sParam5 = request.getParameter("sParam5");
				String rundate = request.getParameter("sRunDate");
				
				String[] sRunDate = null;
				
				if (rundate!=null) sRunDate=rundate.split("\\|");
				
				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				
				dbobject = new DBObject(conn.getConnection());
				
				String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";
				//System.out.println("this is ET 1 point");
				if ("C".equals(tag)){
					StringBuffer sbU = new StringBuffer();
					
					sbU.append("UPDATE TBLETLSQL SET SQL=null,REMK=?,PARAMREMK=?,USEYN=?,INPUTFREQUENCY=?,SQLTEXT=EMPTY_CLOB() WHERE ETLKEY=? AND ITEMCODE=? ");
					Object[] pmU = {sRemk,sParamRemk,sUseYN,sInFRQ,sETLKey,sItemCode};
					
					StringBuffer sbI = new StringBuffer();
					sbI.append("INSERT INTO TBLETLSQL (ETLKEY,ITEMCODE,REMK,PARAMREMK,USEYN,INPUTFREQUENCY,SQLTEXT ) VALUES (?,?,?,?,?,?,EMPTY_CLOB())");
					Object[] pmI = {sETLKey,sItemCode,sRemk,sParamRemk,sUseYN,sInFRQ};
					
					if (dbobject.executePreparedUpdate(sbU.toString(),pmU)<1){
						if (dbobject.executePreparedUpdate(sbI.toString(),pmI)<1){
							return ;
						}
					}

					if (rs!=null) {rs.close(); rs=null; }
					String strCLOB = "SELECT SQLTEXT FROM TBLETLSQL WHERE ETLKEY=? AND ITEMCODE=? FOR UPDATE";
					Object[] objCLOB = {sETLKey,sItemCode};
					rs = dbobject.executePreparedQuery(strCLOB,objCLOB);
					
					if (rs.next()){
						CLOB cl = ((OracleResultSet)rs).getCLOB("SQLTEXT");
						long pos = 1;
						cl.putString(pos,sSQL);
					}
					
					
					String strParam = "DELETE FROM TBLETLPARAM WHERE ETLKEY=? AND ITEMCODE=?";
					Object[] pmParam = {sETLKey, sItemCode};
					
					dbobject.executePreparedUpdate(strParam.toString(),pmParam);
					
					String strPMI = "INSERT INTO TBLETLPARAM (ETLKEY,ITEMCODE,PARAM,VAL) VALUES (?,?,?,?)";
					Object[] pmPMI = {sETLKey,sItemCode,null,null};
					
					if ( (sParam1!=null)&&(!"".equals(sParam1)) ){
						pmPMI[2] = "$1";;
						pmPMI[3] = sParam1;
						dbobject.executePreparedUpdate(strPMI.toString(),pmPMI);
					}
					if ( (sParam2!=null)&&(!"".equals(sParam2)) ){
						pmPMI[2] = "$2";;
						pmPMI[3] = sParam2;
						dbobject.executePreparedUpdate(strPMI.toString(),pmPMI);
					}
					if ( (sParam3!=null)&&(!"".equals(sParam3)) ){
						pmPMI[2] = "$3";;
						pmPMI[3] = sParam3;
						dbobject.executePreparedUpdate(strPMI.toString(),pmPMI);
					}
					if ( (sParam4!=null)&&(!"".equals(sParam4)) ){
						pmPMI[2] = "$4";;
						pmPMI[3] = sParam4;
						dbobject.executePreparedUpdate(strPMI.toString(),pmPMI);
					}
					if ( (sParam5!=null)&&(!"".equals(sParam5)) ){
						pmPMI[2] = "$5";;
						pmPMI[3] = sParam5;
						dbobject.executePreparedUpdate(strPMI.toString(),pmPMI);
					}		
					
					String strRunD = "DELETE FROM TBLETLRUNDATE WHERE ETLKEY=? AND ITEMCODE=?";
					Object[] pmRunD = {sETLKey,sItemCode};
					
					dbobject.executePreparedUpdate(strRunD,pmRunD);
					
					String strRunI = "INSERT INTO TBLETLRUNDATE (ETLKEY, ITEMCODE,RUNDATE ) VALUES (?,?,?)";
					Object[] pmRunI = {sETLKey,sItemCode,null};
					
					for (int i = 0; i < sRunDate.length; i++) {
						if(!sRunDate[i].equals("")){
							pmRunI[2] = sRunDate[i];
							dbobject.executePreparedUpdate(strRunI,pmRunI);
						}
					}
					conn.commit();
				} else if ("U".equals(tag)){
					StringBuffer sbU = new StringBuffer();
					
					
					sbU.append("UPDATE TBLETLSQL SET SQL=null,REMK=?,PARAMREMK=?,USEYN=?,INPUTFREQUENCY=?,SQLTEXT=EMPTY_CLOB() WHERE ETLKEY=? AND ITEMCODE=? ");
					Object[] pmU = {sRemk,sParamRemk,sUseYN,sInFRQ,sETLKey,sItemCode};
					
					StringBuffer sbI = new StringBuffer();
					sbI.append("INSERT INTO TBLETLSQL (ETLKEY,ITEMCODE,REMK,PARAMREMK,USEYN,INPUTFREQUENCY,SQLTEXT ) VALUES (?,?,?,?,?,?,EMPTY_CLOB())");
					Object[] pmI = {sETLKey,sItemCode,sRemk,sParamRemk,sUseYN,sInFRQ};
					
					if (dbobject.executePreparedUpdate(sbU.toString(),pmU)<1){
						if (dbobject.executePreparedUpdate(sbI.toString(),pmI)<1){
							return ;
						}
					}
					
					// STORE SQLTEXT CLOB;
					
					if (rs!=null) {rs.close(); rs=null; }
					String strCLOB = "SELECT SQLTEXT FROM TBLETLSQL WHERE ETLKEY=? AND ITEMCODE=? FOR UPDATE";
					Object[] objCLOB = {sETLKey,sItemCode};
					rs = dbobject.executePreparedQuery(strCLOB,objCLOB);
					
					if (rs.next()){
						CLOB cl = ((OracleResultSet)rs).getCLOB("SQLTEXT");
						long pos = 1;
						cl.putString(pos,sSQL);
					}
					
					String strParam = "DELETE FROM TBLETLPARAM WHERE ETLKEY=? AND ITEMCODE=?";
					Object[] pmParam = {sETLKey, sItemCode};
					
					dbobject.executePreparedUpdate(strParam.toString(),pmParam);
					
					String strPMI = "INSERT INTO TBLETLPARAM (ETLKEY,ITEMCODE,PARAM,VAL) VALUES (?,?,?,?)";
					Object[] pmPMI = {sETLKey,sItemCode,null,null};
					
					if ( (sParam1!=null)&&(!"".equals(sParam1)) ){
						pmPMI[2] = "$1";;
						pmPMI[3] = sParam1;
						dbobject.executePreparedUpdate(strPMI.toString(),pmPMI);
					}
					if ( (sParam2!=null)&&(!"".equals(sParam2)) ){
						pmPMI[2] = "$2";;
						pmPMI[3] = sParam2;
						dbobject.executePreparedUpdate(strPMI.toString(),pmPMI);
					}
					if ( (sParam3!=null)&&(!"".equals(sParam3)) ){
						pmPMI[2] = "$3";;
						pmPMI[3] = sParam3;
						dbobject.executePreparedUpdate(strPMI.toString(),pmPMI);
					}
					if ( (sParam4!=null)&&(!"".equals(sParam4)) ){
						pmPMI[2] = "$4";;
						pmPMI[3] = sParam4;
						dbobject.executePreparedUpdate(strPMI.toString(),pmPMI);
					}
					if ( (sParam5!=null)&&(!"".equals(sParam5)) ){
						pmPMI[2] = "$5";;
						pmPMI[3] = sParam5;
						dbobject.executePreparedUpdate(strPMI.toString(),pmPMI);
					}		
					
					String strRunD = "DELETE FROM TBLETLRUNDATE WHERE ETLKEY=? AND ITEMCODE=?";
					Object[] pmRunD = {sETLKey,sItemCode};
					
					dbobject.executePreparedUpdate(strRunD,pmRunD);
					
					String strRunI = "INSERT INTO TBLETLRUNDATE (ETLKEY, ITEMCODE,RUNDATE ) VALUES (?,?,?)";
					Object[] pmRunI = {sETLKey,sItemCode,null};
					
					for (int i = 0; i < sRunDate.length; i++) {
						if(!sRunDate[i].equals("")){
							pmRunI[2] = sRunDate[i];
							dbobject.executePreparedUpdate(strRunI,pmRunI);
						}
					}
					conn.commit();
				} else if ("D".equals(tag)){
					String strRD = "DELETE FROM TBLETLRUNDATE WHERE ETLKEY=? AND ITEMCODE=?";
					Object[] pmRD = {sETLKey,sItemCode};
					
					dbobject.executePreparedUpdate(strRD,pmRD);
					
					String strPD = "DELETE FROM TBLETLPARAM WHERE ETLKEY=? AND ITEMCODE=?";
					Object[] pmPD = {sETLKey,sItemCode};
					
					dbobject.executePreparedUpdate(strPD,pmPD);
					
					
					String strQL = "DELETE FROM TBLETLSQL WHERE ETLKEY=? AND ITEMCODE=?";
					
					dbobject.executePreparedUpdate(strQL,pmPD);
					
					conn.commit();
				}
				
				//System.out.println("this is ET 3 point");
				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
				sbSQL.append(" SELECT ETL.*,BSC.BNAME FROM  ")
		         .append(" (SELECT TRIM(S.ETLKEY) ETLKEY,TRIM(S.ITEMCODE) ITEMCODE,S.REMK,S.USEYN,S.INPUTDATE,S.UPDATEDATE,S.PARAMREMK,S.SQLTEXT,S.INPUTFREQUENCY,(SELECT COUNT(*) FROM TBLETLDATA D WHERE D.ETLKEY=S.ETLKEY AND D.ITEMCODE=S.ITEMCODE) CN,  ")
		         .append(" D.FREQUENCY,M.NAME,(SELECT ITEMNAME FROM TBLITEM I WHERE D.ID=I.MEASUREID AND S.ITEMCODE=I.CODE) INAME,D.ID EID  ")
		         .append(" FROM TBLETLSQL S, TBLMEASUREDEFINE D, TBLMEASURE M  ")
		         .append(" WHERE S.ETLKEY=D.ETLKEY AND D.MEASUREID=M.ID AND D.YEAR=? ORDER BY S.ETLKEY ) ETL ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME  ")
		         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA ")
		         .append(" ON ETL.EID=MEA.MCID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
		         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
		         .append(" ON MEA.MPID=OBJ.OID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
		         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
		         .append(" ON OBJ.OPID=PST.PID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
		         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
		         .append(" ON PST.PPID=BSC.BID ORDER BY BNAME,ETLKEY");
				
				String year = Util.getToDay().substring(0,4);
				Object[] pmSQL = {year,year,year,year,year};
				
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);
				
				ArrayList list = new ArrayList();
				

				while (rs.next()){
					SqlEntity ent = new SqlEntity();
					ent.etlkey = rs.getString("ETLKEY");
					ent.itemcode = rs.getString("ITEMCODE");
					etl = ent.etlkey;
					item = ent.itemcode;
					
					StringBuffer output = new StringBuffer();
					Reader input = rs.getCharacterStream("SQLTEXT");
					if (input!=null){
						char[] buffer = new char[1024];
						int byteRead;
						while((byteRead=input.read(buffer,0,1024))!=-1){
							output.append(buffer,0,byteRead);
						}
						input.close();
					}
					ent.sql = output.toString();
					ent.sql = (ent.sql!=null)?ent.sql.replaceAll("\r\n","`"):"";
					ent.remk = rs.getString("REMK");
					ent.useyn = rs.getString("USEYN");
					ent.mname = rs.getString("NAME");
					ent.iname = rs.getString("INAME");
					ent.frequency = rs.getString("FREQUENCY");
					ent.paramremk = rs.getString("PARAMREMK");
					ent.inFRQ = rs.getInt("INPUTFREQUENCY");
					ent.dname = rs.getString("BNAME");
					list.add(ent);
				}
				
				
				String param = "SELECT * FROM TBLETLPARAM";
				if (rs!=null) {rs.close(); rs=null;}
				
				rs = dbobject.executeQuery(param);
				
				while(rs.next()){
					SqlEntity ent = getEntity(list,rs.getString("ETLKEY"),rs.getString("ITEMCODE"));
					String val = rs.getString("PARAM")+","+rs.getString("VAL");
					
					if (ent!=null)
						ent.params.add(val);
				}
				
				String strRunDate = "SELECT * FROM TBLETLRUNDATE";
				if (rs !=null) {rs.close(); rs=null;}
				
				rs = dbobject.executeQuery(strRunDate);
				
				while(rs.next()){
					SqlEntity ent = getEntity(list,rs.getString("ETLKEY"),rs.getString("ITEMCODE"));
					String date = rs.getString("RUNDATE");
					
					if (ent!=null)
						ent.rundate.add(date);
				}
				
				request.setAttribute("list",list);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println(e+" eltkey : "+etl+" itemCode : "+item);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}	
			
	}
		
	private SqlEntity getEntity(ArrayList list, String etlkey, String itemcode){
		for (int i = 0; i < list.size(); i++) {
			SqlEntity ent = (SqlEntity)list.get(i);
			if (ent.etlkey.equals(etlkey)&&(ent.itemcode.equals(itemcode)))
				return ent;
		}
		return null;
	}
			
	/*
	 * 삭제
	 */
	public int setETLDel(String sETLKey, String sItemCode)
	{
		int ret = 0;
		String sql = "";
		
		//
		//db1.setBeginTrans();
		
		try{
			//tbletlsql
			sql = "Delete From tbletlsql Where etlkey='" + sETLKey + "' and itemcode='" + sItemCode + "' ";
			//ret = db1.setDeleteTrans(sql);
			if(ret<=0){
				//db1.setRollBackTrans();
				return -1;
			}
			
			//tbletlrundate
			sql = "Delete From tbletlrundate Where etlkey='" + sETLKey + "' and itemcode='" + sItemCode + "' ";
			//ret = db1.setDeleteTrans(sql);
			if(ret<0){
				//db1.setRollBackTrans();
				return -1;
			}
			
			//tbletlparam
			sql = "Delete From tbletlparam Where etlkey='" + sETLKey + "' and itemcode='" + sItemCode + "' ";
			//ret = db1.setDeleteTrans(sql);
			if(ret<0){
				//db1.setRollBackTrans();
				return -1;
			}
			
			
		}catch(Exception e){
			//myUtil.myErrLog(e.toString());
			//db1.setRollBackTrans();
			return -1;
		}
		
		//
		//db1.setCommitTrans();
		
		return ret;
	}
	
	
}



