package ncsys.com.bsc.actual.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MeasureReportService {

	public List<Map<String, Object>> selectMeasureQty(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectMeasureQly(HashMap<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectMeasureStatus(HashMap<String, Object> param) throws Exception;

}

