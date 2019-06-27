package tems.com.cooperate.receiveApprove.web;

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

import egovframework.com.cmm.util.EgovDoubleSubmitHelper;
import tems.com.common.StringUtils;
import tems.com.common.model.ComboVO;
import tems.com.common.model.SearchVO;
import tems.com.common.service.ComboService;
import tems.com.cooperate.receiveApprove.service.CooperateReceiveApproveService;
import tems.com.cooperate.result.service.CooperateResultListService;
import tems.com.exam.cooperation.model.CooperationListVO;
import tems.com.exam.req.model.ReqSmpListVO;
import tems.com.exam.req.service.ReqDetailService;
import tems.com.exam.result.model.CoopApprVO;
import tems.com.login.model.LoginUserVO;

@Controller
public class CooperateReceiveApproveController {
	
	@Resource(name ="CooperateReceiveApproveService")
	private CooperateReceiveApproveService cooperateReceiveApproveService;
	
	@Resource(name = "CooperateResultListService")
    private CooperateResultListService cooperateResultListService;
	
	@Resource(name = "ComboService")
    private ComboService ComboService;
	
	@Resource(name = "ReqDetailService")
    private ReqDetailService reqDetailService;
	
	//협조결과승인 페이지 불러오기
	@RequestMapping(value="/cooperate/receiveApprove/ApproveList.do")
    public String ReceiveApperoveList(HttpServletRequest req, ModelMap model) throws Exception {

	return "tems/com/cooperate/receiveApprove/ReceiveApproveList";
	
	
    }
	
	
	@RequestMapping(value="/cooperate/receiveApprove/getCoopApprList.json")
    public @ResponseBody HashMap getCoopApprList(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
		
		List<CooperationListVO> cooperateApprList = cooperateReceiveApproveService.getCoopApprList(searchVO);
		
		HashMap map = new HashMap();
    	map.put("cooperateApprList",cooperateApprList);
    	
      	return map;
    }
	
	//협조 일괄승인
	@RequestMapping(value="/cooperate/receiveApprove/upCoopAppr.json")
    public void upCoopAppr(
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
	        	CooperationListVO vo = (CooperationListVO)JSONObject.toBean(jarray.getJSONObject(i), CooperationListVO.class);
	        	vo.setAdminid(user.getAdminid());
	        	cooperateReceiveApproveService.upCoopAppr(vo);
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
	
	//협조승인 상세페이지 불러오기
		@RequestMapping(value="/cooperate/receiveApprove/ApproveDetail.do")
	    public String CooperationDetail(
	    		HttpServletRequest req,
	    		SearchVO searchVO,
	    		CooperationListVO cooperationListVO,
	    		ModelMap model) throws Exception {
			
	    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
	    	searchVO.setAdminid(user.getAdminid());
	    	
			String data[]	=	searchVO.getData().split(",");
			String returnUrl = "";
			
			searchVO.setReqid(data[0]);
	    	
	    	List<ComboVO> ComboList18 = ComboService.getComboList("18");	//결과유형
	    	List<ReqSmpListVO> reqSmpList = cooperateResultListService.getResultSmpList(searchVO);
	    	
	    	model.addAttribute("reqDetail",cooperateResultListService.getResultDetail(searchVO));
	    	model.addAttribute("reqSmpList", reqSmpList);
	    	model.addAttribute("ComboList18", ComboList18);
	    	model.addAttribute("reqAttachList", reqDetailService.selReqAttach(searchVO.getReqid()));
	    	
	    	if(EgovDoubleSubmitHelper.checkAndSaveToken()){	//중복submit 방지 egov3.2에서 안됨  3.5부터 가능하다고 함
				if("Y".equals(searchVO.getConfirm())){
					//CoopApprVO vo = (CoopApprVO)JSONObject.toBean(jarray.getJSONObject(i), CoopApprVO.class);
					cooperationListVO.setAdminid(user.getAdminid());
					cooperateReceiveApproveService.upCoopAppr(cooperationListVO);
				} else if("R".equals(searchVO.getConfirm())){
					//cooperationListService.inCooperReject(coopApprVO);
				}
	    	}
	    	model.addAttribute("reqid",data[0]);
	    	
	    	data = (String[]) ArrayUtils.removeElement(data, data[0]);
	    	String nextdatas = StringUtils.ArrayToString(data);
	    	
	    	model.addAttribute("data",nextdatas);
	    	
	    	if(searchVO.getData().equals("")){
	    		returnUrl = "tems/com/cooperate/receiveApprove/ReceiveApproveList"; 
	    	} else {
	    		returnUrl = "tems/com/cooperate/receiveApprove/ReceiveApproveDetail";
	    	}
			
			return returnUrl;
	    }
}
