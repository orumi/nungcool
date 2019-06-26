package exam.com.common.service.impl;

/**
 * Created by owner1120 on 2016-01-26.
 */

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import exam.com.main.model.LoginUserVO;

import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("xmlDAO")
public class XMLDAO extends EgovComAbstractDAO {

    public List<?> selectXmlReport(HashMap<String, String> map) {
        return list("xmlDAO.selectXmlReport", map);
    }
    
    public List<?> selectXmlItem(HashMap<String, String> map){
    	return list("xmlDAO.selectXmlItem", map);
    }

   

}
