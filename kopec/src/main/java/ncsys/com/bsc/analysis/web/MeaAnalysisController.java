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
@RequestMapping("/analysis/meaAnalysis")
public class MeaAnalysisController {

	@Resource(name = "orgScoreService")
	private OrgScoreService orgScoreService;

	@Resource(name="MeasureService")
	private  MeasureService measureService;


	@RequestMapping(value = "/meaAnalysis.do")
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


		return "ncsys/bsc/analysis/meaAnalysis/meaAnalysis.tiles";
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

			ScoreTableUtil util = new ScoreTableUtil();
			JSONArray selectOrgScore =  util.selectMeasureScore(request, response);

			mv.addObject("selectOrgScore",selectOrgScore);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


    @RequestMapping(value = "/selectMeasureActuals.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectMeasureActuals(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param )  {
    	JSONObject nJson = new JSONObject();
    	try{


    		Map<String, Object> treescore = measureService.selectMeasureId(param);


    		MeasureDefine measureDefine = new MeasureDefine();
    		measureDefine.setId( String.valueOf(treescore.get("contentid")) );
    		measureDefine.setYear((String)param.get("year"));

	    	MeasureDefine reMeasure = measureService.selectMeasureDefine(measureDefine);

	    	param.put("mid", String.valueOf(treescore.get("contentid")));

	    	List<Map<String, Object>> selectItemActuals = orgScoreService.selectItemActuals(param);

	    	nJson.put("reMeasure", reMeasure);
	    	nJson.put("selectItemActuals", selectItemActuals);

	    	nJson.put("reVal", "ok_resend");

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		nJson.put("reVal", "fail_resend");
    		System.out.println(e);
    	}
	}

}
