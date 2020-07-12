package ncsys.com.bsc.analysis.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nc.xml.ScoreTableUtil;

import ncsys.com.bsc.admin.service.MeasureService;
import ncsys.com.bsc.admin.service.PsnEmpScoreService;
import ncsys.com.bsc.admin.service.ValuateGroupService;
import ncsys.com.bsc.admin.service.model.Item;
import ncsys.com.bsc.admin.service.model.MeasureDefine;
import ncsys.com.bsc.admin.service.model.MeasureUser;
import ncsys.com.bsc.scorecard.service.OrgScoreService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/analysis/orgAnalysis")
public class OrgAnalysisController {

	@Resource(name = "orgScoreService")
	private OrgScoreService orgScoreService;

	@Resource(name="MeasureService")
	private  MeasureService measureService;


	@RequestMapping(value = "/orgAnalysis.do")
	public String view(Model model) throws Exception {

		List<Map<String, Object>> config = orgScoreService.selectConfig();
		model.addAttribute("config", config);

		if(config.size()>0){
			String year = (String)config.get(0).get("showyear");
			HashMap<String, Object> map = new HashMap<>();

			map.put("year",year);

			List<Map<String, Object>> sbuBsc = orgScoreService.selectSbuBsc(map);

			model.addAttribute("sbuBsc", sbuBsc);
		}


		return "ncsys/bsc/analysis/orgAnalysis/orgAnalysis.tiles";
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
