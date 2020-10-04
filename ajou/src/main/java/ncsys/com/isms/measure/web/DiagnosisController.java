package ncsys.com.isms.measure.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ncsys.com.isms.measure.service.model.*;
import ncsys.com.isms.measure.service.DiagnosisService;
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
@RequestMapping("/diagnosis")
public class DiagnosisController {

	@Resource(name="diagnosisService")
	private  DiagnosisService diagnosisService;
	
    /**
     * 통제항목 관련 목록창 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/diagnosisMng.do")
    public String regulation() throws Exception {
    	return "isms/measure/diagnosisMng.tiles";
    }
    

    /**
     * 초기 정보 (지표진단 체계 버전,  진단운영 정보)
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/diagnosisInit.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void diagnosisInit(HttpServletRequest request, HttpServletResponse response, String verId )  {
    	try{
    		
	    	JSONObject nJson = new JSONObject();
			
			// 버전정보
	    	List<Version> listVersion = diagnosisService.selectPiversion();
	    	// 통제
	    	List<Diagnosis> listDiagnosis = diagnosisService.selectDiagnosis();
	    	
	    	nJson.put("listVersion", listVersion);
	    	nJson.put("listDiagnosis", listDiagnosis);
			
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}
    

    /**
     * 통제 상세 정보
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/diagnosisDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void diagnosisDetail(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		JSONObject nJson = new JSONObject();

    		if("modify".equals(mode)){
	    		Diagnosis diagnosis = new ObjectMapper().readValue(json, Diagnosis.class);
	    		diagnosis.setUserId(loginVO.getId());
	    		
	    		if(	"0".equals(diagnosis.getDgsid() )){
	    			diagnosisService.insertDiagnosisDetail(diagnosis);
	    		} else {
	    			if("D".equals(diagnosis.getActionmode()) ){
	    				diagnosisService.deleteDiagnosisDetail(diagnosis);
	    			} else {
	    				diagnosisService.updateDiagnosisDetail(diagnosis);
	    			}
	    		}
	    		List<Diagnosis> listDiagnosis = diagnosisService.selectDiagnosis();
	    		nJson.put("listDiagnosis", listDiagnosis);

	    		
	    	} else if("weight".equals(mode)){
	    		DiagnosisWeight diagnosisWeight = new ObjectMapper().readValue(json, DiagnosisWeight.class);
	    		diagnosisWeight.setUserId(loginVO.getId());
	    		
	    		diagnosisService.updateDiagnosisWeight(diagnosisWeight);
	    		
	    	}
	    	
	    	nJson.put("reVal", "ok_resend");
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}

    /**
     * 목록정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/diagnosisList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void diagnosisListJson(HttpServletRequest request, HttpServletResponse response, DiagnosisList diagnosisList, Criteria cri )  {
    	try{
    		
    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	System.out.println("diagnosisListJson");
	    	
	    	JSONObject nJson = new JSONObject();
	    	
	    	
			List<DiagnosisList> reDiagnosisList = diagnosisService.selectDiagnosisDetailList(diagnosisList);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("diagnosisList", reDiagnosisList);
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
