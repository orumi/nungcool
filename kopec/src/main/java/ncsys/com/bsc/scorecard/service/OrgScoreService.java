package ncsys.com.bsc.scorecard.service;

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


public interface OrgScoreService {

	public List<Map<String, Object>> selectConfig() throws Exception;

	public List<Map<String, Object>> selectSbuBsc(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectState(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectOrgScore(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectMeasureActual(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectItemActual(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectItemActuals(Map<String, Object> map) throws Exception;




}

