package tems.com.cooperate.result.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import tems.com.common.model.SearchVO;
import tems.com.exam.result.model.ResultDetailVO;
import tems.com.exam.result.model.ResultlVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CooperateResultListDAO")
public class CooperateResultListDAO  extends EgovComAbstractDAO {
		
	public List<?> getRequestList(SearchVO searchVO){
		return list("CooperateResultListDAO.getRequestList",searchVO);
	}
	
	public List<?> getResultSmpList(SearchVO searchVO){
		return list("CooperateResultListDAO.getResultSmpList",searchVO);
	}
	
	public List<?> getCoopResultList(SearchVO searchVO){
		return list("CooperateResultListDAO.getCoopResultList",searchVO);
	}
	
	public ResultDetailVO getResultDetail(SearchVO searchVO){
        return (ResultDetailVO)select("CooperateResultListDAO.getCoopReqDetail", searchVO);
   }
	
	public List<?> getCoopCalculation(SearchVO searchVO){
        return list("CooperateResultListDAO.getCoopCalculation", searchVO);
   }
	
	public void upCoopResultState(ResultlVO resultlVO){
		update("CooperateResultListDAO.upCoopResultState",resultlVO);
	}
	
	public void upCoopReqState(ResultlVO resultlVO){
		update("CooperateResultListDAO.upCoopReqState",resultlVO);
	}
	
}
