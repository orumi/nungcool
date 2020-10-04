package ncsys.com.isms.cool.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ncsys.com.isms.measure.service.model.*;
import ncsys.com.isms.measure.service.MeasureService;
import ncsys.com.isms.measure.service.model.Measure;
import ncsys.com.util.Criteria;
import ncsys.com.util.PageMaker;
import net.sf.json.JSONObject;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.LoginVO;


@Controller
@RequestMapping("/cool/planned")
public class PlannedController {

	
    /**
     * 통제항목 관련 목록창 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/list.do")
    public String plannedList() throws Exception {
    	return "isms/cool/planned.tiles";
    }

    
    /**
     * 통제항목 관련 목록창 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/voidList.do")
    public String voidList(String vo) throws Exception {
    	
    	System.out.println("#############:"+vo);;
    	
    	return " ";
    }
    
    
    
}
