package tems.com.cooperate.result.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.common.model.SearchVO;
import tems.com.cooperate.result.service.CooperateResultListService;
import tems.com.exam.result.model.ResultDetailVO;
import tems.com.exam.result.model.ResultlVO;
import tems.com.exam.result.service.impl.ResultDetailDAO;

@Service("CooperateResultListService")
public class CooperateResultListServiceImpl implements CooperateResultListService {
    
	@Resource(name = "CooperateResultListDAO")
    private CooperateResultListDAO cooperateResultListDAO;
	
	public List getRequestList(SearchVO searchVO) throws Exception{
		return cooperateResultListDAO.getRequestList(searchVO);
	}
	
	public List getResultSmpList(SearchVO searchVO) throws Exception{
		return cooperateResultListDAO.getResultSmpList(searchVO);
	}
	
	public List getCoopResultList(SearchVO searchVO) throws Exception{
		return cooperateResultListDAO.getCoopResultList(searchVO);
	}
	
	public ResultDetailVO getResultDetail(SearchVO searchVO) throws Exception{
		return cooperateResultListDAO.getResultDetail(searchVO);
	}
	
	public List<?> getCoopCalculation(SearchVO searchVO) throws Exception{
		return cooperateResultListDAO.getCoopCalculation(searchVO);
	}
	
	public void upCoopResultState(ResultlVO resultlVO) throws Exception{
		cooperateResultListDAO.upCoopResultState(resultlVO);
		cooperateResultListDAO.upCoopReqState(resultlVO);
	}
}
