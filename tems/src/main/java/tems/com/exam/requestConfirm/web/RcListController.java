package tems.com.exam.requestConfirm.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.common.StringUtils;
import tems.com.common.model.ComboVO;
import tems.com.common.model.SearchVO;
import tems.com.common.service.ComboService;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.req.service.ReqListService;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;
import tems.com.exam.requestConfirm.service.RcListService;

@Controller
public class RcListController {
	
	@Resource(name = "ComboService")
    private ComboService comboService;
	
	@Resource(name = "RcListService")
    private RcListService rcListService;
	
	@RequestMapping(value="/tems/requestConfirm.do")
	public String selectRequestConfirmList(HttpServletRequest request, ModelMap model) throws Exception{
		
    	
    	List<ComboVO> StateComboList = comboService.getStateCodeList("'2'");	//진행상태 not in		0    접수대기,2    접수완료,4    분석진행,6    시험완료,7    결재완료,8    발급완료, 9 취소
    	
 		model.addAttribute("StateComboList", StateComboList);
 		
		
		return "tems/com/exam/requestConfirm/RcList";
	}
	
	
    @RequestMapping(value="/exam/requestConfirm/getConfirmList.json")
    public @ResponseBody List<ReqConfirmListVO>  getConfirmList(
    		HttpServletRequest req,
    		SearchVO searchVO
    		) throws Exception{
    	
    	searchVO.setApprid(StringUtils.nvl(req.getParameter("apprid"),""));
    	List<ReqConfirmListVO> rcList = rcListService.getConfirmList(searchVO);
    	
        return rcList;
    }
    
    @RequestMapping(value="/exam/requestConfirm/upApproval.json")
    public void upApproval(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	JSONObject nJson = new JSONObject();
    	/*try{
		    	reqConfirmListVO.setApprid(StringUtils.nvl(req.getParameter("apprid"),""));
		    	rcListService.upApproval(reqConfirmListVO);
		    	nJson.put("RESULT_YN"     ,"Y");*/
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	ReqConfirmListVO vo = (ReqConfirmListVO)JSONObject.toBean(jarray.getJSONObject(i), ReqConfirmListVO.class);
	        	vo.setApprid(StringUtils.nvl(req.getParameter("apprid"),""));
		    	rcListService.upApproval(vo);
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
