package tems.com.bbs.exam.examPds.service;

import java.util.List;

import tems.com.bbs.exam.examPds.model.AllBoardVO;
import tems.com.bbs.exam.examPds.model.BoardVO;
import tems.com.common.Criteria;



public interface ExamPdsService {

	//리스트
		public List<BoardVO> listBoard(Criteria cri) throws Exception ;
		
		//토탈카운트
		public int selectBoardTotCnt(Criteria cri) throws Exception ;
		
		//읽기
		public BoardVO selectBoard(int bID) throws Exception ;
		
		//저장
		public int insertBoard(AllBoardVO allBoardVO) throws Exception ;
		
		//댓글수
		public int selectReBoardCnt(int bID) throws Exception ;
		
		//삭제
		public void deleteBoard(int bID) throws Exception ;

		//수정
		public int updateBoard(AllBoardVO allBoardVO) throws Exception ;
		
}
