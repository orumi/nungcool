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

import ncsys.com.bsc.admin.service.PerformService;
import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.util.Util;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

@Controller
@RequestMapping("/admin/perform")
public class PerformController {


	@Resource(name="PerformService")
	private PerformService performService;



    @RequestMapping(value="/paymentRate.do")
    public String paymentRate(Model model) throws Exception {

    	return "ncsys/bsc/admin/perform/paymentRate.tiles";
    }


    @RequestMapping(value = "/selectInit.json", method=RequestMethod.POST )
	public ModelAndView selectInit(
			@RequestParam HashMap<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
    		List<Map<String, Object>> selectPsnBaseLine = performService.selectPsnBaseLine(param);
    		List<Map<String, Object>> selectPsnJikgub = performService.selectPsnJikgub(param);

    		mv.addObject("selectPsnBaseLine", selectPsnBaseLine);
    		mv.addObject("selectPsnJikgub", selectPsnJikgub);

    		mv.addObject("selectPsnSubMapping", performService.selectPsnSubMapping(param));
    		mv.addObject("selectPsnBscMapping", performService.selectPsnBscMapping(param));

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}


    @RequestMapping(value = "/psnBaseLine.json", method=RequestMethod.POST )
	public ModelAndView psnBaseLine(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
	    	List<Map<String, Object>> selectPsnBaseLine = performService.adjustPsnBaseLine(param);
	    	mv.addObject("selectPsnBaseLine", selectPsnBaseLine);
	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}

    @RequestMapping(value = "/deletePsnBaseLine.json", method=RequestMethod.POST )
	public ModelAndView deletePsnBaseLine(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{
	    	performService.deletePsnBaseLine(param);


	    	List<Map<String, Object>> selectPsnBaseLine = performService.selectPsnBaseLine(param);
    		List<Map<String, Object>> selectPsnJikgub = performService.selectPsnJikgub(param);

    		mv.addObject("selectPsnBaseLine", selectPsnBaseLine);
    		mv.addObject("selectPsnJikgub", selectPsnJikgub);

    		mv.addObject("selectPsnSubMapping", performService.selectPsnSubMapping(param));
    		mv.addObject("selectPsnBscMapping", performService.selectPsnBscMapping(param));

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}


    @RequestMapping(value = "/psnJikgub.json", method=RequestMethod.POST )
	public ModelAndView psnJikgub(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{


    		List<Map<String, Object>> selectPsnJikgub = performService.adjustPsnJikgub(param);
	    	mv.addObject("selectPsnJikgub", selectPsnJikgub);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}


    @RequestMapping(value = "/psnSubMapping.json", method=RequestMethod.POST )
	public ModelAndView psnSubMapping(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{


    		List<Map<String, Object>> selectPsnSubMapping = performService.adjustPsnSubMapping(param);
	    	mv.addObject("selectPsnSubMapping", selectPsnSubMapping);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}




    /* psnExcept */



    @RequestMapping(value = "/psnExceptInit.json", method=RequestMethod.POST )
	public ModelAndView psnExceptInit(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{


    		List<Map<String, Object>> selectExceptBsc = performService.selectExceptBsc(param);
	    	mv.addObject("selectExceptBsc", selectExceptBsc);

	    	List<Map<String, Object>> selectPsnEmp = performService.selectPsnEmp(param);
	    	mv.addObject("selectPsnEmp", selectPsnEmp);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}


    @RequestMapping(value = "/psnExceptEmp.json", method=RequestMethod.POST )
	public ModelAndView psnExceptEmp(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{


    		List<Map<String, Object>> selectPsnExceptEmp = performService.selectPsnExceptEmp(param);
	    	mv.addObject("selectPsnExceptEmp", selectPsnExceptEmp);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}


    @RequestMapping(value = "/adjustPsnExceptEmp.json", method=RequestMethod.POST )
	public ModelAndView adjustPsnExceptEmp(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{


    		List<Map<String, Object>> selectExceptBsc = performService.adjustPsnExceptEmp(param);
	    	mv.addObject("selectExceptBsc", selectExceptBsc);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}









    @RequestMapping(value = "/psnLaborInit.json", method=RequestMethod.POST )
	public ModelAndView psnLaborInit(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{

    		List<Map<String, Object>> selectPsnEmp = performService.selectPsnEmp(param);
    		List<Map<String, Object>> selectPsnLabor = performService.selectPsnLabor(param);

    		mv.addObject("selectPsnEmp", selectPsnEmp);
    		mv.addObject("selectPsnLabor", selectPsnLabor);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}



    @RequestMapping(value = "/adjustPsnLaborEmp.json", method=RequestMethod.POST )
	public ModelAndView adjustPsnLaborEmp(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{

    		List<Map<String, Object>> selectPsnLabor = performService.adjustPsnLabor(param);
	    	mv.addObject("selectPsnLabor", selectPsnLabor);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}



    @RequestMapping(value = "/psnBscScore.json", method=RequestMethod.POST )
	public ModelAndView psnBscScore(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{

    		PsnBonusUtil util  =  new PsnBonusUtil();
			util.setPsnBscScore(request, response);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}


    @RequestMapping(value = "/psnBizMh.json", method=RequestMethod.POST )
	public ModelAndView psnBizMh(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{

    		PsnBonusUtil util  =  new PsnBonusUtil();
			util.setPsnBizMh(request, response);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}


    @RequestMapping(value = "/psnScore.json", method=RequestMethod.POST )
	public ModelAndView psnScore(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{

    		PsnBonusUtil util  =  new PsnBonusUtil();
			util.setPsnScore(request, response);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}





    @RequestMapping(value = "/selectPsnGrade.json", method=RequestMethod.POST )
	public ModelAndView selectPsnGrade(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{

    		List<Map<String, Object>> selectPsnGradeBase = performService.selectPsnGradeBase(param);

    		mv.addObject("selectPsnGradeBase", selectPsnGradeBase);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}



    @RequestMapping(value = "/adjustPsnGrade.json", method=RequestMethod.POST )
	public ModelAndView adjustPsnGrade(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{

    		List<Map<String, Object>> selectPsnGradeBase = performService.adjustPsnGradeBase(param);
	    	mv.addObject("selectPsnGradeBase", selectPsnGradeBase);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}






    @RequestMapping(value = "/selectPsnBscGrade.json", method=RequestMethod.POST )
	public ModelAndView selectPsnBscGrade(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{

    		List<Map<String, Object>> selectPsnBscGrade = performService.selectPsnBscGrade(param);

    		mv.addObject("selectPsnBscGrade", selectPsnBscGrade);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}



    @RequestMapping(value = "/adjustPsnBscGrade.json", method=RequestMethod.POST )
	public ModelAndView adjustPsnBscGrade(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{

    		PsnBonusUtil util  =  new PsnBonusUtil();
			util.setPsnBscGrade(request, response);

    		List<Map<String, Object>> selectPsnBscGrade = performService.selectPsnBscGrade(param);

    		mv.addObject("selectPsnBscGrade", selectPsnBscGrade);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}


    @RequestMapping(value = "/selectPsnBizMh.json", method=RequestMethod.POST )
	public ModelAndView selectPsnBizMh(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{

    		List<Map<String, Object>> selectPsnBizMh = performService.selectPsnBizMh(param);

    		mv.addObject("selectPsnBizMh", selectPsnBizMh);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}


    @RequestMapping(value = "/selectPsnScore.json", method=RequestMethod.POST )
	public ModelAndView selectPsnScore(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{

    		List<Map<String, Object>> selectPsnScore = performService.selectPsnScore(param);

    		mv.addObject("selectPsnScore", selectPsnScore);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}

    @RequestMapping(value = "/selectPsnScoreList.json", method=RequestMethod.POST )
	public ModelAndView selectPsnScoreList(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param )  {
    	ModelAndView mv = new ModelAndView("jsonView");
    	try{

    		List<Map<String, Object>> selectPsnScoreList = performService.selectPsnScoreList(param);

    		mv.addObject("selectPsnScoreList", selectPsnScoreList);

	    	mv.addObject("reCode", "SUCCESS");
    	} catch (Exception e ){
    		System.out.println(e);
    		mv.addObject("reCode", "FAILURE");
    	}
    	return mv;
	}



}
