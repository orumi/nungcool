package com.nc.admin;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
import java.util.ArrayList;

public class Table {
	public String kind;
	public String name;
	public String createSQL;
	public String sequenceSQL;
	public String alterSQL;
	public String indexSQL;
	public String triggerSQL;
	
	public Table(String name){
		this(name, null);
	}
	
	public Table(String name, String kind){
		this.name = name;
		this.kind = kind;
	}
	
	public String getName(){
		return name;
	}
	
	public String toString(){
		return name;
	}
}
