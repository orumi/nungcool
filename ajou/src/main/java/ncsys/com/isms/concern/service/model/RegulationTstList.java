package ncsys.com.isms.concern.service.model;

import java.util.HashMap;

public class RegulationTstList {
	
	private String rowidx; 
	private String verid; 
	private String rgldtlid; 
	private String fldid; 
	private String fldnm; 
	private String fsort;
	private String fcnt;
	private String fnum;  
	private String rglid; 
	private String rglnm; 
	private String rsort;
	private String rcnt;
	private String rnum;
	private String dsort; 
	private String rgldtlnm;
	private String rdtlid;
	private String weekpoint;
	private String concernpoint;
	private String concernlevel;
	private String planyn;
	private String plandetail; 
		
	private String userId;
	
	private String actionmode;

	public String getRowidx() {
		return rowidx;
	}

	public void setRowidx(String rowidx) {
		this.rowidx = rowidx;
	}

	public String getVerid() {
		return verid;
	}

	public void setVerid(String verid) {
		this.verid = verid;
	}

	public String getRgldtlid() {
		return rgldtlid;
	}

	public void setRgldtlid(String rgldtlid) {
		this.rgldtlid = rgldtlid;
	}

	public String getFldid() {
		return fldid;
	}

	public void setFldid(String fldid) {
		this.fldid = fldid;
	}

	public String getFldnm() {
		return fldnm;
	}

	public void setFldnm(String fldnm) {
		this.fldnm = fldnm;
	}

	public String getFsort() {
		return fsort;
	}

	public void setFsort(String fsort) {
		this.fsort = fsort;
	}

	public String getFcnt() {
		return fcnt;
	}

	public void setFcnt(String fcnt) {
		this.fcnt = fcnt;
	}

	public String getFnum() {
		return fnum;
	}

	public void setFnum(String fnum) {
		this.fnum = fnum;
	}

	public String getRglid() {
		return rglid;
	}

	public void setRglid(String rglid) {
		this.rglid = rglid;
	}

	public String getRglnm() {
		return rglnm;
	}

	public void setRglnm(String rglnm) {
		this.rglnm = rglnm;
	}

	public String getRsort() {
		return rsort;
	}

	public void setRsort(String rsort) {
		this.rsort = rsort;
	}

	public String getRcnt() {
		return rcnt;
	}

	public void setRcnt(String rcnt) {
		this.rcnt = rcnt;
	}

	public String getRnum() {
		return rnum;
	}

	public void setRnum(String rnum) {
		this.rnum = rnum;
	}

	public String getDsort() {
		return dsort;
	}

	public void setDsort(String dsort) {
		this.dsort = dsort;
	}

	public String getRgldtlnm() {
		return rgldtlnm;
	}

	public void setRgldtlnm(String rgldtlnm) {
		this.rgldtlnm = rgldtlnm;
	}

	public String getRdtlid() {
		return rdtlid;
	}

	public void setRdtlid(String rdtlid) {
		this.rdtlid = rdtlid;
	}

	public String getWeekpoint() {
		return weekpoint;
	}

	public void setWeekpoint(String weekpoint) {
		this.weekpoint = weekpoint;
	}

	public String getConcernpoint() {
		return concernpoint;
	}

	public void setConcernpoint(String concernpoint) {
		this.concernpoint = concernpoint;
	}

	public String getConcernlevel() {
		return concernlevel;
	}

	public void setConcernlevel(String concernlevel) {
		this.concernlevel = concernlevel;
	}

	public String getPlanyn() {
		return planyn;
	}

	public void setPlanyn(String planyn) {
		this.planyn = planyn;
	}

	public String getPlandetail() {
		return plandetail;
	}

	public void setPlandetail(String plandetail) {
		this.plandetail = plandetail;
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

	

	private HashMap<String, Object> attr;
	
	public HashMap<String, Object> getAttr() {
		attr = new HashMap<String, Object>( );
		
		HashMap<String, Object> fldnm = new HashMap<String, Object>();
		
		if( this.fnum.equals("1") ){
			fldnm.put("rowspan", this.fcnt);
		} else {
			fldnm.put("display", "none");
		}
		attr.put("fldnm", fldnm);
		
		HashMap<String, Object> rglnm = new HashMap<String, Object>();
		
		if(this.rnum.equals("1")){
			rglnm.put("rowspan", this.rcnt);	
		} else {
			rglnm.put("display", "none");
		}
		attr.put("rglnm", rglnm);
		
		return attr;
	}

	public void setAttr(HashMap<String, Object> attr) {
		this.attr = attr;
	}

	
	
	
	
	
}
