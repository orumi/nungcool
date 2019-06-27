package tems.com.exam.requestConfirm.web;

import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import tems.com.common.StringUtils;
import tems.com.exam.req.model.ReqSmpListVO;
import tems.com.exam.req.service.ReqDetailService;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;
import tems.com.exam.requestConfirm.service.RcListService;

@Controller
public class RcListDetailController {
	
	@Resource(name = "RcListService")
    private RcListService rcListService;
	
	@Resource(name = "ReqDetailService")
    private ReqDetailService reqDetailService;

	@RequestMapping(value="/exam/requestConfirm/RcListDetail.do")
	public String RcListDetail(HttpServletRequest req,
			ModelMap model) throws Exception{
		
		String datas              = StringUtils.nvl(req.getParameter("data"),"");
		String confirm              = StringUtils.nvl(req.getParameter("confirm"),"");
		String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");
		String data[]	=	datas.split(",");
		String returnUrl = "";
		
		if(confirm.equals("Y")){
			ReqConfirmListVO reqConfirmListVO = new ReqConfirmListVO();
			reqConfirmListVO.setApprid(StringUtils.nvl(req.getParameter("apprid"),""));
			reqConfirmListVO.setReqid(reqid);
			rcListService.upApproval(reqConfirmListVO);
		} else if(confirm.equals("R")){
			
			ReqConfirmListVO reqConfirmListVO = new ReqConfirmListVO();
			reqConfirmListVO.setReqid(reqid);
			reqConfirmListVO.setRejid(StringUtils.nvl(req.getParameter("apprid"),""));
			reqConfirmListVO.setApprid(StringUtils.nvl(req.getParameter("apprid"),""));
			reqConfirmListVO.setRejdesc(StringUtils.nvl(req.getParameter("rejdesc"),""));
			
			rcListService.upReject(reqConfirmListVO);
		}
		
    	List<ReqSmpListVO> reqSmpList = reqDetailService.getReqSmpList(data[0]);
    	
    	model.addAttribute("reqDetail",reqDetailService.getReqDetail(data[0]));
    	model.addAttribute("reqSmpList", reqSmpList);
    	model.addAttribute("reqid",data[0]);
    	
    	data = (String[]) ArrayUtils.removeElement(data, data[0]);
    	String nextdatas = StringUtils.ArrayToString(data);
    	
    	model.addAttribute("data",nextdatas);
    	
    	if(datas.equals("")){
    		returnUrl = "tems/com/exam/requestConfirm/RcList"; 
    	} else {
    		returnUrl = "tems/com/exam/requestConfirm/RcListDetail";
    	}
		
		return returnUrl;
	}
	
	@RequestMapping(value="/exam/requestConfirm/RcListDetailConfrim.do")
	public String RcListDetailConfrim(HttpServletRequest req,
				ReqConfirmListVO reqConfirmListVO,
				ModelMap model
				) throws Exception{
		
		String datas              = StringUtils.nvl(req.getParameter("data"),"");
		String data[]	=	datas.split(",");
		String returnUrl = "";
		
		
		
    	List<ReqSmpListVO> reqSmpList = reqDetailService.getReqSmpList(data[0]);
    	
    	model.addAttribute("reqDetail",reqDetailService.getReqDetail(data[0]));
    	model.addAttribute("reqSmpList", reqSmpList);
    	
    	data = (String[]) ArrayUtils.removeElement(data, data[0]);
    	datas = StringUtils.ArrayToString(data);
    	
    	model.addAttribute("data",datas);
    	
    	
    	
    	if(data.length < 1){
    		returnUrl = "tems/com/exam/requestConfirm/RcList"; 
    	} else {
    		returnUrl = "tems/com/exam/requestConfirm/RcListDetail";
    	}
		
		return returnUrl;
	}
}
