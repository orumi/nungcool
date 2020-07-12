package com.nc.util;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.Date;
import java.util.Calendar;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.io.IOException;

public class DataSet { 
	private HashMap columnName; // 0 based
	private ArrayList rowData; // 0 based
	private ArrayList columnData; // �ߺ� �Ǵ� data ---> column data type & column name
	private int columns; // �÷���
	private int rows; // �ο��
	private int mCursor; // ���� ����Ű�� �ִ� �ο�
	private Object[] currentRowData; //���� �ο� ���尪 
	
	// ���� �ִ� �� ��
	private NumberFormat numberFormat;
	private DateFormat dateFormat;
	
	public DataSet() { // ������
		columns = 0;
		rows = 0;
		mCursor = 1;
		currentRowData = null;
	}
	
	public DataSet(ResultSet rs) { // ������
		columns = 0;
		rows = 0;
		mCursor = 1;
		currentRowData = null;
		try { 
			load(rs);
		} catch (SQLException se) {
			
		}
	}
	
	public void load(ResultSet rs) throws SQLException { // �ʱ� �ε� ---> ����Ʈ�¿� �ִ� ������ �����ͼ����� ����
		reset();
		
		ResultSetMetaData rsmd = rs.getMetaData(); // 1 based
		columns = rsmd.getColumnCount();
        
		rowData = new ArrayList();
        
		setColumnInfo(rsmd);
        
        while(rs.next()) {
        	Object[] temp = new Object[columns]; // �÷��� ��ŭ ������Ʈ�迭 ����
			for(int i=1;i<=columns;i++) {
				temp[i-1] = rs.getObject(i);
			}
			rowData.add(temp); // �ο� �ϳ� �߰�
			rows++;
			//System.out.println(rs.getString("MNAME"));
		}
//        currentRowData = (Object[])rowData.get(0); // next() ���� �ʱ�ȭ ������ ---> test�� �� ���
	}
	
	private void setColumnInfo(ResultSetMetaData rsmd) { // rsmd ---> 1 based ---> �÷��� �÷�Ÿ�� ����
		try {
			columnName = new HashMap();
			columnData = new ArrayList(); // �÷������� ��� ���� ��̸���Ʈ ���� ---> ��� ����
			String[] temp = new String[columns];
			String[] temp1 = new String[columns];
			for(int i=0;i<columns;i++) {
				try {
					columnName.put(rsmd.getColumnName(i+1).toUpperCase(), new Integer(i+1));
					temp[i] = rsmd.getColumnTypeName(i+1);
					temp1[i] = rsmd.getColumnName(i+1);
				} catch (Exception e) {
					System.out.println(e);
				} finally {
									
				}
			}
			columnData.add(temp); // �÷�Ÿ��
			columnData.add(temp1); // �÷���
		} catch (Exception e) {
			
		} finally {
			
		}
	}

	
	public boolean next() {
		boolean flag = mCursor <= rows;
		if(flag) setRow(mCursor++);
//		if(flag) mCursor++;
		return flag;
	}
	
	public int getColumnCount() {
		return columns;
	}

	public int getRowCount() {
		return rows;
	}
	
	public void setRow(int i) {
		currentRowData = (Object[])rowData.get(i-1);
	}
	
	public int getColumnIndex(String s) {
		try{
			String tempString = columnName.get(s.toUpperCase()).toString();
			int tempInt = Integer.parseInt(tempString);
			return tempInt >= 1 ? tempInt : -1; 
		} catch (Exception e) {
			System.out.print(s+" err: "+e);
			return -1;
		}
	}

	public Object getColumnTypeName(int i) {
		Object[] temp = (Object[])columnData.get(0);
		return temp[i-1];
	}
	
	public Object getColumnName(int i) {
		Object[] temp = (Object[])columnData.get(1);
		return temp[i-1];
	}

	public void resetCursor() {
		mCursor = 1;
		currentRowData = null;
	}
	
	private void reset() {
		resetCursor();
		columnName = null; // 0 based
		rowData = null; // 0 based
		columnData = null; // �ߺ� �Ǵ� data ---> column data type & column name
		columns = 0; // �÷���
		rows = 0; // �ο��		
	}

	public int getCursor() {
		return mCursor;
	}
	
	public Object getObject(String s) {
		int i = getColumnIndex(s);
		if(i == -1) return null;
		else return getObject(i);
	}

//	public Object getObject(String s, String s1) {
//		int i = getColumnIndex(s);
//		return (i >= 0) ? currentRowData[i-1] : (Object)s1;
//	}

//	public Object getObject(int i) {
//		return (i >= 0) ? currentRowData[i-1] : "";
//	}
	
	public Object getObject(int i) {
		Object temp = currentRowData[i-1];
		return (i >= 0) ? ((temp != null) ? temp : "") : "";
	}
	
	public boolean isNumber(int i){
		if("null".equals(currentRowData[i-1])){
			return false;
		} else {
		    return true;
		}
	}
	
	public String getString(String s) {
		try{
			int i = getColumnIndex(s);
			if(i == -1) return null;
			else return getString(i);
		} catch (Exception e){
			return "";
		}
	}
	
	public String getString(int i) throws Exception{
		try{
			return (i >= 0) ? currentRowData[i-1].toString() : "";
		} catch (Exception e){
			return "";
		}
	}
	
	public int getInt(String s){
		try {
		int i = getColumnIndex(s);
		if(i == -1) return -1;
		else return getInt(i);
		} catch (Exception e) {
			return 0;
		}
	}
	
	public int getInt(int i){
		return Integer.parseInt(getObject(i).toString());
	}
	
	public long getLong(String s){
		int i = getColumnIndex(s);
		if(i == -1) return -1;
		else return getLong(i);
	}
	
	public long getLong(int i){
		return Long.parseLong(getObject(i).toString());
	}
	
	public double getDouble(String s){
		int i = getColumnIndex(s);
		if(i == -1) return -1;
		else return getDouble(i);
	}
	
	public double getDouble(int i){
		return Double.parseDouble(getObject(i).toString());
	}
	
//	 ���⼭���� ���� �ִ� �κ�	
	
	public NumberFormat getNumberFormat() {
		return numberFormat;
	}

	public Number getNumber(String s) {
		try{
			int i = getColumnIndex(s);
			if(i == -1) return null;
			else return getNumber(i);
		} catch (Exception e){
			System.out.println(e);
			return null;
		}
		
	}

	public Number getNumber(int i) {
		try {
			Object temp = currentRowData[i-1];
			if(temp == null || ((String)temp).length() == 0) return null;
			else return numberFormat.parse((String)temp);
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
		
	}

	public void setDateFormat(DateFormat dateformat) {
		this.dateFormat = dateformat;		
	}

	public String getDate(String s) {
		int i = getColumnIndex(s);
		if(i == -1) return null;
		else return getDate(i);
	}

	public String getDate(int i) {
		
		dateFormat = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");

		if(dateFormat != null){
			try {
				Object temp = currentRowData[i-1];
				if(temp == null || (temp.toString()).length() == 0) return null;
				else return dateFormat.format(getDateFormSource(i));
			} catch (Exception e) {
				System.out.println(e);
			}
			return null;
		} else throw new RuntimeException("CSVImport getDate error");
	}
	
	private Date getDateFormSource(int i){
		Date date = null;
		
		try {			
			Object temp = currentRowData[i-1];
			if(temp == null || (temp.toString()).length() == 0) return null;
			int year;
			int month;
			int day;
			int hour;
			int minute;
			int second;
			year = Integer.parseInt(temp.toString().substring(0,4));
			month = Integer.parseInt(temp.toString().substring(4,6));
			day = Integer.parseInt(temp.toString().substring(6,8));
			hour = Integer.parseInt(temp.toString().substring(8,10));
			minute = Integer.parseInt(temp.toString().substring(10,12));
			second = Integer.parseInt(temp.toString().substring(12,14));
			Calendar calender = Calendar.getInstance();
			calender.set(year,month,day,hour,minute,second);
			
			
			return calender.getTime();
		} catch (Exception e) {
			System.out.println(e);
		}
		return date;
	}
	
	public boolean isEmpty(String s){
		int i = getColumnIndex(s);
		if (i==-1) return false;
		return isEmpty(i);
	}
	
	public boolean isEmpty(int i){
		if (currentRowData[i-1]==null) return true;
		else return false;
	}
	
	public String toString(){ // toString() overriding
		resetCursor();
		StringBuffer sb = new StringBuffer();
		sb.append("<br>\r\n");
		
		for (int i=1;i<=columns;i++)  
			sb.append("/"+getColumnName(i));
		sb.append("<br>\r\n");
		while(next()) {
			for(int j=1;j<=columns;j++)
				sb.append(getObject(j) + " ");
			sb.append(" <br>\r\n");
		}
		sb.append("column count = " + getColumnCount());
		sb.append(" <br>\r\n");
		sb.append("row count = " + getRowCount());
		sb.append(" <br>\r\n");
		resetCursor();
		return sb.toString(); 
	}
}