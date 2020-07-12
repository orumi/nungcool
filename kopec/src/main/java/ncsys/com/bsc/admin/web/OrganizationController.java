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

import ncsys.com.bsc.admin.service.OrganizationService;
import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.bsc.admin.service.model.Map;
import ncsys.com.bsc.admin.service.model.Mapicon;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/admin/organization")
public class OrganizationController {

	@Resource(name="OrganizationService")
	private  OrganizationService organizationService;


    @RequestMapping(value="/organizationMng.do")
    public String organizationMng() throws Exception {

    	return "ncsys/bsc/admin/organization/organizationMng.tiles";
    }

    @RequestMapping(value="/mapProperties.do")
    public String mapProperties() throws Exception {

    	return "ncsys/bsc/admin/organization/mapProperties.popup";
    }


    @RequestMapping(value = "/selectHierarchy.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectHierarchyJson(HttpServletRequest request, HttpServletResponse response,  String year )  {
    	try{

	    	JSONObject nJson = new JSONObject();

	    	List<HierarchyNode> node = organizationService.selectHierarchy(year);

	    	nJson.put("node", node);


	    	List<Map> maps = organizationService.selectMap(year);

	    	nJson.put("maps", maps);

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}


    @RequestMapping(value = "/selectMapImages.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectMapImages(HttpServletRequest request, HttpServletResponse response)  {
    	try{

	    	JSONObject nJson = new JSONObject();

	    	String[] images = organizationService.selectMapImages();
	    	nJson.put("images", images);

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}


    @RequestMapping(value = "/setMapProperty.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void setMapProperty(HttpServletRequest request, HttpServletResponse response,  @RequestBody String json )  {
    	try{

	    	JSONObject nJson = new JSONObject();

	    	Map map = new ObjectMapper().readValue(json, Map.class);

	    	if("U".equals(map.getActionmode())){
	    		organizationService.updateMap(map);
	    	} else if("C".equals(map.getActionmode())) {
	    		String newId = organizationService.selectNextMapId();
	    		map.setId(newId);
	    		organizationService.insertMap(map);
	    	} else if("D".equals(map.getActionmode())) {
	    		organizationService.deleteMap(map);
	    	}

	    	List<Map> maps = organizationService.selectMap(map.getYear());

	    	nJson.put("maps", maps);
	    	nJson.put("map", map);


	    	nJson.put("reVal", "ok_resend");

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}


    @RequestMapping(value = "/setMapIcons.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void setMapIcons(HttpServletRequest request, HttpServletResponse response,  @RequestBody String json )  {
    	try{

	    	JSONObject nJson = new JSONObject();

	    	Mapicon[] icons = new ObjectMapper().readValue(json, Mapicon[].class);

	    	String mapid = null;

	    	for (int i = 0; i < icons.length; i++) {
	    		Mapicon mapIcon = icons[i];
	    		if(i==0){
	    			organizationService.deleteMapicon(mapIcon);
	    			mapid = mapIcon.getMapid();
	    		}

	    		mapIcon.setId(String.valueOf(i+1));
				organizationService.insertMapicon(mapIcon);
			}


	    	List<Mapicon> icon = organizationService.selectIcon(mapid);

	    	nJson.put("icon", icon);


	    	nJson.put("reVal", "ok_resend");

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}

    @RequestMapping(value = "/selectIcons.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void selectIcons(HttpServletRequest request, HttpServletResponse response,  String mapid )  {
    	try{

	    	JSONObject nJson = new JSONObject();

	    	List<Mapicon> icon = organizationService.selectIcon(mapid);

	    	nJson.put("icon", icon);

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}


    @RequestMapping(value = "/uploadFile.json", method = RequestMethod.POST)
	@ResponseBody
    public void uploadFile(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {

		//LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");

		JSONObject nJson = new JSONObject();
		try{

			/* store */
			//HashMap<String, String> fileMap = EgovFileMngUtil.uploadFile(file,"Globals.ActualFileStorePath");

			//EgovFileMngUtil.uploadMapImageFile(file);

			String[] images = organizationService.selectMapImages();
	    	nJson.put("images", images);

    		nJson.put("reVal", "ok_resend");
	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
