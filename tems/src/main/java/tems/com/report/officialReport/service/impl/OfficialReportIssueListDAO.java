package tems.com.report.officialReport.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;
import tems.com.common.model.SearchVO;
import tems.com.report.officialReport.model.ReportIssueListVO;

import java.util.List;

@Repository("officialReportIssueListDAO")
public class OfficialReportIssueListDAO  extends EgovComAbstractDAO {

	public List<?> getReportIssueList(SearchVO searchVO){
		return list("officialReportIssueListDAO.getReportIssueList",searchVO);
	}
	
	public void inTheReport(ReportIssueListVO reportIssueListVO){
		insert("officialReportIssueListDAO.inTheReport", reportIssueListVO);
	}
	
	public void upRequestState(ReportIssueListVO reportIssueListVO){
		update("officialReportIssueListDAO.upRequestState", reportIssueListVO);
	}
	
	public void upReportState(ReportIssueListVO reportIssueListVO){
		update("officialReportIssueListDAO.upReportState", reportIssueListVO);
	}

}
