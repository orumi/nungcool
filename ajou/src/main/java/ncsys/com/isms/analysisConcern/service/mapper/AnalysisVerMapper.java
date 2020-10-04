package ncsys.com.isms.analysisConcern.service.mapper;

import java.util.List;

import ncsys.com.isms.analysisConcern.service.model.AnalysisVer;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("analysisVerMapper")
public interface AnalysisVerMapper {
	
	/* week item */
	public List<AnalysisVer> selectAnalysisVerList();
    public AnalysisVer selectAnalysisVer(AnalysisVer analysisVer);
    public int insertAnalysisVer(AnalysisVer analysisVer);
    public int updateAnalysisVer(AnalysisVer analysisVer);
    public int deleteAnalysisVer(AnalysisVer analysisVer);
    
}
