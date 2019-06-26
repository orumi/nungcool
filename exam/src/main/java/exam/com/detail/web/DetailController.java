package exam.com.detail.web;


import exam.com.common.Criteria;
import exam.com.common.PageMaker;
import exam.com.common.service.XMLService;
import exam.com.detail.service.DetailService;
import exam.com.main.model.LoginUserVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class DetailController {

    @Resource(name = "detailService")
    private DetailService detailService;
    
    
    @Resource(name = "xmlService")
    private XMLService xmlService;
    

    private static final Logger LOGGER = LoggerFactory.getLogger(DetailController.class);

    /* egov-com-servlet.xml setting
     * servlet context */
    @RequestMapping("/detail/reqList.do")
    public String pageReqList(HttpServletRequest request, HttpServletResponse resp, Criteria cri) throws Exception {

        LoginUserVO loginUserVO = (LoginUserVO) request.getSession().getAttribute("loginUserVO");
        String memid = loginUserVO.getMemid();
        Map map = new HashMap();

        map.put("memid", memid);
        map.put("startNum", cri.getFirst());
        map.put("endNum", cri.getEnd());
        map.put("keyword", cri.getKeyword());
        map.put("reqstate", "4");   // 상태 -1 작성중, 0 접수대기 2 접수완료 

        int totalCount = detailService.selRecepInfoCnt(map);
        List detailList = detailService.selRecepInfoLookUp(map);

        PageMaker pageMaker = new PageMaker(cri, totalCount);

        request.setAttribute("detailList", detailList);
        request.setAttribute("pageMaker", pageMaker);


 		/* tiles setting tiles.xml */
        return "exam/detail/reqList";
    }

    /* go Page */
    @RequestMapping("/detail/state.do")
    public String pageState(HttpServletRequest req, HttpServletResponse resp, Criteria cri) throws Exception {

        LoginUserVO loginUserVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");
        String memid = loginUserVO.getMemid();
        Map map = new HashMap();

        map.put("memid", memid);
        map.put("startNum", cri.getFirst());
        map.put("endNum", cri.getEnd());
        map.put("keyword", cri.getKeyword());
        map.put("reqstate", "8");   // 상태 : -1.작성중, 0.접수대기 2.접수완료 4.분석진행 6.시험완료 7.결재완료 8. 발급완료 9.취소 
        
        int totalCount = detailService.selAnalProgStateCnt(map);

        List detailList = detailService.selAnalProgState(map);


        PageMaker pageMaker = new PageMaker(cri, totalCount);

        req.setAttribute("detailList", detailList);
        req.setAttribute("pageMaker", pageMaker);

        //System.out.println("login/userLogin.do.do ");
 		/* tiles setting tiles.xml */
        return "exam/detail/state";
    }

    
 	/* open Page */
 	@RequestMapping("/detail/detailRequest.do")
 	public String pageTestRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

 		/*/ start xml /*/
 		HashMap<String, String> map = new HashMap<String, String>();
 		map.put("reqid", "24505");
 		map.put("reportid", "1");
 		
 		String strXML = xmlService.selectXML(map);
 		
 		System.out.println(strXML);
 		/*end of xml test */
 		
 		
 		
 		
 		/* tiles setting tiles.xml */
 		return "exam/detail/detailRequest";
 	}

}
