package tems.com.attachFile.service.impl;

import java.io.File;
import java.util.HashMap;
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
	
	
	//첨부파일 복사_jsp로 정보 보내줌
	@Override
	public AttachFileVO uploadAttachFile(MultipartFile file, String boardName) throws Exception {
		
		//파일이름생성
		UUID uuid = UUID.randomUUID();
		String orgName = new String(file.getOriginalFilename().getBytes("8859_1"),"UTF-8");
		String saveName = uuid.toString();
		
		
		System.out.println(saveName);
		
		//저장할 디렉토리
		String saveDir = "C:\\uploadFile\\"+boardName+"\\";
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
		
		System.out.println("attachFile 서비스");
		System.out.println(attachFileVO.toString());
		
		return attachFileVO;
	}

	
	//파일리스트
	@Override
	public List<AttachFileVO> listAttachFile(int bID, String boardName) throws Exception {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("bID", bID);
		map.put("boardName", boardName);
		
		return attachFileDAO.listAttachFile(map);
	}
	
	
	
	

	//특정 파일 삭제
//	@Override
//	public int deleteAttachFile(int fID) throws Exception {
//		attachFileDAO.deleteAttachFile(fID);
//		return fID;
//	}
	
	
}
