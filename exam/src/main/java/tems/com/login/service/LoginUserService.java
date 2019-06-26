package tems.com.login.service;

import java.util.List;

import tems.com.login.model.LoginUserVO;
import tems.com.login.model.ReqListVO;
import tems.com.login.model.UserMenuVO;

/**
 * Created by yongwoo on 2015-11-09.
 */
public interface LoginUserService {

          public LoginUserVO getLoginUser(LoginUserVO loginUserVO) throws Exception;


          public List<UserMenuVO>  getLoginMenu(LoginUserVO loginUserVO) throws Exception;
          
          public void edtUserSkin(LoginUserVO loginUserVO) throws Exception;
          
          public List<ReqListVO>  getReqList(LoginUserVO loginUserVO) throws Exception;
}
