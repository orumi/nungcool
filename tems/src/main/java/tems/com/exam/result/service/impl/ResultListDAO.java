package tems.com.exam.result.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ApprDetailVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("ResultListDAO")
public class ResultListDAO extends EgovComAbstractDAO  {
	
	public List<?> getRequestList(SearchVO searchVO){
        return list("ResultListDAO.getRequestList", searchVO);
   }
	
	public void delApprConf(ApprDetailVO apprDetailVO){
		delete("ResultListDAO.delApprConf",apprDetailVO);
	}
	
	public void inApprConf(ApprDetailVO apprDetailVO){
		insert("ResultListDAO.inApprConf",apprDetailVO);
	}
	
	public void upApprState(ApprDetailVO apprDetailVO){
		update("ResultListDAO.upApprState",apprDetailVO);
		update("ResultListDAO.upReportState",apprDetailVO);
	}
}
