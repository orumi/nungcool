package tems.com.attachFile.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tems.com.attachFile.model.AttachFileVO;
import tems.com.attachFile.service.AttachFileService;
	
@Controller
@RequestMapping(value = "/{boardName}")
public class AttachFileController {
	
	@Resource(name = "attachFileService")
	private AttachFileService attachFileService;
	
	
	@ResponseBody
	@RequestMapping(value="/attachFile.json", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
	public AttachFileVO uploadFile(HttpServletRequest req, @PathVariable("boardName") String boardName)throws Exception{
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;   
		MultipartFile file = multipartRequest.getFile("file");   
		System.out.println("파일 제이슨");
		return attachFileService.uploadAttachFile(file, boardName);
	}

	
	@ResponseBody
	@RequestMapping(value="/listFile.json", method = RequestMethod.POST)
	public List<AttachFileVO> listFile(@RequestParam("bID") int bID, @PathVariable("boardName") String boardName)throws Exception{
		
		System.out.println("파일컨트롤러" + boardName);
		System.out.println(attachFileService.listAttachFile(bID, boardName).size());
		
		return attachFileService.listAttachFile(bID, boardName);
	}
	
	
//	@ResponseBody
//	@RequestMapping(value="/deleteFile.json", method = RequestMethod.POST)
//	public int deleteFile(@RequestParam("fID") int fID)throws Exception{
//		System.out.println(fID);
//		return attachFileService.deleteAttachFile(fID);
//	}
}