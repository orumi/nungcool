package ncsys.com.bsc.admin.service;

import java.util.List;
import java.util.Map;

public interface DeptMappingService {

	public List<Map<String, Object>> selectBsc(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectDeptMapping(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectDept(Map<String, Object> map) throws Exception;

	public int copyDeptMapping(Map<String, Object> map) throws Exception;


	public List<Map<String, Object>> adjustDeptMapping(Map<String, Object> map) throws Exception;


}

