package ncsys.com.bsc.admin.web;

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

import com.nc.xml.AnalysisUtil;

import ncsys.com.bsc.scorecard.service.OrgScoreService;
import ncsys.com.bsc.valuate.service.ValuateViewService;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/admin/score")
public class ScoreController {

	@Resource(name = "orgScoreService")
	private OrgScoreService orgScoreService;

	@Resource(name = "valuateViewService")
	private ValuateViewService valuateViewService;

	@RequestMapping(value = "/scoreChart.do")
	public String appConfig(Model model) throws Exception {
		List<Map<String, Object>> config = orgScoreService.selectConfig();
		model.addAttribute("config", config);

		return "ncsys/bsc/admin/score/scoreChart.tiles";
	}

	@RequestMapping(value = "/selectAnalyDivisions.json", method = RequestMethod.POST)
	public ModelAndView selectAnalyDivisions(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			AnalysisUtil util= new AnalysisUtil();
			JSONArray jArray = util.selectScoreDivision(request, response);

			mv.addObject("analyDivisions", jArray);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/annuallyChart.do")
	public String annuallyChart(Model model) throws Exception {
		List<Map<String, Object>> config = orgScoreService.selectConfig();
		model.addAttribute("config", config);

		return "ncsys/bsc/admin/score/annuallyChart.tiles";
	}

	@RequestMapping(value = "/selectAnnually.json", method = RequestMethod.POST)
	public ModelAndView selectAnnually(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			AnalysisUtil util= new AnalysisUtil();
			JSONArray jArray = util.selectAnnually(request, response);

			mv.addObject("analyAnnually", jArray);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}
















	@RequestMapping(value = "/qlyComment.do")
	public String qlyComment(Model model) throws Exception {
		List<Map<String, Object>> config = orgScoreService.selectConfig();
		model.addAttribute("config", config);

		return "ncsys/bsc/admin/score/qlyComment.tiles";
	}

	@RequestMapping(value = "/selectComment.json", method = RequestMethod.POST)
	public ModelAndView selectComment(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> qlyComment = valuateViewService.selectQlyComment(param);

			mv.addObject("qlyComment", qlyComment);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/selectCommentDetail.json", method = RequestMethod.POST)
	public ModelAndView selectCommentDetail(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> qlyCommentDtl = valuateViewService.selectQlyCommentDetail(param);

			mv.addObject("qlyCommentDtl", qlyCommentDtl);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}
}
