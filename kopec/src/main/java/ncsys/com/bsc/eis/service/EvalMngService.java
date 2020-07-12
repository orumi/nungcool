package ncsys.com.bsc.eis.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ncsys.com.bsc.admin.service.model.Component;
import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.bsc.admin.service.model.Item;
import ncsys.com.bsc.admin.service.model.MeasureDefine;
import ncsys.com.bsc.admin.service.model.MeasureList;
import ncsys.com.bsc.admin.service.model.MeasureUser;
import ncsys.com.bsc.admin.service.model.TreeScoreTree;


public interface EvalMngService {

	public List<Map<String, Object>> selectOrgCd(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectMeasDivCd(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectMeasGrpCd(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectMeasCd(HashMap<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectMeasList(HashMap<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectOrgList(HashMap<String, Object> param) throws Exception;

	public int adjustOrgMeas(HashMap<String, Object> param) throws Exception;

	public int insertOrgMeas(HashMap<String, Object> param) throws Exception;
	public int updateOrgMeas(HashMap<String, Object> param) throws Exception;
	public int deleteOrgMeas(HashMap<String, Object> param) throws Exception;

	public int insertMeasComCd(HashMap<String, Object> param) throws Exception;

	public int adjustEvalOrgCopy(HashMap<String, Object> param) throws Exception;

	public int adjustEvalOrgMeasCopy(HashMap<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectEvalOrgRst(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> adjustEvalOrgRst(HashMap<String, Object> param) throws Exception;

	public int deleteEvalOrgRst(HashMap<String, Object> param) throws Exception;

	public int updateEvalMeasRst(HashMap<String, Object> param) throws Exception;
}

