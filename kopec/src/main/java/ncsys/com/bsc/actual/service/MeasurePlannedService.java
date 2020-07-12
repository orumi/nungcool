package ncsys.com.bsc.actual.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MeasurePlannedService {

	public List<Map<String, Object>> selectMeasureList(HashMap<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectMeasureItem(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectItemActual(HashMap<String, Object> param) throws Exception;


	public int adjustItemActual(HashMap<String, Object> param) throws Exception;

	public int deleteItemActual(HashMap<String, Object> param) throws Exception;

}

