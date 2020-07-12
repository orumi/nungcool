package ncsys.com.bsc.actual.service.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("measurePlannedMapper")
public interface MeasurePlannedMapper {

	public List<Map<String, Object>> selectMeasureList(HashMap<String, Object> param);


	public List<Map<String, Object>> selectMeasureItem(HashMap<String, Object> param);

	public List<Map<String, Object>> selectItemActual(HashMap<String, Object> param);


	public int deleteItem(HashMap<String, Object> param);
	public int insertItem(HashMap<String, Object> param);




}
