package tems.com.exam.req.service;

import java.util.List;

import tems.com.exam.req.model.RequestItemDetailVO;

public interface ReqDetailService {
	
	List getReqItemList(RequestItemDetailVO reqItemDetailVO) throws Exception;
	
}
