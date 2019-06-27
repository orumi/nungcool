package tems.com.report.officialReport.web;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tems.com.common.SendMail;
import tems.com.common.StringUtils;
import tems.com.common.model.ComboVO;
import tems.com.common.model.SearchVO;
import tems.com.common.service.ComboService;
import tems.com.login.model.LoginUserVO;
import tems.com.report.officialReport.model.ReportIssueListVO;
import tems.com.report.officialReport.service.OfficialReportIssueListService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

@Controller
public class OfficialReportIssueListController {
	
	@Resource(name = "ComboService")
    private ComboService ComboService;
	
	@Resource(name = "officialReportIssueListService")
    private OfficialReportIssueListService officialReportIssueListService;

	//성적서발급 페이지 불러오기
	@RequestMapping(value="/report/officialReport/reportIssueList.do")
    public String ReportIssueList(HttpServletRequest req, ModelMap model) throws Exception {
    	
		List<ComboVO> StateComboList = ComboService.getStateCodeList("'7','8'");	//진행상태		0    접수대기,2    접수완료,4    분석진행,6    시험완료,7    결재완료,8    발급완료, 9 취소
    	
 		model.addAttribute("StateComboList", StateComboList);
		
		return "tems/com/report/officialReport/OfficialReportIssueList";
    }
	
    @RequestMapping(value="/report/officialReport/getReportIssueList.json")
    public @ResponseBody List<ReportIssueListVO>  getReportIssueList(
    		HttpServletRequest req,
    		HttpServletResponse res,
    		SearchVO searchVO
    		) throws Exception{

    	List<ReportIssueListVO> reportIssueList = officialReportIssueListService.getReportIssueList(searchVO);
    	
        return reportIssueList;
    }
    
    @RequestMapping(value="/report/officialReport/sendReport.json")
    public void sendReport(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	JSONObject nJson = new JSONObject();

    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	ReportIssueListVO vo = (ReportIssueListVO)JSONObject.toBean(jarray.getJSONObject(i), ReportIssueListVO.class);
	        	vo.setAdminid(user.getAdminid());
				//approveIssueService.upReportApproval(vo);

				officialReportIssueListService.inTheReport(vo);
				officialReportIssueListService.upRequestState(vo);
				officialReportIssueListService.upReportState(vo);
        		///////////////////
        		if("E".equals(vo.getSendtype())){
        			//e-mail 전송 
        			
        			SendMail sendMail = new SendMail();
        			sendMail.send("","","");
        		}
        		///////////////
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
