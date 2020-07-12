package ncsys.com.bsc.admin.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.admin.service.PerformService;
import ncsys.com.bsc.admin.service.mapper.PerformMapper;
import ncsys.com.util.Util;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;


@Service("PerformService")
public class PerformServiceImpl implements PerformService{

	@Resource(name="PerformMapper")
	private PerformMapper performMapper;

	@Override
	public List<Map<String, Object>> selectPsnBaseLine(Map<String, Object> map) throws Exception {
		return performMapper.selectPsnBaseLine(map);
	}

	@Override
	public List<Map<String, Object>> adjustPsnBaseLine(Map<String, Object> map) throws Exception{

		if(performMapper.updatePsnBaseLine(map)<1){
			performMapper.insertPsnBaseLine(map);
		}

		return performMapper.selectPsnBaseLine(map);
	}


	public int deletePsnBaseLine(Map<String, Object> map) throws Exception{
		int reVal = 0;
		reVal = performMapper.deletePsnBaseLine(map);
		reVal = performMapper.deletePsnBizMh(map);
		reVal = performMapper.deletePsnBscScore(map);
		reVal = performMapper.deletePsnScore(map);

		return reVal;
	}


	@Override
	public List<Map<String, Object>> selectPsnJikgub(Map<String, Object> map) throws Exception{
		return performMapper.selectPsnJikgub(map);
	}


	@Override
	public List<Map<String, Object>> adjustPsnJikgub(Map<String, Object> map) throws Exception{

		JSONArray jikgubs = JSONArray.fromObject(JSONSerializer.toJSON(map.get("jikgubs")));

		List<Object> listJikgub = Util.TOLIST(jikgubs);

		Map<String, Object> pm = null;
		for(int i=0; i<listJikgub.size(); i++){
			Map<String, Object > jikgub = (Map<String, Object>)listJikgub.get(i);

			if(i == 0){
				pm = jikgub;
				performMapper.deletePsnJikgub(pm);
			}

			performMapper.insertPsnJikgub(jikgub);
		}

		return performMapper.selectPsnJikgub(pm);
	}




	@Override
	public List<Map<String, Object>> adjustPsnSubMapping(Map<String, Object> map) throws Exception{

		performMapper.deletePsnSubMapping(map);

		JSONArray subMapping = JSONArray.fromObject(JSONSerializer.toJSON(map.get("subMapping")));
		List<Object> listSubMapping = Util.TOLIST(subMapping);

		for(Object subMap : listSubMapping){
			Map<String, Object> mapSubMapp = (Map<String, Object>)subMap;
			performMapper.insertPsnSubMapping(mapSubMapp);
		}

		return performMapper.selectPsnSubMapping(map);
	}

	@Override
	public List<Map<String, Object>> selectPsnSubMapping(Map<String, Object> map) throws Exception{
		return performMapper.selectPsnSubMapping(map);
	}

	@Override
	public List<Map<String, Object>> selectPsnBscMapping(Map<String, Object> map) throws Exception{
		return performMapper.selectPsnBscMapping(map);
	}











	/* psn except */
	@Override
	public List<Map<String, Object>> selectSbuGroup(Map<String, Object> map) throws Exception {
		return performMapper.selectSbuGroup(map);
	}

	@Override
	public List<Map<String, Object>> selectExceptBsc(Map<String, Object> map) throws Exception{
		return performMapper.selectExceptBsc(map);
	}

	@Override
	public List<Map<String, Object>> selectPsnEmp(Map<String, Object> map) throws Exception{
		return performMapper.selectPsnEmp(map);
	}




	@Override
	public List<Map<String, Object>> selectPsnExceptEmp(Map<String, Object> map) throws Exception{
		return performMapper.selectPsnExceptEmp(map);
	}



	@Override
	public List<Map<String, Object>> adjustPsnExceptEmp(Map<String, Object> map) throws Exception{

		performMapper.resetPsnExceptEmpbySbu(map);

		JSONArray jExceptEmp = JSONArray.fromObject(JSONSerializer.toJSON(map.get("exceptEmp")));
		List<Object> listExceptEmp = Util.TOLIST(jExceptEmp);

		for(Object exceptEmp : listExceptEmp){
			Map<String, Object> mapExceptEmp = (Map<String, Object>)exceptEmp;
			performMapper.deletePsnExceptEmp(mapExceptEmp);
			performMapper.insertPsnExceptEmp(mapExceptEmp);
		}

		return performMapper.selectExceptBsc(map);
	}



	public List<Map<String, Object>> selectPsnLabor(Map<String, Object> map) throws Exception{

		return performMapper.selectPsnLabor(map);
	}

	public List<Map<String, Object>> adjustPsnLabor(Map<String, Object> map) throws Exception{

		performMapper.deletePsnLabor(map);

		JSONArray jLaborEmp = JSONArray.fromObject(JSONSerializer.toJSON(map.get("laborEmp")));
		List<Object> listLaborEmp = Util.TOLIST(jLaborEmp);

		for(Object laborEmp : listLaborEmp){
			Map<String, Object> mapLaborEmpEmp = (Map<String, Object>)laborEmp;
			performMapper.insertPsnLabor(mapLaborEmpEmp);
		}

		return performMapper.selectPsnLabor(map);


	}







	public List<Map<String, Object>> selectPsnGradeBase(Map<String, Object> map) throws Exception{

		return performMapper.selectPsnGradeBase(map);
	}

	public List<Map<String, Object>> adjustPsnGradeBase(Map<String, Object> map) throws Exception{

		performMapper.deletePsnGradeBase(map);

		JSONArray jPsnGrade = JSONArray.fromObject(JSONSerializer.toJSON(map.get("psnGrade")));
		List<Object> listPsnGrade = Util.TOLIST(jPsnGrade);

		for(Object psnGrade : listPsnGrade){
			Map<String, Object> mapPsnGrade = (Map<String, Object>)psnGrade;
			performMapper.insertPsnGradeBase(mapPsnGrade);
		}

		return performMapper.selectPsnGradeBase(map);


	}









	public List<Map<String, Object>> selectPsnBscGrade(Map<String, Object> map) throws Exception{

		return performMapper.selectPsnBscGrade(map);
	}


	public List<Map<String, Object>> selectPsnBizMh(Map<String, Object> map) throws Exception{
		return performMapper.selectPsnBizMh(map);
	}


	public List<Map<String, Object>> selectPsnScore(Map<String, Object> map) throws Exception{
		return performMapper.selectPsnScore(map);
	}

	public List<Map<String, Object>> selectPsnScoreList(Map<String, Object> map) throws Exception{
		return performMapper.selectPsnScoreList(map);
	}
}
