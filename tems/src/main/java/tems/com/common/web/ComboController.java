package tems.com.common.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.common.StringUtils;
import tems.com.common.model.CondComboVO;
import tems.com.common.model.MethodComboVO;
import tems.com.common.model.UnitComboVO;
import tems.com.common.service.ComboService;

@Controller
public class ComboController {
	
	
	@Resource(name = "ComboService")
    private ComboService comboService;
	
	/**
     * 
     * @exception Exception
     */
    @RequestMapping(value="/common/getMethodComboList.json")
    public @ResponseBody List<MethodComboVO>   getMethodComboList(
    		HttpServletRequest req) throws Exception {
    	
    	String smpid              = StringUtils.nvl(req.getParameter("smpid"),"");
    	String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");
    	MethodComboVO vo = new MethodComboVO();
    	vo.setReqid(reqid);
    	vo.setSmpid(smpid);
    	List<MethodComboVO> MethodList = comboService.getMethodComboList(vo);
    	
        return MethodList;
    }
    
    
    @RequestMapping(value="/common/getReqCondComboList.json")
    public @ResponseBody List<CondComboVO>   getReqCondComboList(
    		HttpServletRequest req) throws Exception {
    	
    	String smpid              = StringUtils.nvl(req.getParameter("smpid"),"");
    	String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");
    	
    	CondComboVO vo = new CondComboVO();
    	vo.setReqid(reqid);
    	vo.setSmpid(smpid);
    	List<CondComboVO> CondList = comboService.getSmpCondComboList(vo);
    	
    	
        return CondList;
    }
    
    @RequestMapping(value="/common/getCondComboList.json")
    public @ResponseBody List<CondComboVO>   getCondComboList(
    		HttpServletRequest req,
    		CondComboVO vo) throws Exception {
    	
    	List<CondComboVO> CondList = comboService.getCondComboList(vo);
    	
        return CondList;
    }
    
    @RequestMapping(value="/common/getUnitComboList.json")
    public @ResponseBody List<UnitComboVO>   getUnitComboList(
    		HttpServletRequest req) throws Exception {
    	
    	String smpid              = StringUtils.nvl(req.getParameter("smpid"),"");
    	String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");
    	
    	UnitComboVO vo = new UnitComboVO();
    	vo.setReqid(reqid);
    	vo.setSmpid(smpid);
    	List<UnitComboVO> CondList = comboService.getUnitComboList(vo);
    	
        return CondList;
    }
    
    
    @RequestMapping(value="/common/getComboListAll.json")
    public @ResponseBody HashMap   getComboListAll(
    		HttpServletRequest req) throws Exception {
    	
    	String smpid              = StringUtils.nvl(req.getParameter("smpid"),"");
    	String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");
    	
    	HashMap map = new HashMap();
    	UnitComboVO vo = new UnitComboVO();
    	vo.setReqid(reqid);
    	vo.setSmpid(smpid);
    	List<UnitComboVO> UnitList = comboService.getUnitComboList(vo);
    	
    	MethodComboVO vo2 = new MethodComboVO();
    	vo2.setReqid(reqid);
    	vo2.setSmpid(smpid);
    	List<MethodComboVO> MethodList = comboService.getMethodComboList(vo2);
    	
    	CondComboVO vo3 = new CondComboVO();
    	vo3.setReqid(reqid);
    	vo3.setSmpid(smpid);
    	List<CondComboVO> CondList = comboService.getSmpCondComboList(vo3);
    	
    	map.put("UnitList",UnitList);
    	map.put("MethodList",MethodList);
    	map.put("CondList",CondList);
    	
        return map;
    }
    
    
	
}
