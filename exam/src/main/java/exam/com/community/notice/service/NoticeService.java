package exam.com.community.notice.service;

import java.util.List;

import exam.com.common.Criteria;
import exam.com.community.notice.model.AttachFileVO;
import exam.com.community.notice.model.BoardVO;


public interface NoticeService {

	//리스트
	public List<BoardVO> listBoard(Criteria cri) throws Exception ;
	
	//토탈카운트
	public int selectBoardTotCnt(Criteria cri) throws Exception ;
	
	//읽기
	public BoardVO selectBoard(int bID) throws Exception ;
	
	//첨부파일 리스트
	public List<AttachFileVO> listAttachFile(int bID) throws Exception;
}

