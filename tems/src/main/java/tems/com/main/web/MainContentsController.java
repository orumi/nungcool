package tems.com.main.web;




import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import tems.com.login.model.LoginUserVO;
import tems.com.login.model.ReqListVO;
import tems.com.login.service.LoginUserService;
import tems.com.main.model.ProgressInfoVO;
import tems.com.main.service.MainContentsService;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;




@Controller
public class MainContentsController {

    @Resource(name = "loginUserService")
    private LoginUserService loginUserService;
    @Resource(name = "mainContentsService")
    private MainContentsService mainContentsService;


    @RequestMapping("/setMain.do")
    public String setMain(HttpServletRequest req, HttpServletResponse resp, ModelMap model) throws Exception {

        LoginUserVO loginUserVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");

        List<ReqListVO> ReqList = (List<ReqListVO>) loginUserService.getReqList(loginUserVO);

        model.addAttribute("ReqList", ReqList);

        // 테이블 좌측 1번라인 처리
        List reqTestRegList = mainContentsService.selectReqTestRegList();
        model.addAttribute("reqTestRegList", reqTestRegList);
        // 테이블 좌측 1번라인 처리 End


        //테이블 우측 1번라인 처리
        ProgressInfoVO proInfoVO = new ProgressInfoVO();
        proInfoVO.setUserID(loginUserVO.getAdminid());
        List progressInfoList = mainContentsService.selectProgressInfo(proInfoVO);
        model.addAttribute("progressInfoList", progressInfoList);
        //테이블 우측 1번라인 처리

        // 테이블 좌측 2번라인 처리
        List progressList = mainContentsService.selectProgressStateList();
        model.addAttribute("progressList", progressList);
        // 테이블 좌측 2번라인 처리 END




        //공지사항 게시판
        List noticeList = mainContentsService.selectBoardList();
        model.addAttribute("noticeList", noticeList);
        //자료실 게시판




        return "tems/com/login/main";
    }


}
