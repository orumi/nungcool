package tems.com.exam.req.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.ApprListVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("ReqListDAO")
public class ReqListDAO extends EgovComAbstractDAO  {
		
	public List<?> getReqList(SearchVO requestSearchVO){
        return list("RequestDAO.selReqList", requestSearchVO);
   }
	
	public void edtReqList(RequestListVO requestListVO){
		update("RequestDAO.edtReqList",requestListVO);
	}
	
	public List<?> getApprList(String adminid){
        return list("RequestDAO.selApprList", adminid);
   }
	
	public List<?> getApprDetail(String apprlineid){
        return list("RequestDAO.selApprDetail", apprlineid);
   }
	
	public void upReqState(RequestListVO requestListVO){
		update("RequestDAO.upReqState",requestListVO);
		update("RequestDAO.upResultState",requestListVO);
		update("RequestDAO.upReportState",requestListVO);
	}
	
	public int selNextApprLine(String adminid){
		return (Integer) select("RequestDAO.selNextApprLine", adminid);
	}
	
	public void edtApprLine(ApprDetailVO apprDetailVO){
		update("RequestDAO.edtApprLine",apprDetailVO);
	}
	
	public void delApprConf(ApprDetailVO apprDetailVO){
		delete("RequestDAO.delApprConf",apprDetailVO);
	}
	
	public void inApprConf(ApprDetailVO apprDetailVO){
		insert("RequestDAO.inApprConf",apprDetailVO);
	}
	
	public void upApprState(ApprDetailVO apprDetailVO){
		update("RequestDAO.upApprState",apprDetailVO);
	}
	
	public List<?> getSelApprLineUp(String seqid){
        return list("RequestDAO.selApprLineUp", seqid);
   }
	
	public ReqConfirmListVO getReject(String reqid){
		return (ReqConfirmListVO)select("RequestDAO.selReject",reqid);
	}
	
	public List<?> selRequestHistory(SearchVO searchVO){
		return list("RequestDAO.selRequestHistory", searchVO);
	}
	
}
