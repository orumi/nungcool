package ncsys.com.isms.concern.service;

import java.util.List;

import ncsys.com.isms.concern.service.model.ConcernItem;


public interface ConcernService {

	/* week item */
	public List<ConcernItem> selectConcernItemList(ConcernItem concernItem) throws Exception;
    public ConcernItem selectConcernItem(ConcernItem concernItem) throws Exception;
    public int insertConcernItem(ConcernItem concernItem) throws Exception;
    public int updateConcernItem(ConcernItem concernItem) throws Exception;
    public int deleteConcernItem(ConcernItem concernItem) throws Exception;
    
}
