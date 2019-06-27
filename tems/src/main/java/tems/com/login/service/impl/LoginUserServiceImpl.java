package tems.com.login.service.impl;

import oracle.jdbc.util.Login;
import org.springframework.stereotype.Service;

import tems.com.login.model.FavoriteVO;
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

    @Override
    public List<FavoriteVO> getFavoriteList(LoginUserVO loginUserVO) throws Exception {
        List<FavoriteVO> favoriteList = (List<FavoriteVO>) loginUserDAO.getFavoriteList(loginUserVO);
        return favoriteList;
    }

    @Override
    public void insertFavoriteList(FavoriteVO favoriteVO) throws Exception {
        loginUserDAO.insertFavoriteList(favoriteVO);
    }

    @Override
    public void deleteFavoriteList(List<FavoriteVO> list) throws Exception {

        for (FavoriteVO vo : list) {
            loginUserDAO.deleteFavoriteList(vo);
        }
    }

    @Override
    public void updateFavoriteList(List<FavoriteVO> list) throws Exception {
        for (FavoriteVO vo : list) {
            loginUserDAO.updateFavoriteList(vo);
        }
    }

    @Override
    public List checkMainViewCount(FavoriteVO favoriteVO) throws Exception {
        return loginUserDAO.checkMainViewCount(favoriteVO);
    }

}
