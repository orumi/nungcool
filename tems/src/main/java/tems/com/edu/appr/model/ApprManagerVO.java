package tems.com.edu.appr.model;

public class ApprManagerVO {

	private String apprMngID;
	private String apprID;
	private String adminID;
	private String name;
	private String ordinal;
	private String apprState;
	private String apprDate;
	private String memo;

	public String getApprMngID() {
		return apprMngID;
	}

	public void setApprMngID(String apprMngID) {
		this.apprMngID = apprMngID;
	}

	public String getApprID() {
		return apprID;
	}

	public void setApprID(String apprID) {
		this.apprID = apprID;
	}

	public String getAdminID() {
		return adminID;
	}

	public void setAdminID(String adminID) {
		this.adminID = adminID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOrdinal() {
		return ordinal;
	}

	public void setOrdinal(String ordinal) {
		this.ordinal = ordinal;
	}

	public String getApprState() {
		return apprState;
	}

	public void setApprState(String apprState) {
		this.apprState = apprState;
	}

	public String getApprDate() {
		return apprDate;
	}

	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	@Override
	public String toString() {
		return "ApprManagerVO [apprMngID=" + apprMngID + ", apprID=" + apprID + ", adminID=" + adminID + ", name=" + name + ", ordinal=" + ordinal + ", apprState=" + apprState
				+ ", apprDate=" + apprDate + ", memo=" + memo + "]";
	}

}
