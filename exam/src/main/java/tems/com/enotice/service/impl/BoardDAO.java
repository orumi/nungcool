package tems.com.enotice.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.Criteria;
import tems.com.enotice.model.BoardVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("boardDAO")
public class BoardDAO extends EgovComAbstractDAO{

	//리스트
	public List<BoardVO> listBoard(Criteria cri) throws Exception {
		
		return (List<BoardVO>) list("boardDAO.listBoard",cri);
	}
	
	//토탈카운트
	public int selectBoardTotCnt (Criteria cri) throws Exception {
		return (Integer) select("boardDAO.selectBoardTotCnt",cri);
	}
	
	//읽기
	public BoardVO selectBoard(int bID) throws Exception {
		return (BoardVO) select("BoardDAO.selectBoard", bID);
	}
	
	
	//원글저장
	public int insertBoard(BoardVO boardVO) throws Exception {
	
		insert("boardDAO.insertBoard", boardVO);
		return boardVO.getbID(); // 등록된 글 키값
	}
	

	//답글저장
	public int insertReBoard(BoardVO boardVO) throws Exception {
			
		update("boardDAO.updateOrderby", boardVO);
		insert("boardDAO.insertReBoard", boardVO);

		return boardVO.getbID(); // 등록된 글 키값
	}
	
	
	//댓글 카운트
	public int selectReBoardCnt(int bID) throws Exception {

		return (Integer) select("boardDAO.selectReBoardCnt", bID);		
	}
	
	//글삭제
	public void deleteBoard(int bID) throws Exception {
		
		delete("boardDAO.deleteBoard", bID);
	}
	
}
