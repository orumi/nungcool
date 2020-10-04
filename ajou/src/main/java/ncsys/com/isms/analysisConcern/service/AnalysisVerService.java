package ncsys.com.isms.analysisConcern.service;

import java.util.List;

import ncsys.com.isms.analysisConcern.service.model.AnalysisVer;


public interface AnalysisVerService {


	/* analysis version */
	public List<AnalysisVer> selectAnalysisVerList() throws Exception;
    public AnalysisVer selectAnalysisVer(AnalysisVer analysisVer) throws Exception;
    public int insertAnalysisVer(AnalysisVer analysisVer) throws Exception;
    public int updateAnalysisVer(AnalysisVer analysisVer) throws Exception;
    public int deleteAnalysisVer(AnalysisVer analysisVer) throws Exception;
    
    
}
