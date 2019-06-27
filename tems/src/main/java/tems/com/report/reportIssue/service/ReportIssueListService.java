package tems.com.report.reportIssue.service;

import java.util.List;

import tems.com.common.model.SearchVO;
import tems.com.report.reportIssue.model.ReportIssueListVO;

public interface ReportIssueListService {
	
	List getReportIssueList(SearchVO searchVO);
	
	void inTheReport(ReportIssueListVO reportIssueListVO);
	
	void upRequestState(ReportIssueListVO reportIssueListVO);
	
	void upReportState(ReportIssueListVO reportIssueListVO);
	
}
