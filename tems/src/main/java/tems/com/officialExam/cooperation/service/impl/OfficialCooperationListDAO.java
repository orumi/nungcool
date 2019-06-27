package tems.com.officialExam.cooperation.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;
import tems.com.common.model.SearchVO;
import tems.com.exam.result.model.CoopApprVO;
import tems.com.officialExam.cooperation.model.CooperReqDetailVO;

import java.util.List;

@Repository("officialCooperationDAO")
public class OfficialCooperationListDAO extends EgovComAbstractDAO {
	
	public List<?> getCooperationList(SearchVO searchVO){
		return list("officialCooperationDAO.getCooperationList",searchVO);
	}
	
	public void upCooperApproval(CoopApprVO coopApprVO){
		update("officialCooperationDAO.upCooperApproval",coopApprVO);
	}
	
	public void upCooperApprovalNext(CoopApprVO coopApprVO){
		update("officialCooperationDAO.upCooperApprovalNext",coopApprVO);
	}
	
	public void upCooperApprovalReq(CoopApprVO coopApprVO){
		update("officialCooperationDAO.upCooperApprovalReq",coopApprVO);
	}
	
	public List<?> getCooperSmpList(SearchVO searchVO){
		return list("officialCooperationDAO.getCooperSmpList",searchVO);
	}
	
	public CooperReqDetailVO getCooperReqDetail(SearchVO searchVO){
		return (CooperReqDetailVO) select("officialCooperationDAO.getCooperReqDetail",searchVO);
	}
	
	public void inCooperReject(CoopApprVO coopApprVO){
		insert("officialCooperationDAO.inCooperReject", coopApprVO);
	}
	
	public void upCooperRejApproval(CoopApprVO coopApprVO){
		update("officialCooperationDAO.upCooperRejApproval",coopApprVO);
	}
	
	public void upCooperRejApprovalReq(CoopApprVO coopApprVO){
		update("officialCooperationDAO.upCooperRejApprovalReq",coopApprVO);
	}
	
	public List<?> getResultList(SearchVO searchVO){
		return list("officialCooperationDAO.getResultList",searchVO);
	}
}
