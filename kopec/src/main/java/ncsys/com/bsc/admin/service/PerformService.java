package ncsys.com.bsc.admin.service;

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


public interface PerformService {

	public List<Map<String, Object>> selectPsnBaseLine(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> adjustPsnBaseLine(Map<String, Object> map) throws Exception;
	public int deletePsnBaseLine(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectPsnJikgub(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> adjustPsnJikgub(Map<String, Object> map) throws Exception;


	public List<Map<String, Object>> adjustPsnSubMapping(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectPsnSubMapping(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectPsnBscMapping(Map<String, Object> map) throws Exception;



	/* psn except */

	public List<Map<String, Object>> selectSbuGroup(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectExceptBsc(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectPsnEmp(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectPsnExceptEmp(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> adjustPsnExceptEmp(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectPsnLabor(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> adjustPsnLabor(Map<String, Object> map) throws Exception;

    /* psn grade */
	public List<Map<String, Object>> selectPsnGradeBase(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> adjustPsnGradeBase(Map<String, Object> map) throws Exception;


	public List<Map<String, Object>> selectPsnBscGrade(Map<String, Object> map) throws Exception;


	public List<Map<String, Object>> selectPsnBizMh(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectPsnScore(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectPsnScoreList(Map<String, Object> map) throws Exception;


}

