package tems.com.common;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import tems.com.login.model.UserMenuVO;

public class MenuAuthCheck {
	
	public static Boolean AuthCheck(HttpServletRequest req) {
		
		Boolean B = false;
		
		if("main".equals(req.getSession().getAttribute("menuId"))){
			B = true;
		} else {
			
			List<UserMenuVO> list = (List<UserMenuVO>) req.getSession().getAttribute("UserMenuList");
			for(int i=0;i<list.size();i++){
				UserMenuVO  menu = list.get(i);
				if(req.getSession().getAttribute("menuId").equals(menu.getMenuno())){
					B = true;
				}
			}
			
		}
		return B;
	}
}
