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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import ncsys.com.bsc.admin.service.MeasureService;
import ncsys.com.bsc.admin.service.PsnEmpScoreService;
import ncsys.com.bsc.admin.service.ValuateGroupService;
import ncsys.com.bsc.admin.service.model.Item;
import ncsys.com.bsc.admin.service.model.MeasureDefine;
import ncsys.com.bsc.admin.service.model.MeasureUser;
import ncsys.com.bsc.scorecard.service.OrgScoreService;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/scorecard/rank")
public class OrgRankController {

	@Resource(name = "orgScoreService")
	private OrgScoreService orgScoreService;


	@Resource(name = "valuateGroupService")
	private ValuateGroupService valuateGroupService;

	@RequestMapping(value = "/orgRank.do")
	public String appConfig(Model model) throws Exception {

		List<Map<String, Object>> config = orgScoreService.selectConfig();
		model.addAttribute("config", config);

		return "ncsys/bsc/scorecard/strategy/orgRank.tiles";
	}



}
