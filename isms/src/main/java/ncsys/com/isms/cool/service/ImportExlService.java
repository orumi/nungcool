package ncsys.com.isms.cool.service;

import java.util.List;

import egovframework.com.cmm.LoginVO;
import ncsys.com.isms.asset.service.model.Asset;
import ncsys.com.isms.certification.service.model.CertiDetail;
import ncsys.com.isms.concern.service.model.ConcernDtlDetail;
import ncsys.com.isms.concern.service.model.ConcernItem;
import ncsys.com.isms.concern.service.model.CriteriaItem;
import ncsys.com.isms.concern.service.model.RegulationTst;
import ncsys.com.isms.hierarchy.service.model.*;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlDetail;
import ncsys.com.isms.weekTest.service.model.WeekTestFieldRst;
import ncsys.com.isms.weekTest.service.model.WeekTestItem;


public interface ImportExlService {

	public List<RegulationDetail> adjustRegulationItem(LoginVO loginVO, RegulationDetail[] regulationDetail) throws Exception;
	public List<InspectDetail> adjustInspectItem(LoginVO loginVO, InspectDetail[] inspectDetail) throws Exception;
	public List<CertiDetail> adjustCertification(LoginVO loginVO, CertiDetail[] certiDetail) throws Exception;

	public List<Asset> adjustAsset(LoginVO loginVO, Asset[] asset) throws Exception;
	public List<WeekTestItem> adjustWeekTestItem(LoginVO loginVO, WeekTestItem[] weekTestItem) throws Exception;
	public List<WeekTestDtlDetail> adjustWeekTestResult(LoginVO loginVO, WeekTestDtlDetail[] weekTestDtlDetail) throws Exception;
	
	
	public List<RegulationTst> adjustRglEval(LoginVO loginVO, RegulationTst[] regulationTst) throws Exception;
	public List<CriteriaItem> adjustCriteria(LoginVO loginVO, CriteriaItem[] criteriaItem) throws Exception;
	public List<ConcernItem> adjustCcnItem(LoginVO loginVO, ConcernItem[] concernItem) throws Exception;
	public List<ConcernDtlDetail> adjustCcnRst(LoginVO loginVO, ConcernDtlDetail[] concernDtlDetail) throws Exception;
	
}
