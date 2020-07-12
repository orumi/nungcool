package ncsys.com.bsc.analysis.web;

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

import com.nc.xml.ScoreTableUtil;

import ncsys.com.bsc.admin.service.MeasureService;
import ncsys.com.bsc.scorecard.service.OrgScoreService;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/analysis/psn")
public class PsnScoreController {

	@Resource(name = "orgScoreService")
	private OrgScoreService orgScoreService;

	@Resource(name="MeasureService")
	private  MeasureService measureService;


	@RequestMapping(value = "/psnEmpScore.do")
	public String view(Model model,HttpServletRequest request, HttpServletResponse response) throws Exception {

		String userId = (String)request.getSession().getAttribute("userId");
		String userName = (String)request.getSession().getAttribute("userName");


		List<Map<String, Object>> config = orgScoreService.selectConfig();
		model.addAttribute("config", config);

		if(config.size()>0){
			String year = (String)config.get(0).get("showyear");
			HashMap<String, Object> map = new HashMap<>();

			map.put("year",year);

			List<Map<String, Object>> sbuBsc = orgScoreService.selectSbuBsc(map);

			model.addAttribute("sbuBsc", sbuBsc);
		}

		model.addAttribute("userId", userId);
		model.addAttribute("userName", userName);

		return "ncsys/bsc/analysis/psn/psnEmpScore.tiles";
	}



	@RequestMapping(value = "/selectBSC.json", method = RequestMethod.POST)
	public ModelAndView selectBSC(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> sbuBsc = orgScoreService.selectSbuBsc(param);
			mv.addObject("sbuBsc", sbuBsc);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


	@RequestMapping(value = "/selectOrgScore.json", method = RequestMethod.POST)
	public ModelAndView selectOrgScore(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			//List<Map<String, Object>> selectOrgScore = orgScoreService.selectOrgScore(param);
			//mv.addObject("selectOrgScore", selectOrgScore);

			ScoreTableUtil util = new ScoreTableUtil();
			JSONArray selectOrgScore =  util.selectScoreTableScore(request, response);

			mv.addObject("selectOrgScore",selectOrgScore);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}



}
