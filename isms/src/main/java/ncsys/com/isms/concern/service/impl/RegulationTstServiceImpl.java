package ncsys.com.isms.concern.service.impl;

import java.util.List;

import javax.annotation.Resource;

import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.mapper.AssetMapper;
import ncsys.com.isms.asset.service.model.Asset;
import ncsys.com.isms.asset.service.model.AssetGroup;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.asset.service.model.AssetGrpCnt;
import ncsys.com.isms.asset.service.model.AssetKind;
import ncsys.com.isms.asset.service.model.AssetVersion;
import ncsys.com.isms.concern.service.RegulationTstService;
import ncsys.com.isms.concern.service.mapper.RegulationTstMapper;
import ncsys.com.isms.concern.service.model.RegulationTst;
import ncsys.com.isms.concern.service.model.RegulationTstList;
import ncsys.com.isms.weekTest.service.WeekTestDtlService;
import ncsys.com.isms.weekTest.service.WeekTestService;
import ncsys.com.isms.weekTest.service.mapper.WeekTestDtlMapper;
import ncsys.com.isms.weekTest.service.mapper.WeekTestMapper;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlAsset;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlDetail;
import ncsys.com.isms.weekTest.service.model.WeekTestField;
import ncsys.com.isms.weekTest.service.model.WeekTestItem;
import ncsys.com.isms.weekTest.service.model.WeekTestItemList;

import org.springframework.stereotype.Service;


@Service("regulationTstService")
public class RegulationTstServiceImpl implements RegulationTstService{

	@Resource(name="regulationTstMapper")
	private RegulationTstMapper regulationTstMapper;

	@Override
	public List<RegulationTstList> selectRegulationTst(RegulationTst regulationTst) throws Exception {
		return regulationTstMapper.selectRegulationTst(regulationTst);
	}
 
	@Override
	public int deleteRegulationTst(RegulationTst regulationTst) throws Exception {
		return regulationTstMapper.deleteRegulationTst(regulationTst);
	}
	
	@Override
	public int insertRegulationTst(RegulationTst regulationTst) throws Exception{
		return regulationTstMapper.insertRegulationTst(regulationTst);
	}
	
	@Override
	public int updateRegulationTst(RegulationTst regulationTst) throws Exception{
		return regulationTstMapper.updateRegulationTst(regulationTst);
	}
	
	@Override
	public int adjustRegulationTst(RegulationTst regulationTst) throws Exception{
		
		int reVal = 0;
		
		if( (reVal = regulationTstMapper.updateRegulationTst(regulationTst)) < 1 ){
			return regulationTstMapper.insertRegulationTst(regulationTst);
		}
		
		return reVal;
		
	}
	

}
