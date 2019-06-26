package ncsys.com.isms.weekTest.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import ncsys.com.isms.weekTest.service.model.WeekTestAstRst;
import ncsys.com.isms.weekTest.service.model.WeekTestFieldRst;


public interface WeekTestRstService {

	/* week item */
	public List<WeekTestAstRst> selectWeekTestAstRst(String astverid) throws Exception;
    
    /* week field */
    public List<WeekTestFieldRst> selectWeekTestFieldRst(String astverid) throws Exception;
    public HashMap<String, String> selectWeekTestFieldSumRst(String astverid) throws Exception;
    
	public ArrayList<HashMap<String, String>> selectWeekTestFieldRstCrossTab(String astverid) throws Exception;
	
	
}
