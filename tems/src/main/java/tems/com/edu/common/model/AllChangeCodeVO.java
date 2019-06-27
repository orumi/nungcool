package tems.com.edu.common.model;

import java.util.Arrays;

public class AllChangeCodeVO {

	private String codeID;
	private String codeName;
	private String[] chkedList;
	private String adminID;

	public String getCodeID() {
		return codeID;
	}

	public void setCodeID(String codeID) {
		this.codeID = codeID;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	public String[] getChkedList() {
		return chkedList;
	}

	public void setChkedList(String[] chkedList) {
		this.chkedList = chkedList;
	}

	public String getAdminID() {
		return adminID;
	}

	public void setAdminID(String adminID) {
		this.adminID = adminID;
	}

	@Override
	public String toString() {
		return "AllChangeCode [codeID=" + codeID + ", codeName=" + codeName + ", chkedList=" + Arrays.toString(chkedList) + ", adminID=" + adminID + "]";
	}

}
