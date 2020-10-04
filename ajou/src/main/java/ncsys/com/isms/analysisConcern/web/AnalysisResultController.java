package ncsys.com.isms.analysisConcern.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ncsys.com.isms.analysisConcern.service.AnalysisResultService;
import ncsys.com.isms.analysisConcern.service.AnalysisVerService;
import ncsys.com.isms.analysisConcern.service.model.AnalysisResult;
import ncsys.com.isms.analysisConcern.service.model.AnalysisVer;
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
@RequestMapping("/analysisConcern")
public class AnalysisResultController {

	
	@Resource(name="analysisResultService")
	private  AnalysisResultService analysisResultService;
	
	@Resource(name="analysisVerService")
	private AnalysisVerService analysisVerService;
	
	
	
	   
    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/analysisResult.do")
    public String weekTstRst() throws Exception {
    	return "isms/analysisConcern/analysisResult.tiles";
    }
    
    
    
    	
    
    /* week test item init */
    /**
     * 초기정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/analysisConcernResultInit.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void analysisConcernResultInit(HttpServletRequest request, HttpServletResponse response)  {
    	try{
	    	System.out.println("weekTestItemInit.json");
	    	
	    	JSONObject nJson = new JSONObject();
			
	    	/*분석 버전*/
	    	List<AnalysisVer> analysisVer = analysisVerService.selectAnalysisVerList();
	    	nJson.put("analysisVer", analysisVer);
	    	
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
    @RequestMapping(value = "/analysisConcernResultList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void analysisConcernResultList(HttpServletRequest request, HttpServletResponse response, AnalysisVer analysisVer)  {
    	try{

	    	JSONObject nJson = new JSONObject();
			
	    	/* select reAnalysisResult */
	    	List<AnalysisResult> reRegulationResult = analysisResultService.selectRegulationResult(analysisVer);
	    	nJson.put("reRegulationResult", reRegulationResult);
	    	
	    	List<AnalysisResult> reCriteriaResult = analysisResultService.selectCriteriaResult(analysisVer);
	    	nJson.put("reCriteriaResult", reCriteriaResult);
	    	
	    	List<AnalysisResult> reConcernResult = analysisResultService.selectConcernResult(analysisVer);
	    	nJson.put("reConcernResult", reConcernResult);
	    	
	    	
	    	ArrayList<AnalysisResult> reAnalysisResult = new ArrayList<AnalysisResult>();
			
	    	reAnalysisResult.addAll(reRegulationResult);
	    	reAnalysisResult.addAll(reCriteriaResult);
	    	reAnalysisResult.addAll(reConcernResult);
	    	
	    	nJson.put("reAnalysisResult", reAnalysisResult);
	    	
			
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}
    
    
    
 
    
    
}
