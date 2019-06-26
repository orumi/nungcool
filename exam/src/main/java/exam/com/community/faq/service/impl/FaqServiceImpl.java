package exam.com.community.faq.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import exam.com.common.Criteria;
import exam.com.community.faq.model.AttachFileVO;
import exam.com.community.faq.model.BoardVO;
import exam.com.community.faq.service.FaqService;




@Service("faqService")
public class FaqServiceImpl implements FaqService {

	@Resource(name = "faqDAO")
	private FaqDAO faqDAO;
	
	
	//리스트
	@Override
	public List<BoardVO> listBoard(Criteria cri) throws Exception {
	
		return faqDAO.listBoard(cri);
	}
	
	//토탈카운트
	@Override
	public int selectBoardTotCnt(Criteria cri) throws Exception {
		
		return faqDAO.selectBoardTotCnt(cri);
	}

	//읽기
	@Override
	public BoardVO selectBoard(int bID) throws Exception {
		
		return faqDAO.selectBoard(bID);
	}
	
	//첨부파일 리스트
	@Override
	public List<AttachFileVO> listAttachFile(int bID) throws Exception {
		return faqDAO.listAttachFile(bID);
	}

}



