package tems.com.officialExam.officialReq.service.impl;

import org.springframework.stereotype.Service;
import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;
import tems.com.officialExam.officialReq.service.OfficialReqService;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by owner1120 on 2016-03-07.
 */

@Service("officialReqService")
public class OfficialReqImpl implements OfficialReqService {

    @Resource(name = "officialReqDAO")
    OfficialReqDAO officialReqDAO;

    @Override
    public List<?> getReqList(SearchVO requestSearchVO) throws Exception {
        return officialReqDAO.getReqList(requestSearchVO);
    }

    @Override
    public void edtReqList(RequestListVO requestListVO) throws Exception {
        officialReqDAO.edtReqList(requestListVO);
    }

    @Override
    public List<?> getApprList(String adminid) throws Exception {
        return officialReqDAO.getApprList(adminid);
    }

    @Override
    public List<?> getApprDetail(String apprlineid) throws Exception {
        return officialReqDAO.getApprDetail(apprlineid);
    }

    @Override
    public void upReqState(RequestListVO requestListVO) throws Exception {
        officialReqDAO.upReqState(requestListVO);
    }

    @Override
    public int selNextApprLine(String adminid) throws Exception {
        return officialReqDAO.selNextApprLine(adminid);
    }

    @Override
    public void edtApprLine(ApprDetailVO apprDetailVO) throws Exception {
        officialReqDAO.edtApprLine(apprDetailVO);
    }

    @Override
    public void delApprConf(ApprDetailVO apprDetailVO) throws Exception {
        officialReqDAO.delApprConf(apprDetailVO);
    }

    @Override
    public void inApprConf(ApprDetailVO apprDetailVO) throws Exception {
        officialReqDAO.inApprConf(apprDetailVO);
    }

    @Override
    public void upApprState(ApprDetailVO apprDetailVO) throws Exception {
        officialReqDAO.upApprState(apprDetailVO);
    }

    @Override
    public List<?> getSelApprLineUp(String seqid) throws Exception {
        return officialReqDAO.getSelApprLineUp(seqid);
    }

    @Override
    public ReqConfirmListVO getReject(String reqid) throws Exception {
        return officialReqDAO.getReject(reqid);
    }

    @Override
    public List<?> selRequestHistory(SearchVO searchVO) throws Exception {
        return officialReqDAO.selRequestHistory(searchVO);
    }

}
