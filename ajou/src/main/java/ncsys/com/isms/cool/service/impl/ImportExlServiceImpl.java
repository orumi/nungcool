package ncsys.com.isms.cool.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.model.Asset;
import ncsys.com.isms.asset.service.model.AssetGroup;
import ncsys.com.isms.asset.service.model.AssetVersion;
import ncsys.com.isms.certification.service.CertiService;
import ncsys.com.isms.certification.service.model.CertiDetail;
import ncsys.com.isms.concern.service.ConcernDtlService;
import ncsys.com.isms.concern.service.ConcernService;
import ncsys.com.isms.concern.service.CriteriaItemService;
import ncsys.com.isms.concern.service.RegulationTstService;
import ncsys.com.isms.concern.service.model.ConcernDtlDetail;
import ncsys.com.isms.concern.service.model.ConcernItem;
import ncsys.com.isms.concern.service.model.CriteriaItem;
import ncsys.com.isms.concern.service.model.CriteriaVersion;
import ncsys.com.isms.concern.service.model.RegulationTst;
import ncsys.com.isms.cool.service.ImportExlService;
import ncsys.com.isms.hierarchy.service.InspectService;
import ncsys.com.isms.hierarchy.service.RegulationService;
import ncsys.com.isms.hierarchy.service.model.*;
import ncsys.com.isms.weekTest.service.WeekTestDtlService;
import ncsys.com.isms.weekTest.service.WeekTestService;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlDetail;
import ncsys.com.isms.weekTest.service.model.WeekTestFieldRst;
import ncsys.com.isms.weekTest.service.model.WeekTestItem;
import ncsys.com.util.commoncd.service.CommonCdService;
import ncsys.com.util.commoncd.service.model.CommonCd;

@Service("importExlService")
public class ImportExlServiceImpl implements ImportExlService{

	@Resource(name="regulationService")
	private RegulationService regulationService;
	
	@Resource(name="regulationTstService")
	private RegulationTstService regulationTstService;
	
	@Resource(name="inspectService")
	private InspectService inspectService;
	
	@Resource(name="certiService")
	private CertiService certiService;
	
	@Resource(name="commonCdService")
	private  CommonCdService commonCdService;
	
	@Resource(name="assetService")
	private  AssetService assetService;
	
	@Resource(name="weekTestService")
	private  WeekTestService weekTestService;
	
	@Resource(name="weekTestDtlService")
	private  WeekTestDtlService weekTestDtlService;
	
	
	@Resource(name="criteriaItemService")
	private  CriteriaItemService criteriaItemService;
	
	@Resource(name="concernService")
	private  ConcernService concernService;
	
	@Resource(name="concernDtlService")
	private  ConcernDtlService concernDtlService;
	
	
	/* 관리체계 통제항목 */
	@Override
	public List<RegulationDetail> adjustRegulationItem(LoginVO loginVO, RegulationDetail[] regulationDetail) throws Exception{
		
		List<RegulationDetail> errList = new ArrayList<RegulationDetail>();
		
		for (int i = 0; i < regulationDetail.length; i++) {
			RegulationDetail entity = regulationDetail[i];
			try {
				//select version
				Version tmpVersion = new Version();
				tmpVersion.setVernm(entity.getVernm());
				Version selectVersion = regulationService.selectVersionByName(tmpVersion);
				
				if(selectVersion == null ){
					tmpVersion.setSortby(String.valueOf((i+1)*100));
					tmpVersion.setUserId(loginVO.getId());
					regulationService.insertVersion(tmpVersion);
					entity.setVerid(tmpVersion.getVerid());
				} else {
					entity.setVerid(selectVersion.getVerid());
				}
				
				// select field
				Field tmpField = new Field();
				tmpField.setFldnm(entity.getFldnm());
				Field selectField = regulationService.selectRegulationFieldByName(tmpField);
				if(selectField == null ){
					tmpField.setSortby(String.valueOf((i+1)*100));
					tmpField.setUserId(loginVO.getId());
					regulationService.insertRegulationField(tmpField);
					
					entity.setFldid(tmpField.getFldid());
				} else {
					entity.setFldid(selectField.getFldid());
				}
				
				// select rgl
				Regulation tmpRegulation = new Regulation();
				tmpRegulation.setRglnm(entity.getRglnm());
				Regulation selectRegulation = regulationService.selectRegulationByName(tmpRegulation);
				if(selectRegulation==null){
					tmpRegulation.setSortby(String.valueOf((i+1)*100));
					tmpRegulation.setUserId(loginVO.getId());
					regulationService.insertRegulation(tmpRegulation);
					
					entity.setRglid(tmpRegulation.getRglid());
				} else {
					entity.setRglid(selectRegulation.getRglid());
				}
				
				
				entity.setSortby(String.valueOf((i+1)*100));
				entity.setUserId(loginVO.getId());
				
				//select rgldtl 
				List<RegulationDetail> reDetails = regulationService.selectRegulationDetailByName(entity);
				
				System.out.println("regdetail NM : "+entity.getRgldtlnm());
				
				
				if(reDetails.size() > 0 ){
					for (int j = 0; j < reDetails.size(); j++) {
						RegulationDetail dtl = reDetails.get(j);
						entity.setRgldtlid(dtl.getRgldtlid());
						regulationService.updateRegulationDetail(entity);	
					}
				} else {
					regulationService.insertRegulationDetail(entity);	
				}
				
/*				System.out.println("verid : "+entity.getVerid());*/
			
			} catch (Exception e) {
				System.out.println(e);
				errList.add(entity);
			}
		}
		
		
		return errList;
	}
	
	/* 관리체계 점검항목 */
	@Override
	public List<InspectDetail> adjustInspectItem(LoginVO loginVO, InspectDetail[] inspectDetail) throws Exception{
		
		List<InspectDetail> errList = new ArrayList<InspectDetail>();
		
		for (int i = 0; i < inspectDetail.length; i++) {
			InspectDetail entity = inspectDetail[i];
			try {
				// select regulationdetail 
				RegulationDetail rglDetail = regulationService.selectRegulationDetailByFullname(entity);
				if(rglDetail != null ){
					entity.setRgldtlid(rglDetail.getRgldtlid());
					entity.setUserId(loginVO.getId());
					
					InspectDetail tmpDetail = inspectService.selectInspectDetailByName(entity);
					
					System.out.println("regdetail NM : "+entity.getRgldtlnm());
					
					if(tmpDetail!=null){
						entity.setItemseq(tmpDetail.getItemseq());
						inspectService.updateInspectDetail(entity);
					} else {
						inspectService.insertInspectDetail(entity);
					}
					
					
				} else {
					throw new Exception();
				}
				
			} catch (Exception e) {
				System.out.println(e);
				errList.add(entity);
			}
		}
		
		
		return errList;
	}
	
	/* 관리체계 ISMS수행계획 */
	@Override
	public List<CertiDetail> adjustCertification(LoginVO loginVO, CertiDetail[] certiDetail) throws Exception{
		
		List<CertiDetail> errList = new ArrayList<CertiDetail>();

		/* 담당 구분 정보 */
		CommonCd commonCd = new CommonCd();
		commonCd.setCodeid("COM077");
		List<CommonCd> reCommonCd = commonCdService.selectCommonCdList(commonCd);
		
		for (int i = 0; i < certiDetail.length; i++) {
			CertiDetail entity = certiDetail[i];
			try {
				
				if(entity.getProofitem() == null || "".equals(entity.getProofitem())){
					throw new Exception("수행자료 정보가 필요합니다.");
				}
				
				// select regulationdetail 
				RegulationDetail rglDetail = regulationService.selectRegulationDetailByFullname(entity);
				if(rglDetail != null ){
					entity.setRgldtlid(rglDetail.getRgldtlid());
					entity.setUserId(loginVO.getId());
					if(setOwnerType(reCommonCd, entity)==0){
						throw new Exception("정보보호담당자형식이 잘못되었습니다.");
					}
					
					
					//System.out.println("regdetail NM : "+entity.getRgldtlnm());
					String[] aProofitem = entity.getProofitem().split("\r\n");
					
					for (int j = 0; j < aProofitem.length; j++) {
						if(aProofitem[j]!=null && !"".equals(aProofitem[j])){
							entity.setProofitem(aProofitem[j]);
							CertiDetail tmpDetail = certiService.selectCertiDetailByName(entity);
							
							if(tmpDetail!=null){
								entity.setProofid(tmpDetail.getProofid());
								certiService.updateCertiDetail(entity);
							} else {
								certiService.insertCertiDetail(entity);
							}
						}
					}
					
				} else {
					throw new Exception("통제항목이 존재하지 않습니다.");
				}
				
			} catch (Exception e) {
				System.out.println(e);
				entity.setProcessmsg(e.getMessage());
				errList.add(entity);
			}
		}
		
		
		return errList;
	}
	
	
	private int setOwnerType(List<CommonCd> listCommonCd, CertiDetail certiDetail){
		
		for (int i = 0; i < listCommonCd.size(); i++) {
			if(certiDetail.getOwnertypenm().equals(listCommonCd.get(i).getCodenm())){
				certiDetail.setOwnertype(listCommonCd.get(i).getCode());
				return 1;
			}
		}
		
		return 0;
		
	}
	
	/* 자산정보 */
	@Override
	public List<Asset> adjustAsset(LoginVO loginVO, Asset[] asset) throws Exception{
		
		List<Asset> errList = new ArrayList<Asset>();

		for (int i = 0; i < asset.length; i++) {
			Asset entity = asset[i];
			try {
				AssetVersion tmpVersion = new AssetVersion();
				tmpVersion.setAstvernm(entity.getAstvernm());
				
				AssetVersion selectVersion = assetService.selectAssetVersionByName(tmpVersion);
				
				if(selectVersion == null ){
					tmpVersion.setSortby(String.valueOf((i+1)*100));
					tmpVersion.setUserId(loginVO.getId());
					assetService.insertAssetVersion(tmpVersion);
					entity.setAstverid(tmpVersion.getAstverid());
				} else {
					entity.setAstverid(selectVersion.getAstverid());
				}
				
				AssetGroup assetGroup = new AssetGroup();
				assetGroup.setAstgrpnm(entity.getAstgrpnm());
				
				AssetGroup selectAssetGroup = assetService.selectAssetGroupByName(assetGroup);
				
				if(selectAssetGroup == null) {
					throw new Exception("자산그룹정보가 없습니다.");
				} else {
					entity.setAstgrpid(selectAssetGroup.getAstgrpid());
				}
				
				Asset tmpAsset = assetService.selectAssetByName(entity);
				
				
				
				if(tmpAsset != null){
					entity.setUserId(loginVO.getId());
					entity.setAssetid(tmpAsset.getAssetid());
					assetService.updateAsset(entity);
				} else {
					entity.setUserId(loginVO.getId());
					assetService.insertAsset(entity);
				}
				
				
			} catch (Exception e) {
				System.out.println(e);
				errList.add(entity);
			}
		}
		
		
		return errList;
	}
	
	/* 취약점 항목 */
	@Override
	public List<WeekTestItem> adjustWeekTestItem(LoginVO loginVO, WeekTestItem[] weekTestItem) throws Exception{
		
		List<WeekTestItem> errList = new ArrayList<WeekTestItem>();

		/* 담당 구분 정보 */
		CommonCd commonCd = new CommonCd();
		commonCd.setCodeid("COM079");
		List<CommonCd> reCommonCd = commonCdService.selectCommonCdList(commonCd);
		
		for (int i = 0; i < weekTestItem.length; i++) {
			WeekTestItem entity = weekTestItem[i];
			try {
				//select asstgroup
				AssetGroup assetGroup = new AssetGroup();
				assetGroup.setAstgrpnm(entity.getAstgrpnm());
				
				AssetGroup selectAssetGroup = assetService.selectAssetGroupByName(assetGroup);
				if(selectAssetGroup == null) {
					throw new Exception("자산분류정보가 없습니다.");
				} else {
					entity.setAstgrpid(selectAssetGroup.getAstgrpid());
				}
				
				//select field 
				if(setWktstFieldid(reCommonCd, entity) == 0){
					throw new Exception("점검영역정보가 없습니다.");
				}
				
				WeekTestItem selectWeekTestItem = weekTestService.selectWeekTestItem(entity);
				
				if(selectWeekTestItem!=null){
					entity.setUserId(loginVO.getId());
					entity.setOldAstgrpid(entity.getAstgrpid());
					entity.setOldTstitemcd(entity.getTstitemcd());
					
					weekTestService.updateWeekTestItem(entity);
				} else {
					entity.setUserId(loginVO.getId());
					weekTestService.insertWeekTestItem(entity);
				}
				
				
			} catch (Exception e) {
				System.out.println(e);
				errList.add(entity);
			}
		}
		
		
		return errList;
	}
	
	
	private int setWktstFieldid(List<CommonCd> listCommonCd, WeekTestItem weekTestItem){
		
		for (int i = 0; i < listCommonCd.size(); i++) {
			if(weekTestItem.getWktstfieldnm().equals(listCommonCd.get(i).getCodenm())){
				weekTestItem.setWktstfieldid(listCommonCd.get(i).getCode());
				return 1;
			}
		}
		
		return 0;
		
	}
	
	/* 취약점 결과 */
	@Override
	public List<WeekTestDtlDetail> adjustWeekTestResult(LoginVO loginVO, WeekTestDtlDetail[] weekTestDtlDetail) throws Exception{
		
		List<WeekTestDtlDetail> errList = new ArrayList<WeekTestDtlDetail>();

		for (int i = 0; i < weekTestDtlDetail.length; i++) {
			WeekTestDtlDetail entity = weekTestDtlDetail[i];
			try {
				
				// 자산 버전 
				AssetVersion tmpVersion = new AssetVersion();
				tmpVersion.setAstvernm(entity.getAstvernm());
				
				AssetVersion selectVersion = assetService.selectAssetVersionByName(tmpVersion);
				
				if(selectVersion == null ){
					throw new Exception();
				} else {
					entity.setAstverid(selectVersion.getAstverid());
				}
				
				// 자산구분
				AssetGroup assetGroup = new AssetGroup();
				assetGroup.setAstgrpnm(entity.getAstgrpnm());
				
				AssetGroup selectAssetGroup = assetService.selectAssetGroupByName(assetGroup);
				
				if(selectAssetGroup == null) {
					throw new Exception();
				} else {
					entity.setAstgrpid(selectAssetGroup.getAstgrpid());
				}
				
				Asset asset = new Asset();
				asset.setAstverid(entity.getAstverid());
				asset.setAstgrpid(entity.getAstgrpid());
				asset.setMgnno(entity.getMgnno());
				
				Asset selectAsset = assetService.selectAssetByName(asset);
				
				if(selectAsset == null){
					throw new Exception();
				} else {
					entity.setAssetid(selectAsset.getAssetid());
				}
								
				// 3. 자산구분에 대한 진단항목
				WeekTestItem weekTestItem = new WeekTestItem();
				weekTestItem.setAstgrpid(entity.getAstgrpid());
				weekTestItem.setTstitemcd(entity.getTstitemcd());
				
				WeekTestItem selectWeekTestItem = weekTestService.selectWeekTestItem(weekTestItem);
				if(selectWeekTestItem==null){
					throw new Exception();
				} else {

				}
				
				// 4. 결과 정보 가져오기 및 저장하기
				WeekTestDtlDetail selectWeekTestDtlDetail =  weekTestDtlService.selectWeekTestDetail(entity);
				entity.setUserId(loginVO.getId());
				if(selectWeekTestDtlDetail!=null){
					weekTestDtlService.updateWeekTestDtl(entity);
				} else {
					
					weekTestDtlService.insertWeekTestDtl(entity);
				}
				
				
			} catch (Exception e) {
				System.out.println(e);
				errList.add(entity);
			}
		}
		
		
		return errList;
	}
	
	/* 관리체계 위험정보 */
	@Override
	public List<RegulationTst> adjustRglEval(LoginVO loginVO, RegulationTst[] regulationTst) throws Exception {
		
		List<RegulationTst> errList = new ArrayList<RegulationTst>();

		
		for (int i = 0; i < regulationTst.length; i++) {
			RegulationTst entity = regulationTst[i];
			try {
				//select regulationdetail
				RegulationDetail rglDetail = regulationService.selectRegulationDetailByFullname(entity);
				if(rglDetail == null) {
					throw new Exception();
				} else {
					entity.setRgldtlid(rglDetail.getRgldtlid());
				}
				
				regulationTstService.adjustRegulationTst(entity);
				
				
			} catch (Exception e) {
				System.out.println(e);
				errList.add(entity);
			}
		}
		
		
		return errList;
	}	
	
	/* 법적준거성 평가 */
	@Override
	public List<CriteriaItem> adjustCriteria(LoginVO loginVO, CriteriaItem[] criteriaItem) throws Exception {
		
		List<CriteriaItem> errList = new ArrayList<CriteriaItem>();

		
		for (int i = 0; i < criteriaItem.length; i++) {
			CriteriaItem entity = criteriaItem[i];
			try {
				//select version
				CriteriaVersion tmpVersion = new CriteriaVersion();
				tmpVersion.setCtrvernm(entity.getCtrvernm());
				CriteriaVersion selectVersion = criteriaItemService.selectCriteriaVersionByName(tmpVersion);
				
				if(selectVersion == null ){
					tmpVersion.setSortby(String.valueOf((i+1)*100));
					tmpVersion.setUserId(loginVO.getId());
					criteriaItemService.insertCriteriaVersion(tmpVersion);
					entity.setCtrverid(tmpVersion.getCtrverid());
				} else {
					entity.setCtrverid(selectVersion.getCtrverid());
				}
				
				criteriaItemService.insertCriteriaItem(entity);
				
				
			} catch (Exception e) {
				System.out.println(e);
				errList.add(entity);
			}
		}
		
		
		return errList;
	}	
	
	/* 위협진단 항목 */
	@Override
	public List<ConcernItem> adjustCcnItem(LoginVO loginVO, ConcernItem[] concernItem) throws Exception {
		
		List<ConcernItem> errList = new ArrayList<ConcernItem>();

		
		for (int i = 0; i < concernItem.length; i++) {
			ConcernItem entity = concernItem[i];
			try {
				//select asstgroup
				AssetGroup assetGroup = new AssetGroup();
				assetGroup.setAstgrpnm(entity.getAstgrpnm());
				
				AssetGroup selectAssetGroup = assetService.selectAssetGroupByName(assetGroup);
				if(selectAssetGroup == null) {
					throw new Exception("자산분류정보가 없습니다.");
				} else {
					entity.setAstgrpid(selectAssetGroup.getAstgrpid());
				}
				
				ConcernItem selectConcernItem = concernService.selectConcernItem(entity);
				
				if(selectConcernItem!=null){
					entity.setUserId(loginVO.getId());
					entity.setOldAstgrpid(entity.getAstgrpid());
					entity.setOldCcnitemcd(entity.getCcnitemcd());
					
					concernService.updateConcernItem(entity);
				} else {
					entity.setUserId(loginVO.getId());
					concernService.insertConcernItem(entity);
				}
				
				
			} catch (Exception e) {
				System.out.println(e);
				errList.add(entity);
			}
		}
		
		
		return errList;
	}
	
	/* 위협진단 결과 등록 */
	@Override
	public List<ConcernDtlDetail> adjustCcnRst(LoginVO loginVO, ConcernDtlDetail[] concernDtlDetail) throws Exception {
		
		List<ConcernDtlDetail> errList = new ArrayList<ConcernDtlDetail>();

		
		for (int i = 0; i < concernDtlDetail.length; i++) {
			ConcernDtlDetail entity = concernDtlDetail[i];
			try {
				// 1. 자산버전 
				AssetVersion tmpVersion = new AssetVersion();
				tmpVersion.setAstvernm(entity.getAstvernm());
				
				AssetVersion selectVersion = assetService.selectAssetVersionByName(tmpVersion);
				
				if(selectVersion == null ){
					throw new Exception("자산버전정보가 일치하지 않습니다.");
				} else {
					entity.setAstverid(selectVersion.getAstverid());
				}
				
				// 2. 자산구분
				AssetGroup assetGroup = new AssetGroup();
				assetGroup.setAstgrpnm(entity.getAstgrpnm());
				
				AssetGroup selectAssetGroup = assetService.selectAssetGroupByName(assetGroup);
				
				if(selectAssetGroup == null) {
					throw new Exception("자사분류 정보가 일치하지 않습니다.");
				} else {
					entity.setAstgrpid(selectAssetGroup.getAstgrpid());
				}
				
				// 3. 자산 정보
				Asset asset = new Asset();
				asset.setAstverid(entity.getAstverid());
				asset.setAstgrpid(entity.getAstgrpid());
				asset.setMgnno(entity.getMgnno());
				
				Asset selectAsset = assetService.selectAssetByName(asset);
				
				if(selectAsset == null){
					throw new Exception("해당 자산정보가 없습니다.");
				} else {
					entity.setAssetid(selectAsset.getAssetid());
				}
				
				// 4. 자산구분에 대한 진단항목
				ConcernItem sConcernItem = new ConcernItem();
				sConcernItem.setAstgrpid(entity.getAstgrpid());
				sConcernItem.setCcnitemcd(entity.getCcnitemcd());
				
				ConcernItem selectConcernItem = concernService.selectConcernItem(sConcernItem);
				
				if(selectConcernItem == null){
					throw new Exception("자산에 대한 진단항목이 없습니다.");
				} else {

				}
				
				// 5. 결과 정보 가져오기 및 저장하기
				ConcernDtlDetail selectConcernDtlDetail =  concernDtlService.selectConcernDetail(entity);
				entity.setUserId(loginVO.getId());
				if(selectConcernDtlDetail != null){
					concernDtlService.updateConcernDtlDetail(entity); 
				} else {
					concernDtlService.insertConcernDtl(entity);
				}
				
				
			} catch (Exception e) {
				System.out.println(e);
				errList.add(entity);
			}
		}
		
		
		return errList;
	}


}
