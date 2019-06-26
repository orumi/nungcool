package tems.com.common.service;

import java.util.List;

import tems.com.system.model.AuthorGrpVO;
import tems.com.system.model.AuthorListVO;
import tems.com.system.model.OfficeUserListVO;

public interface ComboService {
	
	
	List getComboList(String str) throws Exception;
	
	List getApprStateCodeList(String str) throws Exception;
	
	List getStateCodeList(String str) throws Exception;
	
	
}
