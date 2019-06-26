package tems.com.exam.req.service;

import java.util.List;

import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.ApprListVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.req.model.RequestSearchVO;

public interface ReqListService {
	
	List getReqList(RequestSearchVO requestSearchVO) throws Exception;
	
	void edtReqList(RequestListVO requestListVO) throws Exception;
	
	List getApprList(String adminid) throws Exception;
	
	List getApprDetail(String apprlineid) throws Exception;
	
	void upReqState(RequestListVO requestListVO) throws Exception;
	
	int selNextApprLine(String adminid) throws Exception;
	
	void edtApprLine(ApprDetailVO apprDetailVO) throws Exception;
	
	void inApprConf(ApprDetailVO apprDetailVO) throws Exception;
}
