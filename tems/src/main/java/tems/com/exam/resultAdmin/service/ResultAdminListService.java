package tems.com.exam.resultAdmin.service;

import java.util.List;

import tems.com.common.model.SearchVO;
import tems.com.exam.result.model.CalculationVO;
import tems.com.exam.result.model.ResultlVO;
import tems.com.exam.resultAdmin.model.ResultAdminListVO;

public interface ResultAdminListService {
	
	List getResultAdminList(SearchVO searchVO) throws Exception;
	
	void upResultAdminDetail(ResultAdminListVO resultAdminListVO) throws Exception;
	
	List getCalculationAdmin(SearchVO searchVO) throws Exception;
	
	void inCalResultAdmin(CalculationVO calculationVO) throws Exception;
	
	List getReqList(SearchVO searchVO) throws Exception;
}
