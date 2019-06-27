package tems.com.attachFile.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import tems.com.attachFile.model.AttachFileVO;

public interface AttachFileService {

	public AttachFileVO uploadAttachFile(MultipartFile file, String boardName) throws Exception;
	
	public List<AttachFileVO> listAttachFile(int bID, String boardName) throws Exception;
	
//	public int deleteAttachFile(int fID) throws Exception;
	
}