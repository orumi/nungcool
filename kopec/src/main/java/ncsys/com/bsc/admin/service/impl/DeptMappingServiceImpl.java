package ncsys.com.bsc.admin.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.admin.service.DeptMappingService;
import ncsys.com.bsc.admin.service.mapper.DeptMappingMapper;
import ncsys.com.util.Util;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;


@Service("DeptMappingService")
public class DeptMappingServiceImpl implements DeptMappingService{

	@Resource(name="DeptMappingMapper")
	private DeptMappingMapper deptMappingMapper;

	@Override
	public List<Map<String, Object>> selectBsc(Map<String, Object> map) throws Exception {
		return deptMappingMapper.selectBsc(map);
	}

	@Override
	public List<Map<String, Object>> selectDeptMapping(Map<String, Object> map) throws Exception {
		return deptMappingMapper.selectDeptMapping(map);
	}

	@Override
	public List<Map<String, Object>> selectDept(Map<String, Object> map) throws Exception {
		return deptMappingMapper.selectDept(map);
	}


	@Override
	public int copyDeptMapping(Map<String, Object> map) throws Exception{
		int reVal = 0;
		reVal = deptMappingMapper.deleteDeptMappingbyYear(map);
		reVal = deptMappingMapper.insertDeptMappingbyYear(map);
		reVal = deptMappingMapper.clearDeptMapping(map);

		return reVal;
	}



	@Override
	public List<Map<String, Object>> adjustDeptMapping(Map<String, Object> map) throws Exception{

		deptMappingMapper.deleteDeptMappingbyBcid(map);

		JSONArray jDeptMapping = JSONArray.fromObject(JSONSerializer.toJSON(map.get("deptMapping")));

		List<Object> listDeptMapping = Util.TOLIST(jDeptMapping);

		for(int i=0; i<listDeptMapping.size(); i++){
			Map<String, Object > m = (Map<String, Object>)listDeptMapping.get(i);

			deptMappingMapper.insetDeptMapping(m);
			deptMappingMapper.updateUserDept(m);
		}

		return deptMappingMapper.selectBsc(map);
	}



}
