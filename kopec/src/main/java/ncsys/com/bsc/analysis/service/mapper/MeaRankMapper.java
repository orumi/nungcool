package ncsys.com.bsc.analysis.service.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("meaRankMapper")
public interface MeaRankMapper {

	public List<Map<String, Object>> selectMeasureYear(HashMap<String, Object> param);
	public List<Map<String, Object>> selectMeaRank(HashMap<String, Object> param);

}
