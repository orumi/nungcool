package tems.com.officialExam.issue.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;
import tems.com.common.model.SearchVO;
import tems.com.officialExam.issue.model.RejectResultVO;

import java.util.List;

@Repository("officialApproveIssueDAO")
public class OfficialApproveIssueDAO extends EgovComAbstractDAO {

	public List<?> getRequestList(SearchVO searchVO){
		return list("officialApproveIssueDAO.getRequestList",searchVO);
	}
	
	public List<?> getRejectResultList(SearchVO searchVO){
		return list("officialApproveIssueDAO.getRejectResultList",searchVO);
	}
	
	public String inResultReject(RejectResultVO rejectResultVO){
		insert("officialApproveIssueDAO.inResultReject",rejectResultVO);
		return rejectResultVO.getRejordinal();
	}
	
	public void inResultRejectItem(RejectResultVO rejectResultVO){
		insert("officialApproveIssueDAO.inResultRejectItem",rejectResultVO);
	}
	
	public void upReportApprovalReject(RejectResultVO rejectResultVO){
		update("officialApproveIssueDAO.upReportApprovalReject",rejectResultVO);
		update("officialApproveIssueDAO.upRequestRejectState",rejectResultVO);
		update("officialApproveIssueDAO.upReportRejectState",rejectResultVO);
	}
	
	public void upReportApproval(RejectResultVO rejectResultVO){
		update("officialApproveIssueDAO.upReportApproval",rejectResultVO);
		update("officialApproveIssueDAO.upReportApprovalNext",rejectResultVO);
		update("officialApproveIssueDAO.upReportApprovalReq",rejectResultVO);
		update("officialApproveIssueDAO.upReportState",rejectResultVO);
	}
}
