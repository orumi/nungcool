package ncsys.com.bsc.admin.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.admin.service.AppConfigService;
import ncsys.com.bsc.admin.service.mapper.AppConfigMapper;


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

}
