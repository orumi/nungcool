package tems.com.edu.appr.service;

import java.util.List;

import tems.com.common.Criteria;
import tems.com.edu.appr.model.ApprManagerVO;
import tems.com.edu.appr.model.ApprMemberVO;
import tems.com.edu.appr.model.ApprPaperVO;
import tems.com.edu.appr.model.ApprVO;
import tems.com.edu.appr.model.CrtApprManagerVO;

public interface ApprListService {

	//내부결재대상 리스트
	public List<ApprMemberVO> listApprMember(List<String> chkedList) throws Exception;

	//결재문서 올리기
	public String insertAppr(ApprPaperVO apprPaperVO) throws Exception;
	
	//결재문서 가져오기
	public ApprVO selectAppr(String apprID) throws Exception;
	
	//문서별 결재대상 리스트 (보기페이지) 
	public List<ApprMemberVO> listApprMemberByApprID(String apprID) throws Exception;
	
	//결재선 가져오기
	public List<ApprManagerVO> listApprManager(String apprID) throws Exception;

	//올린 결재문서리스트
	public List<ApprVO> listApprDraft(Criteria cri) throws Exception;
	
	//올린 결재문서토탈카운트
	public int selectApprDraftTotCnt(Criteria cri) throws Exception ;
	
	//결재할 문서리스트
	public List<ApprVO> listApprAgree(Criteria cri) throws Exception;
	
	//결재할 문서토탈카운트
	public int selectApprAgreeTotCnt(Criteria cri) throws Exception ;

	public void updateAgreeOK(String apprID, String adminID)throws Exception ;
	
	public CrtApprManagerVO selectCrtApprManager(String apprID, String adminID) throws Exception;

	//반려	
	public void updateApprReject(ApprManagerVO apprManagerVO) throws Exception; 
	
	
	
	
}
