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
