package ncsys.com.portal.service.mapper;

import java.util.List;

import ncsys.com.portal.service.model.PlannedSchedule;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("plannedScheduleMapper")
public interface PlannedScheduleMapper {
	
	public List<PlannedSchedule> selectPlannedScheduleTable();
	
	public List<PlannedSchedule> selectPlannedScheduleList();
	public PlannedSchedule selectPlannedScheduleDetail(PlannedSchedule plannedSchedule);
	
	public void insertPlannedSchedule(PlannedSchedule plannedSchedule);
	public void updatePlannedSchedule(PlannedSchedule plannedSchedule);
	public void deletePlannedSchedule(PlannedSchedule plannedSchedule);
	
	
}
