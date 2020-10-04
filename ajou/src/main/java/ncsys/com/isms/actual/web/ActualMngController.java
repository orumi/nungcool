package ncsys.com.isms.actual.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ncsys.com.isms.actual.service.ActualMngService;
import ncsys.com.isms.actual.service.model.ActualDetail;
import ncsys.com.isms.actual.service.model.ActualFile;
import ncsys.com.isms.actual.service.model.ActualList;
import ncsys.com.util.Criteria;
import ncsys.com.util.EnvConfig;
import ncsys.com.util.PageMaker;
import ncsys.com.util.commoncd.service.CommonCdService;
import net.sf.json.JSONObject;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.Globals;



/* new project */
@Controller
@RequestMapping("/actual")
public class ActualMngController {

	
	@Resource(name="actualMngService")
	private  ActualMngService actualMngService;
	
	
	@Resource(name="commonCdService")
	private  CommonCdService commonCdService;
	
	@Autowired 
	private EnvConfig envConfig;
	
    /**
     * 실적등록 창 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/actualMng.do")
    public String actualMng() throws Exception {
    	
    	
    	System.out.println("####################### : "+envConfig.getRootPath());
    	System.out.println("####################### Batch is : "+envConfig.getBatch());
    	return "isms/actual/actualMng.tiles";
    }
    
    /**
     * ISMS실적 메인 실적 현황
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/actualMain.do")
    public String actualMain() throws Exception {
    	return "isms/actual/actualMain.tiles";
    }

    
    /**
     * 점검항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/actualDetail.do")
    public String actualDetail() throws Exception {
    	return "isms/actual/actualDetail.popup";
    }
    
    
    /**
     * 목록정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/actualList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void actualListJson(HttpServletRequest request, HttpServletResponse response, ActualList actualList, Criteria cri )  {
    	try{
    		
    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
	    	
	    	JSONObject nJson = new JSONObject();
			
			List<ActualList> reActualList = actualMngService.selectActualList(actualList);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("actualList", reActualList);
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
    @RequestMapping(value = "/actualDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void actualDetail(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		ActualDetail actualDetail = new ObjectMapper().readValue(json, ActualDetail.class);
    		actualDetail.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
	    		
    			if("D".equals(actualDetail.getActionmode()) ){
    				actualMngService.deleteActualDetail(actualDetail);
    			} else if("U".equals(actualDetail.getActionmode()) ){
    				actualMngService.updateActualDetail(actualDetail);
    			}

    			nJson.put("inspectDetail", actualDetail);
    			
	    	} else if("delete".equals(mode)){
	    		
	    		actualMngService.deleteActualDetail(actualDetail);
	    		
	    	} else if("select".equals(mode)){
	    		
	    		ActualDetail reActualDetail =  actualMngService.selectActualDetail(actualDetail);
	    		nJson.put("actualDetail", reActualDetail);
	    		
	    		ActualFile actualFile = new ActualFile();
	    		actualFile.setYear(actualDetail.getYear());
	    		actualFile.setMonth(actualDetail.getMonth());
	    		actualFile.setProofid(actualDetail.getProofid());

	    		List<ActualFile> actualFiles = actualMngService.selectActualFiles(actualFile); 
	    		nJson.put("actualFiles", actualFiles);
	    		
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
    
    @RequestMapping(value = "/uploadFile.json", method = RequestMethod.POST)
	@ResponseBody
	public void uploadFile(@RequestParam(value = "file") MultipartFile file, ActualFile actualFile, HttpServletRequest request, HttpServletResponse response) {
		
		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");

		JSONObject nJson = new JSONObject();
		try{
			
			
			/* store by year */
			HashMap<String, String> fileMap = EgovFileMngUtil.uploadFile(file,"Globals.ActualFileStorePath");
			
			actualFile.setUserId(loginVO.getId());
			actualFile.setOrginFileName(fileMap.get(Globals.ORIGIN_FILE_NM));
			actualFile.setNewName(fileMap.get(Globals.UPLOAD_FILE_NM));
			actualFile.setFileExt(fileMap.get(Globals.FILE_EXT));
			actualFile.setStoredFilePath(fileMap.get(Globals.FILE_PATH));
			
			actualMngService.insertActualFile(actualFile);
			
			
    		List<ActualFile> actualFiles = actualMngService.selectActualFiles(actualFile); 
    		nJson.put("actualFiles", actualFiles);
    		
    		nJson.put("reVal", "ok_resend");
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
    

    @RequestMapping(value = "/deleteFile.json", method = RequestMethod.POST)
	@ResponseBody
	public void deleteFile(HttpServletRequest request, HttpServletResponse response, @RequestBody String json) {

		JSONObject nJson = new JSONObject();
		try{
			ActualFile actualFile = new ObjectMapper().readValue(json, ActualFile.class);
			LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
			
			
			//delete upload file 
			
			actualMngService.deleteActualFile(actualFile);
			
			
    		List<ActualFile> actualFiles = actualMngService.selectActualFiles(actualFile); 
    		nJson.put("actualFiles", actualFiles);
    		
    		nJson.put("reVal", "ok_resend");
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
