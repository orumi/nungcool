package tems.com.cooperate.receiveApprove.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.common.model.SearchVO;
import tems.com.cooperate.receiveApprove.service.CooperateReceiveApproveService;
import tems.com.exam.cooperation.model.CooperationListVO;

@Service("CooperateReceiveApproveService")
public class CooperateReceiveApproveServiceImpl implements CooperateReceiveApproveService{
		
	@Resource(name = "CooperateReceiveApproveDAO")
	private CooperateReceiveApproveDAO cooperateReceiveApproveDAO;
	
	@Override
	public List getCoopApprList(SearchVO searchVO) throws Exception{
		return cooperateReceiveApproveDAO.getCoopApprList(searchVO);
	}
	
	@Override
	public void upCoopAppr(CooperationListVO cooperationListVO) throws Exception{
		cooperateReceiveApproveDAO.upCoopAppr(cooperationListVO);
	}
}
