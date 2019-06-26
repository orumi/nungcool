package ncsys.com.isms.certification.service;

import java.util.List;

import ncsys.com.isms.certification.service.model.CertiDetail;
import ncsys.com.isms.certification.service.model.CertiList;
import ncsys.com.isms.hierarchy.service.model.*;


public interface CertiService {

	public List<CertiList> selectCertiList(CertiList certiList) throws Exception;
	
	/* FOR DETAIL */
	public void insertCertiDetail(CertiDetail certiDetail) throws Exception;
	public void updateCertiDetail(CertiDetail certiDetail) throws Exception;
	public void deleteCertiDetail(CertiDetail certiDetail) throws Exception;
	public CertiDetail selectCertiDetail(CertiDetail certiDetail) throws Exception;	
	
	public CertiDetail selectCertiDetailByName(CertiDetail certiDetail) throws Exception;
}
