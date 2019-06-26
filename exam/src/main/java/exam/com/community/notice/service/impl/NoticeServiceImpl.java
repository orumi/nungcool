package exam.com.community.notice.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import exam.com.common.Criteria;
import exam.com.community.notice.model.AttachFileVO;
import exam.com.community.notice.model.BoardVO;
import exam.com.community.notice.service.NoticeService;


@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {

	@Resource(name = "noticeDAO")
	private NoticeDAO noticeDAO;
	
	
	//리스트
	@Override
	public List<BoardVO> listBoard(Criteria cri) throws Exception {
	
		return noticeDAO.listBoard(cri);
	}
	
	//토탈카운트
	@Override
	public int selectBoardTotCnt(Criteria cri) throws Exception {
		
		return noticeDAO.selectBoardTotCnt(cri);
	}

	//읽기
	@Override
	public BoardVO selectBoard(int bID) throws Exception {
		
		return noticeDAO.selectBoard(bID);
	}
	
	//첨부파일 리스트
	@Override
	public List<AttachFileVO> listAttachFile(int bID) throws Exception {
		return noticeDAO.listAttachFile(bID);
	}

}



