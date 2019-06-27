package tems.com.report.officialReport.service.impl;

import org.springframework.stereotype.Service;
import tems.com.common.model.SearchVO;
import tems.com.report.officialReport.model.ReportIssueListVO;
import tems.com.report.officialReport.service.OfficialReportIssueListService;

import javax.annotation.Resource;
import java.util.List;

@Service("officialReportIssueListService")
public class OfficialReportIssueListServiceImpl implements OfficialReportIssueListService {
	
	@Resource(name = "officialReportIssueListDAO")
    private OfficialReportIssueListDAO officialReportIssueListDAO;
	
	public List<?> getReportIssueList(SearchVO searchVO){
		return officialReportIssueListDAO.getReportIssueList(searchVO);
	}
	
	public void inTheReport(ReportIssueListVO reportIssueListVO){
		officialReportIssueListDAO.inTheReport(reportIssueListVO);
	}
	
	public void upRequestState(ReportIssueListVO reportIssueListVO){
		officialReportIssueListDAO.upRequestState(reportIssueListVO);
	}
	
	public void upReportState(ReportIssueListVO reportIssueListVO){
		officialReportIssueListDAO.upReportState(reportIssueListVO);
	}
}
