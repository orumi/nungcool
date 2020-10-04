package ncsys.com.isms.concern.web;



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
import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.asset.service.model.AssetVersion;
import ncsys.com.isms.concern.service.ConcernDtlService;
import ncsys.com.isms.concern.service.model.ConcernDtlAsset;
import ncsys.com.isms.concern.service.model.ConcernDtlDetail;
import ncsys.com.isms.weekTest.service.WeekTestDtlService;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlAsset;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlDetail;
import ncsys.com.util.Criteria;
import ncsys.com.util.PageMaker;
import net.sf.json.JSONObject;


@Controller
@RequestMapping("/concern")
public class ConcernDtlController {



    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/concernDtl.do")
    public String concernDtl() throws Exception {
    	return "isms/concern/concernDtl.tiles";
    }
    
    
    @Resource(name="concernDtlService")
	private  ConcernDtlService concernDtlService;
	
    
    @Resource(name="assetService")
	private  AssetService assetService;


    /* week test item init */
    /**
     * 초기정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/concernDtlInit.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void concernDtlInit(HttpServletRequest request, HttpServletResponse response)  {
    	try{
	    	System.out.println("concernItemInit.json");
	    	
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
    @RequestMapping(value = "/concernDtlAsset.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void concernDtlAsset(HttpServletRequest request, HttpServletResponse response, ConcernDtlAsset concernDtlAsset, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
			List<ConcernDtlAsset> reconcernDtlAsset = concernDtlService.selectConcernDtlAsset(concernDtlAsset);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("reconcernDtlAsset", reconcernDtlAsset);
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
    @RequestMapping(value = "/concernDtlDetailList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void concernDtlDetailList(HttpServletRequest request, HttpServletResponse response, ConcernDtlDetail concernDtlDetail, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
	    	List<ConcernDtlDetail> reConcernDtlDetail = concernDtlService.selectConcernDtlDetail(concernDtlDetail);
	    	nJson.put("reConcernDtlDetail", reConcernDtlDetail);
			
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
    @RequestMapping(value = "/concernDtlDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void concernDtlDetail(HttpServletRequest request, HttpServletResponse response, ConcernDtlDetail pmDetail, @RequestBody String json )  {
    	JSONObject nJson = new JSONObject();
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		//System.out.println(json);
    		
    		ConcernDtlDetail[] listDetail = new ObjectMapper().readValue(json, ConcernDtlDetail[].class);
    		
	    	if("modify".equals(pmDetail.getActionmode())){
	    		//listDetail
	    		concernDtlService.deleteConcernDtl(pmDetail);
	    		
	    		for (int i = 0; i < listDetail.length; i++) {
	    			listDetail[i].setUserId(loginVO.getId());
	    			listDetail[i].setAssetid(pmDetail.getAssetid());
	    			listDetail[i].setAstgrpid(pmDetail.getAstgrpid());
	    			listDetail[i].setAstverid(pmDetail.getAstverid());
	    			
					concernDtlService.insertConcernDtl(listDetail[i]);
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