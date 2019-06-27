package tems.com.officialExam.cooperation.service.impl;

import org.springframework.stereotype.Service;
import tems.com.common.model.SearchVO;
import tems.com.exam.result.model.CoopApprVO;
import tems.com.officialExam.cooperation.model.CooperReqDetailVO;
import tems.com.officialExam.cooperation.service.OfficialCooperationListService;

import javax.annotation.Resource;
import java.util.List;

@Service("officialCooperationListService")
public class OfficialCooperationListServiceImpl implements OfficialCooperationListService {
	
	@Resource(name = "officialCooperationDAO")
    private OfficialCooperationListDAO officialCooperationListDAO;
	
	@Override
	public List<?> getCooperationList(SearchVO searchVO) throws Exception{
		return officialCooperationListDAO.getCooperationList(searchVO);
	}
	
	@Override
	public void upCooperApproval(CoopApprVO coopApprVO) throws Exception{
		officialCooperationListDAO.upCooperApproval(coopApprVO);
		officialCooperationListDAO.upCooperApprovalNext(coopApprVO);
		officialCooperationListDAO.upCooperApprovalReq(coopApprVO);
	}
	
	@Override
	public List<?> getCooperSmpList(SearchVO searchVO) throws Exception{
		return officialCooperationListDAO.getCooperSmpList(searchVO);
	}
	
	@Override
	public CooperReqDetailVO getCooperReqDetail(SearchVO searchVO) throws Exception{
		return officialCooperationListDAO.getCooperReqDetail(searchVO);
	}
	
	@Override
	public void inCooperReject(CoopApprVO coopApprVO) throws Exception{
		officialCooperationListDAO.inCooperReject(coopApprVO);
		officialCooperationListDAO.upCooperRejApproval(coopApprVO);
		officialCooperationListDAO.upCooperRejApprovalReq(coopApprVO);
	}
	
	@Override
	public List getResultList(SearchVO searchVO) throws Exception{
		return officialCooperationListDAO.getResultList(searchVO);
	}
}
