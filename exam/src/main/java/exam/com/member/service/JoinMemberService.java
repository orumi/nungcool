package exam.com.member.service;


import exam.com.member.model.CompanyVO;
import exam.com.member.model.IdInquiry;
import exam.com.member.model.MemberVO;

import java.util.List;

/**
 * Created by yongwoo on 2015-11-09.
 */

public interface JoinMemberService {

    public List<?> checkCompRegi(CompanyVO vo) throws Exception;

    public String idValidation(MemberVO vo) throws Exception;

    public List<?> bisNumCheck(CompanyVO vo) throws Exception;

    public void insertJoinMember(MemberVO vo) throws Exception;

    public void insertJoinCompany(CompanyVO vo) throws Exception;

    public List<?> selectIdInquiry(IdInquiry idInquiry) throws Exception;

    public String phoneValid(MemberVO vo) throws Exception;

    public String emailValid(MemberVO vo) throws Exception;


}
