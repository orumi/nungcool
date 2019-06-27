package tems.com.testBaseManagement.testItemManagement.genReqTestProp.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.GenReqVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.AdminVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.GroupVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.ReqPropVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.SearchVO;

import java.util.List;

/**
 * Created by owner1120 on 2015-12-08.
 */
@Repository("genReqPropServiceDAO")
public class GenReqPropServiceDAO extends EgovComAbstractDAO {

    public List<?> selectGenReqPropServiceList() throws Exception {
        return list("genReqPropServiceDAO.selectGenReqPropServiceDAO");
    }

    public void insertGenReqPropServiceDAO(ReqPropVO vo) throws Exception {
        insert("genReqPropServiceDAO.insertGenReqPropServiceDAO", vo);
    }

    public void updateGenReqPropServiceDAO(ReqPropVO vo) throws Exception {
        update("genReqPropServiceDAO.updateGenReqPropServiceDAO", vo);
    }

    public void deleteGenReqPropServiceDAO(ReqPropVO vo) throws Exception {
        delete("genReqPropServiceDAO.deleteGenReqPropServiceDAO", vo);
    }

    public List<?> selectAdminList(AdminVO vo) throws Exception {
        return list("genReqPropServiceDAO.selectAdminList", vo);
    }

    public List<?> selectGroupList() throws Exception {
        return list("genReqPropServiceDAO.selectGroupList");
    }

    public List<?> selectSearchList(SearchVO vo) throws Exception {
        return list("genReqPropServiceDAO.selectSearchList", vo);
    }

    public List<?> selectPopUpRight(AdminVO vo) throws Exception {
        return list("genReqPropServiceDAO.selectPopUpRight", vo);
    }

    public void insertAdmins (AdminVO vo) throws Exception {
        insert("genReqPropServiceDAO.insertAdmins", vo);
    }

    public void deleteAdmins (AdminVO vo) throws Exception {
        delete("genReqPropServiceDAO.deleteAdmins",vo);
    }

    public List searchData (SearchVO vo) throws Exception {
        return list("genReqPropServiceDAO.selectSearchList", vo);
    }


}
