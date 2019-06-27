package tems.com.edu.course.model;

public class EstimateVO {
	private String estimateID;
	private String enrollID;
	private String issueDate;
	private String issueID;

	public String getEstimateID() {
		return estimateID;
	}

	public void setEstimateID(String estimateID) {
		this.estimateID = estimateID;
	}

	public String getEnrollID() {
		return enrollID;
	}

	public void setEnrollID(String enrollID) {
		this.enrollID = enrollID;
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

	@Override
	public String toString() {
		return "EstimateVO [estimateID=" + estimateID + ", enrollID=" + enrollID + ", issueDate=" + issueDate + ", issueID=" + issueID + "]";
	}

}
