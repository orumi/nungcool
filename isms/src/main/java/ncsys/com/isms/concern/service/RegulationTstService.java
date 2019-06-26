package ncsys.com.isms.concern.service;

import java.util.List;

import ncsys.com.isms.concern.service.model.RegulationTst;
import ncsys.com.isms.concern.service.model.RegulationTstList;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlAsset;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlDetail;
import ncsys.com.isms.weekTest.service.model.WeekTestField;
import ncsys.com.isms.weekTest.service.model.WeekTestItem;
import ncsys.com.isms.weekTest.service.model.WeekTestItemList;


public interface RegulationTstService {

	public List<RegulationTstList> selectRegulationTst(RegulationTst regulationTst) throws Exception;
    
	public int deleteRegulationTst(RegulationTst regulationTst) throws Exception;
	public int insertRegulationTst(RegulationTst regulationTst) throws Exception;
	public int updateRegulationTst(RegulationTst regulationTst) throws Exception;


	public int adjustRegulationTst(RegulationTst regulationTst) throws Exception;
	
}
