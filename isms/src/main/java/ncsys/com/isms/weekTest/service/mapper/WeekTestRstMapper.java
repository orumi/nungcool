package ncsys.com.isms.weekTest.service.mapper;

import java.util.List;

import ncsys.com.isms.weekTest.service.model.WeekTestAstRst;
import ncsys.com.isms.weekTest.service.model.WeekTestFieldRst;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("weekTestRstMapper")
public interface WeekTestRstMapper {
	
	/* week item */
	public List<WeekTestAstRst> selectWeekTestAstRst(String astverid);
    
    /* week field */
    public List<WeekTestFieldRst> selectWeekTestFieldRst(String astverid);

    public List<WeekTestFieldRst> selectWeekTestFieldSumRst(String astverid);
    
}
