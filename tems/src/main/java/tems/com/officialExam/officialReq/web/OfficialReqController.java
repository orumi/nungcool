package tems.com.officialExam.officialReq.web;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tems.com.common.StringUtils;
import tems.com.common.model.ComboVO;
import tems.com.common.model.SearchVO;
import tems.com.common.service.ComboService;
import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.ApprListVO;
import tems.com.exam.req.model.RequestHistoryVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.requestConfirm.model.ReqConfirmListVO;
import tems.com.login.model.LoginUserVO;
import tems.com.officialExam.officialReq.service.OfficialReqService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

/**
 * Created by owner1120 on 2016-03-02.
 */

@Controller
public class OfficialReqController {

    @Resource(name = "ComboService")
    private ComboService ComboService;

    @Resource(name = "officialReqService")
    private OfficialReqService officialReqService;

    @RequestMapping("/officialExam/req/ReqList.do")
    public String officialReq(HttpServletRequest req, HttpServletResponse resp, ModelMap model) throws Exception {

        List<ComboVO> ComboList17 = ComboService.getComboList("17");	//결제유형
        List<ComboVO> ApprComboList = ComboService.getApprStateCodeList("'-','A'");	//승인요청상태    - 요청전, A 결재중, D 승인완료, R 반려
        List<ComboVO> StateComboList = ComboService.getStateCodeList("'0','2','4'");	//진행상태		0    접수대기,2    접수완료,4    분석진행,6    시험완료,7    결재완료,8    발급완료, 9 취소

        model.addAttribute("ComboList17", ComboList17);
        model.addAttribute("ApprComboList", ApprComboList);
        model.addAttribute("StateComboList", StateComboList);

        return "tems/com/officialExam/officialReq/officialReq";
    }

    @RequestMapping(value="/officialExam/req/selReqList.json")
    public @ResponseBody
    List<RequestListVO>  selOfficeUserList(
            HttpServletRequest req,
            SearchVO requestSearchVO
    ) throws Exception{
        List<RequestListVO> RequestList = officialReqService.getReqList(requestSearchVO);
        return RequestList;
    }

    @RequestMapping(value="/officialExam/req/edtReqList.json")
    public void edtReqList(
            RequestListVO requestListVO,
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

        JSONObject nJson = new JSONObject();
        String data              = StringUtils.nvl(req.getParameter("data"), "");
        JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));

        try{
            for(int i = 0; i < jarray.size(); i++){
                RequestListVO vo = (RequestListVO)JSONObject.toBean(jarray.getJSONObject(i), RequestListVO.class);
                vo.setModifyid(user.getAdminid());
                if(vo.getState().equals("updated")){
                    officialReqService.edtReqList(vo);
                    nJson.put("RESULT_YN"     ,"Y");
                    nJson.put("RESULT_MESSAGE","");
                }

            }
        }catch(Exception e){
            nJson.put("RESULT_YN"     ,"N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }

    @RequestMapping(value="/officialExam/req/getApprList.json")
    public @ResponseBody List<ApprListVO>  getApprList(
            HttpServletRequest req
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
        List<ApprListVO> ApprList = officialReqService.getApprList(user.getAdminid());

        return ApprList;
    }


    @RequestMapping(value="/officialExam/req/getApprDetail.json")
    public @ResponseBody List<ApprDetailVO>  getApprDetail(
            HttpServletRequest req
    ) throws Exception{

        String apprlineid              = StringUtils.nvl(req.getParameter("apprlineid"),"");
        List<ApprDetailVO> ApprList = officialReqService.getApprDetail(apprlineid);

        return ApprList;
    }

    @RequestMapping(value="/officialExam/req/upReqState.json")
    public void upReqState(
            RequestListVO requestListVO,
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

        JSONObject nJson = new JSONObject();
        String data              = StringUtils.nvl(req.getParameter("data"),"");
        String cmbstate              = StringUtils.nvl(req.getParameter("cmbstate"),"");
        JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));

        try{
            for(int i = 0; i < jarray.size(); i++){
                RequestListVO vo = (RequestListVO)JSONObject.toBean(jarray.getJSONObject(i), RequestListVO.class);
                vo.setModifyid(user.getAdminid());
                vo.setReqstate(cmbstate);
                officialReqService.upReqState(vo);
                nJson.put("RESULT_YN"     ,"Y");
                nJson.put("RESULT_MESSAGE","");
            }
        }catch(Exception e){
            nJson.put("RESULT_YN"     ,"N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }


    @RequestMapping(value="/officialExam/req/edtApprLine.json")
    public void edtApprLine(
            RequestListVO requestListVO,
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

        JSONObject nJson = new JSONObject();
        String data              = StringUtils.nvl(req.getParameter("data"),"");
        JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));



        try{
            int MaxApprLineId = officialReqService.selNextApprLine(user.getAdminid());

            for(int i = 0; i < jarray.size(); i++){
                ApprDetailVO vo = (ApprDetailVO)JSONObject.toBean(jarray.getJSONObject(i), ApprDetailVO.class);
                vo.setModifyid(user.getAdminid());
                if(vo.getState().equals("created")){
                    vo.setApprlineid(Integer.toString(MaxApprLineId));
                    vo.setRegid(user.getAdminid());
                    officialReqService.edtApprLine(vo);
                    nJson.put("RESULT_YN"     ,"Y");
                    nJson.put("RESULT_MESSAGE","");
                } else if(vo.getState().equals("updated")){
                    vo.setModifyid(user.getAdminid());
                    officialReqService.edtApprLine(vo);
                    nJson.put("RESULT_YN"     ,"Y");
                    nJson.put("RESULT_MESSAGE","");
                }


            }
        }catch(Exception e){
            nJson.put("RESULT_YN"     ,"N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }


    @RequestMapping(value="/officialExam/req/inApprConf.json")
    public void inApprConf(
            RequestListVO requestListVO,
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

        JSONObject nJson = new JSONObject();
        String data              = StringUtils.nvl(req.getParameter("data"),"");
        JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));

        String reqid = "";

        try{
            for(int i = 0; i < jarray.size(); i++){
                ApprDetailVO vo = (ApprDetailVO)JSONObject.toBean(jarray.getJSONObject(i), ApprDetailVO.class);

                if(vo.getOrdinal().equals("1")){
                    vo.setApprstate("A");
                } else {
                    vo.setApprstate("-");
                }

                if(!reqid.equals(vo.getReqid())){
                    officialReqService.delApprConf(vo);				//기존 승인요청 삭제
                }

                vo.setModifyid(user.getAdminid());
                vo.setRegid(user.getAdminid());
                officialReqService.inApprConf(vo);				//승인요청 저장
                officialReqService.upApprState(vo);				//승인상태 변경
                reqid = vo.getReqid();

            }
            nJson.put("RESULT_YN"     ,"Y");
            nJson.put("RESULT_MESSAGE","");
        }catch(Exception e){
            nJson.put("RESULT_YN"     ,"N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }


    @RequestMapping(value="/officialExam/req/getApprLineUp.json")
    public @ResponseBody List<ApprDetailVO>  getApprLineUp(
            HttpServletRequest req
    ) throws Exception{

        String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");
        List<ApprDetailVO> ApprList = officialReqService.getSelApprLineUp(reqid);

        return ApprList;
    }

    @RequestMapping(value="/officialExam/req/getReject.json")
    public @ResponseBody
    ReqConfirmListVO getReject(
            HttpServletRequest req
    ) throws Exception{

        String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");
        ReqConfirmListVO reqConfirmListVO = officialReqService.getReject(reqid);

        return reqConfirmListVO;
    }

    @RequestMapping(value="/officialExam/req/selRequestHistory.json")
    public @ResponseBody List<RequestHistoryVO>  selRequestHistory(
            HttpServletRequest req,
            SearchVO searchVO
    ) throws Exception{

        List<RequestHistoryVO> requestHistoryVO = officialReqService.selRequestHistory(searchVO);

        return requestHistoryVO;
    }
    
}