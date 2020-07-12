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

import ncsys.com.bsc.actual.service.MeasureOwnerService;
import ncsys.com.bsc.eis.service.EvalMngService;
import ncsys.com.bsc.scorecard.service.OrgScoreService;

@Controller
@RequestMapping("/actual/measure")
public class MeasureOwnerController {

	@Resource(name = "orgScoreService")
	private OrgScoreService orgScoreService;

	@Resource(name = "measureOwnerService")
	private MeasureOwnerService measureOwnerService;


	@RequestMapping(value = "/owner.do")
	public String mboPsnScore(Model model) throws Exception {
		List<Map<String, Object>> config = orgScoreService.selectConfig();
		model.addAttribute("config", config);

		return "ncsys/bsc/actual/measure/measureOwner.tiles";
	}


	@RequestMapping(value = "/selectSBU.json", method = RequestMethod.POST)
	public ModelAndView selectSBU(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> selectSBU = measureOwnerService.selectSBU(param);
			mv.addObject("selectSBU", selectSBU);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
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
					param.put("ownerId", userId);
				}

				List<Map<String, Object>> measureList = measureOwnerService.selectMeasureList(param);
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


	@RequestMapping(value = "/selectMeasureOwner.json", method = RequestMethod.POST)
	public ModelAndView selectMeasureOwner(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {


			List<Map<String, Object>> measureOwner = measureOwnerService.selectMeasureOwner(param);
			mv.addObject("measureOwner", measureOwner);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/selectUserList.json", method = RequestMethod.POST)
	public ModelAndView selectUserList(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {


			List<Map<String, Object>> userList = measureOwnerService.selectUserList(param);
			mv.addObject("userList", userList);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/adjustMeasureUpdater.json", method = RequestMethod.POST)
	public ModelAndView adjustMeasureUpdater(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {


			measureOwnerService.adjustMeasureUpdater(param);


			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/adjustUpdaterWithTo.json", method = RequestMethod.POST)
	public ModelAndView adjustUpdaterWithTo(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			measureOwnerService.adjustUpdaterWithTo(param);
			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}





}
