package tems.com.exam.cooperation.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.model.SearchVO;
import tems.com.exam.cooperation.model.CooperReqDetailVO;
import tems.com.exam.cooperation.model.CooperationRejectVO;
import tems.com.exam.issue.model.RejectResultVO;
import tems.com.exam.result.model.CoopApprVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CooperationListDAO")
public class CooperationListDAO extends EgovComAbstractDAO {
	
	public List<?> getCooperationList(SearchVO searchVO){
		return list("CooperationDAO.getCooperationList",searchVO);
	}
	
	public void upCooperApproval(CoopApprVO coopApprVO){
		update("CooperationDAO.upCooperApproval",coopApprVO);
	}
	
	public void upCooperApprovalNext(CoopApprVO coopApprVO){
		update("CooperationDAO.upCooperApprovalNext",coopApprVO);
	}
	
	public void upCooperApprovalReq(CoopApprVO coopApprVO){
		update("CooperationDAO.upCooperApprovalReq",coopApprVO);
	}
	
	public List<?> getCooperSmpList(SearchVO searchVO){
		return list("CooperationDAO.getCooperSmpList",searchVO);
	}
	
	public CooperReqDetailVO getCooperReqDetail(SearchVO searchVO){
		return (CooperReqDetailVO) select("CooperationDAO.getCooperReqDetail",searchVO);
	}
	
	public void inCooperReject(CoopApprVO coopApprVO){
		insert("CooperationDAO.inCooperReject", coopApprVO);
	}
	
	public void upCooperRejApproval(CoopApprVO coopApprVO){
		update("CooperationDAO.upCooperRejApproval",coopApprVO);
	}
	
	public void upCooperRejApprovalReq(CoopApprVO coopApprVO){
		update("CooperationDAO.upCooperRejApprovalReq",coopApprVO);
	}
	
	public List<?> getResultList(SearchVO searchVO){
		return list("CooperationDAO.getResultList",searchVO);
	}
}
