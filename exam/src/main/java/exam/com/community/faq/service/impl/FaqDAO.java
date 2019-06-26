package exam.com.community.faq.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import exam.com.common.Criteria;
import exam.com.community.faq.model.AttachFileVO;
import exam.com.community.faq.model.BoardVO;



@Repository("faqDAO")
public class FaqDAO extends EgovComAbstractDAO{

	//리스트
	public List<BoardVO> listBoard(Criteria cri) throws Exception {
		
		return (List<BoardVO>) list("faqDAO.listBoard",cri);
	}
	
	//토탈카운트
	public int selectBoardTotCnt (Criteria cri) throws Exception {
		return (Integer) select("faqDAO.selectBoardTotCnt",cri);
	}
	
	//읽기
	public BoardVO selectBoard(int bID) throws Exception {
		return (BoardVO) select("faqDAO.selectBoard", bID);
	}
	
	
	//첨부파일리스트
	public List<AttachFileVO> listAttachFile(int bID) throws Exception {
		return (List<AttachFileVO>) list("faqDAO.listAttachFile", bID);
	}
	
}