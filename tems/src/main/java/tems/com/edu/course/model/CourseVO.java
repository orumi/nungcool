package tems.com.edu.course.model;

public class CourseVO {

	private String cosID;
	private String subjectID;
	private String cosName;
	private String enrollStartDate;
	private String enrollStartHour;
	private String enrollEndDate;
	private String enrollEndHour;
	private String cosStartDate;
	private String cosEndDate;
	private String cosPrice;
	private String cosPlace;
	private String cosState;
	private String regID;
	private String regDate;
	private String modifyID;
	private String modifyDate;
	private String codeID;
	private String codeName;

	private String memCnt;

	public String getCosID() {
		return cosID;
	}

	public void setCosID(String cosID) {
		this.cosID = cosID;
	}

	public String getSubjectID() {
		return subjectID;
	}

	public void setSubjectID(String subjectID) {
		this.subjectID = subjectID;
	}

	public String getCosName() {
		return cosName;
	}

	public void setCosName(String cosName) {
		this.cosName = cosName;
	}

	public String getEnrollStartDate() {
		return enrollStartDate;
	}

	public void setEnrollStartDate(String enrollStartDate) {
		this.enrollStartDate = enrollStartDate;
	}

	public String getEnrollStartHour() {
		return enrollStartHour;
	}

	public void setEnrollStartHour(String enrollStartHour) {
		this.enrollStartHour = enrollStartHour;
	}

	public String getEnrollEndDate() {
		return enrollEndDate;
	}

	public void setEnrollEndDate(String enrollEndDate) {
		this.enrollEndDate = enrollEndDate;
	}

	public String getEnrollEndHour() {
		return enrollEndHour;
	}

	public void setEnrollEndHour(String enrollEndHour) {
		this.enrollEndHour = enrollEndHour;
	}

	public String getCosStartDate() {
		return cosStartDate;
	}

	public void setCosStartDate(String cosStartDate) {
		this.cosStartDate = cosStartDate;
	}

	public String getCosEndDate() {
		return cosEndDate;
	}

	public void setCosEndDate(String cosEndDate) {
		this.cosEndDate = cosEndDate;
	}

	public String getCosPrice() {
		return cosPrice;
	}

	public void setCosPrice(String cosPrice) {
		this.cosPrice = cosPrice;
	}

	public String getCosPlace() {
		return cosPlace;
	}

	public void setCosPlace(String cosPlace) {
		this.cosPlace = cosPlace;
	}

	public String getCosState() {
		return cosState;
	}

	public void setCosState(String cosState) {
		this.cosState = cosState;
	}

	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getModifyID() {
		return modifyID;
	}

	public void setModifyID(String modifyID) {
		this.modifyID = modifyID;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getCodeID() {
		return codeID;
	}

	public void setCodeID(String codeID) {
		this.codeID = codeID;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	public String getMemCnt() {
		return memCnt;
	}

	public void setMemCnt(String memCnt) {
		this.memCnt = memCnt;
	}

	@Override
	public String toString() {
		return "CourseVO [cosID=" + cosID + ", subjectID=" + subjectID + ", cosName=" + cosName + ", enrollStartDate=" + enrollStartDate + ", enrollStartHour=" + enrollStartHour
				+ ", enrollEndDate=" + enrollEndDate + ", enrollEndHour=" + enrollEndHour + ", cosStartDate=" + cosStartDate + ", cosEndDate=" + cosEndDate + ", cosPrice="
				+ cosPrice + ", cosPlace=" + cosPlace + ", cosState=" + cosState + ", regID=" + regID + ", regDate=" + regDate + ", modifyID=" + modifyID + ", modifyDate="
				+ modifyDate + ", codeID=" + codeID + ", codeName=" + codeName + ", memCnt=" + memCnt + "]";
	}

}
