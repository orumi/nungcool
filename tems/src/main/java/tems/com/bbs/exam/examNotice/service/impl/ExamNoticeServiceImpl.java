package tems.com.bbs.exam.examNotice.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tems.com.attachFile.model.AttachFileVO;
import tems.com.attachFile.service.impl.AttachFileDAO;
import tems.com.bbs.exam.examNotice.model.AllBoardVO;
import tems.com.bbs.exam.examNotice.model.BoardVO;
import tems.com.bbs.exam.examNotice.service.ExamNoticeService;
import tems.com.common.Criteria;

@Service("examNoticeService")
public class ExamNoticeServiceImpl implements ExamNoticeService {

	@Resource(name = "examNoticeDAO")
	private ExamNoticeDAO examNoticeDAO;

	@Resource(name = "attachFileDAO")
	private AttachFileDAO attachFileDAO;

	//리스트
	@Override
	public List<BoardVO> listBoard(Criteria cri) throws Exception {

		return examNoticeDAO.listBoard(cri);
	}

	//토탈카운트
	@Override
	public int selectBoardTotCnt(Criteria cri) throws Exception {

		return examNoticeDAO.selectBoardTotCnt(cri);
	}

	//읽기
	@Override
	public BoardVO selectBoard(int bID) throws Exception {

		return examNoticeDAO.selectBoard(bID);
	}

	//저장
	@Transactional
	@Override
	public int insertBoard(AllBoardVO allBoardVO) throws Exception {

		BoardVO boardVO = allBoardVO.getBoardVO();
		int bID;
		int fileCnt = allBoardVO.getAttachList().size();

		if (boardVO.getbID() > 0) { //답글일때 저장
			bID = examNoticeDAO.insertReBoard(boardVO);
		} else { //원글일때 저장
			bID = examNoticeDAO.insertBoard(boardVO);
		}

		if (fileCnt == 0) { // 첨부파일 없을때
			//첨부파일에 bID업데이트
			System.out.println("파일없음");
		} else {

			System.out.println("파일있음:" + fileCnt);
			for (int i = 0; i < fileCnt; i++) {
				AttachFileVO attachFileVO = allBoardVO.getAttachList().get(i);
				attachFileVO.setbID(bID);
				attachFileDAO.uploadAttachFile(attachFileVO);
			}
		}
		return bID;
	}

	//댓글수 체크
	@Override
	public int selectReBoardCnt(int bID) throws Exception {

		return examNoticeDAO.selectReBoardCnt(bID);
	}

	//삭제
	@Transactional
	@Override
	public void deleteBoard(int bID) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("bID", bID);
		map.put("boardName", "examNotice");

		examNoticeDAO.deleteBoard(bID); //글 삭제
		attachFileDAO.deleteAttachFileByBID(map); //첨부파일 삭제
	}

	//수정
	@Transactional
	@Override
	public int updateBoard(AllBoardVO allBoardVO) throws Exception {
		BoardVO boardVO = allBoardVO.getBoardVO();
		int bID = boardVO.getbID();
		int fileCnt = allBoardVO.getAttachList().size();

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("bID", bID);
		map.put("boardName", "examNotice");

		System.out.println("서비스");
		System.out.println(boardVO.toString());
		examNoticeDAO.updateBoard(boardVO);

		attachFileDAO.deleteAttachFileByBID(map);

		for (int i = 0; i < fileCnt; i++) {
			AttachFileVO attachFileVO = allBoardVO.getAttachList().get(i);
			attachFileVO.setbID(bID);
			attachFileVO.setBoardName("examNotice");
			attachFileDAO.uploadAttachFile(attachFileVO);
		}

		return bID;
	}

}
