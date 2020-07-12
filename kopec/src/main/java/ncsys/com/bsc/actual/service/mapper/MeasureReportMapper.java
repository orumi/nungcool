package ncsys.com.bsc.actual.service.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("measureReportMapper")
public interface MeasureReportMapper {

	public List<Map<String, Object>> selectMeasureQty(HashMap<String, Object> param);

	public List<Map<String, Object>> selectMeasureQly(HashMap<String, Object> param);

	public List<Map<String, Object>> selectMeasureStatusCnt(HashMap<String, Object> param);
	public List<Map<String, Object>> selectMeasureStatusWgt(HashMap<String, Object> param);





}
