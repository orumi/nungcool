package ncsys.com.isms.asset.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.model.Asset;
import ncsys.com.isms.asset.service.model.AssetGroup;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.asset.service.model.AssetGrpCnt;
import ncsys.com.isms.asset.service.model.AssetKind;
import ncsys.com.isms.asset.service.model.AssetVersion;
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
@RequestMapping("/asset")
public class AssetController {

	@Resource(name="assetService")
	private  AssetService assetService;
	
	
    /**
     * 통제항목 관련 목록창 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/assetMng.do")
    public String assetMng() throws Exception {
    	return "isms/asset/assetMng.tiles";
    }

    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/assetDetail.do")
    public String assetDetail() throws Exception {
    	return "isms/asset/assetDetail.popup";
    }

    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/assetVersion.do")
    public String assetVersion() throws Exception {
    	return "isms/asset/assetVersion.popup";
    }
    
    
    
    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/assetGroup.do")
    public String assetGroup() throws Exception {
    	return "isms/asset/assetGroup.tiles";
    }    
    
    /**
     * 통제항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/assetGroupDetail.do")
    public String assetGrpDetail() throws Exception {
    	return "isms/asset/assetGroupDetail.popup";
    }
    
    /**
     * 목록정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/assetInit.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void assetInit(HttpServletRequest request, HttpServletResponse response)  {
    	try{
	    	System.out.println("regulationDetialListJson");
	    	
	    	JSONObject nJson = new JSONObject();
			
	    	List<AssetVersion> assetVersionList =  assetService.selectAssetVersionList();
	    	nJson.put("assetVersionList", assetVersionList);
	    	
	    	
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
    
    
    /**
     * 통제 상세 정보
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/assetVersion.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void assetVersion(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		AssetVersion assetVersion = new ObjectMapper().readValue(json, AssetVersion.class);
    		assetVersion.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
	    		if(	"0".equals(assetVersion.getAstverid() )){
	    			assetService.insertAssetVersion(assetVersion);
	    		} else {
	    			if("D".equals(assetVersion.getActionmode()) ){
	    				assetService.deleteAssetVersion(assetVersion);
	    			} else {
	    				assetService.updateAssetVersion(assetVersion);
	    			}
	    		}
	    	}
	    	
	    	List<AssetVersion> assetVersionList =  assetService.selectAssetVersionList();
	    	nJson.put("assetVersionList", assetVersionList);
	    	
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
    @RequestMapping(value = "/assetList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void assetList(HttpServletRequest request, HttpServletResponse response, Asset asset, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
			List<Asset> reAssetList = assetService.selectAssetList(asset);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("reAssetList", reAssetList);
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
     * 통제 상세 정보
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/assetDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void assetDetail(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		Asset assetDetail = new ObjectMapper().readValue(json, Asset.class);
    		assetDetail.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
	    		if(	"0".equals(assetDetail.getAssetid() )){
	    			assetService.insertAsset(assetDetail);
	    		} else {
	    			if("D".equals(assetDetail.getActionmode()) ){
	    				assetService.deleteAsset(assetDetail);
	    			} else {
	    				assetService.updateAsset(assetDetail);
	    			}
	    		}
	    		/*Asset reAssetDetail =  assetService.selectAssetDetail(assetDetail);
	    		nJson.put("asset", reAssetDetail);*/
	    		
	    	} else if("delete".equals(mode)){
	    		
	    		assetService.deleteAsset(assetDetail);
	    		
	    	} else if("select".equals(mode)){
	    		
	    		Asset reAssetDetail =  assetService.selectAssetDetail(assetDetail);
	    		nJson.put("reAssetDetail", reAssetDetail);
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
    
    
    
    
    
    
    
    /*
	***************************************************************************************************
    ***************************************************************************************************
    */
    
    /**
     * 정보 
     *
     * @return
     * @throws Exception
     * 
     * assetGroup.jsp
     */
    @RequestMapping(value = "/assetGrpInit.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void assetGrpInit(HttpServletRequest request, HttpServletResponse response)  {
    	try{
	    	System.out.println("regulationDetialListJson");
	    	
	    	JSONObject nJson = new JSONObject();
			
	    	List<AssetVersion> assetVersionList =  assetService.selectAssetVersionList();
	    	nJson.put("assetVersionList", assetVersionList);
	    	
	    	List<AssetKind> assetKind =  assetService.selectAssetKind();
	    	nJson.put("assetKind", assetKind);
	    	
	    	
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
     * 
     * $("#jqgrid").jqGrid({
                url : 'assetAstCntList.json',
            	datatype: 'local',
     */
    @RequestMapping(value = "/assetAstCntList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void assetAstCntList(HttpServletRequest request, HttpServletResponse response, AssetGrpCnt assetGrpCnt, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
			List<AssetGrpCnt> reAssetGrpCnt = assetService.selectAssetGrpCntList(assetGrpCnt);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("reAssetGrpCnt", reAssetGrpCnt);
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
     * 목록정보 
     *
     * @return
     * @throws Exception
     * $("#jqgridGrp").jqGrid({
                url : 'assetGrpList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : {  },
     */
    @RequestMapping(value = "/assetGrpList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void assetGrpList(HttpServletRequest request, HttpServletResponse response, Asset asset, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
    		
	    	JSONObject nJson = new JSONObject();
			
			List<AssetGroupList> reAssetGroupList = assetService.selectAssetGroupList();
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("reAssetGroupList", reAssetGroupList);
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
     * 통제 상세 정보
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/assetGrpDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void assetGrpDetail(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		AssetGroup detail = new ObjectMapper().readValue(json, AssetGroup.class);
    		detail.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
	    		if(	"0".equals(detail.getAstgrpid() )){
	    			assetService.insertAssetGroup(detail);
	    		} else {
	    			if("D".equals(detail.getActionmode()) ){
	    				assetService.deleteAssetGroup(detail);
	    			} else {
	    				assetService.updateAssetGroup(detail);
	    			}
	    		}
	    		
	    	} else if("select".equals(mode)){
	    		
	    		AssetGroup reDetail =  assetService.selectAssetGroupDetail(detail);
	    		nJson.put("reDetail", reDetail);
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
