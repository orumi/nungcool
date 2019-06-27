package tems.com.exam.result.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
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
import tems.com.common.model.DeptListVO;
import tems.com.common.model.SearchVO;
import tems.com.common.service.ComboService;
import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.ReqSmpListVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.req.service.ReqDetailService;
import tems.com.exam.result.model.CalculationVO;
import tems.com.exam.result.model.ResultlVO;
import tems.com.exam.result.model.SmpDetailVO;
import tems.com.exam.result.service.ResultDetailService;
import tems.com.exam.resultAdmin.model.ResultAdminListVO;
import tems.com.login.model.LoginUserVO;

@Controller
public class ResultDetailController {
	
	@Resource(name = "ResultDetailService")
    private ResultDetailService resultDetailService;
	
	@Resource(name = "ComboService")
    private ComboService ComboService;
	
	@Resource(name = "ReqDetailService")
    private ReqDetailService reqDetailService;
	
	/**
     * 
     * @exception Exception
     */
    @RequestMapping(value="/exam/result/ResultListDetail.do")
    public String ReqListDetail(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	searchVO.setAdminid(user.getAdminid());
    	
    	List<ComboVO> ComboList18 = ComboService.getComboList("18");	//결과유형
    	List<DeptListVO> deptList = ComboService.getDeptComboList(searchVO);	//본부리스트
    	
    	
    	
    	List<ReqSmpListVO> reqSmpList = resultDetailService.getResultSmpList(searchVO);
    	
    	model.addAttribute("reqDetail",resultDetailService.getResultDetail(searchVO));
    	model.addAttribute("reqSmpList", reqSmpList);
    	model.addAttribute("ComboList18", ComboList18);
    	model.addAttribute("deptList", deptList);
    	model.addAttribute("reqAttachList", reqDetailService.selReqAttach(searchVO.getReqid()));
    	
      	return "tems/com/exam/result/ResultListDetail";
    }
    
    @RequestMapping(value="/exam/result/getResultList.json")
    public @ResponseBody HashMap   getResultList(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
    	
    	List<ResultlVO> ResultList = resultDetailService.getResultList(searchVO);
    	List<CalculationVO> CalcList = resultDetailService.getCalculation(searchVO);
        
    	HashMap map = new HashMap();
    	map.put("ResultList",ResultList);
    	map.put("CalcList",CalcList);

    	
        return map;
    	
    }
    
    
    @RequestMapping(value="/exam/result/upResultDetail.json")
    public void upResultDetail(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception {
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	String caldata              = StringUtils.nvl(req.getParameter("caldata"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	JSONArray caljarray = JSONArray.fromObject(JSONSerializer.toJSON(caldata));
    	ResultlVO vo = new ResultlVO();
    	CalculationVO calvo = new CalculationVO();
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	vo = (ResultlVO)JSONObject.toBean(jarray.getJSONObject(i), ResultlVO.class);
	        	vo.setItemregid(user.getAdminid());
	        	resultDetailService.upResultDetail(vo);
	        }
	        
	        for(int i = 0; i < caljarray.size(); i++){
	        	calvo = (CalculationVO)JSONObject.toBean(caljarray.getJSONObject(i), CalculationVO.class);
	        	calvo.setRegid(user.getAdminid());
	        	resultDetailService.inCalResult(calvo);
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
    
    
    @RequestMapping(value="/exam/result/getResultListAll.json")
    public @ResponseBody HashMap   getResultListAll(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
    	
    	List<ResultAdminListVO> resultAdminList = resultDetailService.getResultListAll(searchVO);
    	SmpDetailVO smpDetailVO = resultDetailService.getSmpDetail(searchVO);
        //return resultAdminList;

    	HashMap map = new HashMap();
    	map.put("resultAdminList",resultAdminList);
    	map.put("smpDetailVO",smpDetailVO);

    	
        return map;
    	
    }
    
    
    @RequestMapping(value="/exam/result/inCoopConf.json")
    public void inCoopConf(
    		RequestListVO requestListVO,
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	JSONObject nJson = new JSONObject();
    	try{
    		
    		resultDetailService.inApprConf(req);
    		
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
    
}
