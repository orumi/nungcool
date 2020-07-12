package ncsys.com.bsc.eis.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.eis.service.EvalChartService;
import ncsys.com.bsc.eis.service.mapper.EvalChartMapper;


@Service("evalChartService")
public class EvalChartServiceImpl implements EvalChartService{

	@Resource(name="evalChartMapper")
	private EvalChartMapper evalChartMapper;


	@Override
	public List<Map<String, Object>> selectEvalOrgRst(HashMap<String, Object> param) throws Exception {
		return evalChartMapper.selectEvalOrgRst(param);
	}


}
