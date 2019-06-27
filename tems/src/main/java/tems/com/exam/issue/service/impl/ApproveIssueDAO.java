package tems.com.exam.issue.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.model.SearchVO;
import tems.com.exam.issue.model.RejectResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("ApproveIssueDAO")
public class ApproveIssueDAO extends EgovComAbstractDAO {

	public List<?> getRequestList(SearchVO searchVO){
		return list("ApproveIssueDAO.getRequestList",searchVO);
	}
	
	public List<?> getRejectResultList(SearchVO searchVO){
		return list("ApproveIssueDAO.getRejectResultList",searchVO);
	}
	
	public String inResultReject(RejectResultVO rejectResultVO){
		insert("ApproveIssueDAO.inResultReject",rejectResultVO);
		return rejectResultVO.getRejordinal();
	}
	
	public void inResultRejectItem(RejectResultVO rejectResultVO){
		insert("ApproveIssueDAO.inResultRejectItem",rejectResultVO);
	}
	
	public void upReportApprovalReject(RejectResultVO rejectResultVO){
		update("ApproveIssueDAO.upReportApprovalReject",rejectResultVO);
		update("ApproveIssueDAO.upRequestRejectState",rejectResultVO);
		update("ApproveIssueDAO.upReportRejectState",rejectResultVO);
	}
	
	public void upReportApproval(RejectResultVO rejectResultVO){
		update("ApproveIssueDAO.upReportApproval",rejectResultVO);
		update("ApproveIssueDAO.upReportApprovalNext",rejectResultVO);
		update("ApproveIssueDAO.upReportApprovalReq",rejectResultVO);
		update("ApproveIssueDAO.upReportState",rejectResultVO);
	}
}
