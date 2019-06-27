package tems.com.report.reportIssue.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.common.model.SearchVO;
import tems.com.report.reportIssue.model.ReportIssueListVO;
import tems.com.report.reportIssue.service.ReportIssueListService;

@Service("ReportIssueListService")
public class ReportIssueListServiceImpl implements ReportIssueListService {
	
	@Resource(name = "ReportIssueListDAO")
    private ReportIssueListDAO reportIssueListDAO;
	
	public List<?> getReportIssueList(SearchVO searchVO){
		return reportIssueListDAO.getReportIssueList(searchVO);
	}
	
	public void inTheReport(ReportIssueListVO reportIssueListVO){
		reportIssueListDAO.inTheReport(reportIssueListVO);
	}
	
	public void upRequestState(ReportIssueListVO reportIssueListVO){
		reportIssueListDAO.upRequestState(reportIssueListVO);
	}
	
	public void upReportState(ReportIssueListVO reportIssueListVO){
		reportIssueListDAO.upReportState(reportIssueListVO);
	}
}
