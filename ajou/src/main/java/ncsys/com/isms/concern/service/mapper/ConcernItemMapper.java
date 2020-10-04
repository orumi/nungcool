package ncsys.com.isms.concern.service.mapper;

import java.util.List;

import ncsys.com.isms.concern.service.model.ConcernItem;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("concernItemMapper")
public interface ConcernItemMapper {
	
	/* week item */
	public List<ConcernItem> selectConcernItemList(ConcernItem concernItem);
    public ConcernItem selectConcernItem(ConcernItem concernItem);
    public int insertConcernItem(ConcernItem concernItem);
    public int updateConcernItem(ConcernItem concernItem);
    public int deleteConcernItem(ConcernItem concernItem);
    

}
