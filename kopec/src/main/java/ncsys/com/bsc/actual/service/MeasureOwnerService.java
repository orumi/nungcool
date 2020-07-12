package ncsys.com.bsc.actual.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MeasureOwnerService {

	public List<Map<String, Object>> selectSBU(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectMeasureList(HashMap<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectMeasureOwner(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectUserList(HashMap<String, Object> param) throws Exception;


	public int deleteAuthoritybyMeasure(HashMap<String, Object> param) throws Exception;
	public int insertAuthority(HashMap<String, Object> param) throws Exception;
	public int updateMeasureUpdater(HashMap<String, Object> param) throws Exception;

	public int adjustMeasureUpdater(HashMap<String, Object> param) throws Exception;

	public int adjustUpdaterWithTo(HashMap<String, Object> param) throws Exception;


}

