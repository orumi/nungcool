package tems.com.edu.course.web;

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
import tems.com.edu.common.model.AllChangeCodeVO;
import tems.com.edu.common.model.CodeVO;
import tems.com.edu.common.service.CommonService;
import tems.com.edu.course.model.CertificateVO;
import tems.com.edu.course.model.CourseEnrollVO;
import tems.com.edu.course.model.CourseVO;
import tems.com.edu.course.model.EnrollMemberVO;
import tems.com.edu.course.model.EnrollStateVO;
import tems.com.edu.course.model.GradeVO;
import tems.com.edu.course.model.ReceiptVO;
import tems.com.edu.course.model.SubjectVO;
import tems.com.edu.course.service.CourseListService;
import tems.com.edu.pay.model.PayVO;
import tems.com.edu.pay.service.PayListService;
import tems.com.login.model.LoginUserVO;

@Controller
@RequestMapping(value = "/edu/course")
public class CourseListController {

	@Resource(name = "courseListService")
	private CourseListService courseListService;
	
	
	@Resource(name = "payListService")
	private PayListService payListService;
	
	
	
	@Resource(name = "commonService")
	private CommonService commonService;
	
	
	/********************************************************************************************/	
	/**	교육훈련 리스트                                                                         */
	/********************************************************************************************/	
	
	//교육훈련리스트
	@RequestMapping(value = "/courseList.do", method = RequestMethod.GET)
	public String courseList(Criteria cri, Model model, HttpServletRequest req) throws Exception {
	
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
 		
 		
 		//교육훈련리스트
 		List<CourseVO> courseList = courseListService.listCourse(cri);
 		
 		int totCnt = courseListService.selectCourseTotCnt(cri);
 		PageMaker pageMaker = new PageMaker(cri, totCnt);
 		
 		
 		//교육훈련상태코드
 		List<CodeVO> courseStateCodeList = commonService.listCourseStateCode();
 		
 		model.addAttribute("courseList", courseList);
 		model.addAttribute("courseStateCodeList", courseStateCodeList);
 		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);

		
 		//과목리스트(팝업 출력)
 		List<SubjectVO> subjectList = courseListService.listSubject();
 		model.addAttribute("subjectList", subjectList);

 		return "tems/com/edu/course/CourseList";
	}

	
	//교육훈련상태 일괄변경
	@ResponseBody
	@RequestMapping(value = "/updateCourseStateAll.json", method = RequestMethod.POST)
	public void updateCourseStateAll(@RequestBody AllChangeCodeVO allChangeCodeVO) throws Exception {
		
		courseListService.updateCourseStateAll(allChangeCodeVO);
	}

	

	//교육훈련 신청자 조회
	@ResponseBody
	@RequestMapping(value = "/listEnrollLMember.json", method = RequestMethod.POST)
	public int listEnrollLMemberJson(@RequestParam("cosID")  String cosID, Criteria cri) throws Exception {
		
		return courseListService.listEnrollMember(cosID, cri).size();
		
		
	}
	
	//교육훈련 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteCourse.json", method = RequestMethod.POST)
	public void deleteCourseJson(@RequestParam("cosID") String cosID) throws Exception {
		System.out.println(cosID);
		
		courseListService.deleteCourse(cosID);
	}
	
	
	
	
	//교육훈련추가(팝업)
	@RequestMapping(value = "/courseInsert.do", method = RequestMethod.POST)
	public String courseInsert(CourseVO courseVO, Model model) throws Exception {
		
		courseListService.insertCourse(courseVO);
		
		return "redirect:/edu/course/courseList.do";
	}
	
	
	
	/********************************************************************************************/	
	/**	교육훈련 상세                                                                           */
	/********************************************************************************************/	
	
	//교육훈련상세
	@RequestMapping(value = "/courseDetail.do", method = RequestMethod.GET)
	public String courseDetail(String cosID, Criteria cri, Model model) throws Exception {
		
		//교육훈련정보
		CourseVO courseVO = courseListService.selectCourse(cosID); 
		
		//교육훈련상태코드
		List<CodeVO> courseStateCodeList = commonService.listCourseStateCode();
				
		//교육훈련 신청 맴버
		List<EnrollMemberVO> enrollLMember= courseListService.listEnrollMember(cosID, cri); 	
		
		//접수상태코드
		List<CodeVO> enrollStateCodeList = commonService.listEnrollStateCode();
 		
		model.addAttribute("courseVO", courseVO);
		model.addAttribute("courseStateCodeList", courseStateCodeList);
		model.addAttribute("enrollLMember", enrollLMember);
		model.addAttribute("enrollStateCodeList", enrollStateCodeList);
		model.addAttribute("cri", cri);
		
 		return "tems/com/edu/course/CourseDetail";
	}
	

	
	//교육훈련수정
	@RequestMapping(value = "/courseUpdate.do", method = RequestMethod.POST)
	public String updateCourse(CourseVO courseVO, Criteria cri, Model model) throws Exception {
		
		String cosID = courseVO.getCosID();
		int crtPage = cri.getCrtPage();
		int rowCnt = cri.getRowCnt();
		courseListService.updateCourse(courseVO);
		
		return "redirect:/edu/course/courseDetail.do?cosID="+cosID+"&crtPage="+crtPage+"&rowCnt="+rowCnt ;
	}


	

	
		
	
	/********************************************************************************************/	
	/**	개인별 관리 페이지                                                                      */
	/********************************************************************************************/	
	
	//훈련생별 접수정보
	@RequestMapping(value = "/enrollInfo.do", method = RequestMethod.GET)
	public String selectCourseEnroll(String enrollID, Criteria cri, Model model) throws Exception {
		
		//훈련생별 접수정보
		CourseEnrollVO courseEnroll = courseListService.selectCourseEnroll(enrollID);
		model.addAttribute("courseEnroll", courseEnroll);

		//결제관련
		PayVO pay = payListService.selectPay(enrollID);
		model.addAttribute("pay", pay);
		
		//접수증관련
		ReceiptVO receipt = courseListService.selectReceipt(enrollID);
		model.addAttribute("receipt", receipt);
		
		//평가관련
		GradeVO grade = courseListService.selectGrade(enrollID);
		model.addAttribute("grade", grade);

		//수료증관련
		CertificateVO certificate = courseListService.selectCertificate(enrollID);
		model.addAttribute("certificate", certificate);
		
		
		//각종 상태값
		List<CodeVO> enrollStateList = commonService.listEnrollStateCode();
		model.addAttribute("enrollStateList", enrollStateList );
		
		List<CodeVO> payStateList = commonService.listPayStateCode();
		model.addAttribute("payStateList", payStateList );
		
		List<CodeVO> payTypeList = commonService.listPayTypeCode();
		model.addAttribute("payTypeList", payTypeList );
		
		List<CodeVO> payTimeList = commonService.listPayTimeCode();
		model.addAttribute("payTimeList", payTimeList );
		
		List<CodeVO> taxTypeList = commonService.listTaxTypeCode();
		model.addAttribute("taxTypeList", taxTypeList );
		
		List<CodeVO> passList = commonService.listPassCode();
		model.addAttribute("passList", passList );
		
		model.addAttribute("cri", cri);		
		
		return "tems/com/edu/course/EnrollInfo";
	}
	
	
	
	//접수상태 관리
	@RequestMapping(value = "/updateEnrollState.do", method = RequestMethod.POST)
	public String updateEnrollState(EnrollStateVO enrollStateVO, Criteria cri) throws Exception {		
		String cosID = enrollStateVO.getCosID();
		String enrollID = enrollStateVO.getEnrollID();
		int crtPage = cri.getCrtPage();
		int rowCnt = cri.getRowCnt();
		
		courseListService.updateEnrollState(enrollStateVO); 
		
		return "redirect:/edu/course/enrollInfo.do?cosID=" +cosID+ "&crtPage=" +crtPage+ "&rowCnt=" +rowCnt+ "&enrollID="+ enrollID ;
	}
	
	
	//결제상태 관리
	@RequestMapping(value = "/updatePayState.do", method = RequestMethod.POST)
	public String updatePayState(PayVO payVO, Criteria cri) throws Exception {
		String cosID = payVO.getCosID();
		String enrollID = payVO.getEnrollID();
		int crtPage = cri.getCrtPage();
		int rowCnt = cri.getRowCnt();
		
		payListService.updatePayState(payVO); 
		
		return "redirect:/edu/course/enrollInfo.do?cosID=" +cosID+ "&crtPage=" +crtPage+ "&rowCnt=" +rowCnt+ "&enrollID="+ enrollID ;
	}   
	
	
	//결제정보 관리
	@RequestMapping(value = "/updatePayInfo.do", method = RequestMethod.POST)
	public String updatePayInfo(PayVO payVO, Criteria cri) throws Exception {
		String cosID = payVO.getCosID();
		String enrollID = payVO.getEnrollID();
		int crtPage = cri.getCrtPage();
		int rowCnt = cri.getRowCnt();
		
		payListService.updatePayInfo(payVO); 
		
		return "redirect:/edu/course/enrollInfo.do?cosID=" +cosID+ "&crtPage=" +crtPage+ "&rowCnt=" +rowCnt+ "&enrollID="+ enrollID ;
	}   
	
	
	
	//평가 관리
	@RequestMapping(value = "/updateGrade.do", method = RequestMethod.POST)
	public String updateGrade(GradeVO gradeVO, Criteria cri) throws Exception {
		String cosID = gradeVO.getCosID();
		String enrollID = gradeVO.getEnrollID();
		int crtPage = cri.getCrtPage();
		int rowCnt = cri.getRowCnt();	
		
		courseListService.updateGrade(gradeVO); 
		
		return "redirect:/edu/course/enrollInfo.do?cosID=" +cosID+ "&crtPage=" +crtPage+ "&rowCnt=" +rowCnt+ "&enrollID="+ enrollID ;
	}   
	
	

	
		

	//접수상태리스트 일괄상태변경
		@ResponseBody
		@RequestMapping(value = "/updateEnrollStateAll.json", method = RequestMethod.POST)
		public void updateEnrollStateAll(@RequestBody AllChangeCodeVO allChangeCodeVO) throws Exception {
			System.out.println(allChangeCodeVO.toString());
			
			courseListService.updateEnrollStateAll(allChangeCodeVO);
			
		}	
	
	
}
