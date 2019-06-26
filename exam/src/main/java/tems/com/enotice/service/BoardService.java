package tems.com.enotice.service;

import java.util.List;

import tems.com.common.Criteria;
import tems.com.enotice.model.BoardVO;

public interface BoardService {

	//리스트
	public List<BoardVO> listBoard(Criteria cri) throws Exception ;
	
	//토탈카운트
	public int selectBoardTotCnt(Criteria cri) throws Exception ;
	
	//읽기
	public BoardVO selectBoard(int bID) throws Exception ;
	
	//저장
	public int insertBoard(BoardVO boardVO, List<Integer> fIDs) throws Exception ;
	
	//댓글수
	public int selectReBoardCnt(int bID) throws Exception ;
	
	//삭제
	public void deleteBoard(int bID) throws Exception ;
}
