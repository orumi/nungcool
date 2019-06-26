package exam.com.main.web;


import exam.com.main.model.SiguVO;
import exam.com.main.model.ZipcodeVO;
import exam.com.main.service.ZipcodeService;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;



@Controller
public class ZipcodeController {

    @Resource(name = "zipcodeService")
    private ZipcodeService zipcodeService;
    
    
    private static final Logger LOGGER = LoggerFactory.getLogger(ZipcodeController.class);
    

 	/*  회원정보 관리 (수정) */
    @RequestMapping(value = "/main/zipcodeService.json")
    public String actionZipcode( HttpServletRequest request, HttpServletResponse response) throws Exception {
   	 

    	JSONObject nJson = new JSONObject();
        try{
        	String formTag = request.getParameter("formTag")!=null?request.getParameter("formTag"):"";
        	
        	if("siguList".equals(formTag)){
        		/*시구군 정보 가져오기 */
        		List<SiguVO> retList = zipcodeService.selectSiguList();
        		
        		nJson.put("RESULT_LIST", retList);
        		nJson.put("RESULT_YN", "Y");
        			
        		
        	} else if ("zipcodeSearch".equals(formTag)){
        		String sido = request.getParameter("sido");
        		String tablename = "ZIP_TABLE_"+sido;
        		String searchKey = request.getParameter("searchKey");
        		String searchType = request.getParameter("searchType");
        		int startrow = 0;
        		int endrow  = 150;
        		
        		HashMap<String, String> map = new HashMap<String, String>();
        		map.put("tablename", tablename);
        		map.put("searchType", searchType);
        		map.put("searchKey", searchKey);
        		map.put("endrow", Integer.toString(endrow));
        		map.put("startrow", Integer.toString(startrow));
        		
        		
        		List<ZipcodeVO> list = zipcodeService.selectZipSearchList(map);
        		String cnt = zipcodeService.selectZipSearchCount(map);
        		
        		
        		nJson.put("RESULT_LIST", list);
        		nJson.put("RESULT_CNT", cnt);
        		nJson.put("RESULT_YN", "Y");
        		
        	}
        	
        }catch(Exception e){
       	 	nJson.put("RESULT_YN","N"); 
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
    	PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
        
        return null;
    }

	@ResponseBody
	@RequestMapping(value = "/member/zipcodeService.json")
	public String actionZipcodeWithoutLogin( HttpServletRequest request, HttpServletResponse response) throws Exception {


		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		JSONObject nJson = new JSONObject();
		try{
			String formTag = request.getParameter("formTag")!=null?request.getParameter("formTag"):"";

			if("siguList".equals(formTag)){
        		/*시구군 정보 가져오기 */
				List<SiguVO> retList = zipcodeService.selectSiguList();

				nJson.put("RESULT_LIST", retList);
				nJson.put("RESULT_YN", "Y");


			} else if ("zipcodeSearch".equals(formTag)){
				String sido = request.getParameter("sido");
				String tablename = "ZIP_TABLE_"+sido;
				String searchKey = request.getParameter("searchKey");
				String searchType = request.getParameter("searchType");
				int startrow = 0;
				int endrow  = 150;

				HashMap<String, String> map = new HashMap<String, String>();
				map.put("tablename", tablename);
				map.put("searchType", searchType);
				map.put("searchKey", searchKey);
				map.put("endrow", Integer.toString(endrow));
				map.put("startrow", Integer.toString(startrow));


				List<ZipcodeVO> list = zipcodeService.selectZipSearchList(map);
				String cnt = zipcodeService.selectZipSearchCount(map);


				nJson.put("RESULT_LIST", list);
				nJson.put("RESULT_CNT", cnt);
				nJson.put("RESULT_YN", "Y");

			}

		}catch(Exception e){
			nJson.put("RESULT_YN","N");
			nJson.put("RESULT_MESSAGE",e.getMessage());
		}
		PrintWriter out = response.getWriter();
		out.write(nJson.toString());
		out.flush();
		out.close();

		return null;
	}






}
