package ncsys.com.bsc.admin.service;

import java.util.List;

import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.bsc.admin.service.model.Map;
import ncsys.com.bsc.admin.service.model.Mapicon;


public interface OrganizationService {

	public List<HierarchyNode> selectHierarchy(String year) throws Exception;
	
	public List<Map> selectMap(String year) throws Exception;
	public List<Mapicon> selectIcon(String mapid) throws Exception;
	
	public String selectNextMapId() throws Exception;
	
	public int insertMap(Map map) throws Exception;
	public int updateMap(Map map) throws Exception;
	public int deleteMap(Map map) throws Exception;
	
	public int insertMapicon(Mapicon mapicon) throws Exception;
	public int deleteMapicon(Mapicon mapicon) throws Exception;
	
	public String[] selectMapImages() throws Exception;
}
