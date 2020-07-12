package ncsys.com.bsc.admin.service;

import java.util.List;

import ncsys.com.bsc.admin.service.model.Component;
import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.bsc.admin.service.model.HierarchyTree;
import ncsys.com.bsc.admin.service.model.Map;
import ncsys.com.bsc.admin.service.model.Mapicon;


public interface HierarchyService {

	public List<HierarchyNode> selectHierarchy(String year) throws Exception;

	public List<Component> selectCompany() throws Exception;
	public List<Component> selectSBU() throws Exception;
	public List<Component> selectBSC() throws Exception;


	public String selectNextHierarchyId() throws Exception;
	public int insertHierarchy(HierarchyNode vo) throws Exception;

	public void adjustHierarchy(HierarchyTree tree) throws Exception;

	/* 기존 hierarchy 조회 있으면 parentid로 활요 */
	public HierarchyTree selectHierarchyByContentid(HierarchyTree vo) throws Exception;


	public int updateHierarchy(HierarchyTree vo) throws Exception;
	public int deleteHierarchy(HierarchyTree vo) throws Exception;




	public int deleteItemActual(HierarchyTree vo) throws Exception;
	public int deleteItem(HierarchyTree vo) throws Exception;
	public int deleteMeasureDetail(HierarchyTree vo) throws Exception;
	public int deleteMeasureScore(HierarchyTree vo) throws Exception;
	public int deleteMeasureDefine(HierarchyTree vo) throws Exception;


	public List<HierarchyNode> selectChildHierarchy(HierarchyTree vo) throws Exception;


}

