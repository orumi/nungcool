package ncsys.com.bsc.eis.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.eis.service.EvalMngService;
import ncsys.com.bsc.eis.service.mapper.EvalMngMapper;
import ncsys.com.util.Util;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;


@Service("evalMngService")
public class EvalMngServiceImpl implements EvalMngService{

	@Resource(name="evalMngMapper")
	private EvalMngMapper evalMngMapper;


	@Override
	public List<Map<String, Object>> selectOrgCd(HashMap<String, Object> param) throws Exception {
		return evalMngMapper.selectOrgCd(param);
	}

	@Override
	public List<Map<String, Object>> selectMeasDivCd(HashMap<String, Object> param) throws Exception {
		return evalMngMapper.selectMeasDivCd(param);
	}

	@Override
	public List<Map<String, Object>> selectMeasGrpCd(HashMap<String, Object> param) throws Exception {
		return evalMngMapper.selectMeasGrpCd(param);
	}

	@Override
	public List<Map<String, Object>> selectMeasCd(HashMap<String, Object> param) throws Exception {
		return evalMngMapper.selectMeasCd(param);
	}

	@Override
	public List<Map<String, Object>> selectMeasList(HashMap<String, Object> param) throws Exception {
		return evalMngMapper.selectMeasList(param);
	}

	@Override
	public List<Map<String, Object>> selectOrgList(HashMap<String, Object> param) throws Exception {
		return evalMngMapper.selectOrgList(param);
	}


	@Override
	public int adjustOrgMeas(HashMap<String, Object> param) throws Exception {
		int reVal = 0;

		if((reVal = this.updateOrgMeas(param))<1){
			reVal = this.insertOrgMeas(param);
		}

		return reVal;
	}

	@Override
	public int insertOrgMeas(HashMap<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return evalMngMapper.insertOrgMeas(param);
	}

	@Override
	public int updateOrgMeas(HashMap<String, Object> param) throws Exception {
		return evalMngMapper.updateOrgMeas(param);
	}

	@Override
	public int deleteOrgMeas(HashMap<String, Object> param) throws Exception {
		return evalMngMapper.deleteOrgMeas(param);
	}

	@Override
	public int insertMeasComCd(HashMap<String, Object> param) throws Exception {
		return evalMngMapper.insertMeasComCd(param);
	}

	@Override
	public int adjustEvalOrgCopy(HashMap<String, Object> param) throws Exception {
		int reVal = 0;

		reVal = evalMngMapper.deleteEvalOrg(param);
		reVal = evalMngMapper.insertEvalOrg(param);
		reVal = evalMngMapper.deleteEvalOrgMeas(param);
		reVal = evalMngMapper.insertEvalOrgMeas(param);

		return reVal;
	}

	@Override
	public int adjustEvalOrgMeasCopy(HashMap<String, Object> param) throws Exception {
		int reVal = 0;

		reVal = evalMngMapper.deleteEvalOrgMeasByOrgCd(param);
		reVal = evalMngMapper.insertEvalOrgMeasByOrgCd(param);

		return reVal;

	}

	@Override
	public List<Map<String, Object>> selectEvalOrgRst(HashMap<String, Object> param) throws Exception {

		return evalMngMapper.selectEvalOrgRst(param);

	}

	@Override
	public List<Map<String, Object>> adjustEvalOrgRst(HashMap<String, Object> param) throws Exception {
		JSONArray jArray = JSONArray.fromObject(JSONSerializer.toJSON(param.get("evalOrgRst")));
		List<Object> listEvalOrgRst = Util.TOLIST(jArray);

		String userId = (String)param.get("userId");
		for(Object listObj : listEvalOrgRst){
			HashMap<String, Object> mapObj = (HashMap<String, Object>)listObj;

			mapObj.put("userId", userId);

			if(evalMngMapper.updateEvalOrgRst(mapObj) < 1){
				evalMngMapper.insertEvalOrgRst(mapObj);
			}

		}


		return evalMngMapper.selectEvalOrgRst(param);

	}

	@Override
	public int deleteEvalOrgRst(HashMap<String, Object> param) throws Exception {
		return evalMngMapper.deleteEvalOrgRst(param);
	};

	@Override
	public int updateEvalMeasRst(HashMap<String, Object> param) throws Exception {
		JSONArray jArray = JSONArray.fromObject(JSONSerializer.toJSON(param.get("evalMeasRst")));
		List<Object> listEvalMeasRst = Util.TOLIST(jArray);

		String userId = (String)param.get("userId");
		for(Object listObj : listEvalMeasRst){
			HashMap<String, Object> mapObj = (HashMap<String, Object>)listObj;

			mapObj.put("userId", userId);

			evalMngMapper.updateEvalMeasRst(mapObj);
		}

		return 1;
	}


}
