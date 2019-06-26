package tems.com.exam.req.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.json.simple.JSONValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.common.MenuAuthCheck;
import tems.com.common.StringUtils;
import tems.com.exam.req.model.RequestItemDetailVO;
import tems.com.exam.req.service.ReqDetailService;
import tems.com.login.model.LoginUserVO;
import tems.com.system.model.AuthorGrpVO;
import tems.com.system.model.AuthorListVO;
import tems.com.system.service.AuthorGrpService;
import tems.com.testSample.model.TestItemVO;
import tems.com.testSample.service.TestItemService;
import egovframework.com.cmm.ComDefaultCodeVO;

@Controller
public class ReqDetailController {
	
	@Resource(name = "ReqDetailService")
    private ReqDetailService reqDetailService;
	
	/**
     * 
     * @exception Exception
     */
    @RequestMapping(value="/exam/req/ReqListDetail.do")
    public String ReqListDetail(
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
 		
      	return "tems/com/exam/req/ReqListDetail";
    }
    
    @RequestMapping(value="/exam/req/ReqItemList.json")
    public @ResponseBody List<RequestItemDetailVO>  selAuthorGrpList(
    		RequestItemDetailVO reqItemDetailVO
    		) throws Exception{
    	List<RequestItemDetailVO> reqItemDetailList = reqDetailService.getReqItemList(reqItemDetailVO);
    	
        return reqItemDetailList;
    }
    
}
