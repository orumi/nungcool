package ncsys.com.isms.measure.web;

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
@RequestMapping("/measure")
public class MeasureController {

	@Resource(name="measureService")
	private  MeasureService measureService;
	
    /**
     * 통제항목 관련 목록창 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/measureMng.do")
    public String regulation() throws Exception {
    	return "isms/measure/measureMng.tiles";
    }

    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/measureDetail.do")
    public String regulationDetail() throws Exception {
    	return "isms/measure/measureDetail.popup";
    }

    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/version.do")
    public String version() throws Exception {
    	return "isms/measure/version.popup";
    }
    
    /**
     * 목록정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/measureDetialList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void measureDetialListJson(HttpServletRequest request, HttpServletResponse response, MeasureList measureList, Criteria cri )  {
    	try{
    		
    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
    		
	    	System.out.println("measureDetialListJson");
	    	
	    	JSONObject nJson = new JSONObject();
			
			List<MeasureList> reMeasureList = measureService.selectMeasureDetailList(measureList);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("measureList", reMeasureList);
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
    
    
    /**
     * 초기 정보
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/measureDetialInfo.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void measureDetailInfo(HttpServletRequest request, HttpServletResponse response, String verId )  {
    	try{
    		
	    	JSONObject nJson = new JSONObject();
			
			// 버전정보
	    	List<Version> listVersion = measureService.selectVersion();
	    	// 분야
	    	List<Field> listField = measureService.selectFiled();
	    	// 통제
	    	List<Measure> listMeasure = measureService.selectMeasure();
	    	
	    	nJson.put("listVersion", listVersion);
	    	nJson.put("listField", listField);
	    	nJson.put("listMeasure", listMeasure);
			
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
    @RequestMapping(value = "/measureDetial.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void measureDetial(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		MeasureDetail measureDetail = new ObjectMapper().readValue(json, MeasureDetail.class);
    		measureDetail.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
	    		if(	"0".equals(measureDetail.getMsrdtlid() )){
	    			measureService.insertMeasureDetail(measureDetail);
	    		} else {
	    			if("D".equals(measureDetail.getActionmode()) ){
	    				measureService.deleteMeasureDetail(measureDetail);
	    			} else {
	    				measureService.updateMeasureDetail(measureDetail);
	    			}
	    		}
	    		nJson.put("measureDetail", measureDetail);
	    	} else if("delete".equals(mode)){
	    		
	    		measureService.deleteMeasureDetail(measureDetail);
	    		
	    	} else if("select".equals(mode)){
	    		
	    		MeasureDetail reMeasureDetail =  measureService.selectMeasureDetail(measureDetail);
	    		nJson.put("measureDetail", reMeasureDetail);
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
     * 분야 정보
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/measureField.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void measureField(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		Field field = new ObjectMapper().readValue(json, Field.class);
    		field.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
	    		if(	"0".equals(field.getPifldid() )){
	    			measureService.insertMeasureField(field);
	    		} else {
	    			if("D".equals(field.getActionmode()) ){
	    				measureService.deleteMeasureField(field);
	    			} else {
	    				measureService.updateMeasureField(field);
	    			}
	    		}
	    		
	    	}
	    	
	    	List<Field> listField = measureService.selectFiled();
    		
	    	nJson.put("listField", listField);
	    	
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
     * 통제정보 관리
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/measure.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void measure(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		Measure measure = new ObjectMapper().readValue(json, Measure.class);
    		measure.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
	    		if(	"0".equals(measure.getMsrid() )){
	    			measureService.insertMeasure(measure);
	    		} else {
	    			if("D".equals(measure.getActionmode()) ){
	    				measureService.deleteMeasure(measure);
	    			} else {
	    				measureService.updateMeasure(measure);
	    			}
	    		}
	    		
	    	}
	    	
	    	List<Measure> listMeasure = measureService.selectMeasure();
    		
	    	nJson.put("listMeasure", listMeasure);
	    	
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
     * 버전 관리
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/version.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void version(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		Version version = new ObjectMapper().readValue(json, Version.class);
    		version.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
	    		if(	"0".equals(version.getPiverid() )){
	    			measureService.insertVersion(version);
	    		} else {
	    			if("D".equals(version.getActionmode()) ){
	    				measureService.deleteVersion(version);
	    			} else {
	    				measureService.updateVersion(version);
	    			}
	    		}
	    		
	    	}
	    	
	    	List<Version> listVersion = measureService.selectVersion();
    		
	    	nJson.put("listVersion", listVersion);
	    	
	    	nJson.put("reVal", "ok_resend");
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}    
    
    
    
    
    
    
    
}
