package ncsys.com.bsc.admin.service.mapper;

import java.util.List;
import java.util.Map;

import ncsys.com.bsc.admin.service.model.Component;
import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.bsc.admin.service.model.Item;
import ncsys.com.bsc.admin.service.model.MeasureDefine;
import ncsys.com.bsc.admin.service.model.MeasureList;
import ncsys.com.bsc.admin.service.model.MeasureUser;
import ncsys.com.bsc.admin.service.model.TreeScoreTree;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("MeasureMapper")
public interface MeasureMapper {

	public List<MeasureList> selectMeasureList(MeasureList measureList);

	public List<Component> selectPst();
	public List<Component> selectObject();
	public List<Component> selectMeasure();

	public MeasureDefine selectMeasureDefine(MeasureDefine measureDefine);
	public Map<String, Object> selectMeasureId(Map<String, Object> param);


	public List<Item> selectMeasureItems(MeasureDefine measureDefine);
	public List<MeasureUser> selectMeasureUpdaters(MeasureDefine measureDefine);

	//selectTreeScoreByContentid
	public TreeScoreTree selectTreeScoreByContentid(TreeScoreTree  treeScoreTree);


	public List<MeasureUser> selectMeasureUserS();


	/* measuredefine */

	public int insertTreeScore(HierarchyNode hierarchyNode);
	public HierarchyNode selectTreeScoreByParentid(HierarchyNode hierarchyNode);

	public int insertMeasureDefine(MeasureDefine  measureDefine);
	public int updateMeasureDefine(MeasureDefine  measureDefine);

	public int deleteMeasureItems(MeasureDefine measureDefine);
	public int insertMeasureItem(Item item);

	public int deleteMeasureAuthority(MeasureDefine measureDefine);
	public int insertMeasureAuthority(MeasureUser measureUser);

	public int deleteTreeMeasure(MeasureDefine  measureDefine);
	public int deleteMeasureDefine(MeasureDefine  measureDefine);

	public int clearTreescoreObject(MeasureDefine  measureDefine);
	public int clearTreescorePst(MeasureDefine  measureDefine);
}
