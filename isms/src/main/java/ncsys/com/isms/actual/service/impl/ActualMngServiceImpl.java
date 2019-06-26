package ncsys.com.isms.actual.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import ncsys.com.isms.actual.service.ActualMngService;
import ncsys.com.isms.actual.service.mapper.ActualMngMapper;
import ncsys.com.isms.actual.service.model.ActualDetail;
import ncsys.com.isms.actual.service.model.ActualFile;
import ncsys.com.isms.actual.service.model.ActualList;


@Service("actualMngService")
public class ActualMngServiceImpl implements ActualMngService{

	@Resource(name="actualMngMapper")
	private ActualMngMapper actualMngMapper;

	@Override
	public List<ActualList> selectActualList(ActualList ActualList) throws Exception {
		return actualMngMapper.selectActualList(ActualList );
	}
	
	
	@Override
	public void insertActualDetail(ActualDetail ActualDetail) throws Exception{
		actualMngMapper.insertActualDetail(ActualDetail);
		
	}
	@Override
	public void updateActualDetail(ActualDetail ActualDetail) throws Exception{
		
		int reval = actualMngMapper.updateActualDetail(ActualDetail);
		if(reval < 1){
			actualMngMapper.insertActualDetail(ActualDetail);
		}
	}
	
	@Override
	public void deleteActualDetail(ActualDetail ActualDetail) throws Exception{
		actualMngMapper.deleteActualDetail(ActualDetail);
		
	}
	@Override
	public ActualDetail selectActualDetail(ActualDetail ActualDetail) throws Exception {
		return actualMngMapper.selectActualDetail(ActualDetail );
	}
	
	@Override
	public List<ActualFile> selectActualFiles(ActualFile actualFile) throws Exception {
		return actualMngMapper.selectActualFiles(actualFile); 
	}
	 
	@Override
	public void insertActualFile(ActualFile actualFile) throws Exception {
		actualMngMapper.insertActualFile(actualFile);
	}
	
	@Override
	public void deleteActualFile(ActualFile actualFile) throws Exception {
		actualMngMapper.deleteActualFile(actualFile);
	}
	
}
