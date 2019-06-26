package exam.com.common.service;

import exam.com.detail.model.DetailVO;
import exam.com.main.model.LoginUserVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by owner1120 on 2016-01-26.
 */


public interface XMLService {


    //접수정보조회(수수료납부) Start
    public String selectXML(HashMap<String, String> map) throws Exception;




}
