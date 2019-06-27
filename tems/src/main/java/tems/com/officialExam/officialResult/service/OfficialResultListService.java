package tems.com.officialExam.officialResult.service;

import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ApprDetailVO;

import java.util.List;

public interface OfficialResultListService {
	
	List getRequestList(SearchVO searchVO) throws Exception;
	
	void delApprConf(ApprDetailVO apprDetailVO) throws Exception;
	
	void inApprConf(ApprDetailVO apprDetailVO) throws Exception;
	
	void upApprState(ApprDetailVO apprDetailVO) throws Exception;
}
