package tems.com.exam.req.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.ApprListVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.req.model.RequestSearchVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("ReqListDAO")
public class ReqListDAO extends EgovComAbstractDAO  {
		
	public List<?> getReqList(RequestSearchVO requestSearchVO){
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
	
	public void inApprConf(ApprDetailVO apprDetailVO){
		insert("RequestDAO.inApprConf",apprDetailVO);
	}
	
}
