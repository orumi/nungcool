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

import ncsys.com.bsc.admin.service.DeptMappingService;
import ncsys.com.bsc.admin.service.PerformService;
import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.util.Util;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

@Controller
@RequestMapping("/admin/deptMapping")
public class DeptMappingController {


	@Resource(name="DeptMappingService")
	private DeptMappingService deptMappingService;



    @RequestMapping(value="/list.do")
    public String paymentRate(Model model) throws Exception {

    	return "ncsys/bsc/admin/deptMapping/list.tiles";
    }


    @RequestMapping(value = "/selectInit.json", method=RequestMethod.POST )
	public ModelAndView selectInit(
			@RequestParam HashMap<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
    		List<Map<String, Object>> selectBsc = deptMappingService.selectBsc(param);
    		List<Map<String, Object>> selectDept = deptMappingService.selectDept(param);

    		mv.addObject("selectBsc", selectBsc);
    		mv.addObject("selectDept", selectDept);


	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}

    @RequestMapping(value = "/selectBsc.json", method=RequestMethod.POST )
	public ModelAndView selectBsc(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
	    	List<Map<String, Object>> selectBsc = deptMappingService.selectBsc(param);
	    	mv.addObject("selectBsc", selectBsc);
	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}

    @RequestMapping(value = "/selectDeptMapping.json", method=RequestMethod.POST )
	public ModelAndView selectDeptMapping(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
	    	List<Map<String, Object>> selectDeptMapping = deptMappingService.selectDeptMapping(param);
	    	mv.addObject("selectDeptMapping", selectDeptMapping);
	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}

    @RequestMapping(value = "/selectDept.json", method=RequestMethod.POST )
	public ModelAndView selectDept(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
	    	List<Map<String, Object>> selectDept = deptMappingService.selectDept(param);
	    	mv.addObject("selectDept", selectDept);
	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}

    @RequestMapping(value = "/copyDeptMapping.json", method=RequestMethod.POST )
	public ModelAndView copyDeptMapping(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
	    	int reVal = deptMappingService.copyDeptMapping(param);
	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}

    @RequestMapping(value = "/adjustDeptMapping.json", method=RequestMethod.POST )
	public ModelAndView adjustDeptMapping(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
	    	List<Map<String, Object>> selectBsc = deptMappingService.adjustDeptMapping(param);
	    	mv.addObject("selectBsc", selectBsc);
	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}


}
