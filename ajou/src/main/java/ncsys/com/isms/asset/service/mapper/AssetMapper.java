package ncsys.com.isms.asset.service.mapper;

import java.util.List;

import ncsys.com.isms.asset.service.model.Asset;
import ncsys.com.isms.asset.service.model.AssetGroup;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.asset.service.model.AssetGrp;
import ncsys.com.isms.asset.service.model.AssetGrpCnt;
import ncsys.com.isms.asset.service.model.AssetKind;
import ncsys.com.isms.asset.service.model.AssetVersion;
import ncsys.com.isms.hierarchy.service.model.*;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("assetMapper")
public interface AssetMapper {
	
	/* asset version */
	public List<AssetVersion> selectAssetVersionList ();
	public AssetVersion selectAssetVersionDetail (AssetVersion assetVersion);
	public void insertAssetVersion (AssetVersion assetVersion);
	public void updateAssetVersion (AssetVersion assetVersion);
	public void deleteAssetVersion (AssetVersion assetVersion);
	public AssetVersion selectAssetVersionByName(AssetVersion assetVersion);
	
	/* asset group */
	public List<AssetKind> selectAssetKind ();
	public List<AssetGroupList> selectAssetGroupList ();
	public List<AssetGrpCnt> selectAssetGrpCntList (AssetGrpCnt assetGrpCnt);
	public AssetGroup selectAssetGroupDetail (AssetGroup assetGroup);
	public void insertAssetGroup (AssetGroup assetGroup);
	public void updateAssetGroup (AssetGroup assetGroup);
	public void deleteAssetGroup (AssetGroup assetGroup);
	public AssetGroup selectAssetGroupByName(AssetGrp assetGrp);
	
	
	/* asset */
	public List<Asset> selectAssetList (Asset asset);
	public Asset selectAssetDetail (Asset asset);
	public void insertAsset (Asset asset);
	public void updateAsset (Asset asset);
	public void deleteAsset (Asset asset);
	public Asset selectAssetByName(Asset asset);
}
