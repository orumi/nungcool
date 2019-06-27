package tems.com.exam.requestConfirm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.model.SearchVO;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("RcListDAO")
public class RcListDAO extends EgovComAbstractDAO {
	
	public List<?> getConfirmList(SearchVO searchVO){
        return list("RcListDAO.getConfirmList", searchVO);
   }
	
	public void upApproval(ReqConfirmListVO reqConfirmListVO){
        update("RcListDAO.upApproval", reqConfirmListVO);
        update("RcListDAO.upApprovalNext", reqConfirmListVO);
        update("RcListDAO.upApprovalReq", reqConfirmListVO);
        update("RcListDAO.upReportState", reqConfirmListVO);
   }
	
	public void upReject(ReqConfirmListVO reqConfirmListVO){
		insert("RcListDAO.inReject", reqConfirmListVO);
		update("RcListDAO.upApprovalReject", reqConfirmListVO);
        update("RcListDAO.upApprovalReq", reqConfirmListVO);
   }
}
