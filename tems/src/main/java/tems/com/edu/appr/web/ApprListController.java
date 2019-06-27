package tems.com.edu.appr.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.common.Criteria;
import tems.com.common.MenuAuthCheck;
import tems.com.common.PageMaker;
import tems.com.edu.appr.model.ApprManagerVO;
import tems.com.edu.appr.model.ApprMemberVO;
import tems.com.edu.appr.model.ApprPaperVO;
import tems.com.edu.appr.model.ApprVO;
import tems.com.edu.appr.model.CrtApprManagerVO;
import tems.com.edu.appr.service.ApprListService;
import tems.com.edu.course.model.CourseVO;
import tems.com.edu.course.service.CourseListService;
import tems.com.edu.pay.service.PayListService;
import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.ApprListVO;
import tems.com.exam.req.service.ReqListService;
import tems.com.login.model.LoginUserVO;

@Controller
@RequestMapping(value = "/edu/appr")
public class ApprListController {

	
	@Resource(name = "apprListService")
	private ApprListService apprListService;
	
	
	@Resource(name = "courseListService")
	private CourseListService courseListService;
	
	
	@Resource(name = "ReqListService")
	private ReqListService reqListService;
	
	
	@Resource(name = "payListService")
	private PayListService payListService;
	
	
	
	//올린 결재 리스트
	@RequestMapping(value = "/apprDraftList.do", method = RequestMethod.GET)
	public String apprDraftList(Criteria cri, Model model, HttpServletRequest req) throws Exception {
		
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
 		
 		//로그인 사용자 정보 입력
 		cri.setLoginAdminID(nLoginVO.getAdminid());
 		System.out.println("컨트"+ cri.toString());
 		
 		//결재문서 리스트 가져오기
 		List<ApprVO> apprList = apprListService.listApprDraft(cri);
 		System.out.println(apprList.size());
 		
 		//페이징 준비
 		int totCnt = apprListService.selectApprDraftTotCnt(cri);
 		System.out.println(totCnt);
 		PageMaker pageMaker = new PageMaker(cri, totCnt);
 	
 		//jsp값 전달
 		model.addAttribute("apprList", apprList);
 		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
 	
		return "tems/com/edu/appr/ApprDraftList";
		
	}   


	//결재해야할 리스트
	@RequestMapping(value = "/apprAgreeList.do", method = RequestMethod.GET)
	public String apprAgreeList(Criteria cri, Model model, HttpServletRequest req) throws Exception {
		
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
 		
 		//로그인 사용자 정보 입력
 		cri.setLoginAdminID(nLoginVO.getAdminid());
 		System.out.println("컨트"+ cri.toString());
 		
 		//결재문서 리스트 가져오기
 		List<ApprVO> apprList = apprListService.listApprAgree(cri);
 		System.out.println(apprList.toString());
 		System.out.println(apprList.size());
 		
 		//페이징 준비
 		int totCnt = apprListService.selectApprAgreeTotCnt(cri);
 		System.out.println(totCnt);
 		PageMaker pageMaker = new PageMaker(cri, totCnt);
 	
 		//jsp값 전달
 		model.addAttribute("apprList", apprList);
 		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
 	
		return "tems/com/edu/appr/ApprAgreeList";
		
	}   
	
	
	
	
	
	//내부결재 글쓰기(교육훈련)
	@RequestMapping(value = "/apprWriteE.do", method = RequestMethod.POST)
	public String apprWriteE(@RequestParam(value="chkedList")  List<String> chkedList, 
							@RequestParam(value="cosID")  String cosID, Model model, Criteria cri, HttpServletRequest req) throws Exception {
		
		
		//로그인정보
		LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
		
		//결재선 템플릿
		List<ApprListVO> apprList = reqListService.getApprList(user.getAdminid());
		
		//수업정보
		CourseVO courseVO = courseListService.selectCourse(cosID); 
		System.out.println(courseVO.toString());
	
		//훈련생리스트
		List<ApprMemberVO> apprMemberList = apprListService.listApprMember(chkedList);		

		//결재선 템플릿
    	model.addAttribute("apprList", apprList);
    	
    	//수업정보
    	model.addAttribute("courseVO", courseVO);
    	
    	//대상훈련생
    	model.addAttribute("apprMemberList", apprMemberList);
	
    	return "tems/com/edu/appr/ApprWriteE";
	}   
	
	
	//내부결재 글쓰기(환불결재)
	@RequestMapping(value = "/apprWriteR.do", method = RequestMethod.POST)
	public String apprWriteR(@RequestParam(value="chkedList")  List<String> chkedList, 
							 Model model, Criteria cri, HttpServletRequest req) throws Exception {
		
		
		//로그인정보
		LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
		
		//결재선 템플릿
		List<ApprListVO> apprList = reqListService.getApprList(user.getAdminid());
		
		//훈련생리스트
		List<ApprMemberVO> apprMemberList = apprListService.listApprMember(chkedList);	
		
//		//결재대상자
//		List<PayMemberVO> apprMemberList = payListService.listRefundMember(chkedList);

		//결재선 템플릿
    	model.addAttribute("apprList", apprList);
    	
    	//대상훈련생
    	model.addAttribute("apprMemberList", apprMemberList);
	
    	return "tems/com/edu/appr/ApprWriteR";
	}  
	
	
	


	//내부결재 올리기
	@RequestMapping(value = "/insertApprE.do", method = RequestMethod.POST)
	public String insertApprE(ApprPaperVO apprPaperVO) throws Exception {
		System.out.println("ApprWrite.jsp에서 넘어온정보: " + apprPaperVO.toString());
		
		String apprID = apprListService.insertAppr(apprPaperVO);
		
		return "redirect:/edu/appr/apprDraftReadE.do?apprID="+apprID;
		                           
	}



	//내부결재 올리기
	@RequestMapping(value = "/insertApprR.do", method = RequestMethod.POST)
	public String insertApprR(ApprPaperVO apprPaperVO) throws Exception {
		System.out.println("ApprWrite.jsp에서 넘어온정보: " + apprPaperVO.toString());
		
		String apprID = apprListService.insertAppr(apprPaperVO);
		
		return "redirect:/edu/appr/apprDraftReadR.do?apprID="+apprID;
		                           
	}
	
	
	

	@ResponseBody
	@RequestMapping(value = "/apprWrite.json", method = RequestMethod.POST)
	public String apprWriteJson(@RequestParam(value="chkEnrollmember", required=false) List<Integer> chkEnrollmember) throws Exception {
		
		System.out.println("내부결재");
		System.out.println(chkEnrollmember.size());
		
		return "tems/com/edu/appr/ApprWrite";
	}   


	
	@ResponseBody
	@RequestMapping(value = "/enrollStateModify.json", method = RequestMethod.POST)
	public String enrollStateModifyjson(@RequestParam("chkEnrollmember") List<Integer> chkEnrollmember) throws Exception {
		
		System.out.println("상태변경");
		System.out.println(chkEnrollmember.size());
		
		return "tems/com/edu/appr/ApprWrite";
	}   

	
	
	//결재문서 보기
	@ResponseBody
	@RequestMapping(value = "/selectApprLine.json", method = RequestMethod.POST)
	public List<ApprDetailVO> selectApprLine(@RequestParam("apprlineid") String apprlineid) throws Exception {
		
		System.out.println("넘어온 결제선 넘버:"+ apprlineid);
		
		return reqListService.getApprDetail(apprlineid);
	}
	
	
	//올린 결재문서 내용보기(enroll)
	@RequestMapping(value = "/apprDraftReadE.do", method = RequestMethod.GET)
	public String selectApprDraftReadE(@RequestParam(value="apprID") String apprID,
								  Criteria cri, Model model, HttpServletRequest req) throws Exception {
		
		//로그인정보
		LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
		
		//결재문서 가져오기
		ApprVO apprVO = apprListService.selectAppr(apprID);
		
		//수업정보
		CourseVO courseVO = courseListService.selectCourse(apprVO.getCosID()); 
				
		//맴버리스트
		List<ApprMemberVO> apprMemberList = apprListService.listApprMemberByApprID(apprID);
		
		System.out.println("[ApprListController]맴버리스트: " + apprMemberList.toString());
		
		//결재선 템플릿
		List<ApprManagerVO> apprManagerList = apprListService.listApprManager(apprID);
		
		System.out.println("[ApprListController]결재자리스트: " + apprManagerList.toString());
		
		model.addAttribute("cri", cri);
		model.addAttribute("apprVO", apprVO);
    	model.addAttribute("courseVO", courseVO);
    	model.addAttribute("apprMemberList", apprMemberList);
    	model.addAttribute("apprManagerList", apprManagerList);
		
		return "tems/com/edu/appr/ApprDraftReadE";
	}
	
	
	//올린 결재문서 내용보기(refund)
	@RequestMapping(value = "/apprDraftReadR.do", method = RequestMethod.GET)
	public String selectApprDraftReadR(@RequestParam(value="apprID") String apprID,
								  Criteria cri, Model model, HttpServletRequest req) throws Exception {
		
		//로그인정보
		LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
		
		//결재문서 가져오기
		ApprVO apprVO = apprListService.selectAppr(apprID);
		

				
		//맴버리스트
		List<ApprMemberVO> apprMemberList = apprListService.listApprMemberByApprID(apprID);
		System.out.println("++++++++++++++++++++++++++++++++++++++++");
		System.out.println(apprMemberList.size());
		
		
		//결재선 템플릿
		List<ApprManagerVO> apprManagerList = apprListService.listApprManager(apprID);
		
		
		model.addAttribute("cri", cri);
		model.addAttribute("apprVO", apprVO);
    	model.addAttribute("apprMemberList", apprMemberList);
    	model.addAttribute("apprManagerList", apprManagerList);
		
		return "tems/com/edu/appr/ApprDraftReadR";
	}
	
	
	
	

	//결재해야할 문서 내용보기
	@RequestMapping(value = "/apprAgreeReadE.do", method = RequestMethod.GET)
	public String selectApprAgreeReadE(@RequestParam(value="apprID") String apprID,
			 					Criteria cri, Model model, HttpServletRequest req) throws Exception {
		
		//로그인정보
		LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
		
		//결재문서 가져오기
		ApprVO apprVO = apprListService.selectAppr(apprID);
		
		//수업정보
		CourseVO courseVO = courseListService.selectCourse(apprVO.getCosID()); 
				
		//맴버리스트
		List<ApprMemberVO> apprMemberList = apprListService.listApprMemberByApprID(apprID);
		
		System.out.println("[ApprListController]맴버리스트: " + apprMemberList.toString());
		
		//결재선 템플릿
		List<ApprManagerVO> apprManagerList = apprListService.listApprManager(apprID);
		
		System.out.println("[ApprListController]결재자리스트: " + apprManagerList.toString());
		
		//현재 결재자 정보
		CrtApprManagerVO crtApprManagerVO = apprListService.selectCrtApprManager(apprID, user.getAdminid());
		
		model.addAttribute("cri", cri);
		model.addAttribute("apprVO", apprVO);
    	model.addAttribute("courseVO", courseVO);
    	model.addAttribute("apprMemberList", apprMemberList);
    	model.addAttribute("apprManagerList", apprManagerList);
    	model.addAttribute("crtApprManagerVO", crtApprManagerVO);
		
		return "tems/com/edu/appr/ApprAgreeReadE";
	}
	

	
	//결재해야할 문서 내용보기
	@RequestMapping(value = "/apprAgreeReadR.do", method = RequestMethod.GET)
	public String selectApprAgreeReadR(@RequestParam(value="apprID") String apprID,
			 					Criteria cri, Model model, HttpServletRequest req) throws Exception {
		
		//로그인정보
		LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
		
		//결재문서 가져오기
		ApprVO apprVO = apprListService.selectAppr(apprID);
		
		//수업정보
		CourseVO courseVO = courseListService.selectCourse(apprVO.getCosID()); 
				
		//맴버리스트
		List<ApprMemberVO> apprMemberList = apprListService.listApprMemberByApprID(apprID);
		
		
		//결재선 템플릿
		List<ApprManagerVO> apprManagerList = apprListService.listApprManager(apprID);
		
		
		//현재 결재자 정보
		CrtApprManagerVO crtApprManagerVO = apprListService.selectCrtApprManager(apprID, user.getAdminid());
		
		model.addAttribute("cri", cri);
		model.addAttribute("apprVO", apprVO);
    	model.addAttribute("courseVO", courseVO);
    	model.addAttribute("apprMemberList", apprMemberList);
    	model.addAttribute("apprManagerList", apprManagerList);
    	model.addAttribute("crtApprManagerVO", crtApprManagerVO);
		
		return "tems/com/edu/appr/ApprAgreeReadR";
	}


	//결재 OK하기
	@ResponseBody
	@RequestMapping(value = "/updateAgreeOK.json", method = RequestMethod.POST)
	public void updateAgreeOKJson(@RequestParam("apprID") String apprID, @RequestParam("adminID") String adminID) throws Exception {
		
		apprListService.updateAgreeOK(apprID, adminID);
	}
	
	
	//결재 반려 하기
	@ResponseBody
	@RequestMapping(value = "/updateReject.json", method = RequestMethod.POST)
	public void updateRejectJson(@RequestBody ApprManagerVO apprManagerVO) throws Exception {
		
		apprListService.updateApprReject(apprManagerVO);
	}
	

}
