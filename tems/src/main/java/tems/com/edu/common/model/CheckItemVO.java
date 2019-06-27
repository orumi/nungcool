package tems.com.edu.common.model;

import java.util.List;

public class CheckItemVO {

	private int cosID;
	private List<Integer> chkedList;

	public int getCosID() {
		return cosID;
	}

	public void setCosID(int cosID) {
		this.cosID = cosID;
	}

	public List<Integer> getChkedList() {
		return chkedList;
	}

	public void setChkedList(List<Integer> chkedList) {
		this.chkedList = chkedList;
	}

	@Override
	public String toString() {
		return "CheckItemVO [cosID=" + cosID + ", chkedList=" + chkedList + ", getCosID()=" + getCosID() + ", getChkedList()=" + getChkedList() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}

	
}
