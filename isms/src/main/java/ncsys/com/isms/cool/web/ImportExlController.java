package ncsys.com.isms.cool.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.LoginVO;
import ncsys.com.isms.asset.service.model.Asset;
import ncsys.com.isms.certification.service.model.CertiDetail;
import ncsys.com.isms.concern.service.model.ConcernDtlDetail;
import ncsys.com.isms.concern.service.model.ConcernItem;
import ncsys.com.isms.concern.service.model.CriteriaItem;
import ncsys.com.isms.concern.service.model.RegulationTst;
import ncsys.com.isms.cool.service.ImportExlService;
import ncsys.com.isms.hierarchy.service.model.InspectDetail;
import ncsys.com.isms.hierarchy.service.model.RegulationDetail;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlDetail;
import ncsys.com.isms.weekTest.service.model.WeekTestItem;


@Controller
@RequestMapping("/cool/import")
public class ImportExlController {

	@Resource(name="importExlService")
	private ImportExlService importExlService;
	
	
    /**
     * 통제항목 관련 목록창 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/importExlRgl.do")
    public String importExlRgl() throws Exception {
    	return "isms/cool/importExlRgl.tiles";
    }
    
    @RequestMapping(value="/importExlAst.do")
    public String importExlAst() throws Exception {
    	return "isms/cool/importExlAst.tiles";
    }
    
    @RequestMapping(value="/importExlCcn.do")
    public String importExlCcn() throws Exception {
    	return "isms/cool/importExlCcn.tiles";
    }

    
    /* 엑셀 일괄 등록 */
	@RequestMapping(value = "rgstrExl.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void rgstrExl(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json)  throws Exception {
		
		JSONObject nJson = new JSONObject();
		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
		
		if("rgl".equals(mode)){
			RegulationDetail[] excelEntity = new ObjectMapper().readValue(json, RegulationDetail[].class);
			
			List<RegulationDetail> errorList = importExlService.adjustRegulationItem(loginVO, excelEntity);
			
			nJson.put("totalCnt",excelEntity.length);
			nJson.put("errorCnt",errorList.size());
			nJson.put("errorList", errorList);
			
		} else if ("mng".equals(mode)){
			InspectDetail[] excelEntity = new ObjectMapper().readValue(json, InspectDetail[].class);
			
			List<InspectDetail> errorList = importExlService.adjustInspectItem(loginVO, excelEntity);
			
			nJson.put("totalCnt",excelEntity.length);
			nJson.put("errorCnt",errorList.size());
			nJson.put("errorList", errorList);
			
		} else if ("isms".equals(mode)){
			CertiDetail[] excelEntity = new ObjectMapper().readValue(json, CertiDetail[].class);
			
			List<CertiDetail> errorList = importExlService.adjustCertification(loginVO, excelEntity);
			
			nJson.put("totalCnt",excelEntity.length);
			nJson.put("errorCnt",errorList.size());
			nJson.put("errorList", errorList);
		}
		
		nJson.put("reVal", "ok_resend");
		
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
		
	}
	

    
    /* 엑셀 일괄 등록 */
	@RequestMapping(value = "rgstrExlAst.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void rgstrExlAst(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json)  throws Exception {
		
		JSONObject nJson = new JSONObject();
		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
		
		if("ast".equals(mode)){
			Asset[] excelEntity = new ObjectMapper().readValue(json, Asset[].class);
			
			List<Asset> errorList = importExlService.adjustAsset(loginVO, excelEntity);
			
			nJson.put("totalCnt",excelEntity.length);
			nJson.put("errorCnt",errorList.size());
			nJson.put("errorList", errorList);
			
		} else if ("tst".equals(mode)){
			WeekTestItem[] excelEntity = new ObjectMapper().readValue(json, WeekTestItem[].class);
			
			List<WeekTestItem> errorList = importExlService.adjustWeekTestItem(loginVO, excelEntity);
			
			nJson.put("totalCnt",excelEntity.length);
			nJson.put("errorCnt",errorList.size());
			nJson.put("errorList", errorList);
			
		} else if ("rst".equals(mode)){
			WeekTestDtlDetail[] excelEntity = new ObjectMapper().readValue(json, WeekTestDtlDetail[].class);
			
			List<WeekTestDtlDetail> errorList = importExlService.adjustWeekTestResult(loginVO, excelEntity);
			
			nJson.put("totalCnt",excelEntity.length);
			nJson.put("errorCnt",errorList.size());
			nJson.put("errorList", errorList);
		}
		
		nJson.put("reVal", "ok_resend");
		
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
		
	}
	
	
	
    /* 엑셀 일괄 등록 */
	@RequestMapping(value = "rgstrExlCcn.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void rgstrExlCcn(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json) throws Exception {
		
		JSONObject nJson = new JSONObject();
		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
		
		if("rgl".equals(mode)){
			RegulationTst[] excelEntity = new ObjectMapper().readValue(json, RegulationTst[].class);
			
			List<RegulationTst> errorList = importExlService.adjustRglEval(loginVO, excelEntity);
			
			nJson.put("totalCnt",excelEntity.length);
			nJson.put("errorCnt",errorList.size());
			nJson.put("errorList", errorList);
			
		} else if ("ctr".equals(mode)){
			CriteriaItem[] excelEntity = new ObjectMapper().readValue(json, CriteriaItem[].class);
			
			List<CriteriaItem> errorList = importExlService.adjustCriteria(loginVO, excelEntity);
			
			nJson.put("totalCnt",excelEntity.length);
			nJson.put("errorCnt",errorList.size());
			nJson.put("errorList", errorList);
			
		} else if ("ccn".equals(mode)){
			ConcernItem[] excelEntity = new ObjectMapper().readValue(json, ConcernItem[].class);
			
			List<ConcernItem> errorList = importExlService.adjustCcnItem(loginVO, excelEntity);
			
			nJson.put("totalCnt",excelEntity.length);
			nJson.put("errorCnt",errorList.size());
			nJson.put("errorList", errorList);
		} else if ("rst".equals(mode)){
			ConcernDtlDetail[] excelEntity = new ObjectMapper().readValue(json, ConcernDtlDetail[].class);
			
			List<ConcernDtlDetail> errorList = importExlService.adjustCcnRst(loginVO, excelEntity);
			
			nJson.put("totalCnt",excelEntity.length);
			nJson.put("errorCnt",errorList.size());
			nJson.put("errorList", errorList);
		}
		
		nJson.put("reVal", "ok_resend");
		
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
		
	}
	
	
	
	
}
