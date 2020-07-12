package ncsys.com.bsc.admin.service.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("DeptMappingMapper")
public interface DeptMappingMapper {

	public List<Map<String, Object>> selectBsc(Map<String, Object> map);
	public List<Map<String, Object>> selectDeptMapping(Map<String, Object> map);
	public List<Map<String, Object>> selectDept(Map<String, Object> map);


	public int deleteDeptMappingbyYear(Map<String, Object> map);
	public int insertDeptMappingbyYear(Map<String, Object> map);
	public int clearDeptMapping(Map<String, Object> map);


	public int deleteDeptMappingbyBcid(Map<String, Object> map);
	public int insetDeptMapping(Map<String, Object> map);
	public int updateUserDept(Map<String, Object> map);




}
