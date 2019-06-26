package tems.com.enotice.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.attachFile.service.AttachFileService;
import tems.com.common.Criteria;
import tems.com.common.MenuAuthCheck;
import tems.com.common.PageMaker;
import tems.com.enotice.model.BoardVO;
import tems.com.enotice.service.BoardService;
import tems.com.login.model.LoginUserVO;


@Controller
@RequestMapping(value = "/{boardName}")
public class BoardController {

	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name = "attachFileService")
	private AttachFileService attachFileService;
							 
	//리스트
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String list(Criteria cri, @PathVariable("boardName") String boardName, Model model, HttpServletRequest req) throws Exception {
	
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
		List<BoardVO> boardList = boardService.listBoard(cri);
		int totCnt = boardService.selectBoardTotCnt(cri);
		PageMaker pageMaker = new PageMaker(cri, totCnt);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
 	
		return "tems/com/enotice/list";
	}
	
	
	//읽기
	@RequestMapping(value = "/read.do", method = RequestMethod.GET)
	public String selectEnotice(int bID, Criteria cri, Model model) throws Exception {
		
		model.addAttribute("article", boardService.selectBoard(bID));
		model.addAttribute("cri", cri);
		model.addAttribute("attachFileList", attachFileService.listAttachFile(bID));
		
		return "tems/com/enotice/read";
	}
	
	
	
	//등록폼
	@RequestMapping(value = "/write.do", method = RequestMethod.GET)
	public String writeEnotice(@RequestParam(value = "bID", required = false, defaultValue = "0") int bID, Criteria cri, Model model) throws Exception {
		BoardVO boardVO = new BoardVO();

		if (bID > 0) {
			//답글 일때는 원글 정보 가져옴
			boardVO = boardService.selectBoard(bID);
			boardVO.setpID(boardVO.getbID());
		}

		model.addAttribute("article", boardVO);
		model.addAttribute("cri", cri);
		return "tems/com/enotice/write";
	}

	
	//글저장
	@RequestMapping(value = "/insert.do", method = RequestMethod.POST)
	public String insertBoard(@RequestParam(value = "fID", required = false) List<Integer> fID, BoardVO boardVO, Criteria cri) throws Exception {
		int crtPage = cri.getCrtPage();
		int rowCnt = cri.getRowCnt();
		int bID = boardService.insertBoard(boardVO, fID);
		
		return "redirect:/enotice/read.do?bID=" + bID + "&crtPage=" + crtPage + "&rowCnt=" + rowCnt;
	}
	
	
	//댓글수 체크
	@ResponseBody
	@RequestMapping(value = "/selectReBoardCnt.json", method = RequestMethod.POST)
	public int selectReBoardCnt(@RequestParam("bID") int bID) throws Exception {
		return boardService.selectReBoardCnt(bID);
	}
		
	
	//삭제
	@RequestMapping(value = "/delete.do", method = RequestMethod.POST)
	public String deleteBoard(int bID, Criteria cri) throws Exception {
		int crtPage = cri.getCrtPage();
		int rowCnt = cri.getRowCnt();
		
		boardService.deleteBoard(bID);
		return "redirect:/enotice/list.do?crtPage=" + crtPage + "&rowCnt=" + rowCnt;
	}
	
}
