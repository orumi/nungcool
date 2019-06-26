package ncsys.com.isms.weekTest.service.model;

public class WeekTestItem {
	
	private String astgrpid;
	private String astgrpnm;
	private String wktstfieldid;
	private String wktstfieldnm;
	private String tstitemcd;
	private String tstitemnm;
	private String importance;
	private String tstscr;
	private String useyn;
	private String delyn;
	private String sortby;
	private String inputid;
	private String inputdt;
	private String updateid;
	private String updatedt;
	
	private String oldAstgrpid;
	private String oldTstitemcd;
		
	private String userId;
	
	private String actionmode;

	public String getAstgrpid() {
		return astgrpid;
	}

	public String getOldAstgrpid() {
		return oldAstgrpid;
	}

	public void setOldAstgrpid(String oldAstgrpid) {
		this.oldAstgrpid = oldAstgrpid;
	}

	public String getOldTstitemcd() {
		return oldTstitemcd;
	}

	public void setOldTstitemcd(String oldTstitemcd) {
		this.oldTstitemcd = oldTstitemcd;
	}

	public void setAstgrpid(String astgrpid) {
		this.astgrpid = astgrpid;
	}

	public String getWktstfieldid() {
		return wktstfieldid;
	}

	public void setWktstfieldid(String wktstfieldid) {
		this.wktstfieldid = wktstfieldid;
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
		String reval = "";
		
		if("상".equals(this.importance)){
			reval = "3";
		} else if("중".equals(this.importance)){
			reval = "2";
		} else if("하".equals(this.importance)){
			reval = "1";
		}
		
		return reval;
	}

	public void setTstscr(String tstscr) {
		this.tstscr = tstscr;
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

	public String getInputid() {
		return inputid;
	}

	public void setInputid(String inputid) {
		this.inputid = inputid;
	}

	public String getInputdt() {
		return inputdt;
	}

	public void setInputdt(String inputdt) {
		this.inputdt = inputdt;
	}

	public String getUpdateid() {
		return updateid;
	}

	public void setUpdateid(String updateid) {
		this.updateid = updateid;
	}

	public String getUpdatedt() {
		return updatedt;
	}

	public void setUpdatedt(String updatedt) {
		this.updatedt = updatedt;
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

	public String getWktstfieldnm() {
		return wktstfieldnm;
	}

	public void setWktstfieldnm(String wktstfieldnm) {
		this.wktstfieldnm = wktstfieldnm;
	}

	public String getAstgrpnm() {
		return astgrpnm;
	}

	public void setAstgrpnm(String astgrpnm) {
		this.astgrpnm = astgrpnm;
	}
	
	
	
	
	
	
	
}
