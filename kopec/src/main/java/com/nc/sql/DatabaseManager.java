package com.nc.sql;

import java.io.File;
import java.util.*;

import com.nc.util.ServerUtil;

public class DatabaseManager {
	public static final String DBASE_HOME = "dbconf";
	String directoryFile;
	HashMap dbMap;
	HashMap query;
	//ArrayList tableList; 
	static DatabaseManager manager;

	private DatabaseManager(String s){
		directoryFile = s;
	}

	public void load(){
		if(dbMap == null){
			dbMap = new HashMap();
			if (query == null) query = new HashMap();  /// query selector instance
			Properties properties = ServerUtil.getProperties(directoryFile);
			int i = 0;
			do{
				String s = "db["+i+"].";
				String s1 = properties.getProperty(s+"name");
				if(s1 == null) break;
				String s2 = properties.getProperty(s+"file");
				s2 = "dbconf"+File.separator+s2;
				String s3 = properties.getProperty(s+"table");
				s3 = "dbconf"+File.separator+s3;

				String s4 = properties.getProperty(s+"vendor");
				i++;
			} while(true);

		}
	}

	public void unload(){
		//tableList = null;
		dbMap = null;
	}

	public void reload(){
		unload();
		load();
	}

	public Iterator getDatabaseNames(){
		return dbMap.keySet().iterator();
	}

	public static DatabaseManager getDatabaseManager(){
		if(manager == null)
			manager = new DatabaseManager("dbconf"+File.separator+"db.properties");
		return manager;
	}

































}
