package exam.com.community.faq.model;

public class BoardVO {

	private int bID;
	private String regID;
	private String regDate;
	private String modifyID;
	private String modifyDate;
	private String title;
	private String content;
	private String writer;
	private int cnt;
	private int groupNO;
	private int depth;
	private int orderby;
	private int pID;
	
	
	public BoardVO() {
		this.cnt = 0;
		this.groupNO = 0;
		this.depth = 0;
		this.orderby = 0;
		this.pID = 0;
	}

	public int getbID() {
		return bID;
	}

	public void setbID(int bID) {
		this.bID = bID;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public int getGroupNO() {
		return groupNO;
	}

	public void setGroupNO(int groupNO) {
		this.groupNO = groupNO;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getOrderby() {
		return orderby;
	}

	public void setOrderby(int orderby) {
		this.orderby = orderby;
	}

	public int getpID() {
		return pID;
	}

	public void setpID(int pID) {
		this.pID = pID;
	}

	@Override
	public String toString() {
		return "BoardVO [bID=" + bID + ", regID=" + regID + ", regDate=" + regDate + ", modifyID=" + modifyID + ", modifyDate=" + modifyDate + ", title=" + title + ", content="
				+ content + ", writer=" + writer + ", cnt=" + cnt + ", groupNO=" + groupNO + ", depth=" + depth + ", orderby=" + orderby + ", pID=" + pID + ", getbID()="
				+ getbID() + ", getRegID()=" + getRegID() + ", getRegDate()=" + getRegDate() + ", getModifyID()=" + getModifyID() + ", getModifyDate()=" + getModifyDate()
				+ ", getTitle()=" + getTitle() + ", getContent()=" + getContent() + ", getWriter()=" + getWriter() + ", getCnt()=" + getCnt() + ", getGroupNO()=" + getGroupNO()
				+ ", getDepth()=" + getDepth() + ", getOrderby()=" + getOrderby() + ", getpID()=" + getpID() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}

}
