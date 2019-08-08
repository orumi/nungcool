package tems.com.system.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import tems.com.common.MenuAuthCheck;
import tems.com.common.StringUtils;
import tems.com.login.model.LoginUserVO;
import tems.com.system.model.AuthorGrpVO;
import tems.com.system.model.AuthorListVO;
import tems.com.system.service.AuthorGrpService;
import tems.com.testSample.model.TestItemVO;
import tems.com.testSample.service.TestItemService;
import egovframework.com.cmm.ComDefaultCodeVO;

@Controller
public class AuthorGrpController {

	@Resource(name = "AuthorGrpService")
    private AuthorGrpService authorGrpService;

	/**
     *
     * @exception Exception
     */
    @RequestMapping(value="/system/AuthorGrpList.do")
    public String AuthorGrpList(
    		HttpServletRequest req,
    		ModelMap model) throws Exception {

      	return "tems/com/system/AuthorGrpList";
    }

    @RequestMapping(value="/system/selAuthorGrpList.json")
    public @ResponseBody List<AuthorGrpVO>  selAuthorGrpList(
    		AuthorGrpVO authorGrpVO
    		) throws Exception{
    	List<AuthorGrpVO> authorGrpList = authorGrpService.getAuthorGrpList(authorGrpVO);
        return authorGrpList;
    }

    @RequestMapping(value="/system/delAuthorGrpList.json")
    public @ResponseBody List<AuthorGrpVO>  delAuthorGrpList(
    		AuthorGrpVO authorGrpVO,
    		HttpServletRequest req
    		) throws Exception{

        String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));

        for(int i = 0; i < jarray.size(); i++){
        	AuthorGrpVO vo = (AuthorGrpVO)JSONObject.toBean(jarray.getJSONObject(i), AuthorGrpVO.class);
        	authorGrpService.delAuthorGrpList(vo);
        }


    	List<AuthorGrpVO> authorGrpList = authorGrpService.getAuthorGrpList(authorGrpVO);
        return authorGrpList;
    }

    @RequestMapping(value="/system/edtAuthorGrpList.json")
    public @ResponseBody List<AuthorGrpVO>  edtAuthorGrpList(
    		AuthorGrpVO authorGrpVO,
    		HttpServletRequest req
    		) throws Exception{

    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));


        for(int i = 0; i < jarray.size(); i++){
        	AuthorGrpVO vo = (AuthorGrpVO)JSONObject.toBean(jarray.getJSONObject(i), AuthorGrpVO.class);
        	vo.setRegid(user.getAdminid());
        	if(vo.getState().equals("created")){
        		authorGrpService.inAuthorGrpList(vo);
        	} else if(vo.getState().equals("updated")){
        		authorGrpService.upAuthorGrpList(vo);
        	}

        }

    	List<AuthorGrpVO> authorGrpList = authorGrpService.getAuthorGrpList(authorGrpVO);
        return authorGrpList;
    }



    @RequestMapping(value="/system/selAuthorList.json")
    public @ResponseBody List<AuthorListVO>  selAuthorList(
    		AuthorListVO authorListVO,
    		HttpServletRequest req
    		) throws Exception{

    	authorListVO.setAuthorgpcode(StringUtils.nvl(req.getParameter("gpcode"),""));
    	List<AuthorListVO> authorList = authorGrpService.getAuthorList(authorListVO);
        return authorList;
    }


    @RequestMapping(value="/system/edtAuthorList.json")
    public @ResponseBody List<AuthorListVO>  edtAuthorList(
    		AuthorListVO authorListVO,
    		HttpServletRequest req
    		) throws Exception{

    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	String gpcode = StringUtils.nvl(req.getParameter("gpcode"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));


    	authorListVO.setAuthorgpcode(gpcode);
    	authorGrpService.delAuthorList(authorListVO);

        for(int i = 0; i < jarray.size(); i++){
        	AuthorListVO vo = (AuthorListVO)JSONObject.toBean(jarray.getJSONObject(i), AuthorListVO.class);
        	vo.setRegid(user.getAdminid());
        	vo.setAuthorgpcode(gpcode);
        		authorGrpService.inAuthorList(vo);
        }

        authorListVO.setAuthorgpcode(StringUtils.nvl(req.getParameter("gpcode"),""));
    	List<AuthorListVO> authorList = authorGrpService.getAuthorList(authorListVO);
        return authorList;
    }
}
