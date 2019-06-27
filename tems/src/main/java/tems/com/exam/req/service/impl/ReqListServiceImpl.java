package tems.com.exam.req.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.req.service.ReqListService;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;

@Service("ReqListService")
public class ReqListServiceImpl implements ReqListService {

    @Resource(name = "ReqListDAO")
    private ReqListDAO ReqListDAO;
	
     @Override
     public List<?> getReqList(SearchVO requestSearchVO) throws Exception {
    	 return ReqListDAO.getReqList(requestSearchVO);
     }
     
     @Override
     public void edtReqList(RequestListVO requestListVO) throws Exception {
    	 ReqListDAO.edtReqList(requestListVO);
     }
     
     @Override
     public List<?> getApprList(String adminid) throws Exception {
    	 return ReqListDAO.getApprList(adminid);
     }
     
     @Override
     public List<?> getApprDetail(String apprlineid) throws Exception {
    	 return ReqListDAO.getApprDetail(apprlineid);
     }
     
     @Override
     public void upReqState(RequestListVO requestListVO) throws Exception {
    	 ReqListDAO.upReqState(requestListVO);
     }
     
     @Override
     public int selNextApprLine(String adminid) throws Exception {
    	 return ReqListDAO.selNextApprLine(adminid);
     }
     
     @Override
     public void edtApprLine(ApprDetailVO apprDetailVO) throws Exception {
    	 ReqListDAO.edtApprLine(apprDetailVO);
     }
     
     @Override
     public void delApprConf(ApprDetailVO apprDetailVO) throws Exception {
    	 ReqListDAO.delApprConf(apprDetailVO);
     }
     
     @Override
     public void inApprConf(ApprDetailVO apprDetailVO) throws Exception {
    	 ReqListDAO.inApprConf(apprDetailVO);
     }
     
     @Override
     public void upApprState(ApprDetailVO apprDetailVO) throws Exception {
    	 ReqListDAO.upApprState(apprDetailVO);
     }
     
     @Override
     public List<?> getSelApprLineUp(String seqid) throws Exception {
    	 return ReqListDAO.getSelApprLineUp(seqid);
     }
     
     @Override
     public ReqConfirmListVO getReject(String reqid) throws Exception {
    	 return ReqListDAO.getReject(reqid);
     }
     
     @Override
     public List<?> selRequestHistory(SearchVO searchVO) throws Exception {
    	 return ReqListDAO.selRequestHistory(searchVO);
     }
     
     
     
}
