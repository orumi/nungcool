package com.nc.admin;

import java.util.ArrayList;

public class MessageSet {
	public ArrayList set;
	
	public MessageSet(){
		set = new ArrayList(); 
	}
	
	public Object getObject(int i){
		return (Object)set.get(i);
	}
	
	public void setObject(Object obj){
		this.set.add(obj);
	}
	
	public int getCount(){
		return set.size();
	}
	
	public int getFieldCount(int i){
		return ((IMessage)set.get(i)).getFieldCount();
	}
	
	public void clearObject(){
		set.clear();
		set = null;
	}
	
	public void clear(){
		for(int i =0 ; i<set.size();i++){
			IMessage temp = (IMessage)set.get(i);
			temp.clear();
		}
		set.clear();
		set = null;
	}

}
