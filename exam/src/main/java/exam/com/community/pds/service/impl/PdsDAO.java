package exam.com.community.pds.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import exam.com.common.Criteria;
import exam.com.community.pds.model.AttachFileVO;
import exam.com.community.pds.model.BoardVO;



@Repository("pdsDAO")
public class PdsDAO extends EgovComAbstractDAO{

	//리스트
	public List<BoardVO> listBoard(Criteria cri) throws Exception {
		
		return (List<BoardVO>) list("pdsDAO.listBoard",cri);
	}
	
	//토탈카운트
	public int selectBoardTotCnt (Criteria cri) throws Exception {
		return (Integer) select("pdsDAO.selectBoardTotCnt",cri);
	}
	
	//읽기
	public BoardVO selectBoard(int bID) throws Exception {
		return (BoardVO) select("pdsDAO.selectBoard", bID);
	}
	
	
	//첨부파일리스트
	public List<AttachFileVO> listAttachFile(int bID) throws Exception {
		return (List<AttachFileVO>) list("pdsDAO.listAttachFile", bID);
	}
	
}