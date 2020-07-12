package ncsys.com.bsc.admin.service.impl;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.nc.util.ServerStatic;

import ncsys.com.bsc.admin.service.HierarchyService;
import ncsys.com.bsc.admin.service.OrganizationService;
import ncsys.com.bsc.admin.service.mapper.HierarchyMapper;
import ncsys.com.bsc.admin.service.mapper.OrganizationMapper;
import ncsys.com.bsc.admin.service.model.Component;
import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.bsc.admin.service.model.HierarchyTree;
import ncsys.com.bsc.admin.service.model.Map;
import ncsys.com.bsc.admin.service.model.Mapicon;


@Service("HierarchyService")
public class HierarchyServiceImpl implements HierarchyService{

	@Resource(name="HierarchyMapper")
	private HierarchyMapper hierarchyMapper;

	@Override
	public List<HierarchyNode> selectHierarchy(String year) throws Exception {
		return hierarchyMapper.selectHierarchy(year);
	}

	@Override
	public List<Component> selectCompany() throws Exception {
		return hierarchyMapper.selectCompnay();
	}
	@Override
	public List<Component> selectSBU() throws Exception {
		return hierarchyMapper.selectSBU();
	}
	@Override
	public List<Component> selectBSC() throws Exception {
		return hierarchyMapper.selectBSC();
	}

	@Override
	public String selectNextHierarchyId() throws Exception{
		return hierarchyMapper.selectNextHierarchyId();
	}

	@Override
	public int insertHierarchy(HierarchyNode vo) throws Exception{

		return hierarchyMapper.insertHierarchy(vo);

	}

	@Override
	public void adjustHierarchy(HierarchyTree tree) throws Exception{


		/*기존 정보 조회 */
		HierarchyTree hierarchyTree = hierarchyMapper.selectHierarchyByContentid(tree);

		HierarchyNode com = new HierarchyNode();
		/* company */
		if(hierarchyTree !=null && hierarchyTree.getCcid() != null){
			com.setYear(tree.getYear());
			com.setId(hierarchyTree.getCid());
			com.setParentid("0");
			com.setContentid(hierarchyTree.getCcid());
			com.setTreelevel("0");
		} else {
			String nextId = this.selectNextHierarchyId();
			com.setYear(tree.getYear());
			com.setId(nextId);
			com.setParentid("0");
			com.setContentid(tree.getCcid());
			com.setTreelevel("0");
			com.setRank(tree.getCrank());
			this.insertHierarchy(com);
		}

		HierarchyNode sbu = new HierarchyNode();
		/* sbu */
		if(hierarchyTree !=null && hierarchyTree.getScid() != null){
			sbu.setYear(tree.getYear());
			sbu.setId(hierarchyTree.getSid());
			sbu.setParentid(hierarchyTree.getSpid());
			sbu.setContentid(hierarchyTree.getScid());
			sbu.setTreelevel("1");
		} else {
			String nextId = this.selectNextHierarchyId();

			sbu.setYear(tree.getYear());
			sbu.setId(nextId);
			sbu.setParentid(com.getId());
			sbu.setContentid(tree.getScid());
			sbu.setTreelevel("1");
			sbu.setRank(tree.getSrank());
			this.insertHierarchy(sbu);
		}

		/* bsc */
		HierarchyNode bsc = new HierarchyNode();
		if(hierarchyTree !=null && hierarchyTree.getBcid()!=null){
			bsc.setYear(tree.getYear());
			bsc.setParentid(hierarchyTree.getBid());
			bsc.setContentid(hierarchyTree.getBcid());
			bsc.setTreelevel("2");
		} else {
			String nextId = this.selectNextHierarchyId();

			bsc.setYear(tree.getYear());
			bsc.setId(nextId);
			bsc.setParentid(sbu.getId());
			bsc.setContentid(tree.getBcid());
			bsc.setTreelevel("2");
			bsc.setRank(tree.getBrank());

			this.insertHierarchy(bsc);
		}



	}

	@Override
	public HierarchyTree selectHierarchyByContentid(HierarchyTree vo) throws Exception{

		return hierarchyMapper.selectHierarchyByContentid(vo);

	}





	@Override
	public int updateHierarchy(HierarchyTree vo) throws Exception {

		if ("0".equals(vo.getTreeLevel())){
			vo.setNewId(vo.getCcid());
			vo.setRank(vo.getCrank());
		} else if ("1".equals(vo.getTreeLevel())){
			vo.setNewId(vo.getScid());
			vo.setRank(vo.getSrank());
		} else if ("2".equals(vo.getTreeLevel())){
			vo.setNewId(vo.getBcid());
			vo.setRank(vo.getBrank());
		}



		return hierarchyMapper.updateHierarchy(vo);
	}



	@Override
	public int deleteHierarchy(HierarchyTree vo) throws Exception {

		if("2".equals(vo.getTreeLevel())){
			this.deleteItemActual(vo);
			this.deleteItem(vo);
			this.deleteMeasureDetail(vo);
			this.deleteMeasureScore(vo);
			this.deleteMeasureDefine(vo);
		} else {
			List<HierarchyNode> node = this.hierarchyMapper.selectChildHierarchy(vo);
			if(node.size() > 0){
				return 0;
			}
		}

		return hierarchyMapper.deleteHierarchy(vo);
	}


	@Override
	public int deleteItemActual(HierarchyTree vo) throws Exception {
		return hierarchyMapper.deleteItemActual(vo);
	}


	@Override
	public int deleteItem(HierarchyTree vo) throws Exception {
		return hierarchyMapper.deleteItem(vo);
	}


	@Override
	public int deleteMeasureDetail(HierarchyTree vo) throws Exception {
		return hierarchyMapper.deleteMeasureDetail(vo);
	}


	@Override
	public int deleteMeasureScore(HierarchyTree vo) throws Exception {
		return hierarchyMapper.deleteMeasureScore(vo);
	}


	@Override
	public int deleteMeasureDefine(HierarchyTree vo) throws Exception {
		return hierarchyMapper.deleteMeasureDefine(vo);
	}

	@Override
	public List<HierarchyNode> selectChildHierarchy(HierarchyTree vo) throws Exception {

		return hierarchyMapper.selectChildHierarchy(vo);
	}

}
