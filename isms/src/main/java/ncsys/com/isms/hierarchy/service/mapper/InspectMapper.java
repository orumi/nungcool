package ncsys.com.isms.hierarchy.service.mapper;

import java.util.List;

import ncsys.com.isms.hierarchy.service.model.*;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("inspectMapper")
public interface InspectMapper {
	
	public List<InspectList> selectInspectList(InspectList inspectList);
	public void insertInspectDetail(InspectDetail inspectDetail);
	public void updateInspectDetail(InspectDetail inspectDetail);
	public void deleteInspectDetail(InspectDetail inspectDetail);
	public InspectDetail selectInspectDetail(InspectDetail inspectDetail);
	public InspectDetail selectInspectDetailByName(InspectDetail inspectDetail);
	
}
