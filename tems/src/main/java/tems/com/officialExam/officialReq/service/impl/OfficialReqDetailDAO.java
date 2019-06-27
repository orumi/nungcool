package tems.com.officialExam.officialReq.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;
import tems.com.exam.req.model.*;

import java.util.List;

/**
 * Created by owner1120 on 2016-03-07.
 */
@Repository("officialReqDetailDAO")
public class OfficialReqDetailDAO extends EgovComAbstractDAO {


    public List<?> getReqItemList(RequestItemDetailVO reqItemDetailVO){
        return list("officialReqDetailDAO.selReqDetail", reqItemDetailVO);
    }

    public ReqDetailVO getReqDetail(String reqid){
        return (ReqDetailVO) select("officialReqDetailDAO.selReqDetail",reqid);
    }

    public void delRequest(String reqid){
        delete("officialReqDetailDAO.delSample",reqid);
        delete("officialReqDetailDAO.delResult",reqid);
        delete("officialReqDetailDAO.delReport",reqid);
        delete("officialReqDetailDAO.delRequest",reqid);
    }

    public void upReqRemark(ReqDetailVO reqDetailVO){
        update("officialReqDetailDAO.upReqRemark",reqDetailVO);
    }

    public List<?> getReqSmpList(String reqid){
        return list("officialReqDetailDAO.getReqSmpList", reqid);
    }

    public List<?> getReqResultList(ReqSmpListVO reqSmpListVO){
        return list("officialReqDetailDAO.getReqResultList", reqSmpListVO);
    }

    public void delRequestResult(ReqResultVO reqResultVO){
        delete("officialReqDetailDAO.delReqResult",reqResultVO);
    }

    public void delRequestResultAll(ReqResultVO reqResultVO){
        delete("officialReqDetailDAO.delReqResultAll",reqResultVO);
    }

    public List<?> getItemList(String itemnm){
        return list("officialReqDetailDAO.getItemList", itemnm);
    }

    public void addResultItem(ReqResultVO reqResultVO){
        insert("officialReqDetailDAO.addResultItemParent",reqResultVO);
        insert("officialReqDetailDAO.addResultItem",reqResultVO);
    }

    public void addResultItemAll(ReqResultVO reqResultVO){
        insert("officialReqDetailDAO.addResultItemParentAll",reqResultVO);
        insert("officialReqDetailDAO.addResultItemAll",reqResultVO);
    }

    public ItemMethodVO getItemMethodDetail(ReqResultVO reqResultVO){
        return (ItemMethodVO) select("officialReqDetailDAO.getItemMethodDetail",reqResultVO);
    }

    public CondDetailVO getItemConditionDetail(ReqResultVO reqResultVO){
        return (CondDetailVO) select("officialReqDetailDAO.getItemConditionDetail",reqResultVO);
    }

    public void upResultDetail(ReqResultVO reqResultVO){
        update("officialReqDetailDAO.upResultDetail",reqResultVO);
    }

    public void inResultAssign(ReqResultVO reqResultVO){
        update("officialReqDetailDAO.inResultAssign",reqResultVO);
    }

    public void inResultAssignAll(ReqResultVO reqResultVO){
        update("officialReqDetailDAO.inResultAssignAll",reqResultVO);
    }

    public void delResultAssign(ReqResultVO reqResultVO){
        update("officialReqDetailDAO.delResultAssign",reqResultVO);
    }

    public void delResultAssignAll(ReqResultVO reqResultVO){
        update("officialReqDetailDAO.delResultAssignAll",reqResultVO);
    }

    public void upResultDetailAll(ReqResultVO reqResultVO){
        update("officialReqDetailDAO.upResultDetailAll",reqResultVO);
    }

    public ReqPriceVO selReqPrice(ReqSmpListVO reqSmpListVO){
        return (ReqPriceVO) select("officialReqDetailDAO.selReqPrice",reqSmpListVO);
    }

    public String calPrice(ReqResultVO reqResultVO){
        return (String) select("officialReqDetailDAO.calPrice",reqResultVO);
    }

    public void upReqPrice(ReqPriceVO reqPriceVO){
        update("officialReqDetailDAO.upReqPrice",reqPriceVO);
    }

    public List<?> selReqAttach(String reqid){
        return list("officialReqDetailDAO.selReqAttach", reqid);
    }

}
