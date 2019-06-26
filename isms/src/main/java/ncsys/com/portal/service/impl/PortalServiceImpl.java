package ncsys.com.portal.service.impl;

import java.util.List;

import javax.annotation.Resource;

import ncsys.com.portal.service.PortalService;
import ncsys.com.portal.service.mapper.PlannedScheduleMapper;
import ncsys.com.portal.service.mapper.PortalMapper;
import ncsys.com.portal.service.model.LeftMenu;
import ncsys.com.portal.service.model.PlannedSchedule;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;


@Service("portalService")
public class PortalServiceImpl implements PortalService{

	@Resource(name="portalMapper")
	private PortalMapper portalMapper;
	
	@Resource(name="plannedScheduleMapper")
	private PlannedScheduleMapper plannedScheduleMapper;

	@Resource(name="egovPlanScheduleMstrIdGnrService")
	private EgovIdGnrService planScheduleIdGnrService;	 
	
	
	
	@Override
	public List<LeftMenu> selectLeftMenuList(LoginVO loginVO)  throws Exception {
		return portalMapper.selectLeftMenuList(loginVO);
	}
	
	@Override
	public List<PlannedSchedule> selectPlannedScheduleTable() throws Exception {
		return plannedScheduleMapper.selectPlannedScheduleTable();
	}
	
	@Override
	public List<PlannedSchedule> selectPlannedScheduleList() throws Exception{
		return plannedScheduleMapper.selectPlannedScheduleList();
	}
	
	
	@Override
	public PlannedSchedule selectPlannedScheduleDetail(PlannedSchedule plannedSchedule) throws Exception{
		return plannedScheduleMapper.selectPlannedScheduleDetail(plannedSchedule);
	}
	
	@Override
	public void insertPlannedSchedule(PlannedSchedule plannedSchedule) throws Exception{
		String seqPlanId = planScheduleIdGnrService.getNextStringId();
		plannedSchedule.setPlanid(seqPlanId);
		
		plannedScheduleMapper.insertPlannedSchedule(plannedSchedule);
	}
	
	@Override
	public void updatePlannedSchedule(PlannedSchedule plannedSchedule) throws Exception{
		plannedScheduleMapper.updatePlannedSchedule(plannedSchedule);
	}
	
	@Override
	public void deletePlannedSchedule(PlannedSchedule plannedSchedule) throws Exception{
		plannedScheduleMapper.deletePlannedSchedule(plannedSchedule);
	}
	
	
	
	
}
