package ncsys.com.isms.weekTest.service.impl;

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


@Service("weekTestDtlService")
public class WeekTestDtlServiceImpl implements WeekTestDtlService{

	@Resource(name="weekTestDtlMapper")
	private WeekTestDtlMapper weekTestDtlMapper;

	@Override
	public List<WeekTestDtlAsset> selectWeekTestDtlAsset(WeekTestDtlAsset weekTestDtlAsset) throws Exception {
		return weekTestDtlMapper.selectWeekTestDtlAsset(weekTestDtlAsset);
	}

	@Override
	public List<WeekTestDtlDetail> selectWeekTestDtlDetail(WeekTestDtlDetail weekTestDtlDetail) throws Exception {
		return weekTestDtlMapper.selectWeekTestDtlDetail(weekTestDtlDetail);
	}
	
	@Override
	public void deleteWeekTestDtl(WeekTestDtlDetail weekTestDtlDetail) throws Exception{
		weekTestDtlMapper.deleteWeekTestDtl(weekTestDtlDetail);
	}
	
	@Override
	public void insertWeekTestDtl(WeekTestDtlDetail weekTestDtlDetail) throws Exception{
		weekTestDtlMapper.insertWeekTestDtl(weekTestDtlDetail);
	}
	
	@Override
	public WeekTestDtlDetail selectWeekTestDetail(WeekTestDtlDetail weekTestDtlDetail) throws Exception{
		return weekTestDtlMapper.selectWeekTestDetail(weekTestDtlDetail);
	}

	@Override
	public void updateWeekTestDtl(WeekTestDtlDetail weekTestDtlDetail) throws Exception{
		weekTestDtlMapper.updateWeekTestDtl(weekTestDtlDetail);
	}
}
