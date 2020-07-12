package ncsys.com.bsc.actual.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.actual.service.MeasureOwnerService;
import ncsys.com.bsc.actual.service.mapper.MeasureOwnerMapper;
import ncsys.com.util.Util;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;


@Service("measureOwnerService")
public class MeasureOwnerServiceImpl implements MeasureOwnerService{

	@Resource(name="measureOwnerMapper")
	private MeasureOwnerMapper measureOwnerMapper;



	@Override
	public List<Map<String, Object>> selectSBU(HashMap<String, Object> param) throws Exception {
		return measureOwnerMapper.selectSBU(param);
	}

	@Override
	public List<Map<String, Object>> selectMeasureList(HashMap<String, Object> param) throws Exception {
		return measureOwnerMapper.selectMeasureList(param);
	}


	@Override
	public List<Map<String, Object>> selectMeasureOwner(HashMap<String, Object> param) throws Exception {
		return measureOwnerMapper.selectMeasureOwner(param);
	}

	@Override
	public List<Map<String, Object>> selectUserList(HashMap<String, Object> param) throws Exception {
		return measureOwnerMapper.selectUserList(param);
	}

	@Override
	public int deleteAuthoritybyMeasure(HashMap<String, Object> param) throws Exception {
		return measureOwnerMapper.deleteAuthoritybyMeasure(param);
	}

	@Override
	public int insertAuthority(HashMap<String, Object> param) throws Exception {
		return measureOwnerMapper.insertAuthority(param);
	}

	@Override
	public int updateMeasureUpdater(HashMap<String, Object> param) throws Exception {
		return measureOwnerMapper.updateMeasureUpdater(param);
	}


	@Override
	public int adjustMeasureUpdater(HashMap<String, Object> param) throws Exception {

		int reVal = 0;
		reVal = this.deleteAuthoritybyMeasure(param);

		JSONArray jsonArray = JSONArray.fromObject(JSONSerializer.toJSON(param.get("owners")));

		List<Object> listOwner = Util.TOLIST(jsonArray);

		for(Object owner: listOwner){
			HashMap<String, Object> p = (HashMap<String, Object>)owner;
			if("1".equals(p.get("usertype"))){
				this.updateMeasureUpdater(p);
			} else {
				this.insertAuthority(p);
			}

		}


		return reVal;
	}

	public int adjustUpdaterWithTo(HashMap<String, Object> param) throws Exception {
		int reVal = 0;

		reVal = measureOwnerMapper.insertAuthorityWithTo(param);
		reVal = measureOwnerMapper.deleteAthorityWithTo(param);
		reVal = measureOwnerMapper.updateUpdaterWithTo(param);


		return reVal;
	}

}
