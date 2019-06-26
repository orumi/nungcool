package exam.com.member.service.impl;

import exam.com.member.model.CompanyVO;
import exam.com.member.model.IdInquiry;
import exam.com.member.model.MemberVO;
import exam.com.member.service.JoinMemberService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by yongwoo on 2015-11-09.
 */
@Service("joinMemberService")
public class JoinMemberServiceImpl implements JoinMemberService {

    @Resource(name = "joinMemberDAO")
    private JoinMemberDAO joinMemberDAO;


    @Override
    public List<?> checkCompRegi(CompanyVO vo) throws Exception {
        return joinMemberDAO.checkCompRegi(vo);
    }

    @Override
    public String idValidation(MemberVO vo) throws Exception {

        String userIdValid;
        List list = joinMemberDAO.selectOneUser(vo);

        if (list.size() == 0) {
            userIdValid = "true";
        } else {
            userIdValid = "false";
        }
        return userIdValid;
    }

    @Override
    public List<?> bisNumCheck(CompanyVO vo) throws Exception {
        Boolean bisNumValid;
        List list = joinMemberDAO.selectOneCompanyByBisNum(vo);
        return list;
    }

    @Override
    public void insertJoinMember(MemberVO vo) throws Exception {
        joinMemberDAO.insertJoinMember(vo);
    }

    @Override
    public void insertJoinCompany(CompanyVO vo) throws Exception {
        joinMemberDAO.insertJoinCompany(vo);
        joinMemberDAO.insertJoinCompDummy(vo);
    }

    @Override
    public List<?> selectIdInquiry(IdInquiry idInquiry) throws Exception {
        return joinMemberDAO.selectIdInquiry(idInquiry);
    }

    @Override
    public String phoneValid(MemberVO vo) throws Exception {

        String phoneValid;
        List list = joinMemberDAO.selectPhoneValid(vo);
        if (list.size() == 0) {
            phoneValid = "true";
        } else {
            phoneValid = "false";
        }
        return phoneValid;

    }

    @Override
    public String emailValid(MemberVO vo) throws Exception {

        String emailValid;
        List list = joinMemberDAO.selectEmailValid(vo);
        if (list.size() == 0) {
            emailValid = "true";
        } else {
            emailValid = "false";
        }
        return emailValid;
    }


}
