package tems.com.system.service;

import java.util.List;

import tems.com.system.model.AuthorGrpVO;
import tems.com.system.model.AuthorListVO;

public interface AuthorGrpService {
	
	List getAuthorGrpList(AuthorGrpVO authorGrpVO) throws Exception;
	
	void delAuthorGrpList(AuthorGrpVO authorGrpVO) throws Exception;
	
	void inAuthorGrpList(AuthorGrpVO authorGrpVO) throws Exception;
	
	void upAuthorGrpList(AuthorGrpVO authorGrpVO) throws Exception;
	
	List getAuthorList(AuthorListVO authorListVO) throws Exception;
	
	void inAuthorList(AuthorListVO authorListVO) throws Exception;
	
	void delAuthorList(AuthorListVO authorListVO) throws Exception;
}
