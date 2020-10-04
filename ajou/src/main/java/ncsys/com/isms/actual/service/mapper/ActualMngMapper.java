package ncsys.com.isms.actual.service.mapper;

import java.util.List;

import ncsys.com.isms.actual.service.model.ActualDetail;
import ncsys.com.isms.actual.service.model.ActualFile;
import ncsys.com.isms.actual.service.model.ActualList;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("actualMngMapper")
public interface ActualMngMapper {
	
	public List<ActualList> selectActualList(ActualList actualList);
	public int insertActualDetail(ActualDetail actualDetail);
	public int updateActualDetail(ActualDetail actualDetail);
	public int deleteActualDetail(ActualDetail actualDetail);
	public ActualDetail selectActualDetail(ActualDetail actualDetail);
	
	/* attach file manage*/ 
	public List<ActualFile> selectActualFiles(ActualFile actualFile);
	public int insertActualFile(ActualFile actualFile);
	public int deleteActualFile(ActualFile actualFile);
	
	
}
