package ncsys.com.bsc.scorecard.service.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("orgScoreMapper")
public interface OrgScoreMapper {

	public List<Map<String, Object>> selectConfig();

	public List<Map<String, Object>> selectSbuBsc(Map<String, Object> map);
	public List<Map<String, Object>> selectState(Map<String, Object> map);
	public List<Map<String, Object>> selectOrgScore(Map<String, Object> map);

	public List<Map<String, Object>> selectMeasureActual(Map<String, Object> map);
	public List<Map<String, Object>> selectItemActual(Map<String, Object> map);

	public List<Map<String, Object>> selectItemActuals(Map<String, Object> map);

}
