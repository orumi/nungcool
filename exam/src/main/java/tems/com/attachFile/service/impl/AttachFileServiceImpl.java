package tems.com.attachFile.service.impl;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import tems.com.attachFile.model.AttachFileVO;
import tems.com.attachFile.service.AttachFileService;

@Service("attachFileService")
          
public class AttachFileServiceImpl implements AttachFileService {
	
	@Resource(name = "attachFileDAO")
	private AttachFileDAO attachFileDAO;
	
	@Override
	public AttachFileVO uploadAttachFile(MultipartFile file, String boardName) throws Exception {
		
		//파일이름생성
		UUID uuid = UUID.randomUUID();
		String orgName = file.getOriginalFilename();
		String saveName = uuid.toString() + "_" + orgName;
					
		//저장할 디렉토리
		String saveDir = "C:\\uploadFile\\"+boardName;
		String filePath = saveDir + saveName;
		
		//파일 사이즈
		long fileSize = file.getSize();
		
		//파일 카피
		File target = new File(saveDir, saveName);
		FileCopyUtils.copy(file.getBytes(), target);
		
		//VO작성
		AttachFileVO attachFileVO = new AttachFileVO();
		attachFileVO.setOrgName(orgName);
		attachFileVO.setSaveName(saveName);
		attachFileVO.setFileSize(fileSize);
		attachFileVO.setFilePath(filePath);
		attachFileVO.setBoardName(boardName);
		
		System.out.println(attachFileVO.toString());
		return attachFileDAO.uploadAttachFile(attachFileVO);
	}

	@Override
	public List<AttachFileVO> listAttachFile(int bID) throws Exception {
		return attachFileDAO.listAttachFile(bID);
	}
	
	
}
