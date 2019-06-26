package ncsys.com.isms.concern.service;

import java.util.List;

import ncsys.com.isms.concern.service.model.CriteriaItem;
import ncsys.com.isms.concern.service.model.CriteriaVersion;


public interface CriteriaItemService {

	public List<CriteriaVersion> selectCriteriaVersion() throws Exception;
    
	public int insertCriteriaVersion(CriteriaVersion criteriaVersion) throws Exception;
	public int updateCriteriaVersion(CriteriaVersion criteriaVersion) throws Exception;
	public int deleteCriteriaVersion(CriteriaVersion criteriaVersion) throws Exception;
	public CriteriaVersion selectCriteriaVersionByName(CriteriaVersion criteriaVersion) throws Exception;
	
    public List<CriteriaItem> selectCriteriaItem(CriteriaItem criteriaItem) throws Exception;
    
	public int insertCriteriaItem(CriteriaItem criteriaItem) throws Exception;
	public int updateCriteriaItem(CriteriaItem criteriaItem) throws Exception;
	public int deleteCriteriaItem(CriteriaItem criteriaItem) throws Exception;
	
	public CriteriaItem selectCriteriaItemDetail(CriteriaItem criteriaItem) throws Exception;
	
}
