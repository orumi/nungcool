package tems.com.attachFile.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.attachFile.model.AttachFileVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("attachFileDAO")
public class AttachFileDAO extends EgovComAbstractDAO{
	
	//파일업로드
	public AttachFileVO uploadAttachFile(AttachFileVO attachFileVO) throws Exception {
		System.out.println("파일업로드다오");
		System.out.println(attachFileVO.toString());
		insert("attachFileDAO.uploadAttachFile", attachFileVO);
			
		return attachFileVO;
	}
	
	//파일리스트
	public List<AttachFileVO> listAttachFile(HashMap<String, Object> map) throws Exception {
		
		System.out.println("파일 다오");
		return (List<AttachFileVO>) list("attachFileDAO.listAttachFile", map);
	}
	
	
	//특정게시글 모든 파일삭제
	public void deleteAttachFileByBID(HashMap<String, Object> map) throws Exception {
		System.out.println("파일다오 모든파일삭제: " + map.toString());
		delete("attachFileDAO.deleteAttachFileByBID", map);
	}
	
	
	
	
	//특정 파일 삭제
	public void deleteAttachFile(HashMap<String, Object> map) throws Exception {
		
		delete("attachFileDAO.deleteAttachFile", map);
	}
	
	
	
	//bID 업데이트
	public void updateBID (int bID, int fID) throws Exception {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("bID", bID);
		map.put("fID", fID);
		update("attachFileDAO.updateBID", map);
	}
	
}
