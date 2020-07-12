package ncsys.com.bsc.admin.service;

import java.util.List;
import java.util.Map;

import ncsys.com.bsc.admin.service.model.Component;
import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.bsc.admin.service.model.Item;
import ncsys.com.bsc.admin.service.model.MeasureDefine;
import ncsys.com.bsc.admin.service.model.MeasureList;
import ncsys.com.bsc.admin.service.model.MeasureUser;
import ncsys.com.bsc.admin.service.model.TreeScoreTree;


public interface MeasureService {

	public List<MeasureList> selectMeasureList(MeasureList measureList) throws Exception;



	public int adjustMeasure(MeasureDefine measureDefine) throws Exception;
	public int deleteMeasure(MeasureDefine measureDefine) throws Exception;

	public TreeScoreTree selectTreeScoreByContentid(TreeScoreTree  treeScoreTree) throws Exception;


	public List<Component> selectPst() throws Exception;
	public List<Component> selectObject() throws Exception;
	public List<Component> selectMeasure() throws Exception;


	public List<MeasureUser> selectMeasureUserS() throws Exception;



	public List<Item> selectMeasureItems(MeasureDefine measureDefine) throws Exception;
	public List<MeasureUser> selectMeasureUpdaters(MeasureDefine measureDefine) throws Exception;



	public MeasureDefine selectMeasureDefine(MeasureDefine measureDefine) throws Exception;

	public Map<String, Object> selectMeasureId(Map<String, Object> param) throws Exception;

}

