package tems.com.testBaseManagement.testMethodManagement.service.impl;

import tems.com.testBaseManagement.testMethodManagement.model.TestMethodManagementVO;
import tems.com.testBaseManagement.testMethodManagement.service.TestMethodManagementService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2015-11-18.
 */

@Service("testMethodManagementService")
public class TestMethodManagementServiceImpl implements TestMethodManagementService {

    @Resource(name = "testMethodManagementDAO")
    TestMethodManagementDAO testMethodManagementDAO;

    private static final Logger LOGGER = LoggerFactory.getLogger(TestMethodManagementServiceImpl.class);

    @Override
    public List selectTestMethodList() throws Exception {
        List list = testMethodManagementDAO.selectTestMethodList();
        return list;
    }

    @Override
    public void saveTestMethodItems(List<TestMethodManagementVO> tMMVOList) throws Exception {
        for (TestMethodManagementVO tmmVO : tMMVOList) {
            if (tmmVO.getState().equals("updated")) {
                testMethodManagementDAO.updateTestMethodItems(tmmVO);
            } else if (tmmVO.getState().equals("created")) {
                testMethodManagementDAO.insertTestMethodItems(tmmVO);
            }
        }
    }

    @Override
    public List searchTestItems(TestMethodManagementVO testMethodManagementVO) throws Exception {
        List list = testMethodManagementDAO.searchTestItems(testMethodManagementVO);
        return list;
    }


}
