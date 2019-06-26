package exam.com.main.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

import org.springframework.stereotype.Repository;

import exam.com.main.model.CompanyVO;
import exam.com.main.model.LoginOldUserVO;
import exam.com.main.model.LoginUserVO;
import exam.com.main.model.MemberVO;

import java.util.List;

/**
 * Created by yongwoo on 2015-11-09.
 */
@Repository("mainDAO")
public class MainDAO extends EgovComAbstractDAO {

         

      public List<?> selectState(LoginUserVO loginUserVO) throws Exception {
    	  return list("mainDAO.selectState", loginUserVO);
      }
          

}
