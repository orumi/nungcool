/*
 * Created on 2005. 3. 15
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.nc.admin;

import java.io.*;
import java.util.*;


/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class QueryReader {
    public QueryReader() {
    }

    static public ArrayList load(File file) throws IOException {
        return load(((Reader) (new FileReader(file))));
    }
	static public ArrayList load(String s)
		throws IOException{
		return load(((Reader)(new FileReader(s))));
	}

	static public ArrayList load(Reader reader)
		throws IOException{
		BufferedReader bufferedReader = new BufferedReader(reader);
		Table table = null;
		String s = null;
		StringBuffer stringBuffer = null;
		HashMap hashMap = new HashMap();
		boolean flag = true;
		ArrayList arrayList = new ArrayList();
		try{
			do {
				String s1 = bufferedReader.readLine();
				if(s1 != null){
					s1 = s1.trim();
					if(s1.length()!=0 && s1.charAt(0)!='#')
						if(flag){
							StringTokenizer stringTokenizer = new StringTokenizer(s1);
							String s2 = stringTokenizer.nextToken().toUpperCase();
							String s4 = stringTokenizer.nextToken();
							
							if(s2.equals("TABLE")){
								table = null;
								s = null;
								table = new Table(s4,"TABLE");
								stringBuffer = new StringBuffer();
							    stringBuffer.append("CREATE TABLE "+s4);
							} else if(s2.equals("VIEW")){
								table = null;
								s=null;
								table = new Table(s4,"VIEW");
								stringBuffer = new StringBuffer();
								stringBuffer.append("CREATE VIEW "+s4);
							} else if(s2.equals("SEQUENCE")){
								stringBuffer = new StringBuffer();
								stringBuffer.append("CREATE SEQUENCE "+s4);
							} else if(s2.equals("TRIGGER")){
								stringBuffer = new StringBuffer();
								stringBuffer.append("CREATE OR REPLACE TRIGGER "+s4+" \n ");
							} else if((s2.equals("INDEX")) || (s2.equals("UNIQUE"))){
								stringBuffer = new StringBuffer();
								if (s2.equals("UNIQUE")) stringBuffer.append("CREATE UNIQUE  INDEX "+s4);
								else stringBuffer.append("CREATE INDEX "+s4);
							} else if(s2.equals("ALTER")){
								stringBuffer = new StringBuffer();
								stringBuffer.append("ALTER TABLE "+s4);
							} else {
								throw new Exception("Create Table is no");
							}
						
							flag = false;
						} else if(table != null){
							StringTokenizer stringTokenizer1 = new StringTokenizer(s1,",");
							String s3 = stringTokenizer1.nextToken().trim();
							if(s3.equals("GO")){
								table.createSQL = stringBuffer.toString();
								arrayList.add(table);
								flag = true;
							} else if (s3.equals("ENDSEQUENCE")){
								table.sequenceSQL = stringBuffer.toString();
								flag = true;
							} else if (s3.equals("ENDTRIGGER")){
								//stringBuffer.append(" END ");
								table.triggerSQL = stringBuffer.toString();
								flag = true;
							} else if (s3.equals("ENDINDEX")){
								table.indexSQL = stringBuffer.toString();
								flag = true;
							} else if (s3.equals("ENDALTER")){
								table.alterSQL = stringBuffer.toString();
								flag = true;
							} else {
								stringBuffer.append(" "+s1+" \n");
							}
						}
				} else {
					return arrayList;
				}
			}while(true);
		} catch (Exception e) {
			System.out.println(table.name+ " script : " + stringBuffer.toString());
		}
		return null;
	}





































}
