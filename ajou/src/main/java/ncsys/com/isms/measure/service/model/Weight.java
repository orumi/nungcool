package ncsys.com.isms.measure.service.model;

import java.util.HashMap;


public class Weight {
	private String msrdtlid;
	private String weight;
	private String dgsid;
	
	
	
	public String getMsrdtlid(){
		return this.msrdtlid; 
	}
	public void setMsrdtlid(String msrdtlid){
		this.msrdtlid = msrdtlid;
	}
	
	public String getWeight(){
		return this.weight;
	}
	public void setWeight(String weight){
		this.weight = weight;
	}
	public String getDgsid() {
		return dgsid;
	}
	public void setDgsid(String dgsid) {
		this.dgsid = dgsid;
	}
	
	
	
	
}
