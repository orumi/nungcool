package ncsys.com.bsc.admin.service.mapper;

import java.util.List;

import ncsys.com.bsc.admin.service.model.Component;
import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.bsc.admin.service.model.HierarchyTree;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("HierarchyMapper")
public interface HierarchyMapper {

	public List<HierarchyNode> selectHierarchy(String year);

	public List<Component> selectCompnay();
	public List<Component> selectSBU();
	public List<Component> selectBSC();


	public String selectNextHierarchyId();
	public int insertHierarchy(HierarchyNode vo);


	public HierarchyTree selectHierarchyByContentid(HierarchyTree vo);



	public int updateHierarchy(HierarchyTree vo);

	public int deleteItemActual(HierarchyTree vo);
	public int deleteItem(HierarchyTree vo);
	public int deleteMeasureDetail(HierarchyTree vo);
	public int deleteMeasureScore(HierarchyTree vo);
	public int deleteMeasureDefine(HierarchyTree vo);

	public int deleteHierarchy(HierarchyTree vo);


	public List<HierarchyNode> selectChildHierarchy(HierarchyTree vo);

}
