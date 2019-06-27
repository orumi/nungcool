package tems.com.exam.req.service.impl;

import org.springframework.stereotype.Service;
import tems.com.common.StringUtils;
import tems.com.exam.req.model.*;
import tems.com.exam.req.service.ReqDetailService;

import javax.annotation.Resource;
import java.util.List;

@Service("ReqDetailService")
public class ReqDetailServiceImpl implements ReqDetailService {

     @Resource(name = "ReqDetailDAO")
     private ReqDetailDAO ReqDetailDAO;
	
     @Override
     public List<?> getReqItemList(RequestItemDetailVO reqItemDetailVO) throws Exception {
    	 return ReqDetailDAO.getReqItemList(reqItemDetailVO);
     }
     
     
     @Override
     public ReqDetailVO getReqDetail(String reqid) throws Exception {
    	 return ReqDetailDAO.getReqDetail(reqid);
     }
     
     
     @Override
     public void delRequest(String reqid) throws Exception {
    	 ReqDetailDAO.delRequest(reqid);
     }
     
     
     @Override
     public void upReqRemark(ReqDetailVO reqDetailVO) throws Exception {
    	 ReqDetailDAO.upReqRemark(reqDetailVO);
     }
     
     @Override
     public List<?> getReqSmpList(String reqid) throws Exception {
    	 return ReqDetailDAO.getReqSmpList(reqid);
     }
     
     @Override
     public List<?> getReqResultList(ReqSmpListVO reqSmpListVO) throws Exception {
    	 return ReqDetailDAO.getReqResultList(reqSmpListVO);
     }
     
     @Override
     public void delRequestResult(ReqResultVO reqResultVO) throws Exception {
    	 ReqDetailDAO.delRequestResult(reqResultVO);
     }
     
     @Override
     public void delRequestResultAll(ReqResultVO reqResultVO) throws Exception {
    	 ReqDetailDAO.delRequestResultAll(reqResultVO);
     }
     
     @Override
     public List<?> getItemList(String itemnm) throws Exception {
    	 return ReqDetailDAO.getItemList(itemnm);
     }
     
     @Override
     public void addResultItem(ReqResultVO reqResultVO) throws Exception {
    	 ReqDetailDAO.addResultItem(reqResultVO);
     }

     @Override
     public void addResultItemAll(ReqResultVO reqResultVO) throws Exception {
    	 ReqDetailDAO.addResultItemAll(reqResultVO);
     }
     
     @Override
     public ItemMethodVO getItemMethodDetail(ReqResultVO reqResultVO) throws Exception {
    	 return ReqDetailDAO.getItemMethodDetail(reqResultVO);
     }
     
     @Override
     public CondDetailVO getItemConditionDetail(ReqResultVO reqResultVO) throws Exception {
    	 return ReqDetailDAO.getItemConditionDetail(reqResultVO);
     }
     
     @Override
     public void upResultDetail(ReqResultVO reqResultVO) throws Exception {
    	 
    	 ReqDetailDAO.upResultDetail(reqResultVO);
    	 
    	 ReqDetailDAO.delResultAssign(reqResultVO);
    	 
    	 String adminid = StringUtils.nvl(reqResultVO.getAdminid(),"");
    	 
    	 if(!adminid.equals("")){
	    	 String[] adminids = reqResultVO.getAdminid().split(",");
	    	 ReqResultVO vo = new ReqResultVO();
	    	 for(int i=0;i<adminids.length;i++){
	    		 vo.setResultid(reqResultVO.getResultid());
	    		 vo.setAdminid(adminids[i]);
	    		 vo.setRegid(reqResultVO.getRegid());
	    		 ReqDetailDAO.inResultAssign(vo);
	    	 }
    	 }
     }
     
     @Override
     public void upResultDetailAll(ReqResultVO reqResultVO) throws Exception {
    	 ReqDetailDAO.upResultDetailAll(reqResultVO);
    	 
    	 ReqDetailDAO.delResultAssignAll(reqResultVO);
    	 
    	 ReqDetailDAO.inResultAssignAll(reqResultVO);
    	 
    	 /*String adminid = StringUtils.nvl(reqResultVO.getAdminid(),"");
    	 
    	 if(!adminid.equals("")){
	    	 String[] adminids = reqResultVO.getAdminid().split(",");
	    	 ReqResultVO vo = new ReqResultVO();
	    	 for(int i=0;i<adminids.length;i++){
	    		 vo.setResultid(reqResultVO.getResultid());
	    		 vo.setAdminid(adminids[i]);
	    		 vo.setRegid(reqResultVO.getRegid());
	    		 ReqDetailDAO.inResultAssignAll(vo);
	    	 }
    	 }*/
     }
     
     @Override
     public ReqPriceVO selReqPrice(ReqSmpListVO reqSmpListVO) throws Exception{
    	 return ReqDetailDAO.selReqPrice(reqSmpListVO);
     }
     
     @Override
     public String calPrice(ReqResultVO reqResultVO) throws Exception{
    	 return ReqDetailDAO.calPrice(reqResultVO);
     }
     
     @Override
     public void upReqPrice(ReqPriceVO reqPriceVO) throws Exception{
    	 ReqDetailDAO.upReqPrice(reqPriceVO);
     }
     
     @Override
     public List<?> selReqAttach(String reqid) throws Exception{
    	 return ReqDetailDAO.selReqAttach(reqid);
     }
     
     
}
