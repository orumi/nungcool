package ncsys.com.portal.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.LoginVO;
import ncsys.com.isms.main.service.MainMngService;
import ncsys.com.isms.main.service.model.RadarDetail;
import ncsys.com.portal.service.PortalService;
import ncsys.com.portal.service.model.LeftMenu;
import ncsys.com.portal.service.model.PlannedSchedule;
import ncsys.com.util.Criteria;
import ncsys.com.util.PageMaker;
import net.sf.json.JSONObject;


@Controller
public class PortalController {

	@Resource(name="portalService")
	private  PortalService portalService;
	
	@Resource(name="mainMngService")
	private  MainMngService mainMngService;
	
    
    @RequestMapping(value="/isms/main.do")
    public String doIsmsMain() throws Exception {

    	return "isms/main/main.tiles";
    }

    @RequestMapping(value="/main/plannedSchedule.do", method=RequestMethod.GET )
    public String doPlannedSchedule(String planid) throws Exception {
    	
    	System.out.println("planid : "+planid);
    	
    	return "isms/main/plannedSchedule.tiles";
    }
    
    @RequestMapping(value="/main/plannedScheduleDetail.do")
    public String doPlannedScheduleDetail() throws Exception {
    	return "isms/main/plannedScheduleDetail.popup";
    }
    
    
	
    /**
     * Portal index .
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/main/portal.do")
    public String doMainPortal(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

    	try {
	    	System.out.println("PORTAL SYSTEM MAIN ");
	    	LoginVO loginVO = (LoginVO)request.getSession().getAttribute("loginVO");
	    	
	    	List<LeftMenu> leftMenu = portalService.selectLeftMenuList(loginVO);
	    	request.setAttribute("leftMenu", leftMenu);

	    	request.setAttribute("loginVO", loginVO);
	    	
	    	
	    	return "main/portal.tiles";
    	
    	} catch (Exception e) {
    		System.out.println("doMainPortal : "+e);
    		return "/error";
    	}
    }
    
    
    
    /**
     * 계획일정 목록정보 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/main/plannedScheduleList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void plannedScheduleList(HttpServletRequest request, HttpServletResponse response, Criteria cri )  {
    	try{

    		String page = request.getParameter("page");

    		//cri.setCrtPage(Integer.valueOf(page));
    		
	    	JSONObject nJson = new JSONObject();
			
			List<PlannedSchedule> rePlannedSchedule = portalService.selectPlannedScheduleList();
			
			int totCnt = 100;
			PageMaker pageMaker = new PageMaker(cri, totCnt);
			
			nJson.put("rePlannedSchedule", rePlannedSchedule);
			nJson.put("pageMaker", pageMaker);
			nJson.put("cri", cri);
			
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}    
    
    
    /**
     * 계획일정
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/main/plannedScheduleDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void plannedScheduleDetail(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	JSONObject nJson = new JSONObject();
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		PlannedSchedule detail = new ObjectMapper().readValue(json, PlannedSchedule.class);
    		detail.setUserId(loginVO.getId());
    		
	    	if("modify".equals(mode)){
	    		
	    		if("I".equals(detail.getActionmode()) ){
	    			portalService.insertPlannedSchedule(detail);
	    		} else if("D".equals(detail.getActionmode()) ){
	    			portalService.deletePlannedSchedule(detail);
	    		} else if("U".equals(detail.getActionmode())){
	    			portalService.updatePlannedSchedule(detail);
	    		}
	
	    	} else if("select".equals(mode)){
	    		
	    		PlannedSchedule reDetail = portalService.selectPlannedScheduleDetail(detail); 
	    		nJson.put("reDetail", reDetail);
	    	}
	    	
	    	nJson.put("reVal", "ok_resend");
	    	
    	} catch (Exception e ){
    		nJson.put("reVal", "failure_resend");
    		System.out.println(e);
    	} finally {
    		try {
	    		PrintWriter out = response.getWriter();
		        out.write(nJson.toString());
		        out.flush();
		        out.close();
    		} catch (Exception e){ }
    	}
	}
    
    
    
    
    /**
     * 분야별 ISMS 현황 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/main/radarInfor.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void radarInforJson(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
    		
    		RadarDetail radarDetail = new ObjectMapper().readValue(json, RadarDetail.class);
    		//radarDetail.setUserId(loginVO.getId());
	    	
	    	JSONObject nJson = new JSONObject();
			
			List<RadarDetail> reRadarDetail = mainMngService.selectRadar(radarDetail);
			
			nJson.put("radarDetail", reRadarDetail);
			
	    	nJson.put("reVal", "ok_resend");
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}
    
    
    
    /**
     * 분야별 ISMS 현황 
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/main/plannedSchedule.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void plannedSchedule(HttpServletRequest request, HttpServletResponse response )  {
    	try{
    		
    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");
	    	
	    	JSONObject nJson = new JSONObject();
			
			List<PlannedSchedule> rePlannedSchedule = portalService.selectPlannedScheduleTable();
			
			nJson.put("rePlannedSchedule", rePlannedSchedule);
			
	    	nJson.put("reVal", "ok_resend");
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();
	        
    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}
}
