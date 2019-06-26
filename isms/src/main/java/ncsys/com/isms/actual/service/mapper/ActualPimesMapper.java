package ncsys.com.isms.actual.service.mapper;

import java.util.List;

import ncsys.com.isms.actual.service.model.ActualDetail;
import ncsys.com.isms.actual.service.model.ActualFile;
import ncsys.com.isms.actual.service.model.ActualList;
import ncsys.com.isms.actual.service.model.ActualPimesDetail;
import ncsys.com.isms.actual.service.model.ActualPimesFile;
import ncsys.com.isms.actual.service.model.ActualPimesList;
import ncsys.com.isms.measure.service.model.Diagnosis;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("actualPimesMapper")
public interface ActualPimesMapper {
	
	public List<Diagnosis> selectDignosisByYear(String year);
	public List<ActualPimesList> selectActualPimesList(ActualPimesList actualPimesList);
	
	public ActualPimesDetail selectActualDetail(ActualPimesDetail actualPimesDetail);
	
	
	public int updateActualDetail(ActualPimesDetail actualPimesDetail);
	public int deleteActualDetail(ActualPimesDetail actualPimesDetail);
	
	
	/* attach file manage*/ 
	public List<ActualPimesFile> selectActualFiles(ActualPimesFile actualPimesFile);
	public int insertActualFile(ActualPimesFile actualPimesFile);
	public int deleteActualFile(ActualPimesFile actualPimesFile);
	
	
}
