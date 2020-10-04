package ncsys.com.isms.actual.service.model;

import java.util.HashMap;


public class ActualList {
	
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
	private String rgldtlnm;
	private String ismsstd;
	private String dsort;
	private String dcnt;
	private String dnum;
	 
	private String proofid;
	private String proofitem;
	private String frequency;
	private String ownertype;
	private String owner;
	private String proe;
	
	
	private String pfid;
	private String year;
	private String a01;
	private String a02;
	private String a03;
	private String a04;
	private String a05;
	private String a06;
	private String a07;
	private String a08;
	private String a09;
	private String a10;
	private String a11;
	private String a12;
	
	/* searching condition */
	private String versionId;
	private String fieldId;
	
	
	public String getPfid() {
		return pfid;
	}

	public void setPfid(String pfid) {
		this.pfid = pfid;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getA01() {
		return a01;
	}

	public void setA01(String a01) {
		this.a01 = a01;
	}

	public String getA02() {
		return a02;
	}

	public void setA02(String a02) {
		this.a02 = a02;
	}

	public String getA03() {
		return a03;
	}

	public void setA03(String a03) {
		this.a03 = a03;
	}

	public String getA04() {
		return a04;
	}

	public void setA04(String a04) {
		this.a04 = a04;
	}

	public String getA05() {
		return a05;
	}

	public void setA05(String a05) {
		this.a05 = a05;
	}

	public String getA06() {
		return a06;
	}

	public void setA06(String a06) {
		this.a06 = a06;
	}

	public String getA07() {
		return a07;
	}

	public void setA07(String a07) {
		this.a07 = a07;
	}

	public String getA08() {
		return a08;
	}

	public void setA08(String a08) {
		this.a08 = a08;
	}

	public String getA09() {
		return a09;
	}

	public void setA09(String a09) {
		this.a09 = a09;
	}

	public String getA10() {
		return a10;
	}

	public void setA10(String a10) {
		this.a10 = a10;
	}

	public String getA11() {
		return a11;
	}

	public void setA11(String a11) {
		this.a11 = a11;
	}

	public String getA12() {
		return a12;
	}

	public void setA12(String a12) {
		this.a12 = a12;
	}


	
	
	public String getIsmsstd() {
		return ismsstd;
	}

	public void setIsmsstd(String ismsstd) {
		this.ismsstd = ismsstd;
	}

	public String getProofid() {
		return proofid;
	}

	public void setProofid(String proofid) {
		this.proofid = proofid;
	}

	public String getProofitem() {
		return proofitem;
	}

	public void setProofitem(String proofitem) {
		this.proofitem = proofitem;
	}

	public String getFrequency() {
		return frequency;
	}

	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}

	public String getOwnertype() {
		return ownertype;
	}

	public void setOwnertype(String ownertype) {
		this.ownertype = ownertype;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getProe() {
		return proe;
	}

	public void setProe(String proe) {
		this.proe = proe;
	}

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
		attr.put("ismsstd", rgldtlnm);
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
