package tems.com.login.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

import org.springframework.stereotype.Repository;

import tems.com.login.model.FavoriteVO;
import tems.com.login.model.LoginUserVO;
import tems.com.login.model.ReqListVO;

import java.util.List;

/**
 * Created by yongwoo on 2015-11-09.
 */
@Repository("loginUserDAO")
public class LoginUserDAO extends EgovComAbstractDAO {

    public LoginUserVO getLoginUser(LoginUserVO loginUserVO) throws Exception {
        return (LoginUserVO) select("loginUserDAO.getLoginUser", loginUserVO);
    }

    public List<?> getLoginMenu(LoginUserVO loginUserVO) {
        return list("loginUserDAO.getLoginMenu", loginUserVO);
    }

    public void edtUserSkin(LoginUserVO loginUserVO) {
        update("loginUserDAO.edtUserSkin", loginUserVO);
    }

    public List<?> getReqList(LoginUserVO loginUserVO) {
        return list("LoginUserDAO.reqList", loginUserVO);
    }

    public List<?> getFavoriteList(LoginUserVO loginUserVO) {
        return list("LoginUserDAO.getFavoriteList", loginUserVO);
    }

    public void insertFavoriteList(FavoriteVO favoriteVO) {
        insert("LoginUserDAO.insertFavoriteList", favoriteVO);
    }

    public void deleteFavoriteList(FavoriteVO favoriteVO) {
        delete("LoginUserDAO.deleteFavoriteList", favoriteVO);
    }

    public void updateFavoriteList(FavoriteVO favoriteVO) {
        update("LoginUserDAO.updateFavoriteList", favoriteVO);
    }

    public List<?> checkMainViewCount(FavoriteVO favoriteVO) {
        return list("LoginUserDAO.checkMainViewCount", favoriteVO);
    }

}
