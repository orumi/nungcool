package ncsys.com.bsc.admin.service.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("valuateGroupMapper")
public interface ValuateGroupMapper {

	public List<Map<String, Object>> selectValuate(Map<String, Object> map);
	public List<Map<String, Object>> selectEvaler(Map<String, Object> map);

	public int insertEvalGrp(Map<String, Object> map);
	public int insertEvalDept(Map<String, Object> map);
	public int insertEvaler(Map<String, Object> map);
	public int updateEvaler(Map<String, Object> map);

	public int deleteEvaler(Map<String, Object> map);


	public List<Map<String, Object>> selectOrgAddScore(Map<String, Object> map);
	public Map<String, Object> selectOrgAddScoreDetail(Map<String, Object> map);


	public int updateOrgAddScore(Map<String, Object> map);
	public int insertOrgAddScore(Map<String, Object> map);
	public int deleteOrgAddScore(Map<String, Object> map);


}
