package tems.com.testSample.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import tems.com.testSample.model.TestItemDefaultVO;
import tems.com.testSample.model.TestItemVO;
import tems.com.testSample.service.TestItemService;
import tems.com.testSample.service.impl.TestItemDAO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * @Class Name : TestItemServiceImpl.java
 * @Description : TestItem Business Implement class
 * @Modification Information
 *
 * @author test
 * @since 1
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("testItemService")
public class TestItemServiceImpl extends EgovAbstractServiceImpl implements
        TestItemService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(TestItemServiceImpl.class);

    @Resource(name="testItemDAO")
    private TestItemDAO testItemDAO;
    
    /** ID Generation */
    //@Resource(name="{egovTestItemIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * TEST_ITEM을 등록한다.
	 * @param vo - 등록할 정보가 담긴 TestItemVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertTestItem(TestItemVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	testItemDAO.insertTestItem(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * TEST_ITEM을 수정한다.
	 * @param vo - 수정할 정보가 담긴 TestItemVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateTestItem(TestItemVO vo) throws Exception {
        testItemDAO.updateTestItem(vo);
    }

    /**
	 * TEST_ITEM을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 TestItemVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteTestItem(TestItemVO vo) throws Exception {
        testItemDAO.deleteTestItem(vo);
    }

    /**
	 * TEST_ITEM을 조회한다.
	 * @param vo - 조회할 정보가 담긴 TestItemVO
	 * @return 조회한 TEST_ITEM
	 * @exception Exception
	 */
    public TestItemVO selectTestItem(TestItemVO vo) throws Exception {
        TestItemVO resultVO = testItemDAO.selectTestItem(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * TEST_ITEM 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return TEST_ITEM 목록
	 * @exception Exception
	 */
    public List<?> selectTestItemList(TestItemDefaultVO searchVO) throws Exception {
        return testItemDAO.selectTestItemList(searchVO);
    }

    /**
	 * TEST_ITEM 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return TEST_ITEM 총 갯수
	 * @exception
	 */
    public int selectTestItemListTotCnt(TestItemDefaultVO searchVO) {
		return testItemDAO.selectTestItemListTotCnt(searchVO);
	}
    
}
