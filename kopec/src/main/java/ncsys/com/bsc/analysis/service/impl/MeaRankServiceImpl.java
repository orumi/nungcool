package ncsys.com.bsc.analysis.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.analysis.service.MeaRankService;
import ncsys.com.bsc.analysis.service.mapper.MeaRankMapper;
import ncsys.com.bsc.scorecard.service.MapScoreService;
import ncsys.com.bsc.scorecard.service.mapper.MapScoreMapper;


@Service("meaRankService")
public class MeaRankServiceImpl implements MeaRankService{

	@Resource(name="meaRankMapper")
	private MeaRankMapper meaRankMapper;


	@Override
	public List<Map<String, Object>> selectMeasureYear(HashMap<String, Object> param) throws Exception {
		return meaRankMapper.selectMeasureYear(param);
	}

	@Override
	public List<Map<String, Object>> selectMeaRank(HashMap<String, Object> param) throws Exception {
		return meaRankMapper.selectMeaRank(param);
	}



}
