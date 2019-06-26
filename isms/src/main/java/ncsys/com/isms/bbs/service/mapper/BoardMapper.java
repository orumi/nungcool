package ncsys.com.isms.bbs.service.mapper;

import java.util.List;

import ncsys.com.isms.bbs.service.model.BoardVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardMapper")
public interface BoardMapper {
	
	public List<BoardVO> selectBoardArticleList(BoardVO boardVO);
	public Integer selectBoardArticleListCnt(BoardVO boardVO);
	public BoardVO selectBoardArticle(BoardVO boardVO);
	

	public int insertBoardArticle(BoardVO boardVO);
	public int replyBoardArticle(BoardVO boardVO);
	public int updateBoardArticle(BoardVO boardVO);
	public int deleteBoardArticle(BoardVO boardVO);
	
	public Integer selectMaxInqireCo(BoardVO boardVO);
	public int updateInqireCo(BoardVO boardVO);
}
