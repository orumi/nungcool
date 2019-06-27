package tems.com.bbs.exam.examNotice.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.attachFile.service.AttachFileService;
import tems.com.bbs.exam.examNotice.model.AllBoardVO;
import tems.com.bbs.exam.examNotice.model.BoardVO;
import tems.com.bbs.exam.examNotice.service.ExamNoticeService;
import tems.com.common.Criteria;
import tems.com.common.MenuAuthCheck;
import tems.com.common.PageMaker;
import tems.com.login.model.LoginUserVO;




@Controller
@RequestMapping(value = "/bbs/examNotice")
public class ExamNoticeController {

	@Resource(name = "examNoticeService")
	private ExamNoticeService examNoticeService;
	
	@Resource(name = "attachFileService")
	private AttachFileService attachFileService;
	
							 
	//리스트
	@RequestMapping(value = "/list.do")
	public String listBoard(Criteria cri, Model model, HttpServletRequest req) throws Exception {
	
		//인증관련
		if(req.getParameter("req_menuNo") != null){
    		req.getSession().setAttribute("menuId", req.getParameter("req_menuNo"));
    	}
    	
    	LoginUserVO nLoginVO = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
 		if(nLoginVO != null){
 			if(!MenuAuthCheck.AuthCheck(req)){
 				model.addAttribute("resultMsg", "메뉴 사용권한이 없습니다..");
 				return "forward:/login/userLogout.do";
 			}
 		} else {
 			model.addAttribute("resultMsg", "사용자 정보가 없습니다.");
 			return "forward:/login/userLogout.do";
 		}
		
 		
 		//리스트 가져오기
		System.out.println(cri.toString());
 		
 		List<BoardVO> boardList = examNoticeService.listBoard(cri);
		int totCnt = examNoticeService.selectBoardTotCnt(cri);
		PageMaker pageMaker = new PageMaker(cri, totCnt);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
 	
		return "tems/com/bbs/exam/examNotice/list";
	}
	
	
	//읽기
	@RequestMapping(value = "/read.do", method = RequestMethod.GET)
	public String selectBoard(int bID, Criteria cri, Model model) throws Exception {
		String boardName = "examNotice";
		model.addAttribute("article", examNoticeService.selectBoard(bID));
		model.addAttribute("cri", cri);
		model.addAttribute("attachFileList", attachFileService.listAttachFile(bID, boardName));
		
		return "tems/com/bbs/exam/examNotice/read";
	}
	
	
	
	//등록폼
	@RequestMapping(value = "/write.do")
	public String writeBoard(@RequestParam(value = "bID", required = false, defaultValue = "0") int bID, Criteria cri, Model model) throws Exception {
		BoardVO boardVO = new BoardVO();

		if (bID > 0) {
			//답글 일때는 원글 정보 가져옴
			boardVO = examNoticeService.selectBoard(bID);
			boardVO.setpID(boardVO.getbID());
		}

		model.addAttribute("article", boardVO);
		model.addAttribute("cri", cri);
		return "tems/com/bbs/exam/examNotice/write";
	}


	
	
	//글저장
	@ResponseBody
	@RequestMapping(value = "/insert.json", method = RequestMethod.POST)
	public int insertBoard(@RequestBody AllBoardVO allBoardVO) throws Exception {
		
		
		System.out.println(allBoardVO.getBoardVO().toString());		
		System.out.println(allBoardVO.getAttachList().size());
		
		String tmpContnet = allBoardVO.getBoardVO().getContent();
		tmpContnet = tmpContnet.replace("&lt;", "<");
		tmpContnet = tmpContnet.replace("&gt;", ">");
		
		allBoardVO.getBoardVO().setContent(tmpContnet);
		
		return examNoticeService.insertBoard(allBoardVO);
	}
	
	
	
	
	//댓글수 체크
	@ResponseBody
	@RequestMapping(value = "/selectReBoardCnt.json", method = RequestMethod.POST)
	public int selectReBoardCnt(@RequestParam(value = "bID") int bID) throws Exception {
		return examNoticeService.selectReBoardCnt(bID);
	}
		
	
	//삭제
	@ResponseBody
	@RequestMapping(value = "/delete.json", method = RequestMethod.POST)
	public int deleteBoard(@RequestParam(value = "bID") int bID) throws Exception {
		System.out.println("댓글 삭제");
		System.out.println(bID);
		examNoticeService.deleteBoard(bID);
		return bID;
	}
	
	
	//수정폼
	@RequestMapping(value = "/modify.do")
	public String modifyBoard(int bID, Criteria cri, Model model) throws Exception {
		
		model.addAttribute("article", examNoticeService.selectBoard(bID));
		model.addAttribute("cri", cri);
		
		return "tems/com/bbs/exam/examNotice/modify";
	}
	
	
	//글수정
	@ResponseBody
	@RequestMapping(value = "/update.json", method = RequestMethod.POST)
	public int updateBoard(@RequestBody AllBoardVO allBoardVO) throws Exception {
		System.out.println("수정 컨트롤로");
		System.out.println(allBoardVO.getBoardVO().toString());		
		System.out.println(allBoardVO.getAttachList().size());
		
		String tmpContnet = allBoardVO.getBoardVO().getContent();
		tmpContnet = tmpContnet.replace("&lt;", "<");
		tmpContnet = tmpContnet.replace("&gt;", ">");
		
		allBoardVO.getBoardVO().setContent(tmpContnet);	
		
		return examNoticeService.updateBoard(allBoardVO);
	}
		
	
}
