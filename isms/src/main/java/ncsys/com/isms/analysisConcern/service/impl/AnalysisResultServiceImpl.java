package ncsys.com.isms.analysisConcern.service.impl;

import java.util.List;

import javax.annotation.Resource;

import ncsys.com.isms.analysisConcern.service.AnalysisResultService;
import ncsys.com.isms.analysisConcern.service.mapper.AnalysisResultMapper;
import ncsys.com.isms.analysisConcern.service.model.AnalysisResult;
import ncsys.com.isms.analysisConcern.service.model.AnalysisVer;

import org.springframework.stereotype.Service;


@Service("analysisResultService")
public class AnalysisResultServiceImpl implements AnalysisResultService{

	@Resource(name="analysisResultMapper")
	private AnalysisResultMapper analysisResultMapper;


	@Override
	public List<AnalysisResult> selectRegulationResult(AnalysisVer analysisVer) throws Exception {
		return analysisResultMapper.selectRegulationResult(analysisVer);
	}
	
	@Override
	public List<AnalysisResult> selectCriteriaResult(AnalysisVer analysisVer) throws Exception {
		return analysisResultMapper.selectCriteriaResult(analysisVer);
	}
	
	@Override
	public List<AnalysisResult> selectConcernResult(AnalysisVer analysisVer) throws Exception {
		return analysisResultMapper.selectConcernResult(analysisVer);
	}
	
	
}
