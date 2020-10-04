package ncsys.com.isms.certification.service.mapper;

import java.util.List;

import ncsys.com.isms.certification.service.model.CertiDetail;
import ncsys.com.isms.certification.service.model.CertiList;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("certiMapper")
public interface CertiMapper {
	
	public List<CertiList> selectCertiList(CertiList certiList);
	public void insertCertiDetail(CertiDetail certiDetail);
	public void updateCertiDetail(CertiDetail certiDetail);
	public void deleteCertiDetail(CertiDetail certiDetail);
	public CertiDetail selectCertiDetail(CertiDetail certiDetail);
	
	public CertiDetail selectCertiDetailByName(CertiDetail certiDetail);
}
