package ncsys.com.bsc.admin.service.mapper;

import java.util.List;

import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.bsc.admin.service.model.Map;
import ncsys.com.bsc.admin.service.model.Mapicon;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("OrganizationMapper")
public interface OrganizationMapper {
	
	public List<HierarchyNode> selectHierarchy(String year);
	
	public List<Map> selectMap(String year);
	public List<Mapicon> selectIcon(String mapid);
	
	public String selectNextMapId();
	
	public int insertMap(Map map);
	public int updateMap(Map map);
	public int deleteMap(Map map);
	
	public int insertMapicon(Mapicon mapicon);
	public int deleteMapicon(Mapicon mapicon);
	
}
