package tems.com.edu.pay.service;

import java.util.List;

import org.springframework.web.bind.annotation.RequestBody;

import tems.com.common.Criteria;
import tems.com.edu.common.model.AllChangeCodeVO;
import tems.com.edu.pay.model.PayMemberVO;
import tems.com.edu.pay.model.PayVO;

public interface PayListService {

	//결제대상 리스트
	public List<PayMemberVO> listPayMember(Criteria cri) throws Exception ;
	
	//결제대상 토탈 카운트
	public int selectPayMemberTotCnt(Criteria cri) throws Exception ;
	
	//결제리스트 일괄상태변경
	public void updatePayStateAll(@RequestBody AllChangeCodeVO allChangeCodeVO) throws Exception ;
	
	//결제상태 변경
	public void updatePayState(PayVO payVO) throws Exception ;
	
	
	
	//결제정보관리
	public void updatePayInfo(PayVO payVO) throws Exception ; 

	
	//결제관련
	public PayVO selectPay(String enrollID) throws Exception ;
	
	//환불대상 리스트
	public List<PayMemberVO> listRefundMember(List<String> chkedList) throws Exception;

//	//환불대상 리스트
//	public List<PayMemberVO> listRefundMemberByApprID(String apprID) throws Exception;
}

