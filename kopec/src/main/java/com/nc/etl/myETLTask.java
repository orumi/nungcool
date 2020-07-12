package com.nc.etl;

import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Properties;
import java.util.TimerTask;
import java.util.Vector;


import com.nc.actual.ActualUtil;
import com.nc.actual.MeasureDetail;
import com.nc.cool.CoolServer;
import com.nc.math.Expression;
import com.nc.math.ExpressionParser;
import com.nc.sql.CoolConnection;
import com.nc.util.*;

/*
 * package com.nungcool.servlet==>startScheduler()�� ���
 *
 *  - Scheduler.schedule(new myETLTask(), sysProp, "myETL" ,10000L, 36000L);	//l1=delay, l2=period
 *
 */

public class myETLTask extends TimerTask {
	/*
	 *  1�ð��� ���鼭 �ð��� 1���� ��� ����...
	 *
	 *  ó�� ����
	 *
	 *  1. �������� �����´�.
	 *  2. Query �� DB Connection ������ �����´�.
	 *  3. ������ �����´�.
	 *  4. ������ �ݿ��Ѵ�.
	 *  5. ���� �� ������ �ݿ��Ѵ�.
	 *  6. �α׿� �����Ѵ�.
	 *
	 *  (non-Javadoc)
	 * @see java.lang.Runnable#run()
	 */
	public boolean step = false;

	public void run() {

		CoolConnection conn     = null;
		DBObject       dbobject = null;
		ResultSet      rs       = null;

		String tEtlKey   = null;
		String tItemCode = null;

		try {

			String strDate  = Util.getToDayTime();
			String year     = strDate.substring(0,4);
			int y = Integer.valueOf(year).intValue();
			String pYear    = String.valueOf(y-1);
			String yyyymm   = strDate.substring(0,6);
			String month    = strDate.substring(4,6);
			String hour     = strDate.substring(8,10);
			String yyyymmdd = strDate.substring(0,8);
			String qtr      = getQTR(strDate.substring(4,6));

			System.out.println("ETL running .. current time is : "+strDate);

			if (("05".equals(hour))||(step)) {  // ���� ������ ���� ����  //
			//if (true){  // ���� ������ ���� ����
				System.out.println("start ETL Run...");

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);

				dbobject = new DBObject(conn.getConnection());

				StringBuffer sbParam = new StringBuffer();
				sbParam.append(" SELECT param, val ")
		               .append("     ,CASE WHEN val='YYYY'   THEN TO_CHAR(TO_DATE('"+yyyymmdd+"','yyyymmdd'), 'yyyy')  ")
		               .append("           WHEN val='YY1B'   THEN TO_CHAR(ADD_MONTHS(TO_DATE('"+yyyymmdd+"','yyyymmdd'),-12), 'yyyy') ")
		               .append("           WHEN val='YYYYMM' THEN TO_CHAR(TO_DATE('"+yyyymmdd+"','yyyymmdd') , 'yyyymm') ")
		               .append(" 	       WHEN val='YYYY1B' THEN TO_CHAR(ADD_MONTHS(TO_DATE('"+yyyymmdd+"','yyyymmdd'),-1), 'yyyymm') ")
		               .append(" 	       WHEN val='YYYY2B' THEN TO_CHAR(ADD_MONTHS(TO_DATE('"+yyyymmdd+"','yyyymmdd'),-2), 'yyyymm') ")
		               .append(" 	       WHEN val='YYYY5B' THEN TO_CHAR(ADD_MONTHS(TO_DATE('"+yyyymmdd+"','yyyymmdd'),-5), 'yyyymm') ")
		               .append("           WHEN val='YYYY01' THEN TO_CHAR(TO_DATE('"+yyyymmdd+"','yyyymmdd'), 'yyyy')||'01' ")
		               .append("           WHEN val='YYYY12' THEN TO_CHAR(TO_DATE('"+yyyymmdd+"','yyyymmdd'), 'yyyy')||'12' ")
		               .append("           ELSE  '?' ")
		               .append("       END val1 ")
		               .append("  FROM  TBLETLPARAM ")
		               .append("  WHERE etlkey=? AND itemcode=? ")
		               .append("  ORDER BY val ");

				Object[] pmParam = {null,null};

				// 1. ���� ���� ����� ���� �´�. (���� ������ connection ������ ���� ������)
				ArrayList runList = getRunList(dbobject,yyyymm);

				if (runList!=null) {
					for (int i=0;i<runList.size();i++) {  // �ݺ� ����;
					// 2. ������ ���� �´�.
						// 2.1 PARAM�� �����ͼ� �ݿ��Ѵ�.

						EntSql ent = (EntSql)runList.get(i);

						if (rs!=null){rs.close(); rs=null;}

						String sql      = ent.sql;
						String etlkey   = ent.etlKey;
						String itemCode = ent.itemCode;
						int con = ent.conn;
						pmParam[0]=etlkey;
						pmParam[1]=itemCode;
						tEtlKey = etlkey;
						tItemCode = itemCode;


						rs = dbobject.executePreparedQuery(sbParam.toString(),pmParam);
						if (sql==null) continue;

						sql = sql.replaceAll("\\\\","");
						while(rs.next()){
							String param = "\\"+rs.getString("PARAM");
							String val1 = rs.getString("VAL1");
							sql=sql.replaceAll(param,val1);
						}

						double  val=0;
						boolean step = false;
						try{
							val = getVal(dbobject,sql,tEtlKey,tItemCode);
							step = true;
						} catch (Exception e) {
							step=false;
						}


						// 3. ������ �ݿ��Ѵ�.
						if (step){
							String intDate = yyyymm;

							if (ent.inFRQ==1){
								intDate=getPrevFrq(dbobject,etlkey,yyyymm);
							} else {
								intDate=getCurFrq(dbobject,etlkey,yyyymm);
							}

							//System.out.println("etl running... :"+etlkey);
							updateETLData(dbobject,val,etlkey,itemCode,intDate);

						// 4. ���� ������ �ݿ��Ѵ�.
							updateDetail(dbobject,val,etlkey,itemCode,intDate);

							conn.commit();

						}
					}
				}

				//conn.commit();

			}

		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("ETL key is : "+tEtlKey+"/ ItemCode :"+tItemCode+" Error :  "+e);
		} finally {
			step=false;
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

	private String getCurFrq(DBObject dbobject, String etlkey, String yyyymm){
		ResultSet rs = null;
		try {
			String str = "SELECT FREQUENCY FROM TBLMEASUREDEFINE WHERE ETLKEY=?";
			Object[] obj = {etlkey};

			rs = dbobject.executePreparedQuery(str,obj);

			String frq = "";
			while(rs.next()){
				frq = rs.getString("FREQUENCY");
			}
			int year  = Integer.parseInt(yyyymm.substring(0,4));
			int month = Integer.parseInt(yyyymm.substring(4,6));

			if ("��".equals(frq)){

			} else if ("�б�".equals(frq)){
				if (month<4){
					month=3;
				} else if (month<7){
					month=6;
				} else if (month<10){
					month=9;
				} else {
					month=12;
				}
			} else if ("�ݱ�".equals(frq)){
				if (month<7){
					month=6;
				} else {
					month=12;
				}
			} else if ("��".equals(frq)){
				month=12;
			}

			String m = (month<10)?"0"+String.valueOf(month):String.valueOf(month);
			return String.valueOf(year)+m;
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
		}
		return null;
	}
	private String getPrevFrq(DBObject dbobject, String etlkey, String yyyymm){
		ResultSet rs = null;
		try {
			String str = "SELECT FREQUENCY FROM TBLMEASUREDEFINE WHERE ETLKEY=?";
			Object[] obj = {etlkey};

			rs = dbobject.executePreparedQuery(str,obj);

			String frq = "";
			while(rs.next()){
				frq = rs.getString("FREQUENCY");
			}
			int year = Integer.parseInt(yyyymm.substring(0,4));
			int month = Integer.parseInt(yyyymm.substring(4,6));

			if ("��".equals(frq)){
				if (month==1){
					month=12;
					year = year-1;
				} else {
					month=month-1;
				}
			} else if ("�б�".equals(frq)){
				if (month<4){
					month=12;
					year = year-1;
				} else if (month<7){
					month=3;
				} else if (month<10){
					month=6;
				} else {
					month=9;
				}
			} else if ("�ݱ�".equals(frq)){
				if (month<7){
					month=12;
					year=year-1;
				} else {
					month=6;
				}
			} else if ("��".equals(frq)){
				year=year-1;
				month=12;
			}

			String m = (month<10)?"0"+String.valueOf(month):String.valueOf(month);
			return String.valueOf(year)+m;
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
		}
		return null;
	}
	private String getQTR(String str){
		int tmp = Integer.parseInt(str);
		if (tmp<4) return "03";
		else if (tmp<7) return "06";
		else if (tmp<10) return "09";
		else return "12";
	}

	private String getPreQTR(String str){
		int tmp = Integer.parseInt(str);
		if (tmp<4) return "12";
		else if (tmp<7) return "03";
		else if (tmp<10) return "06";
		else return "09";
	}



	private String getMeasureId(DBObject dbobject, String etlkey, String year){
		ResultSet rs = null;
		String reval = null;
		try {
			String str = "SELECT ID FROM TBLMEASUREDEFINE WHERE ETLKEY=? AND YEAR=?";
			Object[] obj = {etlkey,year};
			rs = dbobject.executePreparedQuery(str,obj);
			if (rs.next()){
				reval = rs.getString("ID");
			}
		} catch (Exception e) {
			if (rs!=null){try { rs.close(); } catch (SQLException se) {} }
		}
		return reval;
	}

	private void updateDetail(DBObject dbobject,String etlkey, String yyyymm) {
		ResultSet rs = null;

		try {

			String strEqu = "SELECT ID, EQUATION,WEIGHT,TREND,FREQUENCY FROM TBLMEASUREDEFINE WHERE ETLKEY=? AND YEAR=?";
			Object[] pmEqu = {etlkey,yyyymm.substring(0,4)};

			if (rs!=null){rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(strEqu,pmEqu);
			String mid       = "";
			String equ       = "";
			String weight    = null;
			String trend     = null;
			String frequency = null;
			while(rs.next()){
				mid       = String.valueOf(rs.getInt("ID"));
				equ       = rs.getString("EQUATION");
				weight    = rs.getString("WEIGHT");
				trend     = rs.getString("TREND");
				frequency = rs.getString("FREQUENCY");
			}

			ExpressionParser exParser = new ExpressionParser(equ);
			Expression expression = exParser.getCompleteExpression();

			Vector vector = new Vector();
			expression.addUnknowns(vector);

			// 2. save item actual

			String year    = yyyymm.substring(0,4);
			String schDate = yyyymm.substring(0,6);
			/*
			 *
			 */


			// 3. get item actuals
			HashMap map = new HashMap();

			String strA = "SELECT A.*,I.ITEMTYPE FROM TBLITEMACTUAL A, TBLITEM I WHERE A.MEASUREID=I.MEASUREID AND A.CODE=I.CODE AND STRDATE=? AND A.MEASUREID=?";
			Object[] pmA = {schDate,mid};
			if (rs!=null) {rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(strA,pmA);

			int icnt = 0;
			while(rs.next()){
				double tmp = 0;
				if ("����".equals(rs.getString("ITEMTYPE"))){
					tmp = rs.getDouble("ACCUM");
				} else if ("���".equals(rs.getString("ITEMTYPE"))){
					tmp = rs.getDouble("AVERAGE");
				} else {
					tmp = rs.getDouble("ACTUAL");
				}
				map.put(rs.getString("CODE"),new Double(tmp) );
				icnt++;
			}
			int k = vector.size();


	//		 4. calcuate measure actual

			if (k<=icnt){
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

				measuredetail.actual    = actual.doubleValue();
				measuredetail.strDate   = Util.getLastMonth(schDate);
				measuredetail.weight    = new Float(weight).floatValue();
				measuredetail.measureId = new Integer(mid).intValue();
				measuredetail.trend     = (trend==null)?"����":trend;
				measuredetail.frequency = frequency;

				actaulutil.updateMeasureDetail(dbobject,measuredetail);
			}
		} catch (SQLException se) {

		} finally {
			if (rs!=null){try { rs.close(); } catch (SQLException se) {} }
		}
	}

	private void updateDetail(DBObject dbobject,double val,String etlkey,String itemCode, String yyyymm) {
		ResultSet rs = null;

		try {

			String strEqu = "SELECT ID, EQUATION,WEIGHT,TREND,FREQUENCY FROM TBLMEASUREDEFINE WHERE ETLKEY=? AND YEAR=?";
			Object[] pmEqu = {etlkey,yyyymm.substring(0,4)};

			if (rs!=null){rs.close(); rs=null;}

			rs = dbobject.executePreparedQuery(strEqu,pmEqu);
			String mid       = "";
			String equ       = "";
			String weight    = null;
			String trend     = null;
			String frequency = null;
			while(rs.next()){
				mid       = String.valueOf(rs.getInt("ID"));
				equ       = rs.getString("EQUATION");
				weight    = rs.getString("WEIGHT");
				trend     = rs.getString("TREND");
				frequency = rs.getString("FREQUENCY");
			}

			ExpressionParser exParser = new ExpressionParser(equ);
			Expression expression = exParser.getCompleteExpression();

			Vector vector = new Vector();
			expression.addUnknowns(vector);

			// 2. save item actual

			String year = yyyymm.substring(0,4);
			String schDate = yyyymm.substring(0,6);

			StringBuffer sbItem = new StringBuffer();
			sbItem.append("SELECT COUNT(ACTUAL) CNT,SUM(ACTUAL) ACC,AVG(ACTUAL) AVG FROM TBLITEMACTUAL WHERE MEASUREID=? AND CODE=? AND STRDATE>=? AND STRDATE<?");
			Object[] pmItem = {mid,itemCode,year+"01",schDate};

			StringBuffer sbItemI = new StringBuffer();
			sbItemI.append("INSERT INTO TBLITEMACTUAL (MEASUREID,CODE,STRDATE,INPUTDATE,ACTUAL,ACCUM,AVERAGE) VALUES (?,?,?,?,?, ?,?)");
			Object[] pmItemI = {mid,itemCode,schDate,Util.getToDay().substring(0,8),null,null,null};

			StringBuffer sbItemU = new StringBuffer();
			sbItemU.append("UPDATE TBLITEMACTUAL SET INPUTDATE=?,ACTUAL=?,ACCUM=?,AVERAGE=? WHERE MEASUREID=? AND CODE=? AND STRDATE=?");
			Object[] pmItemU = {Util.getToDay().substring(0,8),null,null,null,mid,itemCode,schDate};

			double acc=0;
			double avg=0;

			rs = dbobject.executePreparedQuery(sbItem.toString(),pmItem);
			while(rs.next()){
				int cnt = rs.getInt("CNT");
				if (cnt == 0){
					acc=val;
					avg=val;
				} else {
					acc = rs.getFloat("ACC")+val;
					avg = acc/(cnt+1);
				}
			}
			pmItemU[1] = new Double(val);
			pmItemU[2] = new Double(acc);
			pmItemU[3] = new Double(avg);
			if (dbobject.executePreparedUpdate(sbItemU.toString(),pmItemU)<1){
				pmItemI[4] = new Double(val);
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
				if ("����".equals(rs.getString("ITEMTYPE"))){
					tmp = rs.getDouble("ACCUM");
				} else if ("���".equals(rs.getString("ITEMTYPE"))){
					tmp = rs.getDouble("AVERAGE");
				} else {
					tmp = rs.getDouble("ACTUAL");
				}
				map.put(rs.getString("CODE"),new Double(tmp) );
				icnt++;
			}
			int k = vector.size();

	//		 4. calcuate measure actual
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
				measuredetail.trend = (trend==null)?"����":trend;
				measuredetail.frequency = frequency;

				actaulutil.updateMeasureDetail(dbobject,measuredetail);
			}
		} catch (SQLException se) {

		} finally {
			if (rs!=null){try { rs.close(); } catch (SQLException se) {} }
		}
	}

	private void updateETLData(DBObject dbobject,double val, String etlkey, String itemCode, String yyyymm) throws SQLException{
		String strU = "UPDATE TBLETLDATA SET ETLVAL=?,UPDATEDATE=SYSDATE WHERE ETLKEY=? AND ITEMCODE=? AND ETLDATE=?";
		Object[] pmU = {new Double(val),etlkey,itemCode,yyyymm};

		String strI = "INSERT INTO TBLETLDATA (ETLKEY,ITEMCODE,ETLDATE,ETLVAL,INPUTDATE) VALUES (?,?,?,?,SYSDATE)";
		Object[] pmI = {etlkey,itemCode,yyyymm,new Double(val)};

		if (dbobject.executePreparedUpdate(strU,pmU)<1){
			dbobject.executePreparedUpdate(strI,pmI);
		}
	}

	private double getVal(DBObject dbobject,String sql,String etlkey,String itemCode) throws SQLException{
		ResultSet rs = null;

		double reval=0;
		try {
            rs = dbobject.executeQuery((sql));

            if (rs.next()) reval = rs.getDouble(1);
            System.out.println(" run... etlkey / itemcode is : "+etlkey+"/"+itemCode+" value is :"+reval);
		} catch (SQLException e) {
			String msg = e.toString().replaceAll("\n","  ");
			System.out.println("etlkey / itemcode is : "+etlkey+"/"+itemCode+"  sql is :   errot is :"+e);
			throw new SQLException();
		} finally {

			if (rs !=null) { try{rs.close();rs=null; } catch (Exception e){}}
		}
		return reval;
	}

	private double getVal(String sql, EntSql ent){
		String driver = null;
		String username = null;
		String password = null;
		String charSet =  null;
		String database =  null;
		Connection connection = null;

		DBObject dbOut = null;
		ResultSet rs = null;

		double reval=0;
		try {
			//driver = ds.getString("driver");
			//username = ds.getString("username");
			//password = ds.getString("password");
			//charSet = ds.getString("charSet");
			//database = ds.getString("database");

            Class.forName(driver);
            Properties properties = new Properties();
            properties.setProperty("user", username);
            properties.setProperty("password", password);
            properties.setProperty("charSet", charSet);
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

	private ArrayList getRunList(DBObject dbobject, String date) {
		ResultSet rs=null;
		DataSet ds=null;
		try{
			String str = " SELECT R.ETLKEY,R.ITEMCODE,S.SQL,S.SQLTEXT,S.USEYN,S.CONNECTION,S.INPUTFREQUENCY,C.* FROM TBLETLRUNDATE R, TBLETLSQL S,TBLCONNECTION C "+
						 " WHERE S.CONNECTION=C.ID(+) AND R.ETLKEY=S.ETLKEY AND R.ITEMCODE=S.ITEMCODE AND R.RUNDATE = ? AND S.USEYN='Y' ORDER BY ETLKEY,ITEMCODE";
			Object[] pm = {date};
			rs = dbobject.executePreparedQuery(str,pm);

			ArrayList list = new ArrayList();

			while(rs.next()){
				EntSql ent = new EntSql();
				ent.etlKey   = rs.getString("ETLKEY");
				ent.itemCode = rs.getString("ITEMCODE");
				ent.inFRQ    = rs.getInt("INPUTFREQUENCY");

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
				//ent.sql = new String(output.toString().getBytes("euc-kr"),"8859_1");
				ent.sql = output.toString();

				ent.conn = rs.getInt("CONNECTION");
				list.add(ent);
			}
			//ds = new DataSet();
			//ds.load(rs);

			return list;

		} catch (SQLException se) {
			System.out.println(this.toString()+se);
		} catch (Exception e){
			System.out.print(this.toString()+e);
		} finally {
			if (rs!=null){try { rs.close(); } catch (SQLException se) {} }
		}

		return null;
	}



}
