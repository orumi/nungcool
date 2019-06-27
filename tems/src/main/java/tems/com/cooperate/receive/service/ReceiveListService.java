package tems.com.cooperate.receive.service;

import java.util.List;

import tems.com.common.model.SearchVO;
import tems.com.cooperate.receive.model.CooperateReceiveListVO;
import tems.com.exam.cooperation.model.CooperReqDetailVO;

public interface ReceiveListService {

	List getReceiveList(SearchVO searchVO) throws Exception;
	
	void upReceive(CooperateReceiveListVO cooperateReceiveListVO) throws Exception;
	
	CooperReqDetailVO getCoopReqDetail(SearchVO searchVO) throws Exception;
	
	List getCoopSmpList(SearchVO searchVO) throws Exception;
	
	void upCoopReject(CooperateReceiveListVO cooperateReceiveListVO) throws Exception;
}
