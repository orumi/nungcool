package tems.com.exam.result.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import tems.com.common.model.SearchVO;
import tems.com.exam.result.model.CalculationVO;
import tems.com.exam.result.model.CoopApprVO;
import tems.com.exam.result.model.ResultDetailVO;
import tems.com.exam.result.model.ResultlVO;
import tems.com.exam.result.model.SmpDetailVO;

public interface ResultDetailService {
	
	ResultDetailVO getResultDetail(SearchVO searchVO) throws Exception;
	
	List getResultSmpList(SearchVO searchVO) throws Exception;
	
	List getResultList(SearchVO searchVO) throws Exception;
	
	void upResultDetail(ResultlVO resultlVO) throws Exception;
	
	List getCalculation(SearchVO searchVO) throws Exception;
	
	void inCalResult(CalculationVO calculationVO) throws Exception;
	
	List getResultListAll(SearchVO searchVO) throws Exception;
	
	SmpDetailVO getSmpDetail(SearchVO searchVO) throws Exception;
	
	void inApprConf(HttpServletRequest req) throws Exception;
}
