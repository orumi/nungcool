package ncsys.com.isms.asset.service.impl;

import java.util.List;

import javax.annotation.Resource;

import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.mapper.AssetMapper;
import ncsys.com.isms.asset.service.model.Asset;
import ncsys.com.isms.asset.service.model.AssetGroup;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.asset.service.model.AssetGrp;
import ncsys.com.isms.asset.service.model.AssetGrpCnt;
import ncsys.com.isms.asset.service.model.AssetKind;
import ncsys.com.isms.asset.service.model.AssetVersion;
import ncsys.com.isms.hierarchy.service.RegulationService;
import ncsys.com.isms.hierarchy.service.mapper.RegulationMapper;
import ncsys.com.isms.hierarchy.service.model.Field;
import ncsys.com.isms.hierarchy.service.model.Regulation;
import ncsys.com.isms.hierarchy.service.model.RegulationDetail;
import ncsys.com.isms.hierarchy.service.model.RegulationList;
import ncsys.com.isms.hierarchy.service.model.Version;

import org.springframework.stereotype.Service;


@Service("assetService")
public class AssetServiceImpl implements AssetService{

	@Resource(name="assetMapper")
	private AssetMapper assetMapper;

	@Override
	public List<AssetVersion> selectAssetVersionList() throws Exception {
		return assetMapper.selectAssetVersionList();
	}

	@Override
	public AssetVersion selectAssetVersionDetail(AssetVersion assetVersion) throws Exception {
		return assetMapper.selectAssetVersionDetail(assetVersion);
	}

	@Override
	public void insertAssetVersion(AssetVersion assetVersion) throws Exception {
		assetMapper.insertAssetVersion(assetVersion);
	}

	@Override
	public void updateAssetVersion(AssetVersion assetVersion) throws Exception {
		assetMapper.updateAssetVersion(assetVersion);
	}

	@Override
	public void deleteAssetVersion(AssetVersion assetVersion) throws Exception {
		assetMapper.deleteAssetVersion(assetVersion);
	}
	
	@Override
	public AssetVersion selectAssetVersionByName(AssetVersion assetVersion) throws Exception {
		return assetMapper.selectAssetVersionByName(assetVersion);
	}
	
	
	
	@Override
	public List<AssetKind> selectAssetKind() throws Exception {
		return assetMapper.selectAssetKind();
	}

	@Override
	public List<AssetGroupList> selectAssetGroupList() throws Exception {
		return assetMapper.selectAssetGroupList();
	}
	
	@Override
	public List<AssetGrpCnt> selectAssetGrpCntList(AssetGrpCnt assetGrpCnt) throws Exception {
		return assetMapper.selectAssetGrpCntList(assetGrpCnt);
	}

	@Override
	public AssetGroup selectAssetGroupDetail(AssetGroup assetGroup) throws Exception {
		return assetMapper.selectAssetGroupDetail(assetGroup);
	}

	@Override
	public void insertAssetGroup(AssetGroup assetGroup) throws Exception {
		assetMapper.insertAssetGroup(assetGroup);
	}

	@Override
	public void updateAssetGroup(AssetGroup assetGroup) throws Exception {
		assetMapper.updateAssetGroup(assetGroup);
		
	}

	@Override
	public void deleteAssetGroup(AssetGroup assetGroup) throws Exception {
		assetMapper.deleteAssetGroup(assetGroup);
	}

	@Override
	public AssetGroup selectAssetGroupByName(AssetGrp assetGrp) throws Exception {
		return assetMapper.selectAssetGroupByName(assetGrp);
	}
	
	
	
	
	
	
	@Override
	public List<Asset> selectAssetList(Asset asset) throws Exception {
		return assetMapper.selectAssetList(asset);
	}

	@Override
	public Asset selectAssetDetail(Asset asset) throws Exception {
		return assetMapper.selectAssetDetail(asset);
	}

	@Override
	public void insertAsset(Asset asset) throws Exception {
		assetMapper.insertAsset(asset);
	}

	@Override
	public void updateAsset(Asset asset) throws Exception {
		assetMapper.updateAsset(asset);		
	}

	@Override
	public void deleteAsset(Asset asset) throws Exception {
		assetMapper.deleteAsset(asset);
	}

	@Override
	public Asset selectAssetByName(Asset asset) throws Exception {
		return assetMapper.selectAssetByName(asset);
	}
	
	
	
}
