package exam.com.main.service;


import exam.com.main.model.CompanyVO;
import exam.com.main.model.LoginOldUserVO;
import exam.com.main.model.LoginUserVO;
import exam.com.main.model.MemberVO;
import exam.com.member.model.PswordChg;

import java.util.List;

/**
 * Created by yongwoo on 2015-11-09.
 */
public interface LoginUserService {

	public LoginUserVO selectLoginUser(LoginUserVO loginUserVO) throws Exception;
	
	public List selectLoginOldUser(LoginUserVO loginUserVO) throws Exception;
	
	public int selectCountNewId(String newid) throws Exception; 
	
	public void adjustNewId(LoginOldUserVO loginOldUserVO) throws Exception;
	
    public List selectCompany(String comid) throws Exception;
    
    public List selectMember(String memid) throws Exception ;
    
    public void updateCompany(CompanyVO companyVO) throws Exception ;
    
    public void updateMember(MemberVO memberVO) throws Exception ;

    public void updateUserPassword(PswordChg vo) throws Exception;
    
    /*개인회원 관련*/
    public List<?> selectLoginPersonUser(LoginUserVO loginUserVO) throws Exception;
    
    public List<?> selectCompanybyBizNum(CompanyVO companyVO) throws Exception;
    
    public void updateMemberComid(MemberVO memberVO) throws Exception ;
    public void updateRequestComid(MemberVO memberVO) throws Exception ;
    public void insetCompany(CompanyVO companyVO) throws Exception ; 
    
    
    /*최종 회원 변경 */
    public void updateMemYN(MemberVO memberVO) throws Exception ;
    
}
