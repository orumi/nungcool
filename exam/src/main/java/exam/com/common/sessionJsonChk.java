package exam.com.common;

import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import exam.com.main.model.LoginUserVO;

public class sessionJsonChk extends HandlerInterceptorAdapter{
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        try {
        	request.setCharacterEncoding("UTF-8"); 
        	response.setContentType("text/html;charset=UTF-8");
        	
        	String resultMsg = "";
        	
        	LoginUserVO nLoginVO = (LoginUserVO)request.getSession().getAttribute("loginUserVO");
     		if(nLoginVO != null){
     		} else {
     			JSONObject nJson = new JSONObject();
     			nJson.put("CHECK_SESSION", "N");
     			
     			PrintWriter out = response.getWriter();
     	        out.write(nJson.toString());
     	        out.flush();
     	        out.close();
     	        
     			return false;
     		}
        } catch (Exception e) {
            e.printStackTrace();
        }
        //admin 세션key 존재시 main 페이지 이동
        return true;
    }

}
