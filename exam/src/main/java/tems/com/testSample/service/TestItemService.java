package tems.com.testSample.service;

import java.util.List;

import tems.com.testSample.model.TestItemDefaultVO;
import tems.com.testSample.model.TestItemVO;

/**
 * @Class Name : TestItemService.java
 * @Description : TestItem Business class
 * @Modification Information
 *
 * @author test
 * @since 1
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface TestItemService {
	
	/**
	 * TEST_ITEM을 등록한다.
	 * @param vo - 등록할 정보가 담긴 TestItemVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertTestItem(TestItemVO vo) throws Exception;
    
    /**
	 * TEST_ITEM을 수정한다.
	 * @param vo - 수정할 정보가 담긴 TestItemVO
	 * @return void형
	 * @exception Exception
	 */
    void updateTestItem(TestItemVO vo) throws Exception;
    
    /**
	 * TEST_ITEM을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 TestItemVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteTestItem(TestItemVO vo) throws Exception;
    
    /**
	 * TEST_ITEM을 조회한다.
	 * @param vo - 조회할 정보가 담긴 TestItemVO
	 * @return 조회한 TEST_ITEM
	 * @exception Exception
	 */
    TestItemVO selectTestItem(TestItemVO vo) throws Exception;
    
    /**
	 * TEST_ITEM 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return TEST_ITEM 목록
	 * @exception Exception
	 */
    List selectTestItemList(TestItemDefaultVO searchVO) throws Exception;
    
    /**
	 * TEST_ITEM 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return TEST_ITEM 총 갯수
	 * @exception
	 */
    int selectTestItemListTotCnt(TestItemDefaultVO searchVO);
    
}
