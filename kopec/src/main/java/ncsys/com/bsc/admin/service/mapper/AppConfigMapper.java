package ncsys.com.bsc.admin.service.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import ncsys.com.bsc.admin.service.model.HierarchyNode;

@Mapper("appConfigMapper")
public interface AppConfigMapper {

	public List<Map<String, Object>> selectConfig(Map<String, Object> map);

	public int insertConfig(Map<String, Object> map);
	public int updateConfig(Map<String, Object> map);

	public List<Map<String, Object>> selectSchedule(Map<String, Object> map);
	public int insertSchedule(Map<String, Object> map);
	public int deleteSchedule(Map<String, Object> map);

	public int clearScheduleByYear(Map<String, Object> map);
	public int insertScheduleByYear(Map<String, Object> map);


	public List<Map<String, Object>> selectHierarchySBU(Map<String, Object> map);
	public List<Map<String, Object>> selectUserList();
	public List<Map<String, Object>> selectOwnerBySbuId(Map<String, Object> map);

	public int deleteSbuOwner(Map<String, Object> map);
	public int insertSbuOwner(Map<String, Object> map);



}
