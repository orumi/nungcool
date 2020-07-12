package ncsys.com.bsc.admin.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import ncsys.com.bsc.admin.service.HierarchyService;
import ncsys.com.bsc.admin.service.OrganizationService;
import ncsys.com.bsc.admin.service.model.Component;
import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.bsc.admin.service.model.HierarchyTree;
import ncsys.com.bsc.admin.service.model.Map;
import ncsys.com.bsc.admin.service.model.Mapicon;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/admin/hierarchy")
public class HierarchyController {

	@Resource(name="HierarchyService")
	private HierarchyService hierarchyService;


    @RequestMapping(value="/hierarchyMng.do")
    public String organizationMng() throws Exception {

    	return "ncsys/bsc/admin/hierarchy/hierarchyMng.tiles";
    }


    @RequestMapping(value = "/selectHierarchy.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectHierarchyJson(HttpServletRequest request, HttpServletResponse response,  String year )  {
    	try{

	    	JSONObject nJson = new JSONObject();

	    	List<HierarchyNode> node = hierarchyService.selectHierarchy(year);

	    	nJson.put("node", node);

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

	    	List<Component> company = hierarchyService.selectCompany();
	    	List<Component> sbu = hierarchyService.selectSBU();
	    	List<Component> bsc = hierarchyService.selectBSC();

	    	nJson.put("company", company);
	    	nJson.put("sbu", sbu);
	    	nJson.put("bsc", bsc);

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}



    @RequestMapping(value = "/adjusttHierarchy.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void adjusttHierarchy(HttpServletRequest request, HttpServletResponse response, String actionmode, @RequestBody String json)  {
    	JSONObject nJson = new JSONObject();

    	try{

    		String reVal = "ok_resend";
	    	HierarchyTree vo = new ObjectMapper().readValue(json, HierarchyTree.class);

	    	if("I".equals(actionmode)){

	    		hierarchyService.adjustHierarchy(vo);

	    	} else if ("U".equals(actionmode)){

	    		hierarchyService.updateHierarchy(vo);

	    	} else if ("D".equals(actionmode)){

	    		int reInt = hierarchyService.deleteHierarchy(vo);
	    		if(reInt == 0){
	    			reVal = "existChild";
	    		}

	    	}

	    	List<HierarchyNode> node = hierarchyService.selectHierarchy(vo.getYear());
	    	nJson.put("node", node);
	    	nJson.put("reVal", reVal);

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    		nJson.put("reVal", "fail_resend");
    	}
	}


}
