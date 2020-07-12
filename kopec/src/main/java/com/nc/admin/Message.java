package com.nc.admin;

import java.util.ArrayList;

public class Message implements IMessage{
	public String tblName;
	public String message;
	public String error;
	public String define;
	public ArrayList node; 
	
	public Message(){
		node = new ArrayList();
	}
	
	public void addNode(String fieldName, String status, String recom){
		Node temp = new Node();
		temp.fieldName = fieldName;
		temp.status = status;
		temp.recom = recom;
		node.add(temp);
	}
	
	public Node getNode(int i){
		return (Node)node.get(i);
	}
	
	public String getNodeFieldName(int i){
		return ((Node)node.get(i)).fieldName;
	}
	
	public String getStatus(int i){
		return ((Node)node.get(i)).status;
	}
	
	public String getInfo(int i){
		return ((Node)node.get(i)).info;
	}
	
	public String getRecom(int i){
		return ((Node)node.get(i)).recom;
	}

	public void clear() {
		node.clear();
		node = null;
	}

	public int getFieldCount() {
		return node.size();
	}

}

class Node{
	public String fieldName;
	public String status;
	public String info;
	public String recom;
}