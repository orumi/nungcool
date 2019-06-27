package tems.com.exam.req.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import tems.com.common.MenuAuthCheck;
import tems.com.login.model.LoginUserVO;
import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class ReqRejectListController {
	
	
	/**
     * 접수내역 리스트조회한다.
     * @exception Exception
     */
    @RequestMapping(value="/exam/req/ReqRejectList.do")
    public String selectMenuManageList(
    		HttpServletRequest req,
    		ModelMap model) throws Exception {

    	if(req.getParameter("req_menuNo") != null){
    		req.getSession().setAttribute("menuId", req.getParameter("req_menuNo"));
    	}
    	
    	LoginUserVO nLoginVO = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
 		if(nLoginVO != null){
 			if(!MenuAuthCheck.AuthCheck(req)){
 				model.addAttribute("resultMsg", "메뉴 사용권한이 없습니다..");
 				return "forward:/login/userLogout.do";
 			}
 		} else {
 			model.addAttribute("resultMsg", "사용자 정보가 없습니다.");
 			return "forward:/login/userLogout.do";
 		}
 		
      	return "tems/com/exam/req/ReqRejectList";
    }
}
