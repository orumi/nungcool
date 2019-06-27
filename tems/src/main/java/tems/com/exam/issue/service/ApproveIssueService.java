package tems.com.exam.issue.service;

import java.util.List;

import tems.com.common.model.SearchVO;
import tems.com.exam.issue.model.RejectResultVO;

public interface ApproveIssueService {
	List getRequestList(SearchVO searchVO);
	
	List getRejectResultList(SearchVO searchVO);
	
	String inResultReject(RejectResultVO rejectResultVO);
	
	void upReportApprovalReject(RejectResultVO rejectResultVO);
	
	void inResultRejectItem(RejectResultVO rejectResultVO);
	
	void upReportApproval(RejectResultVO rejectResultVO);
}
