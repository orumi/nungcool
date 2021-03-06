package tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.web;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.model.ElePopUpVO;
import tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.model.RightOneVO;
import tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.service.EleItemService;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeSecondVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeThirdVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.service.OilTypeProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.service.GenReqService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015-11-23.
 */
@Controller
public class ElementaryItemController {

    @Resource
    OilTypeProductService oilTypeProductService;
    @Resource
    EleItemService eleItemService;
    @Resource
    GenReqService genReqService;

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/eleItemManage/goPage.do", method = RequestMethod.GET)
    public String goPage(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {


        List list = oilTypeProductService.selectOilTypeProductList();
        model.addAttribute("list", list);

        return "tems/com/testBaseManagement/oilTypeProductManagement/ElementaryItemManagement";
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/eleItemManage/getSecondList.do", method = RequestMethod.POST)
    @ResponseBody
    public List getSecondList(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        OilTypeSecondVO secondVO = new OilTypeSecondVO();
        secondVO.setClassID(data);

        List list = oilTypeProductService.selectSecondList(secondVO);

        return list;
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/eleItemManage/getThirdList.do", method = RequestMethod.POST)
    @ResponseBody
    public List getThirdList(@RequestParam String data, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {

        OilTypeThirdVO thirdVO = new OilTypeThirdVO();
        thirdVO.setGroupID(data);

        List list = oilTypeProductService.selectThirdJoinList(thirdVO);

        return list;
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/eleItemManage/elePopUp.do", method = RequestMethod.GET)
    public String elePopUp(Model model) throws Exception {


        return "pop/com/testBaseManagement/oilTypeProductManagement/popup/ElePopUp";
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/eleItemManage/popUpLoad.do", method = RequestMethod.POST)
    @ResponseBody
    public List popUpLoad(@RequestParam String data, Model model) throws Exception {

        List list = eleItemService.selectEleItemPopUp();

        return list;
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/eleItemManage/loadRightOne.do", method = RequestMethod.POST)
    @ResponseBody
    public List loadRightOne(@RequestParam String data, Model model) throws Exception {

        RightOneVO vo = new RightOneVO();
        vo.setMasterID(data);

        List list = eleItemService.selectRightOne(vo);

        return list;
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/eleItemManage/savePopUp.do", method = RequestMethod.POST)
    @ResponseBody
    public String savePopUp(@RequestParam String data, Model model) throws Exception {

        // 변환시작
        String message = "";

        data = data.replaceAll("\\\\&quot;", "\"");
        data = data.replaceAll("&quot;", "");


        List<ElePopUpVO> modifiedList = new ArrayList<ElePopUpVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for (int i = 0; i < cusJson.size(); i++) {

            ElePopUpVO elePopUpVO = (ElePopUpVO) JSONObject.toBean(cusJson.getJSONObject(i), ElePopUpVO.class);
            elePopUpVO.setResultFlag("Y"); //리절트 플래그는 NOT NULL 디폴트로 Y를 넣어 준다.

            // 중복여부 체크
            List list = eleItemService.duplicateCheck(elePopUpVO);
            if (list.size() >= 1) {

            } else {
                modifiedList.add(elePopUpVO);
            }
        }
        //변환 끝

        //부모 있나 체크 후 부모 없으면 부모 넣고 자식값 넣기

        for (ElePopUpVO vo : modifiedList) {

            List parentsList = eleItemService.getOneFromTCEITEM(vo); // 부모 존재여부 TCE_ITEM에서

            if (parentsList.size() > 0) { // 0보다 크다는건 존재가 있다는 것.
                List checkParentsList = eleItemService.checkParents(vo); // TCE_MASTER_ITEM에 부모님 등록 되어있는지 여부

                if (checkParentsList.size() == 0) { // 있으면 걍 패스 없으면 로직 처리.. 0은 없다는 뜻
                    String masterID = vo.getMasterID();
                    ElePopUpVO parent = (ElePopUpVO) parentsList.get(0);
                    parent.setMasterID(masterID);
                    parent.setResultFlag("Y");
                    eleItemService.insertElePopUP(parent); // 부모 등록
                }
            }
            eleItemService.insertElePopUP(vo); // 이제 자식 추가
        }

        return null;
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/eleItemManage/loadTestMethod.do", method = RequestMethod.POST)
    @ResponseBody
    public List loadTestMethod(@RequestParam String data, Model model) throws Exception {

        RightOneVO vo = new RightOneVO();
        vo.setMasterID(data);

        List list = eleItemService.loadTestMethod(vo);

        return list;
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/eleItemManage/loadTestCondition.do", method = RequestMethod.POST)
    @ResponseBody
    public List loadTestCondition(@RequestParam String data, Model model) throws Exception {

        List list = eleItemService.loadTesTCondtion();

        return list;
    }


    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/eleItemManage/save.do", method = RequestMethod.POST)
    @ResponseBody
    public List saveData(@RequestParam String data, Model model) throws Exception {

        data = data.replaceAll("&quot;", "\"");

        List<RightOneVO> modifiedList = new ArrayList<RightOneVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data)); // 문자열을 JSON으로 변환

        for (int i = 0; i < cusJson.size(); i++) {
            RightOneVO co = (RightOneVO) JSONObject.toBean(cusJson.getJSONObject(i), RightOneVO.class); //JSON을 DTO로 전환
            modifiedList.add(co);
        }

        eleItemService.saveRightOne(modifiedList);

        return null;
    }


    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/eleItemManage/deleteData.do", method = RequestMethod.POST)
    @ResponseBody
    public List deleteData(@RequestParam String data, Model model) throws Exception {


        data = data.replaceAll("&quot;", "\"");

        List<RightOneVO> modifiedList = new ArrayList<RightOneVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data)); // 문자열을 JSON으로 변환

        for (int i = 0; i < cusJson.size(); i++) {
            RightOneVO co = (RightOneVO) JSONObject.toBean(cusJson.getJSONObject(i), RightOneVO.class); //JSON을 DTO로 전환
            modifiedList.add(co);
        }

        eleItemService.deleteRightOne(modifiedList);

        return null;
    }

    @RequestMapping(value = "/com/testBaseManagement/testItemManagement/eleItemManage/loadDataLeft.do", method = RequestMethod.POST)
    @ResponseBody
    public List loadDataLeft(@RequestParam String data, Model model) throws Exception {

        data = data.replaceAll("&quot;", "\"");

        List<RightOneVO> modifiedList = new ArrayList<RightOneVO>();
        JSONArray cusJson = JSONArray.fromObject(JSONSerializer.toJSON(data)); // 문자열을 JSON으로 변환

        for (int i = 0; i < cusJson.size(); i++) {
            RightOneVO co = (RightOneVO) JSONObject.toBean(cusJson.getJSONObject(i), RightOneVO.class); //JSON을 DTO로 전환
            modifiedList.add(co);
        }

        List list = eleItemService.loadDataLeft(modifiedList);

        return list;
    }


}
