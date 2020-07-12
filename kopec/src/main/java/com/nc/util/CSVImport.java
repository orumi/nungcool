package com.nc.util;

import java.io.*;
import java.text.*;
import java.util.*;

public class CSVImport implements Importer{
	char QUOTE_CHAR;
	char CELL_DIV_CHAR;
	boolean caseSensitiveFields;
	boolean trimValues;
	String filename;
	int columns;
	int rows;
	ArrayList rowData;
	int cursor;
	String currentRow[];
	HashMap map;
	NumberFormat numberFormat;
	DateFormat dateFormat;
	
	public CSVImport(){
		QUOTE_CHAR = '"';
		CELL_DIV_CHAR =',';
		caseSensitiveFields = false;
		trimValues = true;
	}

	public void setProperties(Properties properties) {
		// TODO Auto-generated method stub
		
	}

	public void setSource(String s) {
		filename = s;
		
	}

	public void load() throws IOException {
		BufferedReader bufferedreader = null;
		rows =0;
		String s = null;
		try {
			bufferedreader = new BufferedReader(new FileReader(filename));
			rowData = new ArrayList();
			map = new HashMap();
			while(addRowData(bufferedreader));
		} catch (RuntimeException e) {
			throw e;
		} finally {
			if(bufferedreader != null) bufferedreader.close();
		}
		
	}
	
	protected boolean addRowData(BufferedReader bufferedreader)
	throws IOException {
		String s = bufferedreader.readLine(); 
		if (s== null) return false;
		int i = s.length();
		int j = 0;
		ArrayList arraylist = null;
		String as[] = null;
		boolean flag1= rows != 0;
		if(flag1) as = new String[columns];
		else arraylist = new ArrayList();
		
		for (int k=0; j<i; k++){
			if(flag1 && k>= columns) break;
			char c = s.charAt(j++);
			if(c == CELL_DIV_CHAR){
				if (flag1) as[k] = "";
				else arraylist.add("");
			} else {
				StringBuffer stringbuffer = new StringBuffer();
				boolean flag;
				if(!(flag = c == QUOTE_CHAR))
					stringbuffer.append(c);
				while(flag || j<i){
					char c1 = s.charAt(j++);
					if(!flag && c1 == CELL_DIV_CHAR || c1 == QUOTE_CHAR && (j == i || s.charAt(j++) != QUOTE_CHAR))
						break;
					stringbuffer.append(c1);
					if(flag && j==i)
						do {
							s = bufferedreader.readLine();
							if(s == null) System.out.println("CSVImport error Quote was not terminated ");
							i = s.length();
							j=0;
							stringbuffer.append('\n');
						} while (i==0);
				}
				
				String s1 = stringbuffer.toString();
				if(trimValues) s1 = s1.trim();
				if(flag1) as[k] = s1;
				else arraylist.add(s1);
			}
		}
		
		if(!flag1){
			columns = arraylist.size();
			as = new String[columns];
			for(int l=0;l<columns;l++){
				String s2 = (String)arraylist.get(l);
				if(s2 == null) s2="";
				else if (!caseSensitiveFields) s2= s2.toUpperCase();
				map.put(s2, new Integer(l));
				as[l] = s2;
			}
		}
		
		rowData.add(as);
		rows++;
		
		System.out.println(rowData.size());
		return true;
	}

	public int getColumnCount() {
		return columns;
	}

	public int getRowCount() {
		return rows;
	}

	public String[] getRow(int i) {
		return (String[])rowData.get(i);
	}

	public int getColumnIndex(String s) {
		Integer integer = (Integer)map.get(s.toUpperCase());
		return integer != null ? integer.intValue() : -1; 
	}

	public String getColumnName(int i) {
		return ((String[])rowData.get(0))[i];
	}

	public String getSourceName() {
		return filename;
	}

	public void resetCursor() {
		cursor = 1;
		currentRow = null;
	}

	public int getCursor() {
		return cursor;
	}

	public boolean next() {
		boolean flag = cursor < rows;
		currentRow = flag ? getRow(cursor++) : null;
		return flag;
	}

	public String getString(String s) {
		int i = getColumnIndex(s);
		if(i==-1) return null;
		else return getString(i);
	}

	public String getString(String s, String s1) {
		int i = getColumnIndex(s);
		return i>= 0 ? currentRow[i]: s1;
	}

	public String getString(int i) {
		//return i>=0 ? Util.getEUCKR(currentRow[i]):null;  // server tomcat
		return i>=0 ? currentRow[i]:null;
	}

	public NumberFormat getNumberFormat() {
		return numberFormat;
	}

	public Number getNumber(String s) {
		int i = getColumnIndex(s);
		if (i == -1) return null;
		else return getNumber(i);
	}

	public Number getNumber(int i) {
		try {
			String s = currentRow[i];
			if (s == null || s.length() ==0) return null;
			else return numberFormat.parse(s);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	public void setDateFormat(DateFormat dateformat) {
		this.dateFormat = dateformat;		
	}

	public Date getDate(String s) {
		int i = getColumnIndex(s);
		if (i==-1) return null;
		else return getDate(i);
	}

	public Date getDate(int i) {
		if(dateFormat != null){
			try {
				String s = currentRow[i];
				if(s==null|| s.length() == 0) return null;
				else return dateFormat.parse(s);
			} catch (Exception e) {
				// TODO: handle exception
			}
			return null;
		} else throw new RuntimeException("CSVImport getDate error");
	}

}
