package tems.com.exam.result.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.model.SearchVO;
import tems.com.exam.result.model.CalculationVO;
import tems.com.exam.result.model.CoopApprVO;
import tems.com.exam.result.model.ResultDetailVO;
import tems.com.exam.result.model.ResultlVO;
import tems.com.exam.result.model.SmpDetailVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("ResultDetailDAO")
public class ResultDetailDAO extends EgovComAbstractDAO  {
	
	public ResultDetailVO getResultDetail(SearchVO searchVO){
        return (ResultDetailVO)select("ResultDetailDAO.getResultDetail", searchVO);
   }
	
	public List<?> getResultSmpList(SearchVO searchVO){
        return list("ResultDetailDAO.getResultSmpList", searchVO);
   }
	
	public List<?> getResultList(SearchVO searchVO){
        return list("ResultDetailDAO.getResultList", searchVO);
   }
	
	public void upResultDetail(ResultlVO resultlVO){
        update("ResultDetailDAO.upResultDetail", resultlVO);
   }
	
	public List<?> getCalculation(SearchVO searchVO){
        return list("ResultDetailDAO.getCalculation", searchVO);
   }
	
	public void inCalResult(CalculationVO calculationVO){
        insert("ResultDetailDAO.inCalResult", calculationVO);
   }
	
	public List<?> getResultListAll(SearchVO searchVO){
        return list("ResultDetailDAO.getResultListAll", searchVO);
   }
	
	public SmpDetailVO getSmpDetail(SearchVO searchVO){
        return (SmpDetailVO) select("ResultDetailDAO.getSmpDetail", searchVO);
   }
	
	
	
	public void delApprConf(CoopApprVO coopApprVO){
		delete("ResultDetailDAO.delApprConf", coopApprVO);
	}
	
	public void inApprConf(CoopApprVO coopApprVO){
		insert("ResultDetailDAO.inApprConf", coopApprVO);
	}
	
	public void delCoopReq(CoopApprVO coopApprVO){
		delete("ResultDetailDAO.delCoopReq", coopApprVO);
	}
	
	public void inCoopReq(CoopApprVO coopApprVO){
		insert("ResultDetailDAO.inCoopReq", coopApprVO);
	}
	
	public void upCoopResult(CoopApprVO coopApprVO){
		update("ResultDetailDAO.upCoopResult", coopApprVO);
	}
	
}
