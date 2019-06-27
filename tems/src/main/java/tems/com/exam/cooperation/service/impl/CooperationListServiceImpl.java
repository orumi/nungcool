package tems.com.exam.cooperation.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.common.model.SearchVO;
import tems.com.exam.cooperation.model.CooperReqDetailVO;
import tems.com.exam.cooperation.model.CooperationRejectVO;
import tems.com.exam.cooperation.service.CooperationListService;
import tems.com.exam.result.model.CoopApprVO;

@Service("CooperationListService")
public class CooperationListServiceImpl implements CooperationListService{
	
	@Resource(name = "CooperationListDAO")
    private CooperationListDAO cooperationListDAO;
	
	@Override
	public List<?> getCooperationList(SearchVO searchVO) throws Exception{
		return cooperationListDAO.getCooperationList(searchVO);
	}
	
	@Override
	public void upCooperApproval(CoopApprVO coopApprVO) throws Exception{
		cooperationListDAO.upCooperApproval(coopApprVO);
		cooperationListDAO.upCooperApprovalNext(coopApprVO);
		cooperationListDAO.upCooperApprovalReq(coopApprVO);
	}
	
	@Override
	public List<?> getCooperSmpList(SearchVO searchVO) throws Exception{
		return cooperationListDAO.getCooperSmpList(searchVO);
	}
	
	@Override
	public CooperReqDetailVO getCooperReqDetail(SearchVO searchVO) throws Exception{
		return cooperationListDAO.getCooperReqDetail(searchVO);
	}
	
	@Override
	public void inCooperReject(CoopApprVO coopApprVO) throws Exception{
		cooperationListDAO.inCooperReject(coopApprVO);
		cooperationListDAO.upCooperRejApproval(coopApprVO);
		cooperationListDAO.upCooperRejApprovalReq(coopApprVO);
	}
	
	@Override
	public List getResultList(SearchVO searchVO) throws Exception{
		return cooperationListDAO.getResultList(searchVO);
	}
}
