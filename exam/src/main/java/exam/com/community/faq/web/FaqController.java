package exam.com.community.faq.web;

import exam.com.common.Criteria;
import exam.com.common.PageMaker;
import exam.com.community.faq.model.BoardVO;
import exam.com.community.faq.service.FaqService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import java.util.List;



@Controller
@RequestMapping("/community/faq")
public class FaqController {

	@Resource(name = "faqService")
	private FaqService faqService;
	
	
 	@RequestMapping("/list.do")
 	public String listBoard(Criteria cri, Model model ) throws Exception {
 		

 		List<BoardVO> faqList = faqService.listBoard(cri);
		int totCnt = faqService.selectBoardTotCnt(cri);
		PageMaker pageMaker = new PageMaker(cri, totCnt);
		
		model.addAttribute("boardList", faqList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
 		return "exam/community/faq/list";
 	}
 	
 	
	
 	@RequestMapping(value = "/read.do", method = RequestMethod.GET)
	public String selectBoard(int bID, Criteria cri, Model model) throws Exception {
 		
 		model.addAttribute("article", faqService.selectBoard(bID));
		model.addAttribute("cri", cri);
		model.addAttribute("attachFileList", faqService.listAttachFile(bID));
		
 		return "exam/community/faq/read";
 	}
 
 	
     
}


