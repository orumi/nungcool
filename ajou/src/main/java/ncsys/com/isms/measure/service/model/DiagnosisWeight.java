package ncsys.com.isms.measure.service.model;

import java.util.ArrayList;


public class DiagnosisWeight {
	
	private String dgsid; 
	private String year;
	private String userId;
	
	private String actionmode;

	private ArrayList<Weight> wgts = new ArrayList<Weight>();


	public ArrayList<Weight> getWgts() {
		return wgts;
	}

	public void setWgts(ArrayList<Weight> wgts) {
		this.wgts = wgts;
	}

	public String getDgsid() {
		return dgsid;
	}

	public void setDgsid(String dgsid) {
		this.dgsid = dgsid;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}


	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getActionmode() {
		return actionmode;
	}

	public void setActionmode(String actionmode) {
		this.actionmode = actionmode;
	}
	
	
	
	
}
