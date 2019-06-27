package tems.com.edu.appr.model;

public class CrtApprManagerVO {

	private String cosID;
	private String apprContent;
	private String draftID;
	private String draftDate;
	private String apprType;
	private String apprState;
	private String maxOrdinal;

	private String apprMngID;
	private String apprID;
	private String adminID;
	private String name;
	private String myOrdinal;
	private String myApprState;
	private String OKApprDate;
	private String memo;

	public String getCosID() {
		return cosID;
	}

	public void setCosID(String cosID) {
		this.cosID = cosID;
	}

	public String getApprContent() {
		return apprContent;
	}

	public void setApprContent(String apprContent) {
		this.apprContent = apprContent;
	}

	public String getDraftID() {
		return draftID;
	}

	public void setDraftID(String draftID) {
		this.draftID = draftID;
	}

	public String getDraftDate() {
		return draftDate;
	}

	public void setDraftDate(String draftDate) {
		this.draftDate = draftDate;
	}

	public String getApprType() {
		return apprType;
	}

	public void setApprType(String apprType) {
		this.apprType = apprType;
	}

	public String getApprState() {
		return apprState;
	}

	public void setApprState(String apprState) {
		this.apprState = apprState;
	}

	public String getMaxOrdinal() {
		return maxOrdinal;
	}

	public void setMaxOrdinal(String maxOrdinal) {
		this.maxOrdinal = maxOrdinal;
	}

	public String getApprMngID() {
		return apprMngID;
	}

	public void setApprMngID(String apprMngID) {
		this.apprMngID = apprMngID;
	}

	public String getApprID() {
		return apprID;
	}

	public void setApprID(String apprID) {
		this.apprID = apprID;
	}

	public String getAdminID() {
		return adminID;
	}

	public void setAdminID(String adminID) {
		this.adminID = adminID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMyOrdinal() {
		return myOrdinal;
	}

	public void setMyOrdinal(String myOrdinal) {
		this.myOrdinal = myOrdinal;
	}

	public String getMyApprState() {
		return myApprState;
	}

	public void setMyApprState(String myApprState) {
		this.myApprState = myApprState;
	}

	public String getOKApprDate() {
		return OKApprDate;
	}

	public void setOKApprDate(String oKApprDate) {
		OKApprDate = oKApprDate;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	@Override
	public String toString() {
		return "CrtApprManagerVO [cosID=" + cosID + ", apprContent=" + apprContent + ", draftID=" + draftID + ", draftDate=" + draftDate + ", apprType=" + apprType
				+ ", apprState=" + apprState + ", maxOrdinal=" + maxOrdinal + ", apprMngID=" + apprMngID + ", apprID=" + apprID + ", adminID=" + adminID + ", name=" + name
				+ ", myOrdinal=" + myOrdinal + ", myApprState=" + myApprState + ", OKApprDate=" + OKApprDate + ", memo=" + memo + "]";
	}

}
