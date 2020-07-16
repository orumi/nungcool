package com.nc.util;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.actual.ActualUtil;
import com.nc.actual.MeasureDetail;
import com.nc.cool.CoolServer;
import com.nc.cool.ExpressionUtil;
import com.nc.cool.ScorecardUtil;
import com.nc.sql.CoolConnection;
import com.nc.util.Importer;
import com.nc.util.Util;
import com.nc.cool.*;
import com.nc.math.*;

public class ImportUtil {

	public Importer getImport(String s ){
        if(s == null || s.length() == 0)
            return null;
        String s1 = s.substring(s.lastIndexOf(".")).toUpperCase();
        Importer importer = null;
        try {
            importer = new CSVImport();

            File file = new File(ServerStatic.REAL_CONTEXT_ROOT+"/import");
            File file1 = new File(file + File.separator + s);
            if(!file1.exists())
                file1 = new File(s);
            importer.setSource(file1.toString());
        }  catch(Exception e)  {
        	System.out.println(e);
        }
        return importer;
	}


	 public void importWork(String work, HashMap rtnMap, HttpServletRequest request)throws IOException, SQLException {
			Importer dataimporter = getImport(work);
			if(dataimporter == null)
			   return;

			String s = dataimporter.getSourceName();

			String[] projectField = new String[] {"ID","NAME"};
			String[] projectInfoField = new String[] {"NAME","ID","FIELDNAME","TYPENAME","PROJECTDESC", "PROJECTGOALDESC"};


			// 필드 유효성 검사
			dataimporter.load();
			int aaa = dataimporter.getColumnIndex("NAME");
			for (int i1=0; i1<projectInfoField.length;i1++){
				if ((dataimporter.getColumnIndex(projectInfoField[i1])) < 0 ) {
					rtnMap.put("error"," FIELD REQUIRED : "+projectInfoField[i1]);
					return;
				}
			}
			DBObject dbobject = null;
			CoolConnection conn = null;
			try {
				 conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				 String userid = (String)request.getSession().getAttribute("userId");
				 conn.createStatement(false);

				 if (dbobject == null) dbobject = new DBObject(conn.getConnection());
				 for (dataimporter.resetCursor();dataimporter.next();){
					 try {
						 setProject(dbobject, dataimporter, projectInfoField, userid);   /// with on line update for row count;;;
					 } catch (Exception e){
						 String temp = "Failed at row "+dataimporter.getCursor()+"  : "+ e.toString();
							temp = temp.replaceAll("\r\n","  ");
							temp = temp.replaceAll("\r","  ");
							temp = temp.replaceAll("\n"," ");
						 rtnMap.put("error",temp);
						 System.out.println("Inserting fail "+dataimporter.getCursor()+"\n"+e);
						 return;
					 }
				 }
				 conn.commit();
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e);
				rtnMap.put("error", "FAILED INSERT HIERARCHY");
			} finally {
				if (dbobject !=null){dbobject.close(); dbobject=null;}
				if (conn != null){conn.close();conn=null;}
				rtnMap.put("count", String.valueOf(dataimporter.getRowCount()));
			}
	}//-- method importWork



	 public void importGoal(String goal, HashMap rtnMap, HttpServletRequest request)throws IOException, SQLException {
			Importer dataimporter = getImport(goal);
			if(dataimporter == null)
			   return;

			String s = dataimporter.getSourceName();

			String[] projectField = new String[] {"ID","NAME"};
			String[] projectInfoField = new String[] { "PROJECTID", "NAME", "DETAILID", "STEPID", "EXECWORK", "SYEAR", "SQTR", "EYEAR", "EQTR", "MGRDEPT", "MGRUSER", "GOALLEV", "MAINDESC", "DRVMTHD", "ERRCNSDR"};

			// 필드 유효성 검사
			dataimporter.load();
			int aaa = dataimporter.getColumnIndex("NAME");
			for (int i1=0; i1<projectInfoField.length;i1++){
				if ((dataimporter.getColumnIndex(projectInfoField[i1])) < 0 ) {
					rtnMap.put("error"," FIELD REQUIRED : "+projectInfoField[i1]);
					return;
				}
			}
			DBObject dbobject = null;
			CoolConnection conn = null;
			try {
				 conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				 String userid = (String)request.getSession().getAttribute("userId");
				 conn.createStatement(false);

				 if (dbobject == null) dbobject = new DBObject(conn.getConnection());
				 for (dataimporter.resetCursor();dataimporter.next();){
					 try {
						 setPrjDetail(dbobject, dataimporter, projectInfoField, userid);   /// with on line update for row count;;;
					 } catch (Exception e){
						 String temp = "Failed at row "+dataimporter.getCursor()+"  : "+ e.toString();
							temp = temp.replaceAll("\r\n","  ");
							temp = temp.replaceAll("\r","  ");
							temp = temp.replaceAll("\n"," ");
						 rtnMap.put("error",temp);
						 System.out.println("Inserting fail "+dataimporter.getCursor()+"\n"+e);
						 return;
					 }
				 }
				 conn.commit();
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e);
				rtnMap.put("error", "FAILED INSERT HIERARCHY");
			} finally {
				if (dbobject !=null){dbobject.close(); dbobject=null;}
				if (conn != null){conn.close();conn=null;}
				rtnMap.put("count", String.valueOf(dataimporter.getRowCount()));
			}
	}//-- method importGoal



	 public void importStructure(String hierarchy, HashMap rtnMap) throws IOException, SQLException {
		 Importer dataimporter = getImport(hierarchy);

		 if(dataimporter == null)
		     return;
		 String s = dataimporter.getSourceName();
		 ScorecardUtil scorecardutil = null;
		 CoolConnection conn = null;
		 try {
			 conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			 conn.createStatement(false);
	         scorecardutil = new ScorecardUtil(conn.getConnection());

		     dataimporter.load();
		     scorecardutil.importStructure(dataimporter, rtnMap);

		     conn.commit();
		 } catch(IOException ie){
			 conn.rollback();
			 System.out.println(ie);
			 rtnMap.put("error", "Failed to import form "+ie);
		 } catch(Exception exception) {
			 conn.rollback();
			 System.out.println(exception);
			 rtnMap.put("error", "Failed to import form "+exception);
		 }finally{
			if (scorecardutil != null) scorecardutil.close();
			if (conn!=null){conn.close(); conn = null;}
		 }
	}

	 public void importUser(String user, HashMap rtnMap)throws IOException, SQLException {
			Importer dataimporter = getImport(user);
			if(dataimporter == null)
			   return;

			String s = dataimporter.getSourceName();

			String[] fields = new String[] {"userid","name","groupid"};
			String[] fullFields = new String[] {"userid","name","groupid","devcode","devname"};

			// 필드 유효성 검사
			dataimporter.load();
			for (int i1=0; i1<fields.length;i1++){
				if ((dataimporter.getColumnIndex(fields[i1])) < 0 ) {
					rtnMap.put("error"," FIELD REQUIRED : "+fields[i1]);
					return;
				}
			}
			DBObject dbobject = null;
			CoolConnection conn = null;
			try {
				 conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				 conn.createStatement(false);

				 if (dbobject == null) dbobject = new DBObject(conn.getConnection());
				 for (dataimporter.resetCursor();dataimporter.next();){
					 try {
						 setUser(dbobject,dataimporter, fullFields);   /// with on line update for row count;;;
					 } catch (Exception e){
						 String temp = "Failed at row "+dataimporter.getCursor()+"  : "+ e.toString();
							temp = temp.replaceAll("\r\n","  ");
							temp = temp.replaceAll("\r","  ");
							temp = temp.replaceAll("\n"," ");
						 rtnMap.put("error",temp);
						 System.out.println("Inserting fail "+dataimporter.getCursor()+"\n"+e);
						 return;
					 }
				 }
				 conn.commit();
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e);
				rtnMap.put("error", "FAILED INSERT HIERARCHY");
			} finally {
				if (dbobject !=null){dbobject.close(); dbobject=null;}
				if (conn != null){conn.close();conn=null;}
				rtnMap.put("count", String.valueOf(dataimporter.getRowCount()));
			}
	}
	 public void importAuthority (String authority, HashMap rtnMap)throws IOException, SQLException {
			Importer dataimporter = getImport(authority);
			if(dataimporter == null)
			   return;

			String s = dataimporter.getSourceName();

			String[] fields = new String[] {"etlkey","type","userId"};
			String[] fullFields = new String[] {"year","etlkey","type","userId"};

			// 필드 유효성 검사
			dataimporter.load();
			for (int i1=0; i1<fields.length;i1++){
				if ((dataimporter.getColumnIndex(fields[i1])) < 0 ) {
					rtnMap.put("error"," FIELD REQUIRED : "+fields[i1]);
					return;
				}
			}
			DBObject dbobject = null;
			CoolConnection conn = null;
			try {
				 conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				 conn.createStatement(false);

				 if (dbobject == null) dbobject = new DBObject(conn.getConnection());
				 for (dataimporter.resetCursor();dataimporter.next();){
					 try {
						 setAuthority (dbobject,dataimporter, fullFields);   /// with on line update for row count;;;
					 } catch (Exception e){
						 String temp = "Failed at row "+dataimporter.getCursor()+"  : "+ e.toString();
							temp = temp.replaceAll("\r\n","  ");
							temp = temp.replaceAll("\r","  ");
							temp = temp.replaceAll("\n"," ");
						 rtnMap.put("error",temp);
						 System.out.println("Inserting fail "+dataimporter.getCursor()+"\n"+e);
						 return;
					 }
				 }
				 conn.commit();
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e);
				rtnMap.put("error", "FAILED INSERT HIERARCHY");
			} finally {
				if (dbobject !=null){dbobject.close(); dbobject=null;}
				if (conn != null){conn.close();conn=null;}
				rtnMap.put("count", String.valueOf(dataimporter.getRowCount()));
			}
	}
	 public void importPlanned(String item, HashMap rtnMap)throws IOException, SQLException {
			/*  처리과정
			 * 1. Import 필드 유효성 검사
			 * 2. 반복
			 * 		2.1 ETL KEY 유효성 검사 (적절한 지표가 있는지?)
			 * 		2.2 항목코드가 적절한지 (기존 항목에 코드 유/무)
			 * 		2.3 항목저장 및 산식 저장.
			 * 3. 처리 결과 리턴.
			 */

			Importer dataimporter = getImport(item);
			if(dataimporter == null)
			   return;

			String s = dataimporter.getSourceName();

			String[] fields = new String[] {"year","etlkey","effectivedate","planned","plannedbase", "base","baselimit", "limit"};
			String[] fullFields = new String[] {"year","etlkey","effectivedate","planned","plannedbase", "base","baselimit","limit"};

			// 필드 유효성 검사
			dataimporter.load();
			for (int i1=0; i1<fields.length;i1++){
				if ((dataimporter.getColumnIndex(fields[i1])) < 0 ) {
					rtnMap.put("error"," FIELD REQUIRED : "+fields[i1]);
					return;
				}
			}
			DBObject dbobject = null;
			CoolConnection conn = null;
			try {
				 conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				 conn.createStatement(false);

				 if (dbobject == null) dbobject = new DBObject(conn.getConnection());
				 for (dataimporter.resetCursor();dataimporter.next();){
					 try {
						 setPlanned(dbobject,dataimporter, fullFields);   /// with on line update for row count;;;
					 } catch (Exception e){
						 String temp = "Failed at row "+dataimporter.getCursor()+"  "+e;
						 temp = temp.replaceAll("\r"," ");
						 temp = temp.replaceAll("\r\n"," ");
						 temp = temp.replaceAll("\n"," ");
						 rtnMap.put("error",temp);
						 System.out.println("Inserting fail "+dataimporter.getCursor()+"\n"+e);
						 return;
					 }
				 }
				 conn.commit();
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e);
				rtnMap.put("error", "FAILED INSERT HIERARCHY");
			} finally {
				if (dbobject !=null){dbobject.close(); dbobject=null;}
				if (conn != null){conn.close();conn=null;}
				rtnMap.put("count", String.valueOf(dataimporter.getRowCount()));
			}
	}
	 public void importItem(String item, HashMap rtnMap)throws IOException, SQLException {
			/*  처리과정
			 * 1. Import 필드 유효성 검사
			 * 2. 반복
			 * 		2.1 ETL KEY 유효성 검사 (적절한 지표가 있는지?)
			 * 		2.2 항목코드가 적절한지 (기존 항목에 코드 유/무)
			 * 		2.3 항목저장 및 산식 저장.
			 * 3. 처리 결과 리턴.
			 */

			Importer dataimporter = getImport(item);
			if(dataimporter == null)
			   return;

			String s = dataimporter.getSourceName();

			String[] fields = new String[] {"year","etlkey","itemcode","itemname","itementry","itemtype","itemequation"};
			String[] fullFields = new String[] {"year","etlkey","itemcode","itemname","itementry","itemtype","itemequation"};

			// 필드 유효성 검사
			dataimporter.load();
			for (int i1=0; i1<fields.length;i1++){
				if ((dataimporter.getColumnIndex(fields[i1])) < 0 ) {
					rtnMap.put("error"," FIELD REQUIRED : "+fields[i1]);
					return;
				}
			}
			DBObject dbobject = null;
			CoolConnection conn = null;
			try {
				 conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				 conn.createStatement(false);

				 if (dbobject == null) dbobject = new DBObject(conn.getConnection());
				 for (dataimporter.resetCursor();dataimporter.next();){
					 try {
						 setItem(dbobject,dataimporter, fullFields);   /// with on line update for row count;;;
					 } catch (Exception e){
						 String temp = "Failed at row "+dataimporter.getCursor()+"  "+e;
						 temp = temp.replaceAll("\r"," ");
						 temp = temp.replaceAll("\r\n"," ");
						 temp = temp.replaceAll("\n"," ");
						 rtnMap.put("error",temp);
						 System.out.println("Inserting fail "+dataimporter.getCursor()+"\n"+e);
						 return;
					 }
				 }
				 conn.commit();
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e);
				rtnMap.put("error", "FAILED INSERT HIERARCHY");
			} finally {
				if (dbobject !=null){dbobject.close(); dbobject=null;}
				if (conn != null){conn.close();conn=null;}
				rtnMap.put("count", String.valueOf(dataimporter.getRowCount()));
			}
	}


	private void setItem(DBObject dbobject, Importer importer, String[] fullFields) throws SQLException{
		PreparedStatement pstat = null;
		PreparedStatement pstat2 = null;
		PreparedStatement pstat3 = null;
		try{
			int[] meaid = getMeasure(dbobject,importer.getString(fullFields[0]), importer.getString(fullFields[1]),"tblmeasuredefine");

			if (meaid.length==0) throw new SQLException(" 해당 지표가 없습니다.");

			String sql = "update tblitem set itemname=?,itementry=?,itemtype=? where measureid=? and code=?";

			String itementry = importer.getString(fullFields[4]);
			if ((itementry==null)||("".equals(itementry))) throw new SQLException("itementry 값이 없습니다.");
			if (!(("입력".equals(itementry))||("ETL".equals(itementry))))
				throw new SQLException("itementry : 입력, ETL");

			String itemtype = importer.getString(fullFields[5]);
			if ((itemtype==null)||("".equals(itemtype))) throw new SQLException("itemtype 값이 없습니다.");
			if (!(("누적".equals(itemtype))||("평균".equals(itemtype))||("현재값".equals(itemtype))) )
				throw new SQLException("itemtype : 누적, 평균, 현재값");

			pstat = dbobject.getConnection().prepareStatement(sql);
			pstat.setString(1,importer.getString(fullFields[3]));
			pstat.setString(2,itementry);
			pstat.setString(3,itemtype);
			pstat.setString(5,importer.getString(fullFields[2]));

			String s2 = "insert into tblitem (measureid, Code, itemname,itementry,itemtype) values (?,?,?,?,?)";
			pstat2 = dbobject.getConnection().prepareStatement(s2);
			pstat2.setString(2,importer.getString(fullFields[2]));
			pstat2.setString(3,importer.getString(fullFields[3]));
			pstat2.setString(4,itementry);
			pstat2.setString(5,itemtype);

			for (int i = 0; i < meaid.length; i++) {
				pstat.setInt(4,meaid[i]);

				if (pstat.executeUpdate()<1){
					pstat2.setInt(1,meaid[i]);
					pstat2.executeUpdate();
				}
			}

			String s3 = "update tblmeasuredefine set equation=? where etlKey=? and year=?";
			pstat3 = dbobject.getConnection().prepareStatement(s3);
			String equ = importer.getString(fullFields[6]);
			String tequ = equ.replaceAll("X","\\$X");
			pstat3.setString(1,tequ);
			pstat3.setString(2,importer.getString(fullFields[1]));
			pstat3.setString(3,importer.getString(fullFields[0]));
			pstat3.executeUpdate();
		} finally {
			if (pstat != null) pstat.close();
			if (pstat2 != null) pstat2.close();
			if (pstat3 != null) pstat3.close();
		}
	}
	private void setPlanned(DBObject dbobject, Importer importer, String[] fullFields) throws SQLException{
		PreparedStatement pstat = null;
		PreparedStatement pstat1 = null;
		try{
			int[] meaid = getMeasure(dbobject,importer.getString(fullFields[0]), importer.getString(fullFields[1]),"tblmeasuredefine");

			if (meaid.length==0) throw new SQLException(" 해당 지표가 없습니다.");

			String strU = "UPDATE TBLMEASUREDETAIL SET PLANNED=?,PLANNEDBASE=?, BASE=?,BASELIMIT=?, LIMIT=? WHERE MEASUREID=? AND STRDATE=?";

			pstat = dbobject.getConnection().prepareStatement(strU);
			pstat.setDouble(1,Double.parseDouble(importer.getString(fullFields[3])));
			pstat.setDouble(2,Double.parseDouble(importer.getString(fullFields[4])));
			pstat.setDouble(3,Double.parseDouble(importer.getString(fullFields[5])));
			pstat.setDouble(4,Double.parseDouble(importer.getString(fullFields[6])));
			pstat.setDouble(5,Double.parseDouble(importer.getString(fullFields[7])));
			pstat.setString(7,Util.getLastMonth(importer.getString(fullFields[2])));

			String strI = "INSERT INTO TBLMEASUREDETAIL (ID,MEASUREID,STRDATE,PLANNED,PLANNEDBASE,BASE,BASELIMIT,LIMIT) VALUES (?,?,?,?,?,?,?,?) ";
			pstat1 = dbobject.getConnection().prepareStatement(strI);
			pstat1.setInt(1,dbobject.getNextId("TBLMEASUREDETAIL"));
			pstat1.setString(3,Util.getLastMonth(importer.getString(fullFields[2])));
			pstat1.setDouble(4,Double.parseDouble(importer.getString(fullFields[3])));
			pstat1.setDouble(5,Double.parseDouble(importer.getString(fullFields[4])));
			pstat1.setDouble(6,Double.parseDouble(importer.getString(fullFields[5])));
			pstat1.setDouble(7,Double.parseDouble(importer.getString(fullFields[6])));
			pstat1.setDouble(8,Double.parseDouble(importer.getString(fullFields[7])));

			for (int i = 0; i < meaid.length; i++) {
				pstat.setInt(6,meaid[i]);

				if (pstat.executeUpdate()<1){
					pstat1.setInt(2,meaid[i]);
					pstat1.executeUpdate();
				}
			}


		} finally {
			if (pstat != null) pstat.close();
			if (pstat1 != null) pstat1.close();
		}
	}
	private int[] getMeasure(DBObject dbobject, String year, String key, String table) throws SQLException{

		ResultSet rs = dbobject.executeQuery("SELECT id FROM "+table+" WHERE etlKey='"+key+"' and year="+year);
		String tmp = "";

		while (rs.next()) {
			tmp += "|"+String.valueOf(rs.getInt(1));
		}

		String[] at = tmp.split("\\|");
		int[] rv = new int[at.length-1];

		for (int i = 1; i < at.length; i++) {
			rv[i-1] = new Integer(at[i]).intValue();
		}

		return rv;
	}

	 public void importItemActual(String itemActual, HashMap rtnMap)throws IOException, SQLException {
		Importer dataimporter = getImport(itemActual);
		if(dataimporter == null)
		   return;

		String s = dataimporter.getSourceName();
		String[] fields = new String[] {"year","etlkey","effectiveDate","itemCode","itemValue"};
		String[] fullFields = new String[] {"year","etlkey","effectiveDate","planned","base","limit","itemCode","itemvalue"};

			// 필드 유효성 검사
		dataimporter.load();
		for (int i1=0; i1<fields.length;i1++){
			if ((dataimporter.getColumnIndex(fields[i1])) < 0 ) {
				rtnMap.put("error"," FIELD REQUIRED : "+fields[i1]);
				return;
			}
		}
		//ExpressionUtil expressionutil = null;
		DBObject dbobject = null;
		CoolConnection conn = null;
		ActualUtil actualutil = null;
		//ExpressionUtil expressionutil = null;
		try {
			 //expressionutil = new ExpressionUtil(this);
			 conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			 conn.createStatement(false);

			if (dbobject == null) dbobject = new DBObject(conn.getConnection());
			if (actualutil == null) actualutil = new ActualUtil();
			//if (expressionutil == null) expressionutil = new ExpressionUtil(conn.getConnection());

			for (dataimporter.resetCursor();dataimporter.next();){
				try {
					setItemActual(actualutil, dbobject, dataimporter, fullFields);   /// with on line update for row count;;;
				} catch (Exception e){
					rtnMap.put("error","Failed at row "+dataimporter.getCursor());
					System.out.println("Inserting fail "+dataimporter.getCursor()+"\n"+e);
					return;
				}
			}
			conn.commit();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			rtnMap.put("error", "FAILED INSERT HIERARCHY");
		} finally {
			//if (expressionutil != null) expressionutil.close();
			//if (actualutil != null) actualutil.close();
			if (dbobject != null) dbobject.close();
			if (conn != null) conn.close();
			rtnMap.put("count", String.valueOf(dataimporter.getRowCount()-1));
		}
	}


	private void setItemActual(ActualUtil actualutil, DBObject dbobject, Importer importer, String[] fullFields) throws SQLException{
		PreparedStatement pstat = null;
		PreparedStatement pstat2 = null;
		PreparedStatement pstat3 = null;
		ResultSet rs = null;
		try{
			int[] meaid = getMeasure(dbobject,importer.getString(fullFields[0]), importer.getString(fullFields[1]),"tblmeasuredefine");

			if (meaid.length==0) throw new SQLException("해당 지표가 없습니다.");

			for (int j = 0; j < meaid.length; j++) {
				String itemCD = importer.getString(fullFields[6]);
				String strdate = importer.getString(fullFields[2]);
				String itemActual = importer.getString(fullFields[7]);
				String[] itemValue = itemActual.split("\\|");
				String[] code = itemCD.split("\\|");
				double[] act = new double[code.length];
				double[] acc = new double[code.length];
				double[] avg = new double[code.length];
				String[] itemType = new String[code.length];
				Double[] cal = new Double[code.length];

				HashMap map = new HashMap();

				StringBuffer sbItem = new StringBuffer();
				sbItem.append("SELECT COUNT(ACTUAL) CNT,SUM(ACTUAL) ACC,AVG(ACTUAL) AVG FROM TBLITEMACTUAL WHERE MEASUREID=? AND CODE=? AND STRDATE>=? AND STRDATE<?");
				Object[] pmItem = {new Integer(meaid[j]),null,strdate.substring(0,4)+"01",strdate};

				StringBuffer sbItemI = new StringBuffer();
				sbItemI.append("INSERT INTO TBLITEMACTUAL (MEASUREID,CODE,STRDATE,INPUTDATE,ACTUAL,ACCUM,AVERAGE) VALUES (?,?,?,?,?, ?,?)");
				Object[] pmItemI = {new Integer(meaid[j]),null,strdate,Util.getToDay().substring(0,8),null,null,null};

				StringBuffer sbItemU = new StringBuffer();
				sbItemU.append("UPDATE TBLITEMACTUAL SET INPUTDATE=?,ACTUAL=?,ACCUM=?,AVERAGE=? WHERE MEASUREID=? AND CODE=? AND STRDATE=?");
				Object[] pmItemU = {Util.getToDay().substring(0,8),null,null,null,new Integer(meaid[j]),null,strdate};

				for (int i = 0; i < code.length; i++) {
					act[i] = new Double(itemValue[i]).doubleValue();
					itemType[i] = getItemType(dbobject,code[i],meaid[j]);
					if (rs!=null){rs.close(); rs=null;}
					pmItem[1]=code[i];
					rs = dbobject.executePreparedQuery(sbItem.toString(),pmItem);
					while(rs.next()){
						int cnt = rs.getInt("CNT");
						if (cnt == 0){
							acc[i]=act[i];
							avg[i]=act[i];
						} else {
							acc[i] = rs.getDouble("ACC")+act[i];
							avg[i] = acc[i]/(cnt+1);
						}
					}
					pmItemU[1] = new Double(act[i]);
					pmItemU[2] = new Double(acc[i]);
					pmItemU[3] = new Double(avg[i]);
					pmItemU[5] = code[i];
					if (dbobject.executePreparedUpdate(sbItemU.toString(),pmItemU)<1){
						pmItemI[1] = code[i];
						pmItemI[4] = new Double(act[i]);
						pmItemI[5] = new Double(acc[i]);
						pmItemI[6] = new Double(avg[i]);

						dbobject.executePreparedUpdate(sbItemI.toString(),pmItemI);
					}

					if (itemType[i].equals("누적")){
						cal[i]=new Double(acc[i]);
					} else if (itemType[i].equals("평균")){
						cal[i]=new Double(avg[i]);
					} else {
						cal[i]=new Double(act[i]);
					}
					map.put(code[i],cal[i]);
				}

				String strEqu = "SELECT EQUATION,WEIGHT,TREND,FREQUENCY FROM TBLMEASUREDEFINE WHERE ID=?";
				Object[] pmEqu = {new Integer(meaid[j])};

				if (rs!=null){rs.close(); rs=null;}

				rs = dbobject.executePreparedQuery(strEqu,pmEqu);
				String equ = "";
				String weight = null;
				String trend = null;
				String frequency = null;
				while(rs.next()){
					equ = rs.getString("EQUATION");
					weight = rs.getString("WEIGHT");
					trend = rs.getString("TREND");
					frequency = rs.getString("FREQUENCY");
				}

				ExpressionParser exParser = new ExpressionParser(equ);
				Expression expression = exParser.getCompleteExpression();

				Vector vector = new Vector();
				expression.addUnknowns(vector);
				int k = vector.size();
				Hashtable table = new Hashtable();
				for (int l = 0; l < k ; l++) {
					String icd = (String)vector.get(l);
					Object obj = map.get(icd);
					table.put(icd,obj);
				}

				Double actual = (Double)expression.evaluate(table);

				MeasureDetail measuredetail = actualutil.getMeasureDetail (dbobject,String.valueOf(meaid[j]),strdate);
				measuredetail.actual = actual.doubleValue();
				measuredetail.strDate = Util.getLastMonth(strdate);
				measuredetail.weight = new Float(weight).floatValue();
				measuredetail.measureId = new Integer(meaid[j]).intValue();
				measuredetail.trend = (trend==null)?"상향":trend;
				measuredetail.frequency = frequency;

				actualutil.updateMeasureDetail(dbobject,measuredetail);
			}


		} catch (Exception e){
			System.out.println(e);
			throw new SQLException(""+e);
		} finally {
			if (rs != null) {rs.close(); rs=null;}
			if (pstat != null) pstat.close();
			if (pstat2 != null) pstat2.close();
			if (pstat3 != null) pstat3.close();
		}
	}

	private String getItemType(DBObject dbobject, String code,int mid) throws SQLException{
		ResultSet rs = dbobject.executeQuery("SELECT ITEMTYPE FROM TBLITEM WHERE MEASUREID='"+mid+"' AND CODE='"+code+"'");
		if (rs.next()) return rs.getString(1);
		return null;
	}

    private Expression getExpression(String eqn){
        Expression expr = null;
    	if(eqn == null || "".equals(eqn))
            return null;

        ExpressionParser expressionparser = new ExpressionParser(eqn);
        expr = expressionparser.getCompleteExpression();
        return expr;
    }

	private String getExpression(DBObject dbobject, int meaid) throws SQLException{
		ResultSet rs = dbobject.executeQuery("SELECT equation FROM a_measure WHERE id='"+meaid+"'");
		if (rs.next()) return rs.getString(1);
		return null;
	}

	private Float getWeight(DBObject dbobject, int id) throws SQLException{
		ResultSet rs = dbobject.executeQuery("SELECT weight FROM a_measure WHERE id='"+id+"'");
		if (rs.next()) return new Float(rs.getFloat(1));
		return null;
	}

	private void setMeasure(DBObject dbobject, MeasureDetail md) throws SQLException{
		ResultSet rs = dbobject.executeQuery("SELECT weighting, frequency FROM a_measure WHERE id='"+md.measureId+"'");
		if (rs.next()){
			md.weight = rs.getFloat(1);
			md.frequency = rs.getString("frequency");
		}

		ResultSet rs1 = dbobject.executePreparedQuery("SELECT * FROM tbl_measuredefine where ameasureId=?",new Object[]{new Integer(md.measureId)});
		if (rs1.next()){


			md.trend = rs1.getString("trend");

		}
	}

	private void setUser(DBObject dbobject, Importer importer, String[] fullFields) throws SQLException
	{
		PreparedStatement pstat = null;
		PreparedStatement pstat2 = null;

		try{
			String devCode = null;
			String devName = importer.getString(fullFields[4])==null?"":importer.getString(fullFields[4]);
			if (devName.equals("")){
				String sql = "UPDATE TBLUSER SET GROUPID=?,INPUTDATE=? WHERE USERID=?";
				pstat = dbobject.getConnection().prepareStatement(sql);
				pstat.setString(1,importer.getString(fullFields[2]));
				pstat.setString(2,Util.getToDayTime());
				pstat.setString(3,importer.getString(fullFields[0]));

				if (pstat.executeUpdate()<1){
					String s2 = "INSERT INTO TBLUSER (USERID,USERNAME,PASSWORD,GROUPID,INPUTDATE) VALUES (?,?,'BHABNOEKANOJGAKCFKEODKAJALFKCHMKNAMCCAAC',?,?)";
					pstat2 = dbobject.getConnection().prepareStatement(s2);
					pstat2.setString(1,importer.getString(fullFields[0]));
					pstat2.setString(2,(importer.getString(fullFields[1])));
					pstat2.setString(3,importer.getString(fullFields[2]));
					pstat2.setString(4,Util.getToDayTime());
					pstat2.executeUpdate();
				}
			} else {
				String sql = "UPDATE TBLUSER SET GROUPID=?, DIVCODE=(SELECT ID FROM TBLBSC WHERE NAME=?),INPUTDATE=? WHERE USERID=?";
				pstat = dbobject.getConnection().prepareStatement(sql);
				pstat.setString(1,importer.getString(fullFields[2]));
				pstat.setString(2,importer.getString(fullFields[4]));
				pstat.setString(3,Util.getToDayTime());
				pstat.setString(4,importer.getString(fullFields[0]));

				if (pstat.executeUpdate()<1){
					String s2 = "INSERT INTO TBLUSER (USERID,USERNAME,PASSWORD,GROUPID,DIVCODE,INPUTDATE) VALUES (?,?,'BHABNOEKANOJGAKCFKEODKAJALFKCHMKNAMCCAAC',?,?," +
							"(SELECT ID FROM TBLBSC WHERE NAME=?))";
					pstat2 = dbobject.getConnection().prepareStatement(s2);
					pstat2.setString(1,importer.getString(fullFields[0]));
					pstat2.setString(2,(importer.getString(fullFields[1])));
					pstat2.setString(3,importer.getString(fullFields[2]));
					pstat2.setString(4,importer.getString(fullFields[4]));
					pstat2.setString(5,Util.getToDayTime());

					pstat2.executeUpdate();
				}
			}
		} finally {
			if (pstat != null) pstat.close();
			if (pstat2 != null) pstat2.close();
		}
	}//-- method setUser


	public void setProject(DBObject dbobject, Importer importer, String[] projectInfoField, String userid) throws SQLException
	{
		PreparedStatement pstat = null;
		PreparedStatement pstat2 = null;


		try{
			String devCode = null;
			String devName = importer.getString(projectInfoField[1])==null?"":(importer.getString(projectInfoField[1]));

			String sql = "update tblstratproject set name = ? where id = ?";

			Object[] pa1 = {importer.getString(projectInfoField[0]), importer.getString(projectInfoField[1]) };


			int execQ = dbobject.executePreparedUpdate(sql, pa1);

//			pstat = dbobject.getConnection().prepareStatement(sql);
//			pstat.setString(1,importer.getString(projectInfoField[0]));
//			pstat.setInt(2,Integer.parseInt(importer.getString(projectInfoField[1])));

//			System.out.println(importer.getString(projectInfoField[0]));
//			System.out.println(importer.getString(projectInfoField[1]));


			if (execQ < 1)
			{
				String s2 = "insert into tblstratproject (id, name)values((select nvl(max(id)+1,1) from tblstratproject ), ?)";
				Object[] pm = {importer.getString(projectInfoField[0])};
				dbobject.executePreparedUpdate(s2, pm);

				//pstat2 = dbobject.getConnection().prepareStatement(s2);
				//pstat2.setString(1,(importer.getString(projectInfoField[0])));
				//pstat2.executeUpdate();
			}

			StringBuffer insertSql  = new StringBuffer();

			insertSql.append("update tblstratprojectinfo set PROJECTDESC = ?, PROJECTGOALDESC = ?  ") ;
			insertSql.append("where CONTENTID = ? ") ;

			Object[] pmInsert = {importer.getString(projectInfoField[4]),importer.getString(projectInfoField[5]),importer.getString(projectInfoField[1]) };

			dbobject.executePreparedUpdate(insertSql.toString(), pmInsert);

			//pstat = dbobject.getConnection().prepareStatement(insertSql.toString());
			//pstat.setString(1,(importer.getString(projectInfoField[4])));
			//pstat.setString(2,(importer.getString(projectInfoField[5])));
			//pstat.setString(3,(importer.getString(projectInfoField[1])));



			if(dbobject.executePreparedUpdate(insertSql.toString(), pmInsert) < 1)
			{
				StringBuffer strSQL = new StringBuffer();
				strSQL.append("insert into tblstratprojectinfo (PROJECTID, FIELDID, TYPEID, PROJECTDESC, PROJECTGOALDESC, REGIR, CONTENTID) ") ;
				strSQL.append("                            values( ") ;
				strSQL.append("                                (select nvl(max(PROJECTID)+1, 1) from tblstratprojectinfo),  ") ;
				strSQL.append("                                NVL((select FIELDID from tblstratfieldinfo where FIELDNAME = ? ), 1), ") ;
				strSQL.append("                                NVL((select TYPEID from tblstrattypeinfo where TYPENAME = ? ), 1), ") ;
				strSQL.append("                                ?, ") ;
				strSQL.append("                                ?, ") ;
				strSQL.append("                                ?, ") ;
				strSQL.append("                                (select max(id) from tblstratproject)) ") ;

				pstat2 = dbobject.getConnection().prepareStatement(strSQL.toString());
				String tmp = importer.getString(projectInfoField[2]);
				pstat2.setString(1,(importer.getString(projectInfoField[2])));
				pstat2.setString(2,(importer.getString(projectInfoField[3])));
				pstat2.setString(3,(importer.getString(projectInfoField[4])));
				pstat2.setString(4,(importer.getString(projectInfoField[5])));
				pstat2.setString(5,userid);

				System.out.println("aaa       "  + importer.getString(projectInfoField[2]));
				System.out.println("bbb       "  + importer.getString(projectInfoField[3]));
				System.out.println("ccc       "  + importer.getString(projectInfoField[4]));
				System.out.println("ddd       "  + importer.getString(projectInfoField[5]));



				pstat2.executeUpdate();
			}



//			} else {
//				String sql = "UPDATE TBLUSER SET GROUPID=?, DIVCODE=(SELECT ID FROM TBLBSC WHERE NAME=?),INPUTDATE=? WHERE USERID=?";
//				pstat = dbobject.getConnection().prepareStatement(sql);
//				pstat.setString(1,importer.getString(fullFields[2]));
//				pstat.setString(2,importer.getString(fullFields[4]));
//				pstat.setString(3,Util.getToDayTime());
//				pstat.setString(4,importer.getString(fullFields[0]));
//
//				if (pstat.executeUpdate()<1){
//					String s2 = "INSERT INTO TBLUSER (USERID,USERNAME,PASSWORD,GROUPID,DIVCODE,INPUTDATE) VALUES (?,?,'BHABNOEKANOJGAKCFKEODKAJALFKCHMKNAMCCAAC',?,?," +
//							"(SELECT ID FROM TBLBSC WHERE NAME=?))";
//					pstat2 = dbobject.getConnection().prepareStatement(s2);
//					pstat2.setString(1,importer.getString(fullFields[0]));
//					pstat2.setString(2,(importer.getString(fullFields[1])));
//					pstat2.setString(3,importer.getString(fullFields[2]));
//					pstat2.setString(4,importer.getString(fullFields[4]));
//					pstat2.setString(5,Util.getToDayTime());
//
//					pstat2.executeUpdate();
//				}
//			}
		} finally {
			if (pstat != null) pstat.close();
			if (pstat2 != null) pstat2.close();
		}
	}//-- method setProject


	public void setPrjDetail(DBObject dbobject, Importer importer, String[] prjDtl, String userid) throws SQLException
	{
		PreparedStatement pstat = null;
		PreparedStatement pstat2 = null;

		try{
			String devCode = null;
			String devName = importer.getString(prjDtl[1])==null?"":importer.getString(prjDtl[1]);

			StringBuffer sql = new StringBuffer();
			sql.append("update tblstratprojectdetail set ") ;
			sql.append("STEPID = ?, ") ;
			sql.append("MGRUSER = ?, ") ;
			sql.append("EXECWORK=?, ") ;
			sql.append("GOALLEV=?, ") ;

			sql.append("MAINDESC=?, ") ;
			sql.append("DRVMTHD=?, ") ;
			sql.append("ERRCNSDR=?, ") ;
			sql.append("MODIR=?, ") ;

			sql.append("MODIDATE=sysdate, ") ;

			sql.append("MGRDEPT=?, ") ;
			sql.append("SYEAR=?, ") ;
			sql.append("SQTR=?, ") ;
			sql.append("EYEAR=?, ") ;

			sql.append("EQTR=? ") ;
			sql.append("where ") ;
			sql.append("DETAILID = ? ") ;




			Object[] pa1 = {Util.getEUCKR(importer.getString(prjDtl[3])),
							Util.getEUCKR(importer.getString(prjDtl[10])),
							Util.getEUCKR(importer.getString(prjDtl[4])),
							Util.getEUCKR(importer.getString(prjDtl[11])),

							Util.getEUCKR(importer.getString(prjDtl[12])),
							Util.getEUCKR(importer.getString(prjDtl[13])),
							Util.getEUCKR(importer.getString(prjDtl[14])) ,
							userid ,

							Util.getEUCKR(importer.getString(prjDtl[9])) ,
							Util.getEUCKR(importer.getString(prjDtl[5])) ,
							Util.getEUCKR(importer.getString(prjDtl[6])) ,
							Util.getEUCKR(importer.getString(prjDtl[7])) ,

							Util.getEUCKR(importer.getString(prjDtl[8])) ,
							Util.getEUCKR(importer.getString(prjDtl[2])) ,
			};


			int execQ = dbobject.executePreparedUpdate(sql.toString(), pa1);

//			pstat = dbobject.getConnection().prepareStatement(sql);
//			pstat.setString(1,importer.getString(projectInfoField[0]));
//			pstat.setInt(2,Integer.parseInt(importer.getString(projectInfoField[1])));

//			System.out.println(importer.getString(prjDtl[0]));
//			System.out.println(importer.getString(prjDtl[1]));

			if (execQ < 1)
			{
				StringBuffer strSQL = new StringBuffer();
				strSQL.append("insert into tblstratprojectdetail ") ;
				strSQL.append("                                ( ") ;
				strSQL.append("                                    PROJECTID, ") ;
				strSQL.append("                                    STEPID,  ") ;
				strSQL.append("                                    DETAILID,  ") ;
				strSQL.append("                                    MGRUSER,  ") ;
				strSQL.append("                                    EXECWORK,  ") ;

				strSQL.append("                                    GOALLEV,  ") ;
				strSQL.append("                                    MAINDESC,  ") ;
				strSQL.append("                                    DRVMTHD,  ") ;
				strSQL.append("                                    ERRCNSDR,  ") ;
				strSQL.append("                                    REGIR,  ") ;

				strSQL.append("                                    MGRDEPT,  ") ;
				strSQL.append("                                    SQTR,  ") ;
				strSQL.append("                                    EQTR,  ") ;
				strSQL.append("                                    SYEAR,  ") ;
				strSQL.append("                                    EYEAR ") ;
				strSQL.append("                                )values( ") ;

				strSQL.append("                                    ?, ") ;
				strSQL.append("                                    nvl(?, 1), ") ;
				strSQL.append("                                    (select nvl(max(DETAILID)+1, 1) from tblstratprojectdetail), ") ;
				strSQL.append("                                    nvl(?, 'admin'), ") ;
				strSQL.append("                                    ?, ") ;

				strSQL.append("                                    ?, ") ;
				strSQL.append("                                    ?, ") ;
				strSQL.append("                                    ?, ") ;
				strSQL.append("                                    ?, ") ;
				strSQL.append("                                    ?, ") ;

				strSQL.append("                                    ?, ") ;
				strSQL.append("                                    ?, ") ;
				strSQL.append("                                    ?, ") ;
				strSQL.append("                                    ?, ") ;
				strSQL.append("                                    ? ") ;
				strSQL.append("                                ) ") ;

				pstat2 = dbobject.getConnection().prepareStatement(strSQL.toString());
				pstat2.setString(1,Util.getEUCKR(importer.getString(prjDtl[0])));	//projectid
				pstat2.setString(2,Util.getEUCKR(importer.getString(prjDtl[3])));	//stepid
				pstat2.setString(3,Util.getEUCKR(importer.getString(prjDtl[10])));	//mgruser
				pstat2.setString(4,Util.getEUCKR(importer.getString(prjDtl[4])));	//execwork

				pstat2.setString(5,Util.getEUCKR(importer.getString(prjDtl[11])));	//goallev
				pstat2.setString(6,Util.getEUCKR(importer.getString(prjDtl[12])));	//maindesc
				pstat2.setString(7,Util.getEUCKR(importer.getString(prjDtl[13])));	//drvmthd
				pstat2.setString(8,Util.getEUCKR(importer.getString(prjDtl[14])));	//errcnsdr
				pstat2.setString(9,userid);							//regir

				pstat2.setString(10,Util.getEUCKR(importer.getString(prjDtl[9])));	//sqtr
				pstat2.setString(11,Util.getEUCKR(importer.getString(prjDtl[6])));	//sqtr
				pstat2.setString(12,Util.getEUCKR(importer.getString(prjDtl[8])));	//eqtr
				pstat2.setString(13,Util.getEUCKR(importer.getString(prjDtl[5])));	//syear
				pstat2.setString(14,Util.getEUCKR(importer.getString(prjDtl[7])));	//eyear

				pstat2.executeUpdate();
			}


		} finally {
			if (pstat != null) pstat.close();
			if (pstat2 != null) pstat2.close();
		}
	}	//-- method setPrjDetail

	private void setAuthority (DBObject dbobject, Importer importer, String[] fullFields) throws SQLException{
		PreparedStatement pstat = null;
		PreparedStatement pstat2 = null;
		/*
		 * 처리과정
		 * 1. 사용자 정보를 가져온다. (권한설정을 3으로 한다.)
		 * 2. 정/부를 구분하여 저장한다.
		 */
		try{
			String userId = importer.getString(fullFields[3])!=null?importer.getString(fullFields[3]):"";
			String year = importer.getString(fullFields[0])!=null?importer.getString(fullFields[0]):Util.getToDay().substring(0,4);
			String strU = "UPDATE TBLUSER SET GROUPID=3 WHERE USERID=?";
			Object[] pmU = {userId};

			if (dbobject.executePreparedUpdate(strU,pmU)<1){
				throw new SQLException("해당 담당자가 없습니다.");
			}

			String kind = importer.getString(fullFields[2])!=null?importer.getString(fullFields[2]):"";
			String etlkey = importer.getString(fullFields[1])!=null?importer.getString(fullFields[1]):"";
			int[] mid = getMeasure(dbobject,year,etlkey,"tblmeasuredefine");

			if (mid.length==0) throw new SQLException("해당 성과지표가 없습니다.");

			if ("정".equals(kind)){
				String strUM = "UPDATE TBLMEASUREDEFINE SET UPDATEID=? WHERE ID=?";
				Object[] pmUM ={userId,null};
				for (int i = 0; i < mid.length; i++) {
					pmUM[1] = new Integer(mid[i]);
					dbobject.executePreparedUpdate(strUM,pmUM);
				}
			} else {
				String strAU = "UPDATE TBLAUTHORITY SET USERID=? WHERE YEAR=? AND USERID=? AND MEASUREID=?";
				Object[] pmAU = {userId,year,userId,null};
				String strAI = "INSERT INTO TBLAUTHORITY (YEAR,MEASUREID,USERID) VALUES (?,?,?)";
				Object[] pmAI = {year,null,userId};
				for (int i = 0; i < mid.length; i++) {
					pmAU[3] = new Integer(mid[i]);
					if (dbobject.executePreparedUpdate(strAU,pmAU)<1){
						pmAI[1] = pmAU[3];
						dbobject.executePreparedUpdate(strAI,pmAI);
					}
				}

			}

		} finally {
			if (pstat != null) pstat.close();
			if (pstat2 != null) pstat2.close();
		}
	}

	public void importTaskActual(String taskActual, HashMap rtnMap, HttpServletRequest request, HttpServletResponse response)throws IOException, SQLException {
		Importer dataimporter = getImport(taskActual);
		if(dataimporter == null)
		   return;

		String s = dataimporter.getSourceName();
		String[] fields = new String[] {"년도","ETLKEY","지표명","산식","실적년월","그룹","부서"};
		//String[] ful	lFields = new String[] {"year","etlkey","effectiveDate","planned","plannedbase","base","baselimit","limit","itemCode","itemvalue"};

		// 필드 유효성 검사
		dataimporter.load();
		for (int i1=0; i1<fields.length;i1++){
			if ((dataimporter.getColumnIndex(fields[i1]	)) < 0 ) {
				rtnMap.put("error"," FIELD REQUIRED : "+fields[i1]);
				System.out.println("error field read");
				//return;
			}
		}

		//ExpressionUtil expressionutil = null;
		DBObject dbobject = null;
		CoolConnection conn = null;
		ActualUtil actualutil = null;
		//ExpressionUtil expressionutil = null;
		try {

			String userId = (String)request.getSession().getAttribute("userId");

			 //expressionutil = new ExpressionUtil(this);
			 conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			 conn.createStatement(false);

			if (dbobject == null) dbobject = new DBObject(conn.getConnection());
			if (actualutil == null) actualutil = new ActualUtil();
			//if (expressionutil == null) expressionutil = new ExpressionUtil(conn.getConnection());

			for (dataimporter.resetCursor();dataimporter.next();){
				//System.out.println("dataimporter read");
				try {

					settaskItemActual(actualutil, dbobject, dataimporter, fields, userId);   /// with on line update for row count;;;
				} catch (Exception e){
					rtnMap.put("error","Failed at row "+dataimporter.getCursor());
					System.out.println("Inserting fail "+dataimporter.getCursor()+"\n"+e);
					return;
				}
			}
			conn.commit();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			rtnMap.put("error", "FAILED INSERT HIERARCHY");
		} finally {
			//if (expressionutil != null) expressionutil.close();
			//if (actualutil != null) actualutil.close();
			if (dbobject != null) dbobject.close();
			if (conn != null) conn.close();
			rtnMap.put("count", String.valueOf(dataimporter.getRowCount()-1));
		}
	}

	private void settaskItemActual(ActualUtil actualutil, DBObject dbobject, Importer importer, String[] fullFields,String userId) throws SQLException{
		PreparedStatement pstat = null;
		PreparedStatement pstat2 = null;
		PreparedStatement pstat3 = null;
		ResultSet rs = null;

		try{
			int[] meaid = getMeasure(dbobject,importer.getString(fullFields[0]), importer.getString(fullFields[1]),"tblmeasuredefine");

			if (meaid.length==0) throw new SQLException("해당 지표가 없습니다.");

			rs = dbobject.executeQuery("SELECT * FROM TBLITEM WHERE MEASUREID="+meaid[0]+"");
			DataSet dsItem = new DataSet();
			dsItem.load(rs);
			int itemCnt = dsItem.getRowCount();

			for (int j = 0; j < meaid.length; j++) {
				//String itemCD = importer.getString(fullFields[6]);
				String strdate = importer.getString(fullFields[4]).trim();
				//String itemActual = new String[itemCnt];
				String[] itemValue = new String[itemCnt];
				String[] code = new String[itemCnt];
				//System.out.println("file data process...:"+strdate);
				if(!strdate.equals("")){
					for(int i=0;i<itemCnt;i++){
						itemValue[i] = importer.getString(8+i);
					}

					int jc = 0;
					if(dsItem != null){
						dsItem.resetCursor();
						while(dsItem.next()){
							code[jc] = dsItem.getString("CODE");
							jc++;
						}
					}
					//System.out.println("Import:"+code.length+"/"+meaid.length+strdate);
					double[] act = new double[code.length];
					double[] acc = new double[code.length];
					double[] avg = new double[code.length];
					String[] itemType = new String[code.length];
					Double[] cal = new Double[code.length];

					HashMap map = new HashMap();

					StringBuffer sbItem = new StringBuffer();
					sbItem.append("SELECT COUNT(ACTUAL) CNT,SUM(ACTUAL) ACC,AVG(ACTUAL) AVG FROM TBLITEMACTUAL WHERE MEASUREID=? AND CODE=? AND STRDATE>=? AND STRDATE<?");
					Object[] pmItem = {new Integer(meaid[j]),null,strdate.substring(0,4)+"01",strdate};

					StringBuffer sbItemI = new StringBuffer();
					sbItemI.append("INSERT INTO TBLITEMACTUAL (MEASUREID,CODE,STRDATE,INPUTDATE,ACTUAL,ACCUM,AVERAGE) VALUES (?,?,?,?,?, ?,?)");
					Object[] pmItemI = {new Integer(meaid[j]),null,strdate,Util.getToDay().substring(0,8),null,null,null};

					StringBuffer sbItemU = new StringBuffer();
					sbItemU.append("UPDATE TBLITEMACTUAL SET INPUTDATE=?,ACTUAL=?,ACCUM=?,AVERAGE=? WHERE MEASUREID=? AND CODE=? AND STRDATE=?");
					Object[] pmItemU = {Util.getToDay().substring(0,8),null,null,null,new Integer(meaid[j]),null,strdate};

					for (int i = 0; i < code.length; i++) {
						act[i] = new Double(itemValue[i]).doubleValue();
						itemType[i] = getItemType(dbobject,code[i],meaid[j]);
						if (rs!=null){rs.close(); rs=null;}
						pmItem[1]=code[i];
						rs = dbobject.executePreparedQuery(sbItem.toString(),pmItem);
						while(rs.next()){
							int cnt = rs.getInt("CNT");
							if (cnt == 0){
								acc[i]=act[i];
								avg[i]=act[i];
							} else {
								acc[i] = rs.getDouble("ACC")+act[i];
								avg[i] = acc[i]/(cnt+1);
							}
						}
						pmItemU[1] = new Double(act[i]);
						pmItemU[2] = new Double(acc[i]);
						pmItemU[3] = new Double(avg[i]);
						pmItemU[5] = code[i];
						if (dbobject.executePreparedUpdate(sbItemU.toString(),pmItemU)<1){
							pmItemI[1] = code[i];
							pmItemI[4] = new Double(act[i]);
							pmItemI[5] = new Double(acc[i]);
							pmItemI[6] = new Double(avg[i]);

							dbobject.executePreparedUpdate(sbItemI.toString(),pmItemI);
						}

						if (itemType[i].equals("누적")){
							cal[i]=new Double(acc[i]);
						} else if (itemType[i].equals("평균")){
							cal[i]=new Double(avg[i]);
						} else {
							cal[i]=new Double(act[i]);
						}
						map.put(code[i],cal[i]);
					}

					String strEqu = "SELECT EQUATION,WEIGHT,TREND,FREQUENCY,SCORECODE SCODE,PLANNED,PLANNEDBASEPLUS, PLANNEDBASE,BASEPLUS,BASE,     BASELIMITPLUS,BASELIMIT,LIMITPLUS,LIMIT FROM TBLMEASUREDEFINE WHERE ID=?";
					Object[] pmEqu = {new Integer(meaid[j])};

					if (rs!=null){rs.close(); rs=null;}

					/*점수 계산 기준 */
					int upper     = 100;
					int highplus  = 95;
					int high      = 90;
					int lowplus   = 85;
					int low       = 80;
					int lowerplus = 75;
					int lower     = 70;
					int lowstplus = 65;
					int lowst     = 60;

					/*기준 등급 지표별 다름 */
					double PLANNED          = 100;
					double PLANNEDBASEPLUS  = 95;
					double PLANNEDBASE      = 90;
					double BASEPLUS         = 85;
					double BASE             = 80;
					double BASELIMITPLUS    = 75;
					double BASELIMIT        = 70;
					double LIMITPLUS        = 65;
					double LIMIT            = 65;  // limitplus와 같게...

					rs = dbobject.executePreparedQuery(strEqu,pmEqu);
					String equ = "";
					String weight = null;
					String trend = null;
					String frequency = null;
					while(rs.next()){
						equ = rs.getString("EQUATION");
						weight = rs.getString("WEIGHT");
						trend = rs.getString("TREND");
						frequency = rs.getString("FREQUENCY");

						PLANNED          = rs.getDouble("PLANNED");
						PLANNEDBASEPLUS  = rs.getDouble("PLANNEDBASEPLUS");
						PLANNEDBASE      = rs.getDouble("PLANNEDBASE");
						BASEPLUS         = rs.getDouble("BASEPLUS");
						BASE             = rs.getDouble("BASE");
						BASELIMITPLUS    = rs.getDouble("BASELIMITPLUS");
						BASELIMIT        = rs.getDouble("BASELIMIT");
						LIMITPLUS        = rs.getDouble("LIMITPLUS");
						LIMIT            = rs.getDouble("LIMIT");
					}

					ExpressionParser exParser = new ExpressionParser(equ);
					Expression expression = exParser.getCompleteExpression();

					Vector vector = new Vector();
					expression.addUnknowns(vector);
					int k = vector.size();
					Hashtable table = new Hashtable();
					for (int l = 0; l < k ; l++) {
						String icd = (String)vector.get(l);
						Object obj = map.get(icd);
						table.put(icd,obj);
					}

					Double actual = (Double)expression.evaluate(table);

					MeasureDetail measuredetail = actualutil.getMeasureDetail (dbobject,String.valueOf(meaid[j]),strdate);
					/*int upper = ServerStatic.UPPER;
					int high = ServerStatic.HIGH;
					int low = ServerStatic.LOW;
					int lower = ServerStatic.LOWER;
					int lowst = ServerStatic.LOWST;*/

					measuredetail.actual = actual.doubleValue();
					measuredetail.strDate = Util.getLastMonth(strdate);
					measuredetail.weight = new Float(weight).floatValue();
					measuredetail.measureId = new Integer(meaid[j]).intValue();
					measuredetail.trend = (trend==null)?"상향":trend;
					measuredetail.frequency = frequency;
					measuredetail.updater = userId;

					measuredetail.planned         = PLANNED;
					measuredetail.plannedbaseplus = PLANNEDBASEPLUS;
					measuredetail.plannedbase     = PLANNEDBASE;
					measuredetail.baseplus        = BASEPLUS;
					measuredetail.base            = BASE;
					measuredetail.baselimitplus   = BASELIMITPLUS;
					measuredetail.baselimit       = BASELIMIT;
					measuredetail.limitplus       = LIMITPLUS;
					measuredetail.limit           = LIMIT;


					measuredetail.upper     = upper;
					measuredetail.highplus  = highplus;
					measuredetail.high      = high;
					measuredetail.lowplus   = lowplus;
					measuredetail.low       = low;
					measuredetail.lowerplus = lowerplus;
					measuredetail.lower     = lower;
					measuredetail.lowstplus = lowstplus;
					measuredetail.lowst     = lowst;


					actualutil.updateMeasureDetail(dbobject,measuredetail);
				}
			}
		} catch (Exception e){
			System.out.println(e);
			throw new SQLException("Import err:"+e);
		} finally {
			if (rs != null) {rs.close(); rs=null;}
			if (pstat != null) pstat.close();
			if (pstat2 != null) pstat2.close();
			if (pstat3 != null) pstat3.close();
		}
	}
}
