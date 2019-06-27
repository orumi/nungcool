package tems.com.main.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;
import tems.com.login.model.LoginUserVO;
import tems.com.main.model.ProgressInfoVO;

import java.util.List;

@Repository("mainContentsDAO")
public class MainContentsDAO extends EgovComAbstractDAO {

    public List<?> selectReqTestRegList() {
        return list("mainContentsDAO.selectReqTestRegList");
    }

    public List<?> selectProgressStateList() {
        return list("mainContentsDAO.selectProgressStateList");
    }

    public List<?> selectProgressInfo(ProgressInfoVO vo) {
        return list("mainContentsDAO.selectProgressInfo", vo);
    }

    public List<?> selectBoardList() {
        return list("mainContentsDAO.selectBoardList");
    }

}
