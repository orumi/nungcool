package ncsys.com.isms.hierarchy.service;

import java.util.List;

import ncsys.com.isms.hierarchy.service.model.*;


public interface RegulationService {

	public List<RegulationList> selectRegulationDetailList(RegulationList regulationList) throws Exception;
	
	public List<Version> selectVersion() throws Exception;
	public List<Field> selectFiled() throws Exception;
	public List<Regulation> selectRegulation() throws Exception;
	
	/* FOR DETAIL */
	public void insertRegulationDetail(RegulationDetail regulationDetail) throws Exception;
	public void updateRegulationDetail(RegulationDetail regulationDetail) throws Exception;
	public void deleteRegulationDetail(RegulationDetail regulationDetail) throws Exception;
	
	public RegulationDetail selectRegulationDetail(RegulationDetail regulationDetail) throws Exception;
	public List<RegulationDetail> selectRegulationDetailByName(RegulationDetail regulationDetail) throws Exception;
	
	public RegulationDetail selectRegulationDetailByFullname(RglDetail rglDetail) throws Exception;
	
	/* FOR FILED */
	public void insertRegulationField(Field field) throws Exception;
	public void updateRegulationField(Field field) throws Exception;
	public void deleteRegulationField(Field field) throws Exception;
	
	/* FOR REGULATION */
	public void insertRegulation(Regulation regulation) throws Exception;
	public void updateRegulation(Regulation regulation) throws Exception;
	public void deleteRegulation(Regulation regulation) throws Exception;
	
	
	/* FOR VERSION */
	public void insertVersion(Version version) throws Exception;
	public void updateVersion(Version version) throws Exception;
	public void deleteVersion(Version version) throws Exception;	
	
	
	public Field selectRegulationFieldByName(Field field) throws Exception;	
	public Regulation selectRegulationByName(Regulation regulation) throws Exception;	
	public Version selectVersionByName(Version version) throws Exception;	
	
}
