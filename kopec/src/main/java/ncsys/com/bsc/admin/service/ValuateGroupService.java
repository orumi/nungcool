package ncsys.com.bsc.admin.service;

import java.util.List;
import java.util.Map;

public interface ValuateGroupService {

	public List<Map<String, Object>> selectValuate(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectEvaler(Map<String, Object> map) throws Exception;


	public List<Map<String, Object>> adjustValuate(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> deleteValuate(Map<String, Object> map) throws Exception;


	public List<Map<String, Object>> selectOrgAddScore(Map<String, Object> map) throws Exception;
	public Map<String, Object> selectOrgAddScoreDetail(Map<String, Object> map) throws Exception;

	public int adjustOrgAddScore(Map<String, Object> map) throws Exception;
	public int updateOrgAddScore(Map<String, Object> map) throws Exception;
	public int insertOrgAddScore(Map<String, Object> map) throws Exception;
	public int deleteOrgAddScore(Map<String, Object> map) throws Exception;


}

