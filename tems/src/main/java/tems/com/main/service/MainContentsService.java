package tems.com.main.service;

import tems.com.main.model.ProgressInfoVO;

import java.util.List;

public interface MainContentsService {

    public List selectReqTestRegList() throws Exception;

    public List selectProgressStateList() throws Exception;

    public List selectProgressInfo(ProgressInfoVO vo) throws Exception;

    public List selectBoardList() throws Exception;



}
