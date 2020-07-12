package ncsys.com.bsc.analysis.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MboPsnScoreService {


	public List<Map<String, Object>> selectInitCon(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectPsnRoot(HashMap<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectPsnTreeList(HashMap<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectAccoutList(HashMap<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectAccoutDetail(HashMap<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectTargetRoot(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectTargetList(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectTargetDetail(HashMap<String, Object> param) throws Exception;


}

