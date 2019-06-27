package tems.com.common;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import tems.com.login.model.LoginUserVO;
import tems.com.login.service.LoginUserService;

public class sessionChk extends HandlerInterceptorAdapter {


    @Resource(name = "loginUserService")
    private LoginUserService loginUserService;

    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse response, Object handler) throws Exception {
        try {
            String resultMsg = "";

            if (!StringUtils.nvl(req.getParameter("req_menuNo"), "").equals("null") && !StringUtils.nvl(req.getParameter("req_menuNo"), "").equals("")) {
                req.getSession().setAttribute("menuId", req.getParameter("req_menuNo"));
            }

            LoginUserVO nLoginVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");
            if (nLoginVO != null) {
                if (!MenuAuthCheck.AuthCheck(req)) {

                    response.sendRedirect(req.getContextPath() + "/index.do?ecd=1");
                    return false;
                } else {

                    // Top Menu 즐겨찾기 부분 Start //
                    List favoriteList = loginUserService.getFavoriteList(nLoginVO); // 디비에서 목록 가져온다 해당 아이디값으로 조회해서
                    req.getSession().setAttribute("favoriteList", favoriteList); // 세션에 합체 시킴
                    // Top Menu 즐겨찾기 부분 Start End //
                }
            } else {
                response.sendRedirect(req.getContextPath() + "/index.do?ecd=2");
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //admin 세션key 존재시 main 페이지 이동
        return true;
    }

}
