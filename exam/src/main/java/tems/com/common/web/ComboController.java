package tems.com.common.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

public class ComboController {
	
	/**
     * 접수내역 리스트조회한다.
     * @exception Exception
     */
    @RequestMapping(value="/getComboData.json")
    public String selectMenuManageList(
    		HttpServletRequest req,
    		ModelMap model) throws Exception {
    	
      	return "";
    }
	
}
