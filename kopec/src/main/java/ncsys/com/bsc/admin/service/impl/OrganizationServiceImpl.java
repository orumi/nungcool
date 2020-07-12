package ncsys.com.bsc.admin.service.impl;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.nc.util.ServerStatic;

import ncsys.com.bsc.admin.service.OrganizationService;
import ncsys.com.bsc.admin.service.mapper.OrganizationMapper;
import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.bsc.admin.service.model.Map;
import ncsys.com.bsc.admin.service.model.Mapicon;


@Service("OrganizationService")
public class OrganizationServiceImpl implements OrganizationService{

	@Resource(name="OrganizationMapper")
	private OrganizationMapper organizationMapper;

	@Override
	public List<HierarchyNode> selectHierarchy(String year) throws Exception {
		return organizationMapper.selectHierarchy(year);
	}
	
	
	public List<Map> selectMap(String year) throws Exception {
		return organizationMapper.selectMap(year);
	}
	public List<Mapicon> selectIcon(String mapid) throws Exception {
		return organizationMapper.selectIcon(mapid);
	}
	
	public String selectNextMapId() throws Exception {
		return organizationMapper.selectNextMapId();
	}
	
	public int insertMap(Map map) throws Exception {
		return organizationMapper.insertMap(map);
	}
	public int updateMap(Map map) throws Exception {
		return organizationMapper.updateMap(map);
	}
	public int deleteMap(Map map) throws Exception {
		return organizationMapper.deleteMap(map);
	}
	
	public int insertMapicon(Mapicon mapicon) throws Exception {
		return organizationMapper.insertMapicon(mapicon);
	}
	public int deleteMapicon(Mapicon mapicon) throws Exception {
		return organizationMapper.deleteMapicon(mapicon);
	}
	
	
	public String[] selectMapImages() throws Exception {
		String filePath = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"mapImage";
		File file = new File(filePath);
		String fileList[]=file.list();
		
		return fileList;
		
	}
	
	
}
