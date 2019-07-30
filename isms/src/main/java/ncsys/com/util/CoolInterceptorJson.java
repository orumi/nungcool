package ncsys.com.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CoolInterceptorJson extends HandlerInterceptorAdapter{

	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        try {
        	request.setCharacterEncoding("UTF-8");
        	response.setContentType("text/html;charset=UTF-8");

        	System.out.println("CoolInterceptorJson");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

}
