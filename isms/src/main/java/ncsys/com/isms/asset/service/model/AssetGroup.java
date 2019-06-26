package ncsys.com.isms.asset.service.model;

import java.util.HashMap;

public class AssetGroup implements AssetGrp{
	
	private String rowidx;
	private String astgrpid;
	private String astgrpkind;
	private String astgrpkindnm;
	private String astgrpnm;
	private String astgrpdfn;
	private String useyn;
	private String delyn;
	private String sortby;
	
	private String actionmode;
	
	private String userId;
	
	public String getAstgrpid() {
		return astgrpid;
	}
	public void setAstgrpid(String astgrpid) {
		this.astgrpid = astgrpid;
	}
	public String getAstgrpkind() {
		return astgrpkind;
	}
	public void setAstgrpkind(String astgrpkind) {
		this.astgrpkind = astgrpkind;
	}
	public String getAstgrpkindnm() {
		return astgrpkindnm;
	}
	public void setAstgrpkindnm(String astgrpkindnm) {
		this.astgrpkindnm = astgrpkindnm;
	}
	@Override
	public String getAstgrpnm() {
		return astgrpnm;
	}
	public void setAstgrpnm(String astgrpnm) {
		this.astgrpnm = astgrpnm;
	}
	public String getAstgrpdfn() {
		return astgrpdfn;
	}
	public void setAstgrpdfn(String astgrpdfn) {
		this.astgrpdfn = astgrpdfn;
	}
	public String getUseyn() {
		return useyn;
	}
	public void setUseyn(String useyn) {
		this.useyn = useyn;
	}
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}
	public String getSortby() {
		return sortby;
	}
	public void setSortby(String sortby) {
		this.sortby = sortby;
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
	public String getRowidx() {
		return rowidx;
	}
	public void setRowidx(String rowidx) {
		this.rowidx = rowidx;
	}

	
	
	
	
	
	
}
