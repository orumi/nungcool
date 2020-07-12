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
import ncsys.com.bsc.scorecard.service.OrgScoreService;

@Controller
@RequestMapping("/actual/qtyActual")
public class MeasurePlannedController {

	@Resource(name = "orgScoreService")
	private OrgScoreService orgScoreService;

	@Resource(name = "measurePlannedService")
	private MeasurePlannedService measurePlannedService;


	@RequestMapping(value = "/measurePlanned.do")
	public String mboPsnScore(Model model) throws Exception {
		List<Map<String, Object>> config = orgScoreService.selectConfig();
		model.addAttribute("config", config);

		return "ncsys/bsc/actual/qtyActual/measurePlanned.tiles";
	}




	@RequestMapping(value = "/selectMeasureList.json", method = RequestMethod.POST)
	public ModelAndView selectMeasureList(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {


			String groupId = (String)request.getSession().getAttribute("groupId");
			String userId  = (String)request.getSession().getAttribute("userId");

			int group = 1;

			if (groupId!=null) group = Integer.parseInt(groupId);
			if (group<4){

				if (group == 1) {
					// all
				} else {
					param.put("userId", userId);
				}

				List<Map<String, Object>> measureList = measurePlannedService.selectMeasureList(param);
				mv.addObject("measureList", measureList);

				mv.addObject("reCode", "SUCCESS");
			} else {
				mv.addObject("reCode", "NO AUTHORITY");
			}
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


	@RequestMapping(value = "/selectMeasureItem.json", method = RequestMethod.POST)
	public ModelAndView selectMeasureItem(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> measureItem = measurePlannedService.selectMeasureItem(param);
			mv.addObject("measureItem", measureItem);

			mv.addObject("reCode", "SUCCESS");

		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/selectMeasurePlanned.json", method = RequestMethod.POST)
	public ModelAndView selectMeasurePlanned(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> itemActual = measurePlannedService.selectItemActual(param);
			mv.addObject("itemActual", itemActual);

			mv.addObject("reCode", "SUCCESS");

		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


	@RequestMapping(value = "/adjustItemPlanned.json", method = RequestMethod.POST)
	public ModelAndView adjustItemPlanned(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			measurePlannedService.adjustItemActual(param);

			List<Map<String, Object>> itemActual = measurePlannedService.selectItemActual(param);
			mv.addObject("itemActual", itemActual);

			mv.addObject("reCode", "SUCCESS");

		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/deleteItemPlanned.json", method = RequestMethod.POST)
	public ModelAndView deleteItemPlanned(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			measurePlannedService.deleteItemActual(param);

			List<Map<String, Object>> itemActual = measurePlannedService.selectItemActual(param);
			mv.addObject("itemActual", itemActual);

			mv.addObject("reCode", "SUCCESS");

		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

}
