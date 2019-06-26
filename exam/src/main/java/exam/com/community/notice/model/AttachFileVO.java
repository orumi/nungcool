package exam.com.community.notice.model;


public class AttachFileVO {

	private int fID;
	private int bID;
	private String filePath;
	private String orgName;
	private String saveName;
	private long fileSize;
	private String regID;
	private String regDate;
	private String boardName;

	public int getfID() {
		return fID;
	}

	public void setfID(int fID) {
		this.fID = fID;
	}

	public int getbID() {
		return bID;
	}

	public void setbID(int bID) {
		this.bID = bID;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		
		this.filePath = filePath;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		
		
		this.orgName = orgName;
	}

	public String getSaveName() {
		return saveName;
	}

	public void setSaveName(String saveName) {
		
		this.saveName = saveName;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
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

	public String getBoardName() {
		return boardName;
	}

	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}

	@Override
	public String toString() {
		return "AttachFileVO [fID=" + fID + ", bID=" + bID + ", filePath=" + filePath + ", orgName=" + orgName + ", saveName=" + saveName + ", fileSize=" + fileSize + ", regID="
				+ regID + ", regDate=" + regDate + ", boardName=" + boardName + "]";
	}

}
