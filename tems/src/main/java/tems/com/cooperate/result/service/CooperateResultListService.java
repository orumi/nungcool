package tems.com.cooperate.result.service;

import java.util.List;

import tems.com.common.model.SearchVO;
import tems.com.exam.result.model.ResultDetailVO;
import tems.com.exam.result.model.ResultlVO;

public interface CooperateResultListService {
	
	List getRequestList(SearchVO searchVO) throws Exception;
	
	List getResultSmpList(SearchVO searchVO) throws Exception;
	
	List getCoopResultList(SearchVO searchVO) throws Exception;
	
	ResultDetailVO getResultDetail(SearchVO searchVO) throws Exception;
	
	List getCoopCalculation(SearchVO searchVO) throws Exception;
	
	void upCoopResultState(ResultlVO resultlVO) throws Exception;
}
