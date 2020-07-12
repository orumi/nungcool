package ncsys.com.bsc.valuate.web;

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

import ncsys.com.bsc.actual.service.MeasurePlannedService;
import ncsys.com.bsc.actual.service.MeasureReportService;
import ncsys.com.bsc.scorecard.service.OrgScoreService;
import ncsys.com.bsc.valuate.service.ValuateViewService;

@Controller
@RequestMapping("/valuate/result")
public class ValuateViewController {

	@Resource(name = "orgScoreService")
	private OrgScoreService orgScoreService;

	@Resource(name = "valuateViewService")
	private ValuateViewService valuateViewService;


	@RequestMapping(value = "/valuateView.do")
	public String mboPsnScore(Model model) throws Exception {
		List<Map<String, Object>> config = orgScoreService.selectConfig();
		model.addAttribute("config", config);

		return "ncsys/bsc/valuate/result/valuateView.tiles";
	}

	@RequestMapping(value = "/selectEvalGrp.json", method = RequestMethod.POST)
	public ModelAndView selectEvalGrp(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> evalGrp = valuateViewService.selectEvalGrp(param);
			mv.addObject("evalGrp", evalGrp);

			mv.addObject("reCode", "SUCCESS");

		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/selectEvalView.json", method = RequestMethod.POST)
	public ModelAndView selectEvalView(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> evalView = valuateViewService.selectEvalView(param);
			mv.addObject("evalView", evalView);

			mv.addObject("reCode", "SUCCESS");

		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


}
