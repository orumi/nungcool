package tems.com.exam.result.service;

import java.util.List;

import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ApprDetailVO;

public interface ResultListService {
	
	List getRequestList(SearchVO searchVO) throws Exception;
	
	void delApprConf(ApprDetailVO apprDetailVO) throws Exception;
	
	void inApprConf(ApprDetailVO apprDetailVO) throws Exception;
	
	void upApprState(ApprDetailVO apprDetailVO) throws Exception;
}
