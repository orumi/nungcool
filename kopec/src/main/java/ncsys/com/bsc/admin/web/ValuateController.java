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


import ncsys.com.bsc.admin.service.ValuateGroupService;

@Controller
@RequestMapping("/admin/valuate")
public class ValuateController {

	@Resource(name = "valuateGroupService")
	private ValuateGroupService valuateGroupService;

	@RequestMapping(value = "/list.do")
	public String appConfig(Model model) throws Exception {

		return "ncsys/bsc/admin/valuate/list.tiles";
	}

	@RequestMapping(value = "/selectInit.json", method = RequestMethod.POST)
	public ModelAndView selectInit(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> selectValuate = valuateGroupService.selectValuate(param);

			mv.addObject("selectValuate", selectValuate);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/selectValuate.json", method = RequestMethod.POST)
	public ModelAndView selectValuate(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> selectValuate = valuateGroupService.selectValuate(param);

			mv.addObject("selectValuate", selectValuate);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/selectEvaler.json", method = RequestMethod.POST)
	public ModelAndView selectEvaler(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> selectEvaler = valuateGroupService.selectEvaler(param);

			mv.addObject("selectEvaler", selectEvaler);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/adjustValute.json", method = RequestMethod.POST)
	public ModelAndView adjustConfig(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");

		try {
			String userId = (String)request.getSession().getAttribute("userId");

    		param.put("userId", userId);

			List<Map<String, Object>> selectValuate = valuateGroupService.adjustValuate(param);
			mv.addObject("selectValuate", selectValuate);
			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/deleteValuate.json", method = RequestMethod.POST)
	public ModelAndView deleteValuate(HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> selectValuate = valuateGroupService.deleteValuate(param);
			mv.addObject("selectValuate", selectValuate);
			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}










	@RequestMapping(value = "/orgAddScore.do")
	public String orgAddScore(Model model) throws Exception {

		return "ncsys/bsc/admin/valuate/orgAddScore.tiles";
	}


	@RequestMapping(value = "/selectOrgAddScrInit.json", method = RequestMethod.POST)
	public ModelAndView selectOrgAddScrInit(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> selectOrgAddScore = valuateGroupService.selectOrgAddScore(param);

			mv.addObject("selectOrgAddScore", selectOrgAddScore);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


	@RequestMapping(value = "/selectOrgAddScoreDetail.json", method = RequestMethod.POST)
	public ModelAndView selectOrgAddScoreDetail(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			Map<String, Object> selectOrgAddScoreDetail = valuateGroupService.selectOrgAddScoreDetail(param);

			mv.addObject("selectOrgAddScoreDetail", selectOrgAddScoreDetail);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/adjustOrgAddScr.json", method = RequestMethod.POST)
	public ModelAndView adjustOrgAddScr(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			String userId = (String)request.getSession().getAttribute("userId");
			valuateGroupService.adjustOrgAddScore(param);

			List<Map<String, Object>> selectOrgAddScore = valuateGroupService.selectOrgAddScore(param);

			mv.addObject("selectOrgAddScore", selectOrgAddScore);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


	@RequestMapping(value = "/deleteOrgAddScore.json", method = RequestMethod.POST)
	public ModelAndView deleteOrgAddScore(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			valuateGroupService.deleteOrgAddScore(param);

			List<Map<String, Object>> selectOrgAddScore = valuateGroupService.selectOrgAddScore(param);

			mv.addObject("selectOrgAddScore", selectOrgAddScore);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


}
