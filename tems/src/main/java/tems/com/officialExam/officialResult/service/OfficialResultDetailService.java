package tems.com.officialExam.officialResult.service;

import tems.com.common.model.SearchVO;
import tems.com.officialExam.officialResult.model.CalculationVO;
import tems.com.officialExam.officialResult.model.ResultDetailVO;
import tems.com.officialExam.officialResult.model.ResultlVO;
import tems.com.officialExam.officialResult.model.SmpDetailVO;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface OfficialResultDetailService {
	
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
