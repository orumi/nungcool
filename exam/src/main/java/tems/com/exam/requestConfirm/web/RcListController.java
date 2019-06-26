package tems.com.exam.requestConfirm.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RcListController {
	
	@RequestMapping(value="/tems/requestConfirm.do")
	public String selectRequestConfirmList(HttpServletRequest request, ModelMap model) throws Exception{
		
		return "tems/com/exam/requestConfirm/RcList";
	}
}
