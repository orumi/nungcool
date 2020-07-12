package ncsys.com.bsc.admin.service.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("psnEmpScoreMapper")
public interface PsnEmpScoreMapper {

	public List<Map<String, Object>> selectEmp(Map<String, Object> map);

	public List<Map<String, Object>> selectPeriod(Map<String, Object> map);

	public List<Map<String, Object>> selectPsnLabor(Map<String, Object> map);
	public List<Map<String, Object>> selectPsnScore(Map<String, Object> map);
	public List<Map<String, Object>> selectPsnBizmh(Map<String, Object> map);



}
