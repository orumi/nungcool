package ncsys.com.isms.actual.service;

import java.util.List;

import ncsys.com.isms.actual.service.model.ActualDetail;
import ncsys.com.isms.actual.service.model.ActualFile;
import ncsys.com.isms.actual.service.model.ActualList;
import ncsys.com.isms.actual.service.model.ActualPimesDetail;
import ncsys.com.isms.actual.service.model.ActualPimesFile;
import ncsys.com.isms.actual.service.model.ActualPimesList;
import ncsys.com.isms.measure.service.model.Diagnosis;


public interface ActualPimesService {
	
	public List<Diagnosis> selectDignosisByYear(String year) throws Exception;
	public List<ActualPimesList> selectActualPimesList(ActualPimesList ActualPimesList) throws Exception;
	
	
	
	
	/* FOR DETAIL */
	public ActualPimesDetail selectActualDetail(ActualPimesDetail actualPimesDetail) throws Exception;	
	public int updateActualPimesDetail(ActualPimesDetail actualPimesDetail) throws Exception;
	public int deleteActualPimesDetail(ActualPimesDetail actualPimesDetail) throws Exception;
	
	public List<ActualPimesFile> selectActualFiles(ActualPimesFile actualPimesFile) throws Exception; 
	public int insertActualFile(ActualPimesFile actualPimesFile) throws Exception;
	public int deleteActualFile(ActualPimesFile actualPimesFile) throws Exception;
}
