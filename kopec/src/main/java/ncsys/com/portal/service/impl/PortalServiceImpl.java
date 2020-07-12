package ncsys.com.portal.service.impl;

import java.util.List;

import javax.annotation.Resource;

import ncsys.com.portal.service.PortalService;
import ncsys.com.portal.service.mapper.PortalMapper;
import ncsys.com.portal.service.model.LeftMenu;

import org.springframework.stereotype.Service;



@Service("portalService")
public class PortalServiceImpl implements PortalService{

	@Resource(name="portalMapper")
	private PortalMapper portalMapper;

	@Override
	public List<LeftMenu> selectLeftMenuList()  throws Exception {
		return portalMapper.selectLeftMenuList();
	}




}
