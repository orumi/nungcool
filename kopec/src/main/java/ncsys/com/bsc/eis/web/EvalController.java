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

import ncsys.com.bsc.eis.service.EvalChartService;
import ncsys.com.bsc.eis.service.EvalMeasService;
import ncsys.com.bsc.eis.service.EvalMngService;


@Controller
@RequestMapping("/eis/evaluation")
public class EvalController {

	@Resource(name = "evalChartService")
	private EvalChartService evalChartService;

	@Resource(name = "evalMeasService")
	private EvalMeasService evalMeasService;


	@Resource(name = "evalMngService")
	private EvalMngService evalMngService;



	@RequestMapping(value = "/evalChart.do")
	public String evalChart(Model model) throws Exception {

		return "ncsys/bsc/eis/evaluation/evalChart.tiles";
	}

	@RequestMapping(value = "/selectEvalOrgRst.json", method = RequestMethod.POST)
	public ModelAndView selectEvalOrgRst(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> evalOrgRst = evalChartService.selectEvalOrgRst(param);
			mv.addObject("evalOrgRst", evalOrgRst);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


	@RequestMapping(value = "/evalMeas.do")
	public String evalMng(Model model) throws Exception {

		return "ncsys/bsc/eis/evaluation/evalMeas.tiles";

	}

	@RequestMapping(value = "/selectOrgCode.json", method = RequestMethod.POST)
	public ModelAndView selectOrgCode(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> orgCd = evalMngService.selectOrgCd(param);
			mv.addObject("orgCd", orgCd);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}




	@RequestMapping(value = "/selectEvalMeaRst.json", method = RequestMethod.POST)
	public ModelAndView selectEvalMeaRst(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> evalOrgRst = evalMeasService.selectEvalMeaRst(param);
			mv.addObject("evalOrgRst", evalOrgRst);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/selectEvalMeasQtyRst.json", method = RequestMethod.POST)
	public ModelAndView selectEvalMeasQtyRst(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> evalQtyRst = evalMeasService.selectEvalMeasQtyRst(param);
			mv.addObject("evalQtyRst", evalQtyRst);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


}
