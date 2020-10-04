package ncsys.com.isms.measure.service;

import java.util.List;

import ncsys.com.isms.measure.service.model.*;


public interface DiagnosisService {

	public List<DiagnosisList> selectDiagnosisDetailList(DiagnosisList diagnosisList) throws Exception;
	
	public List<Version> selectPiversion() throws Exception;
	public List<Diagnosis> selectDiagnosis() throws Exception;
	
		/* FOR DETAIL */
	public void insertDiagnosisDetail(Diagnosis diagnosis) throws Exception;
	public void updateDiagnosisDetail(Diagnosis diagnosis) throws Exception;
	public void deleteDiagnosisDetail(Diagnosis diagnosis) throws Exception;
	
	public void updateDiagnosisWeight(DiagnosisWeight diagnosisWeight) throws Exception;
	
	
	
	
	

	
	
	/* FOR FILED */
	public void insertMeasureField(Field field) throws Exception;
	public void updateMeasureField(Field field) throws Exception;
	public void deleteMeasureField(Field field) throws Exception;
	
	/* FOR REGULATION */
	public void insertMeasure(Measure measure) throws Exception;
	public void updateMeasure(Measure measure) throws Exception;
	public void deleteMeasure(Measure measure) throws Exception;
	
	
	/* FOR VERSION */
	public void insertVersion(Version version) throws Exception;
	public void updateVersion(Version version) throws Exception;
	public void deleteVersion(Version version) throws Exception;	
	
}
