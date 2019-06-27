package tems.com.edu.pay.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.common.Criteria;
import tems.com.common.MenuAuthCheck;
import tems.com.common.PageMaker;
import tems.com.edu.common.model.AllChangeCodeVO;
import tems.com.edu.common.model.CodeVO;
import tems.com.edu.common.service.CommonService;
import tems.com.edu.pay.model.PayMemberVO;
import tems.com.edu.pay.model.PayVO;
import tems.com.edu.pay.service.PayListService;
import tems.com.login.model.LoginUserVO;

@Controller
@RequestMapping(value = "/edu/pay")
public class PayListController {

	@Resource(name = "payListService")
	private PayListService payListService;
	
	@Resource(name = "commonService")
	private CommonService commonService;
	
	
	//교육결제관리 리스트
	@RequestMapping(value = "/payList.do", method = RequestMethod.GET)
	public String payList(Criteria cri, Model model, HttpServletRequest req) throws Exception {
		
		//인증관련
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

 		//결제상태코드
 		List<CodeVO> payStateCodeList = commonService.listPayStateCode();
 		model.addAttribute("payStateCodeList", payStateCodeList);
 		
 		//리스트 가져오기
 		List<PayMemberVO> payMemberList = payListService.listPayMember(cri);
 		model.addAttribute("payMemberList", payMemberList);
 		
 		//페이징 준비
 		int totCnt = payListService.selectPayMemberTotCnt(cri) ; 
 		PageMaker pageMaker = new PageMaker(cri, totCnt);
 		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
 		
		return "tems/com/edu/pay/PayList";
	}   
	
		
	//결제리스트 일괄상태변경
	@ResponseBody
	@RequestMapping(value = "/updatePayStateAll.json", method = RequestMethod.POST)
	public void updatePayStateAll(@RequestBody AllChangeCodeVO allChangeCodeVO) throws Exception {
		System.out.println(allChangeCodeVO.toString());
		
		payListService.updatePayStateAll(allChangeCodeVO);
		
	}
	
	
	

	

	
	
}
