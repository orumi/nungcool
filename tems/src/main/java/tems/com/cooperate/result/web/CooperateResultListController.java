package tems.com.cooperate.result.web;

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
import tems.com.common.model.DeptListVO;
import tems.com.common.model.SearchVO;
import tems.com.common.service.ComboService;
import tems.com.cooperate.result.service.CooperateResultListService;
import tems.com.exam.req.model.ReqSmpListVO;
import tems.com.exam.req.service.ReqDetailService;
import tems.com.exam.result.model.CalculationVO;
import tems.com.exam.result.model.ResultReqListVO;
import tems.com.exam.result.model.ResultlVO;
import tems.com.exam.result.service.ResultDetailService;
import tems.com.login.model.LoginUserVO;

@Controller
public class CooperateResultListController {
	
	@Resource(name = "CooperateResultListService")
    private CooperateResultListService cooperateResultListService;
	
	@Resource(name = "ReqDetailService")
    private ReqDetailService reqDetailService;
	
	@Resource(name = "ComboService")
    private ComboService comboService;
	
	@Resource(name = "ResultDetailService")
    private ResultDetailService resultDetailService;

	//결과등록 페이지 불러오기
	@RequestMapping(value="/cooperate/result/ResultList.do")
    public String CooperateResultList(HttpServletRequest req, ModelMap model) throws Exception {

	return "tems/com/cooperate/result/ResultList";
    }
	
	@RequestMapping(value="/cooperate/result/getCoopReqList.json")
    public @ResponseBody List<ResultReqListVO>  getCoopReqList(
    		HttpServletRequest req,
    		SearchVO searchVO
    		) throws Exception{

    	List<ResultReqListVO> RequestList = cooperateResultListService.getRequestList(searchVO);
    	
        return RequestList;
    }
	
	/**
     * 
     * @exception Exception
     */
    @RequestMapping(value="/cooperate/result/ResultDetail.do")
    public String CooperateResultDetail(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	searchVO.setAdminid(user.getAdminid());
    	
    	List<ComboVO> ComboList18 = comboService.getComboList("18");	//결과유형
    	
    	List<ReqSmpListVO> reqSmpList = cooperateResultListService.getResultSmpList(searchVO);
    	
    	model.addAttribute("reqDetail",cooperateResultListService.getResultDetail(searchVO));
    	model.addAttribute("reqSmpList", reqSmpList);
    	model.addAttribute("ComboList18", ComboList18);
    	model.addAttribute("reqAttachList", reqDetailService.selReqAttach(searchVO.getReqid()));
    	
      	return "tems/com/cooperate/result/ResultDetail";
    }
    
    @RequestMapping(value="/cooperate/result/getCoopResultList.json")
    public @ResponseBody HashMap   getCoopResultList(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
    	
    	List<ResultlVO> ResultList = cooperateResultListService.getCoopResultList(searchVO);
    	List<CalculationVO> CalcList = cooperateResultListService.getCoopCalculation(searchVO);
        
    	HashMap map = new HashMap();
    	map.put("ResultList",ResultList);
    	map.put("CalcList",CalcList);

        return map;
    	
    }
    
    @RequestMapping(value="/cooperate/result/upCoopResultDetail.json")
    public void upCoopResultDetail(
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
    
    @RequestMapping(value="/cooperate/result/upCoopResultState.json")
    public void upCoopResultState(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception {
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	String caldata              = StringUtils.nvl(req.getParameter("caldata"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	ResultlVO vo = new ResultlVO();
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	vo = (ResultlVO)JSONObject.toBean(jarray.getJSONObject(i), ResultlVO.class);
	        	vo.setItemregid(user.getAdminid());
	        	cooperateResultListService.upCoopResultState(vo);
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
}
