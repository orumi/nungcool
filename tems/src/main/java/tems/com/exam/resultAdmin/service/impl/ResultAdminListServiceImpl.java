package tems.com.exam.resultAdmin.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.common.StringUtils;
import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ReqResultVO;
import tems.com.exam.result.model.CalculationVO;
import tems.com.exam.result.model.ResultlVO;
import tems.com.exam.resultAdmin.model.ResultAdminListVO;
import tems.com.exam.resultAdmin.service.ResultAdminListService;
import tems.com.exam.resultAdmin.service.impl.ResultAdminListDAO;

@Service("ResultAdminListService")
public class ResultAdminListServiceImpl  implements ResultAdminListService {
	
    @Resource(name = "ResultAdminListDAO")
    private ResultAdminListDAO resultAdminListDAO;
    
    @Override
    public List<?> getResultAdminList(SearchVO searchVO) throws Exception{
    	return resultAdminListDAO.getResultAdminList(searchVO);
    }
    
    @Override
    public void upResultAdminDetail(ResultAdminListVO resultAdminListVO) throws Exception{
    	resultAdminListDAO.upResultAdminDetail(resultAdminListVO);
    }
    
    @Override
    public List<?> getCalculationAdmin(SearchVO searchVO) throws Exception{
    	return resultAdminListDAO.getCalculationAdmin(searchVO);
    }
    
    @Override
    public void inCalResultAdmin(CalculationVO calculationVO) throws Exception{
    	resultAdminListDAO.inCalResultAdmin(calculationVO);
    }
    
    @Override
    public List getReqList(SearchVO searchVO) throws Exception{
    	return resultAdminListDAO.getReqList(searchVO);
    }
}
