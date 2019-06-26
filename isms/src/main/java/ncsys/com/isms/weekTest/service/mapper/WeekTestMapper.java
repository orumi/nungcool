package ncsys.com.isms.weekTest.service.mapper;

import java.util.List;

import ncsys.com.isms.weekTest.service.model.WeekTestField;
import ncsys.com.isms.weekTest.service.model.WeekTestItem;
import ncsys.com.isms.weekTest.service.model.WeekTestItemList;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("weekTestMapper")
public interface WeekTestMapper {
	
	/* week item */
	public List<WeekTestItemList> selectWeekTestItemList(WeekTestItem weekTestItem);
    public WeekTestItem selectWeekTestItem(WeekTestItem weekTestItem);
    public void insertWeekTestItem(WeekTestItem weekTestItem);
    public void updateWeekTestItem(WeekTestItem weekTestItem);
    public void deleteWeekTestItem(WeekTestItem weekTestItem);
    
    /* week field */
    public List<WeekTestField> selectWeekTestFieldList();

}
