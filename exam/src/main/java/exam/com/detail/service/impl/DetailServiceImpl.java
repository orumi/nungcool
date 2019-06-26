package exam.com.detail.service.impl;

import exam.com.detail.model.DetailVO;
import exam.com.detail.service.DetailService;
import exam.com.main.model.LoginUserVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by owner1120 on 2016-01-26.
 */
@Service("detailService")
public class DetailServiceImpl implements DetailService {

    @Resource(name = "detailDAO")
    DetailDAO detailDAO;

    @Override
    public List<DetailVO> selRecepInfoLookUp(Map map) throws Exception {
        return (List<DetailVO>) detailDAO.selRecepInfoLookUp(map);
    }


    @Override
    public int selRecepInfoCnt(Map map) throws Exception {
        int cnt = detailDAO.selRecepInfoCnt(map);
        return cnt;
    }


    @Override
    public List<DetailVO> selAnalProgState(Map map) throws Exception {
        return (List<DetailVO>) detailDAO.selAnalProgState(map);
    }

   

    @Override
    public int selAnalProgStateCnt(Map map) throws Exception {
        int cnt = detailDAO.selAnalProgStateCnt(map);
        return cnt;
    }


}
