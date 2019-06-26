package ncsys.com.portal.service;

import java.util.List;

import egovframework.com.cmm.LoginVO;
import ncsys.com.portal.service.model.LeftMenu;
import ncsys.com.portal.service.model.PlannedSchedule;


public interface PortalService {

	public List<LeftMenu> selectLeftMenuList(LoginVO loginVO) throws Exception;
	
	public List<PlannedSchedule> selectPlannedScheduleTable() throws Exception;
	
	public List<PlannedSchedule> selectPlannedScheduleList() throws Exception;
	public PlannedSchedule selectPlannedScheduleDetail(PlannedSchedule plannedSchedule) throws Exception;
	public void insertPlannedSchedule(PlannedSchedule plannedSchedule) throws Exception;
	public void updatePlannedSchedule(PlannedSchedule plannedSchedule) throws Exception;
	public void deletePlannedSchedule(PlannedSchedule plannedSchedule) throws Exception;
}
