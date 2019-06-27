package tems.com.bbs.exam.examPds.web;

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
import tems.com.bbs.exam.examPds.model.AllBoardVO;
import tems.com.bbs.exam.examPds.model.BoardVO;
import tems.com.bbs.exam.examPds.service.ExamPdsService;
import tems.com.common.Criteria;
import tems.com.common.MenuAuthCheck;
import tems.com.common.PageMaker;
import tems.com.login.model.LoginUserVO;


@Controller
@RequestMapping(value = "/bbs/examPds")
public class ExamPdsController {

	@Resource(name = "examPdsService")
	private ExamPdsService examPdsService;
	
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
 		
 		List<BoardVO> boardList = examPdsService.listBoard(cri);
		int totCnt = examPdsService.selectBoardTotCnt(cri);
		PageMaker pageMaker = new PageMaker(cri, totCnt);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
 	
		return "tems/com/bbs/exam/examPds/list";
	}
	
	
	//읽기
	@RequestMapping(value = "/read.do", method = RequestMethod.GET)
	public String selectBoard(int bID, Criteria cri, Model model) throws Exception {
		String boardName = "examPds";
		model.addAttribute("article", examPdsService.selectBoard(bID));
		model.addAttribute("cri", cri);
		model.addAttribute("attachFileList", attachFileService.listAttachFile(bID, boardName));
		
		return "tems/com/bbs/exam/examPds/read";
	}
	
	
	
	//등록폼
	@RequestMapping(value = "/write.do")
	public String writeBoard(@RequestParam(value = "bID", required = false, defaultValue = "0") int bID, Criteria cri, Model model) throws Exception {
		BoardVO boardVO = new BoardVO();

		if (bID > 0) {
			//답글 일때는 원글 정보 가져옴
			boardVO = examPdsService.selectBoard(bID);
			boardVO.setpID(boardVO.getbID());
		}

		model.addAttribute("article", boardVO);
		model.addAttribute("cri", cri);
		return "tems/com/bbs/exam/examPds/write";
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
		
		return examPdsService.insertBoard(allBoardVO);
	}
	
	
	
	//댓글수 체크
	@ResponseBody
	@RequestMapping(value = "/selectReBoardCnt.json", method = RequestMethod.POST)
	public int selectReBoardCnt(@RequestParam(value = "bID") int bID) throws Exception {
		return examPdsService.selectReBoardCnt(bID);
	}
		
	
	//삭제
	@ResponseBody
	@RequestMapping(value = "/delete.json", method = RequestMethod.POST)
	public int deleteBoard(@RequestParam(value = "bID") int bID) throws Exception {
		System.out.println("댓글 삭제");
		System.out.println(bID);
		examPdsService.deleteBoard(bID);
		return bID;
	}
	
	
	//수정폼
	@RequestMapping(value = "/modify.do")
	public String modifyBoard(int bID, Criteria cri, Model model) throws Exception {
		
		model.addAttribute("article", examPdsService.selectBoard(bID));
		model.addAttribute("cri", cri);
		
		return "tems/com/bbs/exam/examPds/modify";
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
			
		return examPdsService.updateBoard(allBoardVO);
	}
		
	
	
}
