package com.nc.totEval;

import java.util.HashMap;

public class EstMeasure {
	public String section;
	public String name;
	public int id;
	public double allot;
	public String bscDivision;
	public String factor;
	
	public HashMap details;
	
	public EstMeasure() {
		details = new HashMap();
	}
	
	public void setDetails(Division div,EstDetail det) {
		details.put(div,det);
	}
	
	public EstDetail getDetails(Division div) {
		return (EstDetail)details.get(div);
	}
	
	public void setScore(EstCompany com, EstScore scr){
		details.put(com,scr);
	}
	
	public EstScore getEstScore(EstCompany com){
		return (EstScore)details.get(com);
	}
}
