package tems.com.officialExam.officialResult.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;
import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ApprDetailVO;

import java.util.List;

@Repository("officialResultListDAO")
public class OfficialResultListDAO extends EgovComAbstractDAO  {
	
	public List<?> getRequestList(SearchVO searchVO){
        return list("officialResultListDAO.getRequestList", searchVO);
   }
	
	public void delApprConf(ApprDetailVO apprDetailVO){
		delete("officialResultListDAO.delApprConf",apprDetailVO);
	}
	
	public void inApprConf(ApprDetailVO apprDetailVO){
		insert("officialResultListDAO.inApprConf",apprDetailVO);
	}
	
	public void upApprState(ApprDetailVO apprDetailVO){
		update("officialResultListDAO.upApprState",apprDetailVO);
		update("officialResultListDAO.upReportState",apprDetailVO);
	}
}
