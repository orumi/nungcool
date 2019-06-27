package tems.com.main.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.login.service.impl.LoginUserDAO;
import tems.com.main.model.ProgressInfoVO;
import tems.com.main.service.MainContentsService;

import java.util.List;

@Service("mainContentsService")
public class MainContentsServiceImlp implements MainContentsService {

    @Resource(name = "mainContentsDAO")
    private MainContentsDAO mainContentsDAO;

    @Override
    public List selectReqTestRegList() throws Exception {
        return mainContentsDAO.selectReqTestRegList();
    }

    @Override
    public List selectProgressStateList() throws Exception {
        return mainContentsDAO.selectProgressStateList();
    }

    @Override
    public List selectProgressInfo(ProgressInfoVO vo) throws Exception {
        return mainContentsDAO.selectProgressInfo(vo);
    }

    @Override
    public List selectBoardList() throws Exception {
        return mainContentsDAO.selectBoardList();
    }
}
