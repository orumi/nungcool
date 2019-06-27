package tems.com.exam.req.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.exam.req.model.CondDetailVO;
import tems.com.exam.req.model.ItemMethodVO;
import tems.com.exam.req.model.ReqPriceVO;
import tems.com.exam.req.model.ReqResultVO;
import tems.com.exam.req.model.ReqSmpListVO;
import tems.com.exam.req.model.RequestItemDetailVO;
import tems.com.exam.req.model.ReqDetailVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("ReqDetailDAO")
public class ReqDetailDAO extends EgovComAbstractDAO  {
		
	public List<?> getReqItemList(RequestItemDetailVO reqItemDetailVO){
        return list("ReqDetailDAO.selReqDetail", reqItemDetailVO);
   }
	
	public ReqDetailVO getReqDetail(String reqid){
		return (ReqDetailVO) select("ReqDetailDAO.selReqDetail",reqid);
	}
	
	public void delRequest(String reqid){
		delete("ReqDetailDAO.delSample",reqid);
		delete("ReqDetailDAO.delResult",reqid);
		delete("ReqDetailDAO.delReport",reqid);
		delete("ReqDetailDAO.delRequest",reqid);
	}
	
	public void upReqRemark(ReqDetailVO reqDetailVO){
		update("ReqDetailDAO.upReqRemark",reqDetailVO);
	}
	
	public List<?> getReqSmpList(String reqid){
        return list("ReqDetailDAO.getReqSmpList", reqid);
   }
	
	public List<?> getReqResultList(ReqSmpListVO reqSmpListVO){
        return list("ReqDetailDAO.getReqResultList", reqSmpListVO);
   }
	
	public void delRequestResult(ReqResultVO reqResultVO){
		delete("ReqDetailDAO.delReqResult",reqResultVO);
	}
	
	public void delRequestResultAll(ReqResultVO reqResultVO){
		delete("ReqDetailDAO.delReqResultAll",reqResultVO);
	}
	
	public List<?> getItemList(String itemnm){
        return list("ReqDetailDAO.getItemList", itemnm);
   }
	
	public void addResultItem(ReqResultVO reqResultVO){
		insert("ReqDetailDAO.addResultItemParent",reqResultVO);
		insert("ReqDetailDAO.addResultItem",reqResultVO);
	}
	
	public void addResultItemAll(ReqResultVO reqResultVO){
		insert("ReqDetailDAO.addResultItemParentAll",reqResultVO);
		insert("ReqDetailDAO.addResultItemAll",reqResultVO);
	}
	
	public ItemMethodVO getItemMethodDetail(ReqResultVO reqResultVO){
		return (ItemMethodVO) select("ReqDetailDAO.getItemMethodDetail",reqResultVO);
	}
	
	public CondDetailVO getItemConditionDetail(ReqResultVO reqResultVO){
		return (CondDetailVO) select("ReqDetailDAO.getItemConditionDetail",reqResultVO);
	}
	
	public void upResultDetail(ReqResultVO reqResultVO){
		update("ReqDetailDAO.upResultDetail",reqResultVO);
	}
	
	public void inResultAssign(ReqResultVO reqResultVO){
		update("ReqDetailDAO.inResultAssign",reqResultVO);
	}
	
	public void inResultAssignAll(ReqResultVO reqResultVO){
		update("ReqDetailDAO.inResultAssignAll",reqResultVO);
	}
	
	public void delResultAssign(ReqResultVO reqResultVO){
		update("ReqDetailDAO.delResultAssign",reqResultVO);
	}
	
	public void delResultAssignAll(ReqResultVO reqResultVO){
		update("ReqDetailDAO.delResultAssignAll",reqResultVO);
	}
	
	public void upResultDetailAll(ReqResultVO reqResultVO){
		update("ReqDetailDAO.upResultDetailAll",reqResultVO);
	}
	
	public ReqPriceVO selReqPrice(ReqSmpListVO reqSmpListVO){
		return (ReqPriceVO) select("ReqDetailDAO.selReqPrice",reqSmpListVO);
	}
	
	public String calPrice(ReqResultVO reqResultVO){
		return (String) select("ReqDetailDAO.calPrice",reqResultVO);
	}
	
	public void upReqPrice(ReqPriceVO reqPriceVO){
		update("ReqDetailDAO.upReqPrice",reqPriceVO);
	}
	
	public List<?> selReqAttach(String reqid){
		return list("ReqDetailDAO.selReqAttach", reqid);
	}

}
