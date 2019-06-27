package tems.com.exam.req.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.json.simple.JSONValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.common.MenuAuthCheck;
import tems.com.common.StringUtils;
import tems.com.exam.req.model.CondDetailVO;
import tems.com.exam.req.model.ItemListVO;
import tems.com.exam.req.model.ItemMethodVO;
import tems.com.exam.req.model.ReqDetailVO;
import tems.com.exam.req.model.ReqPriceVO;
import tems.com.exam.req.model.ReqResultVO;
import tems.com.exam.req.model.ReqSmpListVO;
import tems.com.exam.req.model.RequestItemDetailVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.req.service.ReqDetailService;
import tems.com.exam.req.service.ReqListService;
import tems.com.login.model.LoginUserVO;
import tems.com.system.model.AuthorGrpVO;
import tems.com.system.model.AuthorListVO;
import tems.com.system.service.AuthorGrpService;
import egovframework.com.cmm.ComDefaultCodeVO;

@Controller
public class ReqDetailController {
	
	@Resource(name = "ReqDetailService")
    private ReqDetailService reqDetailService;
	
	@Resource(name = "ReqListService")
    private ReqListService reqListService;
	
	/**
     * 
     * @exception Exception
     */
    @RequestMapping(value="/exam/req/ReqListDetail.do")
    public String ReqListDetail(
    		HttpServletRequest req,
    		ModelMap model) throws Exception {
    	
    	String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");
    	List<ReqSmpListVO> reqSmpList = reqDetailService.getReqSmpList(reqid);
    	
    	model.addAttribute("reqDetail",reqDetailService.getReqDetail(reqid));
    	model.addAttribute("reqSmpList", reqSmpList);
    	model.addAttribute("reqAttachList", reqDetailService.selReqAttach(reqid));
    	
      	return "tems/com/exam/req/ReqListDetail";
    }
    
    @RequestMapping(value="/exam/req/ReqItemList.json")
    public @ResponseBody List<RequestItemDetailVO>  selAuthorGrpList(
    		RequestItemDetailVO reqItemDetailVO
    		) throws Exception{
    	List<RequestItemDetailVO> reqItemDetailList = reqDetailService.getReqItemList(reqItemDetailVO);
    	
        return reqItemDetailList;
    }
    
    @RequestMapping(value="/exam/req/delRequest.json")
    public void delRequest(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");
    	
    	try{
				reqDetailService.delRequest(reqid);
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
    
    
    @RequestMapping(value="/exam/req/upReqRemark.json")
    public void upReqRemark(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	JSONObject nJson = new JSONObject();
    	try{
    	
    	String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");
    	String remark              = StringUtils.nvl(req.getParameter("remark"),"");
		    	ReqDetailVO vo = new ReqDetailVO(); 
		    	vo.setReqid(reqid);
		    	vo.setRemark(remark);
				reqDetailService.upReqRemark(vo);
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
    
    
    @RequestMapping(value="/exam/req/getReqResultList.json")
    public @ResponseBody HashMap  getReqResultList(
    		ReqSmpListVO reqSmpListVO
    		) throws Exception{
    	
    	    	
    	List<ReqResultVO> reqItemDetailList = reqDetailService.getReqResultList(reqSmpListVO);
    	ReqPriceVO reqPriceVO = reqDetailService.selReqPrice(reqSmpListVO);
    	
    	HashMap map = new HashMap();
    	map.put("reqItemDetailList",reqItemDetailList);
    	map.put("reqPriceVO",reqPriceVO);

    	
        return map;
    }
    
    
    @RequestMapping(value="/exam/req/delRequestResult.json")
    public void delRequestResult(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	ReqResultVO vo = new ReqResultVO();
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	vo = (ReqResultVO)JSONObject.toBean(jarray.getJSONObject(i), ReqResultVO.class);
        		reqDetailService.delRequestResult(vo);
        		nJson.put("RESULT_YN"     ,"Y");
        		nJson.put("RESULT_MESSAGE","");
	        }
	        reqDetailService.calPrice(vo);			//수수료 반영
    	}catch(Exception e){
      	  nJson.put("RESULT_YN"     ,"N");
          nJson.put("RESULT_MESSAGE",e.getMessage());
    	}
      PrintWriter out = response.getWriter();
      out.write(nJson.toString());
      out.flush();
      out.close();
    }
    
    @RequestMapping(value="/exam/req/delRequestResultAll.json")
    public void delRequestResultAll(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	ReqResultVO vo = new ReqResultVO();
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	vo = (ReqResultVO)JSONObject.toBean(jarray.getJSONObject(i), ReqResultVO.class);
        		reqDetailService.delRequestResultAll(vo);
        		nJson.put("RESULT_YN"     ,"Y");
        		nJson.put("RESULT_MESSAGE","");
	        }
	        reqDetailService.calPrice(vo);			//수수료 반영
    	}catch(Exception e){
      	  nJson.put("RESULT_YN"     ,"N");
          nJson.put("RESULT_MESSAGE",e.getMessage());
    	}
      PrintWriter out = response.getWriter();
      out.write(nJson.toString());
      out.flush();
      out.close();
    }
    
    @RequestMapping(value="/exam/req/getItemList.json")
    public @ResponseBody List<ItemListVO>  getItemList(
    		HttpServletRequest req
    		) throws Exception{
    	
    	String itemnm              = StringUtils.nvl(req.getParameter("itemnm"),"");
    	List<ItemListVO> ApprList = reqDetailService.getItemList(itemnm);
    	
        return ApprList;
    }
    
    @RequestMapping(value="/exam/req/addResultItem.json")
    public void addResultItem(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	ReqResultVO vo = new ReqResultVO();
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	vo = (ReqResultVO)JSONObject.toBean(jarray.getJSONObject(i), ReqResultVO.class);
	        	vo.setOfficeid(user.getOfficeid());
        		reqDetailService.addResultItem(vo);
        		nJson.put("RESULT_YN"     ,"Y");
        		nJson.put("RESULT_MESSAGE","");
	        }
	        reqDetailService.calPrice(vo);			//수수료 반영
    	}catch(Exception e){
      	  nJson.put("RESULT_YN"     ,"N");
          nJson.put("RESULT_MESSAGE",e.getMessage());
    	}
      PrintWriter out = response.getWriter();
      out.write(nJson.toString());
      out.flush();
      out.close();
    }
    
    @RequestMapping(value="/exam/req/addResultItemAll.json")
    public void addResultItemAll(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	ReqResultVO vo = new ReqResultVO();
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	vo = (ReqResultVO)JSONObject.toBean(jarray.getJSONObject(i), ReqResultVO.class);
	        	vo.setOfficeid(user.getOfficeid());
        		reqDetailService.addResultItemAll(vo);
        		nJson.put("RESULT_YN"     ,"Y");
        		nJson.put("RESULT_MESSAGE","");
	        }
	        reqDetailService.calPrice(vo);			//수수료 반영
    	}catch(Exception e){
      	  nJson.put("RESULT_YN"     ,"N");
          nJson.put("RESULT_MESSAGE",e.getMessage());
    	}
      PrintWriter out = response.getWriter();
      out.write(nJson.toString());
      out.flush();
      out.close();
    }
    
    
    @RequestMapping(value="/exam/req/getItemMethodDetail.json")
    public @ResponseBody ItemMethodVO getItemMethodDetail(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	String itemid              = StringUtils.nvl(req.getParameter("itemid"),"");
    	String methodid              = StringUtils.nvl(req.getParameter("methodid"),"");
    	
		ReqResultVO vo = new ReqResultVO();
		vo.setItemid(itemid);
		vo.setMethodid(methodid);
		return  reqDetailService.getItemMethodDetail(vo);
    }
    
    @RequestMapping(value="/exam/req/getItemConditionDetail.json")
    public @ResponseBody CondDetailVO getItemConditionDetail(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	String itemid              = StringUtils.nvl(req.getParameter("itemid"),"");
    	String condid              = StringUtils.nvl(req.getParameter("condid"),"");
    	
		ReqResultVO vo = new ReqResultVO();
		vo.setItemid(itemid);
		vo.setCondid(condid);
		CondDetailVO vo2 = (CondDetailVO)reqDetailService.getItemConditionDetail(vo); 
		return  vo2;
    }
    
    @RequestMapping(value="/exam/req/edtResultList.json")
    public void edtResultList(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	ReqResultVO vo = new ReqResultVO();
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	vo = (ReqResultVO)JSONObject.toBean(jarray.getJSONObject(i), ReqResultVO.class);
	        	vo.setRegid(user.getAdminid());
        		reqDetailService.upResultDetail(vo);
        		nJson.put("RESULT_YN"     ,"Y");
        		nJson.put("RESULT_MESSAGE","");
	        }
	        reqDetailService.calPrice(vo);			//수수료 반영
    	}catch(Exception e){
      	  nJson.put("RESULT_YN"     ,"N");
          nJson.put("RESULT_MESSAGE",e.getMessage());
    	}
      PrintWriter out = response.getWriter();
      out.write(nJson.toString());
      out.flush();
      out.close();
    }
    
    @RequestMapping(value="/exam/req/upResultDetailAll.json")
    public void upResultDetailAll(
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	String reqid="";
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	ReqResultVO vo = new ReqResultVO();
    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	vo = (ReqResultVO)JSONObject.toBean(jarray.getJSONObject(i), ReqResultVO.class);
	        	vo.setRegid(user.getAdminid());
        		reqDetailService.upResultDetailAll(vo);
        		nJson.put("RESULT_YN"     ,"Y");
        		nJson.put("RESULT_MESSAGE","");
	        }
	        reqDetailService.calPrice(vo);			//수수료 반영
	        
	    }catch(Exception e){
      	  nJson.put("RESULT_YN"     ,"N");
          nJson.put("RESULT_MESSAGE",e.getMessage());
    	}
      PrintWriter out = response.getWriter();
      out.write(nJson.toString());
      out.flush();
      out.close();
    }
    
    @RequestMapping(value="/exam/req/upReqPrice.json")
    public void upReqPrice(
    		HttpServletRequest req,
    		HttpServletResponse response,
    		ReqPriceVO reqPriceVO,
    		ReqResultVO vo
    		) throws Exception{
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	JSONObject nJson = new JSONObject();
    	try{
    		reqPriceVO.setDcprice(StringUtils.nvl(req.getParameter("dcprice"),""));
        	reqPriceVO.setEtcprice(StringUtils.nvl(req.getParameter("etcprice"),""));
        	reqPriceVO.setPricedesc(StringUtils.nvl(req.getParameter("pricedesc"),""));
        	reqPriceVO.setRegid(user.getAdminid());
        	vo.setRegid(StringUtils.nvl(req.getParameter("reqid"),""));
    		
    		reqDetailService.upReqPrice(reqPriceVO);
    		reqDetailService.calPrice(vo);			//수수료 반영
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
    
    @RequestMapping(value="/exam/req/upReqStateOne.json")
    public void upReqState1111111111111111111(
    		RequestListVO requestListVO,
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");
    	String cmbstate              = StringUtils.nvl(req.getParameter("cmbstate"),"");
    	
    	try{
	        	RequestListVO vo = new RequestListVO();
	        	vo.setModifyid(user.getAdminid());
	        	vo.setReqstate(cmbstate);
	        	vo.setReqid(reqid);
        		reqListService.upReqState(vo);				//sms e-mail 전송 및 시료도착정보 저장 해야함
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
