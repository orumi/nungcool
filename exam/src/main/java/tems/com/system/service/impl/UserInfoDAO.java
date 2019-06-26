package tems.com.system.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.system.model.OfficeUserListVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("UserInfoDAO")
public class UserInfoDAO extends EgovComAbstractDAO  {
		
	public List<?> getUserInfoList(){
        return list("UserInfoDAO.selLOfficeist");
   }
	
	public List<?> getOfficeUserList(String str){
        return list("UserInfoDAO.getOfficeUserList",str);
   }
	
	public void upOfficeUser(OfficeUserListVO officeUserListVO){
        update("UserInfoDAO.upOfficeUser", officeUserListVO);
   }

}
