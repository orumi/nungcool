package ncsys.com.isms.actual.service;

import java.util.List;

import ncsys.com.isms.actual.service.model.ActualDetail;
import ncsys.com.isms.actual.service.model.ActualFile;
import ncsys.com.isms.actual.service.model.ActualList;


public interface ActualMngService {

	public List<ActualList> selectActualList(ActualList ActualList) throws Exception;
	
	/* FOR DETAIL */
	public void insertActualDetail(ActualDetail ActualDetail) throws Exception;
	public void updateActualDetail(ActualDetail ActualDetail) throws Exception;
	public void deleteActualDetail(ActualDetail ActualDetail) throws Exception;
	public ActualDetail selectActualDetail(ActualDetail ActualDetail) throws Exception;	
	
	
	public List<ActualFile> selectActualFiles(ActualFile actualFile) throws Exception; 
	public void insertActualFile(ActualFile actualFile) throws Exception;
	public void deleteActualFile(ActualFile actualFile) throws Exception;
}
