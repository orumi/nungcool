package tems.com.cooperate.receive.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.common.model.SearchVO;
import tems.com.cooperate.receive.model.CooperateReceiveListVO;
import tems.com.cooperate.receive.service.ReceiveListService;
import tems.com.exam.cooperation.model.CooperReqDetailVO;

@Service("ReceiveListService")
public class ReceiveListServiceImpl implements ReceiveListService {
	
	@Resource(name = "ReceiveListDAO")
    private ReceiveListDAO receiveListDAO;
	
	public List getReceiveList(SearchVO searchVO) throws Exception{
		return receiveListDAO.getReceiveList(searchVO);
	}
	
	public void upReceive(CooperateReceiveListVO cooperateReceiveListVO) throws Exception{
		receiveListDAO.upReceive(cooperateReceiveListVO);
	}
	
	public CooperReqDetailVO getCoopReqDetail(SearchVO searchVO) throws Exception{
		return receiveListDAO.getCoopReqDetail(searchVO);
	}
	
	public List getCoopSmpList(SearchVO searchVO) throws Exception{
		return receiveListDAO.getCoopSmpList(searchVO);
	}
	
	public void upCoopReject(CooperateReceiveListVO cooperateReceiveListVO) throws Exception{
		receiveListDAO.inCoopReject(cooperateReceiveListVO);
		receiveListDAO.upCoopReqReject(cooperateReceiveListVO);
	}

}
