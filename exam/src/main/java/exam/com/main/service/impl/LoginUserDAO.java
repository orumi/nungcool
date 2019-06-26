package exam.com.main.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import exam.com.main.model.CompanyVO;
import exam.com.main.model.LoginOldUserVO;
import exam.com.main.model.LoginUserVO;
import exam.com.main.model.MemberVO;
import exam.com.member.model.PswordChg;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by yongwoo on 2015-11-09.
 */
@Repository("loginUserDAO")
public class LoginUserDAO extends EgovComAbstractDAO {

          public LoginUserVO selectLoginUser(LoginUserVO loginUserVO) throws Exception{
        	  return (LoginUserVO)select("loginUserDAO.selectLoginUser",loginUserVO);
          }

          public List<?> selectLoginOldUser(LoginUserVO loginUserVO) throws Exception {
        	  return list("loginUserDAO.selectOldUser", loginUserVO);
          }
          
          public int selectCountNewId(String newid) throws Exception {
        	  return ((Integer)select("loginUserDAO.selectCountNewId", newid)).intValue();
          }
          
          
          public void adjustNewId(LoginOldUserVO loginOldUserVO) throws Exception {
        	  update("loginUserDAO.updateNewId", loginOldUserVO);
        	  update("loginUserDAO.updateRequest", loginOldUserVO);
          }

          /* update member info */
          public List<?> selectCompany(String comid) throws Exception {
        	  return list("loginUserDAO.selectCompany", comid);
          }
          
          public List<?> selectMember(String memid) throws Exception {
        	  return list("loginUserDAO.selectMember", memid);
          }
          
          public void updateCompany(CompanyVO companyVO) throws Exception {
        	  update("loginUserDAO.updateCompany", companyVO);
        	  
        	  insert("loginUserDAO.insertTHTCompany", companyVO);
          }
          
          public void updateMember(MemberVO memberVO) throws Exception {
        	  update("loginUserDAO.updateMember", memberVO);
          }

          public void updateUserPassword(PswordChg vo) throws Exception {
              update("loginUserDAO.updateUserPassword", vo);
          }

          
          /* 개인회원 처리 과정 */
          public List<?> selectLoginPersonUser(LoginUserVO loginUserVO) throws Exception {
        	  return list("loginUserDAO.selectPersonUser", loginUserVO);
          }    
          
          
          public List<?> selectCompanybyBizNum(CompanyVO companyVO) throws Exception{
        	  return list("loginUserDAO.selectCompanyByBizNum", companyVO);
          }
          
          public void updateMemberComid(MemberVO memberVO) throws Exception {
        	  update("loginUserDAO.updateMemberComid", memberVO);
          }
          
          public void updateRequestComid(MemberVO memberVO) throws Exception {
        	  update("loginUserDAO.updateRequestComid", memberVO);
          }
           
          public void insetCompany(CompanyVO companyVO) throws Exception {
        	  insert("loginUserDAO.insertCompany", companyVO);
        	  
        	  insert("loginUserDAO.insertTHTCompany", companyVO);
        	  
          }
          
          
          
          /*최종 회원 변경 */
          public void updateMemYN(MemberVO memberVO) throws Exception {
        	  update("loginUserDAO.updateMemYN",memberVO);
          }

}
