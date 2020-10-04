package ncsys.com.isms.hierarchy.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.LoginVO;
import ncsys.com.isms.hierarchy.service.InspectService;
import ncsys.com.isms.hierarchy.service.RegulationService;
import ncsys.com.isms.hierarchy.service.model.InspectDetail;
import ncsys.com.isms.hierarchy.service.model.InspectList;
import ncsys.com.isms.hierarchy.service.model.RegulationDetail;
import ncsys.com.isms.hierarchy.service.model.RegulationList;
import ncsys.com.util.Criteria;
import ncsys.com.util.PageMaker;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/inspect")
public class InspectController {

	
	@Resource(name="inspectService")
	private  InspectService inspectService;
	
	
	
	
    /**
     * 점검항목 관리
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/inspectMng.do")
    public String inspectMng() throws Exception {

    	System.out.println("ISMS SYSTEM inspectMng.do ");
    	return "isms/hierarchy/inspectMng.tiles";
    }
    
    /**
     * 점검항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/inspectDetail.do")
    public String inspectDetail() throws Exception {
    	return "isms/hierarchy/inspectDetail.popup";
    }
    
    
    /**
     * 목록정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/inspectList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void inspectListJson(HttpServletRequest request, HttpServletResponse response, InspectList inspectList, Criteria cri )  {
    	try{
    		
    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
	    	
	    	JSONObject nJson = new JSONObject();
			
			List<InspectList> reInspectList = inspectService.selectInspectList(inspectList);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("inspectList", reInspectList);
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
     * 통제 항목 상세 정보
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/inspectDetial.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void inspectDetial(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		InspectDetail inspectDetail = new ObjectMapper().readValue(json, InspectDetail.class);
    		inspectDetail.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
	    		if(	"0".equals(inspectDetail.getItemseq() )){
	    			if("C".equals(inspectDetail.getActionmode()) ){
	    				inspectService.insertInspectDetail(inspectDetail);
	    			}
	    		} else {
	    			if("D".equals(inspectDetail.getActionmode()) ){
	    				inspectService.deleteInspectDetail(inspectDetail);
	    			} else if("U".equals(inspectDetail.getActionmode()) ){
	    				inspectService.updateInspectDetail(inspectDetail);
	    			}
	    		}
	    		nJson.put("inspectDetail", inspectDetail);
	    	} else if("delete".equals(mode)){
	    		
	    		inspectService.deleteInspectDetail(inspectDetail);
	    		
	    	} else if("select".equals(mode)){
	    		
	    		InspectDetail reInspectDetail =  inspectService.selectInspectDetail(inspectDetail);
	    		nJson.put("inspectDetail", reInspectDetail);
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
    
    
    
}
