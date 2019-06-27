package tems.com.edu.appr.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tems.com.common.Criteria;
import tems.com.edu.appr.model.ApprManagerVO;
import tems.com.edu.appr.model.ApprMemberVO;
import tems.com.edu.appr.model.ApprPaperVO;
import tems.com.edu.appr.model.ApprVO;
import tems.com.edu.appr.model.CrtApprManagerVO;
import tems.com.edu.appr.service.ApprListService;
import tems.com.edu.course.model.CertificateVO;
import tems.com.edu.course.model.ReceiptVO;
import tems.com.edu.course.service.impl.CourseListDAO;
import tems.com.edu.pay.model.PayVO;
import tems.com.edu.pay.service.impl.PayListDAO;

@Service("apprListService")
public class ApprListServiceImpl implements ApprListService {

	@Resource(name = "apprListDAO")
	private ApprListDAO apprListDAO;
	
	@Resource(name = "courseListDAO")
	private CourseListDAO courseListDAO;
	
	@Resource(name = "payListDAO")
	private PayListDAO payListDAO; 
	

	//내부결재대상 리스트
	@Override
	public List<ApprMemberVO> listApprMember(List<String> chkedList) throws Exception {
		
		return apprListDAO.listApprMember(chkedList) ;
	}
	
	//결재문서 등록
	@Transactional
	@Override
	public String insertAppr(ApprPaperVO apprPaperVO) throws Exception {
		//결재문서등록
		// - 메인문서등록, 결재선등록, 대상학생정보 복사
		
		//1)결재문서등록
		//결재자준비
		String cosID = apprPaperVO.getCosID();
		String draftID = apprPaperVO.getDraftID();
		String firstID = apprPaperVO.getFirstID();
		String secondID = apprPaperVO.getSecondID();
		String thirdID = apprPaperVO.getThirdID();
		String fourthID = apprPaperVO.getFourthID();
		String apprID ; 
		int maxOrdinal ;
		
		//결재선 대상 객체 준비(리스트)
		List<ApprManagerVO> apprManagerList = new ArrayList<ApprManagerVO>();
		
		if(!firstID.isEmpty()){
			ApprManagerVO apprManagerVO = new ApprManagerVO(); 
			apprManagerVO.setAdminID(firstID);
			apprManagerVO.setOrdinal("1");
			apprManagerVO.setApprState("H");
			apprManagerList.add(apprManagerVO);
			System.out.println(apprManagerList.toString());
		}
		if(!secondID.isEmpty()){
			ApprManagerVO apprManagerVO = new ApprManagerVO(); 
			apprManagerVO.setAdminID(secondID);
			apprManagerVO.setOrdinal("2");
			apprManagerVO.setApprState("S");
			apprManagerList.add(apprManagerVO);
			System.out.println(apprManagerList.toString());
		}
		if(!thirdID.isEmpty()){
			ApprManagerVO apprManagerVO = new ApprManagerVO(); 
			apprManagerVO.setAdminID(thirdID);
			apprManagerVO.setOrdinal("3");
			apprManagerVO.setApprState("S");
			apprManagerList.add(apprManagerVO);
			System.out.println(apprManagerList.toString());
		}
		if(!fourthID.isEmpty()){
			ApprManagerVO apprManagerVO = new ApprManagerVO(); 
			apprManagerVO.setAdminID(fourthID);
			apprManagerVO.setOrdinal("4");
			apprManagerVO.setApprState("S");
			System.out.println(apprManagerList.toString());
			apprManagerList.add(apprManagerVO);
		}
		
		
		maxOrdinal = apprManagerList.size();
		apprPaperVO.setMaxOrdinal(maxOrdinal);
		apprPaperVO.setApprState("I");
		
		//결재문서저장
		apprID = apprListDAO.insertAppr(apprPaperVO);
		
		//결재선에 apprID 저장
		for (int i = 0; i < apprManagerList.size(); i++) {
			apprManagerList.get(i).setApprID(apprID);
		}
		
		//결재선 저장
		for (ApprManagerVO apprManagerVO : apprManagerList) {
			apprListDAO.insertApprManager(apprManagerVO);
		}
		
		//대상학생정보 복사
		List<ApprMemberVO> apprMemberList = apprListDAO.listApprMember(apprPaperVO.getMemberList());
		for (ApprMemberVO apprMemberVO : apprMemberList) {
			apprMemberVO.setApprID(apprID);
			apprListDAO.insertApprMember(apprMemberVO);
		}
		
		return apprID;
		
	}
	
	//결재문서 보기
	@Override
	public ApprVO selectAppr(String apprID) throws Exception {
		//결재문서 가져오기
		return apprListDAO.selectAppr(apprID);
	}

	
	//문서별 결재대상 리스트 (보기페이지) 
	@Override
	public List<ApprMemberVO> listApprMemberByApprID(String apprID) throws Exception {
	
		return apprListDAO.listApprMemberByApprID(apprID);
	}
	
	//결재선 가져오기
	@Override
	public List<ApprManagerVO> listApprManager(String apprID) throws Exception {
		
		return apprListDAO.listApprManager(apprID);
	}
	
	//자신이 올린 결재문서리스트
	@Override
	public List<ApprVO> listApprDraft(Criteria cri) throws Exception {
		
		return apprListDAO.listApprDraft(cri);
	}
	
	//자신이 올린 결재문서 토탈 카운트
	@Override
	public int selectApprDraftTotCnt(Criteria cri) throws Exception {
		
		return apprListDAO.selectApprDraftTotCnt(cri);
	}

	
	//결재할 결재문서리스트
	@Override
	public List<ApprVO> listApprAgree(Criteria cri) throws Exception {
		
		return apprListDAO.listApprAgree(cri);
	}
	
	//결재할 결재문서 토탈 카운트
	@Override
	public int selectApprAgreeTotCnt(Criteria cri) throws Exception {
		
		return apprListDAO.selectApprAgreeTotCnt(cri);
	}

	
	//결재OK
	@Transactional
	@Override
	public void updateAgreeOK(String apprID, String adminID)throws Exception {
		HashMap<String, Object> crtMngMap = new HashMap<String, Object>();
		
		crtMngMap.put("apprID", apprID);
		crtMngMap.put("adminID", adminID);

		//현재 결재자 정보
		CrtApprManagerVO crtApprManagerVO =  apprListDAO.selectCrtApprManager(crtMngMap);
		System.out.println(crtApprManagerVO.toString());
		int apprMngID = Integer.parseInt(crtApprManagerVO.getApprMngID());
		int maxOrdinal = Integer.parseInt(crtApprManagerVO.getMaxOrdinal());
		int myOrdinal = Integer.parseInt(crtApprManagerVO.getMyOrdinal());
		
		//자신의 결재상태를 C(Complete)로 변경
		Map<String, Object> mngStateMap = new HashMap<String, Object>();
		
		mngStateMap.put("apprMngID", apprMngID);
		mngStateMap.put("apprState", "C");
		
		apprListDAO.updateApprManagerState(mngStateMap);
		
		
	    //다음 결재자가 있으면 다음 결재자의 상태값 변경
		if(myOrdinal < maxOrdinal ){
			HashMap<String, Object> nextMngStateMap = new HashMap<String, Object>();
			nextMngStateMap.put("apprID", apprID);
			nextMngStateMap.put("myOrdinal", myOrdinal+1 );
			nextMngStateMap.put("apprState", "H" );
			
			apprListDAO.updateNextApprManagerState(nextMngStateMap);
		}
		
		//다음 결재자가 없으면 전체 결재상태 완료, 접수증 발급 등 후처리
		else {
			HashMap<String, Object> apprStateMap = new HashMap<String, Object>();
			apprStateMap.put("apprID", apprID);
			apprStateMap.put("apprState", "C" );
			
			//전체 결재상태 완료
			apprListDAO.updateApprState(apprStateMap);
			
			
			//////////////////////////////////////////////////////////////////////////
			// 최종 결재후 처리(각종 증명서 발급)
			//////////////////////////////////////////////////////////////////////////
			//결재 타입 조회
			String apprTypeID = apprListDAO.selectAppr(apprID).getApprTypeID();
			
			//접수증 일때: 접수증 발급
			if(apprTypeID.equals("RECEIPT")){
				//apprID로 enrollID 리스트 가져올것
				List<ApprMemberVO> apprMemberList = apprListDAO.listApprMemberByApprID(apprID);
				System.out.println(apprMemberList.toString());
				
				for (ApprMemberVO apprMember : apprMemberList) {
					String enrollID = apprMember.getEnrollID();
					
					ReceiptVO receiptVO = new ReceiptVO();
					receiptVO.setrEnrollID(enrollID);
					receiptVO.setIssueID(adminID);
					
					//접수증이 발급되지 않은 경우에만 발급
					int receiptCnt = courseListDAO.selectReceiptCntByID(enrollID);
					if(receiptCnt == 0){
						courseListDAO.insertReceipt(receiptVO);
					}
				}//.for
			}
			
			//수료증일때: 수료증 발급
			if(apprTypeID.equals("CERTIFI")){
				//발급대상을 가져옴
				List<ApprMemberVO> apprMemberList = apprListDAO.listApprMemberByApprID(apprID);
				System.out.println(apprMemberList.toString());
				
				for (ApprMemberVO apprMember : apprMemberList) {
					String enrollID = apprMember.getEnrollID();
					String passID = apprMember.getPassID();
					
					//수료자만 수료증 발급
					if(passID.equals("1")){//수료자
						CertificateVO certificateVO = new CertificateVO();
						certificateVO.setcEnrollID(enrollID);
						certificateVO.setIssueID(adminID);
						
						//수료증이 발급되지 않은 경우에만 발급
						int certifiCateCnt = courseListDAO.selectCertificateCntByID(enrollID);
						if(certifiCateCnt == 0){
							courseListDAO.insertCertificate(certificateVO);
						}
						
					}//.if
					
				}//.for
			}//.if
			
			//환불일때: 결재상태값 변경
			if(apprTypeID.equals("REFUND")){
				//발급대상을 가져옴
				List<ApprMemberVO> apprMemberList = apprListDAO.listApprMemberByApprID(apprID);
				System.out.println(apprMemberList.toString());
				
				for (ApprMemberVO apprMember : apprMemberList) {
					String enrollID = apprMember.getEnrollID();
			
					//결제상태를 환불처리중(4) 으로 변경해줌
					PayVO payVO = new PayVO();
					payVO.setEnrollID(enrollID);
					payVO.setPayState("4");
					payListDAO.updatePayState(payVO);
					
				}//.for
				
			}//.if
	
		}//.else
	}	

	
	
	//현재결재자 정보가져오기
	@Override
	public CrtApprManagerVO selectCrtApprManager(String apprID, String adminID) throws Exception {
		HashMap<String, Object> crtMngMap = new HashMap<String, Object>();
		
		crtMngMap.put("apprID", apprID);
		crtMngMap.put("adminID", adminID);
		return apprListDAO.selectCrtApprManager(crtMngMap);
		
	}
	
	
	//반려
	public void updateApprReject(ApprManagerVO apprManagerVO) throws Exception {
		
		String apprID = apprManagerVO.getApprID();
		String adminID = apprManagerVO.getAdminID();
		String memo = apprManagerVO.getMemo();

		HashMap<String, Object> crtMngMap = new HashMap<String, Object>();
		
		crtMngMap.put("apprID", apprID);
		crtMngMap.put("adminID", adminID);
		
		//현재 결재자 정보
		CrtApprManagerVO crtApprManagerVO =  apprListDAO.selectCrtApprManager(crtMngMap);
		int apprMngID = Integer.parseInt(crtApprManagerVO.getApprMngID());		
		
		//자신의 결재상태를 R로 변경
		Map<String, Object> mngStateMap = new HashMap<String, Object>();
		mngStateMap.put("apprMngID", apprMngID);
		mngStateMap.put("apprState", "R");
		mngStateMap.put("memo", "memo");
		apprListDAO.updateApprManagerState(mngStateMap);
		

		//전체 결재상태를  R로 변경
		HashMap<String, Object> apprStateMap = new HashMap<String, Object>();
		apprStateMap.put("apprID", apprID);
		apprStateMap.put("apprState", "R" );
		
		//전체 결재상태 완료
		apprListDAO.updateApprState(apprStateMap);

	} 
	
	
	
	
	
}
