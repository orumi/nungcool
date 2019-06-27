package tems.com.exam.requestConfirm.service;

import java.util.List;

import tems.com.common.model.SearchVO;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;

public interface RcListService {
	
	List getConfirmList(SearchVO searchVO) throws Exception;
	
	void upApproval(ReqConfirmListVO reqConfirmListVO) throws Exception;
	
	void upReject(ReqConfirmListVO reqConfirmListVO) throws Exception;
}
