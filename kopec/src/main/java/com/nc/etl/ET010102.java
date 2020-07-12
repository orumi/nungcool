package com.nc.etl;

import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Properties;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.actual.ActualUtil;
import com.nc.actual.MeasureDetail;
import com.nc.cool.CoolServer;
import com.nc.math.Expression;
import com.nc.math.ExpressionParser;
import com.nc.sql.CoolConnection;
import com.nc.util.*;
//import com.sun.rsasign.bb;

public class ET010102 {

	public int setETLDataDel(String sETLKey, String sItemCode, String sETLDate ) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		int ret = 0;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String sql = "";

			//
			sql = "Delete from tbletldata            \n"
				+ " Where etlkey ='" + sETLKey + "'  \n"
				+ "    and itemcode = '" + sItemCode + "'  \n"
				+ "    and etldate = '" + sETLDate + "'    \n"
				;
			ret = dbobject.executeUpdate(sql);
			
			conn.commit();
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
		return ret;
	}
	
	public void getETLDataList(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String sETLKey = request.getParameter("etlkey") != null ? request.getParameter("etlkey") : "";
			String sItemCode = request.getParameter("itemcode") != null ? request.getParameter("itemcode") : "";
			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append("SELECT ETLDATE,ETLVAL,FLAGYN FROM TBLETLDATA WHERE ETLKEY=? AND ITEMCODE=? ")
				.append(" ORDER BY ETLDATE DESC");
			
			Object[] pmSQL = {sETLKey,sItemCode};
			
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
			StringBuffer sbPM = new StringBuffer();
			sbPM.append("SELECT PARAM,VAL, ")
				.append(" CASE WHEN VAL='YYYY' THEN TO_CHAR(SYSDATE,'yyyy') ")
				.append(" 	   		WHEN val='YY1B' THEN TO_CHAR(ADD_MONTHS(SYSDATE,-12)  , 'yyyy') ")
				.append(" WHEN val='YYYYMM' THEN TO_CHAR(SYSDATE  , 'yyyymm')  ")
				.append(" 			WHEN val='YYYY01' THEN  TO_CHAR(SYSDATE, 'yyyy')||'01'  ") 
				.append(" 			WHEN val='YYYY12' THEN TO_CHAR(SYSDATE, 'yyyy')||'12'   ")
				.append(" 	        WHEN val='YYYY2B' THEN TO_CHAR(ADD_MONTHS(SYSDATE,-2)  , 'yyyymm') ")                 
				.append(" 	        WHEN val='YYYY5B' THEN TO_CHAR(ADD_MONTHS(SYSDATE,-5)  , 'yyyymm') ")
				.append(" 			ELSE '?' ")
				.append(" 		END VAL1 ")
				.append(" 	FROM TBLETLPARAM WHERE ETLKEY=? AND ITEMCODE=? ")
				.append(" 	ORDER BY PARAM 	");
			
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(sbPM.toString(),pmSQL);
			DataSet dsP = new DataSet();
			dsP.load(rs);
			
			request.setAttribute("dsPM",dsP);
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
	 * param 목록
	 */
	public DataSet getETLParam(String sETLKey, String sItemCode) {
		DataSet ds1 = null;
		String sql = "";
		
		sql = "SELECT param, val                                                          \n"
			+ "    ,CASE WHEN val='YYYY' THEN TO_CHAR(SYSDATE, 'yyyy')                    \n"
            + "          WHEN val='YY1B' THEN TO_CHAR(ADD_MONTHS(SYSDATE,-12)  , 'yyyy')  \n"
			+ "          WHEN val='YYYYMM' THEN TO_CHAR(SYSDATE  , 'yyyymm')              \n"
			+ "          WHEN val='YYYY01' THEN  TO_CHAR(SYSDATE, 'yyyy')||'01'           \n"
			+ "          WHEN val='YYYY12' THEN TO_CHAR(SYSDATE, 'yyyy')||'12'            \n"
	        + "          WHEN val='YYYY2B' THEN TO_CHAR(ADD_MONTHS(SYSDATE,-2)  , 'yyyymm') \n"                 
	        + "          WHEN val='YYYY5B' THEN TO_CHAR(ADD_MONTHS(SYSDATE,-5)  , 'yyyymm') \n"                 			
			+ "          ELSE  '?'                                                        \n"
			+ "     END val1                                                              \n"  
			+"  FROM TBLETLPARAM                                                 \n"
			+ " WHERE etlkey='" + sETLKey + "' AND itemcode='" + sItemCode + "'  \n"
			+ " ORDER BY param                                                     \n"
			;
		//ds1 = db1.getSelect(sql);
		
		return ds1;
	}
	
	public void setETLData(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String sETLKey = request.getParameter("etlkey") != null ? request.getParameter("etlkey") : "";
			String sItemCode = request.getParameter("itemcode") != null ? request.getParameter("itemcode") : "";
			String sETLDate = request.getParameter("etldate") != null ? request.getParameter("etldate") : "";
			
			
			String sParam1 = request.getParameter("param1") != null ? request.getParameter("param1") : "";
			String sParam2 = request.getParameter("param2") != null ? request.getParameter("param2") : "";
			String sParam3 = request.getParameter("param3") != null ? request.getParameter("param3") : "";
			String sParam4 = request.getParameter("param4") != null ? request.getParameter("param4") : "";
			String sParam5 = request.getParameter("param5") != null ? request.getParameter("param5") : "";
			
			String strSQL = "SELECT S.SQL,S.CONNECTION,S.SQLTEXT,C.* FROM TBLETLSQL S, TBLCONNECTION C WHERE S.CONNECTION=C.ID(+) AND ETLKEY=? AND ITEMCODE=?";
			Object[] pmSQL = {sETLKey,sItemCode};
			
			rs = dbobject.executePreparedQuery(strSQL,pmSQL);
			
			String sql = null;
			double val = 0D;
			int con = 0;
			String driver = null;
			String database = null;
			Properties properties = null;
			if(rs.next()){
				
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
				
				sql = output.toString();//rs.getString("SQL");
				con = rs.getInt("CONNECTION");
				if (0!=con){
					driver = rs.getString("DRIVER");
					database = rs.getString("DATABASE");
					properties = new Properties();
		            properties.setProperty("user", rs.getString("USERNAME"));
		            properties.setProperty("password", rs.getString("PASSWORD"));
		            properties.setProperty("charSet", rs.getString("CHARSET"));
				}
			}
			request.setAttribute("sql",sql);
			
			if (sql!=null){
				sql = sql.replaceAll("\\\\","");
				sql = sql.replaceAll("\\$1",sParam1);
				sql = sql.replaceAll("\\$2",sParam2);
				sql = sql.replaceAll("\\$3",sParam3);
				sql = sql.replaceAll("\\$4",sParam4);
				sql = sql.replaceAll("\\$5",sParam5);
				
				if (rs!=null){rs.close(); rs=null;}
				boolean step = false;
				if (con==0){
					rs = dbobject.executeQuery(sql);
					if (rs.next()){
						val = rs.getDouble(1);
						step = true;
					}
				} else {
					val = getVal(sql,driver,database,properties);
					step = true;
				}

				if (step){
					request.setAttribute("val",new Double(val));
					
					String strDU = "UPDATE TBLETLDATA SET ETLVAL=?,UPDATEDATE=SYSDATE,PARAM1=?,PARAM2=?,PARAM3=?,PARAM4=?,PARAM5=?,FLAGYN='N' WHERE ETLKEY=? AND ITEMCODE=? AND ETLDATE=?";
					Object[] pmDU = {new Double(val),sParam1,sParam2,sParam3,sParam4,sParam5,sETLKey,sItemCode,sETLDate.substring(0,6)};
					
					String strDI = "INSERT INTO TBLETLDATA (ETLKEY,ITEMCODE,ETLDATE,ETLVAL,PARAM1,PARAM2,PARAM3,PARAM4,PARAM5,FLAGYN) VALUES (?,?,?,?,?,?,?,?,?,'N')";
					Object[] pmDI = {sETLKey,sItemCode,sETLDate.substring(0,6),pmDU[0],sParam1,sParam2,sParam3,sParam4,sParam5};
					
					if (dbobject.executePreparedUpdate(strDU,pmDU)<1){
						dbobject.executePreparedQuery(strDI,pmDI);
					}
				}
				conn.commit();
			}
			
			
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			String msg = e.toString().replaceAll("\n","  ");
			request.setAttribute("msg",msg);
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
			
		}
	}
	private double getVal(String sql, String driver,String database, Properties properties){

		Connection connection = null;
		
		DBObject dbOut = null;
		ResultSet rs = null;
		
		double reval=0;
		try {
		
            Class.forName(driver);
            connection = DriverManager.getConnection(database, properties);
            dbOut = new DBObject(connection);
            
            rs = dbOut.executeQuery(sql);
            
            if (rs.next()) reval = rs.getDouble(1);
            
            
		} catch (Exception e) {
			String msg = e.toString().replaceAll("\n","  ");
			System.out.println(e);
		} finally {
			
			if (dbOut!=null){dbOut.close(); dbOut = null;}
			if (rs !=null) { try{rs.close();rs=null; } catch (Exception e){}}
			if (connection !=null) { try { connection.close(); connection = null; } catch (Exception e ){}}
		}
		return reval;
	}
	/*
	 * 실적값저장
	 */
	public int setActualSave(String sETLKey, String sItemCode, String sEffectiveDate, double nActual, String sETLDate ) {
		int ret = 0;
		int nCnt = 0;
		
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			// 1. get equation 
			String strEqu = "SELECT ID, EQUATION,WEIGHT,TREND,FREQUENCY FROM TBLMEASUREDEFINE WHERE ETLKEY=? AND YEAR=?";
			Object[] pmEqu = {sETLKey,sEffectiveDate.substring(0,4)};
			
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(strEqu,pmEqu);
			String mid = "";
			String equ = "";
			String weight = null;
			String trend = null;
			String frequency = null;
			while(rs.next()){
				mid = String.valueOf(rs.getInt("ID"));
				equ = rs.getString("EQUATION");
				weight = rs.getString("WEIGHT");
				trend = rs.getString("TREND");
				frequency = rs.getString("FREQUENCY");
			}
			
			ExpressionParser exParser = new ExpressionParser(equ);
			Expression expression = exParser.getCompleteExpression();
			
			Vector vector = new Vector();
			expression.addUnknowns(vector);
			
			// 2. save item actual
			
			String year = sEffectiveDate.substring(0,4);
			String schDate = sEffectiveDate.substring(0,6);
			
			StringBuffer sbItem = new StringBuffer();
			sbItem.append("SELECT COUNT(ACTUAL) CNT,SUM(ACTUAL) ACC,AVG(ACTUAL) AVG FROM TBLITEMACTUAL WHERE MEASUREID=? AND CODE=? AND STRDATE>=? AND STRDATE<?");
			Object[] pmItem = {mid,sItemCode,year+"01",schDate};
			
			StringBuffer sbItemI = new StringBuffer();
			sbItemI.append("INSERT INTO TBLITEMACTUAL (MEASUREID,CODE,STRDATE,INPUTDATE,ACTUAL,ACCUM,AVERAGE) VALUES (?,?,?,?,?, ?,?)");
			Object[] pmItemI = {mid,sItemCode,schDate,Util.getToDay().substring(0,8),null,null,null};
			
			StringBuffer sbItemU = new StringBuffer();
			sbItemU.append("UPDATE TBLITEMACTUAL SET INPUTDATE=?,ACTUAL=?,ACCUM=?,AVERAGE=? WHERE MEASUREID=? AND CODE=? AND STRDATE=?");
			Object[] pmItemU = {Util.getToDay().substring(0,8),null,null,null,mid,sItemCode,schDate};
			
			double acc=0;
			double avg=0;
			
			rs = dbobject.executePreparedQuery(sbItem.toString(),pmItem);
			while(rs.next()){
				int cnt = rs.getInt("CNT");
				if (cnt == 0){
					acc=nActual;
					avg=nActual;
				} else {
					acc = rs.getFloat("ACC")+nActual;
					avg = acc/(cnt+1);
				}
			}
			pmItemU[1] = new Double(nActual);
			pmItemU[2] = new Double(acc);
			pmItemU[3] = new Double(avg);
			if (dbobject.executePreparedUpdate(sbItemU.toString(),pmItemU)<1){
				pmItemI[4] = new Double(nActual);
				pmItemI[5] = new Double(acc);
				pmItemI[6] = new Double(avg);
				dbobject.executePreparedUpdate(sbItemI.toString(),pmItemI);
			}
			
			// 3. get item actuals
			HashMap map = new HashMap();
			
			String strA = "SELECT A.*,I.ITEMTYPE FROM TBLITEMACTUAL A, TBLITEM I WHERE A.MEASUREID=I.MEASUREID AND A.CODE=I.CODE AND STRDATE=? AND A.MEASUREID=?";
			Object[] pmA = {schDate,mid};
			if (rs!=null) {rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(strA,pmA);
			
			int icnt = 0;
			while(rs.next()){
				double tmp = 0;
				if ("누적".equals(rs.getString("ITEMTYPE"))){
					tmp = rs.getDouble("ACCUM");
				} else if ("평균".equals(rs.getString("ITEMTYPE"))){
					tmp = rs.getDouble("AVERAGE");
				} else {
					tmp = rs.getDouble("ACTUAL");
				}
				map.put(rs.getString("CODE"),new Double(tmp) );
				icnt++;
			}
			int k = vector.size();
			
			
//			 4. calcuate measure actual
			
			if (k==icnt){
				Hashtable table = new Hashtable();
				for (int j = 0; j < k ; j++) {
					String icd = (String)vector.get(j);
					Object obj = map.get(icd);
					if (obj!=null)
						table.put(icd,obj);
				}
				
				ActualUtil actaulutil = new ActualUtil();
				
				Double actual = (Double)expression.evaluate(table);
				
				MeasureDetail measuredetail = actaulutil.getMeasureDetail (dbobject,mid,schDate);
				
				measuredetail.actual = actual.doubleValue();
				measuredetail.strDate = Util.getLastMonth(schDate);
				measuredetail.weight = new Float(weight).floatValue();
				measuredetail.measureId = new Integer(mid).intValue();
				measuredetail.trend = (trend==null)?"상향":trend;
				measuredetail.frequency = frequency;
				
				actaulutil.updateMeasureDetail(dbobject,measuredetail);
				
				conn.commit();
			}
			
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			String msg = e.toString().replaceAll("\n","  ");
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
		
		return ret;
	}

	


}



