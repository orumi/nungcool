package com.nc.etl;

import java.util.ArrayList;

public class SqlEntity {
	public String etlkey;
	public String itemcode;
	public String sql;
	public String remk;
	public String useyn;
	public String mname;
	public String iname;
	public String frequency;
	public String paramremk;
	public String dname;
	public String connection;
	public int inFRQ;
	
	public ArrayList params;
	public ArrayList rundate;
	
	public SqlEntity(){
		params = new ArrayList();
		rundate = new ArrayList();
	}
}
