package tems.com.login.service.impl;

import org.springframework.stereotype.Service;

import tems.com.login.model.LoginUserVO;
import tems.com.login.model.ReqListVO;
import tems.com.login.model.UserMenuVO;
import tems.com.login.service.LoginUserService;

import javax.annotation.Resource;

import java.util.List;

/**
 * Created by yongwoo on 2015-11-09.
 */
@Service("loginUserService")
public class LoginUserServiceImpl implements LoginUserService {

     @Resource(name = "loginUserDAO")
     private LoginUserDAO loginUserDAO;

     @Override
     public LoginUserVO getLoginUser(LoginUserVO loginUserVO) throws Exception {
          LoginUserVO resultUser = loginUserDAO.getLoginUser(loginUserVO);
          return resultUser;
     }

     @Override
     public List<UserMenuVO> getLoginMenu(LoginUserVO loginUserVO) throws Exception {
          List<UserMenuVO> resultMenu = (List<UserMenuVO>) loginUserDAO.getLoginMenu(loginUserVO);
          return resultMenu;
     }
     
     @Override
     public void edtUserSkin(LoginUserVO loginUserVO) throws Exception {
    	 loginUserDAO.edtUserSkin(loginUserVO);
     }
     
     @Override
     public List<ReqListVO> getReqList(LoginUserVO loginUserVO) throws Exception {
          List<ReqListVO> resultMenu = (List<ReqListVO>) loginUserDAO.getReqList(loginUserVO);
          return resultMenu;
     }
}
