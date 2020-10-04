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
import ncsys.com.isms.concern.service.mapper.ConcernItemMapper;
import ncsys.com.isms.concern.service.model.ConcernItem;

import org.springframework.stereotype.Service;


@Service("concernService")
public class ConcernServiceImpl implements ncsys.com.isms.concern.service.ConcernService{

	@Resource(name="concernItemMapper")
	private ConcernItemMapper concernItemMapper;

	@Override
	public List<ConcernItem> selectConcernItemList(ConcernItem concernItem) throws Exception {
		return concernItemMapper.selectConcernItemList(concernItem);
	}

	@Override
	public ConcernItem selectConcernItem(ConcernItem concernItem) throws Exception {
		return concernItemMapper.selectConcernItem(concernItem);
	}

	@Override
	public int insertConcernItem(ConcernItem concernItem) throws Exception {
		return concernItemMapper.insertConcernItem(concernItem);
	}

	@Override
	public int updateConcernItem(ConcernItem concernItem) throws Exception {
		return concernItemMapper.updateConcernItem(concernItem);
	}

	@Override
	public int deleteConcernItem(ConcernItem concernItem) throws Exception {
		return concernItemMapper.deleteConcernItem(concernItem);
	}

	
}
