package ncsys.com.isms.measure.service.model;

import java.util.HashMap;


public class DiagnosisList {
	
	private String rowidx;
	private String dgsid; 
	private String msrdtlid; 
	private String pifldid; 
	private String pifldnm; 
	private String fsort;
	private String fcnt;
	private String fnum;  
	private String msrid; 
	private String msrname; 
	private String rsort;
	private String rcnt;
	private String rnum;
	private String dsort; 
	private String msrdtlnm;
	private String msrdtl; 
	private String certiact;
	private String calmtd;
	private String weight;
	private String actual;
	
	
	
	
	public String getDgsid() {
		return dgsid;
	}
	public void setDgsid(String dgsid) {
		this.dgsid = dgsid;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getActual() {
		return actual;
	}
	public void setActual(String actual) {
		this.actual = actual;
	}
	public String getRowidx() {
		return rowidx;
	}
	public void setRowidx(String rowidx) {
		this.rowidx = rowidx;
	}
	
	public String getMsrdtlid() {
		return msrdtlid;
	}
	public void setMsrdtlid(String msrdtlid) {
		this.msrdtlid = msrdtlid;
	}
	public String getPifldid() {
		return pifldid;
	}
	public void setPifldid(String pifldid) {
		this.pifldid = pifldid;
	}
	public String getPifldnm() {
		return pifldnm;
	}
	public void setPifldnm(String pifldnm) {
		this.pifldnm = pifldnm;
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
	public String getMsrid() {
		return msrid;
	}
	public void setMsrid(String msrid) {
		this.msrid = msrid;
	}
	public String getMsrname() {
		return msrname;
	}
	public void setMsrname(String msrname) {
		this.msrname = msrname;
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
	public String getMsrdtl() {
		return msrdtl;
	}
	public void setMsrdtl(String msrdtl) {
		this.msrdtl = msrdtl;
	}
	public String getCertiact() {
		return certiact;
	}
	public void setCertiact(String certiact) {
		this.certiact = certiact;
	}
	public String getCalmtd() {
		return calmtd;
	}
	public void setCalmtd(String calmtd) {
		this.calmtd = calmtd;
	}
	public String getMsrdtlnm() {
		return msrdtlnm;
	}
	public void setMsrdtlnm(String msrdtlnm) {
		this.msrdtlnm = msrdtlnm;
	}
	
	private HashMap<String, Object> attr;
	
	public HashMap<String, Object> getAttr() {
		attr = new HashMap<String, Object>( );
		
		HashMap<String, Object> pifldnm = new HashMap<String, Object>();
		
		if( this.fnum.equals("1") ){
			pifldnm.put("rowspan", this.fcnt);
		} else {
			pifldnm.put("display", "none");
		}
		attr.put("pifldnm", pifldnm);
		
		HashMap<String, Object> msrname = new HashMap<String, Object>();
		
		if(this.rnum.equals("1")){
			msrname.put("rowspan", this.rcnt);	
		} else {
			msrname.put("display", "none");
		}
		attr.put("msrname", msrname);
		
		return attr;
	}

	public void setAttr(HashMap<String, Object> attr) {
		this.attr = attr;
	}
	
	
	
	
	
	
}
