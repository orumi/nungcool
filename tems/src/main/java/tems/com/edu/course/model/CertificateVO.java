package tems.com.edu.course.model;

public class CertificateVO {

	private String certificateID;
	private String cEnrollID;
	private String certificateNO;
	private String issueDate;
	private String issueID;

	private String eEnrollID;
	private String mailCertificate;
	private String smsCertificate;
	private String certificateIssue;

	
	public String getCertificateID() {
		return certificateID;
	}

	public void setCertificateID(String certificateID) {
		this.certificateID = certificateID;
	}

	public String getcEnrollID() {
		return cEnrollID;
	}

	public void setcEnrollID(String cEnrollID) {
		this.cEnrollID = cEnrollID;
	}

	public String getCertificateNO() {
		return certificateNO;
	}

	public void setCertificateNO(String certificateNO) {
		this.certificateNO = certificateNO;
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

	public String geteEnrollID() {
		return eEnrollID;
	}

	public void seteEnrollID(String eEnrollID) {
		this.eEnrollID = eEnrollID;
	}

	public String getMailCertificate() {
		return mailCertificate;
	}

	public void setMailCertificate(String mailCertificate) {
		this.mailCertificate = mailCertificate;
	}

	public String getSmsCertificate() {
		return smsCertificate;
	}

	public void setSmsCertificate(String smsCertificate) {
		this.smsCertificate = smsCertificate;
	}

	public String getCertificateIssue() {
		return certificateIssue;
	}

	public void setCertificateIssue(String certificateIssue) {
		this.certificateIssue = certificateIssue;
	}

	@Override
	public String toString() {
		return "CertificateVO [certificateID=" + certificateID + ", cEnrollID=" + cEnrollID + ", certificateNO=" + certificateNO + ", issueDate=" + issueDate + ", issueID="
				+ issueID + ", eEnrollID=" + eEnrollID + ", mailCertificate=" + mailCertificate + ", smsCertificate=" + smsCertificate + ", certificateIssue=" + certificateIssue
				+ "]";
	}

}
