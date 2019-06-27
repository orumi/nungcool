package tems.com.edu.pay.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.Criteria;
import tems.com.edu.common.model.AllChangeCodeVO;
import tems.com.edu.pay.model.PayMemberVO;
import tems.com.edu.pay.model.PayVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("payListDAO")
public class PayListDAO extends EgovComAbstractDAO {
	
	//결제대상 리스트
	public List<PayMemberVO> listPayMember(Criteria cri) throws Exception {
		        
		return (List<PayMemberVO>) list("payListDAO.listPayMember", cri);
	}

	//결제대상 토탈 카운트
	public int selectPayMemberTotCnt(Criteria cri) throws Exception {
		
		return (Integer) select("payListDAO.selectPayMemberTotCnt", cri);
	}
	
	
	//결제상태 변경
	public void updatePayState(PayVO payVO) throws Exception {
		update("payListDAO.updatePayState", payVO);
	}
	
	
	//결제리스트 일괄상태변경
	public void updatePayStateAll(AllChangeCodeVO allChangeCodeVO) throws Exception {
		
		update("payListDAO.updatePayStateAll", allChangeCodeVO);
	}	
	
	
	//결제정보관리
	public void updatePayInfo(PayVO payVO) throws Exception {
		System.out.println("updatePayInfo: " + payVO.toString());
		update("payListDAO.updatePayInfo", payVO);
	}
	

	//결제관련
	public PayVO selectPay(String enrollID) throws Exception {
			
		return (PayVO)select("payListDAO.selectPay", enrollID);
	}
	
	
	//환불대상 리스트
	public List<PayMemberVO> listRefundMember(List<String> chkedList) throws Exception {
		System.out.println("++++++++++++++++++++++++++++++++++++++++++++++");
		System.out.println(chkedList.toString());
		return (List<PayMemberVO>)list("payListDAO.listRefundMember",chkedList);
	}

//	//환불대상 리스트
//	public List<PayMemberVO> listRefundMemberByApprID(String apprID) {
//		
//		return (List<PayMemberVO>)list("payListDAO.listRefundMember",apprID);
//	}
	
	
}