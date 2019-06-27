package tems.com.testBaseManagement.testItemManagement.genReqTestProp.service;

import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.GenReqVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.AdminVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.GroupVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.ReqPropVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestProp.model.SearchVO;

import java.util.List;

/**
 * Created by owner1120 on 2015-12-08.
 */
public interface GenReqPropService {

    public List selectGenReqPropServiceList() throws Exception;

    public void saveGenReqPropServiceList(List<ReqPropVO> list) throws Exception;

    public void deleteGenReqPropServiceList(ReqPropVO reqPropVO) throws Exception;

    public List selectAdminList(AdminVO vo) throws Exception;

    public List selectGroupList() throws Exception;

    public List selectPopUpRight(AdminVO vo) throws Exception;

    public void inserAdmins(List<AdminVO> list) throws Exception;

    public void deleteAdmins(List<AdminVO> list) throws Exception;

    public List searchData(SearchVO vo) throws Exception;
}
