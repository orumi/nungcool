package ncsys.com.isms.weekTest.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.weekTest.service.WeekTestService;
import ncsys.com.isms.weekTest.service.model.WeekTestField;
import ncsys.com.isms.weekTest.service.model.WeekTestItem;
import ncsys.com.isms.weekTest.service.model.WeekTestItemList;
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
@RequestMapping("/weekTest")
public class WeekTestController {

	
	@Resource(name="weekTestService")
	private  WeekTestService weekTestService;
	
	@Resource(name="assetService")
	private  AssetService assetService;
	
	
    /**
     * 통제항목 관련 목록창 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/weekTstItem.do")
    public String weekTstItem() throws Exception {
    	return "isms/weekTest/weekTstItem.tiles";
    }

    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/weekTstItemDetail.do")
    public String weekTstItemDetail() throws Exception {
    	return "isms/weekTest/weekTstItemDetail.popup";
    }

    
    /* week test item init */
    /**
     * 초기정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/weekTestItemInit.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void weekTestItemInit(HttpServletRequest request, HttpServletResponse response)  {
    	try{
	    	System.out.println("weekTestItemInit.json");
	    	
	    	JSONObject nJson = new JSONObject();
			
	    	/* 자산 그분 */
	    	List<AssetGroupList> reAssetGroupList =  assetService.selectAssetGroupList();
	    	nJson.put("reAssetGroupList", reAssetGroupList);
	    	
	    	/*점검 영역 */
	    	List<WeekTestField> reWeekTestField = weekTestService.selectWeekTestFieldList();
	    	nJson.put("reWeekTestField", reWeekTestField);
	    	
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}    
    
    /*week test item List */
    /**
     * 목록정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/weekTestItemList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void weekTestItemList(HttpServletRequest request, HttpServletResponse response, WeekTestItem weekTestItem, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
			List<WeekTestItemList> reWeekTestItemList = weekTestService.selectWeekTestItemList(weekTestItem);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("reWeekTestItemList", reWeekTestItemList);
			nJson.put("pageMaker", pageMaker);
			nJson.put("cri", cri);
			
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}    
    
    /*week test item detail */
    /**
     * 상세 정보
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/weekTestItemDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void weekTestItemDetail(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	JSONObject nJson = new JSONObject();
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		WeekTestItem detail = new ObjectMapper().readValue(json, WeekTestItem.class);
    		detail.setUserId(loginVO.getId());
    		
	    	if("modify".equals(mode)){
	    		
	    		if("I".equals(detail.getActionmode()) ){
	    			weekTestService.insertWeekTestItem(detail);
	    		} else if("D".equals(detail.getActionmode()) ){
	    			weekTestService.deleteWeekTestItem(detail);
	    		} else if("U".equals(detail.getActionmode())){
	   				weekTestService.updateWeekTestItem(detail);
	    		}
	
	    	} else if("select".equals(mode)){
	    		
	    		WeekTestItem reDetail = weekTestService.selectWeekTestItem(detail); 
	    		nJson.put("reDetail", reDetail);
	    	}
	    	
	    	nJson.put("reVal", "ok_resend");
	    	
    	} catch (Exception e ){
    		nJson.put("reVal", "failure_resend");
    		System.out.println(e);
    	} finally {
    		try {
	    		PrintWriter out = response.getWriter();
		        out.write(nJson.toString());
		        out.flush();
		        out.close();
    		} catch (Exception e){ }
    	}
	}
    
    
    /*week test field list */
    /**
     * 목록정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/weekTstFieldList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void weekTstFieldList(HttpServletRequest request, HttpServletResponse response, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
			List<WeekTestField> reWeekTestField = weekTestService.selectWeekTestFieldList();
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("reWeekTestField", reWeekTestField);
			nJson.put("pageMaker", pageMaker);
			nJson.put("cri", cri);
			
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
    	} catch (Exception e ){
    		System.out.println(e);
    	}
	} 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
