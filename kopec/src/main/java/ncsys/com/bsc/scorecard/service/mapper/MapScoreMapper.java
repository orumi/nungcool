package ncsys.com.bsc.scorecard.service.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mapScoreMapper")
public interface MapScoreMapper {

	public List<Map<String, Object>> selectStrategicMap(HashMap<String, Object> param);

}
