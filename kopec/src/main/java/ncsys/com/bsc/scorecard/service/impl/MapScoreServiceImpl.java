package ncsys.com.bsc.scorecard.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.scorecard.service.MapScoreService;
import ncsys.com.bsc.scorecard.service.mapper.MapScoreMapper;


@Service("mapScoreService")
public class MapScoreServiceImpl implements MapScoreService{

	@Resource(name="mapScoreMapper")
	private MapScoreMapper mapScoreMapper;

	@Override
	public List<Map<String, Object>> selectStrategicMap(HashMap<String, Object> param) throws Exception {
		return mapScoreMapper.selectStrategicMap(param);
	}



}
