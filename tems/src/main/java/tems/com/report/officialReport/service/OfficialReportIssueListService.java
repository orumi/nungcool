package tems.com.report.officialReport.service;

import tems.com.common.model.SearchVO;
import tems.com.report.officialReport.model.ReportIssueListVO;

import java.util.List;

public interface OfficialReportIssueListService {
	
	List getReportIssueList(SearchVO searchVO);
	
	void inTheReport(ReportIssueListVO reportIssueListVO);
	
	void upRequestState(ReportIssueListVO reportIssueListVO);
	
	void upReportState(ReportIssueListVO reportIssueListVO);
	
}
