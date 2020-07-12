package ncsys.com.bsc.analysis.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MeaRankService {


	public List<Map<String, Object>> selectMeasureYear(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectMeaRank(HashMap<String, Object> param) throws Exception;



}

