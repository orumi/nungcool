package ncsys.com.isms.concern.service.mapper;

import java.util.List;

import ncsys.com.isms.concern.service.model.RegulationTst;
import ncsys.com.isms.concern.service.model.RegulationTstList;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlAsset;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlDetail;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("regulationTstMapper")
public interface RegulationTstMapper {
	
	/*  */
	public List<RegulationTstList> selectRegulationTst(RegulationTst regulationTst);
    
	public int deleteRegulationTst(RegulationTst regulationTst);
	public int insertRegulationTst(RegulationTst regulationTst);
	public int updateRegulationTst(RegulationTst regulationTst);

	
}
