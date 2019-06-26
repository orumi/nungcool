package exam.com.main.service.impl;

import java.util.List;

import exam.com.main.model.CompanyVO;
import exam.com.main.model.LoginOldUserVO;
import exam.com.main.model.LoginUserVO;
import exam.com.main.model.MemberVO;
import exam.com.main.service.LoginUserService;
import exam.com.main.service.MainService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by yongwoo on 2015-11-09.
 */
@Service("mainService")
public class MainServiceImpl implements MainService {

     @Resource(name = "mainDAO")
     private MainDAO mainDAO;
 
     
     @Override
     public List selectState(LoginUserVO loginUserVO) throws Exception {
          return mainDAO.selectState(loginUserVO);
     }
     
     
     
}
