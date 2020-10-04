package ncsys.com.isms.concern.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.model.AssetVersion;
import ncsys.com.isms.concern.service.CriteriaItemService;
import ncsys.com.isms.concern.service.RegulationTstService;
import ncsys.com.isms.concern.service.impl.CriteriaItemServiceImpl;
import ncsys.com.isms.concern.service.model.CriteriaItem;
import ncsys.com.isms.concern.service.model.CriteriaVersion;
import ncsys.com.isms.concern.service.model.RegulationTst;
import ncsys.com.isms.concern.service.model.RegulationTstList;
import ncsys.com.isms.hierarchy.service.RegulationService;
import ncsys.com.isms.hierarchy.service.model.*;
import ncsys.com.isms.weekTest.service.WeekTestService;
import ncsys.com.isms.weekTest.service.model.WeekTestAstRst;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlDetail;
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
@RequestMapping("/concern")
public class CriteriaItemController {

	
	@Resource(name="criteriaItemService")
	private  CriteriaItemService criteriaItemService;
	
	
    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/criteriaItem.do")
    public String criteriaItem() throws Exception {
    	return "isms/concern/criteriaItem.tiles";
    }

    
    
    @RequestMapping(value="/criteriaVersion.do")
    public String criteriaVersion() throws Exception {
    	return "isms/concern/criteriaVersion.popup";
    }
    
    @RequestMapping(value="/criteriaItemDetail.do")
    public String criteriaItemDetail() throws Exception {
    	return "isms/concern/criteriaItemDetail.popup";
    }
    
    /* week test item init */
    /**
     * 초기정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/criteriaItemInit.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void criteriaItemInit(HttpServletRequest request, HttpServletResponse response)  {
    	try{
	    	System.out.println("weekTestItemInit.json");
	    	
	    	JSONObject nJson = new JSONObject();
			
	    	// 버전정보
	    	List<CriteriaVersion> reCriteriaVersion = criteriaItemService.selectCriteriaVersion();
	    	nJson.put("reCriteriaVersion", reCriteriaVersion);

	    	
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
    @RequestMapping(value = "/criteriaItemList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void criteriaItemList(HttpServletRequest request, HttpServletResponse response, CriteriaItem criteriaItem, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
			List<CriteriaItem> reCriteriaItem = criteriaItemService.selectCriteriaItem(criteriaItem);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			nJson.put("reCriteriaItem", reCriteriaItem);
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
    @RequestMapping(value = "/criteriaVersionDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void criteriaVersionDetail(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	JSONObject nJson = new JSONObject();
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		System.out.println(json);
    		
    		CriteriaVersion criteriaVersion = new ObjectMapper().readValue(json, CriteriaVersion.class);
    		
    		
	    	if("modify".equals(mode)){
		    		if(	"I".equals(criteriaVersion.getActionmode() )){
		    			
		    			criteriaItemService.insertCriteriaVersion(criteriaVersion);
		    			
		    		} else if("U".equals(criteriaVersion.getActionmode()) ){
		    			
		    			criteriaItemService.updateCriteriaVersion(criteriaVersion);
		    			
		    		} else if("D".equals(criteriaVersion.getActionmode()) ){
	    				
		    			criteriaItemService.deleteCriteriaVersion(criteriaVersion);
		    			
		    		}
		    		
		    }
	    	
	    	nJson.put("reVal", "ok_resend");
	    	
	    	List<CriteriaVersion> reCriteriaVersion = criteriaItemService.selectCriteriaVersion();
	    	nJson.put("reCriteriaVersion", reCriteriaVersion);
	    	
	    	
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
    
    /*week test item detail */
    /**
     * 상세 정보
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/criteriaItemDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void criteriaItemDetail(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	JSONObject nJson = new JSONObject();
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		System.out.println(json);
    		
    		CriteriaItem detail = new ObjectMapper().readValue(json, CriteriaItem.class);
    		
    		
	    	if("modify".equals(mode)){
	    		
	    		if ("I".equals(detail.getActionmode())) {
	    			criteriaItemService.insertCriteriaItem(detail);
	    		} else if ("U".equals(detail.getActionmode())) {
	    			criteriaItemService.updateCriteriaItem(detail);
	    		} else if ("D".equals(detail.getActionmode())) {
	    			criteriaItemService.deleteCriteriaItem(detail);
	    		}
	    		
	    	} else if("select".equals(mode)){
		    	CriteriaItem reCriteriaItem = criteriaItemService.selectCriteriaItemDetail(detail);
		    	nJson.put("reCriteriaItem", reCriteriaItem);
		    	
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
    
    
}
