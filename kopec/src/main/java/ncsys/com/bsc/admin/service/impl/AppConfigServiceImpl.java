package ncsys.com.bsc.admin.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.admin.service.AppConfigService;
import ncsys.com.bsc.admin.service.mapper.AppConfigMapper;
import ncsys.com.bsc.admin.service.model.HierarchyNode;


@Service("appConfigService")
public class AppConfigServiceImpl implements AppConfigService{

	@Resource(name="appConfigMapper")
	private AppConfigMapper appConfigMapper;

	@Override
	public List<Map<String, Object>> selectConfig(Map<String, Object> map) throws Exception {
		return appConfigMapper.selectConfig(map);
	}

	@Override
	public List<Map<String, Object>> adjustConfig(Map<String, Object> map) throws Exception{

		if(appConfigMapper.updateConfig(map)<1){
			appConfigMapper.insertConfig(map);
		}

		return appConfigMapper.selectConfig(map);
	}

	@Override
	public List<Map<String, Object>> selectSchedule(Map<String, Object> map) throws Exception {
		return appConfigMapper.selectSchedule(map);
	}

	@Override
	public List<Map<String, Object>> adjustSchedule(Map<String, Object> map) throws Exception{

		appConfigMapper.deleteSchedule(map);
		appConfigMapper.insertSchedule(map);

		return appConfigMapper.selectSchedule(map);
	}

	@Override
	public void adjustCopySchedule(Map<String, Object> map) throws Exception{

		appConfigMapper.clearScheduleByYear(map);
		appConfigMapper.insertScheduleByYear(map);
	}

	@Override
	public List<Map<String, Object>> selectHierarchySBU(Map<String, Object> map) throws Exception{
		return appConfigMapper.selectHierarchySBU(map);
	}

	@Override
	public List<Map<String, Object>> selectUserList() throws Exception {
		return appConfigMapper.selectUserList();
	}

	@Override
	public List<Map<String, Object>> selectOwnerBySbuId(Map<String, Object> map) throws Exception {
		return appConfigMapper.selectOwnerBySbuId(map);
	}

	@Override
	public int deleteSbuOwner(Map<String, Object> map) throws Exception{
		return appConfigMapper.deleteSbuOwner(map);
	}

	@Override
	public int insertSbuOwner(Map<String, Object> map) throws Exception {
		return appConfigMapper.insertSbuOwner(map);
	}



}
