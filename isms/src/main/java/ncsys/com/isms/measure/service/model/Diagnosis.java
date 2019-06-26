package ncsys.com.isms.measure.service.model;

import java.util.ArrayList;


public class Diagnosis {
	
	private String dgsid; 
	private String piversionid; 
	private String year;
	private String begindt;
	private String enddt;
	private String dgsname;
	private String sortby;
	private String userId;
	
	private String actionmode;

	public String getDgsid() {
		return dgsid;
	}

	public void setDgsid(String dgsid) {
		this.dgsid = dgsid;
	}

	public String getPiversionid() {
		return piversionid;
	}

	public void setPiversionid(String piversionid) {
		this.piversionid = piversionid;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getBegindt() {
		return begindt;
	}

	public void setBegindt(String begindt) {
		this.begindt = begindt;
	}

	public String getEnddt() {
		return enddt;
	}

	public void setEnddt(String enddt) {
		this.enddt = enddt;
	}

	public String getDgsname() {
		return dgsname;
	}

	public void setDgsname(String dgsname) {
		this.dgsname = dgsname;
	}

	public String getSortby() {
		return sortby;
	}

	public void setSortby(String sortby) {
		this.sortby = sortby;
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
