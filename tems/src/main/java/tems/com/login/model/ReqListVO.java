package tems.com.login.model;

import java.io.Serializable;

public class ReqListVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String reqid;
	private String requestcdate;
	private String comname;
	private String memname;
	private String statenm;
	private String smpcnt;
	private String rltcnt;
	public String getReqid() {
		return reqid;
	}
	public void setReqid(String reqid) {
		this.reqid = reqid;
	}
	public String getRequestcdate() {
		return requestcdate;
	}
	public void setRequestcdate(String requestcdate) {
		this.requestcdate = requestcdate;
	}
	public String getComname() {
		return comname;
	}
	public void setComname(String comname) {
		this.comname = comname;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getStatenm() {
		return statenm;
	}
	public void setStatenm(String statenm) {
		this.statenm = statenm;
	}
	public String getSmpcnt() {
		return smpcnt;
	}
	public void setSmpcnt(String smpcnt) {
		this.smpcnt = smpcnt;
	}
	public String getRltcnt() {
		return rltcnt;
	}
	public void setRltcnt(String rltcnt) {
		this.rltcnt = rltcnt;
	}

	
}
