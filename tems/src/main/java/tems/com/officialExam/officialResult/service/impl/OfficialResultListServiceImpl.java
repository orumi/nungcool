package tems.com.officialExam.officialResult.service.impl;

import org.springframework.stereotype.Service;
import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ApprDetailVO;
import tems.com.officialExam.officialResult.service.OfficialResultListService;

import javax.annotation.Resource;
import java.util.List;

@Service("officialResultListService")
public class OfficialResultListServiceImpl implements OfficialResultListService {

    @Resource(name = "officialResultListDAO")
    private OfficialResultListDAO officialResultListDAO;
	
    @Override
    public List<?> getRequestList(SearchVO searchVO) throws Exception{
    	return officialResultListDAO.getRequestList(searchVO);
    }
    
    @Override
    public void delApprConf(ApprDetailVO apprDetailVO) throws Exception {
        officialResultListDAO.delApprConf(apprDetailVO);
    }
    
    @Override
    public void inApprConf(ApprDetailVO apprDetailVO) throws Exception {
        officialResultListDAO.inApprConf(apprDetailVO);
    }
    
    @Override
    public void upApprState(ApprDetailVO apprDetailVO) throws Exception {
        officialResultListDAO.upApprState(apprDetailVO);
    }
     
}
