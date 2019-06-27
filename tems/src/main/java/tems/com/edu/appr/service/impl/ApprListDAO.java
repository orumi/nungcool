package tems.com.edu.appr.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import tems.com.common.Criteria;
import tems.com.edu.appr.model.CrtApprManagerVO;
import tems.com.edu.appr.model.ApprManagerVO;
import tems.com.edu.appr.model.ApprMemberVO;
import tems.com.edu.appr.model.ApprPaperVO;
import tems.com.edu.appr.model.ApprVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("apprListDAO")
public class ApprListDAO extends EgovComAbstractDAO {
	
	//내부결재대상 리스트
	public List<ApprMemberVO> listApprMember(List<String> chkedList) throws Exception {
		        
		return (List<ApprMemberVO>) list("apprListDAO.listApprMember", chkedList);
	}
	
	public ApprVO selectAppr(String apprID) throws Exception {
		return (ApprVO) select("apprListDAO.selectAppr", apprID);
	}
	
	
	public String insertAppr(ApprPaperVO apprPaperVO) throws Exception {

		insert("apprListDAO.insertAppr", apprPaperVO);
		return apprPaperVO.getApprID();
	}

	
	public void insertApprManager(ApprManagerVO apprManagerVO) throws Exception {
		
		insert("apprListDAO.insertApprManager", apprManagerVO);
	}

	public void insertApprMember(ApprMemberVO apprMemberVO) throws Exception {
		
		insert("apprListDAO.insertApprMember", apprMemberVO);
	}
	
	public List<ApprMemberVO> listApprMemberByApprID(String apprID) throws Exception {
		return (List<ApprMemberVO>) list("apprListDAO.listApprMemberByApprID", apprID);
	}
	
	public List<ApprManagerVO> listApprManager(String apprID) throws Exception {
		return (List<ApprManagerVO>) list("apprListDAO.listApprManager", apprID);
	}
	
	
	public List<ApprVO> listApprDraft(Criteria cri) throws Exception {
		System.out.println("다오"+ cri.toString());
		return (List<ApprVO>) list("apprListDAO.listApprDraft", cri);
	}
	
	public int selectApprDraftTotCnt(Criteria cri) throws Exception {
		return (Integer)select("apprListDAO.selectApprDraftTotCnt", cri);
	}
	
	
	public List<ApprVO> listApprAgree(Criteria cri) throws Exception {
		System.out.println("다오"+ cri.toString());
		return (List<ApprVO>) list("apprListDAO.listApprAgree", cri);
	}
	
	public int selectApprAgreeTotCnt(Criteria cri) throws Exception {
		return (Integer)select("apprListDAO.selectApprAgreeTotCnt", cri);
	}
	
	public void updateApprManagerState(Map mngStateMap) throws Exception {
		update("apprListDAO.updateApprManagerState", mngStateMap);
		
	}
	
	public CrtApprManagerVO selectCrtApprManager(Map crtMngMap) throws Exception {
		
		return (CrtApprManagerVO) select("apprListDAO.selectCrtApprManager", crtMngMap);
		
	}
	
	public void updateNextApprManagerState(Map nextMngStateMap) throws Exception {
		update("apprListDAO.updateNextApprManagerState", nextMngStateMap);
		
	}
	
	public void updateApprState(Map apprStateMap) throws Exception {
		update("apprListDAO.updateApprState", apprStateMap);
		
	}


	

	
}