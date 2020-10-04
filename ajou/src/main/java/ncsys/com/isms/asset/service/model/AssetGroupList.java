package ncsys.com.isms.asset.service.model;

import java.util.HashMap;

public class AssetGroupList {
	
	private String rowidx;
	private String astgrpid;
	private String astgrpkind;
	private String astgrpkindnm;
	private String astgrpnm;
	private String astgrpdfn;
	private String useyn;
	private String delyn;
	private String sortby;
	
	/*cell merge*/
	private String cnt;
	private String num;
	
	private HashMap<String, Object> attr;
	
	public HashMap<String, Object> getAttr() {
		attr = new HashMap<String, Object>( );
		
		HashMap<String, Object> rowMerge = new HashMap<String, Object>();
		
		if( this.num.equals("1") ){
			rowMerge.put("rowspan", this.cnt);
		} else {
			rowMerge.put("display", "none");
		}
		attr.put("astgrpkindnm", rowMerge);
		
		return attr;
	}

	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
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
