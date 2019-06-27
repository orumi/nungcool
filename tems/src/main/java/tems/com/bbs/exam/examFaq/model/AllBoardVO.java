package tems.com.bbs.exam.examFaq.model;

import java.util.List;

import tems.com.attachFile.model.AttachFileVO;

public class AllBoardVO {

	private BoardVO boardVO;
	private List<AttachFileVO> attachList;

	public BoardVO getBoardVO() {
		return boardVO;
	}

	public void setBoardVO(BoardVO boardVO) {
		this.boardVO = boardVO;
	}

	public List<AttachFileVO> getAttachList() {
		return attachList;
	}

	public void setAttachList(List<AttachFileVO> attachList) {
		this.attachList = attachList;
	}

	@Override
	public String toString() {
		return "AllBoardVO [boardVO=" + boardVO + ", attachList=" + attachList + ", getBoardVO()=" + getBoardVO() + ", getAttachList()=" + getAttachList() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}

}
