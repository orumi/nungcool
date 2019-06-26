package ncsys.com.isms.measure.service.impl;

import java.util.List;

import javax.annotation.Resource;

import ncsys.com.isms.hierarchy.service.RegulationService;
import ncsys.com.isms.hierarchy.service.mapper.RegulationMapper;
import ncsys.com.isms.measure.service.model.*;
import ncsys.com.isms.measure.service.DiagnosisService;
import ncsys.com.isms.measure.service.MeasureService;
import ncsys.com.isms.measure.service.mapper.DiagnosisMapper;
import ncsys.com.isms.measure.service.mapper.MeasureMapper;

import org.springframework.stereotype.Service;


@Service("diagnosisService")
public class DiagnosisServiceImpl implements DiagnosisService{

	@Resource(name="diagnosisMapper")
	private DiagnosisMapper diagnosisMapper;


	@Override
	public List<Version> selectPiversion() throws Exception {
		return diagnosisMapper.selectPiversion( );
	}
	@Override
	public List<Diagnosis> selectDiagnosis() throws Exception {
		return diagnosisMapper.selectDiagnosis( );
	}
	
	@Override
	public void insertDiagnosisDetail(Diagnosis diagnosis) throws Exception{
		diagnosisMapper.insertDiagnosisDetail(diagnosis);
		diagnosisMapper.insertResetDiagnosisDetail(diagnosis);
	}
	@Override
	public void updateDiagnosisDetail(Diagnosis diagnosis) throws Exception{
		diagnosisMapper.updateDiagnosisDetail(diagnosis);
		diagnosisMapper.deleteResetDiagnosisDetail(diagnosis);
		diagnosisMapper.insertResetDiagnosisDetail(diagnosis);
	}
	@Override
	public void deleteDiagnosisDetail(Diagnosis diagnosis) throws Exception{
		diagnosisMapper.deleteDiagnosisDetail(diagnosis);
		
	}
	@Override
	public List<DiagnosisList> selectDiagnosisDetailList(DiagnosisList diagnosisList) throws Exception {
		return diagnosisMapper.selectDiagnosisDetailList(diagnosisList);
	}
	@Override
	public void updateDiagnosisWeight(DiagnosisWeight diagnosisWeight) throws Exception{
		
		for (int i = 0; i < diagnosisWeight.getWgts().size(); i++) {
			diagnosisMapper.updateDiagnosisWeight( (Weight)diagnosisWeight.getWgts().get(i) );	
		}
		
	}
	
	
	
	
	
	

	
	/* for field */
	@Override
	public void insertMeasureField(Field field) throws Exception{
		diagnosisMapper.insertMeasureField(field);
	}
	@Override
	public void updateMeasureField(Field field) throws Exception{
		diagnosisMapper.updateMeasureField(field);
	}
	@Override
	public void deleteMeasureField(Field field) throws Exception{
		diagnosisMapper.deleteMeasureField(field);
	}
	
	/* for field */
	@Override
	public void insertMeasure(Measure measure) throws Exception{
		diagnosisMapper.insertMeasure(measure);
	}
	@Override
	public void updateMeasure(Measure measure) throws Exception{
		diagnosisMapper.updateMeasure(measure);
	}
	@Override
	public void deleteMeasure(Measure measure) throws Exception{
		diagnosisMapper.deleteMeasure(measure);
	}
	
	
	/* for version */
	@Override
	public void insertVersion(Version version) throws Exception{
		diagnosisMapper.insertVersion(version);
	}
	@Override
	public void updateVersion(Version version) throws Exception{
		diagnosisMapper.updateVersion(version);
	}
	@Override
	public void deleteVersion(Version version) throws Exception{
		diagnosisMapper.deleteVersion(version);
	}
	
	
	
	
}
