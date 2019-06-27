package tems.com.edu.course.model;

public class GradeVO {

	private String gradeID;
	private String enrollID;
	private String pass;
	private String score;
	private String regDate;
	private String regID;
	private String modifyDate;
	private String modifyID;

	private String adminID;
	private String cosID;

	public String getGradeID() {
		return gradeID;
	}

	public void setGradeID(String gradeID) {
		this.gradeID = gradeID;
	}

	public String getEnrollID() {
		return enrollID;
	}

	public void setEnrollID(String enrollID) {
		this.enrollID = enrollID;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getModifyID() {
		return modifyID;
	}

	public void setModifyID(String modifyID) {
		this.modifyID = modifyID;
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
		return "GradeVO [gradeID=" + gradeID + ", enrollID=" + enrollID + ", pass=" + pass + ", score=" + score + ", regDate=" + regDate + ", regID=" + regID + ", modifyDate="
				+ modifyDate + ", modifyID=" + modifyID + ", adminID=" + adminID + ", cosID=" + cosID + "]";
	}

}
