package tems.com.exam.issue.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.common.model.SearchVO;
import tems.com.exam.issue.model.RejectResultVO;
import tems.com.exam.issue.service.ApproveIssueService;
import tems.com.exam.issue.service.impl.ApproveIssueDAO;

@Service("ApproveIssueService")
public class ApproveIssueServiceImpl implements ApproveIssueService{
    
	@Resource(name = "ApproveIssueDAO")
    private ApproveIssueDAO approveIssueDAO;
	
	@Override
	public List<?> getRequestList(SearchVO searchVO){
		return approveIssueDAO.getRequestList(searchVO);
	}
	
	@Override
	public List<?> getRejectResultList(SearchVO searchVO){
		return approveIssueDAO.getRejectResultList(searchVO);
	}
	
	@Override
	public String inResultReject(RejectResultVO rejectResultVO){
		return approveIssueDAO.inResultReject(rejectResultVO);
	}
	
	@Override
	public void upReportApprovalReject(RejectResultVO rejectResultVO){
		approveIssueDAO.upReportApprovalReject(rejectResultVO);
	}
	
	@Override
	public void inResultRejectItem(RejectResultVO rejectResultVO){
		approveIssueDAO.inResultRejectItem(rejectResultVO);
	}
	
	@Override
	public void upReportApproval(RejectResultVO rejectResultVO){
		approveIssueDAO.upReportApproval(rejectResultVO);
	}
}
