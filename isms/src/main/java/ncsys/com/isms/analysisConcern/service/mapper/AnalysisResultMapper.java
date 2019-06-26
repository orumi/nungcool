package ncsys.com.isms.analysisConcern.service.mapper;

import java.util.List;

import ncsys.com.isms.analysisConcern.service.model.AnalysisResult;
import ncsys.com.isms.analysisConcern.service.model.AnalysisVer;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("analysisResultMapper")
public interface AnalysisResultMapper {
	
	/*  */
	public List<AnalysisResult> selectRegulationResult(AnalysisVer analysisVer);
	public List<AnalysisResult> selectCriteriaResult(AnalysisVer analysisVer);
	public List<AnalysisResult> selectConcernResult(AnalysisVer analysisVer);
    
}
