package ncsys.com.isms.weekTest.service;

import java.util.List;

import ncsys.com.isms.weekTest.service.model.WeekTestField;
import ncsys.com.isms.weekTest.service.model.WeekTestItem;
import ncsys.com.isms.weekTest.service.model.WeekTestItemList;


public interface WeekTestService {

	/* week item */
	public List<WeekTestItemList> selectWeekTestItemList(WeekTestItem weekTestItem) throws Exception;
    public WeekTestItem selectWeekTestItem(WeekTestItem weekTestItem) throws Exception;
    public void insertWeekTestItem(WeekTestItem weekTestItem) throws Exception;
    public void updateWeekTestItem(WeekTestItem weekTestItem) throws Exception;
    public void deleteWeekTestItem(WeekTestItem weekTestItem) throws Exception;
    
    /* week field */
    public List<WeekTestField> selectWeekTestFieldList() throws Exception;
	
}
