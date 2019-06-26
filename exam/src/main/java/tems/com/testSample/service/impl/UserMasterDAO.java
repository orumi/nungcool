package tems.com.testSample.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.testSample.model.UserMasterDefaultVO;
import tems.com.testSample.model.UserMasterVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : UserMasterDAO.java
 * @Description : UserMaster DAO Class
 * @Modification Information
 *
 * @author test
 * @since 20150923
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("userMasterDAO")
public class UserMasterDAO extends EgovAbstractDAO {

	/**
	 * USER_MASTER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 UserMasterVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertUserMaster(UserMasterVO vo) throws Exception {
        return (String)insert("userMasterDAO.insertUserMaster_S", vo);
    }

    /**
	 * USER_MASTER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 UserMasterVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateUserMaster(UserMasterVO vo) throws Exception {
        update("userMasterDAO.updateUserMaster_S", vo);
    }

    /**
	 * USER_MASTER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 UserMasterVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteUserMaster(UserMasterVO vo) throws Exception {
        delete("userMasterDAO.deleteUserMaster_S", vo);
    }

    /**
	 * USER_MASTER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 UserMasterVO
	 * @return 조회한 USER_MASTER
	 * @exception Exception
	 */
    public UserMasterVO selectUserMaster(UserMasterVO vo) throws Exception {
        return (UserMasterVO) select("userMasterDAO.selectUserMaster_S", vo);
    }

    /**
	 * USER_MASTER 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return USER_MASTER 목록
	 * @exception Exception
	 */
    public List<?> selectUserMasterList(UserMasterDefaultVO searchVO) throws Exception {
        return list("userMasterDAO.selectUserMasterList_D", searchVO);
    }

    /**
	 * USER_MASTER 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return USER_MASTER 총 갯수
	 * @exception
	 */
    public int selectUserMasterListTotCnt(UserMasterDefaultVO searchVO) {
        return (Integer)select("userMasterDAO.selectUserMasterListTotCnt_S", searchVO);
    }

}
