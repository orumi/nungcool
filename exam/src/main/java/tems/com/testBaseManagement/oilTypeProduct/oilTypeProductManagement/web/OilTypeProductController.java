package tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.web;

import org.apache.commons.lang.StringUtils;
import tems.com.common.MenuAuthCheck;
import tems.com.login.model.LoginUserVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeProductVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeSecondVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeThirdVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.service.OilTypeProductService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015-11-23.
 */
@Controller
public class OilTypeProductController {

    @Resource
    OilTypeProductService oilTypeProductService;

    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/goPage.do", method = RequestMethod.GET)
    public String goProductManageList(ModelMap model, HttpServletRequest req) throws Exception {


        /*
        if (req.getParameter("req_menuNo") != null) {
            req.getSession().setAttribute("menuId", req.getParameter("req_menuNo"));
        }

        LoginUserVO nLoginVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");

        if (nLoginVO != null) {
            if (!MenuAuthCheck.AuthCheck(req)) {
                model.addAttribute("resultMsg", "메뉴 사용권한이 없습니다..");
                return "forward:/login/userLogout.do";
            }
        } else {
            model.addAttribute("resultMsg", "사용자 정보가 없습니다.");
            return "forward:/login/userLogout.do";
        }
        */

        return "tems/com/testBaseManagement/oilTypeProductManagement/OilTypeProductManagement";

    }

    @RequestMapping(value = "/com/testBaseManagement/oilTypeProductManagement/select.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List retrieveProductManageList(Model model)
            throws Exception {

        List list = oilTypeProductService.selectOilTypeProductList();

        return list;

    }

    @RequestMapping(value = "/com/testBaseManagement/oilTypeProductManagement/saveData.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List saveDataToDatabase(@RequestParam("data") String data) throws Exception {

        data = data.replaceAll("&quot;", "\"");

        List<OilTypeProductVO> modifiedList = new ArrayList<OilTypeProductVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data)); // 문자열을 JSON으로 변환

        for (int i = 0; i < cusJson.size(); i++) {
            OilTypeProductVO co = (OilTypeProductVO) JSONObject.toBean(cusJson.getJSONObject(i), OilTypeProductVO.class); //JSON을 DTO로 전환
            modifiedList.add(co);
        }

        oilTypeProductService.saveOilTypeProductList(modifiedList);

        return null;

    }

    @RequestMapping(value = "/com/testBaseManagement/oilTypeProductManagement/saveData2.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List saveDataToDatabase2(@RequestParam("data") String data, HttpServletRequest request) throws Exception {

        data = data.replaceAll("&quot;", "\"");

        List<OilTypeSecondVO> modifiedList = new ArrayList<OilTypeSecondVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            OilTypeSecondVO co = (OilTypeSecondVO) JSONObject.toBean(cusJson.getJSONObject(i), OilTypeSecondVO.class);
            modifiedList.add(co);
        }
        oilTypeProductService.saveOilTypeSecondList(modifiedList);
        return null;
    }

    @RequestMapping(value = "/com/testBaseManagement/oilTypeProductManagement/saveData3.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List saveDataToDatabase3(@RequestParam("data") String data, HttpServletRequest request) throws Exception {

        data = data.replaceAll("&quot;", "\"");

        List<OilTypeThirdVO> modifiedList = new ArrayList<OilTypeThirdVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            OilTypeThirdVO co = (OilTypeThirdVO) JSONObject.toBean(cusJson.getJSONObject(i), OilTypeThirdVO.class);
            modifiedList.add(co);
        }

        oilTypeProductService.saveOilTypeThirdList(modifiedList);
        return null;
    }


    @RequestMapping(value = "/com/testBaseManagement/oilTypeProductManagement/loadData2.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List loadData2(@RequestParam("data") String data, HttpServletRequest request) throws Exception {

        data = data.replaceAll("&quot;", "\"");
        JSONObject cusJson = JSONObject.fromObject(JSONSerializer.toJSON(data));
        String classID = cusJson.getString("classID");
        OilTypeSecondVO secondVO = new OilTypeSecondVO();
        secondVO.setClassID(classID);

        List list = oilTypeProductService.selectSecondList(secondVO);
        return list;
    }

    @RequestMapping(value = "/com/testBaseManagement/oilTypeProductManagement/loadData3.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List loadData3(@RequestParam("data") String data, HttpServletRequest request) throws Exception {


        data = data.replaceAll("&quot;", "\"");
        JSONObject cusJson = JSONObject.fromObject(JSONSerializer.toJSON(data));
        String groupID = cusJson.getString("groupID");
        OilTypeThirdVO thirdVO = new OilTypeThirdVO();
        thirdVO.setGroupID(groupID);

        return oilTypeProductService.selectThirdList(thirdVO);
    }




}
