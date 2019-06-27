package tems.com.exam.copyReceive.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CopyReceiveListController {
	
	@RequestMapping(value="/tems/copyReceive.do")
	public String selectCopyReceiveList(HttpServletRequest request, ModelMap model) throws Exception{
		
		return "tems/com/exam/ccReceive/CopyReceiveList";
	}
}
