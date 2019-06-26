package tems.com.testSample.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.testSample.model.TestItemDefaultVO;
import tems.com.testSample.model.TestItemVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : TestItemDAO.java
 * @Description : TestItem DAO Class
 * @Modification Information
 *
 * @author test
 * @since 1
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("testItemDAO")
public class TestItemDAO extends EgovAbstractDAO {

	/**
	 * TEST_ITEM을 등록한다.
	 * @param vo - 등록할 정보가 담긴 TestItemVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertTestItem(TestItemVO vo) throws Exception {
        return (String)insert("testItemDAO.insertTestItem_S", vo);
    }

    /**
	 * TEST_ITEM을 수정한다.
	 * @param vo - 수정할 정보가 담긴 TestItemVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateTestItem(TestItemVO vo) throws Exception {
        update("testItemDAO.updateTestItem_S", vo);
    }

    /**
	 * TEST_ITEM을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 TestItemVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteTestItem(TestItemVO vo) throws Exception {
        delete("testItemDAO.deleteTestItem_S", vo);
    }

    /**
	 * TEST_ITEM을 조회한다.
	 * @param vo - 조회할 정보가 담긴 TestItemVO
	 * @return 조회한 TEST_ITEM
	 * @exception Exception
	 */
    public TestItemVO selectTestItem(TestItemVO vo) throws Exception {
        return (TestItemVO) select("testItemDAO.selectTestItem_S", vo);
    }

    /**
	 * TEST_ITEM 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return TEST_ITEM 목록
	 * @exception Exception
	 */
    public List<?> selectTestItemList(TestItemDefaultVO searchVO) throws Exception {
        return list("testItemDAO.selectTestItemList_D", searchVO);
    }

    /**
	 * TEST_ITEM 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return TEST_ITEM 총 갯수
	 * @exception
	 */
    public int selectTestItemListTotCnt(TestItemDefaultVO searchVO) {
        return (Integer)select("testItemDAO.selectTestItemListTotCnt_S", searchVO);
    }

}
