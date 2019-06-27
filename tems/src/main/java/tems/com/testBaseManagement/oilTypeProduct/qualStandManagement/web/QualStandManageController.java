package tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.web;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import tems.com.common.StringUtils;
import tems.com.login.model.LoginUserVO;
import tems.com.system.model.OfficeUserListVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeSecondVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeThirdVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.service.OilTypeProductService;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualInsertVO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualPopVO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualStandCrossListVO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualStandListVO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.service.QualStandManageService;
import tems.com.testBaseManagement.testMethodManagement.model.TestMethodManagementVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.lang.reflect.Array;
import java.util.*;


/**
 * Created by owner1120 on 2015-12-11.
 */

@Controller
public class QualStandManageController {

    @Resource(name = "QualStandManageService")
    private QualStandManageService QualStandManageService;

    @Resource
    private OilTypeProductService oilTypeProductService;

    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/goPage.do", method = RequestMethod.GET)
    public String goPage(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

/*
        List list = QualStandManageService.firstSelectList();
        List list2 = QualStandManageService.secondSelectList();
        List list3 = QualStandManageService.thirdSelectList();
*/



        return "tems/com/testBaseManagement/oilTypeProductManagement/QualStandManagement";
    }


    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/getSelectListWithJson.json", method = RequestMethod.POST)
    @ResponseBody
    public Map getSelectListWithJson(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        List list = QualStandManageService.firstSelectList();
        List list2 = QualStandManageService.secondSelectList();
        List list3 = QualStandManageService.thirdSelectList();

        Map<String, Object> map = new HashMap<String, Object>();

        map.put("list", list);
        map.put("list2", list2);
        map.put("list3", list3);

        return map;
    }


    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/selQualStandList.json")
    public String selOfficeList(@RequestParam String data,
                                HttpServletRequest req,
                                HttpServletResponse res
    ) throws Exception {


        String masterid = data;

        List<QualStandListVO> UserInfoList = QualStandManageService.getQualStandList(masterid);

        LinkedHashMap<String, QualStandCrossListVO> leftMap = new LinkedHashMap<String, QualStandCrossListVO>();
        LinkedHashMap<String, String> crossField = new LinkedHashMap<String, String>();

        for (int i = 0; i < UserInfoList.size(); i++) {
            QualStandListVO vo = (QualStandListVO) UserInfoList.get(i);

            QualStandCrossListVO leftVO = leftMap.get(vo.getMtitemid());
            if (leftVO == null) {
                leftVO = new QualStandCrossListVO();

                leftVO.setMtitemid(vo.getMtitemid());
                leftVO.setName(vo.getName());
                leftVO.setUnitid(vo.getUnitid());
                leftVO.setDisplaytype(vo.getDisplaytype());
                leftVO.setMethodname(vo.getMethodname());

                leftMap.put(vo.getMtitemid(), leftVO);
            }

            crossField.put(vo.getSpecid(), vo.getSpecnm());

            //leftVO.crossTap.put(vo.getAnalysis_name(), vo.getTestresult());
            leftVO.crossTap.put(vo.getSpecid(), vo.getSpec());
        }

        req.setAttribute("leftMap", leftMap);
        req.setAttribute("crossField", crossField);
        return "non/com/testBaseManagement/oilTypeProductManagement/QualStandList";
    }


    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/edtQualStand.json", method = RequestMethod.POST)
    public void edtOfficeUser(
            QualStandListVO qualStandListVO,
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception {

        LoginUserVO user = (LoginUserVO) req.getSession().getAttribute("loginUserVO");

        JSONObject nJson = new JSONObject();
        String data = StringUtils.nvl(req.getParameter("data"), "");
        JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));

        try {
            for (int i = 0; i < jarray.size(); i++) {
                QualStandListVO vo = (QualStandListVO) JSONObject.toBean(jarray.getJSONObject(i), QualStandListVO.class);
                vo.setModifyid(user.getAdminid());
                QualStandManageService.upQualStand(vo);
                nJson.put("RESULT_YN", "Y");
                nJson.put("RESULT_MESSAGE", "");
            }
        } catch (Exception e) {
            nJson.put("RESULT_YN", "N");
            nJson.put("RESULT_MESSAGE", e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }

    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/qualAddPopUp.do", method = RequestMethod.GET)
    public String elePopUp(Model model) throws Exception {


        return "pop/com/testBaseManagement/oilTypeProductManagement/popup/QualAddPopUp";
    }

    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/selFirstOption.json", method = RequestMethod.POST)
    @ResponseBody
    public List selFirstOption(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        List list = oilTypeProductService.selectOilTypeProductList();

        return list;
    }

    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/selSecondOption.json", method = RequestMethod.POST)
    @ResponseBody
    public List selSecondOption(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        OilTypeSecondVO vo = new OilTypeSecondVO();
        vo.setClassID(data);

        List list = oilTypeProductService.selectSecondList(vo);

        return list;
    }

    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/selThirdOption.json", method = RequestMethod.POST)
    @ResponseBody
    public List selThirdOption(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        OilTypeThirdVO vo = new OilTypeThirdVO();
        vo.setGroupID(data);

        List list = oilTypeProductService.selectThirdList(vo);

        return list;
    }

    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/search.json", method = RequestMethod.POST)
    @ResponseBody
    public String search(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {


        String masterid = data;

        List<QualStandListVO> UserInfoList = QualStandManageService.getQualStandList(masterid);

        LinkedHashMap<String, QualStandCrossListVO> leftMap = new LinkedHashMap<String, QualStandCrossListVO>();
        LinkedHashMap<String, String> crossField = new LinkedHashMap<String, String>();

        for (int i = 0; i < UserInfoList.size(); i++) {
            QualStandListVO vo = (QualStandListVO) UserInfoList.get(i);

            QualStandCrossListVO leftVO = leftMap.get(vo.getMtitemid());
            if (leftVO == null) {
                leftVO = new QualStandCrossListVO();

                leftVO.setMtitemid(vo.getMtitemid());
                leftVO.setName(vo.getName());
                leftVO.setUnitid(vo.getUnitid());
                leftVO.setDisplaytype(vo.getDisplaytype());
                leftVO.setMethodname(vo.getMethodname());

                leftMap.put(vo.getMtitemid(), leftVO);
            }

            crossField.put(vo.getSpecid(), vo.getSpecnm());

            //leftVO.crossTap.put(vo.getAnalysis_name(), vo.getTestresult());
            leftVO.crossTap.put(vo.getSpecid(), vo.getSpec());


        }
        req.setAttribute("leftMap", leftMap);
        req.setAttribute("crossField", crossField);
        return "non/com/testBaseManagement/oilTypeProductManagement/QualStandList";

    }


    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/addAjax.json", method = RequestMethod.POST)
    @ResponseBody
    public String addAjax(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {


        JSONObject json = JSONObject.fromObject(JSONSerializer.toJSON(data));

        QualInsertVO vo = (QualInsertVO) JSONObject.toBean(json, QualInsertVO.class);

        QualStandManageService.insertQualStandList(vo);

        return null;
    }


    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/loadPopUpList.json", method = RequestMethod.POST)
    @ResponseBody
    public List loadPopUp(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        List list = QualStandManageService.selectStandPopList(data);

        return list;
    }

    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/saveData.json", method = RequestMethod.POST)
    public
    @ResponseBody
    List saveData(@RequestParam("data") String data, HttpServletRequest request) throws Exception {


        data = data.replaceAll("&quot;", "\"");

        List<QualPopVO> modifiedList = new ArrayList<QualPopVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            QualPopVO co = (QualPopVO) JSONObject.toBean(cusJson.getJSONObject(i), QualPopVO.class);
            modifiedList.add(co);
        }

        QualStandManageService.saveStandPopList(modifiedList);

        return null;

    }

    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/deletePopUp.json", method = RequestMethod.POST)
    @ResponseBody
    public String deletePopUp(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        String message = "";
        data = data.replaceAll("&quot;", "\"");

        List<QualPopVO> modifiedList = new ArrayList<QualPopVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            QualPopVO co = (QualPopVO) JSONObject.toBean(cusJson.getJSONObject(i), QualPopVO.class);
            modifiedList.add(co);
        }
        try {
            QualStandManageService.deletePopUp(modifiedList);
            message = "성공적으로 삭제 되었습니다.";
        } catch (Exception e) {
            message = "삭제가 옳바르게 실행되지 않았습니다. 다시 시도해 주세요.";
        }
        return message;
    }

    @RequestMapping(value = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/iframe.do", method = RequestMethod.GET)
    public String iframe(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        return "non/com/testBaseManagement/oilTypeProductManagement/iframe/iframe";
    }


}
