package ncsys.com.isms.measure.service.impl;

import java.util.List;

import javax.annotation.Resource;

import ncsys.com.isms.hierarchy.service.RegulationService;
import ncsys.com.isms.hierarchy.service.mapper.RegulationMapper;
import ncsys.com.isms.measure.service.model.*;
import ncsys.com.isms.measure.service.MeasureService;
import ncsys.com.isms.measure.service.mapper.MeasureMapper;
import ncsys.com.isms.measure.service.model.Measure;

import org.springframework.stereotype.Service;


@Service("measureService")
public class MeasureServiceImpl implements MeasureService{

	@Resource(name="measureMapper")
	private MeasureMapper measureMapper;

	@Override
	public List<MeasureList> selectMeasureDetailList(MeasureList measureList) throws Exception {
		return measureMapper.selectMeasureDetailList(measureList);
	}
	@Override
	public List<Version> selectVersion() throws Exception {
		return measureMapper.selectVersion( );
	}
	@Override
	public List<Field> selectFiled() throws Exception {
		return measureMapper.selectFiled( );
	}
	@Override
	public List<Measure> selectMeasure() throws Exception {
		return measureMapper.selectMeasure( );
	}
	@Override
	public void insertMeasureDetail(MeasureDetail measureDetail) throws Exception{
		measureMapper.insertMeasureDetail(measureDetail);
		
	}
	@Override
	public void updateMeasureDetail(MeasureDetail measureDetail) throws Exception{
		measureMapper.updateMeasureDetail(measureDetail);
		
	}
	@Override
	public void deleteMeasureDetail(MeasureDetail measureDetail) throws Exception{
		measureMapper.deleteMeasureDetail(measureDetail);
		
	}
	@Override
	public MeasureDetail selectMeasureDetail(MeasureDetail measureDetail) throws Exception {
		return measureMapper.selectMeasureDetail(measureDetail );
	}
	
	/* for field */
	@Override
	public void insertMeasureField(Field field) throws Exception{
		measureMapper.insertMeasureField(field);
	}
	@Override
	public void updateMeasureField(Field field) throws Exception{
		measureMapper.updateMeasureField(field);
	}
	@Override
	public void deleteMeasureField(Field field) throws Exception{
		measureMapper.deleteMeasureField(field);
	}
	
	/* for field */
	@Override
	public void insertMeasure(Measure measure) throws Exception{
		measureMapper.insertMeasure(measure);
	}
	@Override
	public void updateMeasure(Measure measure) throws Exception{
		measureMapper.updateMeasure(measure);
	}
	@Override
	public void deleteMeasure(Measure measure) throws Exception{
		measureMapper.deleteMeasure(measure);
	}
	
	
	/* for version */
	@Override
	public void insertVersion(Version version) throws Exception{
		measureMapper.insertVersion(version);
	}
	@Override
	public void updateVersion(Version version) throws Exception{
		measureMapper.updateVersion(version);
	}
	@Override
	public void deleteVersion(Version version) throws Exception{
		measureMapper.deleteVersion(version);
	}
	
	
	
	
}
