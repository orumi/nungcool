package ncsys.com.portal.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.protocol.HttpContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import ncsys.com.portal.service.PortalService;
import ncsys.com.portal.service.model.LeftMenu;

@Controller
public class PortalController {



    /**
     * Portal index .
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/main/portal.do")
    public String doMainPortal(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
    	try {
	    	System.out.println("PORTAL SYSTEM MAIN ");
	    	//LoginVO loginVO = (LoginVO)request.getSession().getAttribute("loginVO");

	    	/*System.out.println("getUniqId :  "+loginVO.getUniqId());*/


	    	/*System.out.println("PORTAL SYSTEM MAIN ");*/


	    	return "main/portal.tiles";

    	} catch (Exception e) {
    		System.out.println("doMainPortal : "+e);
    		return "/error";
    	}
    }


    @RequestMapping(value="/ncsys/cool/main.do")
    public String doNcsysMain() throws Exception {

    	return "ncsys/cool/main.tiles";
    }


}
