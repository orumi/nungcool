package exam.com.main.web;


import exam.com.common.ComIdCreator;
import exam.com.common.Criteria;
import exam.com.common.StringUtils;
import exam.com.community.faq.service.FaqService;
import exam.com.community.notice.model.BoardVO;
import exam.com.community.notice.service.NoticeService;
import exam.com.main.model.*;
import exam.com.main.service.LoginUserService;
import exam.com.main.service.MainService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;



@Controller
public class MainWebController {

    @Resource(name = "loginUserService")
    private LoginUserService loginUserService;
    
    @Resource(name = "mainService")
    private MainService mainService;

	@Resource(name = "noticeService")
	private NoticeService noticeService;

	@Resource(name = "faqService")
	private FaqService faqService;

	private static final Logger LOGGER = LoggerFactory.getLogger(MainWebController.class);
    
 	/* egov-com-servlet.xml setting 
 	 * servlet context */
    /* kpetro portal-> intro page  */
 	@RequestMapping("/intro/selection.do")
 	public String setMain(HttpServletRequest req, HttpServletResponse resp) throws Exception {

 		
 		//System.out.println("exam/selection.do ");
 		
 		/* tiles setting tiles.xml */
 		return "intro/selection";
 	}
 	
 	/* goLogin page */
 	@RequestMapping("/login/userLogin.do")
 	public String setLogin(HttpServletRequest req, HttpServletResponse resp) throws Exception {

 		
 		//System.out.println("login/userLogin.do.do ");
 		
 		/* tiles setting tiles.xml */
 		return "login/userLogin";
 	}
 	
 	/* actionLogin Proc Page */
 	@RequestMapping("/login/loginProc.do")
 	public String actionLoginProc(HttpServletRequest req, HttpServletResponse resp) throws Exception {
 		
 		String loginPage = "";
 		String loginTag = req.getParameter("loginTag");
 		
 		if("OC".equals(loginTag)){
 			/* 기존 기업회원  아이디 재발급 */
 			loginPage = "login/loginproc/login_oc";
 		} else if("P".equals(loginTag)){
 			/* 개인 회원 아이디 확인 */
 			loginPage = "login/loginproc/login_p";
 		} else if("UD".equals(loginTag)){
 			/* 업체회원 정보 수정 */
 			loginPage = "login/loginproc/login_ud";
 		} else if("CU".equals(loginTag)){
 			/* 개인회원 업체 등록 */
 			loginPage = "login/loginproc/login_cu";
 		} else if("Y".equals(loginTag)){
 			loginPage = "login/loginproc/login_y";
 		}

 		/* tiles setting tiles.xml */
 		return loginPage;
 	}
 	
 	
 	/*  업체회원 아이디 발급  */
    @RequestMapping(value = "/login/loginProcService.do", method = RequestMethod.POST)
    public String actionLoginProcService(
    		@ModelAttribute("loginUserVO") LoginUserVO loginUserVO, BindingResult bindingResult,
    		HttpServletRequest request, HttpServletResponse response) throws Exception {
   	 
    	if(bindingResult.hasErrors()){
    		System.out.println(loginUserVO);
    		LOGGER.error("No MainWebControl ");
    	}
    		
    	JSONObject nJson = new JSONObject();
        try{
        	String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";
        	
        	if("actionChkNewId".equals(tag)){
        		String newid = request.getParameter("newid");
        		
        		int cnt = loginUserService.selectCountNewId(newid);
        		nJson.put("RESULT_CNT", cnt);
        		
        	} else if ("actionAdjustNewid".equals(tag)){
        		// 신규 아이디 적용
        		String newid = request.getParameter("newid");
        		LoginOldUserVO loginOldUserVO = (LoginOldUserVO)request.getSession().getAttribute("loginOldUserVO");
        		if(loginOldUserVO==null){
        			nJson.put("RESULT_YN","N");
        			nJson.put("RESULT_MESSAGE","Session Out");
        		} else {
        			loginOldUserVO.setNewid(newid);
        			
        			loginUserService.adjustNewId(loginOldUserVO);
        			
        			/* set memid & pw */
        			loginUserVO.setMemid(newid);
        			loginUserVO.setMempw(loginOldUserVO.getMempw());
        			
                	LoginUserVO loginVO = loginUserService.selectLoginUser(loginUserVO);
                	
        	        if(loginVO !=null ){
        	        	// 신규 로그인 프로세스 
        	        	request.getSession().setAttribute("loginUserVO", loginVO);
        	        	nJson.put("RESULT_LOGIN", "Y");
        	        }
        			
        			nJson.put("RESULT_YN","Y");
        			
        			
        		}
        		
        	}
        	
        }catch(Exception e){
       	 	nJson.put("RESULT_YN"     ,"N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.print(nJson.toString());
        out.flush();
        out.close();
        
        return null;
    } 	
    
 	
 	/*  로그인 프로세스 최초  */
    @RequestMapping(value = "/login/loginService.do", method = RequestMethod.POST)
    public String actionLoginService(@ModelAttribute("loginUserVO") LoginUserVO loginUserVO, BindingResult bindingResult,
                                    ModelMap model, HttpServletRequest request, HttpServletResponse response)
         throws Exception {
   	 
    	if(bindingResult.hasErrors()){
    		System.out.println(loginUserVO);
    		LOGGER.error("No MainWebControl ");
    	}
    		
    	JSONObject nJson = new JSONObject();

        String jsonText = "";
        try{
	        // 비밀번호 인코딩;..  
        	loginUserVO.setMempw(StringUtils.encryt(loginUserVO.getMempw()));
        	
        	
        	LoginUserVO loginVO = loginUserService.selectLoginUser(loginUserVO);
        	
        	
	        if(loginVO !=null ){
	        	// 신규 로그인 프로세스 
	        	request.getSession().setAttribute("loginUserVO", loginVO);
	        	nJson.put("RESULT_LOGIN", "Y");
	        } else {
	          // 기존 로그인 
	        	List<LoginOldUserVO> list_loginOldUserVO = (List<LoginOldUserVO>)loginUserService.selectLoginOldUser(loginUserVO);
	        	if(list_loginOldUserVO != null && list_loginOldUserVO.size() == 1){
	        		request.getSession().setAttribute("loginOldUserVO", list_loginOldUserVO.get(0));
	        		nJson.put("RESULT_LOGIN", "OC");
	        	} else if(list_loginOldUserVO != null && list_loginOldUserVO.size() > 1){
	        		// 중복 로그인 처리
	        		nJson.put("RESULT_LOGIN", "M");
	        	} else {
	        		// 개인 로그인 처리 
	        		List<LoginPersonUserVO> list_loginPersonUserVO = (List<LoginPersonUserVO>)loginUserService.selectLoginPersonUser(loginUserVO);
	        		if(list_loginPersonUserVO !=null && list_loginPersonUserVO.size() == 1){
	        			request.getSession().setAttribute("loginPersonUserVO", list_loginPersonUserVO.get(0));
	        			nJson.put("RESULT_LOGIN", "P");
	        		} else {
	        			/* 신규, 기존기업, 기존개인이 아니 경우 */
	        			nJson.put("RESULT_LOGIN", "N");
	        		}
	        	}
	        }
	         	  
	         /*     nJson.put("RESULT_YN"     ,"Y");
	              nJson.put("RESULT_MESSAGE","");
	          } else {
	        	  nJson.put("RESULT_YN"     ,"N");
	              nJson.put("RESULT_MESSAGE",URLEncoder.encode("인증되지 않은 아이디 또는 비밀번호 입니다.","UTF-8"));
	          }*/
        }catch(Exception e){
       	 	nJson.put("RESULT_YN"     ,"N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
        jsonText = nJson.toString();
        PrintWriter out = response.getWriter();
        out.print(jsonText);
        out.flush();
        out.close();
        
        return null;
    } 	
 	
    
    
    

 	/*  회원정보 관리 (수정) */
    @RequestMapping(value = "/login/memberProcService.json")
    public String actionMemberProcService( HttpServletRequest request, HttpServletResponse response) throws Exception {
   	 
    		
    	JSONObject nJson = new JSONObject();
        try{
        	String formTag = request.getParameter("formTag")!=null?request.getParameter("formTag"):"";
        	
        	if("selectInfo".equals(formTag)){
        		/*회원정보 가져오기 */
        		LoginUserVO loginUserVO = (LoginUserVO) request.getSession().getAttribute("loginUserVO");
        		
        		if(loginUserVO!=null){
        			List<CompanyVO> list_companyVO = loginUserService.selectCompany(loginUserVO.getComid());
        			nJson.put("RESULT_COMPANY", list_companyVO);
        			
        			List<MemberVO> list_memberVO = loginUserService.selectMember(loginUserVO.getMemid());
        			nJson.put("RESULT_MEMBER", list_memberVO);
        			
        			nJson.put("RESULT_YN", "Y");
        			
        		} else {
        			nJson.put("RESULT_YN", "N");	
        		}
        		
        	} else if ("actionAdjustNewid".equals(formTag)){
        		// 신규 아이디 적용
        		String newid = request.getParameter("newid");
        		LoginOldUserVO loginOldUserVO = (LoginOldUserVO)request.getSession().getAttribute("loginOldUserVO");
        		if(loginOldUserVO==null){
        			nJson.put("RESULT_YN","N");
        			nJson.put("RESULT_MESSAGE","Session Out");
        		} else {
        			loginOldUserVO.setNewid(newid);
        			loginUserService.adjustNewId(loginOldUserVO);
        			nJson.put("RESULT_YN","Y");
        		}
        		
        	} else if ("updateCompany".equals(formTag)){
        		String data      = StringUtils.nvl(request.getParameter("frmData"),"");
        		JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
        		
   	        	CompanyVO companyVO = (CompanyVO)JSONObject.toBean(jarray.getJSONObject(0), CompanyVO.class);
    	        	
   	        	loginUserService.updateCompany(companyVO);
    	        
   	        	
   	        	
   	        	List<CompanyVO> list_companyVO = loginUserService.selectCompany(companyVO.getComid());
   	        	nJson.put("RESULT_COMPANY", list_companyVO);
   	        	
   	        	nJson.put("RESULT_YN", "Y");
    			
        	} else if ("updateMember".equals(formTag)){
        		String data      = StringUtils.nvl(request.getParameter("frmData"),"");
        		JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
        		
   	        	MemberVO memberVO = (MemberVO)JSONObject.toBean(jarray.getJSONObject(0), MemberVO.class);
    	        	
   	        	loginUserService.updateMember(memberVO);
    	        
   	        	List<MemberVO> list_memberVO = loginUserService.selectMember(memberVO.getMemid());
    			nJson.put("RESULT_MEMBER", list_memberVO);
   	        	
   	        	nJson.put("RESULT_YN", "Y");
    			
        	}
        	
        }catch(Exception e){
       	 	nJson.put("RESULT_YN","N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
    	PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
        
        return null;
    } 	    
    
    
    
    /*  개인회원 (수정) */
    @RequestMapping(value = "/login/personProcService.do")
    public String actionPersionProcService( HttpServletRequest request, HttpServletResponse response) throws Exception {
    	request.setCharacterEncoding("UTF-8"); 
    	response.setContentType("text/html;charset=UTF-8");
    	
    	JSONObject nJson = new JSONObject();
        try{
    	
        	String formTag = request.getParameter("formTag")!=null?request.getParameter("formTag"):"";
        	
        	if ("checkBizNum".equals(formTag)){
        		String bizNum = request.getParameter("bizNum");
        		CompanyVO vo = new CompanyVO();
        		vo.setBizno(bizNum);
        		
        		List<CompanyVO> list = (List<CompanyVO>) loginUserService.selectCompanybyBizNum(vo);
        		
        		nJson.put("RESULT_COMPANY", list);
   	        	
   	        	nJson.put("RESULT_YN", "Y");
        	} else if ("updateMember".equals(formTag)){
        		
        		String data      = StringUtils.nvl(request.getParameter("frmData"),"");
        		data = data.replaceAll("&quot;", "'");
        		
        		JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
        		
   	        	CompanyVO companyVO = (CompanyVO)JSONObject.toBean(jarray.getJSONObject(0), CompanyVO.class);
   	        	
        		MemberVO memberVO = (MemberVO)JSONObject.toBean(jarray.getJSONObject(0), MemberVO.class);
        		
        		JSONObject jObj = jarray.getJSONObject(0);
        		String comId = jObj.getString("comId");
        		// insert company;
        		if("".equals(comId)){
        			String newComid = ComIdCreator.getToday() + ComIdCreator.getNowTime(6);
                    companyVO.setComid(newComid);
                    memberVO.setComid(newComid);
                    
                    companyVO.setComname(jObj.getString("compName"));
                    companyVO.setBizno(jObj.getString("bisNum"));
                    companyVO.setBiztype(jObj.getString("bisType"));
                    companyVO.setCeoname(jObj.getString("ceoNm"));
                    companyVO.setMngphone(jObj.getString("compTelNum"));
                    companyVO.setZipcode(jObj.getString("compAddrNum"));
                    companyVO.setAddr1(jObj.getString("compAddr1"));
                    companyVO.setAddr2(jObj.getString("compAddr2"));
                    companyVO.setEname(jObj.getString("compEnNm"));
                    companyVO.setEceoname(jObj.getString("ceoEnNm"));
                    
                    loginUserService.insetCompany(companyVO);
                    
        		} else {
        			memberVO.setComid(comId);
        		}
        		memberVO.setZipcode(jObj.getString("userZipcode"));
        		memberVO.setAddr1(jObj.getString("userAddr1"));
        		memberVO.setAddr2(jObj.getString("userAddr2"));
        		//update member commid
        		loginUserService.updateRequestComid(memberVO);
        		loginUserService.updateMemberComid(memberVO);
        		
        		
        		// final member memyn
        		loginUserService.updateMemYN(memberVO);
        		
        		nJson.put("RESULT_YN","Y");
        	}
	    }catch(Exception e){
	   	 	nJson.put("RESULT_YN","N");
	        nJson.put("RESULT_MESSAGE",e.getMessage());
	    }
		PrintWriter out = response.getWriter();
	    out.write(nJson.toString());
	    out.flush();
	    out.close();
	    
	    return null;
	} 	
    
    
    
    
    
    
    
    
 	
 	@RequestMapping("/setMain.do")
 	public String setMain(HttpServletRequest request, HttpServletResponse respose, ModelMap model) throws Exception {

 		LoginUserVO loginUserVO = (LoginUserVO) request.getSession().getAttribute("loginUserVO");
 		String logout = request.getParameter("logout");
 		if(logout!=null && "true".equals(logout)){
 			request.getSession().removeAttribute("loginUserVO");
 		}
 		
 		if(loginUserVO!=null){
 			List<StateVO> list_sateVO = mainService.selectState(loginUserVO);
 			if(list_sateVO!=null && list_sateVO.size()>0){
 				request.setAttribute("stateVO", (StateVO)list_sateVO.get(0));
 			}
 		}






		/*
		* 공지사항 및 자주하는 질문 On 메인화면
		* */
		Criteria cri = new Criteria();
		List<BoardVO> noticeList = noticeService.listBoard(cri);
		List<exam.com.community.faq.model.BoardVO> faqList = faqService.listBoard(cri);

		List<BoardVO> notice = new ArrayList<BoardVO>();
		List<exam.com.community.faq.model.BoardVO> faq = new ArrayList<exam.com.community.faq.model.BoardVO>();

		for(int i = 0; i<6 ; i++){
			notice.add(noticeList.get(i));
			faq.add(faqList.get(i));

		}
		model.addAttribute("boardList", notice);
		model.addAttribute("faqList", faq);


 		return "main/main"; 
 	}
 	
 	
}
