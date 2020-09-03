package ncsys.com.bsc.admin.web;


import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.nc.xml.PsnBonusUtil;

import ncsys.com.bsc.admin.service.AppConfigService;
import ncsys.com.bsc.admin.service.PerformService;
import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.util.Util;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

@Controller
@RequestMapping("/admin/config")
public class ConfigController {


	@Resource(name="appConfigService")
	private AppConfigService appConfigService;



    @RequestMapping(value="/appConfig.do")
    public String appConfig(Model model) throws Exception {

    	return "ncsys/bsc/admin/config/appConfig.tiles";
    }


    @RequestMapping(value = "/selectInit.json", method=RequestMethod.POST )
	public ModelAndView selectInit(
			@RequestParam HashMap<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
    		List<Map<String, Object>> selectConfig = appConfigService.selectConfig(param);

    		mv.addObject("selectConfig", selectConfig);


	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}


    @RequestMapping(value = "/adjustConfig.json", method=RequestMethod.POST )
	public ModelAndView adjustConfig(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
	    	List<Map<String, Object>> selectConfig = appConfigService.adjustConfig(param);
	    	mv.addObject("selectConfig", selectConfig);
	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}





    @RequestMapping(value="/schedule.do")
    public String schedule(Model model) throws Exception {

    	return "ncsys/bsc/admin/config/schedule.tiles";
    }


    @RequestMapping(value = "/selectSchedule.json", method=RequestMethod.POST )
	public ModelAndView selectSchedule(
			@RequestParam HashMap<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
    		List<Map<String, Object>> selectSchedule = appConfigService.selectSchedule(param);

    		mv.addObject("selectSchedule", selectSchedule);
	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}

    @RequestMapping(value = "/adjustSchedule.json", method=RequestMethod.POST )
	public ModelAndView adjustSchedule(
			@RequestParam HashMap<String, Object> param
			,HttpServletRequest request, HttpServletResponse response)  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{

    		String userId = (String)request.getSession().getAttribute("userId");

    		param.put("userId", userId);

    		List<Map<String, Object>> selectSchedule = appConfigService.adjustSchedule(param);

    		mv.addObject("selectSchedule", selectSchedule);
	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}

    @RequestMapping(value = "/adjustCopySchedule.json", method=RequestMethod.POST )
	public ModelAndView adjustCopySchedule(
			@RequestParam HashMap<String, Object> param
			,HttpServletRequest request, HttpServletResponse response)  {
    	String userId = (String)request.getSession().getAttribute("userId");

		param.put("userId", userId);
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
    		appConfigService.adjustCopySchedule(param);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}



    @RequestMapping(value="/deptOwner.do")
    public String deptOwner(Model model) throws Exception {

    	return "ncsys/bsc/admin/config/deptOwner.tiles";
    }

    @RequestMapping(value = "/selectHierachySBU.json", method=RequestMethod.POST )
	public ModelAndView selectHierachySBU(
			@RequestParam HashMap<String, Object> param
			,HttpServletRequest request, HttpServletResponse response
			)  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
    		List<Map<String, Object>> node = appConfigService.selectHierarchySBU(param);

    		mv.addObject("node", node);

    		mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}

    @RequestMapping(value = "/selectUserList.json", method=RequestMethod.POST )
	public ModelAndView selectUserList(
			@RequestParam HashMap<String, Object> param
			,HttpServletRequest request, HttpServletResponse response)  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
    		List<Map<String, Object>> userList = appConfigService.selectUserList();

    		mv.addObject("userList", userList);

    		mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}


    @RequestMapping(value = "/selectOwnerBySbuId.json", method=RequestMethod.POST )
	public ModelAndView selectOwnerBySbuId(
			@RequestParam HashMap<String, Object> param
			,HttpServletRequest request, HttpServletResponse response)  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
    		List<Map<String, Object>> ownerBySbuId = appConfigService.selectOwnerBySbuId(param);

    		mv.addObject("ownerBySbuId", ownerBySbuId);

    		mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}


    @RequestMapping(value = "/adjustOwners.json", method=RequestMethod.POST, produces="application/json" )
	public ModelAndView adjustOwners(
			@RequestParam HashMap<String, Object> param
			,HttpServletRequest request, HttpServletResponse response)  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
    		String userId = (String)request.getSession().getAttribute("userId");

    		JSONArray owners = JSONArray.fromObject(JSONSerializer.toJSON(param.get("owners")));
    		List<Object> listOwners = Util.TOLIST(owners);

    		appConfigService.deleteSbuOwner(param);
    		for(Object owner:listOwners){
    			Map<String, Object> map = (Map<String, Object>) owner;
    			map.put("loginid", userId);
    			map.put("year", param.get("year"));
    			appConfigService.insertSbuOwner(map);
    		}

    		List<Map<String, Object>> userList = appConfigService.selectUserList();

    		mv.addObject("userList", userList);

    		mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}
}
