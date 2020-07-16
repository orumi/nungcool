package ncsys.com.util;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;



public class CoolInterceptor extends HandlerInterceptorAdapter{

	private static final Logger LOGGER = LoggerFactory.getLogger(CoolInterceptor.class);


	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        try {
        	LOGGER.info("called CoolInterceptor preHandle ..");


        	String userId = (String)request.getSession().getAttribute("userId");

        	if(userId == null){
        		response.sendRedirect(request.getContextPath()+"/jsp/web/loginProc.jsp");
        		return false;
        	}

        	request.setCharacterEncoding("UTF-8");
        	response.setContentType("text/html;charset=UTF-8");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

}
