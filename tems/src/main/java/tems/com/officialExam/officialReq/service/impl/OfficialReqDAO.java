package tems.com.officialExam.officialReq.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;
import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;

import java.util.List;

/**
 * Created by owner1120 on 2015-12-10.
 */

@Repository("officialReqDAO")
public class OfficialReqDAO extends EgovComAbstractDAO {

    public List<?> getReqList(SearchVO requestSearchVO){
        return list("officialReqDAO.selReqList", requestSearchVO);
    }

    public void edtReqList(RequestListVO requestListVO){
        update("officialReqDAO.edtReqList",requestListVO);
    }

    public List<?> getApprList(String adminid){
        return list("officialReqDAO.selApprList", adminid);
    }

    public List<?> getApprDetail(String apprlineid){
        return list("officialReqDAO.selApprDetail", apprlineid);
    }

    public void upReqState(RequestListVO requestListVO){
        update("officialReqDAO.upReqState",requestListVO);
        update("officialReqDAO.upResultState",requestListVO);
        update("officialReqDAO.upReportState",requestListVO);
    }

    public int selNextApprLine(String adminid){
        return (Integer) select("officialReqDAO.selNextApprLine", adminid);
    }

    public void edtApprLine(ApprDetailVO apprDetailVO){
        update("officialReqDAO.edtApprLine",apprDetailVO);
    }

    public void delApprConf(ApprDetailVO apprDetailVO){
        delete("officialReqDAO.delApprConf",apprDetailVO);
    }

    public void inApprConf(ApprDetailVO apprDetailVO){
        insert("officialReqDAO.inApprConf",apprDetailVO);
    }

    public void upApprState(ApprDetailVO apprDetailVO){
        update("officialReqDAO.upApprState",apprDetailVO);
    }

    public List<?> getSelApprLineUp(String seqid){
        return list("officialReqDAO.selApprLineUp", seqid);
    }

    public ReqConfirmListVO getReject(String reqid){
        return (ReqConfirmListVO)select("officialReqDAO.selReject",reqid);
    }

    public List<?> selRequestHistory(SearchVO searchVO){
        return list("officialReqDAO.selRequestHistory", searchVO);
    }

}
