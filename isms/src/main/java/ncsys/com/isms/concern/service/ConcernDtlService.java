package ncsys.com.isms.concern.service;

import java.util.List;

import ncsys.com.isms.concern.service.model.ConcernDtlAsset;
import ncsys.com.isms.concern.service.model.ConcernDtlDetail;


public interface ConcernDtlService {

	/* week item */
	public List<ConcernDtlAsset> selectConcernDtlAsset(ConcernDtlAsset concernDtlAsset) throws Exception;
    
    /* week detail */
    public List<ConcernDtlDetail> selectConcernDtlDetail(ConcernDtlDetail concernDtlDetail) throws Exception;

    public int deleteConcernDtl(ConcernDtlDetail concernDtlDetail) throws Exception;
	public int insertConcernDtl(ConcernDtlDetail concernDtlDetail) throws Exception;
	
	public int updateConcernDtlDetail(ConcernDtlDetail concernDtlDetail) throws Exception;
	public ConcernDtlDetail selectConcernDetail(ConcernDtlDetail concernDtlDetail) throws Exception;
}
