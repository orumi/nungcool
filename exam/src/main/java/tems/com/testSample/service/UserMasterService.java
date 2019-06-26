package tems.com.testSample.service;

import java.util.List;

import tems.com.testSample.model.UserMasterDefaultVO;
import tems.com.testSample.model.UserMasterVO;

/**
 * @Class Name : UserMasterService.java
 * @Description : UserMaster Business class
 * @Modification Information
 *
 * @author test
 * @since 20150923
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface UserMasterService {
	
	/**
	 * USER_MASTER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 UserMasterVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertUserMaster(UserMasterVO vo) throws Exception;
    
    /**
	 * USER_MASTER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 UserMasterVO
	 * @return void형
	 * @exception Exception
	 */
    void updateUserMaster(UserMasterVO vo) throws Exception;
    
    /**
	 * USER_MASTER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 UserMasterVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteUserMaster(UserMasterVO vo) throws Exception;
    
    /**
	 * USER_MASTER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 UserMasterVO
	 * @return 조회한 USER_MASTER
	 * @exception Exception
	 */
    UserMasterVO selectUserMaster(UserMasterVO vo) throws Exception;
    
    /**
	 * USER_MASTER 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return USER_MASTER 목록
	 * @exception Exception
	 */
    List selectUserMasterList(UserMasterDefaultVO searchVO) throws Exception;
    
    /**
	 * USER_MASTER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return USER_MASTER 총 갯수
	 * @exception
	 */
    int selectUserMasterListTotCnt(UserMasterDefaultVO searchVO);
    
}
