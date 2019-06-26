package ncsys.com.isms.hierarchy.service;

import java.util.List;

import ncsys.com.isms.hierarchy.service.model.*;


public interface InspectService {

	public List<InspectList> selectInspectList(InspectList inspectList) throws Exception;
	
	/* FOR DETAIL */
	public void insertInspectDetail(InspectDetail inspectDetail) throws Exception;
	public void updateInspectDetail(InspectDetail inspectDetail) throws Exception;
	public void deleteInspectDetail(InspectDetail inspectDetail) throws Exception;
	public InspectDetail selectInspectDetail(InspectDetail inspectDetail) throws Exception;	
	
	public InspectDetail selectInspectDetailByName(InspectDetail inspectDetail) throws Exception;
	
	
}
