package tems.com.officialExam.issue.service.impl;

import org.springframework.stereotype.Service;
import tems.com.common.model.SearchVO;
import tems.com.officialExam.issue.model.RejectResultVO;
import tems.com.officialExam.issue.service.OfficialApproveIssueService;

import javax.annotation.Resource;
import java.util.List;

@Service("officialApproveIssueService")
public class OfficialApproveIssueServiceImpl implements OfficialApproveIssueService {
    
	@Resource(name = "officialApproveIssueDAO")
    private OfficialApproveIssueDAO officialApproveIssueDAO;
	
	@Override
	public List<?> getRequestList(SearchVO searchVO){
		return officialApproveIssueDAO.getRequestList(searchVO);
	}
	
	@Override
	public List<?> getRejectResultList(SearchVO searchVO){
		return officialApproveIssueDAO.getRejectResultList(searchVO);
	}
	
	@Override
	public String inResultReject(RejectResultVO rejectResultVO){
		return officialApproveIssueDAO.inResultReject(rejectResultVO);
	}
	
	@Override
	public void upReportApprovalReject(RejectResultVO rejectResultVO){
		officialApproveIssueDAO.upReportApprovalReject(rejectResultVO);
	}
	
	@Override
	public void inResultRejectItem(RejectResultVO rejectResultVO){
		officialApproveIssueDAO.inResultRejectItem(rejectResultVO);
	}
	
	@Override
	public void upReportApproval(RejectResultVO rejectResultVO){
		officialApproveIssueDAO.upReportApproval(rejectResultVO);
	}
}
