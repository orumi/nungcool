package exam.com.member.web;


import exam.com.common.ComIdCreator;
import exam.com.main.model.LoginUserVO;
import exam.com.main.service.impl.LoginUserDAO;
import exam.com.member.model.CompanyVO;
import exam.com.member.model.IdInquiry;
import exam.com.member.model.MemberVO;
import exam.com.member.model.PswordChg;
import exam.com.member.service.JoinMemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class MemberController {

    @Resource(name = "joinMemberService")
    private JoinMemberService joinMemberService;

    @Resource(name = "loginUserDAO")
    private LoginUserDAO loginUserDAO;

    private static final Logger LOGGER = LoggerFactory.getLogger(MemberController.class);

    /**
     * egov-com-servlet.xml setting
     * servlet context
     **/
    @RequestMapping(value = "/member/pageMember.do", method = RequestMethod.GET)
    public String pageMember(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String pageURL = request.getParameter("pageURL");
        String jspPath = "member/regMember_clause";

        if ("infor".equals(pageURL)) {
            jspPath = "member/regMember_infor";
        } else if ("msg".equals(pageURL)) {
            jspPath = "member/regMember_msg";
        }

 		/* tiles setting tiles.xml */
        return jspPath;
    }


    @RequestMapping(value = "/member/checkCompRegi.json", method = RequestMethod.POST)
    public
    @ResponseBody
    List checkCompRegi(Model model, @RequestParam String data) throws Exception {

        CompanyVO companyVO = new CompanyVO();
        companyVO.setCompName(data);

        List list = joinMemberService.checkCompRegi(companyVO);

        return list;

    }

    @RequestMapping(value = "/member/idValidation.json", method = RequestMethod.POST)
    public
    @ResponseBody
    Map idValidation(Model model, MemberVO memberVO) throws Exception {

        String userIdValid = joinMemberService.idValidation(memberVO);
        String emailValid = joinMemberService.emailValid(memberVO);
        String phoneValid = joinMemberService.phoneValid(memberVO);

        Map map = new HashMap<String, String>();

        map.put("id", userIdValid);
        map.put("email", emailValid);
        map.put("phone", phoneValid);

        return map;
    }

    @RequestMapping(value = "/member/crtPswordChk.json", method = RequestMethod.POST)
    public
    @ResponseBody
    Boolean crtPswordChk(HttpServletRequest request, Model model, @RequestParam("data") String psword) throws Exception {


        Boolean trueFalse = false;

        LoginUserVO loginUserVO = loginUserDAO.selectLoginUser((LoginUserVO) request.getSession().getAttribute("loginUserVO"));

        String encordedPs = encrypt(psword);

        if (loginUserVO.getMempw().equals(encordedPs)) {
            trueFalse = true;
        } else {
            trueFalse = false;
        }

        return trueFalse;
    }


    @RequestMapping(value = "/member/bisNumCheck.json", method = RequestMethod.POST)
    public
    @ResponseBody
    String bisNumCheck(Model model, @RequestParam("data") String bisNum) throws Exception {


        CompanyVO companyVO = new CompanyVO();
        companyVO.setBisNum(bisNum);
        List<CompanyVO> list = (List<CompanyVO>) joinMemberService.bisNumCheck(companyVO);

        String msg = "";
        if (list.size() == 0) {
            msg = "등록 되어있지 않은 사업자 번호 입니다. " +
                    "사용 하셔도 좋습니다.";
        } else {
            for (CompanyVO vo : list) {
                msg += vo.getCompName() + " ";
            }
            msg += "으로 이미 가입되어 있는 번호 입니다. ";
        }
        return msg;
    }


    @RequestMapping(value = "/member/joinMemberAction.do", method = RequestMethod.POST)
    public String joinMemberAction(HttpServletRequest request, Model model, MemberVO memberVO, CompanyVO companyVO) throws Exception {


        memberVO.setPsword(encrypt(memberVO.getPsword()));// 비밀번호 변환

        if (companyVO.getComId().equals("")) {

            String comId = ComIdCreator.getToday() + ComIdCreator.getNowTime(6);
            companyVO.setComId(comId);
            memberVO.setComId(comId);

            try {
                joinMemberService.insertJoinCompany(companyVO);
                joinMemberService.insertJoinMember(memberVO);
                request.getSession().setAttribute("welcomeJoinId", memberVO.getUserId());
                request.getSession().setAttribute("welcomeJoinName", memberVO.getUserNm());
            } catch (Exception e) {
                System.out.println(e.toString());
                return e.toString();
            }

        } else {

            try {
                joinMemberService.insertJoinMember(memberVO);
                request.getSession().setAttribute("welcomeJoinId", memberVO.getUserId());
                request.getSession().setAttribute("welcomeJoinName", memberVO.getUserNm());
            } catch (Exception e) {
                System.out.println(e.toString());
                return e.toString();
            }
        }

        return "redirect:/member/jumpToFinishJoinMember.do";
    }

    @RequestMapping(value = "/member/jumpToFinishJoinMember.do", method = RequestMethod.GET)
    public String jumpToFinishJoinMember(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

        return "member/regMember_msg";
    }


    @RequestMapping(value = "/member/pswordChange.do", method = RequestMethod.GET)
    public String pswordChange(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {


        return "member/pswordChange";
    }

    @RequestMapping(value = "/member/passwordChange.do", method = RequestMethod.POST)
    public String passwordChange(HttpServletRequest request, Model model, PswordChg vo) throws Exception {

        LoginUserVO loginUserVO = (LoginUserVO) request.getSession().getAttribute("loginUserVO");
        vo.setMemid(loginUserVO.getMemid());
        vo.setNewPsword(encrypt(vo.getNewPsword()));

        loginUserDAO.updateUserPassword(vo);

        return "redirect:/setMain.do";

    }


    @RequestMapping(value = "/member/idInquiry.do", method = RequestMethod.GET)
    public String idInquiry(HttpServletRequest request, Model model) throws Exception {


        return "member/idInquiry";

    }

    @ResponseBody
    @RequestMapping(value = "/member/idInquiryAction.json", method = RequestMethod.POST)
    public Map idInquiryAction(HttpServletRequest request, Model model, IdInquiry idInquiry) throws Exception {

        Map map = new HashMap();
        String messageBack = "";
        List list = joinMemberService.selectIdInquiry(idInquiry);

        if(list.size()>=1){
           IdInquiry vo = (IdInquiry) list.get(0);
            messageBack =  "귀하의 아이디는 " + vo.getUserId() + " 입니다." ;
            map.put("message", messageBack);
            return map;
        } else {
            messageBack = "일치하는 정보를 찾을 수 없습니다.";
            map.put("message", messageBack);
            return map;
        }

    }

    private String encrypt(String input) throws NoSuchAlgorithmException {
        String output = "";
        StringBuffer sb = new StringBuffer();
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        md.update(input.getBytes());
        byte[] msgb = md.digest();
        for (int i = 0; i < msgb.length; i++) {
            byte temp = msgb[i];
            String str = Integer.toHexString(temp & 0xFF);
            while (str.length() < 2) {
                str = "0" + str;
            }
            str = str.substring(str.length() - 2);
            sb.append(str);
        }
        output = sb.toString();
        return output;
    }


}