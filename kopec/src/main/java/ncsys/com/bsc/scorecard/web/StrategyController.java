package ncsys.com.bsc.scorecard.web;

import java.io.PrintWriter;
import java.util.ArrayList;
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

import com.nc.xml.Icon;
import com.nc.xml.MapUtil;

import ncsys.com.bsc.admin.service.MeasureService;
import ncsys.com.bsc.admin.service.OrganizationService;
import ncsys.com.bsc.scorecard.service.MapScoreService;
import ncsys.com.bsc.scorecard.service.OrgScoreService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/scorecard/strategy")
public class StrategyController {

	@Resource(name = "orgScoreService")
	private OrgScoreService orgScoreService;

	@Resource(name = "mapScoreService")
	private MapScoreService mapScoreService;

	@Resource(name="MeasureService")
	private  MeasureService measureService;

	@Resource(name="OrganizationService")
	private  OrganizationService organizationService;


	@RequestMapping(value = "/org.do")
	public String org(Model model) throws Exception {

		List<Map<String, Object>> config = orgScoreService.selectConfig();
		model.addAttribute("config", config);

		return "ncsys/bsc/scorecard/strategy/org.tiles";
	}



    @RequestMapping(value = "/selectMaps.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectMaps(HttpServletRequest request, HttpServletResponse response,  String year )  {
    	try{

	    	JSONObject nJson = new JSONObject();

	    	List<ncsys.com.bsc.admin.service.model.Map> maps = organizationService.selectMap(year);

	    	nJson.put("maps", maps);

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}

    @RequestMapping(value = "/selectIconScore.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectIconScore(HttpServletRequest request, HttpServletResponse response,
			String year, String month )  {

    	try{

	    	JSONObject nJson = new JSONObject();

	    	MapUtil util = new MapUtil();
	    	util.getMapIconScore(request, response);


	    	ArrayList<Icon> iconList = (ArrayList)request.getAttribute("iconList");

	    	JSONArray jA = new JSONArray();

	    	for(Icon icon: iconList){
	    		JSONObject jIcon = new JSONObject();
	    		jIcon.put("id", icon.id);
	    		jIcon.put("mapId", icon.mapId);
	    		jIcon.put("iconstyle", icon.style);
	    		jIcon.put("text", icon.text);
	    		jIcon.put("x", icon.x);
	    		jIcon.put("y", icon.y);
	    		jIcon.put("width", icon.width);
	    		jIcon.put("height", icon.height);
	    		jIcon.put("treeId", icon.treeId);
	    		jIcon.put("treeLevel", icon.treeLevel);
	    		jIcon.put("showText", icon.showText);
	    		jIcon.put("showScore", icon.showScore);
	    		jIcon.put("score", icon.score);

	    		jIcon.put("fixed", "Y");

	    		jA.add(jIcon);
	    	}

	    	nJson.put("icon", jA);

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}










	@RequestMapping(value = "/map.do")
	public String map(Model model) throws Exception {

		List<Map<String, Object>> config = orgScoreService.selectConfig();
		model.addAttribute("config", config);


		if(config.size()>0){
			String year = (String)config.get(0).get("showyear");
			HashMap<String, Object> map = new HashMap<>();

			map.put("year",year);

			List<Map<String, Object>> sbuBsc = orgScoreService.selectSbuBsc(map);

			model.addAttribute("sbuBsc", sbuBsc);
		}

		return "ncsys/bsc/scorecard/strategy/map.tiles";
	}


	@RequestMapping(value = "/selectStrategy.json", method = RequestMethod.POST)
	public ModelAndView selectStrategy(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> selectStrategicMap = mapScoreService.selectStrategicMap(param);
			mv.addObject("selectStrategicMap", selectStrategicMap);

			mv.addObject("reCode", "SUCCESS");
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

}
