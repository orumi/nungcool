package exam.com.community.pds.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import exam.com.common.Criteria;
import exam.com.common.PageMaker;
import exam.com.community.pds.model.BoardVO;
import exam.com.community.pds.service.PdsService;



@Controller
@RequestMapping("/community/pds")
public class PdsController {

	@Resource(name = "pdsService")
	private PdsService pdsService;
	
	
 	@RequestMapping("/list.do")
 	public String listBoard(Criteria cri, Model model ) throws Exception {
 		

 		List<BoardVO> pdsList = pdsService.listBoard(cri);
		int totCnt = pdsService.selectBoardTotCnt(cri);
		PageMaker pageMaker = new PageMaker(cri, totCnt);
		
		model.addAttribute("boardList", pdsList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
 		return "exam/community/pds/list";
 	}
 	
 	
	
 	@RequestMapping(value = "/read.do", method = RequestMethod.GET)
	public String selectBoard(int bID, Criteria cri, Model model) throws Exception {
 		
 		model.addAttribute("article", pdsService.selectBoard(bID));
		model.addAttribute("cri", cri);
		model.addAttribute("attachFileList", pdsService.listAttachFile(bID));
		
 		return "exam/community/pds/read";
 	}
 
 	
     
}


