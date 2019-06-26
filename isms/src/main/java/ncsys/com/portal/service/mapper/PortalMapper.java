package ncsys.com.portal.service.mapper;

import java.util.List;

import ncsys.com.portal.service.model.LeftMenu;
import ncsys.com.portal.service.model.PlannedSchedule;
import egovframework.com.cmm.LoginVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("portalMapper")
public interface PortalMapper {
	
	public List<LeftMenu> selectLeftMenuList(LoginVO loginVO);
	
}
