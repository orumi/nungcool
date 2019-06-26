package tems.com.testBaseManagement.Common;

import tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.model.ElePopUpVO;
import tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.service.EleItemService;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.LoadUnitVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.service.GenReqService;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.GroupVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.service.GenReqPropService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by owner1120 on 2015-12-10.
 */
public class Common {


    public void getDetail(GenReqService genReqService, HttpServletRequest request, String num) throws Exception {

        ArrayList<String> CodeNameArr = new ArrayList<String>();
        ArrayList<String> CodeIDArr = new ArrayList<String>();

        List<LoadUnitVO> list = genReqService.selectTestUnitDAO();

        for (LoadUnitVO vo : list) {
            if (vo.getCodeGroupID().equals(num)) {  // num은 키 값이며 TCE_CODE_GROUP에서 num의 상세내용 확인 가능하다.
                CodeNameArr.add("\"" + vo.getCodeName() + "\"");
                CodeIDArr.add("\"" + vo.getCodeID() + "\"");
            }
        }

        request.setAttribute("CodeNameArr", CodeNameArr);
        request.setAttribute("CodeIDArr", CodeIDArr);

    }

    public void getGroup(GenReqPropService genReqPropService, HttpServletRequest request) throws Exception {

        ArrayList<String> nameArr = new ArrayList<String>();
        ArrayList<String> officeIDArr = new ArrayList<String>();

        List<GroupVO> list = genReqPropService.selectGroupList();

        for (GroupVO vo : list) {
                nameArr.add("\"" + vo.getName() + "\"");
                officeIDArr.add("\"" + vo.getOfficeID() + "\"");

        }

        request.setAttribute("nameArr", nameArr);
        request.setAttribute("officeIDArr", officeIDArr);

    }

}
