package tems.com.cooperate.receiveApprove.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.model.SearchVO;
import tems.com.exam.cooperation.model.CooperationListVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CooperateReceiveApproveDAO")
public class CooperateReceiveApproveDAO  extends EgovComAbstractDAO {
	
	public List<?> getCoopApprList(SearchVO searchVO){
		return list("CooperateApproveDAO.getCoopApprList",searchVO);
	}
	
	public void upCoopAppr(CooperationListVO cooperationListVO){
		update("CooperateApproveDAO.upCoopAppr",cooperationListVO);
	}
}
