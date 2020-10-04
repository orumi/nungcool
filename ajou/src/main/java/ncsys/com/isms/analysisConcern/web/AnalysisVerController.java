package ncsys.com.isms.analysisConcern.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ncsys.com.isms.analysisConcern.service.AnalysisVerService;
import ncsys.com.isms.analysisConcern.service.model.AnalysisVer;
import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.asset.service.model.AssetVersion;
import ncsys.com.isms.concern.service.CriteriaItemService;
import ncsys.com.isms.concern.service.model.CriteriaVersion;
import ncsys.com.isms.hierarchy.service.RegulationService;
import ncsys.com.isms.hierarchy.service.model.Version;
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
@RequestMapping("/analysisConcern")
public class AnalysisVerController {

	@Resource(name="analysisVerService")
	private AnalysisVerService analysisVerService;
	
	@Resource(name="regulationService")
	private  RegulationService regulationService;
	
	@Resource(name="criteriaItemService")
	private  CriteriaItemService criteriaItemService;
	
	@Resource(name="assetService")
	private  AssetService assetService;
	
    /**
     * 통제항목 관련 목록창 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/analyVer.do")
    public String analyVer() throws Exception {
    	return "isms/analysisConcern/analyVer.tiles";
    }
    
    @RequestMapping(value="/analyVerDetail.do")
    public String analyVerDetail() throws Exception {
    	return "isms/analysisConcern/analyVerDetail.popup";
    }

    
    /* week test item init */
    /**
     * 초기정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/analysisVerInit.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void analysisVerInit(HttpServletRequest request, HttpServletResponse response)  {
    	try{
	    	System.out.println("analysisVerInit.json");
	    	
	    	JSONObject nJson = new JSONObject();
			
	    	
	    	// 체계버전정보
	    	List<Version> versions = regulationService.selectVersion();
	    	nJson.put("versions", versions);
	    	
	    	// 버전정보
	    	List<CriteriaVersion> ctrVersions = criteriaItemService.selectCriteriaVersion();
	    	nJson.put("ctrVersions", ctrVersions);
	    	
	    	
	    	List<AssetVersion> astVersions =  assetService.selectAssetVersionList();
	    	nJson.put("astVersions", astVersions);
	    	
	    	
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
    @RequestMapping(value = "/analysisVerList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void analysisVerList(HttpServletRequest request, HttpServletResponse response, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
			List<AnalysisVer> reAnalysisVer = analysisVerService.selectAnalysisVerList();
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("reAnalysisVer", reAnalysisVer);
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
    @RequestMapping(value = "/analysisVerDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void analysisVerDetail(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	JSONObject nJson = new JSONObject();
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		AnalysisVer detail = new ObjectMapper().readValue(json, AnalysisVer.class);
    		detail.setUserId(loginVO.getId());
    		
	    	if("modify".equals(mode)){
	    		
	    		if("I".equals(detail.getActionmode()) ){
	    			analysisVerService.insertAnalysisVer(detail);
	    		} else if("D".equals(detail.getActionmode()) ){
	    			analysisVerService.deleteAnalysisVer(detail);
	    		} else if("U".equals(detail.getActionmode())){
	   				analysisVerService.updateAnalysisVer(detail);
	    		}
	
	    	} else if("select".equals(mode)){
	    		
	    		AnalysisVer reDetail = analysisVerService.selectAnalysisVer(detail); 
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
    
    
    
    
    
    
    
    
    
}
