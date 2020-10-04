package ncsys.com.isms.analysisConcern.service;

import java.util.List;

import ncsys.com.isms.analysisConcern.service.model.AnalysisResult;
import ncsys.com.isms.analysisConcern.service.model.AnalysisVer;


public interface AnalysisResultService {

	public List<AnalysisResult> selectRegulationResult(AnalysisVer analysisVer) throws Exception;
	public List<AnalysisResult> selectCriteriaResult(AnalysisVer analysisVer) throws Exception;
	public List<AnalysisResult> selectConcernResult(AnalysisVer analysisVer) throws Exception;
    
}
