package tems.com.exam.req.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.common.MenuAuthCheck;
import tems.com.common.StringUtils;
import tems.com.login.model.LoginUserVO;
import tems.com.login.model.ReqListVO;
import tems.com.system.model.OfficeUserListVO;
import tems.com.common.model.ComboVO;
import tems.com.common.service.ComboService;
import tems.com.exam.req.service.ReqListService;
import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.ApprListVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.req.model.RequestSearchVO;
import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.annotation.IncludedInfo;

@Controller
public class ReqListController {
	
	@Resource(name = "ComboService")
    private ComboService ComboService;
	
	@Resource(name = "ReqListService")
    private ReqListService ReqListService;
	/**
     * 접수내역 리스트조회한다.
     * @exception Exception
     */
    @RequestMapping(value="/exam/req/ReqList.do")
    public String selectMenuManageList(
    		HttpServletRequest req,
    		ModelMap model) throws Exception {
    	
    	List<ComboVO> ComboList17 = ComboService.getComboList("17");	//결제유형
    	List<ComboVO> ApprComboList = ComboService.getApprStateCodeList("'R'");	//승인요청상태    - 요청전, A 결재중, D 승인완료, R 반려
    	List<ComboVO> StateComboList = ComboService.getStateCodeList("'6','7','8','9'");	//진행상태		0    접수대기,2    접수완료,4    분석진행,6    시험완료,7    결재완료,8    발급완료, 9 취소
    	
 		model.addAttribute("ComboList17", ComboList17);
 		model.addAttribute("ApprComboList", ApprComboList);
 		model.addAttribute("StateComboList", StateComboList);
 		

      	return "tems/com/exam/req/ReqList";
    }
    
    
    @RequestMapping(value="/exam/req/selReqList.json")
    public @ResponseBody List<RequestListVO>  selOfficeUserList(
    		HttpServletRequest req,
    		RequestSearchVO requestSearchVO
    		) throws Exception{

    	List<RequestListVO> RequestList = ReqListService.getReqList(requestSearchVO);
    	
        return RequestList;
    }
    
    
    @RequestMapping(value="/exam/req/edtReqList.json")
    public void edtReqList(
    		RequestListVO requestListVO,
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	RequestListVO vo = (RequestListVO)JSONObject.toBean(jarray.getJSONObject(i), RequestListVO.class);
	        	vo.setModifyid(user.getAdminid());
	        	if(vo.getState().equals("updated")){
	        		ReqListService.edtReqList(vo);
	        		nJson.put("RESULT_YN"     ,"Y");
	        		nJson.put("RESULT_MESSAGE","");
	        	}
	            
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
    
    
    @RequestMapping(value="/exam/req/getApprList.json")
    public @ResponseBody List<ApprListVO>  getApprList(
    		HttpServletRequest req
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	List<ApprListVO> ApprList = ReqListService.getApprList(user.getAdminid());
    	
        return ApprList;
    }
    
    @RequestMapping(value="/exam/req/getApprDetail.json")
    public @ResponseBody List<ApprDetailVO>  getApprDetail(
    		HttpServletRequest req
    		) throws Exception{
    	
    	String apprlineid              = StringUtils.nvl(req.getParameter("apprlineid"),"");
    	List<ApprDetailVO> ApprList = ReqListService.getApprDetail(apprlineid);
    	
        return ApprList;
    }
    
    @RequestMapping(value="/exam/req/upReqState.json")
    public void upReqState(
    		RequestListVO requestListVO,
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	String cmbstate              = StringUtils.nvl(req.getParameter("cmbstate"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	RequestListVO vo = (RequestListVO)JSONObject.toBean(jarray.getJSONObject(i), RequestListVO.class);
	        	vo.setModifyid(user.getAdminid());
	        	vo.setReqstate(cmbstate);
        		ReqListService.upReqState(vo);
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
    
    
    @RequestMapping(value="/exam/req/edtApprLine.json")
    public void edtApprLine(
    		RequestListVO requestListVO,
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	
    	
    	
    	try{
    		int MaxApprLineId = ReqListService.selNextApprLine(user.getAdminid());
    		
	        for(int i = 0; i < jarray.size(); i++){
	        	ApprDetailVO vo = (ApprDetailVO)JSONObject.toBean(jarray.getJSONObject(i), ApprDetailVO.class);
	        	vo.setModifyid(user.getAdminid());
	        	if(vo.getState().equals("created")){
	        		vo.setApprlineid(Integer.toString(MaxApprLineId));
	        		vo.setRegid(user.getAdminid());
	        		ReqListService.edtApprLine(vo);
	        		nJson.put("RESULT_YN"     ,"Y");
	        		nJson.put("RESULT_MESSAGE","");
	        	} else if(vo.getState().equals("updated")){
	        		vo.setModifyid(user.getAdminid());
	        		ReqListService.edtApprLine(vo);
	        		nJson.put("RESULT_YN"     ,"Y");
	        		nJson.put("RESULT_MESSAGE","");
	        	}
	        	
	            
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
    
    
    @RequestMapping(value="/exam/req/inApprConf.json")
    public void inApprConf(
    		RequestListVO requestListVO,
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	
    	
    	
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	ApprDetailVO vo = (ApprDetailVO)JSONObject.toBean(jarray.getJSONObject(i), ApprDetailVO.class);
	        	if(vo.getOrdinal().equals("1")){
	        		vo.setApprstate("A");
	        	} else {
	        		vo.setApprstate("-");
	        	}
	        		vo.setModifyid(user.getAdminid());
	        		vo.setRegid(user.getAdminid());
	        		ReqListService.inApprConf(vo);				//승인요청 저장
	        		
	        		
	        		
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
