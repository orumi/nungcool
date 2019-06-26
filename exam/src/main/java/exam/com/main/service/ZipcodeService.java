package exam.com.main.service;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import exam.com.main.model.CompanyVO;
import exam.com.main.model.LoginOldUserVO;
import exam.com.main.model.LoginUserVO;
import exam.com.main.model.MemberVO;

/**
 * Created by on 2015-11-09.
 */
public interface ZipcodeService {

    public List selectSiguList() throws Exception ;

	public String selectZipSearchCount(Map<String, String> map) throws Exception ;

	public List selectZipSearchList(Map<String, String> map) throws Exception ;
	

}
