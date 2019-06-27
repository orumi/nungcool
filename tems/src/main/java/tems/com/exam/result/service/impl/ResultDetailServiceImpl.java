package tems.com.exam.result.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.springframework.stereotype.Service;

import tems.com.common.StringUtils;
import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.ReqResultVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.req.service.ReqListService;
import tems.com.exam.req.service.impl.ReqDetailDAO;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;
import tems.com.exam.result.model.CalculationVO;
import tems.com.exam.result.model.CoopApprVO;
import tems.com.exam.result.model.ResultDetailVO;
import tems.com.exam.result.model.ResultlVO;
import tems.com.exam.result.model.SmpDetailVO;
import tems.com.exam.result.service.ResultDetailService;
import tems.com.exam.result.service.ResultListService;
import tems.com.login.model.LoginUserVO;

@Service("ResultDetailService")
public class ResultDetailServiceImpl implements ResultDetailService {

    @Resource(name = "ResultDetailDAO")
    private ResultDetailDAO resultDetailDAO;
    
    @Resource(name = "ReqDetailDAO")
    private ReqDetailDAO ReqDetailDAO;
	
    @Override
    public ResultDetailVO getResultDetail(SearchVO searchVO) throws Exception{
    	return resultDetailDAO.getResultDetail(searchVO);
    }
    
    @Override
    public List<?> getResultSmpList(SearchVO searchVO) throws Exception{
    	return resultDetailDAO.getResultSmpList(searchVO);
    }
    
    @Override
    public List<?> getResultList(SearchVO searchVO) throws Exception{
    	return resultDetailDAO.getResultList(searchVO);
    }
    
    @Override
    public void upResultDetail(ResultlVO resultlVO) throws Exception{
    	resultDetailDAO.upResultDetail(resultlVO);
    	
    	String adminid = StringUtils.nvl(resultlVO.getAdminid(),"");
    	
    	if(!adminid.equals("")){
	    	String[] adminids = adminid.split(",");
	    	
	    	ReqResultVO vo = new ReqResultVO();
	    	vo.setResultid(resultlVO.getResultid());
	    	
	    	ReqDetailDAO.delResultAssign(vo);	//담당자 지우고 새로 추가
	    	 for(int i=0;i<adminids.length;i++){
	    		 vo.setResultid(resultlVO.getResultid());
	    		 vo.setAdminid(adminids[i]);
	    		 vo.setRegid(resultlVO.getItemregid());
	    		 ReqDetailDAO.inResultAssign(vo);
	    	 }
    	}
    }
    
    @Override
    public List<?> getCalculation(SearchVO searchVO) throws Exception{
    	return resultDetailDAO.getCalculation(searchVO);
    }
    
    @Override
    public void inCalResult(CalculationVO calculationVO) throws Exception{
    	resultDetailDAO.inCalResult(calculationVO);
    }
    
    @Override
    public List<?> getResultListAll(SearchVO searchVO) throws Exception{
    	return resultDetailDAO.getResultListAll(searchVO);
    }
     
    @Override
    public SmpDetailVO getSmpDetail(SearchVO searchVO) throws Exception{
    	return (SmpDetailVO) resultDetailDAO.getSmpDetail(searchVO);
    }
    
    @Override
    public void inApprConf(HttpServletRequest req) throws Exception{
    	
    	LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	String data              = StringUtils.nvl(req.getParameter("data"),"");
    	String resultdata              = StringUtils.nvl(req.getParameter("resultdata"),"");
    	JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    	JSONArray resultjarray = JSONArray.fromObject(JSONSerializer.toJSON(resultdata));

    	String reqid = "";
    	for(int i = 0; i < jarray.size(); i++){
    		CoopApprVO vo = (CoopApprVO)JSONObject.toBean(jarray.getJSONObject(i), CoopApprVO.class);
        	
        	if(vo.getOrdinal().equals("1")){
        		vo.setApprstate("A");
        	} else {
        		vo.setApprstate("-");
        	}
        	
        	if(!reqid.equals(vo.getReqid())){
        		resultDetailDAO.delApprConf(vo);			//기존 결재 삭제
        	}
        	
    		vo.setRegid(user.getAdminid());
    		resultDetailDAO.inApprConf(vo);					//결재라인 저장
    		reqid = vo.getReqid();
    		
        }
    	
    	for(int j = 0; j < resultjarray.size(); j++){
    		CoopApprVO vo = (CoopApprVO)JSONObject.toBean(resultjarray.getJSONObject(j), CoopApprVO.class);
    		vo.setAdminid(user.getAdminid());
    		if(j == 0){
    			resultDetailDAO.delCoopReq(vo);			//기존 협조정보 삭제
    	    	resultDetailDAO.inCoopReq(vo);			//기존 협조정보 저장
    		}
        	resultDetailDAO.upCoopResult(vo);			//항목 협조로 변경
        }
    }
}
