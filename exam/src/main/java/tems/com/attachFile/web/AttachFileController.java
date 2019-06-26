package tems.com.attachFile.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import tems.com.attachFile.model.AttachFileVO;
import tems.com.attachFile.service.AttachFileService;
	
@Controller
@RequestMapping(value = "/{boardName}")
public class AttachFileController {
	
	@Resource(name = "attachFileService")
	private AttachFileService attachFileService;
	

	@ResponseBody
	@RequestMapping(value="/attachFile.json", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
	public AttachFileVO uploadFile(@RequestParam("file") MultipartFile file, @PathVariable("boardName") String boardName)throws Exception{
		System.out.println("s나여기");
		return attachFileService.uploadAttachFile(file, boardName);
	}


}