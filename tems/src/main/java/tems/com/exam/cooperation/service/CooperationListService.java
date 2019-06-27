package tems.com.exam.cooperation.service;

import java.util.List;

import tems.com.common.model.SearchVO;
import tems.com.exam.cooperation.model.CooperReqDetailVO;
import tems.com.exam.cooperation.model.CooperationRejectVO;
import tems.com.exam.result.model.CoopApprVO;

public interface CooperationListService {
	
	List getCooperationList(SearchVO searchVO) throws Exception;
	
	void upCooperApproval(CoopApprVO coopApprVO) throws Exception;
	
	List getCooperSmpList(SearchVO searchVO) throws Exception;
	
	CooperReqDetailVO getCooperReqDetail(SearchVO searchVO) throws Exception;
	
	void inCooperReject(CoopApprVO coopApprVO) throws Exception;
	
	List getResultList(SearchVO searchVO) throws Exception;
}
