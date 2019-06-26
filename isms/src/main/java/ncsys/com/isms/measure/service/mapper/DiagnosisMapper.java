package ncsys.com.isms.measure.service.mapper;

import java.util.List;

import ncsys.com.isms.measure.service.model.*;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("diagnosisMapper")
public interface DiagnosisMapper {
	
	public List<Version> selectPiversion();
	public List<Diagnosis> selectDiagnosis();
	
	public void insertDiagnosisDetail(Diagnosis diagnosis);
	public void updateDiagnosisDetail(Diagnosis diagnosis);
	public void deleteDiagnosisDetail(Diagnosis diagnosis);
	
	public void deleteResetDiagnosisDetail(Diagnosis diagnosis);
	public void insertResetDiagnosisDetail(Diagnosis diagnosis);
	
	public List<DiagnosisList> selectDiagnosisDetailList(DiagnosisList diagnosisList);
	
	public void updateDiagnosisWeight(Weight weight);
	
	
	
	
	
	
	

	
	

	
	/* FOR FILED */
	public void insertMeasureField(Field field);
	public void updateMeasureField(Field field);
	public void deleteMeasureField(Field field);
	
	/* FOR REGULATION */
	public void insertMeasure(Measure regulation);
	public void updateMeasure(Measure regulation);
	public void deleteMeasure(Measure regulation);
	
	
	
	/* FOR VERSION */
	public void insertVersion(Version version);
	public void updateVersion(Version version);
	public void deleteVersion(Version version);
	
}
