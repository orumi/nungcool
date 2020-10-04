package ncsys.com.isms.measure.service;

import java.util.List;

import ncsys.com.isms.measure.service.model.*;


public interface MeasureService {

	public List<MeasureList> selectMeasureDetailList(MeasureList measureList) throws Exception;
	
	public List<Version> selectVersion() throws Exception;
	public List<Field> selectFiled() throws Exception;
	public List<Measure> selectMeasure() throws Exception;
	
	
	
	
	
	/* FOR DETAIL */
	public void insertMeasureDetail(MeasureDetail measureDetail) throws Exception;
	public void updateMeasureDetail(MeasureDetail measureDetail) throws Exception;
	public void deleteMeasureDetail(MeasureDetail measureDetail) throws Exception;
	
	public MeasureDetail selectMeasureDetail(MeasureDetail regulationDetail) throws Exception;
	
	
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
