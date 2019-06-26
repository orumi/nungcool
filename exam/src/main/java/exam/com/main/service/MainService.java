package exam.com.main.service;


import java.util.List;

import exam.com.main.model.CompanyVO;
import exam.com.main.model.LoginOldUserVO;
import exam.com.main.model.LoginUserVO;
import exam.com.main.model.MemberVO;

/**
 * Created by yongwoo on 2015-11-09.
 */
public interface MainService {

	public List selectState(LoginUserVO loginUserVO) throws Exception;
	
}
