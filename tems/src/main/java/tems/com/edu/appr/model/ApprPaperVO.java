package tems.com.edu.appr.model;

import java.util.List;

public class ApprPaperVO {

	private String apprID;
	private String cosID;

	private String apprName;
	private String apprContent;
	private String apprType;
	private String apprState;
	private int maxOrdinal;

	private String draftID;
	private String firstID;
	private String secondID;
	private String thirdID;
	private String fourthID;
	private List<String> memberList;

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
		apprContent = apprContent.replace("\r\n","<br>");
		this.apprContent = apprContent;
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

	public int getMaxOrdinal() {
		return maxOrdinal;
	}

	public void setMaxOrdinal(int maxOrdinal) {
		this.maxOrdinal = maxOrdinal;
	}

	public String getDraftID() {
		return draftID;
	}

	public void setDraftID(String draftID) {
		this.draftID = draftID;
	}

	public String getFirstID() {
		return firstID;
	}

	public void setFirstID(String firstID) {
		this.firstID = firstID;
	}

	public String getSecondID() {
		return secondID;
	}

	public void setSecondID(String secondID) {
		this.secondID = secondID;
	}

	public String getThirdID() {
		return thirdID;
	}

	public void setThirdID(String thirdID) {
		this.thirdID = thirdID;
	}

	public String getFourthID() {
		return fourthID;
	}

	public void setFourthID(String fourthID) {
		this.fourthID = fourthID;
	}

	public List<String> getMemberList() {
		return memberList;
	}

	public void setMemberList(List<String> memberList) {
		this.memberList = memberList;
	}

	@Override
	public String toString() {
		return "ApprPaperVO [apprID=" + apprID + ", cosID=" + cosID + ", apprName=" + apprName + ", apprContent=" + apprContent + ", apprType=" + apprType + ", apprState="
				+ apprState + ", maxOrdinal=" + maxOrdinal + ", draftID=" + draftID + ", firstID=" + firstID + ", secondID=" + secondID + ", thirdID=" + thirdID + ", fourthID="
				+ fourthID + ", memberList=" + memberList + "]";
	}

}
