package tems.com.testBoard.service.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.testBoard.service.TestBoardService;

@Service("testBoardService")
public class TestBoardServiceImpl implements TestBoardService {

	@Resource(name = "testBoardDAO")
	TestBoardDAO tbDAO;
	
	@Override
	public List findAllList() throws Exception {
		List list = null;//tbDAO.findAllList();
		return list;
	}
	
}
