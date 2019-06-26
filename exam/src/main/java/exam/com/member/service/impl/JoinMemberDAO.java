package exam.com.member.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import exam.com.member.model.CompanyVO;
import exam.com.member.model.IdInquiry;
import exam.com.member.model.MemberVO;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by yongwoo on 2015-11-09.
 */
@Repository("joinMemberDAO")
public class JoinMemberDAO extends EgovComAbstractDAO {

    public List<?> checkCompRegi(CompanyVO companyVO) throws Exception {
        return list("joinMemberDAO.checkCompRegi", companyVO);
    }

    public List<?> selectOneUser(MemberVO memberVO) throws Exception {
        return list("joinMemberDAO.selectOneUser", memberVO);
    }

    public List<?> selectOneCompanyByBisNum(CompanyVO companyVO) throws Exception {
        return list("joinMemberDAO.selectOneCompanyByBisNum", companyVO);
    }

    public void insertJoinMember(MemberVO memberVO) throws Exception {
        insert("joinMemberDAO.insertJoinMember", memberVO);
    }

    public void insertJoinCompany(CompanyVO companyVO) throws Exception {
        insert("joinMemberDAO.insertJoinCompany", companyVO);
    }

    public List<?> selectIdInquiry(IdInquiry idInquiry) throws Exception {
        return list("joinMemberDAO.selectIdInquiry", idInquiry);
    }

    public List<?> selectPhoneValid(MemberVO vo) throws Exception {
        return list("joinMemberDAO.selectPhoneValid", vo);
    }

    public List<?> selectEmailValid(MemberVO vo) throws Exception {
        return list("joinMemberDAO.selectEmailValid", vo);
    }

    public void insertJoinCompDummy(CompanyVO vo) throws Exception {
        insert("joinMemberDAO.insertJoinCompDummy", vo);
    }

}