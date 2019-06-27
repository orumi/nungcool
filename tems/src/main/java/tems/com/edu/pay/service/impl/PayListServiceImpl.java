package tems.com.edu.pay.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import tems.com.common.Criteria;
import tems.com.edu.common.model.AllChangeCodeVO;
import tems.com.edu.pay.model.PayMemberVO;
import tems.com.edu.pay.model.PayVO;
import tems.com.edu.pay.service.PayListService;

@Service("payListService")
public class PayListServiceImpl implements PayListService {

	@Resource(name = "payListDAO")
	private PayListDAO payListDAO;

	
	//결제대상 리스트
	@Override
	public List<PayMemberVO> listPayMember(Criteria cri) throws Exception {
	       
		return payListDAO.listPayMember(cri);
	}
	
	
	//결제대상 토탈 카운트
	@Override
	public int selectPayMemberTotCnt(Criteria cri) throws Exception {
		
		return payListDAO.selectPayMemberTotCnt(cri);
	}

	
	//결제리스트 일괄상태변경
	@Override
	public void updatePayStateAll(@RequestBody AllChangeCodeVO allChangeCodeVO) throws Exception {
		
		payListDAO.updatePayStateAll(allChangeCodeVO);
	}	
	
	//결제상태 변경
	@Override
	public void updatePayState(PayVO payVO) throws Exception {
		
		payListDAO.updatePayState(payVO);
		
	}
	
	
	//결제정보관리
	@Override
	public void updatePayInfo(PayVO payVO) throws Exception {
		
		payListDAO.updatePayInfo(payVO);
	}
	
	
	//결제관련
	@Override
	public PayVO selectPay(String enrollID) throws Exception {
	
		return payListDAO.selectPay(enrollID);
	}

	
	
	//환불대상 리스트
	@Override
	public List<PayMemberVO> listRefundMember(List<String> chkedList) throws Exception {
		
		return payListDAO.listRefundMember(chkedList);
	}

//	//환불대상 리스트
//	@Override
//	public List<PayMemberVO> listRefundMemberByApprID(String apprID) throws Exception {
//		
//		return payListDAO.listRefundMemberByApprID(apprID);
//	}
//	
}
