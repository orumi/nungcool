package tems.com.common.service;

import tems.com.common.model.CondComboVO;
import tems.com.common.model.MethodComboVO;
import tems.com.common.model.SearchVO;
import tems.com.common.model.UnitComboVO;

import java.util.List;

public interface ComboService {

	List getComboList(String str) throws Exception;
	
	List getApprStateCodeList(String str) throws Exception;
	
	List getStateCodeList(String str) throws Exception;
	
	List getMethodComboList(MethodComboVO methodComboVO) throws Exception;
	
	List getCondComboList(CondComboVO condComboVO) throws Exception;
	
	List getUnitComboList(UnitComboVO unitComboVO) throws Exception;
	
	List getSmpCondComboList(CondComboVO condComboVO) throws Exception;
	
	List getDeptComboList(SearchVO searchVO) throws Exception;
}
