package exam.com.support.service;


import java.util.HashMap;
import java.util.List;

import exam.com.main.model.LoginUserVO;
import exam.com.req.model.ClassVO;
import exam.com.req.model.PriceVO;
import exam.com.req.model.RequestAttachVO;
import exam.com.req.model.RequestVO;
import exam.com.req.model.ResultVO;
import exam.com.req.model.SampleVO;
import exam.com.req.model.TempletVO;
import exam.com.req.model.TreeVO;

/**
 * Created by KMC
 */

public interface EstimateService {
 
	/*성적서 기본정보*/
	public List getMemberInfo(LoginUserVO loginUser) throws Exception;

	public String getRequestNextVal() throws Exception;
	
	public List getRequest(RequestVO requestVO) throws Exception;
	
	/*기본정보 저장*/
	public List setRequest(RequestVO requestVO) throws Exception;
	
	public List selectClass() throws Exception;
	
	public List selectMaster(ClassVO classVO) throws Exception;
	
	
	
	public SampleVO adjustSample(SampleVO sampleVO) throws Exception;
	
	
	/* about sample */	
	/*시료정보 가져오기*/
	public List selectSample(SampleVO sampleVO) throws Exception;
	
	public String selectNextSmpid(String reqid) throws Exception;
	/*시료정보 저장*/
	public void insertSample(SampleVO sampleVO) throws Exception;
	
	public void updateSample(SampleVO sampleVO) throws Exception;
	
	/* about result */
	/* 항목정보 가져오기 */
	public List selectResult(SampleVO sampleVO) throws Exception;
	
	/*항목저장하기 */
	public void insertResult(SampleVO sampleVO) throws Exception;
	
	
	/* delete sample */
	public List deleteSample(SampleVO sampleVO) throws Exception;
	/* copy sample */
	public void copySample(HashMap<String, String> map) throws Exception;
	
	public void deleteRequestSample(String reqid) throws Exception;
	
	
	/*항목 기초정보 가져오기 및 추가 하기*/
	
	public List selectItems(HashMap<String, String> map) throws Exception;
	
	
	public void insertResultItemP(HashMap<String, String> map) throws Exception;
	public void insertResultItem(TreeVO treeVO) throws Exception;
	
	/* update items */
	public void updateItems(ResultVO resultVO)throws Exception;
	
	/* insert0 items copy */
	public void updateItemsCopyParent(HashMap<String, String> map)throws Exception;
	public void insertItemsCopy(HashMap<String, String> map)throws Exception;
	
	/* update items copy*/
	public void updateItemsCopy(HashMap<String, String> map)throws Exception;
	
	
	public void deleteItems(HashMap<String, String> map) throws Exception;
	
	/*delete itemscopy*/
	public void deleteItemsCopy(HashMap<String, String> map) throws Exception;
	
	
	/*템플릿 가져오기 */
	
	/*템플릿 저장하기*/
	
	/* about templet */
	public String selectNextTempletId() throws Exception;
	
	public List selectTemplet(HashMap<String, String> map) throws Exception;
	
	public void insertTemplet(TempletVO templetVO) throws Exception;
	
	public void deleteTemplet(TempletVO templetVO) throws Exception;
	
	public void adjustTemplet(HashMap<String, String> map) throws Exception;
	
	
	public void deleteRequest(String reqid) throws Exception;
	
	/*about price & state*/
	public String procCalPrice(SampleVO sampleVO) throws Exception;
	public List selectPrice(SampleVO sampleVO) throws Exception;
	public void updateState(PriceVO priceVO) throws Exception;
	
	public List selectCheckMethod(SampleVO sampleVO) throws Exception;
	
	public List selectCheckCondition(SampleVO sampleVO) throws Exception;
	
	
	/* about assign */
	public void insertAssignSmple(SampleVO sampleVO) throws Exception;
	public void deleteAssignSmple(SampleVO sampleVO) throws Exception;
	public void insertAssign(SampleVO sampleVO) throws Exception;
	public void deleteAssign(SampleVO sampleVO) throws Exception;
	
	
	
	/* about dulicate */
	public List selectDuplicate(HashMap<String, Object> map) throws Exception;
	
	
	
	
	/* about attach */
	public List selectAttach(String reqid) throws Exception;
	public void insertAttach(RequestAttachVO attachVO) throws Exception;
	public void deleteAttach(HashMap<String, String> map) throws Exception;
	
	
	/* except */
	public List selectHeating() throws Exception;	
	public List selectExceptItems(HashMap<String, Object> map) throws Exception;
	public void deleteExcept(HashMap<String, String> map) throws Exception;
	public List selectItemGroup() throws Exception;
}
