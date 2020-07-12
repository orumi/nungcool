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


public interface AppConfigService {

	public List<Map<String, Object>> selectConfig(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> adjustConfig(Map<String, Object> map) throws Exception;


	public List<Map<String, Object>> selectSchedule(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> adjustSchedule(Map<String, Object> map) throws Exception;

	public void adjustCopySchedule(Map<String, Object> map) throws Exception;

}

