package ncsys.com.isms.hierarchy.service.impl;

import java.util.List;

import javax.annotation.Resource;

import ncsys.com.isms.hierarchy.service.RegulationService;
import ncsys.com.isms.hierarchy.service.mapper.RegulationMapper;
import ncsys.com.isms.hierarchy.service.model.Field;
import ncsys.com.isms.hierarchy.service.model.InspectDetail;
import ncsys.com.isms.hierarchy.service.model.Regulation;
import ncsys.com.isms.hierarchy.service.model.RegulationDetail;
import ncsys.com.isms.hierarchy.service.model.RegulationList;
import ncsys.com.isms.hierarchy.service.model.RglDetail;
import ncsys.com.isms.hierarchy.service.model.Version;

import org.springframework.stereotype.Service;


@Service("regulationService")
public class RegulationServiceImpl implements RegulationService{

	@Resource(name="regulationMapper")
	private RegulationMapper regulationMapper;

	@Override
	public List<RegulationList> selectRegulationDetailList(RegulationList regulationList) throws Exception {
		return regulationMapper.selectRegulationDetailList(regulationList );
	}
	@Override
	public List<Version> selectVersion() throws Exception {
		return regulationMapper.selectVersion( );
	}
	@Override
	public List<Field> selectFiled() throws Exception {
		return regulationMapper.selectFiled( );
	}
	@Override
	public List<Regulation> selectRegulation() throws Exception {
		return regulationMapper.selectRegulation( );
	}
	@Override
	public void insertRegulationDetail(RegulationDetail regulationDetail) throws Exception{
		regulationMapper.insertRegulationDetail(regulationDetail);
		
	}
	@Override
	public void updateRegulationDetail(RegulationDetail regulationDetail) throws Exception{
		regulationMapper.updateRegulationDetail(regulationDetail);
		
	}
	@Override
	public void deleteRegulationDetail(RegulationDetail regulationDetail) throws Exception{
		regulationMapper.deleteRegulationDetail(regulationDetail);
		
	}
	@Override
	public RegulationDetail selectRegulationDetail(RegulationDetail regulationDetail) throws Exception {
		return regulationMapper.selectRegulationDetail(regulationDetail );
	}
	
	@Override
	public List<RegulationDetail> selectRegulationDetailByName(RegulationDetail regulationDetail) throws Exception{
		return regulationMapper.selectRegulationDetailByName(regulationDetail);
	}
	
	@Override
	public RegulationDetail selectRegulationDetailByFullname(RglDetail rglDetail) throws Exception{
		return regulationMapper.selectRegulationDetailByFullname(rglDetail); 
	}
	
	/* for field */
	@Override
	public void insertRegulationField(Field field) throws Exception{
		regulationMapper.insertRegulationField(field);
	}
	@Override
	public void updateRegulationField(Field field) throws Exception{
		regulationMapper.updateRegulationField(field);
	}
	@Override
	public void deleteRegulationField(Field field) throws Exception{
		regulationMapper.deleteRegulationField(field);
	}
	
	/* for field */
	@Override
	public void insertRegulation(Regulation regulation) throws Exception{
		regulationMapper.insertRegulation(regulation);
	}
	@Override
	public void updateRegulation(Regulation regulation) throws Exception{
		regulationMapper.updateRegulation(regulation);
	}
	@Override
	public void deleteRegulation(Regulation regulation) throws Exception{
		regulationMapper.deleteRegulation(regulation);
	}
	
	
	/* for version */
	@Override
	public void insertVersion(Version version) throws Exception{
		regulationMapper.insertVersion(version);
	}
	@Override
	public void updateVersion(Version version) throws Exception{
		regulationMapper.updateVersion(version);
	}
	@Override
	public void deleteVersion(Version version) throws Exception{
		regulationMapper.deleteVersion(version);
	}
	
	
	
	
	public Field selectRegulationFieldByName(Field field) throws Exception{
		return regulationMapper.selectRegulationFieldByName(field );
	}
	
	public Regulation selectRegulationByName(Regulation regulation) throws Exception{
		return regulationMapper.selectRegulationByName(regulation );
	}
	
	public Version selectVersionByName(Version version) throws Exception{
		return regulationMapper.selectVersionByName(version );
	}
	
	
}
