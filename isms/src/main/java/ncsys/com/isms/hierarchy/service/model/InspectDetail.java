package ncsys.com.isms.hierarchy.service.model;

import java.util.HashMap;


public class InspectDetail implements RglDetail{
	
	private String rowidx;
	private String verid; 
	private String vernm;
	private String rgldtlid; 
	private String fldid; 
	private String fldnm; 
	private String fsort;
	private String rglid; 
	private String rglnm; 
	private String ismsstd;
	private String rsort;
	private String dsort;
	private String rgldtlnm; 
	private String itemseq;
	private String inspectitem;
	private String inspectdetail;
	
	
	private String userId;
	
	private String actionmode;
	
	/* searching condition */
	private String versionId;
	private String fieldId;
	
	
	
	
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
	@Override
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
	
	public String getRglid() {
		return rglid;
	}
	public void setRglid(String rglid) {
		this.rglid = rglid;
	}
	@Override
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
	
	public String getDsort() {
		return dsort;
	}
	public void setDsort(String dsort) {
		this.dsort = dsort;
	}
	@Override
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

	public String getIsmsstd() {
		return ismsstd;
	}

	public void setIsmsstd(String ismsstd) {
		this.ismsstd = ismsstd;
	}
	@Override
	public String getVernm() {
		return vernm;
	}

	public void setVernm(String vernm) {
		this.vernm = vernm;
	}
	
	
	
	
	
	
	
}
