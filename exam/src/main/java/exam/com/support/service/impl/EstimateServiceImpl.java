package exam.com.support.service.impl;


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
import exam.com.support.service.EstimateService;

/**
 * Created by KMC
 */
@Service("EstimateService")
public class EstimateServiceImpl implements EstimateService  {

	 
    @Resource(name = "EstimateDAO")
    private EstimateDAO estimateDAO;
    
    
	@Override
	public List getMemberInfo(LoginUserVO loginUser) throws Exception {
		
		return estimateDAO.getMemberInfo(loginUser);
		
	}

	@Override
	public String getRequestNextVal(){
		return estimateDAO.getRequestNextVal();
	}
	
	
	@Override
	public List getRequest(RequestVO requestVO) throws Exception {
		return estimateDAO.getRequest(requestVO);
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
			estimateDAO.setRequest(requestVO);
			estimateDAO.setReport(requestVO);
		} else {
			/* update */
			estimateDAO.updateRequest(requestVO);
			estimateDAO.updateReport(requestVO); 
		}
		
		return getRequest(requestVO);
		
	}


	
	@Override
	public List selectClass(){
		return estimateDAO.selectClass();
	}
	
	@Override
	public List selectMaster(ClassVO classVO){
		return estimateDAO.selectMaster(classVO);
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
		
		estimateDAO.insertSample(sampleVO);
		estimateDAO.insertResult(sampleVO);
		
		return sampleVO;
		
	}	
	@Override
	public String selectNextSmpid(String reqid){
		return estimateDAO.getNextSmpid(reqid);
	}
	
	@Override
	public List selectSample(SampleVO sampleVO) {
		return estimateDAO.selectSample(sampleVO);
	}
	@Override
	public void insertSample(SampleVO sampleVO){
		estimateDAO.insertSample(sampleVO);
	}
	@Override
	public void updateSample(SampleVO sampleVO){
		estimateDAO.updateSample(sampleVO);
	}
	
	/* about result */
	@Override
	public List selectResult(SampleVO sampleVO){
		return estimateDAO.selectResult(sampleVO);
	}
	@Override
	public void insertResult(SampleVO sampleVO){
		estimateDAO.insertResult(sampleVO);
	}
	
	
	@Override
	public List deleteSample(SampleVO sampleVO){
		return estimateDAO.deleteSample(sampleVO);
	}

	@Override
	public void copySample(HashMap<String, String> map){
		estimateDAO.copySample(map);
	}
	
	@Override
	public void deleteRequestSample(String reqid) {
		estimateDAO.deleteRequestSample(reqid);
	}
	
	
	
	
	@Override
	public List selectItems(HashMap<String, String> map) throws Exception {
		return estimateDAO.selectItems(map);
	}

	@Override
	public void insertResultItemP(HashMap<String, String> map) throws Exception {
		estimateDAO.insertResultItemP(map);
	}
	
	@Override
	public void insertResultItem(TreeVO treeVO) throws Exception {
		estimateDAO.insertResultItem(treeVO);
	}
	
	/* update items */
	@Override
	public void updateItems(ResultVO resultVO){
		estimateDAO.updateItems(resultVO);
	}
	
	/* insert0 items copy */
	@Override
	public void updateItemsCopyParent(HashMap<String, String> map){
		estimateDAO.updateItemsCopyParent(map);
	}
	@Override
	public void insertItemsCopy(HashMap<String, String> map){
		estimateDAO.insertItemsCopy(map);
	}
	
	/* update items copy*/
	@Override
	public void updateItemsCopy(HashMap<String, String> map){
		estimateDAO.updateItemsCopy(map);
	}
	
    /* delete items */
	@Override
	public void deleteItems(HashMap<String, String> map){
		estimateDAO.deleteItems(map);
	}
	
	/*delete itemscopy*/
	@Override
	public void deleteItemsCopy(HashMap<String, String> map){
		estimateDAO.deleteItemsCopy(map);
	}
	
	
	
	
	
	
	/* about templet */
	@Override
	public String selectNextTempletId(){
		return estimateDAO.selectNextTempletId();
	}
	
	@Override
	public List selectTemplet(HashMap<String, String> map){
		return estimateDAO.selectTemplet(map);
	}
	
	@Override
	public void insertTemplet(TempletVO templetVO){
		estimateDAO.insertTemplet(templetVO);
		
	}
	
	@Override
	public void deleteTemplet(TempletVO templetVO){
		estimateDAO.deleteTemplet(templetVO);
		
	}
	
	@Override
	public void adjustTemplet(HashMap<String, String> map){
		estimateDAO.adjustTemplet(map);
		
	}
	
	@Override
	public void deleteRequest(String reqid){
		estimateDAO.deleteRequest(reqid);
		
	}
	
	
	@Override
	public void insertAssignSmple(SampleVO sampleVO){
		estimateDAO.insertAssignSmple(sampleVO);
	}

	@Override
	public void deleteAssignSmple(SampleVO sampleVO){
		estimateDAO.deleteAssignSmple(sampleVO);
	}
	
	@Override
	public void insertAssign(SampleVO sampleVO){
		estimateDAO.insertAssign(sampleVO);
	}

	@Override
	public void deleteAssign(SampleVO sampleVO){
		estimateDAO.deleteAssign(sampleVO);
	}
	
	
	/*about price & state*/
	@Override
	public String procCalPrice(SampleVO sampleVO){
		return estimateDAO.procCalPrice(sampleVO);
	}
	@Override
	public List selectPrice(SampleVO sampleVO){
		return estimateDAO.selectPrice(sampleVO);
	}
	@Override
	public void updateState(PriceVO priceVO){
		estimateDAO.updateState(priceVO);
	}
	
	@Override
	public List selectCheckMethod(SampleVO sampleVO){
		return estimateDAO.selectCheckMethod(sampleVO);
	}
	
	@Override
	public List selectCheckCondition(SampleVO sampleVO){
		return estimateDAO.selectCheckCondition(sampleVO);
	}
	 
	
	/* about attach */
	@Override
	public List selectAttach(String reqid){
		return estimateDAO.selectAttach(reqid);
	}
	@Override
	public void insertAttach(RequestAttachVO attachVO){
		estimateDAO.insertAttach(attachVO);
	}
	@Override
	public void deleteAttach(HashMap<String, String> map){
		estimateDAO.deleteAttach(map);
	}
	
	
	/* about dulicate */
	@Override
	public List selectDuplicate(HashMap<String, Object> map){
		return estimateDAO.selectDuplicate(map);
	}
	
	
	/* except */

	/*	except heating selectHeadting */
	@Override
	public List<?> selectHeating(){
		return estimateDAO.selectHeating();
	}
	
	
	/* except exceptDetail 중복확인 */
	@Override
	public List<?> selectExceptItems(HashMap<String, Object> map){
		return estimateDAO.selectExceptItems(map);
	}
	
	@Override
	public List<?> selectItemGroup() {
		return estimateDAO.selectItemGroup();
	}
	
	/* except deleteExcept deleteItem 중복제거 중복삭제   */
	@Override
	public void deleteExcept(HashMap<String, String> map){
		estimateDAO.deleteExcept(map);
	}
	

}
