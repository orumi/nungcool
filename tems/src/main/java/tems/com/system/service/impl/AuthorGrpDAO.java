package tems.com.system.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.system.model.AuthorGrpVO;
import tems.com.system.model.AuthorListVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("AuthorGrpDAO")
public class AuthorGrpDAO extends EgovComAbstractDAO  {
		
	public List<?> getAuthorGrpList(AuthorGrpVO authorGrpVO){
        return list("AuthorGrpDAO.selAuthorGrpList", authorGrpVO);
   }
	
	public void delAuthorGrpList(AuthorGrpVO authorGrpVO){
        delete("AuthorGrpDAO.delAuthorGrpList", authorGrpVO);
   }
	
	public void inAuthorGrpList(AuthorGrpVO authorGrpVO){
        delete("AuthorGrpDAO.inAuthorGrpList", authorGrpVO);
   }
	
	public void upAuthorGrpList(AuthorGrpVO authorGrpVO){
        delete("AuthorGrpDAO.upAuthorGrpList", authorGrpVO);
   }
	
	public List<?> getAuthorList(AuthorListVO authorListVO){
        return list("AuthorGrpDAO.selAuthorList", authorListVO);
   }
	
	public void inAuthorList(AuthorListVO authorListVO){
        delete("AuthorGrpDAO.inAuthorList", authorListVO);
   }
	
	public void delAuthorList(AuthorListVO authorListVO){
        delete("AuthorGrpDAO.delAuthorList", authorListVO);
   }

}
