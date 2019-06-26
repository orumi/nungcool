package tems.com.common.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

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

}
