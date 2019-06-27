package tems.com.testBaseManagement.testMethodManagement.web;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import tems.com.testBaseManagement.testMethodManagement.model.TestMethodManagementVO;
import tems.com.testBaseManagement.testMethodManagement.service.TestMethodManagementService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015-11-18.
 */


@Controller
public class TestMethodManagementController {


    @Resource
    TestMethodManagementService testMethodManagementService;

    @RequestMapping(value = "/com/testBaseManagement/testMethodManagement/testMethodList.do", method = RequestMethod.GET)
    public String goProductManageList(ModelMap model, HttpServletRequest req) throws Exception {

        return "tems/com/testBaseManagement/testMethodManagement/TestMethodManagement";

    }

    @RequestMapping(value = "/com/testBaseManagement/testMethodManagement/retrieve.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List retrieveProductManageList()
            throws Exception {

        return testMethodManagementService.selectTestMethodList();

    }

    @RequestMapping(value = "/com/testBaseManagement/testMethodManagement/saveData.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List saveDataToDatabase(@RequestParam("data") String data, HttpServletRequest request) throws Exception {



        data = data.replaceAll("&quot;", "\"");


        List<TestMethodManagementVO> modifiedList = new ArrayList<TestMethodManagementVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            TestMethodManagementVO co = (TestMethodManagementVO) JSONObject.toBean(cusJson.getJSONObject(i), TestMethodManagementVO.class);
            modifiedList.add(co);
        }

        testMethodManagementService.saveTestMethodItems(modifiedList);

        return null;

    }

    @RequestMapping(value = "/com/testBaseManagement/testMethodManagement/searchTestItems.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List searchItemList(@RequestParam("data") String data) throws Exception {


        TestMethodManagementVO vo = new TestMethodManagementVO();
        vo.setName(data);

        return testMethodManagementService.searchTestItems(vo);

    }


}
