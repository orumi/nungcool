package tems.com.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.system.model.AuthorGrpVO;
import tems.com.system.model.AuthorListVO;
import tems.com.system.service.AuthorGrpService;
import tems.com.system.service.impl.AuthorGrpDAO;

@Service("AuthorGrpService")
public class AuthorGrpServiceImpl implements AuthorGrpService {

    @Resource(name = "AuthorGrpDAO")
    private AuthorGrpDAO AuthorGrpDAO;
	
     @Override
     public List<?> getAuthorGrpList(AuthorGrpVO authorGrpVO) throws Exception {
    	 return AuthorGrpDAO.getAuthorGrpList(authorGrpVO);
     }
     
     @Override
     public void delAuthorGrpList(AuthorGrpVO authorGrpVO) throws Exception {
    	  AuthorGrpDAO.delAuthorGrpList(authorGrpVO);
     }
     
     @Override
     public void inAuthorGrpList(AuthorGrpVO authorGrpVO) throws Exception {
    	  AuthorGrpDAO.inAuthorGrpList(authorGrpVO);
     }
     
     @Override
     public void upAuthorGrpList(AuthorGrpVO authorGrpVO) throws Exception {
    	  AuthorGrpDAO.upAuthorGrpList(authorGrpVO);
     }
     
     @Override
     public List<?> getAuthorList(AuthorListVO authorListVO) throws Exception {
    	 return AuthorGrpDAO.getAuthorList(authorListVO);
     }
     
     @Override
     public void inAuthorList(AuthorListVO authorListVO) throws Exception {
    	  AuthorGrpDAO.inAuthorList(authorListVO);
     }
     
     @Override
     public void delAuthorList(AuthorListVO authorListVO) throws Exception {
    	  AuthorGrpDAO.delAuthorList(authorListVO);
     }
}
