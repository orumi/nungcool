package ncsys.com.isms.weekTest.service;

import java.util.List;

import ncsys.com.isms.weekTest.service.model.WeekTestDtlAsset;
import ncsys.com.isms.weekTest.service.model.WeekTestDtlDetail;
import ncsys.com.isms.weekTest.service.model.WeekTestField;
import ncsys.com.isms.weekTest.service.model.WeekTestItem;
import ncsys.com.isms.weekTest.service.model.WeekTestItemList;


public interface WeekTestDtlService {

	/* week item */
	public List<WeekTestDtlAsset> selectWeekTestDtlAsset(WeekTestDtlAsset weekTestDtlAsset) throws Exception;
    
    /* week detail */
    public List<WeekTestDtlDetail> selectWeekTestDtlDetail(WeekTestDtlDetail weekTestDtlDetail) throws Exception;

    public void deleteWeekTestDtl(WeekTestDtlDetail weekTestDtlDetail) throws Exception;
	public void insertWeekTestDtl(WeekTestDtlDetail weekTestDtlDetail) throws Exception;
	
	public WeekTestDtlDetail selectWeekTestDetail(WeekTestDtlDetail weekTestDtlDetail) throws Exception;
	public void updateWeekTestDtl(WeekTestDtlDetail weekTestDtlDetail) throws Exception;
}
