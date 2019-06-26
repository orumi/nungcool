package tems.com.testBaseManagement.testMethodManagement.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import tems.com.testBaseManagement.testMethodManagement.model.TestMethodManagementVO;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2015-11-18.
 */

@Repository("testMethodManagementDAO")
public class TestMethodManagementDAO extends EgovComAbstractDAO {


     public List<?> selectTestMethodList() throws Exception {
          return list("testMethodManagementDAO.selectTestMethodList");
     }

     public void updateTestMethodItems(TestMethodManagementVO testMethodManagementVO) throws Exception {
          update("testMethodManagementDAO.updateTestMethodItems", testMethodManagementVO);
     }

     public void insertTestMethodItems(TestMethodManagementVO testMethodManagementVO) throws Exception {
          insert("testMethodManagementDAO.insertTestMethodItems", testMethodManagementVO);
     }

     public List<?> searchTestItems(TestMethodManagementVO testMethodManagementVO) throws Exception {
          return list("testMethodManagementDAO.searchTestItems", testMethodManagementVO);
     }

}
