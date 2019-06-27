package tems.com.officialExam.officialResult.web;

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
import tems.com.exam.req.model.ReqSmpListVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.resultAdmin.model.ResultAdminListVO;
import tems.com.login.model.LoginUserVO;
import tems.com.officialExam.officialReq.service.OfficialReqDetailService;
import tems.com.officialExam.officialResult.model.CalculationVO;
import tems.com.officialExam.officialResult.model.ResultlVO;
import tems.com.officialExam.officialResult.model.SmpDetailVO;
import tems.com.officialExam.officialResult.service.OfficialResultDetailService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

@Controller
public class OfficialResultDetailController {
	
	@Resource(name = "officialResultDetailService")
    private OfficialResultDetailService officialResultDetailService;
	
	@Resource(name = "ComboService")
    private ComboService ComboService;
	
	@Resource(name = "officialReqDetailService")
    private OfficialReqDetailService officialReqDetailService;
	
	/**
     * @exception Exception
     */
    @RequestMapping(value="/officialExam/result/ResultListDetail.do")
    public String ReqListDetail(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	searchVO.setAdminid(user.getAdminid());
    	
    	List<ComboVO> ComboList18 = ComboService.getComboList("18");	//결과유형
    	List<DeptListVO> deptList = ComboService.getDeptComboList(searchVO);	//본부리스트
    	
    	
    	
    	List<ReqSmpListVO> reqSmpList = officialResultDetailService.getResultSmpList(searchVO);
    	
    	model.addAttribute("reqDetail",officialResultDetailService.getResultDetail(searchVO));
    	model.addAttribute("reqSmpList", reqSmpList);
    	model.addAttribute("ComboList18", ComboList18);
    	model.addAttribute("deptList", deptList);
    	model.addAttribute("reqAttachList", officialReqDetailService.selReqAttach(searchVO.getReqid()));
    	
      	return "tems/com/officialExam/officialResult/officialResultDetail";
    }
    
    @RequestMapping(value="/officialExam/result/getResultList.json")
    public @ResponseBody HashMap   getResultList(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
    	
    	List<ResultlVO> ResultList = officialResultDetailService.getResultList(searchVO);
    	List<CalculationVO> CalcList = officialResultDetailService.getCalculation(searchVO);
        
    	HashMap map = new HashMap();
    	map.put("ResultList",ResultList);
    	map.put("CalcList",CalcList);

        return map;
    	
    }

    @RequestMapping(value="/officialExam/result/upResultDetail.json")
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
				officialResultDetailService.upResultDetail(vo);
	        }
	        
	        for(int i = 0; i < caljarray.size(); i++){
	        	calvo = (CalculationVO)JSONObject.toBean(caljarray.getJSONObject(i), CalculationVO.class);
	        	calvo.setRegid(user.getAdminid());
				officialResultDetailService.inCalResult(calvo);
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
    
    
    @RequestMapping(value="/officialExam/result/getResultListAll.json")
    public @ResponseBody HashMap   getResultListAll(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
    	
    	List<ResultAdminListVO> resultAdminList = officialResultDetailService.getResultListAll(searchVO);
    	SmpDetailVO smpDetailVO = officialResultDetailService.getSmpDetail(searchVO);
        //return resultAdminList;

    	HashMap map = new HashMap();
    	map.put("resultAdminList",resultAdminList);
    	map.put("smpDetailVO",smpDetailVO);

    	
        return map;
    	
    }
    
    
    @RequestMapping(value="/officialExam/result/inCoopConf.json")
    public void inCoopConf(
    		RequestListVO requestListVO,
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	JSONObject nJson = new JSONObject();
    	try{

			officialResultDetailService.inApprConf(req);
    		
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
