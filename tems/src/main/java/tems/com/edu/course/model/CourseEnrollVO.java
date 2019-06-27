package tems.com.edu.course.model;

public class CourseEnrollVO {

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

	private String enrollID;
	private String eCosID;
	private String memID;
	private String memName;
	private String hp;
	private String email;
	private String comName;
	private String comCEO;

	private String enrollState;
	private String mailEstimate;
	private String smsEstimate;

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

	public String getEnrollID() {
		return enrollID;
	}

	public void setEnrollID(String enrollID) {
		this.enrollID = enrollID;
	}

	public String geteCosID() {
		return eCosID;
	}

	public void seteCosID(String eCosID) {
		this.eCosID = eCosID;
	}

	public String getMemID() {
		return memID;
	}

	public void setMemID(String memID) {
		this.memID = memID;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getHp() {
		return hp;
	}

	public void setHp(String hp) {
		this.hp = hp;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getComName() {
		return comName;
	}

	public void setComName(String comName) {
		this.comName = comName;
	}

	public String getComCEO() {
		return comCEO;
	}

	public void setComCEO(String comCEO) {
		this.comCEO = comCEO;
	}

	public String getEnrollState() {
		return enrollState;
	}

	public void setEnrollState(String enrollState) {
		this.enrollState = enrollState;
	}

	public String getMailEstimate() {
		return mailEstimate;
	}

	public void setMailEstimate(String mailEstimate) {
		this.mailEstimate = mailEstimate;
	}

	public String getSmsEstimate() {
		return smsEstimate;
	}

	public void setSmsEstimate(String smsEstimate) {
		this.smsEstimate = smsEstimate;
	}

	@Override
	public String toString() {
		return "CourseEnrollVO [cosID=" + cosID + ", subjectID=" + subjectID + ", cosName=" + cosName + ", enrollStartDate=" + enrollStartDate + ", enrollStartHour="
				+ enrollStartHour + ", enrollEndDate=" + enrollEndDate + ", enrollEndHour=" + enrollEndHour + ", cosStartDate=" + cosStartDate + ", cosEndDate=" + cosEndDate
				+ ", cosPrice=" + cosPrice + ", cosPlace=" + cosPlace + ", cosState=" + cosState + ", enrollID=" + enrollID + ", eCosID=" + eCosID + ", memID=" + memID
				+ ", memName=" + memName + ", hp=" + hp + ", email=" + email + ", comName=" + comName + ", comCEO=" + comCEO + ", enrollState=" + enrollState + ", mailEstimate="
				+ mailEstimate + ", smsEstimate=" + smsEstimate + "]";
	}

}
