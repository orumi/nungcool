package tems.com.system.service;

import java.util.List;

import tems.com.system.model.AuthorGrpVO;
import tems.com.system.model.AuthorListVO;
import tems.com.system.model.OfficeUserListVO;

public interface UserInfoService {
	
	List getUserInfoList() throws Exception;
	
	List getOfficeUserList(String str) throws Exception;
	
	void upOfficeUser(OfficeUserListVO officeUserListVO) throws Exception;
	
}
