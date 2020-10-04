package ncsys.com.isms.weekTest.service.model;

public class WeekTestDtlDetail {
	

	private String rowidx;
	private String astverid;
	private String astvernm;
	
	private String astgrpid;
	private String astgrpnm;
	private String assetid;
	private String mgnno;
	private String cate01;
	private String cate02;
	private String assetnm;
	private String imptc;
	private String impti;
	private String impta;
	private String certiyn;
	private String wktstyn;
	
	
	private String wktstfieldid;
	private String wktstfieldnm;
	private String tstitemcd;
	private String tstitemnm;
	private String importance;
	private String tstscr;
	private String tstrst;
	private String settingenv;
	private String tstresult;

	private String tstrstscr;
	
	public String getCate01() {
		return cate01;
	}
	public void setCate01(String cate01) {
		this.cate01 = cate01;
	}
	public String getCate02() {
		return cate02;
	}
	public void setCate02(String cate02) {
		this.cate02 = cate02;
	}
	public String getAssetnm() {
		return assetnm;
	}
	public void setAssetnm(String assetnm) {
		this.assetnm = assetnm;
	}
	public String getImptc() {
		return imptc;
	}
	public void setImptc(String imptc) {
		this.imptc = imptc;
	}
	public String getImpti() {
		return impti;
	}
	public void setImpti(String impti) {
		this.impti = impti;
	}
	public String getImpta() {
		return impta;
	}
	public void setImpta(String impta) {
		this.impta = impta;
	}
	public String getCertiyn() {
		return certiyn;
	}
	public void setCertiyn(String certiyn) {
		this.certiyn = certiyn;
	}
	public String getWktstyn() {
		return wktstyn;
	}
	public void setWktstyn(String wktstyn) {
		this.wktstyn = wktstyn;
	}
	
	
	public String getAstvernm() {
		return astvernm;
	}
	public void setAstvernm(String astvernm) {
		this.astvernm = astvernm;
	}
	public String getMgnno() {
		return mgnno;
	}
	public void setMgnno(String mgnno) {
		this.mgnno = mgnno;
	}
	private String userId;
	
	private String actionmode;
	
	public String getTstresult() {
		return tstresult;
	}
	public void setTstresult(String tstresult) {
		this.tstresult = tstresult;
	}
	public String getRowidx() {
		return rowidx;
	}
	public void setRowidx(String rowidx) {
		this.rowidx = rowidx;
	}
	public String getAstgrpid() {
		return astgrpid;
	}
	public void setAstgrpid(String astgrpid) {
		this.astgrpid = astgrpid;
	}
	public String getAstgrpnm() {
		return astgrpnm;
	}
	public void setAstgrpnm(String astgrpnm) {
		this.astgrpnm = astgrpnm;
	}
	public String getWktstfieldid() {
		return wktstfieldid;
	}
	public void setWktstfieldid(String wktstfieldid) {
		this.wktstfieldid = wktstfieldid;
	}
	public String getWktstfieldnm() {
		return wktstfieldnm;
	}
	public void setWktstfieldnm(String wktstfieldnm) {
		this.wktstfieldnm = wktstfieldnm;
	}
	public String getTstitemcd() {
		return tstitemcd;
	}
	public void setTstitemcd(String tstitemcd) {
		this.tstitemcd = tstitemcd;
	}
	public String getTstitemnm() {
		return tstitemnm;
	}
	public void setTstitemnm(String tstitemnm) {
		this.tstitemnm = tstitemnm;
	}
	public String getImportance() {
		return importance;
	}
	public void setImportance(String importance) {
		this.importance = importance;
	}
	public String getTstscr() {
		return tstscr;
	}
	public void setTstscr(String tstscr) {
		this.tstscr = tstscr;
	}
	public String getTstrst() {
		return tstrst;
	}
	public void setTstrst(String tstrst) {
		this.tstrst = tstrst;
	}
	public String getSettingenv() {
		return settingenv;
	}
	public void setSettingenv(String settingenv) {
		this.settingenv = settingenv;
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
	public String getAssetid() {
		return assetid;
	}
	public void setAssetid(String assetid) {
		this.assetid = assetid;
	}
	public String getAstverid() {
		return astverid;
	}
	public void setAstverid(String astverid) {
		this.astverid = astverid;
	}

	public String getTstrstscr() {
		String reVal = null;
		if("양호".equals(this.tstrst)){
			reVal = "1";
		} else if("취약".equals(this.tstrst)){
			reVal = "0";
		} else if("P".equals(this.tstrst)){
			reVal = "0.5";
		} else if("N/A".equals(this.tstrst)){
			reVal = "N";
		}
		
		return reVal;
	}
	public void setTstrstscr(String tstrstscr) {
		this.tstrstscr = tstrstscr;
	}
	
	

	
	
}
