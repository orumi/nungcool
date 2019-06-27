package tems.com.edu.appr.model;

import java.util.List;

public class ApprWriteFormVO {

	private String cosID;
	private List<String> chkedList;
	private String apprType;
	private String loginID;

	public String getCosID() {
		return cosID;
	}

	public void setCosID(String cosID) {
		this.cosID = cosID;
	}

	public List<String> getChkedList() {
		return chkedList;
	}

	public void setChkedList(List<String> chkedList) {
		this.chkedList = chkedList;
	}

	public String getApprType() {
		return apprType;
	}

	public void setApprType(String apprType) {
		this.apprType = apprType;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	@Override
	public String toString() {
		return "ApprWriteFormVO [cosID=" + cosID + ", chkedList=" + chkedList + ", apprType=" + apprType + ", loginID=" + loginID + "]";
	}

}
