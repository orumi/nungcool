package exam.com.community.notice.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import exam.com.common.Criteria;
import exam.com.common.PageMaker;
import exam.com.community.notice.model.BoardVO;
import exam.com.community.notice.service.NoticeService;



@Controller
@RequestMapping("/community/notice")
public class NoticeController {

	@Resource(name = "noticeService")
	private NoticeService noticeService;
	
	
 	@RequestMapping("/list.do")
 	public String listBoard(Criteria cri, Model model ) throws Exception {
 		

 		List<BoardVO> noticeList = noticeService.listBoard(cri);
		int totCnt = noticeService.selectBoardTotCnt(cri);
		PageMaker pageMaker = new PageMaker(cri, totCnt);
		
		model.addAttribute("boardList", noticeList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
 		return "exam/community/notice/list";
 	}
 	
 	
	
 	@RequestMapping(value = "/read.do", method = RequestMethod.GET)
	public String selectBoard(int bID, Criteria cri, Model model) throws Exception {
 		
 		model.addAttribute("article", noticeService.selectBoard(bID));
		model.addAttribute("cri", cri);
		model.addAttribute("attachFileList", noticeService.listAttachFile(bID));
		
 		return "exam/community/notice/read";
 	}
 
 	
     
}


