package ncsys.com.isms.actual.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ncsys.com.isms.actual.service.ActualPimesService;
import ncsys.com.isms.actual.service.model.ActualDetail;
import ncsys.com.isms.actual.service.model.ActualFile;
import ncsys.com.isms.actual.service.model.ActualList;
import ncsys.com.isms.actual.service.model.ActualPimesDetail;
import ncsys.com.isms.actual.service.model.ActualPimesFile;
import ncsys.com.isms.actual.service.model.ActualPimesList;
import ncsys.com.isms.measure.service.model.Diagnosis;
import ncsys.com.util.Criteria;
import ncsys.com.util.PageMaker;
import ncsys.com.util.commoncd.service.CommonCdService;
import net.sf.json.JSONObject;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.Globals;


@Controller
@RequestMapping("/actualPimes")
public class ActualPimesController {

	
	@Resource(name="actualPimesService")
	private  ActualPimesService actualPimesService;
	
	
	@Resource(name="commonCdService")
	private  CommonCdService commonCdService;
	
	
    /**
     * ISMS인증 목록창 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/actual.do")
    public String actualPimes() throws Exception {
    	return "isms/actual/actualPimes.tiles";
    }

    
    /**
     * 점검항목 편집 화면 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/actualDetail.do")
    public String actualDetail() throws Exception {
    	return "isms/actual/actualPimesDetail.popup";
    }
    
    
    /**
     * 목록정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/initInfo.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void initInfoJson(HttpServletRequest request, HttpServletResponse response)  {
    	try{
    		
    		String page = request.getParameter("page");

    		String year = request.getParameter("year");
    		
    		
	    	
	    	JSONObject nJson = new JSONObject();
			
			List<Diagnosis> reListDiagnosis = actualPimesService.selectDignosisByYear(year);
			
			nJson.put("listDiagnosis", reListDiagnosis);
			
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
    @RequestMapping(value = "/selectDiagnosisList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectDiangosisListJson(HttpServletRequest request, HttpServletResponse response, ActualPimesList actualPiemsList, Criteria cri )  {
    	try{
    		
    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		//cri.setOwner(loginUser.getUserId());
	    	
	    	JSONObject nJson = new JSONObject();
			
			List<ActualPimesList> reActualPimesList = actualPimesService.selectActualPimesList(actualPiemsList);
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			
			nJson.put("actualPimesList", reActualPimesList);
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
    		
    		ActualPimesDetail actualPimesDetail = new ObjectMapper().readValue(json, ActualPimesDetail.class);
    		actualPimesDetail.setUserId(loginVO.getId());
    		
    		JSONObject nJson = new JSONObject();
	    	if("modify".equals(mode)){
	    		
    			if("D".equals(actualPimesDetail.getActionmode()) ){
    				actualPimesService.deleteActualPimesDetail(actualPimesDetail);
    			} else if("U".equals(actualPimesDetail.getActionmode()) ){
    				actualPimesService.updateActualPimesDetail(actualPimesDetail);
    			}
    			
	    	} else if("select".equals(mode)){
	    		
	    		ActualPimesDetail reActualPimesDetail =  actualPimesService.selectActualDetail(actualPimesDetail);
	    		nJson.put("actualPimesDetail", reActualPimesDetail);
	    		
	    		ActualPimesFile actualPimesFile = new ActualPimesFile();
	    		actualPimesFile.setMsrdtlid(actualPimesDetail.getMsrdtlid());
	    		actualPimesFile.setDgsid(actualPimesDetail.getDgsid());
	    		
	    		actualPimesFile.setAttachtype("PLN");
	    		List<ActualPimesFile> actualPimesPlnFiles = actualPimesService.selectActualFiles(actualPimesFile);
	    		nJson.put("actualPimesPlnFiles", actualPimesPlnFiles);
	    		
	    		actualPimesFile.setAttachtype("ACT");
	    		List<ActualPimesFile> actualPimesActFiles = actualPimesService.selectActualFiles(actualPimesFile);
	    		nJson.put("actualPimesActFiles", actualPimesActFiles);
	    		
	    		actualPimesFile.setAttachtype("AGG");
	    		List<ActualPimesFile> actualPimesAggFiles = actualPimesService.selectActualFiles(actualPimesFile);
	    		nJson.put("actualPimesAggFiles", actualPimesAggFiles);
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
	public void uploadFile(@RequestParam(value = "file") MultipartFile file, ActualPimesFile actualPimesFile, HttpServletRequest request, HttpServletResponse response) {
		
		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");

		JSONObject nJson = new JSONObject();
		try{
			
			
			/* store by year */
			HashMap<String, String> fileMap = EgovFileMngUtil.uploadFile(file,"Globals.ActualFileStorePath");
			
			actualPimesFile.setUserId(loginVO.getId());
			actualPimesFile.setOrginFileName(fileMap.get(Globals.ORIGIN_FILE_NM));
			actualPimesFile.setNewName(fileMap.get(Globals.UPLOAD_FILE_NM));
			actualPimesFile.setFileExt(fileMap.get(Globals.FILE_EXT));
			actualPimesFile.setStoredFilePath(fileMap.get(Globals.FILE_PATH));
			
			actualPimesService.insertActualFile(actualPimesFile);
			
			
    		List<ActualPimesFile> actualPimesFiles = actualPimesService.selectActualFiles(actualPimesFile); 
    		nJson.put("actualFiles", actualPimesFiles);
    		
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
			ActualPimesFile actualPimesFile = new ObjectMapper().readValue(json, ActualPimesFile.class);
			LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
			
			//delete upload file 
			
			actualPimesService.deleteActualFile(actualPimesFile);
			
    		List<ActualPimesFile> actualPimesFiles = actualPimesService.selectActualFiles(actualPimesFile); 
    		nJson.put("actualFiles", actualPimesFiles);
    		
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
