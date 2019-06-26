package exam.com.req.service.impl;


import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.exam.req.service.ReqListService;
import tems.com.exam.req.service.impl.ReqDetailDAO;
import exam.com.main.model.LoginUserVO;
import exam.com.req.model.ClassVO;
import exam.com.req.model.PriceVO;
import exam.com.req.model.RequestAttachVO;
import exam.com.req.model.RequestVO;
import exam.com.req.model.ResultVO;
import exam.com.req.model.SampleVO;
import exam.com.req.model.TempletVO;
import exam.com.req.model.TreeVO;
import exam.com.req.service.RequestService;

/**
 * Created by KMC
 */
@Service("RequestService")
public class RequestServiceImpl implements RequestService  {

	 
    @Resource(name = "RequestDAO")
    private RequestDAO requestDAO;
    
    
	@Override
	public List getMemberInfo(LoginUserVO loginUser) throws Exception {
		
		return requestDAO.getMemberInfo(loginUser);
		
	}

	@Override
	public String getRequestNextVal(){
		return requestDAO.getRequestNextVal();
	}
	
	
	@Override
	public List getRequest(RequestVO requestVO) throws Exception {
		return requestDAO.getRequest(requestVO);
	}
	
	
	@Override
	public List setRequest(RequestVO requestVO) throws Exception {
		
		// reqid is null
		
		String reqid = requestVO.getReqid();
		
		if (reqid == null || "".equals(reqid)){
			/* insert */
			// get reqid;
			String nextReqId = getRequestNextVal();
			requestVO.setReqid(String.valueOf(nextReqId));
			requestDAO.setRequest(requestVO);
			requestDAO.setReport(requestVO);
		} else {
			/* update */
			requestDAO.updateRequest(requestVO);
			requestDAO.updateReport(requestVO); 
		}
		
		return getRequest(requestVO);
		
	}


	
	@Override
	public List selectClass(){
		return requestDAO.selectClass();
	}
	
	@Override
	public List selectMaster(ClassVO classVO){
		return requestDAO.selectMaster(classVO);
	}
	
	
	
	
	/* about sample */
	
	/*
	 *   처리과정
	 * 1. 시료정보 저장
	 * 	1.1 시료번호 가져오기
	 *  1.2 시료정보 만들기
	 *  1.3 시료정보 저장
	 * 
	 * 2.항목정보 저장
	 *  
	 */
	
	@Override
	public SampleVO adjustSample(SampleVO sampleVO){
		
		String nextSmpId = selectNextSmpid(sampleVO.getReqid());
		sampleVO.setSmpid(nextSmpId);
		
		requestDAO.insertSample(sampleVO);
		requestDAO.insertResult(sampleVO);
		
		return sampleVO;
		
	}	
	@Override
	public String selectNextSmpid(String reqid){
		return requestDAO.getNextSmpid(reqid);
	}
	
	@Override
	public List selectSample(SampleVO sampleVO) {
		return requestDAO.selectSample(sampleVO);
	}
	@Override
	public void insertSample(SampleVO sampleVO){
		requestDAO.insertSample(sampleVO);
	}
	@Override
	public void updateSample(SampleVO sampleVO){
		requestDAO.updateSample(sampleVO);
	}
	
	/* about result */
	@Override
	public List selectResult(SampleVO sampleVO){
		return requestDAO.selectResult(sampleVO);
	}
	@Override
	public void insertResult(SampleVO sampleVO){
		requestDAO.insertResult(sampleVO);
	}
	
	
	@Override
	public List deleteSample(SampleVO sampleVO){
		return requestDAO.deleteSample(sampleVO);
	}

	@Override
	public void copySample(HashMap<String, String> map){
		requestDAO.copySample(map);
	}
	
	
	
	
	@Override
	public List selectItems(HashMap<String, String> map) throws Exception {
		return requestDAO.selectItems(map);
	}

	@Override
	public void insertResultItemP(HashMap<String, String> map) throws Exception {
		requestDAO.insertResultItemP(map);
	}
	
	@Override
	public void insertResultItem(TreeVO treeVO) throws Exception {
		requestDAO.insertResultItem(treeVO);
	}
	
	/* update items */
	@Override
	public void updateItems(ResultVO resultVO){
		requestDAO.updateItems(resultVO);
	}
	
	/* insert0 items copy */
	@Override
	public void updateItemsCopyParent(HashMap<String, String> map){
		requestDAO.updateItemsCopyParent(map);
	}
	@Override
	public void insertItemsCopy(HashMap<String, String> map){
		requestDAO.insertItemsCopy(map);
	}
	
	/* update items copy*/
	@Override
	public void updateItemsCopy(HashMap<String, String> map){
		requestDAO.updateItemsCopy(map);
	}
	
    /* delete items */
	@Override
	public void deleteItems(HashMap<String, String> map){
		requestDAO.deleteItems(map);
	}
	
	/*delete itemscopy*/
	@Override
	public void deleteItemsCopy(HashMap<String, String> map){
		requestDAO.deleteItemsCopy(map);
	}
	
	
	
	
	
	
	/* about templet */
	@Override
	public String selectNextTempletId(){
		return requestDAO.selectNextTempletId();
	}
	
	@Override
	public List selectTemplet(HashMap<String, String> map){
		return requestDAO.selectTemplet(map);
	}
	
	@Override
	public void insertTemplet(TempletVO templetVO){
		requestDAO.insertTemplet(templetVO);
		
	}
	
	@Override
	public void deleteTemplet(TempletVO templetVO){
		requestDAO.deleteTemplet(templetVO);
		
	}
	
	@Override
	public void adjustTemplet(HashMap<String, String> map){
		requestDAO.adjustTemplet(map);
		
	}
	
	@Override
	public void deleteRequest(String reqid){
		requestDAO.deleteRequest(reqid);
		
	}
	
	
	@Override
	public void insertAssignSmple(SampleVO sampleVO){
		requestDAO.insertAssignSmple(sampleVO);
	}

	@Override
	public void deleteAssignSmple(SampleVO sampleVO){
		requestDAO.deleteAssignSmple(sampleVO);
	}
	
	@Override
	public void insertAssign(SampleVO sampleVO){
		requestDAO.insertAssign(sampleVO);
	}

	@Override
	public void deleteAssign(SampleVO sampleVO){
		requestDAO.deleteAssign(sampleVO);
	}
	
	
	/*about price & state*/
	@Override
	public String procCalPrice(SampleVO sampleVO){
		return requestDAO.procCalPrice(sampleVO);
	}
	@Override
	public List selectPrice(SampleVO sampleVO){
		return requestDAO.selectPrice(sampleVO);
	}
	@Override
	public void updateState(PriceVO priceVO){
		requestDAO.updateState(priceVO);
	}
	
	@Override
	public List selectCheckMethod(SampleVO sampleVO){
		return requestDAO.selectCheckMethod(sampleVO);
	}
	
	@Override
	public List selectCheckCondition(SampleVO sampleVO){
		return requestDAO.selectCheckCondition(sampleVO);
	}
	 
	
	/* about attach */
	@Override
	public List selectAttach(String reqid){
		return requestDAO.selectAttach(reqid);
	}
	@Override
	public void insertAttach(RequestAttachVO attachVO){
		requestDAO.insertAttach(attachVO);
	}
	@Override
	public void deleteAttach(HashMap<String, String> map){
		requestDAO.deleteAttach(map);
	}
	
	
	/* about dulicate */
	@Override
	public List selectDuplicate(HashMap<String, Object> map){
		return requestDAO.selectDuplicate(map);
	}
	
	
	/* except */

	/*	except heating selectHeadting */
	@Override
	public List<?> selectHeating(){
		return requestDAO.selectHeating();
	}
	
	
	/* except exceptDetail 중복확인 */
	@Override
	public List<?> selectExceptItems(HashMap<String, Object> map){
		return requestDAO.selectExceptItems(map);
	}
	
	@Override
	public List<?> selectItemGroup() {
		return requestDAO.selectItemGroup();
	}

	@Override
	public RequestVO selectEnComAddr(RequestVO vo) throws Exception {
		return requestDAO.selectEnComAddr(vo);
	}

	/* except deleteExcept deleteItem 중복제거 중복삭제   */
	@Override
	public void deleteExcept(HashMap<String, String> map){
		requestDAO.deleteExcept(map);
	}
	

}
