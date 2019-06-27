package tems.com.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.system.model.OfficeUserListVO;
import tems.com.system.service.UserInfoService;
import tems.com.system.service.impl.UserInfoDAO;

@Service("UserInfoService")
public class UserInfoServiceImpl implements UserInfoService {

    @Resource(name = "UserInfoDAO")
    private UserInfoDAO UserInfoDAO;
	
     @Override
     public List<?> getUserInfoList() throws Exception {
    	 return UserInfoDAO.getUserInfoList();
     }
     
     @Override
     public List<?> getOfficeUserList(String str) throws Exception {
    	 return UserInfoDAO.getOfficeUserList(str);
     }
     
     @Override
     public void upOfficeUser(OfficeUserListVO officeUserListVO) throws Exception {
    	 UserInfoDAO.upOfficeUser(officeUserListVO);
     }
     
}
