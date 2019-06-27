package tems.com.officialExam.officialReq.service;

import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;

import java.util.List;

/**
 * Created by owner1120 on 2015-12-10.
 */
public interface OfficialReqService {

    List getReqList(SearchVO requestSearchVO) throws Exception;

    void edtReqList(RequestListVO requestListVO) throws Exception;

    List getApprList(String adminid) throws Exception;

    List getApprDetail(String apprlineid) throws Exception;

    void upReqState(RequestListVO requestListVO) throws Exception;

    int selNextApprLine(String adminid) throws Exception;

    void edtApprLine(ApprDetailVO apprDetailVO) throws Exception;

    void delApprConf(ApprDetailVO apprDetailVO) throws Exception;

    void inApprConf(ApprDetailVO apprDetailVO) throws Exception;

    void upApprState(ApprDetailVO apprDetailVO) throws Exception;

    List getSelApprLineUp(String seqid) throws Exception;

    ReqConfirmListVO getReject(String seqid) throws Exception;

    List selRequestHistory(SearchVO searchVO) throws Exception;

}
