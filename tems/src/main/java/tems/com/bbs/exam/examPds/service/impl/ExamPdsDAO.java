package tems.com.bbs.exam.examPds.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.bbs.exam.examPds.model.BoardVO;
import tems.com.common.Criteria;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;




@Repository("examPdsDAO")
public class ExamPdsDAO extends EgovComAbstractDAO{

	//리스트
	public List<BoardVO> listBoard(Criteria cri) throws Exception {
		
		return (List<BoardVO>) list("examPdsDAO.listBoard",cri);
	}
	
	//토탈카운트
	public int selectBoardTotCnt (Criteria cri) throws Exception {
		return (Integer) select("examPdsDAO.selectBoardTotCnt",cri);
	}
	
	//읽기
	public BoardVO selectBoard(int bID) throws Exception {
		return (BoardVO) select("examPdsDAO.selectBoard", bID);
	}
	
	
	//원글저장
	public int insertBoard(BoardVO boardVO) throws Exception {
	    System.out.println(boardVO.getContent());
		insert("examPdsDAO.insertBoard", boardVO);
		return boardVO.getbID(); // 등록된 글 키값
	}
	

	//답글저장
	public int insertReBoard(BoardVO boardVO) throws Exception {
			
		update("examPdsDAO.updateOrderby", boardVO);
		insert("examPdsDAO.insertReBoard", boardVO);

		return boardVO.getbID(); // 등록된 글 키값
	}
	
	
	//댓글 카운트
	public int selectReBoardCnt(int bID) throws Exception {

		return (Integer) select("examPdsDAO.selectReBoardCnt", bID);		
	}
	
	//글삭제
	public void deleteBoard(int bID) throws Exception {
		
		delete("examPdsDAO.deleteBoard", bID);
	}
	
	//수정
	public int updateBoard(BoardVO boardVO) throws Exception {
		System.out.println("DAO");
		System.out.println(boardVO.toString());
		System.out.println("bID"+ boardVO.getbID()); 
		update("examPdsDAO.updateBoard", boardVO);
		return boardVO.getbID();
	}
}
