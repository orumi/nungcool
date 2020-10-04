package ncsys.com.isms.bbs.service;

import java.util.List;

import ncsys.com.isms.bbs.service.model.BoardVO;

public interface BoardService {
    
	public List<BoardVO> selectBoardArticleList(BoardVO boardVO) throws Exception;
	public Integer selectBoardArticleListCnt(BoardVO boardVO) throws Exception;
	public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception;
	

	public int insertBoardArticle(BoardVO boardVO) throws Exception;
	public int replyBoardArticle(BoardVO boardVO) throws Exception;
	public int updateBoardArticle(BoardVO boardVO) throws Exception;
	public int deleteBoardArticle(BoardVO boardVO) throws Exception;
	
	public Integer selectMaxInqireCo(BoardVO boardVO) throws Exception;
	public int updateInqireCo(BoardVO boardVO) throws Exception;
	
}