package exam.com.detail.service.impl;

/**
 * Created by owner1120 on 2016-01-26.
 */

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import exam.com.main.model.LoginUserVO;

import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

@Repository("detailDAO")
public class DetailDAO extends EgovComAbstractDAO {

    //접수정보조회(수수료납부) Start
    public List<?> selRecepInfoLookUp(Map map) {
        return list("detailDAO.selRecepInfoLookUp", map);
    }

    public Integer selRecepInfoCnt(Map map) {
        return (Integer) select("detailDAO.selRecepInfoCnt", map);
    }

    
    
    
    

    //분석진행상태 Start
    public List<?> selAnalProgState(Map map) {
        return list("detailDAO.selAnalProgState", map);
    }
    public Integer selAnalProgStateCnt (Map map){
        return (Integer) select("detailDAO.selAnalProgStateCnt", map);
    }
   

}
