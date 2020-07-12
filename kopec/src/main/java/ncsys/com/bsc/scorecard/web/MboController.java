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
import ncsys.com.bsc.analysis.service.MboPsnScoreService;
import ncsys.com.bsc.scorecard.service.MapScoreService;
import ncsys.com.bsc.scorecard.service.OrgScoreService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/scorecard/perform")
public class MboController {

	@Resource(name = "mboPsnScoreService")
	private MboPsnScoreService mboPsnScoreService;


	@RequestMapping(value = "/mboPsnScore.do")
	public String mboPsnScore(Model model) throws Exception {

		return "ncsys/bsc/scorecard/perform/mboPsnScore.tiles";
	}


	@RequestMapping(value = "/selectTreeRoot.json", method = RequestMethod.POST)
	public ModelAndView selectTreeRoot(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> initCon = mboPsnScoreService.selectInitCon(param);
			if(initCon.size()>0){
				param.put("inSabun", initCon.get(0).get("inSabun"));
				param.put("inSeq", initCon.get(0).get("inSeq"));
				param.put("inRev", initCon.get(0).get("inRev"));

				List<Map<String, Object>> psnRoot = mboPsnScoreService.selectPsnRoot(param);
				mv.addObject("psnRoot", psnRoot);

				mv.addObject("reCode", "SUCCESS");
			} else {
				mv.addObject("reCode", "NOROOT");
			}
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


	@RequestMapping(value = "/selectTreeList.json", method = RequestMethod.POST)
	public ModelAndView selectTreeList(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> psnList = mboPsnScoreService.selectPsnTreeList(param);
			mv.addObject("psnList", psnList);

			mv.addObject("reCode", "SUCCESS");

		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


	@RequestMapping(value = "/selectAccountList.json", method = RequestMethod.POST)
	public ModelAndView selectAccountList(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> accountList = mboPsnScoreService.selectAccoutList(param);
			mv.addObject("accountList", accountList);

			List<Map<String, Object>> accountDetail = mboPsnScoreService.selectAccoutDetail(param);
			mv.addObject("accountDetail", accountDetail);

			mv.addObject("reCode", "SUCCESS");

		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}




	@RequestMapping(value = "/mboTargetScore.do")
	public String mboTargetScore(Model model) throws Exception {

		return "ncsys/bsc/scorecard/perform/mboTargetScore.tiles";
	}


	@RequestMapping(value = "/selectTargetTreeRoot.json", method = RequestMethod.POST)
	public ModelAndView selectTargetTreeRoot(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {
			List<Map<String, Object>> initCon = mboPsnScoreService.selectInitCon(param);
			if(initCon.size()>0){
				param.put("inSabun", initCon.get(0).get("inSabun"));
				param.put("inSeq", initCon.get(0).get("inSeq"));
				param.put("inRev", initCon.get(0).get("inRev"));

				List<Map<String, Object>> targetRoot = mboPsnScoreService.selectTargetRoot(param);
				mv.addObject("root", targetRoot);

				mv.addObject("reCode", "SUCCESS");
			} else {
				mv.addObject("reCode", "NOROOT");
			}
		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


	@RequestMapping(value = "/selectTargetTreeList.json", method = RequestMethod.POST)
	public ModelAndView selectTargetTreeList(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> targetList = mboPsnScoreService.selectTargetList(param);
			mv.addObject("targetList", targetList);

			mv.addObject("reCode", "SUCCESS");

		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}

	@RequestMapping(value = "/selectTargetDetail.json", method = RequestMethod.POST)
	public ModelAndView selectTargetDetail(@RequestParam HashMap<String, Object> param) {
		ModelAndView mv = new ModelAndView("jsonView");
		try {

			List<Map<String, Object>> targetDetail = mboPsnScoreService.selectTargetDetail(param);
			mv.addObject("targetDetail", targetDetail);

			mv.addObject("reCode", "SUCCESS");

		} catch (Exception e) {
			System.out.println(e);
			mv.addObject("reCode", "FAILURE");
		}
		return mv;
	}


}
