package tems.com.officialExam.cooperation.service;

import tems.com.common.model.SearchVO;
import tems.com.exam.result.model.CoopApprVO;
import tems.com.officialExam.cooperation.model.CooperReqDetailVO;

import java.util.List;

public interface OfficialCooperationListService {
	
	List getCooperationList(SearchVO searchVO) throws Exception;
	
	void upCooperApproval(CoopApprVO coopApprVO) throws Exception;
	
	List getCooperSmpList(SearchVO searchVO) throws Exception;
	
	CooperReqDetailVO getCooperReqDetail(SearchVO searchVO) throws Exception;
	
	void inCooperReject(CoopApprVO coopApprVO) throws Exception;
	
	List getResultList(SearchVO searchVO) throws Exception;
}
