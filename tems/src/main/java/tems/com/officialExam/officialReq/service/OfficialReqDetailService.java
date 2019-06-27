package tems.com.officialExam.officialReq.service;

import tems.com.exam.req.model.*;

import java.util.List;

public interface OfficialReqDetailService {
	
	List getReqItemList(RequestItemDetailVO reqItemDetailVO) throws Exception;

	ReqDetailVO getReqDetail(String reqid) throws Exception;
	
	void delRequest(String reqid) throws Exception;
	
	void upReqRemark(ReqDetailVO reqDetailVO) throws Exception;
	
	List getReqSmpList(String reqid) throws Exception;
	
	List getReqResultList(ReqSmpListVO reqSmpListVO) throws Exception;
	
	void delRequestResult(ReqResultVO reqResultVO) throws Exception;

	void delRequestResultAll(ReqResultVO reqResultVO) throws Exception;
	
	List getItemList(String itemnm) throws Exception;
	
	void addResultItem(ReqResultVO reqResultVO) throws Exception;
	
	void addResultItemAll(ReqResultVO reqResultVO) throws Exception;
	
	ItemMethodVO getItemMethodDetail(ReqResultVO reqResultVO) throws Exception;
	
	CondDetailVO getItemConditionDetail(ReqResultVO reqResultVO) throws Exception;
	
	void upResultDetail(ReqResultVO reqResultVO) throws Exception;
	
	void upResultDetailAll(ReqResultVO reqResultVO) throws Exception;
	
	ReqPriceVO selReqPrice(ReqSmpListVO reqSmpListVO) throws Exception;
	
	String calPrice(ReqResultVO reqResultVO) throws Exception;
	
	void upReqPrice(ReqPriceVO reqPriceVO) throws Exception;

	List selReqAttach(String reqid) throws Exception;
}
