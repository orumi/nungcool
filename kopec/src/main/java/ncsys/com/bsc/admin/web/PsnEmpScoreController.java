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

import ncsys.com.bsc.admin.service.PsnEmpScoreService;
import ncsys.com.bsc.admin.service.ValuateGroupService;

@Controller
@RequestMapping("/admin/psn")
public class PsnEmpScoreController {

	@Resource(name = "psnEmpScoreService")
	private PsnEmpScoreService psnEmpScoreService;

	@RequestMapping(value = "/psnEmpScore.do")
	public String psnEmpScore(Model model) throws Exception {

		return "ncsys/bsc/admin/psn/psnEmpScore.tiles";
	}

	@RequestMapping(value = "/selectInit.json", method = RequestMethod.POST)
	public ModelAndView selectInit(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> selectPeriod = psnEmpScoreService.selectPeriod(param);

			mv.addObject("selectPeriod", selectPeriod);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/selectPsnEmpScore.json", method = RequestMethod.POST)
	public ModelAndView selectPsnEmpScore(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> selectPeriod = psnEmpScoreService.selectPeriod(param);

			if("Y".equals(selectPeriod.get(0).get("divYn"))){
				List<Map<String, Object>> selectPsnLabor = psnEmpScoreService.selectPsnLabor(param);
				if("Y".equals(selectPsnLabor.get(0).get("laboryn"))){
					mv.addObject("reCode", "PSNLABOR");
				} else {
					List<Map<String, Object>> selectPsnScore = psnEmpScoreService.selectPsnScore(param);
					List<Map<String, Object>> selectPsnBizmh = psnEmpScoreService.selectPsnBizmh(param);

					mv.addObject("selectPsnScore", selectPsnScore);
					mv.addObject("selectPsnBizmh", selectPsnBizmh);

					mv.addObject("reCode", "SUCCESS");

				}
			} else {
				mv.addObject("reCode", "NOPERIOD");
			}

		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/selectEmployee.json", method = RequestMethod.POST)
	public ModelAndView selectEvaler(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> selectEmp = psnEmpScoreService.selectEmp(param);

			mv.addObject("selectEmp", selectEmp);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


}
