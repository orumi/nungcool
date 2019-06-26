package tems.com.testSample.web;

import java.util.List;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import tems.com.testSample.model.UserMasterDefaultVO;
import tems.com.testSample.model.UserMasterVO;
import tems.com.testSample.service.UserMasterService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : UserMasterController.java
 * @Description : UserMaster Controller class
 * @Modification Information
 *
 * @author test
 * @since 20150923
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=UserMasterVO.class)
public class UserMasterController {

    @Resource(name = "userMasterService")
    private UserMasterService userMasterService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * USER_MASTER 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 UserMasterDefaultVO
	 * @return "/userMaster/UserMasterList"
	 * @exception Exception
	 */
    @RequestMapping(value="/userMaster/UserMasterList.do")
    public String selectUserMasterList(@ModelAttribute("searchVO") UserMasterDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List<?> userMasterList = userMasterService.selectUserMasterList(searchVO);
        model.addAttribute("resultList", userMasterList);
        
        int totCnt = userMasterService.selectUserMasterListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "tems/com/testSample/userMaster/UserMasterList";
    } 
    
    @RequestMapping("/userMaster/addUserMasterView.do")
    public String addUserMasterView(
            @ModelAttribute("searchVO") UserMasterDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("userMasterVO", new UserMasterVO());
        return "tems/com/testSample/userMaster/UserMasterRegister";
    }
    
    @RequestMapping("/userMaster/addUserMaster.do")
    public String addUserMaster(
            UserMasterVO userMasterVO,
            @ModelAttribute("searchVO") UserMasterDefaultVO searchVO, SessionStatus status)
            throws Exception {
        userMasterService.insertUserMaster(userMasterVO);
        status.setComplete();
        return "forward:UserMasterList.do";
    }
    
    @RequestMapping("/userMaster/updateUserMasterView.do")
    public String updateUserMasterView(
            @RequestParam("tblUserId") java.lang.String tblUserId ,
            @ModelAttribute("searchVO") UserMasterDefaultVO searchVO, Model model)
            throws Exception {
        UserMasterVO userMasterVO = new UserMasterVO();
        userMasterVO.setTblUserId(tblUserId);
        // 변수명은 CoC 에 따라 userMasterVO
        model.addAttribute(selectUserMaster(userMasterVO, searchVO));
        return "tems/com/testSample/userMaster/UserMasterRegister";
    }

    @RequestMapping("/userMaster/selectUserMaster.do")
    public @ModelAttribute("userMasterVO")
    UserMasterVO selectUserMaster(
            UserMasterVO userMasterVO,
            @ModelAttribute("searchVO") UserMasterDefaultVO searchVO) throws Exception {
        return userMasterService.selectUserMaster(userMasterVO);
    }

    @RequestMapping("/userMaster/updateUserMaster.do")
    public  String updateUserMaster(
    		@ModelAttribute("userMasterVO") @Valid UserMasterVO userMasterVO,
            @ModelAttribute("searchVO") UserMasterDefaultVO searchVO, 
            SessionStatus status)
            throws Exception {
    	userMasterService.updateUserMaster(userMasterVO);
        status.setComplete();
        return "forward:UserMasterList.do";
    }
    
    @RequestMapping("/userMaster/deleteUserMaster.do")
    public String deleteUserMaster(
            UserMasterVO userMasterVO,
            @ModelAttribute("searchVO") UserMasterDefaultVO searchVO, SessionStatus status)
            throws Exception {
        userMasterService.deleteUserMaster(userMasterVO);
        status.setComplete();
        return "forward:UserMasterList.do";
    }

}
