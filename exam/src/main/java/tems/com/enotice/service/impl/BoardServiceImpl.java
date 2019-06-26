package tems.com.enotice.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tems.com.attachFile.service.impl.AttachFileDAO;
import tems.com.common.Criteria;
import tems.com.enotice.model.BoardVO;
import tems.com.enotice.service.BoardService;


@Service("boardService")
public class BoardServiceImpl implements BoardService{

	@Resource(name = "boardDAO")
	private BoardDAO boardDAO;
	
	@Resource(name = "attachFileDAO")
	private AttachFileDAO attachFileDAO;
	
	
	//리스트
	@Override
	public List<BoardVO> listBoard(Criteria cri) throws Exception {
	
		return boardDAO.listBoard(cri);
	}
	
	//토탈카운트
	@Override
	public int selectBoardTotCnt(Criteria cri) throws Exception {
		
		return boardDAO.selectBoardTotCnt(cri);
	}

	//읽기
	@Override
	public BoardVO selectBoard(int bID) throws Exception {
		
		return boardDAO.selectBoard(bID);
	}


	//저장
	@Override
	public int insertBoard(BoardVO boardVO, List<Integer> fIDs) throws Exception {
		int bID ;
		
		if (boardVO.getbID() > 0) { //답글일때 저장
			bID = boardDAO.insertReBoard(boardVO);
		}
		else { //원글일때 저장
			bID = boardDAO.insertBoard(boardVO);
		}
		
		if(fIDs ==  null){ // 첨부파일 있을때
			//첨부파일에 bID업데이트
			System.out.println("파일없음");
		}
		else{
			System.out.println("파일있음:"+ fIDs.size());
		}
		return bID;
	}
	
	
	//댓글수 체크
	@Override
	public int selectReBoardCnt(int bID) throws Exception {
		
		return boardDAO.selectReBoardCnt(bID);
	}
	
	//삭제
	@Transactional
	@Override
	public void deleteBoard(int bID) throws Exception {

		boardDAO.deleteBoard(bID);  //글 삭제
		attachFileDAO.deleteAttachFileByBID(bID); //첨부파일 삭제
	}
	
}
