package tems.com.exam.requestConfirm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.common.model.SearchVO;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;
import tems.com.exam.requestConfirm.service.RcListService;

@Service("RcListService")
public class RcListServiceImpl  implements RcListService {
	
	 @Resource(name = "RcListDAO")
	    private RcListDAO RcListDAO;
		
	     @Override
	     public List<?> getConfirmList(SearchVO searchVO) throws Exception {
	    	 return RcListDAO.getConfirmList(searchVO);
	     }
	
	     @Override
	     public void upApproval(ReqConfirmListVO reqConfirmListVO) throws Exception {
	    	 RcListDAO.upApproval(reqConfirmListVO);
	     }
	     
	     @Override
	     public void upReject(ReqConfirmListVO reqConfirmListVO) throws Exception {
	    	 RcListDAO.upReject(reqConfirmListVO);
	     }
	
}
