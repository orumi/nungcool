package exam.com.community.pds.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import exam.com.common.Criteria;
import exam.com.community.pds.model.AttachFileVO;
import exam.com.community.pds.model.BoardVO;
import exam.com.community.pds.service.PdsService;


@Service("pdsService")
public class PdsServiceImpl implements PdsService {

	@Resource(name = "pdsDAO")
	private PdsDAO pdsDAO;
	
	
	//리스트
	@Override
	public List<BoardVO> listBoard(Criteria cri) throws Exception {
	
		return pdsDAO.listBoard(cri);
	}
	
	//토탈카운트
	@Override
	public int selectBoardTotCnt(Criteria cri) throws Exception {
		
		return pdsDAO.selectBoardTotCnt(cri);
	}

	//읽기
	@Override
	public BoardVO selectBoard(int bID) throws Exception {
		
		return pdsDAO.selectBoard(bID);
	}
	
	//첨부파일 리스트
	@Override
	public List<AttachFileVO> listAttachFile(int bID) throws Exception {
		return pdsDAO.listAttachFile(bID);
	}

}



