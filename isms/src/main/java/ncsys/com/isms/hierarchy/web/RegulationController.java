package ncsys.com.isms.hierarchy.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ncsys.com.isms.hierarchy.service.RegulationService;
import ncsys.com.isms.hierarchy.service.model.*;
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
@RequestMapping("/hierarchy")
public class RegulationController {

	@Resource(name="regulationService")
	private  RegulationService regulationService;
	
    /**
     * 통제항목 관련 목록창 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/regulation.do")
    public String regulation() throws Exception {
    	return "isms/hierarchy/regulation.tiles";
    }

    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/regulationDetail.do")
    public String regulationDetail() throws Exception {
    	return "isms/hierarchy/regulationDetail.popup";
    }

    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/version.do")
    public String version() throws Exception {
    	return "isms/hierarchy/version.popup";
    }
    
    /**
     * 목록정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/regulationDetialList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void regulationDetialListJson(HttpServletRequest request, HttpServletResponse response, RegulationList regulationList, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
    		
	    	System.out.println("regulationDetialListJson");
	    	
	    	JSONObject nJson = new JSONObject();
			
			List<RegulationList> reRegulationList = regulationService.selectRegulationDetailList(regulationList);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("regulationList", reRegulationList);
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
    @RequestMapping(value = "/regulationDetialInfo.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void regulationDetialInfo(HttpServletRequest request, HttpServletResponse response, String verId )  {
    	try{
    		
	    	JSONObject nJson = new JSONObject();
			
			// 버전정보
	    	List<Version> listVersion = regulationService.selectVersion();
	    	// 분야
	    	List<Field> listField = regulationService.selectFiled();
	    	// 통제
	    	List<Regulation> listRegulation = regulationService.selectRegulation();
	    	
	    	nJson.put("listVersion", listVersion);
	    	nJson.put("listField", listField);
	    	nJson.put("listRegulation", listRegulation);
			
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
    @RequestMapping(value = "/regulationDetial.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void regulationDetial(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		RegulationDetail regulationDetail = new ObjectMapper().readValue(json, RegulationDetail.class);
    		regulationDetail.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
	    		if(	"0".equals(regulationDetail.getRgldtlid() )){
	    			regulationService.insertRegulationDetail(regulationDetail);
	    		} else {
	    			if("D".equals(regulationDetail.getActionmode()) ){
	    				regulationService.deleteRegulationDetail(regulationDetail);
	    			} else {
	    				regulationService.updateRegulationDetail(regulationDetail);
	    			}
	    		}
	    		nJson.put("regulationDetail", regulationDetail);
	    	} else if("delete".equals(mode)){
	    		
	    		regulationService.deleteRegulationDetail(regulationDetail);
	    		
	    	} else if("select".equals(mode)){
	    		
	    		RegulationDetail reRegulationDetail =  regulationService.selectRegulationDetail(regulationDetail);
	    		nJson.put("regulationDetail", reRegulationDetail);
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
    @RequestMapping(value = "/regulationField.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void regulationField(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		Field field = new ObjectMapper().readValue(json, Field.class);
    		field.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
	    		if(	"0".equals(field.getFldid() )){
	    			regulationService.insertRegulationField(field);
	    		} else {
	    			if("D".equals(field.getActionmode()) ){
	    				regulationService.deleteRegulationField(field);
	    			} else {
	    				regulationService.updateRegulationField(field);
	    			}
	    		}
	    		
	    	}
	    	
	    	List<Field> listField = regulationService.selectFiled();
    		
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
    @RequestMapping(value = "/regulation.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void regulation(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		Regulation regulation = new ObjectMapper().readValue(json, Regulation.class);
    		regulation.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
	    		if(	"0".equals(regulation.getRglid() )){
	    			regulationService.insertRegulation(regulation);
	    		} else {
	    			if("D".equals(regulation.getActionmode()) ){
	    				regulationService.deleteRegulation(regulation);
	    			} else {
	    				regulationService.updateRegulation(regulation);
	    			}
	    		}
	    		
	    	}
	    	
	    	List<Regulation> listRegulation = regulationService.selectRegulation();
    		
	    	nJson.put("listRegulation", listRegulation);
	    	
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
	    		
	    		if(	"0".equals(version.getVerid() )){
	    			regulationService.insertVersion(version);
	    		} else {
	    			if("D".equals(version.getActionmode()) ){
	    				regulationService.deleteVersion(version);
	    			} else {
	    				regulationService.updateVersion(version);
	    			}
	    		}
	    		
	    	}
	    	
	    	List<Version> listVersion = regulationService.selectVersion();
    		
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
