package ncsys.com.bsc.admin.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import ncsys.com.bsc.admin.service.MeasureService;
import ncsys.com.bsc.admin.service.model.Component;
import ncsys.com.bsc.admin.service.model.HierarchyTree;
import ncsys.com.bsc.admin.service.model.Item;
import ncsys.com.bsc.admin.service.model.MeasureDefine;
import ncsys.com.bsc.admin.service.model.MeasureList;
import ncsys.com.bsc.admin.service.model.MeasureUser;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/admin/measure")
public class MeasureController {

	@Resource(name="MeasureService")
	private  MeasureService measureService;


    @RequestMapping(value="/measureMng.do")
    public String organizationMng() throws Exception {

    	return "ncsys/bsc/admin/measure/measureMng.tiles";
    }

    @RequestMapping(value="/measureDetail.do")
    public String measureDetail() throws Exception {

    	return "ncsys/bsc/admin/measure/measureDetail.popup";
    }

    @RequestMapping(value="/measureUser.do")
    public String measureUser() throws Exception {

    	return "ncsys/bsc/admin/measure/measureUser.popup";
    }


    @RequestMapping(value = "/selectMeasureList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectMeasureListJson(HttpServletRequest request, HttpServletResponse response,  MeasureList measureList )  {
    	try{

	    	JSONObject nJson = new JSONObject();

	    	List<MeasureList> list = measureService.selectMeasureList(measureList);

	    	nJson.put("list", list);

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}

    @RequestMapping(value = "/selectComponent.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectComponentJson(HttpServletRequest request, HttpServletResponse response)  {
    	try{

	    	JSONObject nJson = new JSONObject();

	    	List<Component> pst = measureService.selectPst();
	    	List<Component> object = measureService.selectObject();
	    	List<Component> measure = measureService.selectMeasure();

	    	nJson.put("pst", pst);
	    	nJson.put("object", object);
	    	nJson.put("measure", measure);

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}


    @RequestMapping(value = "/selectMeasureDefine.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectMeasureDefineJson(HttpServletRequest request, HttpServletResponse response,   @RequestBody String json )  {
    	JSONObject nJson = new JSONObject();
    	try{

    		MeasureDefine measureDefine = new ObjectMapper().readValue(json, MeasureDefine.class);

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


    @RequestMapping(value = "/selectMeasureUser.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectMeasureUser(HttpServletRequest request, HttpServletResponse response)  {
    	try{

	    	JSONObject nJson = new JSONObject();

	    	List<MeasureUser> selectMeasureUser = measureService.selectMeasureUserS();

	    	nJson.put("selectMeasureUser", selectMeasureUser);

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}



    @RequestMapping(value = "/selectMeasureUpdater.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectMeasureUpdater(HttpServletRequest request, HttpServletResponse response,  MeasureDefine measureDefine )  {
    	try{

	    	JSONObject nJson = new JSONObject();

	    	List<MeasureUser> selectMeasureUpdaters = measureService.selectMeasureUpdaters(measureDefine);

	    	nJson.put("selectMeasureUpdaters", selectMeasureUpdaters);

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}





    @RequestMapping(value = "/adjustMeasureDefine.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void adjustMeasureDefineJson(HttpServletRequest request, HttpServletResponse response,  @RequestBody String json )  {

    	JSONObject nJson = new JSONObject();

    	try{
    		MeasureDefine measureDefine = new ObjectMapper().readValue(json, MeasureDefine.class);

	    	int reVal = measureService.adjustMeasure(measureDefine);

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


    @RequestMapping(value = "/deleteMeasureDefine.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void deleteMeasureDefineJson(HttpServletRequest request, HttpServletResponse response,  @RequestBody String json )  {

    	JSONObject nJson = new JSONObject();

    	try{
    		MeasureDefine measureDefine = new ObjectMapper().readValue(json, MeasureDefine.class);

	    	int reVal = measureService.deleteMeasure(measureDefine);

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
