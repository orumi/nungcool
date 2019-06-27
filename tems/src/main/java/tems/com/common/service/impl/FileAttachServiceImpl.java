package tems.com.common.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.common.model.FileAttachVO;
import tems.com.common.model.SearchVO;
import tems.com.common.service.FileAttachService;

@Service("FileAttachService")
public class FileAttachServiceImpl implements FileAttachService {

    @Resource(name = "FileAttachDAO")
    private FileAttachDAO fileAttachDAO;
	
    public void inSampleFile(FileAttachVO fileAttachVO) throws Exception{
    	fileAttachDAO.inSampleFile(fileAttachVO);
    }
    
    public List<?> getSampleFile(SearchVO searchVO) throws Exception{
    	return fileAttachDAO.getSampleFile(searchVO);
    }
    
    public List<?> getAdminSampleFile(SearchVO searchVO) throws Exception{
    	return fileAttachDAO.getAdminSampleFile(searchVO);
    }
    
    public void delSampleFile(FileAttachVO fileAttachVO) throws Exception{
    	fileAttachDAO.delSampleFile(fileAttachVO);
    }
}
