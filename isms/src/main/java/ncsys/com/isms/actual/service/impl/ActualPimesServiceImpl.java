package ncsys.com.isms.actual.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import ncsys.com.isms.actual.service.ActualPimesService;
import ncsys.com.isms.actual.service.mapper.ActualPimesMapper;
import ncsys.com.isms.actual.service.model.ActualDetail;
import ncsys.com.isms.actual.service.model.ActualFile;
import ncsys.com.isms.actual.service.model.ActualList;
import ncsys.com.isms.actual.service.model.ActualPimesDetail;
import ncsys.com.isms.actual.service.model.ActualPimesFile;
import ncsys.com.isms.actual.service.model.ActualPimesList;
import ncsys.com.isms.measure.service.model.Diagnosis;


@Service("actualPimesService")
public class ActualPimesServiceImpl implements ActualPimesService{

	@Resource(name="actualPimesMapper")
	private ActualPimesMapper actualPimesMapper;

	 
	@Override
	public List<Diagnosis> selectDignosisByYear(String year) throws Exception {
		return actualPimesMapper.selectDignosisByYear(year);
	}
	@Override
	public List<ActualPimesList> selectActualPimesList(ActualPimesList actualPimesList) throws Exception {
		return actualPimesMapper.selectActualPimesList(actualPimesList);
	}

	
	@Override
	public ActualPimesDetail selectActualDetail(ActualPimesDetail actualPimesDetail) throws Exception {
		return actualPimesMapper.selectActualDetail(actualPimesDetail );
	}
	 
	@Override
	public List<ActualPimesFile> selectActualFiles(ActualPimesFile actualPimesFile) throws Exception {
		return actualPimesMapper.selectActualFiles(actualPimesFile); 
	}
	
	
	@Override
	public int updateActualPimesDetail(ActualPimesDetail actualPimesDetail) throws Exception {
		return actualPimesMapper.updateActualDetail(actualPimesDetail);
	} 
	@Override
	public int deleteActualPimesDetail(ActualPimesDetail actualPimesDetail) throws Exception {
		return actualPimesMapper.deleteActualDetail(actualPimesDetail);
	} 
	
	@Override
	public int insertActualFile(ActualPimesFile actualPimesFile) throws Exception {
		return actualPimesMapper.insertActualFile(actualPimesFile);
	}
	
	@Override
	public int deleteActualFile(ActualPimesFile actualPimesFile) throws Exception {
		return actualPimesMapper.deleteActualFile(actualPimesFile);
	}
	
}
