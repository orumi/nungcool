package tems.com.testBoard.service.serviceImpl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("testBoardDAO")
public class TestBoardDAO extends EgovComAbstractDAO{
	
	public List<?> findAllList() throws Exception {
		return list("testBoardDAO.findAllList");
	}
}
