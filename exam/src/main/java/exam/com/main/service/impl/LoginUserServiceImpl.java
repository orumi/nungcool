package exam.com.main.service.impl;

import exam.com.main.model.CompanyVO;
import exam.com.main.model.LoginOldUserVO;
import exam.com.main.model.LoginUserVO;
import exam.com.main.model.MemberVO;
import exam.com.main.service.LoginUserService;
import exam.com.member.model.PswordChg;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.List;

/**
 * Created by yongwoo on 2015-11-09.
 */
@Service("loginUserService")
public class LoginUserServiceImpl implements LoginUserService {

     @Resource(name = "loginUserDAO")
     private LoginUserDAO loginUserDAO;
 
     @Override
     public LoginUserVO selectLoginUser(LoginUserVO loginUserVO) throws Exception {
          LoginUserVO resultUser = loginUserDAO.selectLoginUser(loginUserVO);
          return resultUser;
     }
     
     @Override
     public List selectLoginOldUser(LoginUserVO loginUserVO) throws Exception {
          return loginUserDAO.selectLoginOldUser(loginUserVO);
     }
     
     @Override
     public int selectCountNewId(String newid) throws Exception {
    	 return loginUserDAO.selectCountNewId(newid);
     }
     
     @Override
     public void adjustNewId(LoginOldUserVO loginOldUserVO) throws Exception {
    	 loginUserDAO.adjustNewId(loginOldUserVO);
     }
     
     @Override
     public List selectCompany(String comid) throws Exception {
   	  	return loginUserDAO.selectCompany(comid);
     }
     
     @Override
     public List selectMember(String memid) throws Exception {
   	  	return loginUserDAO.selectMember(memid);
     }
     
     @Override
     public void updateCompany(CompanyVO companyVO) throws Exception {
    	 loginUserDAO.updateCompany(companyVO);
     }
     
     @Override
     public void updateMember(MemberVO memberVO) throws Exception {
   	     loginUserDAO.updateMember(memberVO);
     }

     @Override
     public void updateUserPassword(PswordChg vo) throws Exception {
          loginUserDAO.updateUserPassword(vo);
     }
     
     
     /* 개인회원 처리 과정 */
     
     @Override
     public List<?> selectLoginPersonUser(LoginUserVO loginUserVO) throws Exception {
   	  	return loginUserDAO.selectLoginPersonUser(loginUserVO);
     }         

     @Override
     public List<?> selectCompanybyBizNum(CompanyVO companyVO) throws Exception{
   	  	return loginUserDAO.selectCompanybyBizNum(companyVO);
     }
     @Override
     public void updateMemberComid(MemberVO memberVO) throws Exception {
   	  	loginUserDAO.updateMemberComid(memberVO);
     }
     @Override
     public void updateRequestComid(MemberVO memberVO) throws Exception {
   	  	loginUserDAO.updateRequestComid(memberVO);
     }
     @Override
     public void insetCompany(CompanyVO companyVO) throws Exception {
    	 loginUserDAO.insetCompany(companyVO);
     }
     
     
     /*최종 회원 변경 */
     @Override
     public void updateMemYN(MemberVO memberVO) throws Exception {
   	  	loginUserDAO.updateMemYN(memberVO);
     }
     
}
