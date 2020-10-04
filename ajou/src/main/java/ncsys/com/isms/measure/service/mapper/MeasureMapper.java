package ncsys.com.isms.measure.service.mapper;

import java.util.List;

import ncsys.com.isms.measure.service.model.*;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("measureMapper")
public interface MeasureMapper {
	
	public List<Version> selectVersion();
	public List<Field> selectFiled();
	public List<Measure> selectMeasure();
	
	
	
	public List<MeasureList> selectMeasureDetailList(MeasureList measureList);
	

	
	
	public void insertMeasureDetail(MeasureDetail measureDetail);
	public void updateMeasureDetail(MeasureDetail measureDetail);
	public void deleteMeasureDetail(MeasureDetail measureDetail);
	public MeasureDetail selectMeasureDetail(MeasureDetail measureDetail);
	
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
