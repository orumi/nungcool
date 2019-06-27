package tems.com.officialExam.officialReq.model;

public class ReqAttachVO {

	private String filepath;
	private String reqid;
	private String orgname;
	public void setFilepath(String filepath) {
		this.filepath = filepath; 
	}
	public String getFilepath() {
		return filepath; 
	}
	public void setReqid(String reqid) {
		this.reqid = reqid; 
	}
	public String getReqid() {
		return reqid; 
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname; 
	}
	public String getOrgname() {
		return orgname; 
	}

}
