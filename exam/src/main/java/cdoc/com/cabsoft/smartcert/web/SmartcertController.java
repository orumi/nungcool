package cdoc.com.cabsoft.smartcert.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cdoc.com.cabsoft.smartcert.service.SmartcertService;
import exam.com.common.Criteria;

@Controller
public class SmartcertController {
	
	@Resource(name="SmartcertService")
	SmartcertService smartcertService;
	
    private static final Logger LOGGER = LoggerFactory.getLogger(SmartcertController.class);
    
    /**
     * 증명발급 뷰어 출력
     * @param request
     * @param response
     * @param cri
     * @throws Exception
     */
    @RequestMapping("/eform/smartcert.do")
    public void smartcert(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	boolean setUseOverlap = true;
    	smartcertService.processRequest(request, response, setUseOverlap);
    }
    
    /**
     * 직원용 증명발급 PDF 다운로드
     * @param request
     * @param response
     * @param cri
     * @return
     * @throws Exception
     */
    @RequestMapping("/eform/smartcertTempPdf.do")
    public void smartcertTempPdf(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String result = smartcertService.exportTempPdf(request, response);
    	LOGGER.debug("smartcertTempPdf result : " + result);
//    	ModelAndView mv = new ModelAndView();
//    	mv.addObject("result", result);
    	response.getWriter().println("{\"result\" : \""+result+"\"}");
    }
    
    
    /**
     * 증명발급 테스트 페이지
     * @param req
     * @param resp
     * @param cri
     * @return
     * @throws Exception
     */
    @RequestMapping("/eform/test.do")
    public String loadEform(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        return "cdoc/eform/eform_test";
    }
}
