package tems.com.common;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import tems.com.login.model.LoginUserVO;

public class sessionChk extends HandlerInterceptorAdapter{
	
	@Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse response, Object handler) throws Exception {
        
		System.out.println(handler.toString() );
		
		try {
        	String resultMsg = "";
        	
        	if(!StringUtils.nvl(req.getParameter("req_menuNo"), "").equals("null") && !StringUtils.nvl(req.getParameter("req_menuNo"), "").equals("")){
        		req.getSession().setAttribute("menuId", req.getParameter("req_menuNo"));
        	}

        	LoginUserVO nLoginVO = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
     		if(nLoginVO != null){
     			if(!MenuAuthCheck.AuthCheck(req)){
     				
     				
     				response.sendRedirect(req.getContextPath()+"/index.do?ecd=1");
     				return false;
     			}
     		} else {
     			
     			response.sendRedirect(req.getContextPath()+"/index.do?ecd=2");
     			return false;
     		}
        } catch (Exception e) {
            e.printStackTrace();
        }
        //admin 세션key 존재시 main 페이지 이동
        return true;
    }

}
