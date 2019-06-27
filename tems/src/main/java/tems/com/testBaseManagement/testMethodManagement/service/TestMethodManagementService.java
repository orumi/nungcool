package tems.com.testBaseManagement.testMethodManagement.service;

import tems.com.testBaseManagement.testMethodManagement.model.TestMethodManagementVO;

import java.util.List;

/**
 * Created by Administrator on 2015-11-18.
 */

public interface TestMethodManagementService {

     List selectTestMethodList() throws Exception;

     void saveTestMethodItems(List<TestMethodManagementVO> tMMVOList) throws Exception;

     List searchTestItems(TestMethodManagementVO testMethodManagementVO) throws Exception;

}
