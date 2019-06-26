package tems.com.testSample.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import tems.com.testSample.model.UserMasterDefaultVO;
import tems.com.testSample.model.UserMasterVO;
import tems.com.testSample.service.UserMasterService;
import tems.com.testSample.service.impl.UserMasterDAO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * @Class Name : UserMasterServiceImpl.java
 * @Description : UserMaster Business Implement class
 * @Modification Information
 *
 * @author test
 * @since 20150923
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("userMasterService")
public class UserMasterServiceImpl extends EgovAbstractServiceImpl implements
        UserMasterService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(UserMasterServiceImpl.class);

    @Resource(name="userMasterDAO")
    private UserMasterDAO userMasterDAO;
    
    /** ID Generation */
    //@Resource(name="{egovUserMasterIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * USER_MASTER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 UserMasterVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertUserMaster(UserMasterVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	userMasterDAO.insertUserMaster(vo);
        return null;
    }

    /**
	 * USER_MASTER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 UserMasterVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateUserMaster(UserMasterVO vo) throws Exception {
        userMasterDAO.updateUserMaster(vo);
    }

    /**
	 * USER_MASTER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 UserMasterVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteUserMaster(UserMasterVO vo) throws Exception {
        userMasterDAO.deleteUserMaster(vo);
    }

    /**
	 * USER_MASTER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 UserMasterVO
	 * @return 조회한 USER_MASTER
	 * @exception Exception
	 */
    public UserMasterVO selectUserMaster(UserMasterVO vo) throws Exception {
        UserMasterVO resultVO = userMasterDAO.selectUserMaster(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * USER_MASTER 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return USER_MASTER 목록
	 * @exception Exception
	 */
    public List<?> selectUserMasterList(UserMasterDefaultVO searchVO) throws Exception {
        return userMasterDAO.selectUserMasterList(searchVO);
    }

    /**
	 * USER_MASTER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return USER_MASTER 총 갯수
	 * @exception
	 */
    public int selectUserMasterListTotCnt(UserMasterDefaultVO searchVO) {
		return userMasterDAO.selectUserMasterListTotCnt(searchVO);
	}
    
}
