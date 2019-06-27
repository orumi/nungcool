package tems.com.officialExam.cooperation.web;

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
import tems.com.exam.req.model.ReqSmpListVO;
import tems.com.exam.result.model.CoopApprVO;
import tems.com.exam.result.model.ResultlVO;
import tems.com.login.model.LoginUserVO;
import tems.com.officialExam.cooperation.model.CooperationListVO;
import tems.com.officialExam.cooperation.service.OfficialCooperationListService;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

@Controller
public class OfficialCooperationListController {
	
	@Resource(name = "officialCooperationListService")
    private OfficialCooperationListService officialCooperationListService;
	
	@Resource(name = "ComboService")
    private ComboService ComboService;
	
	//협조승인 페이지 불러오기
	@RequestMapping(value="/officialExam/cooperation/CooperationList.do")
    public String ResultList(
    		HttpServletRequest req,
    		ModelMap model) throws Exception {
		
      	return "tems/com/officialExam/cooperation/CooperationList";
    }
	
	
	@RequestMapping(value="/officialExam/cooperation/getCooperationList.json")
    public @ResponseBody HashMap getCooperationList(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
		
		List<CooperationListVO> cooperationList = officialCooperationListService.getCooperationList(searchVO);
		
		HashMap map = new HashMap();
    	map.put("cooperationList",cooperationList);
    	
      	return map;
    }
	
	//협조승인 상세페이지 불러오기
	@RequestMapping(value="/officialExam/cooperation/CooperationDetail.do")
    public String CooperationDetail(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		CoopApprVO coopApprVO,
    		ModelMap model) throws Exception {
		
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	searchVO.setAdminid(user.getAdminid());
    	
		String data[]	=	searchVO.getData().split(",");
		String returnUrl = "";
		
		searchVO.setReqid(data[0]);
    	
    	List<ComboVO> ComboList18 = ComboService.getComboList("18");	//결과유형
    	List<ReqSmpListVO> reqSmpList = officialCooperationListService.getCooperSmpList(searchVO);
    	
    	model.addAttribute("reqDetail",officialCooperationListService.getCooperReqDetail(searchVO));
    	model.addAttribute("reqSmpList", reqSmpList);
    	model.addAttribute("ComboList18", ComboList18);
    	
		if("Y".equals(searchVO.getConfirm())){
			//CoopApprVO vo = (CoopApprVO)JSONObject.toBean(jarray.getJSONObject(i), CoopApprVO.class);
			officialCooperationListService.upCooperApproval(coopApprVO);
		} else if("R".equals(searchVO.getConfirm())){
			officialCooperationListService.inCooperReject(coopApprVO);
		}
		
    	model.addAttribute("reqid",data[0]);
    	
    	data = (String[]) ArrayUtils.removeElement(data, data[0]);
    	String nextdatas = StringUtils.ArrayToString(data);
    	
    	model.addAttribute("data",nextdatas);
    	
    	if(searchVO.getData().equals("")){
    		returnUrl = "tems/com/officialExam/cooperation/CooperationList";
    	} else {
    		returnUrl = "tems/com/officialExam/cooperation/CooperationDetail";
    	}
		return returnUrl;
    }
	
	
	@RequestMapping(value="/officialExam/cooperation/upCooperApproval.json")
    public void upCooperApproval(
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
	        	CoopApprVO vo = (CoopApprVO)JSONObject.toBean(jarray.getJSONObject(i), CoopApprVO.class);
				officialCooperationListService.upCooperApproval(vo);
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
	
    @RequestMapping(value="/officialExam/cooperation/getResultList.json")
    public @ResponseBody HashMap   getResultList(
    		HttpServletRequest req,
    		SearchVO searchVO,
    		ModelMap model) throws Exception {
    	
    	List<ResultlVO> ResultList = officialCooperationListService.getResultList(searchVO);
        
    	HashMap map = new HashMap();
    	map.put("ResultList",ResultList);

        return map;
    	
    }
	
}
