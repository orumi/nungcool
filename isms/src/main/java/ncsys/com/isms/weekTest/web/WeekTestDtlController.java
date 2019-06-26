package ncsys.com.isms.weekTest.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.asset.service.model.AssetVersion;
import ncsys.com.isms.weekTest.service.WeekTestDtlService;
import ncsys.com.isms.weekTest.service.WeekTestService;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlAsset;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlDetail;
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
@RequestMapping("/weekTest")
public class WeekTestDtlController {

	@Resource(name="assetService")
	private  AssetService assetService;
	
	
	@Resource(name="weekTestDtlService")
	private  WeekTestDtlService weekTestDtlService;
	
    
    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/weekTstDtl.do")
    public String weekTstDtl() throws Exception {
    	return "isms/weekTest/weekTstDtl.tiles";
    }
    
    

    /* week test item init */
    /**
     * 초기정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/weekTestDtlInit.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void weekTestDtlInit(HttpServletRequest request, HttpServletResponse response)  {
    	try{
	    	System.out.println("weekTestItemInit.json");
	    	
	    	JSONObject nJson = new JSONObject();
			
	    	List<AssetVersion> reAssetVersionList =  assetService.selectAssetVersionList();
	    	nJson.put("reAssetVersionList", reAssetVersionList);
	    	
	    	
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
    @RequestMapping(value = "/weekTestDtlAsset.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void weekTestDtlAsset(HttpServletRequest request, HttpServletResponse response, WeekTestDtlAsset weekTestDtlAsset, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
			List<WeekTestDtlAsset> reWeekTestDtlAsset = weekTestDtlService.selectWeekTestDtlAsset(weekTestDtlAsset);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("reWeekTestDtlAsset", reWeekTestDtlAsset);
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
    
    
    /*week test item List */
    /**
     * 목록정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/weekTestDtlDetailList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void weekTestDtlDetailList(HttpServletRequest request, HttpServletResponse response, WeekTestDtlDetail weekTestDtlDetail, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
	    	List<WeekTestDtlDetail> reWeekTestDtlDetail = weekTestDtlService.selectWeekTestDtlDetail(weekTestDtlDetail);
	    	nJson.put("reWeekTestDtlDetail", reWeekTestDtlDetail);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
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
    @RequestMapping(value = "/weekTestDtlDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void weekTestDtlDetail(HttpServletRequest request, HttpServletResponse response, WeekTestDtlDetail pmDetail, @RequestBody String json )  {
    	JSONObject nJson = new JSONObject();
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		//System.out.println(json);
    		
    		WeekTestDtlDetail[] listDetail = new ObjectMapper().readValue(json, WeekTestDtlDetail[].class);
    		
	    	if("modify".equals(pmDetail.getActionmode())){
	    		//listDetail
	    		weekTestDtlService.deleteWeekTestDtl(pmDetail);
	    		
	    		for (int i = 0; i < listDetail.length; i++) {
	    			listDetail[i].setUserId(loginVO.getId());
	    			listDetail[i].setAssetid(pmDetail.getAssetid());
	    			listDetail[i].setAstgrpid(pmDetail.getAstgrpid());
	    			listDetail[i].setAstverid(pmDetail.getAstverid());
	    			
					weekTestDtlService.insertWeekTestDtl(listDetail[i]);
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
