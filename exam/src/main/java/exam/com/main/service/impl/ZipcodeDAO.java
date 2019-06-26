package exam.com.main.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

import org.springframework.stereotype.Repository;

import exam.com.main.model.CompanyVO;
import exam.com.main.model.LoginOldUserVO;
import exam.com.main.model.LoginUserVO;
import exam.com.main.model.MemberVO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by on 2015-11-09.
 */
@Repository("zipcodeDAO")
public class ZipcodeDAO extends EgovComAbstractDAO {

	public List selectSiguList() throws Exception {
		return list("zipcodeDAO.siguList");
	}
	
	public String selectZipSearchCount(Map<String, String> map) throws Exception {
		return (String) select("zipcodeDAO.zipCodeSearchCount", map);
	}
	
	public List selectZipSearchList(Map<String, String> map) throws Exception {
		return list("zipcodeDAO.zipCodeSearchList", map);
	}

}
