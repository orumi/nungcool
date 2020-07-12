package ncsys.com.bsc.admin.service;

import java.util.List;
import java.util.Map;

public interface PsnEmpScoreService {

	public List<Map<String, Object>> selectEmp(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectPeriod(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectPsnLabor(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectPsnScore(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectPsnBizmh(Map<String, Object> map) throws Exception;


}

