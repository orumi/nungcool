package ncsys.com.bsc.eis.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.eis.service.EvalMeasService;
import ncsys.com.bsc.eis.service.mapper.EvalMeasMapper;


@Service("evalMeasService")
public class EvalMeasServiceImpl implements EvalMeasService{

	@Resource(name="evalMeasMapper")
	private EvalMeasMapper evalMeasMapper;


	@Override
	public List<Map<String, Object>> selectEvalMeaRst(HashMap<String, Object> param) throws Exception {
		return evalMeasMapper.selectEvalMeaRst(param);
	}

	@Override
	public List<Map<String, Object>> selectEvalMeasQtyRst(HashMap<String, Object> param) throws Exception{
		return evalMeasMapper.selectEvalMeasQtyRst(param);
	}

}
