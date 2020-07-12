package com.nc.cool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.StringTokenizer;
import java.util.Vector;

import com.nc.math.*;
import com.nc.util.DBObject;
import com.nc.util.Importer;
import com.nc.util.Util;

public class ItemUtil extends DBObject{

	public ItemUtil(Connection connection) {
		super(connection);
	}

	public ItemUtil(DBObject dbobject){
		this(dbobject.getConnection());
	}
	
	public void importItemList(Importer dataimporter, HashMap rtnMap) {
		/*  처리과정 
		 * 1. Import 필드 유효성 검사
		 * 2. 반복 
		 * 		2.1 ETL KEY 유효성 검사 (적절한 지표가 있는지?)
		 * 		2.2 항목코드가 적절한지 (기존 항목에 코드 유/무)
		 * 		2.3 항목저장 및 산식 저장.
		 * 3. 처리 결과 리턴. 
		 */
		
		String[] fields = new String[] {"etlkey","itemcode","itemname","itemequation"};
		
		String[] fullFields = new String[] {"etlkey","itemcode","itemname","itemequation"};
		
		// 필드 유효성 검사
		
		for (int i1=0; i1<fields.length;i1++){
			if ((dataimporter.getColumnIndex(fields[i1])) < 0 ) {
				rtnMap.put("error"," FIELD REQUIRED : "+fields[i1]);
				return;
			}
		}
		
		try {
			for (dataimporter.resetCursor();dataimporter.next();){
				try {
					setItem(dataimporter, fullFields);   /// with on line update for row count;;;
				} catch (Exception e){
					rtnMap.put("error","Failed at row "+dataimporter.getCursor());
					System.out.println("Inserting fail "+dataimporter.getCursor()+"\n"+e); 
					return;
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			rtnMap.put("error", "FAILED INSERT HIERARCHY");
		} finally {
			rtnMap.put("count", String.valueOf(dataimporter.getRowCount()));
		}
		
	}
	
	private void setItem(Importer importer, String[] fullFields) throws SQLException{
		PreparedStatement pstat = null;
		PreparedStatement pstat2 = null;
		PreparedStatement pstat3 = null;
		try{
			int meaid = getMeasure(importer.getString(fullFields[0]),"tblMeasureDefine");
			String sql = "update tblMeasureItem set itemName=? where measureId=? and itemcode=?";
			Connection con = getConnection();
			pstat = con.prepareStatement(sql);
			pstat.setString(1,importer.getString(fullFields[2]));     // the name of item;
			pstat.setInt(2,meaid);
			pstat.setString(3,importer.getString(fullFields[1]));
			if (pstat.executeUpdate()<1){
				String s2 = "insert into tblMeasureItem (measureId, itemCode, itemName, inputdate) values (?,?,?,?)";
				pstat2 = con.prepareStatement(s2);
				pstat2.setInt(1,meaid);
				pstat2.setString(2,importer.getString(fullFields[1]));
				pstat2.setString(3,importer.getString(fullFields[2]));
				pstat2.setString(4,Util.getToDay());
				pstat2.executeUpdate();
			}
			String s3 = "update tblMeasureDefine set equation=? where etlKey=?";
			pstat3 = con.prepareStatement(s3);
			pstat3.setString(1,importer.getString(fullFields[3]));
			pstat3.setString(2, importer.getString(fullFields[0]));
			pstat3.executeUpdate();
		} finally {
			if (pstat != null) pstat.close();
			if (pstat2 != null) pstat2.close();
			if (pstat3 != null) pstat3.close();
		}
	}
	
	private int getMeasure(String key, String table) throws SQLException{
		ResultSet rs = executeQuery("SELECT id FROM "+table+" WHERE etlKey='"+key+"'");
		if (rs.next()) return rs.getInt(1);
		return -1;
	}

	public void importItemActual(Importer dataimporter, HashMap rtnMap) {
		String[] fields = new String[] {"etlkey","effectiveDate","itemCode","itemValue"};
		
		String[] fullFields = new String[] {"etlkey","effectiveDate","worst","best","planned","itemCode","itemvalue"};
		
		// 필드 유효성 검사
		
		for (int i1=0; i1<fields.length;i1++){
			if ((dataimporter.getColumnIndex(fields[i1])) < 0 ) {
				rtnMap.put("error"," FIELD REQUIRED : "+fields[i1]);
				return;
			}
		}
		/*
		ExpressionUtil expressionutil = null;
		try {
			 expressionutil = new ExpressionUtil(this);
			for (dataimporter.resetCursor();dataimporter.next();){
				try {
					setItemActual(expressionutil, dataimporter, fullFields);   /// with on line update for row count;;;
				} catch (Exception e){
					rtnMap.put("error","Failed at row "+dataimporter.getCursor());
					System.out.println("Inserting fail "+dataimporter.getCursor()+"\n"+e); 
					return;
				}
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			rtnMap.put("error", "FAILED INSERT HIERARCHY");
		} finally {
			if (expressionutil != null) expressionutil.close();
			rtnMap.put("count", String.valueOf(dataimporter.getRowCount()-1));
		}	
		*/	
	}

	private void setItemActual(Importer importer, String[] fullFields) throws SQLException{
		PreparedStatement pstat = null;
		PreparedStatement pstat2 = null;
		PreparedStatement pstat3 = null;
		
		try{
			int meaid = getMeasure(importer.getString(fullFields[0]),"tblMeasureDefine");
			String equation = getExpression(meaid);
			//Expression expr = expressionutil.getExpression(equation);

			Vector vector = new Vector();
			//expr.addUnknowns(vector);
			 
			StringTokenizer st = new StringTokenizer(importer.getString(fullFields[5]),"|");
			
			String[] itemCode = new String[st.countTokens()];
			for (int i = 0; i < itemCode.length; i++) {
				itemCode[i]=st.nextToken();
			}
			
			StringTokenizer st1 = new StringTokenizer(importer.getString(fullFields[6]),"|");
			
			String[] value = new String[st1.countTokens()];
			for (int i = 0; i < value.length; i++) {
				value[i] = st1.nextToken();
			}
			
			Hashtable hashtable = new Hashtable();
			
			Connection con = getConnection();
			String sql = "update tblactualitem set actual=? where defineid=? and itemcode=? and effectivedate=?";
			pstat = con.prepareStatement(sql);
			
			String s2 = "insert into tblactualitem (defineid,itemcode,actual,effectivedate,inputdate) values (?,?,?,?,?)";
			pstat2 = con.prepareStatement(s2);
			
			String date = importer.getString(fullFields[1])+"00000000";

			for (int i = 0; i < value.length; i++) {
				hashtable.put(itemCode[i],new Double(value[i]));
				pstat.clearParameters();				
				pstat.setDouble(1, new Double(value[i]).doubleValue());
				pstat.setInt(2,meaid);     // itemCode;
				pstat.setString(3,itemCode[i]);
				pstat.setString(4,date);
				if (pstat.executeUpdate()<1){
					pstat2.setInt(1,meaid);
					pstat2.setString(2,itemCode[i]);
					pstat2.setString(3,value[i]);
					pstat2.setString(4,date);
					pstat2.setString(5,Util.getToDay());
					pstat2.executeUpdate();
				}
			}
			
			//Double actual = (Double)expr.evaluate(hashtable);
			
			/*
			//MeasureDetail md = new MeasureDetail();
			md.measureId = meaid;
			md.strDate = date;
			md.weight = getWeight(meaid);
			md.actual = actual;
			md.best = ("".equals(importer.getString(fullFields[3])))?null:new Double(importer.getString(fullFields[3]));
			md.worst = ("".equals(importer.getString(fullFields[2])))?null:new Double(importer.getString(fullFields[2])); 
			md.planned = ("".equals(importer.getString(fullFields[4])))?null:new Double(importer.getString(fullFields[4]));
			
			ScorecardUtil.updateDetailedMeasure(this,md,false);
			
			HashMap hashmap = new HashMap();
			hashmap.put((new Integer(meaid)),(new Date[]{Util.getDate(date)}));
			expressionutil.updateMeasuresWithDates(hashmap);
			*/
		} catch (Exception e){
			System.out.println(e);
			throw new SQLException(""+e);
		} finally {
			if (pstat != null) pstat.close();
			if (pstat2 != null) pstat2.close();
			if (pstat3 != null) pstat3.close();
		}
	}

	private String getExpression(int meaid) throws SQLException{
		ResultSet rs = executeQuery("SELECT equation FROM tblmeasureDefine WHERE id='"+meaid+"'");
		if (rs.next()) return rs.getString(1);
		return null;
	}
	
	private Float getWeight(int id) throws SQLException{
		ResultSet rs = executeQuery("SELECT weight FROM tblmeasureDefine WHERE id='"+id+"'");
		if (rs.next()) return new Float(rs.getFloat(1));
		return null;
	}
}
