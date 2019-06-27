package tems.com.officialExam.officialResult.service.impl;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.springframework.stereotype.Service;
import tems.com.common.StringUtils;
import tems.com.common.model.SearchVO;
import tems.com.exam.req.model.ReqResultVO;
import tems.com.login.model.LoginUserVO;
import tems.com.officialExam.officialReq.service.impl.OfficialReqDetailDAO;
import tems.com.officialExam.officialResult.model.*;
import tems.com.officialExam.officialResult.service.OfficialResultDetailService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service("officialResultDetailService")
public class OfficialResultDetailServiceImpl implements OfficialResultDetailService {

    @Resource(name = "officialResultDetailDAO")
    private OfficialResultDetailDAO officialResultDetailDAO;
    
    @Resource(name = "officialReqDetailDAO")
    private OfficialReqDetailDAO officialReqDetailDAO;
	
    @Override
    public ResultDetailVO getResultDetail(SearchVO searchVO) throws Exception{
    	return officialResultDetailDAO.getResultDetail(searchVO);
    }
    
    @Override
    public List<?> getResultSmpList(SearchVO searchVO) throws Exception{
    	return officialResultDetailDAO.getResultSmpList(searchVO);
    }
    
    @Override
    public List<?> getResultList(SearchVO searchVO) throws Exception{
    	return officialResultDetailDAO.getResultList(searchVO);
    }
    
    @Override
    public void upResultDetail(ResultlVO resultlVO) throws Exception{
		officialResultDetailDAO.upResultDetail(resultlVO);
    	
    	String adminid = StringUtils.nvl(resultlVO.getAdminid(),"");
    	
    	if(!adminid.equals("")){
	    	String[] adminids = adminid.split(",");
	    	
	    	ReqResultVO vo = new ReqResultVO();
	    	vo.setResultid(resultlVO.getResultid());

			officialReqDetailDAO.delResultAssign(vo);	//담당자 지우고 새로 추가
	    	 for(int i=0;i<adminids.length;i++){
	    		 vo.setResultid(resultlVO.getResultid());
	    		 vo.setAdminid(adminids[i]);
	    		 vo.setRegid(resultlVO.getItemregid());
				 officialReqDetailDAO.inResultAssign(vo);
	    	 }
    	}
    }
    
    @Override
    public List<?> getCalculation(SearchVO searchVO) throws Exception{
    	return officialResultDetailDAO.getCalculation(searchVO);
    }
    
    @Override
    public void inCalResult(CalculationVO calculationVO) throws Exception{
		officialResultDetailDAO.inCalResult(calculationVO);
    }
    
    @Override
    public List<?> getResultListAll(SearchVO searchVO) throws Exception{
    	return officialResultDetailDAO.getResultListAll(searchVO);
    }
     
    @Override
    public SmpDetailVO getSmpDetail(SearchVO searchVO) throws Exception{
    	return (SmpDetailVO) officialResultDetailDAO.getSmpDetail(searchVO);
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
				officialResultDetailDAO.delApprConf(vo);			//기존 결재 삭제
        	}
        	
    		vo.setRegid(user.getAdminid());
			officialResultDetailDAO.inApprConf(vo);					//결재라인 저장
    		reqid = vo.getReqid();
    		
        }
    	
    	for(int j = 0; j < resultjarray.size(); j++){
    		CoopApprVO vo = (CoopApprVO)JSONObject.toBean(resultjarray.getJSONObject(j), CoopApprVO.class);
    		vo.setAdminid(user.getAdminid());
    		if(j == 0){
				officialResultDetailDAO.delCoopReq(vo);			//기존 협조정보 삭제
				officialResultDetailDAO.inCoopReq(vo);			//기존 협조정보 저장
    		}
			officialResultDetailDAO.upCoopResult(vo);			//항목 협조로 변경
        }
    }
}
