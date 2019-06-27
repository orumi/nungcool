package tems.com.common.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.common.model.CondComboVO;
import tems.com.common.model.DeptListVO;
import tems.com.common.model.MethodComboVO;
import tems.com.common.model.SearchVO;
import tems.com.common.model.UnitComboVO;
import tems.com.common.service.ComboService;
import tems.com.system.service.impl.UserInfoDAO;

@Service("ComboService")
public class ComboServiceImpl implements ComboService {

    @Resource(name = "ComboDAO")
    private ComboDAO ComboDAO;
	
     @Override
     public List<?> getComboList(String str) throws Exception {
    	 return ComboDAO.getComboList(str);
     }
     
     @Override
     public List<?> getApprStateCodeList(String str) throws Exception {
    	 return ComboDAO.getApprStateCodeList(str);
     }
     
     @Override
     public List<?> getStateCodeList(String str) throws Exception {
    	 return ComboDAO.getStateCodeList(str);
     }
     
     @Override
     public List<?> getMethodComboList(MethodComboVO methodComboVO) throws Exception {
    	 return ComboDAO.getMethodComboList(methodComboVO);
     }
     
     @Override
     public List<?> getCondComboList(CondComboVO condComboVO) throws Exception {
    	 return ComboDAO.getCondComboList(condComboVO);
     }
     
     @Override
     public List<?> getUnitComboList(UnitComboVO unitComboVO) throws Exception {
    	 return ComboDAO.getUnitComboList(unitComboVO);
     }
     
     @Override
     public List<?> getSmpCondComboList(CondComboVO condComboVO) throws Exception {
    	 return ComboDAO.getSmpCondComboList(condComboVO);
     }
     
     @Override
     public List<?> getDeptComboList(SearchVO searchVO) throws Exception{
    	 return ComboDAO.getDeptComboList(searchVO);
     }
}
