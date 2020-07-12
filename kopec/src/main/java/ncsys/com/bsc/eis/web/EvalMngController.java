package ncsys.com.bsc.eis.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import ncsys.com.bsc.eis.service.EvalMngService;


@Controller
@RequestMapping("/eis/evalMng")
public class EvalMngController {

	@Resource(name = "evalMngService")
	private EvalMngService evalMngService;


	@RequestMapping(value = "/evalMng.do")
	public String evalMng(Model model) throws Exception {

		return "ncsys/bsc/eis/evalMng/evalMng.tiles";
	}

	@RequestMapping(value = "/selectInit.json", method = RequestMethod.POST)
	public ModelAndView selectInit(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> orgCd = evalMngService.selectOrgCd(param);
			mv.addObject("orgCd", orgCd);

			List<Map<String, Object>> measDivCd = evalMngService.selectMeasDivCd(param);
			mv.addObject("measDivCd", measDivCd);

			List<Map<String, Object>> measGrpCd = evalMngService.selectMeasGrpCd(param);
			mv.addObject("measGrpCd", measGrpCd);

			List<Map<String, Object>> measCd = evalMngService.selectMeasCd(param);
			mv.addObject("measCd", measCd);


			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/selectOrgMeasure.json", method = RequestMethod.POST)
	public ModelAndView selectOrgMeasure(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> measList = evalMngService.selectMeasList(param);
			mv.addObject("measList", measList);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/adjustOrgMeasure.json", method = RequestMethod.POST)
	public ModelAndView adjustOrgMeasure(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			String userId = (String)request.getSession().getAttribute("userId");
			param.put("userId", userId);

			evalMngService.adjustOrgMeas(param);

			List<Map<String, Object>> measList = evalMngService.selectMeasList(param);
			mv.addObject("measList", measList);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/deleteOrgMeasure.json", method = RequestMethod.POST)
	public ModelAndView deleteOrgMeasure(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			String userId = (String)request.getSession().getAttribute("userId");
			param.put("userId", userId);

			evalMngService.deleteOrgMeas(param);

			List<Map<String, Object>> measList = evalMngService.selectMeasList(param);
			mv.addObject("measList", measList);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/insertMeasComCd.json", method = RequestMethod.POST)
	public ModelAndView insertMeasComCd(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			String userId = (String)request.getSession().getAttribute("userId");
			param.put("userId", userId);

			evalMngService.insertMeasComCd(param);

			List<Map<String, Object>> measCd = evalMngService.selectMeasCd(param);
			mv.addObject("measCd", measCd);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


	@RequestMapping(value = "/adjustEvalOrgYearCopy.json", method = RequestMethod.POST)
	public ModelAndView adjustEvalOrgYearCopy(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			String userId = (String)request.getSession().getAttribute("userId");
			param.put("userId", userId);

			evalMngService.adjustEvalOrgCopy(param);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/adjustEvalOrgMeasCopy.json", method = RequestMethod.POST)
	public ModelAndView adjustEvalOrgMeasCopy(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			String userId = (String)request.getSession().getAttribute("userId");
			param.put("userId", userId);

			evalMngService.adjustEvalOrgMeasCopy(param);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}








	@RequestMapping(value = "/selectEvalOrgRst.json", method = RequestMethod.POST)
	public ModelAndView selectEvalOrgRst(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			String userId = (String)request.getSession().getAttribute("userId");
			param.put("userId", userId);

			List<Map<String, Object>> evalOrgRst = evalMngService.selectEvalOrgRst(param);
			mv.addObject("evalOrgRst", evalOrgRst);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


	@RequestMapping(value = "/adjustEvalOrgRst.json", method = RequestMethod.POST)
	public ModelAndView adjustEvalOrgRst(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			String userId = (String)request.getSession().getAttribute("userId");
			param.put("userId", userId);

			evalMngService.adjustEvalOrgRst(param);

			List<Map<String, Object>> evalOrgRst = evalMngService.selectEvalOrgRst(param);
			mv.addObject("evalOrgRst", evalOrgRst);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


	@RequestMapping(value = "/deleteEvalOrgRst.json", method = RequestMethod.POST)
	public ModelAndView deleteEvalOrgRst(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			String userId = (String)request.getSession().getAttribute("userId");
			param.put("userId", userId);

			evalMngService.deleteEvalOrgRst(param);

			List<Map<String, Object>> evalOrgRst = evalMngService.selectEvalOrgRst(param);
			mv.addObject("evalOrgRst", evalOrgRst);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


	@RequestMapping(value = "/adjustEvalMeasRst.json", method = RequestMethod.POST)
	public ModelAndView adjustEvalMeasRst(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			String userId = (String)request.getSession().getAttribute("userId");
			param.put("userId", userId);

			evalMngService.updateEvalMeasRst(param);

			List<Map<String, Object>> measList = evalMngService.selectMeasList(param);
			mv.addObject("measList", measList);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


}
