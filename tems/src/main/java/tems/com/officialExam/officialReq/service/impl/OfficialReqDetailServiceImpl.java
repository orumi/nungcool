package tems.com.officialExam.officialReq.service.impl;

import org.springframework.stereotype.Service;
import tems.com.common.StringUtils;
import tems.com.exam.req.model.*;
import tems.com.officialExam.officialReq.service.OfficialReqDetailService;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by owner1120 on 2016-03-07.
 */

@Service("officialReqDetailService")
public class OfficialReqDetailServiceImpl implements OfficialReqDetailService {


    @Resource(name = "officialReqDetailDAO")
    private OfficialReqDetailDAO officialReqDetailDAO;

    @Override
    public List<?> getReqItemList(RequestItemDetailVO reqItemDetailVO) throws Exception {
        return officialReqDetailDAO.getReqItemList(reqItemDetailVO);
    }


    @Override
    public ReqDetailVO getReqDetail(String reqid) throws Exception {
        return officialReqDetailDAO.getReqDetail(reqid);
    }


    @Override
    public void delRequest(String reqid) throws Exception {
        officialReqDetailDAO.delRequest(reqid);
    }


    @Override
    public void upReqRemark(ReqDetailVO reqDetailVO) throws Exception {
        officialReqDetailDAO.upReqRemark(reqDetailVO);
    }

    @Override
    public List<?> getReqSmpList(String reqid) throws Exception {
        return officialReqDetailDAO.getReqSmpList(reqid);
    }

    @Override
    public List<?> getReqResultList(ReqSmpListVO reqSmpListVO) throws Exception {
        return officialReqDetailDAO.getReqResultList(reqSmpListVO);
    }

    @Override
    public void delRequestResult(ReqResultVO reqResultVO) throws Exception {
        officialReqDetailDAO.delRequestResult(reqResultVO);
    }

    @Override
    public void delRequestResultAll(ReqResultVO reqResultVO) throws Exception {
        officialReqDetailDAO.delRequestResultAll(reqResultVO);
    }

    @Override
    public List<?> getItemList(String itemnm) throws Exception {
        return officialReqDetailDAO.getItemList(itemnm);
    }

    @Override
    public void addResultItem(ReqResultVO reqResultVO) throws Exception {
        officialReqDetailDAO.addResultItem(reqResultVO);
    }

    @Override
    public void addResultItemAll(ReqResultVO reqResultVO) throws Exception {
        officialReqDetailDAO.addResultItemAll(reqResultVO);
    }

    @Override
    public ItemMethodVO getItemMethodDetail(ReqResultVO reqResultVO) throws Exception {
        return officialReqDetailDAO.getItemMethodDetail(reqResultVO);
    }

    @Override
    public CondDetailVO getItemConditionDetail(ReqResultVO reqResultVO) throws Exception {
        return officialReqDetailDAO.getItemConditionDetail(reqResultVO);
    }

    @Override
    public void upResultDetail(ReqResultVO reqResultVO) throws Exception {

        officialReqDetailDAO.upResultDetail(reqResultVO);

        officialReqDetailDAO.delResultAssign(reqResultVO);

        String adminid = StringUtils.nvl(reqResultVO.getAdminid(), "");

        if(!adminid.equals("")){
            String[] adminids = reqResultVO.getAdminid().split(",");
            ReqResultVO vo = new ReqResultVO();
            for(int i=0;i<adminids.length;i++){
                vo.setResultid(reqResultVO.getResultid());
                vo.setAdminid(adminids[i]);
                vo.setRegid(reqResultVO.getRegid());
                officialReqDetailDAO.inResultAssign(vo);
            }
        }
    }

    @Override
    public void upResultDetailAll(ReqResultVO reqResultVO) throws Exception {
        officialReqDetailDAO.upResultDetailAll(reqResultVO);

        officialReqDetailDAO.delResultAssignAll(reqResultVO);

        officialReqDetailDAO.inResultAssignAll(reqResultVO);
    }

    @Override
    public ReqPriceVO selReqPrice(ReqSmpListVO reqSmpListVO) throws Exception{
        return officialReqDetailDAO.selReqPrice(reqSmpListVO);
    }

    @Override
    public String calPrice(ReqResultVO reqResultVO) throws Exception{
        return officialReqDetailDAO.calPrice(reqResultVO);
    }

    @Override
    public void upReqPrice(ReqPriceVO reqPriceVO) throws Exception{
        officialReqDetailDAO.upReqPrice(reqPriceVO);
    }

    @Override
    public List<?> selReqAttach(String reqid) throws Exception{
        return officialReqDetailDAO.selReqAttach(reqid);
    }
    
    
}
