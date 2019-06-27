package tems.com.edu.course.model;


public class SubjectVO {

	private String subjectID;
	private String subjectName;
	private String subjectDesc;
	private String subjectPrice;
	private String regID;
	private String regDate;
	private String modifyID;
	private String modifyDate;

	public String getSubjectID() {
		return subjectID;
	}

	public void setSubjectID(String subjectID) {
		this.subjectID = subjectID;
	}

	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}

	public String getSubjectDesc() {
		return subjectDesc;
	}

	public void setSubjectDesc(String subjectDesc) {
		this.subjectDesc = subjectDesc;
	}

	public String getSubjectPrice() {
		return subjectPrice;
	}

	public void setSubjectPrice(String subjectPrice) {
		this.subjectPrice = subjectPrice;
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

	@Override
	public String toString() {
		return "SubjectVO [subjectID=" + subjectID + ", subjectName=" + subjectName + ", subjectDesc=" + subjectDesc + ", subjectPrice=" + subjectPrice + ", regID=" + regID
				+ ", regDate=" + regDate + ", modifyID=" + modifyID + ", modifyDate=" + modifyDate + "]";
	}

}
