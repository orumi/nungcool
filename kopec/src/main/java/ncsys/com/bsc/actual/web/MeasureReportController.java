package ncsys.com.bsc.actual.web;

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

@Controller
@RequestMapping("/actual/report")
public class MeasureReportController {

	@Resource(name = "orgScoreService")
	private OrgScoreService orgScoreService;

	@Resource(name = "measureReportService")
	private MeasureReportService measureReportService;


	@RequestMapping(value = "/measureActual.do")
	public String mboPsnScore(Model model) throws Exception {
		List<Map<String, Object>> config = orgScoreService.selectConfig();
		model.addAttribute("config", config);

		return "ncsys/bsc/actual/report/measureActual.tiles";
	}


	@RequestMapping(value = "/selectMeasureActual.json", method = RequestMethod.POST)
	public ModelAndView selectMeasureActual(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> measureQty = measureReportService.selectMeasureQty(param);
			mv.addObject("measureQty", measureQty);

			List<Map<String, Object>> measureQly = measureReportService.selectMeasureQly(param);
			mv.addObject("measureQly", measureQly);

			mv.addObject("reCode", "SUCCESS");

		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}




	@RequestMapping(value = "/measureStatus.do")
	public String measureStatus(Model model) throws Exception {
		List<Map<String, Object>> config = orgScoreService.selectConfig();
		model.addAttribute("config", config);

		return "ncsys/bsc/actual/report/measureStatus.tiles";
	}


	@RequestMapping(value = "/selectMeasureStatus.json", method = RequestMethod.POST)
	public ModelAndView selectMeasureStatus(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> measureStatus = measureReportService.selectMeasureStatus(param);
			mv.addObject("measureStatus", measureStatus);

			mv.addObject("reCode", "SUCCESS");

		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


}
