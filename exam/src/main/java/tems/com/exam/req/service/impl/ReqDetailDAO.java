package tems.com.exam.req.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.exam.req.model.RequestItemDetailVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("ReqDetailDAO")
public class ReqDetailDAO extends EgovComAbstractDAO  {
		
	public List<?> getReqItemList(RequestItemDetailVO reqItemDetailVO){
        return list("RequestDAO.selReqDetail", reqItemDetailVO);
   }

}
