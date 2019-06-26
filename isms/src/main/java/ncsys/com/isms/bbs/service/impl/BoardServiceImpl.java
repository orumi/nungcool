package ncsys.com.isms.bbs.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import ncsys.com.isms.bbs.service.BoardService;
import ncsys.com.isms.bbs.service.mapper.BoardMapper;
import ncsys.com.isms.bbs.service.model.BoardVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService{

	@Resource(name="boardMapper")
	private BoardMapper boardMapper;

	@Resource(name = "egovNttIdGnrService")
    private EgovIdGnrService nttIdgenService;
	
	@Override
	public List<BoardVO> selectBoardArticleList(BoardVO boardVO) throws Exception {
		return boardMapper.selectBoardArticleList(boardVO);
	}

	@Override
	public Integer selectBoardArticleListCnt(BoardVO boardVO) throws Exception {
		return boardMapper.selectBoardArticleListCnt(boardVO);
	}

	@Override
	public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception {
		
		/* 조회수 증가 */
	    int iniqireCo = this.selectMaxInqireCo(boardVO);

	    boardVO.setInqireCo(iniqireCo);
	    this.updateInqireCo(boardVO);
		
		return boardMapper.selectBoardArticle(boardVO);
	}

	@Override
	public int insertBoardArticle(BoardVO boardVO) throws Exception{
		
		boardVO.setNttId(nttIdgenService.getNextIntegerId());
		return boardMapper.insertBoardArticle(boardVO);
	}

	@Override
	public int replyBoardArticle(BoardVO boardVO) throws Exception {
		return boardMapper.replyBoardArticle(boardVO);
	}

	@Override
	public int updateBoardArticle(BoardVO boardVO) throws Exception {
		return boardMapper.updateBoardArticle(boardVO);
	}

	@Override
	public int deleteBoardArticle(BoardVO boardVO) throws Exception {
		return boardMapper.deleteBoardArticle(boardVO);
	}
	
	@Override
	public Integer selectMaxInqireCo(BoardVO boardVO) throws Exception{
		return boardMapper.selectMaxInqireCo(boardVO);
	}
	
	@Override
	public int updateInqireCo(BoardVO boardVO) throws Exception{
		return boardMapper.updateInqireCo(boardVO);
	}
}