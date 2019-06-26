package ncsys.com.isms.concern.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.model.AssetVersion;
import ncsys.com.isms.concern.service.RegulationTstService;
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
public class RegulationTstController {

	
	@Resource(name="regulationService")
	private  RegulationService regulationService;
	
	
	@Resource(name="regulationTstService")
	private  RegulationTstService regulationTstService;
	
	
	
    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/regulationTst.do")
    public String regulationTst() throws Exception {
    	return "isms/concern/regulationTst.tiles";
    }
    
    
    /* week test item init */
    /**
     * 초기정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/regulationTstInit.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void regulationTstInit(HttpServletRequest request, HttpServletResponse response)  {
    	try{
	    	System.out.println("weekTestItemInit.json");
	    	
	    	JSONObject nJson = new JSONObject();
			
	    	// 버전정보
	    	List<Version> listVersion = regulationService.selectVersion();
	    	nJson.put("listVersion", listVersion);

	    	// 분야
	    	List<Field> listField = regulationService.selectFiled();
	    	nJson.put("listField", listField);
	    	
	    	
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
    @RequestMapping(value = "/regulationTstList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void regulationTstList(HttpServletRequest request, HttpServletResponse response, RegulationTst regulationTst, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
			List<RegulationTstList> reRegulationTstList = regulationTstService.selectRegulationTst(regulationTst);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("reRegulationTstList", reRegulationTstList);
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
    @RequestMapping(value = "/regulationTstDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void regulationTstDetail(HttpServletRequest request, HttpServletResponse response, RegulationTst pmDetail, @RequestBody String json )  {
    	JSONObject nJson = new JSONObject();
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		System.out.println(json);
    		
    		RegulationTst[] listDetail = new ObjectMapper().readValue(json, RegulationTst[].class);
    		
    		
	    	if("modify".equals(pmDetail.getActionmode())){
	    		//listDetail
	    		//weekTestDtlService.deleteWeekTestDtl(pmDetail);
	    		
	    		for (int i = 0; i < listDetail.length; i++) {
	    			listDetail[i].setUserId(loginVO.getId());
	    			
	    			regulationTstService.adjustRegulationTst(listDetail[i]);
	    			
				}
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
