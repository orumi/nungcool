package tems.com.testBaseManagement.testItemManagement.genReqTestProp.web;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import tems.com.testBaseManagement.Common.Common;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.service.GenReqService;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.AdminVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.ReqPropVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.SearchVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.service.GenReqPropService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;


/**
 * Created by owner1120 on 2015-12-08.
 */
@Controller
public class GenReqPropController {


    @Resource
    GenReqPropService genReqPropService;
    @Resource
    GenReqService genReqService;

    @RequestMapping(value = "/com/testBaseManageMent/testItemManagement/genReqTestProp/goPage.do", method = RequestMethod.GET)
    public String goProductManageList(ModelMap model, HttpServletRequest request) throws Exception {

        Common common = new Common();

        common.getDetail(genReqService, request, "18");
        common.getGroup(genReqPropService, request);

        return "tems/com/testBaseManagement/testItemManagement/GenReqTestProp";

    }

    @RequestMapping(value = "/com/testBaseManageMent/testItemManagement/genReqTestProp/load.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List<ReqPropVO> loadData(@RequestParam String data) throws Exception {


        List list = genReqPropService.selectGenReqPropServiceList();

        return list;

    }

    @RequestMapping(value = "/com/testBaseManageMent/testItemManagement/genReqTestProp/loadAdmin.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List<ReqPropVO> loadAdmin(@RequestParam String data) throws Exception {

        AdminVO vo = new AdminVO();

        vo.setOfficeID(data);

        List list = genReqPropService.selectAdminList(vo);

        return list;
    }

    @RequestMapping(value = "/com/testBaseManageMent/testItemManagement/genReqTestProp/loadGroup.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List<ReqPropVO> loadGroup(@RequestParam String data) throws Exception {

        List list = genReqPropService.selectGroupList();

        return list;
    }


    @RequestMapping(value = "/com/testBaseManageMent/testItemManagement/genReqTestProp/saveData.do", method = RequestMethod.POST)
    public
    @ResponseBody
    String saveData(@RequestParam String data) throws Exception {

        String message = "";
        data = data.replaceAll("&quot;", "\"");

        List<ReqPropVO> modifiedList = new ArrayList<ReqPropVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            ReqPropVO vo = (ReqPropVO) JSONObject.toBean(cusJson.getJSONObject(i), ReqPropVO.class);

            modifiedList.add(vo);
        }
        try {
            genReqPropService.saveGenReqPropServiceList(modifiedList);
            message = "성공적으로 완료 되었습니다.";
        } catch (Exception e) {
            message = "실패 하였습니다 다시 시도하여 주세요.";
        }

        return message;

    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/genReqTestProp/deleteData.do", method = RequestMethod.POST)
    @ResponseBody
    public String deleteData(@RequestParam String data) throws Exception {

        String message = "";

        data = data.replaceAll("&quot;", "\"");
        JSONObject jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(data));

        ReqPropVO reqPropVO = new ReqPropVO();
        reqPropVO.setItemID(jsonObject.get("itemID").toString());
        reqPropVO.setItemPID(jsonObject.get("itemPID").toString());
        reqPropVO.setMethodID(jsonObject.get("methodID").toString());

        try {
            genReqPropService.deleteGenReqPropServiceList(reqPropVO);
            message = "성공 하였습니다.";
        } catch (Exception e) {
            message = "실패 하였습니다.";
        }
        return message;
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/genReqTestProp/propPopUp.do", method = RequestMethod.GET)
    public String popUp(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

        return "pop/com/testBaseManagement/testItemManagement/popup/PropPopUp";
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/genReqTestProp/addAdminPopUp.do", method = RequestMethod.GET)
    public String addAdminPopUp(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

        return "pop/com/testBaseManagement/testItemManagement/popup/addAdminPopUp";
    }

    @RequestMapping(value = "/com/testBaseManageMent/testItemManagement/genReqTestProp/searchData.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List<ReqPropVO> searchData(@RequestParam String data) throws Exception {


        data = data.replaceAll("&quot;", "\"");
        System.out.println(data);

        JSONObject json = JSONObject.fromObject(JSONSerializer.toJSON(data));
        SearchVO vo = (SearchVO) JSONObject.toBean(json, SearchVO.class);


        List list = genReqPropService.searchData(vo);


         return list ;
    }

    @RequestMapping(value = "/com/testBaseManageMent/testItemManagement/genReqTestProp/savePopData.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List<AdminVO> savePopData(@RequestParam String data) throws Exception {


        data = data.replaceAll("&quot;", "\"");
        System.out.println(data);

        List<AdminVO> modifiedList = new ArrayList<AdminVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            AdminVO vo = (AdminVO) JSONObject.toBean(cusJson.getJSONObject(i), AdminVO.class);

            modifiedList.add(vo);
        }

        genReqPropService.inserAdmins(modifiedList);

        return modifiedList;
    }

    @RequestMapping(value = "/com/testBaseManageMent/testItemManagement/genReqTestProp/loadRight.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List<ReqPropVO> loadRight(@RequestParam String data) throws Exception {


        data = data.replaceAll("&quot;", "\"");

        JSONObject json = JSONObject.fromObject(JSONSerializer.toJSON(data));
        // data = String 값이다.

        AdminVO vo = (AdminVO) JSONObject.toBean(json, AdminVO.class);


        List list = genReqPropService.selectPopUpRight(vo);

        return list;
    }

    @RequestMapping(value = "/com/testBaseManageMent/testItemManagement/genReqTestProp/deleteAdmins.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List<AdminVO> deleteAdmins(@RequestParam String data) throws Exception {


        data = data.replaceAll("&quot;", "\"");
        System.out.println(data);

        List<AdminVO> modifiedList = new ArrayList<AdminVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            AdminVO vo = (AdminVO) JSONObject.toBean(cusJson.getJSONObject(i), AdminVO.class);

            modifiedList.add(vo);
        }

        genReqPropService.deleteAdmins(modifiedList);


        return modifiedList;
    }


}
