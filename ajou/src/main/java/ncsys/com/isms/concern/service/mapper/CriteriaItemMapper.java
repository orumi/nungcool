package ncsys.com.isms.concern.service.mapper;

import java.util.List;

import ncsys.com.isms.concern.service.model.CriteriaItem;
import ncsys.com.isms.concern.service.model.CriteriaVersion;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("criteriaItemMapper")
public interface CriteriaItemMapper {
	
	/*  */
	public List<CriteriaVersion> selectCriteriaVersion();
    
	public int insertCriteriaVersion(CriteriaVersion criteriaVersion);
	public int updateCriteriaVersion(CriteriaVersion criteriaVersion);
	public int deleteCriteriaVersion(CriteriaVersion criteriaVersion);
	
	public CriteriaVersion selectCriteriaVersionByName(CriteriaVersion criteriaVersion);
	
    public List<CriteriaItem> selectCriteriaItem(CriteriaItem criteriaItem);
    
	public int insertCriteriaItem(CriteriaItem criteriaItem);
	public int updateCriteriaItem(CriteriaItem criteriaItem);
	public int deleteCriteriaItem(CriteriaItem criteriaItem);
	
	public CriteriaItem selectCriteriaItemDetail(CriteriaItem criteriaItem);
	

	
}
