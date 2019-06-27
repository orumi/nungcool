package tems.com.edu.appr.model;

public class ApprVO {

	private String apprID;
	private String cosID;
	private String apprName;
	private String apprContent;
	private String draftID;
	private String name;
	private String draftDate;
	private String apprTypeID;
	private String apprTypeName;
	private String apprStateID;
	private String apprStateName;
	private String adminID;
	private String myapprStateID;
	private String myapprStateName;

	public String getApprID() {
		return apprID;
	}

	public void setApprID(String apprID) {
		this.apprID = apprID;
	}

	public String getCosID() {
		return cosID;
	}

	public void setCosID(String cosID) {
		this.cosID = cosID;
	}

	public String getApprName() {
		return apprName;
	}

	public void setApprName(String apprName) {
		this.apprName = apprName;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDraftDate() {
		return draftDate;
	}

	public void setDraftDate(String draftDate) {
		this.draftDate = draftDate;
	}

	public String getApprTypeID() {
		return apprTypeID;
	}

	public void setApprTypeID(String apprTypeID) {
		this.apprTypeID = apprTypeID;
	}

	public String getApprTypeName() {
		return apprTypeName;
	}

	public void setApprTypeName(String apprTypeName) {
		this.apprTypeName = apprTypeName;
	}

	public String getApprStateID() {
		return apprStateID;
	}

	public void setApprStateID(String apprStateID) {
		this.apprStateID = apprStateID;
	}

	public String getApprStateName() {
		return apprStateName;
	}

	public void setApprStateName(String apprStateName) {
		this.apprStateName = apprStateName;
	}

	public String getAdminID() {
		return adminID;
	}

	public void setAdminID(String adminID) {
		this.adminID = adminID;
	}

	public String getMyapprStateID() {
		return myapprStateID;
	}

	public void setMyapprStateID(String myapprStateID) {
		this.myapprStateID = myapprStateID;
	}

	public String getMyapprStateName() {
		return myapprStateName;
	}

	public void setMyapprStateName(String myapprStateName) {
		this.myapprStateName = myapprStateName;
	}

	@Override
	public String toString() {
		return "ApprVO [apprID=" + apprID + ", cosID=" + cosID + ", apprName=" + apprName + ", apprContent=" + apprContent + ", draftID=" + draftID + ", name=" + name
				+ ", draftDate=" + draftDate + ", apprTypeID=" + apprTypeID + ", apprTypeName=" + apprTypeName + ", apprStateID=" + apprStateID + ", apprStateName="
				+ apprStateName + ", adminID=" + adminID + ", myapprStateID=" + myapprStateID + ", myapprStateName=" + myapprStateName + "]";
	}

}
