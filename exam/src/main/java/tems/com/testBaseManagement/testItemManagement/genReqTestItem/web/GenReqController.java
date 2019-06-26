package tems.com.testBaseManagement.testItemManagement.genReqTestItem.web;


import org.springframework.ui.Model;
import tems.com.testBaseManagement.Common.Common;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.GenReqVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.LoadUnitVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.PopUpVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.service.GenReqService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015-11-23.
 */
@Controller
public class GenReqController {


    @Resource
    GenReqService genReqService;

    @RequestMapping(value = "/com/testBaseManageMent/testItemManagement/genReqTestItem/goPage.do", method = RequestMethod.GET)
    public String goProductManageList(ModelMap model, HttpServletRequest request) throws Exception {


        Common common = new Common();

        common.getDetail(genReqService, request, "10");

        return "tems/com/testBaseManagement/testItemManagement/GenReqTestItem";

    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/getReqTestItem/loadData.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List<GenReqVO> loadData() throws Exception {

        List list = (List<GenReqVO>) genReqService.selectGenReqServiceList();

        return list;
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/getReqTestItem/searchData.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List searchData(@RequestParam("data") String data) throws Exception {

        GenReqVO genReqVO = new GenReqVO();
        genReqVO.setName(data);

        return genReqService.searchGenReqServiceList(genReqVO);
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/getReqTestItem/saveData.do", method = RequestMethod.POST)
    public
    @ResponseBody
    String saveData(@RequestParam("data") String data) throws Exception {

        String message = "";
        data = data.replaceAll("&quot;", "\"");

        List<GenReqVO> modifiedList = new ArrayList<GenReqVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            GenReqVO co = (GenReqVO) JSONObject.toBean(cusJson.getJSONObject(i), GenReqVO.class);

            modifiedList.add(co);
        }

        try {
            genReqService.saveGenReqServiceList(modifiedList);
            message = "성공적으로 완료 되었습니다.";
        } catch (Exception e) {
            message = "실패 하였습니다 다시 시도하여 주세요.";
        }

        return message;
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/getReqTestItem/deleteData.do", method = RequestMethod.POST)
    public
    @ResponseBody
    String deleteData(@RequestParam("data") String data) throws Exception {


        String message = "";
        data = data.replaceAll("&quot;", "\"");
        JSONObject jsonObject = JSONObject.fromObject(JSONSerializer.toJSON(data));

        GenReqVO genReqVO = new GenReqVO();
        genReqVO.setItemID(jsonObject.get("itemID").toString());

        List list = null;
        try {
            list = genReqService.selectTNEResult(genReqVO);
        } catch (Exception e) {
            System.out.println(e);
            return message = "사용 여부 확인중에 에러가 발생 하였습니다.";
        }
        if (list.size() == 0) {
            genReqService.deleteGenReqServiceDAO(genReqVO);
            message = "삭제 되었습니다.";
        } else if (list.size() > 0) {
            message = "접수 의뢰된 이력이 있어서 삭제 할 수 없습니다.";
        }
        return message;
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/getReqTestItem/popUp.do", method = RequestMethod.GET)
    public String popUp(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

        List<LoadUnitVO> list = genReqService.selectTestUnitDAO();

        ArrayList<String> tempCodeNameArr = new ArrayList<String>();
        ArrayList<String> tempCodeIDArr = new ArrayList<String>();
        ArrayList<String> timeCodeNameArr = new ArrayList<String>();
        ArrayList<String> timeCodeIDArr = new ArrayList<String>();
        ArrayList<String> etcCodeNameArr = new ArrayList<String>();
        ArrayList<String> etcCodeIDArr = new ArrayList<String>();


        for (int i = 0; i < list.size(); i++) {
            LoadUnitVO vo = list.get(i);
            if ( vo.getCodeGroupID().equals("10") ) {
                tempCodeNameArr.add("\""+vo.getCodeName()+"\"");
                tempCodeIDArr.add("\""+vo.getCodeID()+"\"");
            }
            if ( vo.getCodeGroupID().equals("11") ) {
                timeCodeNameArr.add("\""+vo.getCodeName()+"\"");
                timeCodeIDArr.add("\""+vo.getCodeID()+"\"");
            }
            if ( vo.getCodeGroupID().equals("12") ) {
                etcCodeNameArr.add("\""+vo.getCodeName()+"\"");
                etcCodeIDArr.add("\""+vo.getCodeID()+"\"");
            }
        }

        request.setAttribute("tempCodeNameArr",tempCodeNameArr);
        request.setAttribute("tempCodeIDArr",tempCodeIDArr);
        request.setAttribute("timeCodeNameArr",timeCodeNameArr);
        request.setAttribute("timeCodeIDArr",timeCodeIDArr);
        request.setAttribute("etcCodeNameArr",etcCodeNameArr);
        request.setAttribute("etcCodeIDArr",etcCodeIDArr);

        return "pop/com/testBaseManagement/testItemManagement/popup/PopUp";
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/getReqTestItem/popUpLoadData.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List popUpLoadData(@RequestParam("data") String data) throws Exception {

        PopUpVO popUpVO = new PopUpVO();
        popUpVO.setItemID(data);

        List list = genReqService.selectTestCondition(popUpVO);

        return list;
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/getReqTestItem/popUpSaveData.do", method = RequestMethod.POST)
    public
    @ResponseBody
    String popUpSaveData(@RequestParam String data) throws Exception {

        String message = "";
        data = data.replaceAll("&quot;", "\"");

        List<PopUpVO> modifiedList = new ArrayList<PopUpVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {
            PopUpVO co = (PopUpVO) JSONObject.toBean(cusJson.getJSONObject(i), PopUpVO.class);

            modifiedList.add(co);
        }

        try {
            genReqService.saveTestCondition(modifiedList);
            message = "성공적으로 완료 되었습니다.";
        } catch (Exception e) {
            message = "실패 하였습니다 다시 시도하여 주세요.";
        }

        return message;
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/getReqTestItem/loadUnit.do", method = RequestMethod.POST)
    public
    @ResponseBody
    List loadUnit(@RequestParam String data, Model model) throws Exception {

        List list = genReqService.selectTestUnitDAO();

        return list;
    }


}
