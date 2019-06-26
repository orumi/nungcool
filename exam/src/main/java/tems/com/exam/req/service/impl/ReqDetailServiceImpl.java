package tems.com.exam.req.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.exam.req.model.RequestItemDetailVO;
import tems.com.exam.req.service.ReqDetailService;
import tems.com.exam.req.service.impl.ReqDetailDAO;

@Service("ReqDetailService")
public class ReqDetailServiceImpl implements ReqDetailService {

    @Resource(name = "ReqDetailDAO")
    private ReqDetailDAO ReqDetailDAO;
	
     @Override
     public List<?> getReqItemList(RequestItemDetailVO reqItemDetailVO) throws Exception {
    	 return ReqDetailDAO.getReqItemList(reqItemDetailVO);
     }
     
}
