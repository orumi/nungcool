package tems.com.cooperate.receiveApprove.service;

import java.util.List;

import tems.com.common.model.SearchVO;
import tems.com.exam.cooperation.model.CooperationListVO;

public interface CooperateReceiveApproveService {
	
	List getCoopApprList(SearchVO searchVO) throws Exception;
	
	void upCoopAppr(CooperationListVO cooperationListVO) throws Exception;
}
