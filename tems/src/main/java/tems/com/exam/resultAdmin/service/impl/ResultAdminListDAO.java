package tems.com.exam.resultAdmin.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.model.SearchVO;
import tems.com.exam.result.model.CalculationVO;
import tems.com.exam.result.model.ResultlVO;
import tems.com.exam.resultAdmin.model.ResultAdminListVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("ResultAdminListDAO")
public class ResultAdminListDAO extends EgovComAbstractDAO {
	
	public List<?> getResultAdminList(SearchVO searchVO){
        return list("ResultAdminListDAO.getResultAdminList", searchVO);
   }
	
	public void upResultAdminDetail(ResultAdminListVO resultAdminListVO){
        update("ResultAdminListDAO.upResultAdminDetail", resultAdminListVO);
   }
	
	public List<?> getCalculationAdmin(SearchVO searchVO){
        return list("ResultAdminListDAO.getCalculationAdmin", searchVO);
   }
	
	public void inCalResultAdmin(CalculationVO calculationVO){
        insert("ResultAdminListDAO.inCalResultAdmin", calculationVO);
   }
	
	public List<?> getReqList(SearchVO searchVO){
        return list("ResultAdminListDAO.getReqList", searchVO);
   }
}
