package tems.com.common.service;

import java.util.List;

import tems.com.common.model.CondComboVO;
import tems.com.common.model.FileAttachVO;
import tems.com.common.model.MethodComboVO;
import tems.com.common.model.SearchVO;
import tems.com.common.model.UnitComboVO;
import tems.com.system.model.AuthorGrpVO;
import tems.com.system.model.AuthorListVO;
import tems.com.system.model.OfficeUserListVO;

public interface FileAttachService {
	
	void inSampleFile(FileAttachVO fileAttachVO) throws Exception;

	List getSampleFile(SearchVO searchVO) throws Exception;
	
	List getAdminSampleFile(SearchVO searchVO) throws Exception;
	
	void delSampleFile(FileAttachVO fileAttachVO) throws Exception;
}
