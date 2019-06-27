package tems.com.officialExam.issue.service;

import tems.com.common.model.SearchVO;
import tems.com.officialExam.issue.model.RejectResultVO;

import java.util.List;

public interface OfficialApproveIssueService {
	List getRequestList(SearchVO searchVO);
	
	List getRejectResultList(SearchVO searchVO);
	
	String inResultReject(RejectResultVO rejectResultVO);
	
	void upReportApprovalReject(RejectResultVO rejectResultVO);
	
	void inResultRejectItem(RejectResultVO rejectResultVO);
	
	void upReportApproval(RejectResultVO rejectResultVO);
}
