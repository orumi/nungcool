package ncsys.com.isms.hierarchy.service.model;

import java.util.HashMap;


public class InspectList {
	
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
	private String dcnt;
	private String dnum;
	private String rgldtlnm; 
	private String itemseq;
	private String inspectitem;
	private String inspectdetail;
	
	/* searching condition */
	private String versionId;
	private String fieldId;
	
	
	
	
	
	public String getDcnt() {
		return dcnt;
	}

	public void setDcnt(String dcnt) {
		this.dcnt = dcnt;
	}

	public String getDnum() {
		return dnum;
	}

	public void setDnum(String dnum) {
		this.dnum = dnum;
	}

	public String getItemseq() {
		return itemseq;
	}

	public void setItemseq(String itemseq) {
		this.itemseq = itemseq;
	}

	public String getInspectitem() {
		return inspectitem;
	}

	public void setInspectitem(String inspectitem) {
		this.inspectitem = inspectitem;
	}

	public String getInspectdetail() {
		return inspectdetail;
	}

	public void setInspectdetail(String inspectdetail) {
		this.inspectdetail = inspectdetail;
	}

	public String getVersionId() {
		return versionId;
	}

	public void setVersionId(String versionId) {
		this.versionId = versionId;
	}

	public String getFieldId() {
		return fieldId;
	}

	public void setFieldId(String fieldId) {
		this.fieldId = fieldId;
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
		
		
		HashMap<String, Object> rgldtlnm = new HashMap<String, Object>();
		if(this.dnum.equals("1")){
			rgldtlnm.put("rowspan", this.dcnt);
		} else {
			rgldtlnm.put("display", "none");
		}
		attr.put("rgldtlnm", rgldtlnm);
		
		//rgldtlid
		attr.put("rgldtlid", rgldtlnm);
		
		return attr;
	}

	public void setAttr(HashMap<String, Object> attr) {
		this.attr = attr;
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


	public String getRowidx() {
		return rowidx;
	}

	public void setRowidx(String rowidx) {
		this.rowidx = rowidx;
	}
	
	
	
	
	
	
	
}
