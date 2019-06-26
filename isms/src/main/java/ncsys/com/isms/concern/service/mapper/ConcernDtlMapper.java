package ncsys.com.isms.concern.service.mapper;

import java.util.List;

import ncsys.com.isms.concern.service.model.ConcernDtlAsset;
import ncsys.com.isms.concern.service.model.ConcernDtlDetail;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("concernDtlMapper")
public interface ConcernDtlMapper {
	
	/* week item */
	public List<ConcernDtlAsset> selectConcernDtlAsset(ConcernDtlAsset concernDtlAsset);
    
    /* week detail */
	public List<ConcernDtlDetail> selectConcernDtlDetail(ConcernDtlDetail concernDtlDetail);
	
	public int deleteConcernDtl(ConcernDtlDetail concernDtlDetail);
	public int insertConcernDtl(ConcernDtlDetail concernDtlDetail);
	public int updateConcernDtlDetail(ConcernDtlDetail concernDtlDetail);
	
	public ConcernDtlDetail selectConcernDetail(ConcernDtlDetail concernDtlDetail);
	
}
