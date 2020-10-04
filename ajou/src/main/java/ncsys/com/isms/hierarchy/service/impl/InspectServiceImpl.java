package ncsys.com.isms.hierarchy.service.impl;

import java.util.List;

import javax.annotation.Resource;

import ncsys.com.isms.hierarchy.service.InspectService;
import ncsys.com.isms.hierarchy.service.mapper.InspectMapper;
import ncsys.com.isms.hierarchy.service.model.InspectList;
import ncsys.com.isms.hierarchy.service.model.Regulation;
import ncsys.com.isms.hierarchy.service.model.Version;
import ncsys.com.isms.hierarchy.service.model.Field;
import ncsys.com.isms.hierarchy.service.model.InspectDetail;

import org.springframework.stereotype.Service;


@Service("inspectService")
public class InspectServiceImpl implements InspectService{

	@Resource(name="inspectMapper")
	private InspectMapper inspectMapper;

	@Override
	public List<InspectList> selectInspectList(InspectList inspectList) throws Exception {
		return inspectMapper.selectInspectList(inspectList );
	}
	
	
	@Override
	public void insertInspectDetail(InspectDetail inspectDetail) throws Exception{
		inspectMapper.insertInspectDetail(inspectDetail);
		
	}
	@Override
	public void updateInspectDetail(InspectDetail inspectDetail) throws Exception{
		inspectMapper.updateInspectDetail(inspectDetail);
		
	}
	@Override
	public void deleteInspectDetail(InspectDetail inspectDetail) throws Exception{
		inspectMapper.deleteInspectDetail(inspectDetail);
		
	}
	@Override
	public InspectDetail selectInspectDetail(InspectDetail inspectDetail) throws Exception {
		return inspectMapper.selectInspectDetail(inspectDetail );
	}
	
	@Override
	public InspectDetail selectInspectDetailByName(InspectDetail inspectDetail) throws Exception {
		return inspectMapper.selectInspectDetailByName(inspectDetail);
	}
	
	
}
