package tems.com.exam.resultAdmin.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.common.StringUtils;
import tems.com.common.model.ComboVO;
import tems.com.common.model.SearchVO;
import tems.com.common.service.ComboService;
import tems.com.exam.result.model.CalculationVO;
import tems.com.exam.result.model.ResultlVO;
import tems.com.exam.result.service.ResultDetailService;
import tems.com.exam.resultAdmin.model.ResultAdminListVO;
import tems.com.exam.resultAdmin.model.ResultReqListVO;
import tems.com.exam.resultAdmin.service.ResultAdminListService;
import tems.com.login.model.LoginUserVO;

@Controller
public class ResultAdminListController {
	
	@Resource(name = "ComboService")
    private ComboService ComboService;
	
	@Resource(name = "ResultAdminListService")
    private ResultAdminListService resultAdminListService;
	
	@Resource(name = "ResultDetailService")
    private ResultDetailService resultDetailService;
	
	
	@RequestMapping(value="/exam/resultAdmin/ResultAdminList.do")
    public String ResultAdminList(
    		HttpServletRequest req,
    		ModelMap model) throws Exception {
		
		List<ComboVO> StateComboList = ComboService.getStateCodeList("'4'");	//진행상태		0    접수대기,2    접수완료,4    분석진행,6    시험완료,7    결재완료,8    발급완료, 9 취소
		List<ComboVO> ComboList18 = ComboService.getComboList("18");	//결과유형
    	
 		model.addAttribute("StateComboList", StateComboList);
 		model.addAttribute("ComboList18", ComboList18);
    	
      	return "tems/com/exam/resultAdmin/ResultAdminList";
    }
	
    @RequestMapping(value="/exam/resultAdmin/getResultAdminList.json")
    public @ResponseBody HashMap   getResultList(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
    	
    	List<ResultAdminListVO> ResultList = resultAdminListService.getResultAdminList(searchVO);
    	List<CalculationVO> CalcList = resultAdminListService.getCalculationAdmin(searchVO);
    	List<ResultReqListVO> reqList = resultAdminListService.getReqList(searchVO);
    	

        
    	HashMap map = new HashMap();
    	map.put("ResultList",ResultList);
    	map.put("CalcList",CalcList);
    	map.put("reqList",reqList);

    	
        return map;
    	
    }
    
    
    @RequestMapping(value="/exam/resultAdmin/upResultAdminDetail.json")
    public void upResultAdminDetail(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception {
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	String caldata              = StringUtils.nvl(req.getParameter("caldata"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	JSONArray caljarray = JSONArray.fromObject(JSONSerializer.toJSON(caldata));
    	ResultAdminListVO vo = new ResultAdminListVO();
    	CalculationVO calvo = new CalculationVO();
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	vo = (ResultAdminListVO)JSONObject.toBean(jarray.getJSONObject(i), ResultAdminListVO.class);
	        	vo.setItemregid(user.getAdminid());
	        	resultAdminListService.upResultAdminDetail(vo);
	        }
	        
	        for(int i = 0; i < caljarray.size(); i++){
	        	calvo = (CalculationVO)JSONObject.toBean(caljarray.getJSONObject(i), CalculationVO.class);
	        	calvo.setRegid(user.getAdminid());
	        	resultAdminListService.inCalResultAdmin(calvo);
	        }
	        nJson.put("RESULT_YN"     ,"Y");
    		nJson.put("RESULT_MESSAGE","");
    	}catch(Exception e){
      	  nJson.put("RESULT_YN"     ,"N");
          nJson.put("RESULT_MESSAGE",e.getMessage());
    	}
      PrintWriter out = response.getWriter();
      out.write(nJson.toString());
      out.flush();
      out.close();
    }
    
    @RequestMapping(value="/exam/resultAdmin/getCalculation.json")
    public @ResponseBody List<CalculationVO>   getCalculation(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
    	
    	List<CalculationVO> CalcList = resultDetailService.getCalculation(searchVO);
    	
        return CalcList;
    	
    }
    
}

