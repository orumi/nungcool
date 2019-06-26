package ncsys.com.isms.hierarchy.service.mapper;

import java.util.List;

import ncsys.com.isms.hierarchy.service.model.*;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("regulationMapper")
public interface RegulationMapper {
	
	public List<RegulationList> selectRegulationDetailList(RegulationList regulationList);
	
	public List<Version> selectVersion();
	public List<Field> selectFiled();
	public List<Regulation> selectRegulation();
	
	
	public void insertRegulationDetail(RegulationDetail regulationDetail);
	public void updateRegulationDetail(RegulationDetail regulationDetail);
	public void deleteRegulationDetail(RegulationDetail regulationDetail);
	public RegulationDetail selectRegulationDetail(RegulationDetail regulationDetail);
	public List<RegulationDetail> selectRegulationDetailByName(RegulationDetail regulationDetail);
	public RegulationDetail selectRegulationDetailByFullname(RglDetail rglDetail);
	
	
	/* FOR FILED */
	public void insertRegulationField(Field field);
	public void updateRegulationField(Field field);
	public void deleteRegulationField(Field field);
	public Field selectRegulationFieldByName(Field field);
	
	/* FOR REGULATION */
	public void insertRegulation(Regulation regulation);
	public void updateRegulation(Regulation regulation);
	public void deleteRegulation(Regulation regulation);
	public Regulation selectRegulationByName(Regulation regulation);
	
	
	/* FOR VERSION */
	public void insertVersion(Version version);
	public void updateVersion(Version version);
	public void deleteVersion(Version version);
	public Version selectVersionByName(Version version);
	
	
	
	
}
