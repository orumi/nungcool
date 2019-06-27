package tems.com.cooperate.receive.web;

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
import tems.com.cooperate.receive.model.CooperateReceiveListVO;
import tems.com.cooperate.receive.service.ReceiveListService;
import tems.com.exam.cooperation.model.CooperationListVO;
import tems.com.exam.cooperation.service.CooperationListService;
import tems.com.exam.req.model.ReqSmpListVO;
import tems.com.exam.result.model.CoopApprVO;
import tems.com.login.model.LoginUserVO;

@Controller
public class ReceiveListController {
	
	@Resource(name = "ReceiveListService")
    private ReceiveListService receiveListService;
	
	@Resource(name = "CooperationListService")
    private CooperationListService cooperationListService;
	
	@Resource(name = "ComboService")
    private ComboService ComboService;
	
	//협조접수 페이지 불러오기
	@RequestMapping(value="/cooperate/receive/ReceiveList.do")
	public String ReceiveList(HttpServletRequest req,ModelMap model) throws Exception {

	return "tems/com/cooperate/receive/ReceiveList";
	}
		
	
	@RequestMapping(value="/cooperate/receive/getReceiveList.json")
    public @ResponseBody HashMap getReceiveList(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
		
		List<CooperateReceiveListVO> cooperateReceiveList = receiveListService.getReceiveList(searchVO);
		
		HashMap map = new HashMap();
    	map.put("cooperateReceiveList",cooperateReceiveList);
    	
      	return map;
    }
	
	@RequestMapping(value="/cooperate/receive/upReceive.json")
    public void upReceive(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
		JSONObject nJson = new JSONObject();
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	CooperateReceiveListVO vo = (CooperateReceiveListVO)JSONObject.toBean(jarray.getJSONObject(i), CooperateReceiveListVO.class);
	        	receiveListService.upReceive(vo);
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
	
	//협조접수 상세페이지 불러오기
		@RequestMapping(value="/cooperate/receive/reqReceiveDetail.do")
	    public String CooperationDetail(
	    		HttpServletRequest req,
	    		SearchVO searchVO,
	    		CooperateReceiveListVO vo,
	    		ModelMap model) throws Exception {
			
	    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
	    	searchVO.setAdminid(user.getAdminid());
	    	
			String data[]	=	searchVO.getData().split(",");
			String returnUrl = "";
			
			searchVO.setReqid(data[0]);
	    	
	    	List<ComboVO> ComboList18 = ComboService.getComboList("18");	//결과유형
	    	List<ReqSmpListVO> reqSmpList = receiveListService.getCoopSmpList(searchVO);
	    	
	    	model.addAttribute("reqDetail",receiveListService.getCoopReqDetail(searchVO));
	    	model.addAttribute("reqSmpList", reqSmpList);
	    	model.addAttribute("ComboList18", ComboList18);
	    	
	    	
	    	if(EgovDoubleSubmitHelper.checkAndSaveToken()){	//중복submit 방지 egov3.2에서 안됨  3.5부터 가능하다고 함
				if("Y".equals(searchVO.getConfirm())){
					receiveListService.upReceive(vo);
				} else if("R".equals(searchVO.getConfirm())){
					receiveListService.upCoopReject(vo);
				}
	    	}
			
	    	model.addAttribute("reqid",data[0]);
	    	
	    	data = (String[]) ArrayUtils.removeElement(data, data[0]);
	    	String nextdatas = StringUtils.ArrayToString(data);
	    	
	    	model.addAttribute("data",nextdatas);
	    	
	    	if(searchVO.getData().equals("")){
	    		returnUrl = "tems/com/cooperate/receive/ReceiveList"; 
	    	} else {
	    		returnUrl = "tems/com/cooperate/receive/ReceiveDetail";
	    	}
			
			return returnUrl;
	    }
	
	

}
