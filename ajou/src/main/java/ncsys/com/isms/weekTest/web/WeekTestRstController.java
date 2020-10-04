package ncsys.com.isms.weekTest.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.asset.service.model.AssetVersion;
import ncsys.com.isms.weekTest.service.WeekTestRstService;
import ncsys.com.isms.weekTest.service.WeekTestService;
import ncsys.com.isms.weekTest.service.model.WeekTestAstRst;
import ncsys.com.isms.weekTest.service.model.WeekTestField;
import ncsys.com.isms.weekTest.service.model.WeekTestFieldRst;
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
public class WeekTestRstController {

	
	@Resource(name="weekTestRstService")
	private  WeekTestRstService weekTestRstService;
	
	@Resource(name="assetService")
	private  AssetService assetService;
	
	@Resource(name="weekTestService")
	private  WeekTestService weekTestService;
	
	
	   
    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/weekTstRst.do")
    public String weekTstRst() throws Exception {
    	return "isms/weekTest/weekTstRst.tiles";
    }
    
    
    
    	
    
    /* week test item init */
    /**
     * 초기정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/weekTestItemRstInit.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void weekTestItemRstInit(HttpServletRequest request, HttpServletResponse response)  {
    	try{
	    	System.out.println("weekTestItemInit.json");
	    	
	    	JSONObject nJson = new JSONObject();
			
	    	/*자산 버전*/
	    	List<AssetVersion> assetVersionList =  assetService.selectAssetVersionList();
	    	nJson.put("assetVersionList", assetVersionList);
	    	
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
    @RequestMapping(value = "/weekTestItemAstRstList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void weekTestItemAstRstList(HttpServletRequest request, HttpServletResponse response, String astverid, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
			List<WeekTestAstRst> reWeekTestAstRst = weekTestRstService.selectWeekTestAstRst(astverid);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("reWeekTestAstRst", reWeekTestAstRst);
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
    @RequestMapping(value = "/weekTestItemFieldRstList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void weekTestItemFieldRstList(HttpServletRequest request, HttpServletResponse response, String astverid)  {
    	try{

	    	JSONObject nJson = new JSONObject();
			
	    	/* select Field */
	    	List<WeekTestField> reWeekTestField = weekTestService.selectWeekTestFieldList();
	    	nJson.put("reWeekTestField", reWeekTestField);
	    	
	    	/* select cross tab */
	    	ArrayList<HashMap<String, String>> reWeekTestFieldRstList = weekTestRstService.selectWeekTestFieldRstCrossTab(astverid);
			nJson.put("reWeekTestFieldRstList", reWeekTestFieldRstList);

			HashMap<String, String> totalWeekTestFieldRst = weekTestRstService.selectWeekTestFieldSumRst(astverid);
			nJson.put("totalWeekTestFieldRst", totalWeekTestFieldRst);
			
			
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}
    
    
    
 
    
    
}
