package ncsys.com.bsc.analysis.service.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mboPsnScoreMapper")
public interface MboPsnScoreMapper {

	public List<Map<String, Object>> selectInitCon(HashMap<String, Object> param);
	public List<Map<String, Object>> selectPsnRoot(HashMap<String, Object> param);
	public List<Map<String, Object>> selectPsnTreeList(HashMap<String, Object> param);

	public List<Map<String, Object>> selectAccoutList(HashMap<String, Object> param);
	public List<Map<String, Object>> selectAccoutDetail(HashMap<String, Object> param);

	public List<Map<String, Object>> selectTargetRoot(HashMap<String, Object> param);
	public List<Map<String, Object>> selectTargetList(HashMap<String, Object> param);
	public List<Map<String, Object>> selectTargetDetail(HashMap<String, Object> param);


}
