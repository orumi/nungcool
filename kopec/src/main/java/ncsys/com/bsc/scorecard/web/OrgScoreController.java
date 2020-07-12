package ncsys.com.bsc.scorecard.web;

import java.io.PrintWriter;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import ncsys.com.bsc.admin.service.MeasureService;
import ncsys.com.bsc.admin.service.model.Item;
import ncsys.com.bsc.admin.service.model.MeasureDefine;
import ncsys.com.bsc.admin.service.model.MeasureUser;
import ncsys.com.bsc.scorecard.service.OrgScoreService;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/scorecard/score")
public class OrgScoreController {

	@Resource(name = "orgScoreService")
	private OrgScoreService orgScoreService;

	@Resource(name="MeasureService")
	private  MeasureService measureService;


	@RequestMapping(value = "/orgScore.do")
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


		return "ncsys/bsc/scorecard/strategy/orgScore.tiles";
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



	@RequestMapping(value = "/selectState.json", method = RequestMethod.POST)
	public ModelAndView selectState(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> selectState = orgScoreService.selectState(param);
			mv.addObject("selectState", selectState);

			List<Map<String, Object>> selectOrgScore = orgScoreService.selectOrgScore(param);
			mv.addObject("selectOrgScore", selectOrgScore);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/selectOrgScore.json", method = RequestMethod.POST)
	public ModelAndView selectOrgScore(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> selectOrgScore = orgScoreService.selectOrgScore(param);
			mv.addObject("selectOrgScore", selectOrgScore);

			mv.addObject("reCode", "SUCCESS");
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
			List<Map<String, Object>> selectEmp = orgScoreService.selectConfig();

			mv.addObject("selectEmp", selectEmp);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}



    @RequestMapping(value = "/selectMeasureDefine.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectMeasureDefineJson(HttpServletRequest request, HttpServletResponse response,   @RequestParam HashMap<String, Object> param )  {
    	JSONObject nJson = new JSONObject();
    	try{

    		MeasureDefine measureDefine = new MeasureDefine();
    		measureDefine.setId((String)param.get("mid"));
    		measureDefine.setYear((String)param.get("year"));

	    	MeasureDefine reMeasure = measureService.selectMeasureDefine(measureDefine);

	    	List<Item> reItem = measureService.selectMeasureItems(measureDefine);
	    	List<MeasureUser> reUpdater = measureService.selectMeasureUpdaters(measureDefine);

	    	nJson.put("reMeasure", reMeasure);
	    	nJson.put("reItem", reItem);
	    	nJson.put("reUpdater", reUpdater);

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
    @RequestMapping(value = "/selectMeasureDefineByTid.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectMeasureDefineByTid(HttpServletRequest request, HttpServletResponse response,   @RequestParam HashMap<String, Object> param )  {
    	JSONObject nJson = new JSONObject();
    	try{

    		Map<String, Object> treescore = measureService.selectMeasureId(param);

    		MeasureDefine measureDefine = new MeasureDefine();
    		measureDefine.setId(String.valueOf(treescore.get("contentid")) );
    		measureDefine.setYear((String)param.get("year"));

	    	MeasureDefine reMeasure = measureService.selectMeasureDefine(measureDefine);

	    	List<Item> reItem = measureService.selectMeasureItems(measureDefine);
	    	List<MeasureUser> reUpdater = measureService.selectMeasureUpdaters(measureDefine);

	    	nJson.put("reMeasure", reMeasure);
	    	nJson.put("reItem", reItem);
	    	nJson.put("reUpdater", reUpdater);

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

    @RequestMapping(value = "/selectMeasureActual.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectMeasureActual(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param )  {
    	JSONObject nJson = new JSONObject();
    	try{

    		MeasureDefine measureDefine = new MeasureDefine();
    		measureDefine.setId((String)param.get("mid"));
    		measureDefine.setYear((String)param.get("year"));

	    	MeasureDefine reMeasure = measureService.selectMeasureDefine(measureDefine);

	    	List<Map<String, Object>> selectMeasureActual = orgScoreService.selectMeasureActual(param);
	    	List<Map<String, Object>> selectItemActual = orgScoreService.selectItemActual(param);

	    	nJson.put("reMeasure", reMeasure);
	    	nJson.put("selectMeasureActual", selectMeasureActual);
	    	nJson.put("selectItemActual", selectItemActual);

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

    @RequestMapping(value = "/selectMeasureActualByTid.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectMeasureActualByTid(HttpServletRequest request, HttpServletResponse response,
			@RequestParam HashMap<String, Object> param )  {
    	JSONObject nJson = new JSONObject();
    	try{


    		Map<String, Object> treescore = measureService.selectMeasureId(param);


    		MeasureDefine measureDefine = new MeasureDefine();
    		measureDefine.setId( String.valueOf(treescore.get("contentid")) );
    		measureDefine.setYear((String)param.get("year"));

	    	MeasureDefine reMeasure = measureService.selectMeasureDefine(measureDefine);


	    	param.put("mid", String.valueOf(treescore.get("contentid")));

	    	List<Map<String, Object>> selectMeasureActual = orgScoreService.selectMeasureActual(param);
	    	List<Map<String, Object>> selectItemActual = orgScoreService.selectItemActual(param);

	    	nJson.put("reMeasure", reMeasure);
	    	nJson.put("selectMeasureActual", selectMeasureActual);
	    	nJson.put("selectItemActual", selectItemActual);

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
