package tems.com.common.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.model.CondComboVO;
import tems.com.common.model.FileAttachVO;
import tems.com.common.model.MethodComboVO;
import tems.com.common.model.SearchVO;
import tems.com.common.model.UnitComboVO;
import tems.com.system.model.OfficeUserListVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("FileAttachDAO")
public class FileAttachDAO extends EgovComAbstractDAO  {
	
	public void inSampleFile(FileAttachVO fileAttachVO) throws Exception{
		insert("FileAttachDAO.inSampleFile",fileAttachVO);
	}
	
	public List<?> getSampleFile(SearchVO searchVO) throws Exception{
		return list("FileAttachDAO.getSampleFile",searchVO);
	}
	
	public List<?> getAdminSampleFile(SearchVO searchVO) throws Exception{
		return list("FileAttachDAO.getAdminSampleFile",searchVO);
	}
	
	public void delSampleFile(FileAttachVO fileAttachVO) throws Exception{
		delete("FileAttachDAO.delSampleFile",fileAttachVO);
	}

}
