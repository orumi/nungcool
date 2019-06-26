package tems.com.common.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

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
     
}
