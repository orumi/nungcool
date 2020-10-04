package ncsys.com.isms.weekTest.service.mapper;

import java.util.List;

import ncsys.com.isms.weekTest.service.model.WeekTestDtlAsset;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlDetail;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("weekTestDtlMapper")
public interface WeekTestDtlMapper {
	
	/* week item */
	public List<WeekTestDtlAsset> selectWeekTestDtlAsset(WeekTestDtlAsset weekTestDtlAsset);
    
    /* week detail */
	public List<WeekTestDtlDetail> selectWeekTestDtlDetail(WeekTestDtlDetail weekTestDtlDetail);
	
	public void deleteWeekTestDtl(WeekTestDtlDetail weekTestDtlDetail);
	public void insertWeekTestDtl(WeekTestDtlDetail weekTestDtlDetail);
	
	public WeekTestDtlDetail selectWeekTestDetail(WeekTestDtlDetail weekTestDtlDetail);

	public void updateWeekTestDtl(WeekTestDtlDetail weekTestDtlDetail);
}
