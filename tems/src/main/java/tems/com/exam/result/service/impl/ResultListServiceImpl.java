package tems.com.exam.result.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.req.service.ReqListService;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;
import tems.com.exam.result.service.ResultListService;

@Service("ResultListService")
public class ResultListServiceImpl implements ResultListService {

    @Resource(name = "ResultListDAO")
    private ResultListDAO resultListDAO;
	
    @Override
    public List<?> getRequestList(SearchVO searchVO) throws Exception{
    	return resultListDAO.getRequestList(searchVO);
    }
    
    @Override
    public void delApprConf(ApprDetailVO apprDetailVO) throws Exception {
    	resultListDAO.delApprConf(apprDetailVO);
    }
    
    @Override
    public void inApprConf(ApprDetailVO apprDetailVO) throws Exception {
    	resultListDAO.inApprConf(apprDetailVO);
    }
    
    @Override
    public void upApprState(ApprDetailVO apprDetailVO) throws Exception {
    	resultListDAO.upApprState(apprDetailVO);
    }
     
}
