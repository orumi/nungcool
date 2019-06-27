package tems.com.report.reportIssue.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import tems.com.common.model.SearchVO;
import tems.com.report.reportIssue.model.ReportIssueListVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("ReportIssueListDAO")
public class ReportIssueListDAO  extends EgovComAbstractDAO {

	public List<?> getReportIssueList(SearchVO searchVO){
		return list("ReportIssueListDAO.getReportIssueList",searchVO);
	}
	
	public void inTheReport(ReportIssueListVO reportIssueListVO){
		insert("ReportIssueListDAO.inTheReport", reportIssueListVO);
	}
	
	public void upRequestState(ReportIssueListVO reportIssueListVO){
		update("ReportIssueListDAO.upRequestState", reportIssueListVO);
	}
	
	public void upReportState(ReportIssueListVO reportIssueListVO){
		update("ReportIssueListDAO.upReportState", reportIssueListVO);
	}

}
