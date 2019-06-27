package tems.com.edu.course.model;

public class EnrollStateVO {

	private String enrollID;
	private String enrollState;
	private String mailEstimate;
	private String smsEstimate;
	private String adminID;
	private String cosID;

	public String getEnrollID() {
		return enrollID;
	}

	public void setEnrollID(String enrollID) {
		this.enrollID = enrollID;
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

	public String getAdminID() {
		return adminID;
	}

	public void setAdminID(String adminID) {
		this.adminID = adminID;
	}

	public String getCosID() {
		return cosID;
	}

	public void setCosID(String cosID) {
		this.cosID = cosID;
	}

	@Override
	public String toString() {
		return "EnrollStateVO [enrollID=" + enrollID + ", enrollState=" + enrollState + ", mailEstimate=" + mailEstimate + ", smsEstimate=" + smsEstimate + ", adminID=" + adminID
				+ ", cosID=" + cosID + "]";
	}

}
