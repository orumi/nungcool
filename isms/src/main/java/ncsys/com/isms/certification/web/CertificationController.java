package ncsys.com.isms.certification.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ncsys.com.isms.certification.service.CertiService;
import ncsys.com.isms.certification.service.model.CertiDetail;
import ncsys.com.isms.certification.service.model.CertiList;
import ncsys.com.util.Criteria;
import ncsys.com.util.PageMaker;
import ncsys.com.util.commoncd.service.CommonCdService;
import ncsys.com.util.commoncd.service.model.CommonCd;
import net.sf.json.JSONObject;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.LoginVO;


@Controller
@RequestMapping("/certification")
public class CertificationController {

	
	@Resource(name="certiService")
	private  CertiService certiService;
	
	
	@Resource(name="commonCdService")
	private  CommonCdService commonCdService;
	
	
    /**
     * ISMS인증 목록창 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/certiManage.do")
    public String certiManage() throws Exception {
    	return "isms/certification/certiManage.tiles";
    }

    
    /**
     * 점검항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/certiDetail.do")
    public String certiDetail() throws Exception {
    	return "isms/certification/certiDetail.popup";
    }
    
    
    /**
     * 목록정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/certiList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void certiListJson(HttpServletRequest request, HttpServletResponse response, CertiList certiList, Criteria cri )  {
    	try{
    		
    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
	    	
	    	JSONObject nJson = new JSONObject();
			
			List<CertiList> reCertiList = certiService.selectCertiList(certiList);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("certiList", reCertiList);
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
    @RequestMapping(value = "/certiDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void certiDetail(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		CertiDetail certiDetail = new ObjectMapper().readValue(json, CertiDetail.class);
    		certiDetail.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
	    		if(	"0".equals(certiDetail.getProofid() )){
	    			if("C".equals(certiDetail.getActionmode()) ){
	    				certiService.insertCertiDetail(certiDetail);
	    			}
	    		} else {
	    			if("D".equals(certiDetail.getActionmode()) ){
	    				certiService.deleteCertiDetail(certiDetail);
	    			} else if("U".equals(certiDetail.getActionmode()) ){
	    				certiService.updateCertiDetail(certiDetail);
	    			}
	    		}
	    		nJson.put("inspectDetail", certiDetail);
	    	} else if("delete".equals(mode)){
	    		
	    		certiService.deleteCertiDetail(certiDetail);
	    		
	    	} else if("select".equals(mode)){
	    		
	    		CertiDetail reCertiDetail =  certiService.selectCertiDetail(certiDetail);
	    		nJson.put("certiDetail", reCertiDetail);
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
    @RequestMapping(value = "/commonCd.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void commonCd(HttpServletRequest request, HttpServletResponse response, CommonCd commonCd)  {
    	try{
	    	JSONObject nJson = new JSONObject();
			
			List<CommonCd> reCommonCd = commonCdService.selectCommonCdList(commonCd);
			
			nJson.put("commonCd", reCommonCd);
			
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}
    
    
    
}
