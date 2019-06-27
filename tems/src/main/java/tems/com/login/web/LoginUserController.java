package tems.com.login.web;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import tems.com.login.model.FavoriteVO;
import tems.com.login.model.LoginUserVO;
import tems.com.login.model.ReqListVO;
import tems.com.login.model.UserMenuVO;
import tems.com.login.service.LoginUserService;
import tems.com.main.model.ProgressInfoVO;
import tems.com.main.service.MainContentsService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yongwoo on 2015-11-09.
 */

@Controller
public class LoginUserController {

    @Resource(name = "loginUserService")
    private LoginUserService loginUserService;

    @Resource(name = "mainContentsService")
    private MainContentsService mainContentsService;

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

            jsonText = nJson.toString();

        } catch (Exception e) {
            nJson.put("RESULT_YN", "N");
            nJson.put("RESULT_MESSAGE", e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.print(jsonText);
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


    @RequestMapping(value = "/login/addFavoriteMenu.json")
    public
    @ResponseBody
    Map addFavoriteMenu(@RequestParam("data") String data, HttpServletRequest req) throws Exception {

        Map map = new HashMap();
        String message = "";

        //import net.sf.json.JSONObject 이다
        JSONObject json = JSONObject.fromObject(JSONSerializer.toJSON(data));
        FavoriteVO vo = (FavoriteVO) JSONObject.toBean(json, FavoriteVO.class);


        // 바로 즐겨찾기 바로가기 메뉴에 등록될지 여부를 위한 mainView 의 Y값 개수와 현재 등록되어 있는 페이지인지 여부를 위해 지금 저장하려는 페이지 개수 in DB를 조사해 온다.
        List list = loginUserService.checkMainViewCount(vo);
        FavoriteVO checkVO = (FavoriteVO) list.get(0);
        int menuNoCount = Integer.parseInt(checkVO.getMenuNo());
        int mainViewCount = Integer.parseInt(checkVO.getMainView());


        if (mainViewCount >= 3) { // 초기 즐겨찾기 바로가기 메뉴에 바로 등록 될 것인지 아닌지의 유무 이미 3개이상 있다면 추가될 수 없다.
            vo.setMainView("N");
        } else {
            vo.setMainView("Y"); // 3개 이하라면 바로 추가.
        }

        if (menuNoCount >= 1) {
            message = "이미 즐겨찾기 목록에 등록 되어 있습니다.";
            map.put("message", message);
            return map;
        }

        if (vo.getMenuNo().equals("main")) {
            message = "메인화면은 즐겨찾기 대상이 아닙니다.";
            map.put("message", message);
            return map;
        } else {
            try {
                loginUserService.insertFavoriteList(vo);
                message = "성공적으로 즐겨찾기에 추가 되었습니다.";
            } catch (Exception e) {
                message = "즐겨찾기에 추가 되지 않았습니다. 관리자에게 문의 하세요";
            }
        }
        map.put("message", message);
        return map;
    }

    @RequestMapping(value = "/login/addFavoriteMenuLoad.json")
    public
    @ResponseBody
    List addFavoriteMenuLoad(@RequestParam("data") String data, HttpServletRequest req) throws Exception {

        LoginUserVO loginUserVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");

        List list = loginUserService.getFavoriteList(loginUserVO);

        return list;
    }


    @RequestMapping(value = "/login/deleteFavoriteMenu.json")
    public
    @ResponseBody
    Map deleteFavoriteMenu(@RequestParam("data") String data, HttpServletRequest req) throws Exception {

        Map map = new HashMap();

        String message = "";

        List<FavoriteVO> modifiedList = new ArrayList();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            FavoriteVO vo = (FavoriteVO) JSONObject.toBean(cusJson.getJSONObject(i), FavoriteVO.class);
            modifiedList.add(vo);
        }
        try {
            loginUserService.deleteFavoriteList(modifiedList);
            message = "성공적으로 삭제 되었습니다.";
            map.put("message", message);
        } catch (Exception e) {
            message = "오류가 발생 하였습니다 관리자에게 문의 하여 주세요 오류 코드 : " + e;
            map.put("message", message);
        }
        return map;
    }

    @RequestMapping(value = "/login/updateFavoriteMenu.json")
    public
    @ResponseBody
    Map updateFavoriteMenu(@RequestParam("data") String data, HttpServletRequest req) throws Exception {

        Map map = new HashMap();
        String message = "";
        List<FavoriteVO> modifiedList = new ArrayList();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            FavoriteVO vo = (FavoriteVO) JSONObject.toBean(cusJson.getJSONObject(i), FavoriteVO.class);
            modifiedList.add(vo);

        }

        try {
            loginUserService.updateFavoriteList(modifiedList);
            message = "성공적으로 저장 되었습니다.";
            map.put("message", message);
        } catch (Exception e) {
            message = "오류가 발생 하였습니다 관리자에게 문의 하여 주세요 오류 코드 : " + e;
            map.put("message", message);
        }
        return map;
    }


    @RequestMapping(value = "/login/getHeaderInformation.json")
    public
    @ResponseBody
    ProgressInfoVO getHeaderInformation(@RequestParam("data") String data, HttpServletRequest req, Model model) throws Exception {

        LoginUserVO loginUserVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");

        List<ReqListVO> ReqList = (List<ReqListVO>) loginUserService.getReqList(loginUserVO);


        //테이블 우측 1번라인 처리
        ProgressInfoVO proInfoVO = new ProgressInfoVO();
        proInfoVO.setUserID(loginUserVO.getAdminid());
        List progressInfoList = mainContentsService.selectProgressInfo(proInfoVO);
        //테이블 우측 1번라인 처리

        ProgressInfoVO vo = (ProgressInfoVO) progressInfoList.get(0);


        return vo;
    }



}
