package ncsys.com.bsc.valuate.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.valuate.service.ValuateViewService;
import ncsys.com.bsc.valuate.service.mapper.ValuateViewMapper;


@Service("valuateViewService")
public class ValuateViewServiceImpl implements ValuateViewService{

	@Resource(name="valuateViewMapper")
	private ValuateViewMapper valuateViewMapper;

	@Override
	public List<Map<String, Object>> selectEvalGrp(HashMap<String, Object> param) throws Exception {
		return valuateViewMapper.selectEvalGrp(param);
	}


	@Override
	public List<Map<String, Object>> selectEvalView(HashMap<String, Object> param) throws Exception {
		return valuateViewMapper.selectEvalView(param);
	}


	@Override
	public List<Map<String, Object>> selectQlyComment(HashMap<String, Object> param) throws Exception {
		return valuateViewMapper.selectQlyComment(param);
	}

	@Override
	public List<Map<String, Object>> selectQlyCommentDetail(HashMap<String, Object> param) throws Exception {
		return valuateViewMapper.selectQlyCommentDetail(param);
	}

}
