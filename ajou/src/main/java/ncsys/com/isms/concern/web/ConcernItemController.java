package ncsys.com.isms.concern.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.concern.service.ConcernService;
import ncsys.com.isms.concern.service.model.ConcernItem;
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
@RequestMapping("/concern")
public class ConcernItemController {

	
	@Resource(name="concernService")
	private  ConcernService concernService;
	
	@Resource(name="assetService")
	private  AssetService assetService;
	
	
    /**
     * 통제항목 관련 목록창 
     *
     * @return
     * @throws Exception
     */
   @RequestMapping(value="/concernItem.do")
   public String concernItem() throws Exception {
   	return "isms/concern/concernItem.tiles";
   }


   /**
    * 통제항목 편집 화면 호출
    *
    * @return
    * @throws Exception
    */
   @RequestMapping(value="/concernItemDetail.do")
   public String concernItemDetail() throws Exception {
   	return "isms/concern/concernItemDetail.popup";
   }

    
    /* week test item init */
    /**
     * 초기정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/concernItemInit.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void concernItemInit(HttpServletRequest request, HttpServletResponse response)  {
    	try{
	    	System.out.println("weekTestItemInit.json");
	    	
	    	JSONObject nJson = new JSONObject();
			
	    	/* 자산 그분 */
	    	List<AssetGroupList> reAssetGroupList =  assetService.selectAssetGroupList();
	    	nJson.put("reAssetGroupList", reAssetGroupList);
	    	
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
    @RequestMapping(value = "/concernItemList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void weekTestItemList(HttpServletRequest request, HttpServletResponse response, ConcernItem concernItem, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
			List<ConcernItem> reConcernItem = concernService.selectConcernItemList(concernItem);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("reConcernItem", reConcernItem);
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
    @RequestMapping(value = "/concernItemDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void weekTestItemDetail(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	JSONObject nJson = new JSONObject();
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		ConcernItem detail = new ObjectMapper().readValue(json, ConcernItem.class);
    		detail.setUserId(loginVO.getId());
    		
	    	if("modify".equals(mode)){
	    		
	    		if("I".equals(detail.getActionmode()) ){
	    			concernService.insertConcernItem(detail);
	    		} else if("D".equals(detail.getActionmode()) ){
	    			concernService.deleteConcernItem(detail);
	    		} else if("U".equals(detail.getActionmode())){
	    			concernService.updateConcernItem(detail);
	    		}
	
	    	} else if("select".equals(mode)){
	    		
	    		ConcernItem reDetail = concernService.selectConcernItem(detail); 
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
