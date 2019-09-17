package ncsys.com.isms.bbs.web;




import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.LoginVO;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.bbs.service.BoardService;
import ncsys.com.isms.bbs.service.model.BoardVO;
import ncsys.com.isms.concern.service.ConcernDtlService;
import ncsys.com.isms.concern.service.model.ConcernItem;
import ncsys.com.util.Criteria;
import ncsys.com.util.PageMaker;
import net.sf.json.JSONObject;


@Controller
@RequestMapping("/cool/bbs")
public class BoardController {


	@Resource(name="boardService")
	private  BoardService boardService;


    /**
     * 목록창
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/board.do")
    public ModelAndView board(BoardVO boardVO) throws Exception {
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("isms/bbs/board.tiles");
    	mv.addObject("boardVO", boardVO);
    	return mv;
    	//return "isms/bbs/board.tiles";
    }


    /**
     * 상세창
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/boardDetail.do")
    public ModelAndView boardDetail(BoardVO boardVO) throws Exception {
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("isms/bbs/boardDetail.popup");
    	mv.addObject("boardVO", boardVO);
    	return mv;

    	//return "isms/bbs/boardDetail.popup";
    }


    /**
     * 초기정보
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/boardInit.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void boardInit(HttpServletRequest request, HttpServletResponse response)  {
    	try{
	    	System.out.println("boardInit.json");

	    	JSONObject nJson = new JSONObject();

	    	/*List<AssetGroupList> reAssetGroupList =  assetService.selectAssetGroupList();
	    	nJson.put("reAssetGroupList", reAssetGroupList);*/

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}

    /*week test item List */
    /**
     * 목록정보
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/boardArticleList.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void boardArticleList(HttpServletRequest request, HttpServletResponse response, BoardVO boardVO, Criteria cri )  {
    	try{

    		System.out.println(cri);

	    	JSONObject nJson = new JSONObject();

	    	/* first paget current page */
	    	boardVO.setFirstIndex(cri.getFirst());

	    	/* rowcount */
	    	boardVO.setRecordCountPerPage(cri.getRows());

			List<BoardVO> reBoardVO = boardService.selectBoardArticleList(boardVO);
			int totCnt = boardService.selectBoardArticleListCnt(boardVO);

			PageMaker pageMaker = new PageMaker(cri, totCnt);


			nJson.put("reBoardVO", reBoardVO);
			nJson.put("pageMaker", pageMaker);
			nJson.put("cri", cri);

	        PrintWriter out = response.getWriter();
	        out.write(nJson.toString());
	        out.flush();
	        out.close();

    	} catch (Exception e ){
    		System.out.println(e);
    	}
	}

    /*week test item detail */
    /**
     * 상세 정보
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/boardArticleDetail.json", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void boardArticleDetail(HttpServletRequest request, HttpServletResponse response, String mode, @RequestBody String json )  {
    	JSONObject nJson = new JSONObject();
    	try{

    		LoginVO loginVO =  (LoginVO)request.getSession().getAttribute("loginVO");

    		BoardVO detail = new ObjectMapper().readValue(json, BoardVO.class);
    		detail.setFrstRegisterId(loginVO.getId());
    		detail.setNtcrId(loginVO.getId());
    		detail.setNtcrNm(loginVO.getName());

	    	if("modify".equals(mode)){

	    		if("I".equals(detail.getActionmode()) ){
	    			boardService.insertBoardArticle(detail);
	    		} else if("D".equals(detail.getActionmode()) ){
	    			boardService.deleteBoardArticle(detail);
	    		} else if("U".equals(detail.getActionmode())){
	    			boardService.updateBoardArticle(detail);
	    		}

	    	} else if("select".equals(mode)){

	    		BoardVO reDetail = boardService.selectBoardArticle(detail);
	    		nJson.put("reDetail", reDetail);
	    	}

	    	nJson.put("reVal", "ok_resend");

    	} catch (Exception e ){
    		nJson.put("reVal", "failure_resend");
    		System.out.println(e);
    	} finally {
    		try {
	    		PrintWriter out = response.getWriter();
		        out.write(nJson.toString());
		        out.flush();
		        out.close();
    		} catch (Exception e){ }
    	}
	}

}
