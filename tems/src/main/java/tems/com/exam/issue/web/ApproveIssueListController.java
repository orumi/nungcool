package tems.com.exam.issue.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.common.StringUtils;
import tems.com.common.model.ComboVO;
import tems.com.common.model.SearchVO;
import tems.com.common.service.ComboService;
import tems.com.exam.issue.model.ApproveIssueListVO;
import tems.com.exam.issue.model.RejectResultVO;
import tems.com.exam.issue.service.ApproveIssueService;
import tems.com.exam.req.model.ReqSmpListVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;
import tems.com.exam.result.service.ResultDetailService;
import tems.com.exam.resultAdmin.model.ResultAdminListVO;
import tems.com.exam.resultAdmin.service.ResultAdminListService;
import tems.com.login.model.LoginUserVO;

@Controller
public class ApproveIssueListController {
	
	@Resource(name = "ApproveIssueService")
    private ApproveIssueService approveIssueService;
	
	
	@Resource(name = "ComboService")
    private ComboService ComboService;
	
	@Resource(name = "ResultDetailService")
    private ResultDetailService resultDetailService;
	
	
	//발급승인 페이지 불러오기
	@RequestMapping(value="/exam/issue/ApproveIssueList.do")
    public String ApproveIssueList(
    		HttpServletRequest req,
    		ModelMap model) throws Exception {
		
    	
      	return "tems/com/exam/issue/ApproveIssueList";
    }
	
	//발급승인 상세페이지 불러오기
	@RequestMapping(value="/exam/issue/ApproveIssueDetail.do")
    public String ApproveIssueDetail(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		RejectResultVO rejectResultVO,
    		ModelMap model) throws Exception {
		
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	searchVO.setAdminid(user.getAdminid());
    	
		String data[]	=	searchVO.getData().split(",");
		String returnUrl = "";
		
		searchVO.setReqid(data[0]);
    	
    	List<ComboVO> ComboList18 = ComboService.getComboList("18");	//결과유형
    	List<ReqSmpListVO> reqSmpList = resultDetailService.getResultSmpList(searchVO);
    	
    	model.addAttribute("reqDetail",resultDetailService.getResultDetail(searchVO));
    	model.addAttribute("reqSmpList", reqSmpList);
    	model.addAttribute("ComboList18", ComboList18);
    	
      	/*return "tems/com/exam/issue/ApproveIssueDetail";*/
		
		
		if("Y".equals(searchVO.getConfirm())){
			rejectResultVO.setAdminid(user.getAdminid());
			approveIssueService.upReportApproval(rejectResultVO);
		} else if("R".equals(searchVO.getConfirm())){
			String vodata              = StringUtils.nvl(req.getParameter("vodata"),"");
			vodata = vodata.replaceAll("&quot;", "\"");
	    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(vodata));
	    	
	    	rejectResultVO.setAdminid(user.getAdminid());
	    	String rejordinal = approveIssueService.inResultReject(rejectResultVO);
	    	
	    	for(int i = 0; i < jarray.size(); i++){
	    		RejectResultVO vo = (RejectResultVO)JSONObject.toBean(jarray.getJSONObject(i), RejectResultVO.class);
	    		vo.setRejordinal(rejordinal);
	        	vo.setAdminid(user.getAdminid());
	        	approveIssueService.inResultRejectItem(vo);
	        }
	    	approveIssueService.upReportApprovalReject(rejectResultVO);
		}
		
    	model.addAttribute("reqid",data[0]);
    	
    	data = (String[]) ArrayUtils.removeElement(data, data[0]);
    	String nextdatas = StringUtils.ArrayToString(data);
    	
    	model.addAttribute("data",nextdatas);
    	
    	if(searchVO.getData().equals("")){
    		returnUrl = "tems/com/exam/issue/ApproveIssueList"; 
    	} else {
    		returnUrl = "tems/com/exam/issue/ApproveIssueDetail";
    	}
		
		return returnUrl;
    }
	
	//
	@RequestMapping(value="/exam/issue/getApproveIssueList.json")
    public @ResponseBody HashMap getApproveIssueList(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
		
		List<ApproveIssueListVO> ApproveIssueList = approveIssueService.getRequestList(searchVO);
		
		HashMap map = new HashMap();
    	map.put("ApproveIssueList",ApproveIssueList);
    	
      	return map;
    }
	
	//반려화면 항목리스트
	@RequestMapping(value="/exam/issue/getRejectResultList.json")
    public @ResponseBody List<RejectResultVO> getRejectResultList(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
		
		List<RejectResultVO> getRejectResultList = approveIssueService.getRejectResultList(searchVO);
		
      	return getRejectResultList;
    }
	
    @RequestMapping(value="/exam/issue/upApproval.json")
    public void upApproval(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	JSONObject nJson = new JSONObject();
    	/*try{
		    	reqConfirmListVO.setApprid(StringUtils.nvl(req.getParameter("apprid"),""));
		    	rcListService.upApproval(reqConfirmListVO);
		    	nJson.put("RESULT_YN"     ,"Y");*/
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	RejectResultVO vo = (RejectResultVO)JSONObject.toBean(jarray.getJSONObject(i), RejectResultVO.class);
	        	vo.setAdminid(user.getAdminid());
				approveIssueService.upReportApproval(vo);
        		nJson.put("RESULT_YN"     ,"Y");
        		nJson.put("RESULT_MESSAGE","");
	            
	        }
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
