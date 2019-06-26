package exam.com.common;

import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import exam.com.main.model.LoginUserVO;

public class sessionChk extends HandlerInterceptorAdapter{
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        try {
        	request.setCharacterEncoding("UTF-8"); 
        	response.setContentType("text/html;charset=UTF-8");
        	
        	String resultMsg = "";
        	LoginUserVO nLoginVO = (LoginUserVO)request.getSession().getAttribute("loginUserVO");
     		if(nLoginVO != null){
     			
     			//if(!MenuAuthCheck.AuthCheck(req)){
     				
     				
     				//response.sendRedirect(req.getContextPath()+"/index.do?ecd=1");
     				//return false;
     			//}
     		} else {
     			String reqURL = request.getRequestURI().toString();
            	String menu = request.getParameter("menu")!=null?request.getParameter("menu"):"";
            	String sub  = request.getParameter("sub")!=null?request.getParameter("sub"):"";
     	        
     			response.sendRedirect(request.getContextPath()+"/login.do?reqURL="+reqURL+"&sub="+sub+"&menu="+menu);
     			return false;
     		}
        } catch (Exception e) {
            e.printStackTrace();
        }
        //admin 세션key 존재시 main 페이지 이동
        return true;
    }

}
