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
import ncsys.com.isms.weekTest.service.WeekTestService;
import ncsys.com.isms.weekTest.service.mapper.WeekTestMapper;
import ncsys.com.isms.weekTest.service.model.WeekTestField;
import ncsys.com.isms.weekTest.service.model.WeekTestItem;
import ncsys.com.isms.weekTest.service.model.WeekTestItemList;

import org.springframework.stereotype.Service;


@Service("weekTestService")
public class WeekTestServiceImpl implements WeekTestService{

	@Resource(name="weekTestMapper")
	private WeekTestMapper weekTestMapper;

	@Override
	public List<WeekTestItemList> selectWeekTestItemList(WeekTestItem weekTestItem) throws Exception {
		return weekTestMapper.selectWeekTestItemList(weekTestItem);
	}

	@Override
	public WeekTestItem selectWeekTestItem(WeekTestItem weekTestItem) throws Exception {
		return weekTestMapper.selectWeekTestItem(weekTestItem);
	}

	@Override
	public void insertWeekTestItem(WeekTestItem weekTestItem) throws Exception {
		weekTestMapper.insertWeekTestItem(weekTestItem);
	}

	@Override
	public void updateWeekTestItem(WeekTestItem weekTestItem) throws Exception {
		weekTestMapper.updateWeekTestItem(weekTestItem);
	}

	@Override
	public void deleteWeekTestItem(WeekTestItem weekTestItem) throws Exception {
		weekTestMapper.deleteWeekTestItem(weekTestItem);
	}

	@Override
	public List<WeekTestField> selectWeekTestFieldList() throws Exception {
		return weekTestMapper.selectWeekTestFieldList();
	}
	
	
}
