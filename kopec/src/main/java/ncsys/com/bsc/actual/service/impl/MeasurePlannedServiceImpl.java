package ncsys.com.bsc.actual.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.actual.service.MeasureOwnerService;
import ncsys.com.bsc.actual.service.MeasurePlannedService;
import ncsys.com.bsc.actual.service.mapper.MeasureOwnerMapper;
import ncsys.com.bsc.actual.service.mapper.MeasurePlannedMapper;
import ncsys.com.util.Util;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;


@Service("measurePlannedService")
public class MeasurePlannedServiceImpl implements MeasurePlannedService{

	@Resource(name="measurePlannedMapper")
	private MeasurePlannedMapper measurePlannedMapper;



	@Override
	public List<Map<String, Object>> selectMeasureList(HashMap<String, Object> param) throws Exception {
		return measurePlannedMapper.selectMeasureList(param);
	}

	@Override
	public List<Map<String, Object>> selectMeasureItem(HashMap<String, Object> param) throws Exception {
		return measurePlannedMapper.selectMeasureItem(param);
	}


	@Override
	public List<Map<String, Object>> selectItemActual(HashMap<String, Object> param) throws Exception {
		return measurePlannedMapper.selectItemActual(param);
	}

	@Override
	public int adjustItemActual(HashMap<String, Object> param) throws Exception {
		int reVal = 0;

		measurePlannedMapper.deleteItem(param);

		JSONArray jArray = JSONArray.fromObject(JSONSerializer.toJSON(param.get("itemactuals")));
		List<Object> listItems = Util.TOLIST(jArray);

		String userId = (String)param.get("userId");
		for(Object listObj : listItems){
			HashMap<String, Object> mapObj = (HashMap<String, Object>)listObj;

			mapObj.put("userId", userId);

			measurePlannedMapper.insertItem(mapObj);
		}
		return reVal;
	}

	@Override
	public int deleteItemActual(HashMap<String, Object> param) throws Exception {
		int reVal = 0;

		measurePlannedMapper.deleteItem(param);

		return reVal;
	}

}
