package tems.com.testBaseManagement.testItemManagement.genReqTestProp.service.impl;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.GenReqVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.PopUpVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.AdminVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.GroupVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.ReqPropVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.SearchVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.service.GenReqPropService;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by owner1120 on 2015-12-08.
 */
@Service
class GenReqPropServiceImpl implements GenReqPropService {

    @Resource
    GenReqPropServiceDAO genReqPropServiceDAO;

    @Override
    public List selectGenReqPropServiceList() throws Exception {
        List list = genReqPropServiceDAO.selectGenReqPropServiceList();
        return list;
    }

    @Override
    public void saveGenReqPropServiceList(List<ReqPropVO> list) throws Exception {
        for (ReqPropVO vo : list) {
            if (vo.getState().equals("updated")) {
                genReqPropServiceDAO.updateGenReqPropServiceDAO(vo);
            } else if (vo.getState().equals("created")) {
                genReqPropServiceDAO.insertGenReqPropServiceDAO(vo);
            } else if (vo.getState().equals("deleted")) {
                genReqPropServiceDAO.deleteGenReqPropServiceDAO(vo);
            }
        }
    }

    @Override
    public void deleteGenReqPropServiceList(ReqPropVO reqPropVO) throws Exception {
        genReqPropServiceDAO.deleteGenReqPropServiceDAO(reqPropVO);
    }

    @Override
    public List selectAdminList(AdminVO vo) throws Exception {
        return genReqPropServiceDAO.selectAdminList(vo);
    }

    @Override
    public List selectGroupList() throws Exception {
        return genReqPropServiceDAO.selectGroupList();
    }

    @Override
    public List selectPopUpRight(AdminVO vo) throws Exception {

        List list = genReqPropServiceDAO.selectPopUpRight(vo);

        return list;
    }

    @Override
    public void inserAdmins(List<AdminVO> list) throws Exception {

        for (AdminVO vo : list) {
            try {
                genReqPropServiceDAO.insertAdmins(vo);
            } catch (Exception e) {
                System.out.println(vo + " 값이 이미 값이 존재 합니다.");
            }
        }
    }

    @Override
    public void deleteAdmins(List<AdminVO> list) throws Exception {

        for (AdminVO vo : list) {
            try {
                genReqPropServiceDAO.deleteAdmins(vo);
            } catch (Exception e) {
                System.out.println(vo + " 삭제에 실패 하였습니다.");
            }
        }
    }

    @Override
    public List searchData(SearchVO vo) throws Exception {
        return genReqPropServiceDAO.searchData(vo);
    }
}
