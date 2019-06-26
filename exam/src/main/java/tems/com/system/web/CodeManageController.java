package tems.com.system.web;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import tems.com.system.model.CodeDetailVO;
import tems.com.system.model.CodeGroupVO;
import tems.com.system.service.CommonCodeService;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualPopVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by owner1120 on 2015-12-30.
 */

@Controller
public class CodeManageController {

    @Resource
    CommonCodeService commonCodeService;

    @RequestMapping(value = "/system/codeManage/goPage.do", method = RequestMethod.GET)
    public String goPage(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        return "tems/com/system/CommonCodeManage";
    }

    @RequestMapping(value = "/system/codeManage/loadDataLeft.json", method = RequestMethod.POST)
    @ResponseBody
    public List loadDataLeft(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        List list = commonCodeService.getCodeGroupList();

        return list;
    }

    @RequestMapping(value = "/system/codeManage/loadDataRight.json", method = RequestMethod.POST)
    @ResponseBody
    public List loadDataRight(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        List list = commonCodeService.getCodeGroupList2(data);

        return list;
    }


    @RequestMapping(value = "/system/codeManage/saveData.json", method = RequestMethod.POST)
    @ResponseBody
    public String saveData(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        data = data.replaceAll("&quot;", "\"");

        List<CodeGroupVO> modifiedList = new ArrayList<CodeGroupVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            CodeGroupVO co = (CodeGroupVO) JSONObject.toBean(cusJson.getJSONObject(i), CodeGroupVO.class);
            modifiedList.add(co);
        }

        commonCodeService.saveCodeGroupList(modifiedList);

        return "성공적으로 완료 되었습니다.";
    }

    @RequestMapping(value = "/system/codeManage/saveDataRight.json", method = RequestMethod.POST)
    @ResponseBody
    public String saveDataRight(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        data = data.replaceAll("&quot;", "\"");

        List<CodeDetailVO> modifiedList = new ArrayList<CodeDetailVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            CodeDetailVO co = (CodeDetailVO) JSONObject.toBean(cusJson.getJSONObject(i), CodeDetailVO.class);
            modifiedList.add(co);
        }

        commonCodeService.saveCodeGroupList2(modifiedList);

        return "성공적으로 완료 되었습니다.";
    }

    @RequestMapping(value = "/system/codeManage/deleteData.json", method = RequestMethod.POST)
    @ResponseBody
    public String deleteData(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        data = data.replaceAll("&quot;", "\"");

        List<CodeGroupVO> modifiedList = new ArrayList<CodeGroupVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            CodeGroupVO co = (CodeGroupVO) JSONObject.toBean(cusJson.getJSONObject(i), CodeGroupVO.class);
            modifiedList.add(co);
        }

        commonCodeService.deleteCodeGroupList(modifiedList);

        return "성공적으로 완료 되었습니다.";
    }

    @RequestMapping(value = "/system/codeManage/deleteDataRight.json", method = RequestMethod.POST)
    @ResponseBody
    public String deleteData2(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        data = data.replaceAll("&quot;", "\"");

        List<CodeDetailVO> modifiedList = new ArrayList<CodeDetailVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            CodeDetailVO co = (CodeDetailVO) JSONObject.toBean(cusJson.getJSONObject(i), CodeDetailVO.class);
            modifiedList.add(co);
        }

        commonCodeService.deleteCodeGroupList2(modifiedList);

        return "성공적으로 완료 되었습니다.";
    }

}

