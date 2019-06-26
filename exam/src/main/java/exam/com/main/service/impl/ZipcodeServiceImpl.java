package exam.com.main.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import exam.com.main.model.CompanyVO;
import exam.com.main.model.LoginOldUserVO;
import exam.com.main.model.LoginUserVO;
import exam.com.main.model.MemberVO;
import exam.com.main.service.LoginUserService;
import exam.com.main.service.ZipcodeService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by on 2015-11-09.
 */
@Service("zipcodeService")
public class ZipcodeServiceImpl implements ZipcodeService {

    @Resource(name = "zipcodeDAO")
    private ZipcodeDAO zipcodeDAO;
 	
    @Override
    public List selectSiguList() throws Exception {
    	return zipcodeDAO.selectSiguList();
	}

    @Override
	public String selectZipSearchCount(Map<String, String> map) throws Exception {
		return zipcodeDAO.selectZipSearchCount(map);
	}

    @Override
	public List selectZipSearchList(Map<String, String> map) throws Exception {
		return zipcodeDAO.selectZipSearchList(map);
	}
     
}
