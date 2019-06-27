package tems.com.system.model;

public class AuthorGrpVO {

	private String regid;
	private String regdate;
	private String authorgpnm;
	private String authorgpcode;
	private String state;
	private String orderby;
	
	public void setRegid(String regid) {
		this.regid = regid; 
	}
	public String getRegid() {
		return regid; 
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate; 
	}
	public String getRegdate() {
		return regdate; 
	}
	public void setAuthorgpnm(String authorgpnm) {
		this.authorgpnm = authorgpnm; 
	}
	public String getAuthorgpnm() {
		return authorgpnm; 
	}
	public void setAuthorgpcode(String authorgpcode) {
		this.authorgpcode = authorgpcode; 
	}
	public String getAuthorgpcode() {
		return authorgpcode; 
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getOrderby() {
		return orderby;
	}
	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}
	

}
