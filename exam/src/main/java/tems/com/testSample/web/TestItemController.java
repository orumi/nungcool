package tems.com.testSample.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import tems.com.testSample.model.TestItemDefaultVO;
import tems.com.testSample.model.TestItemVO;
import tems.com.testSample.service.TestItemService;

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : TestItemController.java
 * @Description : TestItem Controller class
 * @Modification Information
 *
 * @author test
 * @since 1
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=TestItemVO.class)
public class TestItemController {

    @Resource(name = "testItemService")
    private TestItemService testItemService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * TEST_ITEM 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 TestItemDefaultVO
	 * @return "/testItem/TestItemList"
	 * @exception Exception
	 */
    @RequestMapping(value="/testItem/TestItemList.do")
    public String selectTestItemList(@ModelAttribute("searchVO") TestItemDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List<?> testItemList = testItemService.selectTestItemList(searchVO);
        model.addAttribute("resultList", testItemList);
        
        int totCnt = testItemService.selectTestItemListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "tems/com/testSample/testItem/TestItemList";
    } 

    
    
    @RequestMapping(value="/testItem/TestItemList.json")
    public @ResponseBody List<TestItemVO> selectTestItemJson(@ModelAttribute("searchVO") TestItemDefaultVO searchVO, 
    		ModelMap model, HttpServletResponse response, HttpServletRequest req)
            throws Exception {

    	List<TestItemVO> testItemList = testItemService.selectTestItemList(searchVO);
	    //response.setHeader( "content-length", Integer.toString(testItemList.toString().getBytes().length+1));		--속도가 느려짐..
        return testItemList;
    } 
    
    @RequestMapping("/testItem/addTestItemView.do")
    public String addTestItemView(
            @ModelAttribute("searchVO") TestItemDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("testItemVO", new TestItemVO());
        return "tems/com/testSample/testItem/TestItemRegister";
    }
    
    @RequestMapping("/testItem/addTestItem.do")
    public String addTestItem(
            TestItemVO testItemVO,
            @ModelAttribute("searchVO") TestItemDefaultVO searchVO, SessionStatus status)
            throws Exception {
        testItemService.insertTestItem(testItemVO);
        status.setComplete();
        return "forward:/testItem/TestItemList.do";
    }
    
    @RequestMapping("/testItem/updateTestItemView.do")
    public String updateTestItemView(
            @RequestParam("tblItemCode") java.math.BigDecimal tblItemCode ,
            @ModelAttribute("searchVO") TestItemDefaultVO searchVO, Model model)
            throws Exception {
        TestItemVO testItemVO = new TestItemVO();
        testItemVO.setTblItemCode(tblItemCode);
        // 변수명은 CoC 에 따라 testItemVO
        model.addAttribute(selectTestItem(testItemVO, searchVO));
        return "tems/com/testSample/testItem/TestItemRegister";
    }

    @RequestMapping("/testItem/selectTestItem.do")
    public @ModelAttribute("testItemVO")
    TestItemVO selectTestItem(
            TestItemVO testItemVO,
            @ModelAttribute("searchVO") TestItemDefaultVO searchVO) throws Exception {
        return testItemService.selectTestItem(testItemVO);
    }

    @RequestMapping("/testItem/updateTestItem.do")
    public String updateTestItem(
            TestItemVO testItemVO,
            @ModelAttribute("searchVO") TestItemDefaultVO searchVO, SessionStatus status)
            throws Exception {
        testItemService.updateTestItem(testItemVO);
        status.setComplete();
        return "forward:/testItem/TestItemList.do";
    }
    
    @RequestMapping("/testItem/deleteTestItem.do")
    public String deleteTestItem(
            TestItemVO testItemVO,
            @ModelAttribute("searchVO") TestItemDefaultVO searchVO, SessionStatus status)
            throws Exception {
        testItemService.deleteTestItem(testItemVO);
        status.setComplete();
        return "forward:/testItem/TestItemList.do";
    }
    
    @RequestMapping(value="/getJsonByMap.do")
    public @ResponseBody Map<String , Object> getJsonByMap() {
        Map<String, Object> jsonObject = new HashMap<String, Object>();
        Map<String, Object> jsonSubObject = null;
        ArrayList<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
             
        //1번째 데이터
        jsonSubObject = new HashMap<String, Object>();
        jsonSubObject.put("idx", 1);
        jsonSubObject.put("title", "제목입니다");
        jsonSubObject.put("create_date", new Date());
        jsonList.add(jsonSubObject);
        //2번째 데이터
        jsonSubObject = new HashMap<String, Object>();
        jsonSubObject.put("idx", 2);
        jsonSubObject.put("title", "두번째제목입니다");
        jsonSubObject.put("create_date", new Date());
        jsonList.add(jsonSubObject);
             
        jsonObject.put("success", true);
        jsonObject.put("total_count", 10);
        jsonObject.put("result_list", jsonList);
             
        return jsonObject; 
    }


}
