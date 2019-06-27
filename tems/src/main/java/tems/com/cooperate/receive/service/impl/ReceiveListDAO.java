package tems.com.cooperate.receive.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.model.SearchVO;
import tems.com.cooperate.receive.model.CooperateReceiveListVO;
import tems.com.exam.cooperation.model.CooperReqDetailVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("ReceiveListDAO")
public class ReceiveListDAO extends EgovComAbstractDAO {

	public List<?> getReceiveList(SearchVO searchVO){
		return list("CooperateReceiveDAO.getReceiveList",searchVO);
	}
	
	public void upReceive(CooperateReceiveListVO cooperateReceiveListVO){
		update("CooperateReceiveDAO.upReceive",cooperateReceiveListVO);
	}
	
	public CooperReqDetailVO getCoopReqDetail(SearchVO searchVO){
		return (CooperReqDetailVO) select("CooperateReceiveDAO.getCoopReqDetail",searchVO);
	}
	
	
	public List<?> getCoopSmpList(SearchVO searchVO){
		return list("CooperateReceiveDAO.getCoopSmpList",searchVO);
	}
	
	public void inCoopReject(CooperateReceiveListVO cooperateReceiveListVO){
		update("CooperateReceiveDAO.inCoopReject",cooperateReceiveListVO);
	}
	
	public void upCoopReqReject(CooperateReceiveListVO cooperateReceiveListVO){
		update("CooperateReceiveDAO.upCoopReqReject",cooperateReceiveListVO);
	}
}
