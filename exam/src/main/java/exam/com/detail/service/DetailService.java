package exam.com.detail.service;

import exam.com.detail.model.DetailVO;
import exam.com.main.model.LoginUserVO;

import java.util.List;
import java.util.Map;

/**
 * Created by owner1120 on 2016-01-26.
 */


public interface DetailService {


    //접수정보조회(수수료납부) Start..
    public List<DetailVO> selRecepInfoLookUp(Map map) throws Exception;

    public int selRecepInfoCnt(Map map) throws Exception;


    //분석진행상태 Start
    public List<DetailVO> selAnalProgState(Map map) throws Exception;

    public int selAnalProgStateCnt(Map map) throws Exception;


}
