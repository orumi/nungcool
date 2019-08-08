package tems.com.login.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import tems.com.login.model.LoginUserVO;
import tems.com.login.model.ReqListVO;
import tems.com.login.model.UserMenuVO;
import tems.com.login.service.LoginUserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;

import net.sf.json.JSONObject;

/**
 * Created by yongwoo on 2015-11-09.
 */

@Controller
public class LoginUserController {

    @Resource(name = "loginUserService")
    private LoginUserService loginUserService;

    @RequestMapping("/setMain.do")
    public String setMain(HttpServletRequest req, HttpServletResponse resp, ModelMap model) throws Exception {

        LoginUserVO loginUserVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");

        List<ReqListVO> ReqList = (List<ReqListVO>) loginUserService.getReqList(loginUserVO);

        model.addAttribute("ReqList", ReqList);

        return "tems/com/login/main";
    }


    @RequestMapping(value = "/login/userLogin.do", method = RequestMethod.POST)
    public String userLoginService(@ModelAttribute("loginUserVO") LoginUserVO loginUserVO, BindingResult bindingResult,
                                   ModelMap model, HttpServletRequest req, HttpServletResponse response)
            throws Exception {

    	JSONObject nJson = new JSONObject();

        List<UserMenuVO> list;
        UserMenuVO loginMenuVO = new UserMenuVO();
        String jsonText = "";
        try {
            LoginUserVO loginVO = loginUserService.getLoginUser(loginUserVO);

            if (loginVO != null) {

                list = (List<UserMenuVO>) loginUserService.getLoginMenu(loginVO);

                req.getSession().setAttribute("loginUserVO", loginVO);
                req.getSession().setAttribute("UserMenuList", list);
                req.getSession().setAttribute("menuId", "main");
                req.getSession().setAttribute("skin", loginVO.getSkin());

                nJson.put("RESULT_YN", "Y");
                nJson.put("RESULT_MESSAGE", "");
            } else {
                nJson.put("RESULT_YN", "N");
                nJson.put("RESULT_MESSAGE", URLEncoder.encode("인증되지 않은 아이디 또는 비밀번호 입니다.", "UTF-8"));
            }
            //jsonText = nJson.toJSONString();
        } catch (Exception e) {
            nJson.put("RESULT_YN", "N");
            nJson.put("RESULT_MESSAGE", e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.print(nJson.toString());
        out.flush();
        out.close();
        return null;
    }


    @RequestMapping(value = "/login/userLogout.do")
    public String userLogout(ModelMap model, HttpServletRequest req) throws Exception {

        req.getSession().invalidate();
        model.addAttribute("resultMsg", "로그아웃 되었습니다.");
        return "tems/loginPage";

    }

    @RequestMapping(value = "/login/edtUserSkin.json")
    public void edtUserSkin(
            @ModelAttribute("loginUserVO") LoginUserVO loginUserVO,
            HttpServletRequest req
    ) throws Exception {

        req.getSession().setAttribute("skin", loginUserVO.getSkin());
        loginUserService.edtUserSkin(loginUserVO);
    }

}
