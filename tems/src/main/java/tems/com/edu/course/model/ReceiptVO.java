package tems.com.edu.course.model;

public class ReceiptVO {

	private String receiptID;
	private String rEnrollID;
	private String issueDate;
	private String issueID;
	private String receiptNO;

	private String eEnrollID;
	private String mailReceipt;
	private String smsReceipt;

	public String getReceiptID() {
		return receiptID;
	}

	public void setReceiptID(String receiptID) {
		this.receiptID = receiptID;
	}

	public String getrEnrollID() {
		return rEnrollID;
	}

	public void setrEnrollID(String rEnrollID) {
		this.rEnrollID = rEnrollID;
	}

	public String getIssueDate() {
		return issueDate;
	}

	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}

	public String getIssueID() {
		return issueID;
	}

	public void setIssueID(String issueID) {
		this.issueID = issueID;
	}

	public String getReceiptNO() {
		return receiptNO;
	}

	public void setReceiptNO(String receiptNO) {
		this.receiptNO = receiptNO;
	}

	public String geteEnrollID() {
		return eEnrollID;
	}

	public void seteEnrollID(String eEnrollID) {
		this.eEnrollID = eEnrollID;
	}

	public String getMailReceipt() {
		return mailReceipt;
	}

	public void setMailReceipt(String mailReceipt) {
		this.mailReceipt = mailReceipt;
	}

	public String getSmsReceipt() {
		return smsReceipt;
	}

	public void setSmsReceipt(String smsReceipt) {
		this.smsReceipt = smsReceipt;
	}

	@Override
	public String toString() {
		return "ReceiptVO [receiptID=" + receiptID + ", rEnrollID=" + rEnrollID + ", issueDate=" + issueDate + ", issueID=" + issueID + ", receiptNO=" + receiptNO + ", eEnrollID="
				+ eEnrollID + ", mailReceipt=" + mailReceipt + ", smsReceipt=" + smsReceipt + "]";
	}

}
