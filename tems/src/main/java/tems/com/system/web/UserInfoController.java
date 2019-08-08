package tems.com.system.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.common.StringUtils;
import tems.com.login.model.LoginUserVO;
import tems.com.system.model.AuthorGrpVO;
import tems.com.system.model.AuthorListVO;
import tems.com.system.model.OfficeListVO;
import tems.com.system.model.OfficeUserListVO;
import tems.com.system.service.UserInfoService;

@Controller
public class UserInfoController {

	@Resource(name = "UserInfoService")
    private UserInfoService UserInfoService;

	/**
     *
     * @exception Exception
     */
    @RequestMapping(value="/system/userInfoList.do")
    public String UserInfoList(
    		HttpServletRequest req,
    		ModelMap model) throws Exception {

      	return "tems/com/system/UserInfoList";
    }

    @RequestMapping(value="/system/selOfficeList.json")
    public @ResponseBody List<OfficeListVO>  selOfficeList(
    		) throws Exception{
    	List<OfficeListVO> UserInfoList = UserInfoService.getUserInfoList();
        return UserInfoList;
    }


    @RequestMapping(value="/system/selOfficeUserList.json")
    public @ResponseBody List<OfficeUserListVO>  selOfficeUserList(
    		HttpServletRequest req
    		) throws Exception{

    	String officeid  = StringUtils.nvl(req.getParameter("officeid"),"");

    	List<OfficeUserListVO> UserInfoList = UserInfoService.getOfficeUserList(officeid);

        return UserInfoList;
    }


    @RequestMapping(value="/system/edtOfficeUser.json")
    public void edtOfficeUser(
    		OfficeUserListVO officeUserListVO,
    		HttpServletRequest req,
    		HttpServletResponse response
    		) throws Exception{

    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

    	JSONObject nJson = new JSONObject();
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));

    	try{
	        for(int i = 0; i < jarray.size(); i++){
	        	OfficeUserListVO vo = (OfficeUserListVO)JSONObject.toBean(jarray.getJSONObject(i), OfficeUserListVO.class);
	        	vo.setModifyid(user.getAdminid());
	        	if(vo.getState().equals("updated")){
	        		UserInfoService.upOfficeUser(vo);
	        		nJson.put("RESULT_YN"     ,"Y");
	        		nJson.put("RESULT_MESSAGE","");
	        	}

	        }
    	}catch(Exception e){
      	  nJson.put("RESULT_YN"     ,"N");
          nJson.put("RESULT_MESSAGE",e.getMessage());
    	}
      PrintWriter out = response.getWriter();
      out.write(nJson.toString());
      out.flush();
      out.close();
    }


}
