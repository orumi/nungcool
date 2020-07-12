package ncsys.com.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CoolInterceptorJson extends HandlerInterceptorAdapter{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CoolInterceptorJson.class);
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        try { 
        	
        	LOGGER.info("called CoolInterceptorJson preHandle ..");
        	
        	request.setCharacterEncoding("UTF-8"); 
        	response.setContentType("text/html;charset=UTF-8");
        	
        	LOGGER.info("CoolInterceptorJson End");
        	
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

}