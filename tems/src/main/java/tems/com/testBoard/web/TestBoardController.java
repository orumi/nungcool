package tems.com.testBoard.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.testBoard.service.TestBoardService;

@Controller
public class TestBoardController {
	
	@Resource
	TestBoardService tbService;
	
	//페이지 로드
	@RequestMapping(value = "/com/testBoard/jangme/test.do", method = RequestMethod.GET)
    public String goTestBoard(ModelMap model, HttpServletRequest req) throws Exception {

        return "tems/com/testBoard/TestBoard";
    }
	
	//테이블에 저장된 데이터 가져오기
	@RequestMapping(value = "/com/testBoard/jangme/loadDate.do", method = RequestMethod.POST)
	@ResponseBody
	public List findAllList() throws Exception {
		
		return tbService.findAllList(); 
	}
	
	//페이지 로드2
	@RequestMapping(value = "/com/testBoard/jangme/test2.do", method = RequestMethod.GET)
    public String goTestBoard2(ModelMap model, HttpServletRequest req) throws Exception {

		return "tems/com/testBoard/TestBoard2";
    }
	
}
