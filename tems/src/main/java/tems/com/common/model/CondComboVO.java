package tems.com.common.model;

public class CondComboVO {

	private String condid;
	private String itemid;
	private String testcond;
	private String smpid;
	private String reqid;
	private String adminid;
	public void setCondid(String condid) {
		this.condid = condid; 
	}
	public String getCondid() {
		return condid; 
	}
	public void setItemid(String itemid) {
		this.itemid = itemid; 
	}
	public String getItemid() {
		return itemid; 
	}
	public void setTestcond(String testcond) {
		this.testcond = testcond; 
	}
	public String getTestcond() {
		return testcond; 
	}
	public String getSmpid() {
		return smpid;
	}
	public void setSmpid(String smpid) {
		this.smpid = smpid;
	}
	public String getReqid() {
		return reqid;
	}
	public void setReqid(String reqid) {
		this.reqid = reqid;
	}
	public String getAdminid() {
		return adminid;
	}
	public void setAdminid(String adminid) {
		this.adminid = adminid;
	}
	
}
