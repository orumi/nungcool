package ncsys.com.isms.asset.service;

import java.util.List;

import ncsys.com.isms.asset.service.model.Asset;
import ncsys.com.isms.asset.service.model.AssetGroup;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.asset.service.model.AssetGrp;
import ncsys.com.isms.asset.service.model.AssetGrpCnt;
import ncsys.com.isms.asset.service.model.AssetKind;
import ncsys.com.isms.asset.service.model.AssetVersion;
import ncsys.com.isms.hierarchy.service.model.*;


public interface AssetService {

	/* asset version */
	public List<AssetVersion> selectAssetVersionList () throws Exception;
	public AssetVersion selectAssetVersionDetail (AssetVersion assetVersion) throws Exception;
	public void insertAssetVersion (AssetVersion assetVersion) throws Exception;
	public void updateAssetVersion (AssetVersion assetVersion) throws Exception;
	public void deleteAssetVersion (AssetVersion assetVersion) throws Exception;
	public AssetVersion selectAssetVersionByName(AssetVersion assetVersion) throws Exception;
	
	/* asset group */
	public List<AssetKind> selectAssetKind () throws Exception;
	public List<AssetGroupList> selectAssetGroupList () throws Exception;
	public List<AssetGrpCnt> selectAssetGrpCntList (AssetGrpCnt assetGrpCnt) throws Exception;
	public AssetGroup selectAssetGroupDetail (AssetGroup assetGroup) throws Exception;
	public void insertAssetGroup (AssetGroup assetGroup) throws Exception;
	public void updateAssetGroup (AssetGroup assetGroup) throws Exception;
	public void deleteAssetGroup (AssetGroup assetGroup) throws Exception;
	public AssetGroup selectAssetGroupByName(AssetGrp assetGrp) throws Exception;
	
	/* asset */
	public List<Asset> selectAssetList (Asset asset) throws Exception;
	public Asset selectAssetDetail (Asset asset) throws Exception;
	public void insertAsset (Asset asset) throws Exception;
	public void updateAsset (Asset asset) throws Exception;
	public void deleteAsset (Asset asset) throws Exception;
	public Asset selectAssetByName(Asset asset) throws Exception;
	
}
