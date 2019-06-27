package tems.com.common.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.model.CondComboVO;
import tems.com.common.model.DeptListVO;
import tems.com.common.model.MethodComboVO;
import tems.com.common.model.SearchVO;
import tems.com.common.model.UnitComboVO;
import tems.com.system.model.OfficeUserListVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("ComboDAO")
public class ComboDAO extends EgovComAbstractDAO  {
	
	public List<?> getComboList(String str){
        return list("ComboDAO.getCodeDetailList",str);
   }
	
	public List<?> getApprStateCodeList(String str){
        return list("ComboDAO.getApprStateCodeList",str);
   }
	
	public List<?> getStateCodeList(String str){
        return list("ComboDAO.getStateCodeList",str);
   }
	
	public List<?> getMethodComboList(MethodComboVO methodComboVO){
        return list("ComboDAO.getMethodComboList",methodComboVO);
   }
	
	public List<?> getCondComboList(CondComboVO condComboVO){
        return list("ComboDAO.getCondComboList",condComboVO);
   }
	
	public List<?> getUnitComboList(UnitComboVO unitComboVO){
        return list("ComboDAO.getUnitComboList",unitComboVO);
   }
	
	public List<?> getSmpCondComboList(CondComboVO condComboVO){
        return list("ComboDAO.getSmpCondComboList",condComboVO);
   }
	
	public List<?> getDeptComboList(SearchVO searchVO){
        return list("ComboDAO.getDeptComboList",searchVO);
   }

}
