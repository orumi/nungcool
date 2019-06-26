package exam.com.req.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.ApprListVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.req.model.RequestSearchVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import exam.com.main.model.LoginUserVO;
import exam.com.req.model.ClassVO;
import exam.com.req.model.PriceVO;
import exam.com.req.model.RequestAttachVO;
import exam.com.req.model.RequestVO;
import exam.com.req.model.ResultVO;
import exam.com.req.model.SampleVO;
import exam.com.req.model.TempletVO;
import exam.com.req.model.TreeVO;

@Repository("RequestDAO")
public class RequestDAO extends EgovComAbstractDAO  {
		
	public List<?> getMemberInfo(LoginUserVO loginUser){
        return list("request_DAO.selectMemberInfo", loginUser);
    }



	public RequestVO selectEnComAddr(RequestVO requestVO){
		return (RequestVO) select("request_DAO.selectEnComAddr", requestVO);
	}
	
	
	
	public List<?> getRequest(RequestVO requestVO){
		return list("request_DAO.selectRequestInfo",requestVO);
	}

	public void setRequest(RequestVO requestVO){
		insert("request_DAO.insertRequest", requestVO);
	}
	
	public void setReport(RequestVO requestVO){
		insert("request_DAO.insertReport",requestVO);
	}
	
	public void updateRequest(RequestVO requestVO){
		update("request_DAO.updateRequest", requestVO);
	}
	
	public void updateReport(RequestVO requestVO){
		update("request_DAO.updateReport", requestVO);
	}
	
	
	 
	public String getRequestNextVal(){
		return String.valueOf(select("request_DAO.selectSEQ_ReqId") );
	}
	
	
	
	/*about Class & master */
	
	//selectClass
	public List<?> selectClass(){
		return list("request_DAO.selectClass");
	}
	
	// selectMaster
	public List<?> selectMaster(ClassVO classVO){
		return list("request_DAO.selectMaster", classVO);
	}
	
	
	
	
	/* about sample */
	public String getNextSmpid(String reqid){
		return String.valueOf(select("request_DAO.selectNextSmpid", reqid) );
	}
	
	
	public List<?> selectSample(SampleVO sampleVO){
		return list("request_DAO.selectSample", sampleVO);
	}
	
	public void insertSample(SampleVO sampleVO){
		insert("request_DAO.insertSample",sampleVO);
	}
	
	public void updateSample(SampleVO sampleVO){
		update("request_DAO.updateSample",sampleVO);
	}
	
	/* about result */
	public List<?> selectResult(SampleVO sampleVO){
		return list("request_DAO.selectResult",sampleVO);
	}
	
	public void insertResult(SampleVO sampleVO){
		
		if("Y".equals(sampleVO.getKolasyn())){
			insert("request_DAO.insertResultWithKolas",sampleVO);
		} else {
			insert("request_DAO.insertResult",sampleVO);
		}
		/*기본항목 추가후 resultpid 적용*/
		update("request_DAO.updateResultPid",sampleVO);
	}
	
	public void insertResultWithKolas(SampleVO sampleVO){
		insert("request_DAO.insertResultWithKolas",sampleVO);
		
		/*기본항목 추가후 resultpid 적용*/
		update("request_DAO.updateResultPid",sampleVO);
	}
	
	
	
	/* delete sample & result */
	public List<?> deleteSample(SampleVO sampleVO){
		
		delete("request_DAO.deleteSample", sampleVO);
		
		delete("request_DAO.deleteResult", sampleVO);
		
		return selectSample(sampleVO);
	}
	
	
	/* copy sample */
	public void copySample(HashMap<String, String> map){
		insert("request_DAO.insertCopySample", map);
		
		insert("request_DAO.insertCopyResult",map);
		
		/* 검사항목 복사 상위 아이디 조정 */
		updateItemsCopyParent(map);
	}
	
	
	
	/*about result items*/
	
	public List<?> selectItems(HashMap<String, String> map){
		return list("request_DAO.selectItems", map);
	}
	
	/*add items*/
	public void insertResultItem(TreeVO treeVO){
		insert("request_DAO.insertResultItem",treeVO);
	}
	public void insertResultItemP(HashMap<String, String> map){
		insert("request_DAO.insertResultItemP",map);
	}
	
	
	/* update items */
	public void updateItems(ResultVO resultVO){
		update("request_DAO.updateResult", resultVO);
	}
	
	/* insert items copy 항목복사 */
	public void insertItemsCopy(HashMap<String, String> map){
		insert("request_DAO.insertItemCopy", map);
	}
	
	public void updateItemsCopyParent(HashMap<String, String> map){
		update("request_DAO.updateCopyParent",map);
		update("request_DAO.updateCopyNull",map);
	}
	
	/* update items copy 속성복사*/
	public void updateItemsCopy(HashMap<String, String> map){
		update("request_DAO.updateItemCopy",map);
	}
	
	
    /* delete items */
	public void deleteItems(HashMap<String, String> map){
		/* delete grandparent */
		update("request_DAO.deleteGrandParent",map);
		
		/* delete parent */
		update("request_DAO.deleteParent",map);
		
		/*delete item */
		delete("request_DAO.deleteItem",map);
	}
	
	/*delete itemscopy*/
	public void deleteItemsCopy(HashMap<String, String> map){
		delete("request_DAO.deleteItemCopy",map);
	}
	
	
	
	/*about templet*/
	public String selectNextTempletId(){
		return String.valueOf(select("templet_DAO.selectSEQ_TempletId") );
	}
	
	public List<?> selectTemplet(HashMap<String, String> map){
		return list("templet_DAO.selectTemplet", map);
	}
	
	
	public void insertTemplet(TempletVO templetVO){
		insert("templet_DAO.insertRequest", templetVO);
		insert("templet_DAO.insertReport", templetVO);
		insert("templet_DAO.insertSample", templetVO);
		insert("templet_DAO.insertResult", templetVO);
		
	}
	
	public void deleteTemplet(TempletVO templetVO){
		delete("templet_DAO.deleteRequest", templetVO);
		delete("templet_DAO.deleteReport", templetVO);
		delete("templet_DAO.deleteSample", templetVO);
		delete("templet_DAO.deleteResult", templetVO);
		
	}
	
	/* 시료 내에서 복사 적용 */
	public void adjustTemplet(HashMap<String, String> map){
		insert("templet_DAO.adjustRequest",map);
		insert("templet_DAO.adjustReport",map);
		insert("templet_DAO.adjustSample",map);
		insert("templet_DAO.adjustResult",map);
		
		
		/* 검사항목 복사 상위 아이디 조정 */
		updateItemsCopyParent(map);
		
	}
	
	
	public void deleteRequest(String reqid){
		delete("request_DAO.deleteRequestResult",reqid);
		delete("request_DAO.deleteRequestSample",reqid);
		delete("request_DAO.deleteReport",reqid);
		delete("request_DAO.deleteRequest",reqid);
		
		delete("request_DAO.deleteAttachAll",reqid);
	}
	
	
	
	/*about assign*/
	public void insertAssignSmple(SampleVO sampleVO){
		insert("request_DAO.insertAssignSmple", sampleVO);
	}

	public void deleteAssignSmple(SampleVO sampleVO){
		delete("request_DAO.deleteAssignSmple", sampleVO);
	}
	public void insertAssign(SampleVO sampleVO){
		insert("request_DAO.insertAssign", sampleVO);
	}

	public void deleteAssign(SampleVO sampleVO){
		delete("request_DAO.deleteAssign", sampleVO);
	}
	
	/* about price */
	public String procCalPrice(SampleVO sampleVO){
		return (String) select("request_DAO.procCalPrice",sampleVO); 
	}
	
	public List<?> selectPrice(SampleVO sampleVO){
		return list("request_DAO.selectPrice", sampleVO);
	}
	
	public void updateState(PriceVO priceVO){
		update("request_DAO.updateRequestState", priceVO);
		update("request_DAO.updateReportState", priceVO);
	}
	
	
	public List<?> selectCheckMethod(SampleVO sampleVO){
		return list("request_DAO.selectCheckMethod",sampleVO);
	}
	
	public List<?> selectCheckCondition(SampleVO sampleVO){
		return list("request_DAO.selectCheckCondition", sampleVO);
	}
	
	
	
	
	/* about dulicate */
	public List<?> selectDuplicate(HashMap<String, Object> map){
		return list("request_DAO.selectDuplicate", map);
	}
	
	
	
	
	
	
	
	
	
	
	
	/* about attach */
	public List<?> selectAttach(String reqid){
		return list("request_DAO.selectAttach", reqid);
	}
	
	public void insertAttach(RequestAttachVO attachVO){
		insert("request_DAO.insertAttach", attachVO);
	}
	
	public void deleteAttach(HashMap<String, String> map){
		delete("request_DAO.deleteAttach", map);
	}
	
	/* except */

	/*	except heating selectHeadting */
	public List<?> selectHeating(){
		return list("request_DAO.selectSearchDetailItem");
	}
	
	
	/* except exceptDetail 중복확인 */
	public List<?> selectExceptItems(HashMap<String, Object> map){
		return list("request_DAO.selectExceptItems", map);
	}
	
	
	/* except deleteExcept deleteItem 중복제거 중복삭제   */
	public void deleteExcept(HashMap<String, String> map){
		delete("request_DAO.deleteExcept", map);
	}
	
	
	public List<?> selectItemGroup(){
		return list("request_DAO.selectItemGroup");
	}
	
}
