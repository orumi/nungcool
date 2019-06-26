package exam.com.support.web;


import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.apache.commons.lang.time.FastDateFormat;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tems.com.common.StringUtils;
import egovframework.com.cmm.service.EgovProperties;
import exam.com.main.model.CompanyVO;
import exam.com.main.model.LoginUserVO;
import exam.com.main.service.LoginUserService;
import exam.com.req.model.ClassVO;
import exam.com.req.model.DuplicateVO;
import exam.com.req.model.ExceptItem;
import exam.com.req.model.ItemGroupVO;
import exam.com.req.model.ItemVO;
import exam.com.req.model.MasterVO;
import exam.com.req.model.MemberInfo;
import exam.com.req.model.MethodCheckVO;
import exam.com.req.model.PriceVO;
import exam.com.req.model.RequestAttachVO;
import exam.com.req.model.RequestVO;
import exam.com.req.model.ResultVO;
import exam.com.req.model.SampleVO;
import exam.com.req.model.SearchDetailItem;
import exam.com.req.model.TempletVO;
import exam.com.req.model.TreeVO;
import exam.com.req.service.RequestService;
import exam.com.support.model.EquipDetailVO;
import exam.com.support.model.EquipItemVO;
import exam.com.support.model.EquipReqVO;
import exam.com.support.model.MembershipVO;
import exam.com.support.service.EstimateService;
import exam.com.support.service.MembershipService;



@Controller
public class MembershipController {

    @Resource(name = "MembershipService")
    private MembershipService membershipService;
    
    @Resource(name = "loginUserService")
    private LoginUserService loginUserService;
    
    @Resource(name = "RequestService")
    private RequestService requestService;
    
	/* open Page */
	
    private static final Logger LOGGER = LoggerFactory.getLogger(MembershipController.class);
    
 	
 	/* open Page */
 	@RequestMapping("/member/membership.do")
 	public String membership(HttpServletRequest request, HttpServletResponse response) throws Exception {
 		
 		/* tiles setting tiles.xml */
 		return "support/membership";
 	}
 	
 	/* open Page */
 	@RequestMapping("/member/equipment.do")
 	public String equipment(HttpServletRequest request, HttpServletResponse response) throws Exception {
 		
 		/* tiles setting tiles.xml */
 		return "support/equipment";
 	}
 	
 	/* open Page */
 	@RequestMapping("/member/equipmentDetail.do")
 	public String equipmentDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
 		
 		/* tiles setting tiles.xml */
 		return "support/equipmentDetail";
 	}
 	
 	
 	 
   /* equipment */
    @RequestMapping(value="/member/actionEquipment.json")
    public @ResponseBody void  actionEquipment(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	request.setCharacterEncoding("UTF-8"); 
    	response.setContentType("text/html;charset=UTF-8");
    	
    	LoginUserVO loginUser = (LoginUserVO) request.getSession().getAttribute("loginUserVO");
    	JSONObject nJson = new JSONObject();
    	
    	try {
            
    		String formTag = request.getParameter("formTag")!=null?request.getParameter("formTag"):"";
        	
        	if("selectInfo".equals(formTag)){
        		if(loginUser!=null){
        			
        			
        			List<MemberInfo> memberInfo = requestService.getMemberInfo(loginUser);
    	    		nJson.put("info", memberInfo);
    	    		
    	    		
        			nJson.put("RESULT_YN"     ,"Y");
        		} else {
        			nJson.put("RESULT_YN"     ,"N");
        		}
        	
        	} else if ("selectEquipReq".equals(formTag)) {
        		if(loginUser!=null){
        			List<MemberInfo> memberInfo = requestService.getMemberInfo(loginUser);
    	    		nJson.put("info", memberInfo);
    	    		String equipreqid = request.getParameter("equipreqid");
    	    		
    	    		HashMap<String, String> map = new HashMap<String, String>();
    	    		map.put("comid", loginUser.getComid());
    	    		map.put("equipreqid", equipreqid);
    	    		
    	    		// 기본정보
    	    		List<EquipReqVO> list_equipReqVO = membershipService.selectEquipReqDetail(map);
    	    		nJson.put("RESULT_EQUIPREQ", list_equipReqVO);
    	    		
    	    		
    	    		// 장비 정보
    	    		List<EquipDetailVO> list_equipDetailVO = membershipService.selectEquipDetailList(equipreqid);
    	    		nJson.put("RESULT_EQUIPREQLIST", list_equipDetailVO);
    	    		
        			nJson.put("RESULT_YN"     ,"Y");
        		} else {
        			nJson.put("RESULT_YN"     ,"N");
        		}
        	} else if ("updateMembership".equals(formTag)){
        		if(loginUser!=null){
        			MembershipVO vo = new MembershipVO();
        			vo.setComid(loginUser.getComid());
        			vo.setStartdate(request.getParameter("sDate"));
        			vo.setEnddate(request.getParameter("eDate"));
        			vo.setEcstat("0"); // 신청중
        			vo.setEcdiv("-1");  // 신청중 
        			vo.setRegid(loginUser.getMemid());
        			
        			String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";
        			
        			if("U".equals(tag)){
        				membershipService.updateMembership(vo);
        			} else {
        				membershipService.insertMembership(vo);
        			}
        			
        			List<MembershipVO> list_membershipVO = membershipService.selectMembership(loginUser);
        			nJson.put("RESULT_MEMBERSHIP", list_membershipVO);
        			nJson.put("RESULT_YN"     ,"Y");
        		}
        	} else if ("selectEquips".equals(formTag)) {
        		if(loginUser!=null){
        			String searchkey = request.getParameter("searchkey");
        			List<EquipItemVO> list_equipItemVO = membershipService.selectSearchEquip(searchkey);
        			
        			nJson.put("RESULT_EQUIPS", list_equipItemVO);
        			nJson.put("RESULT_YN", "Y");
        		}
        	} else if ("setDelete".equals(formTag)){
        		if(loginUser!=null){
        			String equipreqid = request.getParameter("equipreqid");
        			
        			membershipService.deleteEquipReq(equipreqid);
        			
        			nJson.put("RESULT_YN", "Y");
        		}
        	} else if ("setRequest".equals(formTag)){
        		if(loginUser!=null){
        			String data      = StringUtils.nvl(request.getParameter("frmData"),"");
	        		JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
	        			
	        		for(int i = 0; i < jarray.size(); i++){
	        			EquipReqVO vo = (EquipReqVO)JSONObject.toBean(jarray.getJSONObject(i), EquipReqVO.class);
	        			
	        			//actionAjax({"formTag":"setRequest", "sDate":sDate, "eDate":eDate, "tag":tag,  "frmData": frmData, "selEquip":selEquip });
	        			
	        			String selEquip = request.getParameter("selEquip");
	        			
	        			
	        			vo.setState("0");
	        			vo.setComid(loginUser.getComid());
	        			vo.setMemid(loginUser.getMemid());
	        			
	        			
	        			String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";
	        			
	        			if("U".equals(tag)){
	        				String equipreqid = request.getParameter("equipreqid");
	        				vo.setEquipreqid(equipreqid);
	        				
	        				membershipService.updateEquipReq(vo);
	        			} else {
	        				membershipService.insertEquipReq(vo);
	        			}
	        			
	        			
	        			// equips
	        			String[] aEquip = selEquip.split("\\|");
	        			
	        			membershipService.deleteEquipContract(vo.getEquipreqid());
	        			
	        			for (int j = 0; j < aEquip.length; j++) {
							String equipid = aEquip[j];
							if(!"".equals(equipid)){
								EquipDetailVO equipDetailVO = new EquipDetailVO();
								equipDetailVO.setEquipreqid(vo.getEquipreqid());
								equipDetailVO.setEquipid(equipid);
								
								equipDetailVO.setRegid(loginUser.getMemid());
								
								membershipService.insertEquipContract(equipDetailVO);
								
							}
						}
	        			
	        			membershipService.updateTotPay(vo.getEquipreqid());
	        			
        			}
        			
        		}
        		
        		nJson.put("RESULT_YN"     ,"Y");
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
 	
 	
	// 의뢰정보 적용하기 ;
    
    @RequestMapping(value="/member/actionMembership.json")
    public @ResponseBody void  actionMembership(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	request.setCharacterEncoding("UTF-8"); 
    	response.setContentType("text/html;charset=UTF-8");
    	
    	LoginUserVO loginUser = (LoginUserVO) request.getSession().getAttribute("loginUserVO");
    	JSONObject nJson = new JSONObject();
    	
    	try {
            
    		String formTag = request.getParameter("formTag")!=null?request.getParameter("formTag"):"";
        	
    		if("selectMembershipInfo".equals(formTag)){
        		if(loginUser!=null){
        			List<CompanyVO> list_companyVO = loginUserService.selectCompany(loginUser.getComid());
        			nJson.put("RESULT_COMPANY", list_companyVO);
        			
        			List<MembershipVO> list_MembershipVO = membershipService.selectMembership(loginUser);
        			nJson.put("RESULT_MEMBERSHIP", list_MembershipVO);
        			nJson.put("RESULT_YN"     ,"Y");
        		} else {
        			nJson.put("RESULT_YN"     ,"N");
        		}
        	} else if("selectInfo".equals(formTag)){
        		if(loginUser!=null){
        			List<CompanyVO> list_companyVO = loginUserService.selectCompany(loginUser.getComid());
        			nJson.put("RESULT_COMPANY", list_companyVO);
        			
        			List<EquipReqVO> list_equipReqVO = membershipService.selectEquipReq(loginUser.getComid());
        			nJson.put("RESULT_EQUIPREQLIST", list_equipReqVO);
        			nJson.put("RESULT_YN"     ,"Y");
        		} else {
        			nJson.put("RESULT_YN"     ,"N");
        		}
        	} else if ("updateMembership".equals(formTag)){
        		if(loginUser!=null){
        			MembershipVO vo = new MembershipVO();
        			vo.setComid(loginUser.getComid());
        			vo.setStartdate(request.getParameter("sDate"));
        			vo.setEnddate(request.getParameter("eDate"));
        			vo.setEcstat("0"); // 신청중
        			vo.setEcdiv("-1");  // 신청중 
        			vo.setRegid(loginUser.getMemid());
        			
        			String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";
        			
        			if("U".equals(tag)){
        				membershipService.updateMembership(vo);
        			} else {
        				membershipService.insertMembership(vo);
        			}
        			
        			List<MembershipVO> list_membershipVO = membershipService.selectMembership(loginUser);
        			nJson.put("RESULT_MEMBERSHIP", list_membershipVO);
        			nJson.put("RESULT_YN"     ,"Y");
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
    
    
    
    
}
