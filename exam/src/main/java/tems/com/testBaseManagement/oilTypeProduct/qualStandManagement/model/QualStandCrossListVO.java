package tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model;

import java.util.HashMap;

public class QualStandCrossListVO {

	private String name;
	private String displaytype;
	private String mtitemid;
	private String methodname;
	private String specid;
	private String unitid;
	private String specnm;
	private String spec;
	
	public HashMap crossTap;
	
	public QualStandCrossListVO(){
		crossTap = new HashMap<String, String>();
	}
	
	public String getSpec() {
		return spec;
	}
	public void setSpec(String spec) {
		this.spec = spec;
	}
	public void setName(String name) {
		this.name = name; 
	}
	public String getName() {
		return name; 
	}
	public void setDisplaytype(String displaytype) {
		this.displaytype = displaytype; 
	}
	public String getDisplaytype() {
		return displaytype; 
	}
	public void setMtitemid(String mtitemid) {
		this.mtitemid = mtitemid; 
	}
	public String getMtitemid() {
		return mtitemid; 
	}
	public void setMethodname(String methodname) {
		this.methodname = methodname; 
	}
	public String getMethodname() {
		return methodname; 
	}
	public void setSpecid(String specid) {
		this.specid = specid; 
	}
	public String getSpecid() {
		return specid; 
	}
	public void setUnitid(String unitid) {
		this.unitid = unitid; 
	}
	public String getUnitid() {
		return unitid; 
	}
	public void setSpecnm(String specnm) {
		this.specnm = specnm; 
	}
	public String getSpecnm() {
		return specnm; 
	}

}
