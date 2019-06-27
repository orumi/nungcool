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
import tems.com.common.model.SearchVO;
import tems.com.common.service.ComboService;
import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.login.model.LoginUserVO;
import tems.com.officialExam.officialResult.model.ResultReqListVO;
import tems.com.officialExam.officialResult.service.OfficialResultListService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

@Controller
public class OfficialResultListController {
	
	@Resource(name = "ComboService")
    private ComboService ComboService;
	
	@Resource(name = "officialResultListService")
    private OfficialResultListService resultListService;

	@RequestMapping(value="/officialExam/result/ResultList.do")
    public String ResultList(
    		HttpServletRequest req,
    		ModelMap model) throws Exception {

		List<ComboVO> StateComboList = ComboService.getStateCodeList("'6','7'");	//진행상태		0    접수대기,2    접수완료,4    분석진행,6    시험완료,7    결재완료,8    발급완료, 9 취소
 		model.addAttribute("StateComboList", StateComboList);
      	return "tems/com/officialExam/officialResult/officialResult";
    }
	
    @RequestMapping(value="/officialExam/result/getRequestList.json")
    public @ResponseBody List<ResultReqListVO>  getRequestList(
    		HttpServletRequest req,
    		SearchVO searchVO
    		) throws Exception{

    	List<ResultReqListVO> RequestList = resultListService.getRequestList(searchVO);
    	
        return RequestList;
    }
    
    
    @RequestMapping(value="/officialExam/result/inApprConf.json")
    public void inApprConf(
    		RequestListVO requestListVO,
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	
    	String reqid = "";
    	
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	ApprDetailVO vo = (ApprDetailVO)JSONObject.toBean(jarray.getJSONObject(i), ApprDetailVO.class);
	        	
	        	if(vo.getOrdinal().equals("1")){
	        		vo.setApprstate("A");
	        	} else {
	        		vo.setApprstate("-");
	        	}
	        	
	        	if(!reqid.equals(vo.getReqid())){
	        		resultListService.delApprConf(vo);				//기존 승인요청 삭제
	        	}
	        	
        		vo.setModifyid(user.getAdminid());
        		vo.setRegid(user.getAdminid());
        		resultListService.inApprConf(vo);				//승인요청 저장
        		resultListService.upApprState(vo);				//승인상태 변경
        		reqid = vo.getReqid();
        		
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
