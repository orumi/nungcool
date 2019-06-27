package tems.com.officialExam.officialReq.web;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tems.com.common.StringUtils;
import tems.com.exam.req.model.*;
import tems.com.login.model.LoginUserVO;
import tems.com.officialExam.officialReq.service.OfficialReqDetailService;
import tems.com.officialExam.officialReq.service.OfficialReqService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

/**
 * Created by owner1120 on 2016-03-07.
 */

@Controller
public class OfficialReqDetailController {

    @Resource(name = "ComboService")
    private tems.com.common.service.ComboService ComboService;

    @Resource(name = "officialReqDetailService")
    private OfficialReqDetailService officialReqDetailService;

    @Resource(name = "officialReqService")
    private OfficialReqService officialReqService;

    /**
     * @exception Exception
     */
    @RequestMapping(value="/officialExam/req/ReqListDetail.do")
    public String ReqListDetail(
            HttpServletRequest req,
            ModelMap model) throws Exception {

        String reqid = StringUtils.nvl(req.getParameter("reqid"), "");

        model.addAttribute("reqDetail",officialReqDetailService.getReqDetail(reqid));
        model.addAttribute("reqSmpList", officialReqDetailService.getReqSmpList(reqid));
        model.addAttribute("reqAttachList", officialReqDetailService.selReqAttach(reqid));

        return "tems/com/officialExam/officialReq/officialReqDetail";
    }

    @RequestMapping(value="/officialExam/req/ReqItemList.json")
    public @ResponseBody
    List<RequestItemDetailVO>  selAuthorGrpList(
            RequestItemDetailVO reqItemDetailVO
    ) throws Exception{
        List<RequestItemDetailVO> reqItemDetailList = officialReqDetailService.getReqItemList(reqItemDetailVO);

        return reqItemDetailList;
    }

    @RequestMapping(value="/officialExam/req/delRequest.json")
    public void delRequest(
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

        JSONObject nJson = new JSONObject();
        String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");

        try{
            officialReqDetailService.delRequest(reqid);
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


    @RequestMapping(value="/officialExam/req/upReqRemark.json")
    public void upReqRemark(
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
        JSONObject nJson = new JSONObject();
        try{

            String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");
            String remark              = StringUtils.nvl(req.getParameter("remark"),"");
            ReqDetailVO vo = new ReqDetailVO();
            vo.setReqid(reqid);
            vo.setRemark(remark);
            officialReqDetailService.upReqRemark(vo);
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


    @RequestMapping(value="/officialExam/req/getReqResultList.json")
    public @ResponseBody
    HashMap getReqResultList(
            ReqSmpListVO reqSmpListVO
    ) throws Exception{


        List<ReqResultVO> reqItemDetailList = officialReqDetailService.getReqResultList(reqSmpListVO);
        ReqPriceVO reqPriceVO = officialReqDetailService.selReqPrice(reqSmpListVO);

        HashMap map = new HashMap();
        map.put("reqItemDetailList",reqItemDetailList);
        map.put("reqPriceVO",reqPriceVO);


        return map;
    }


    @RequestMapping(value="/officialExam/req/delRequestResult.json")
    public void delRequestResult(
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

        JSONObject nJson = new JSONObject();

        String data              = StringUtils.nvl(req.getParameter("data"),"");
        JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
        ReqResultVO vo = new ReqResultVO();
        try{
            for(int i = 0; i < jarray.size(); i++){
                vo = (ReqResultVO)JSONObject.toBean(jarray.getJSONObject(i), ReqResultVO.class);
                officialReqDetailService.delRequestResult(vo);
                nJson.put("RESULT_YN"     ,"Y");
                nJson.put("RESULT_MESSAGE","");
            }
            officialReqDetailService.calPrice(vo);			//수수료 반영
        }catch(Exception e){
            nJson.put("RESULT_YN"     ,"N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }

    @RequestMapping(value="/officialExam/req/delRequestResultAll.json")
    public void delRequestResultAll(
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

        JSONObject nJson = new JSONObject();

        String data              = StringUtils.nvl(req.getParameter("data"),"");
        JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
        ReqResultVO vo = new ReqResultVO();
        try{
            for(int i = 0; i < jarray.size(); i++){
                vo = (ReqResultVO)JSONObject.toBean(jarray.getJSONObject(i), ReqResultVO.class);
                officialReqDetailService.delRequestResultAll(vo);
                nJson.put("RESULT_YN"     ,"Y");
                nJson.put("RESULT_MESSAGE","");
            }
            officialReqDetailService.calPrice(vo);			//수수료 반영
        }catch(Exception e){
            nJson.put("RESULT_YN"     ,"N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }

    @RequestMapping(value="/officialExam/req/getItemList.json")
    public @ResponseBody List<ItemListVO>  getItemList(
            HttpServletRequest req
    ) throws Exception{

        String itemnm              = StringUtils.nvl(req.getParameter("itemnm"),"");
        List<ItemListVO> ApprList = officialReqDetailService.getItemList(itemnm);

        return ApprList;
    }

    @RequestMapping(value="/officialExam/req/addResultItem.json")
    public void addResultItem(
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

        JSONObject nJson = new JSONObject();

        String data              = StringUtils.nvl(req.getParameter("data"),"");
        JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
        ReqResultVO vo = new ReqResultVO();
        try{
            for(int i = 0; i < jarray.size(); i++){
                vo = (ReqResultVO)JSONObject.toBean(jarray.getJSONObject(i), ReqResultVO.class);
                vo.setOfficeid(user.getOfficeid());
                officialReqDetailService.addResultItem(vo);
                nJson.put("RESULT_YN"     ,"Y");
                nJson.put("RESULT_MESSAGE","");
            }
            officialReqDetailService.calPrice(vo);			//수수료 반영
        }catch(Exception e){
            nJson.put("RESULT_YN"     ,"N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }

    @RequestMapping(value="/officialExam/req/addResultItemAll.json")
    public void addResultItemAll(
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

        JSONObject nJson = new JSONObject();

        String data              = StringUtils.nvl(req.getParameter("data"),"");
        JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
        ReqResultVO vo = new ReqResultVO();
        try{
            for(int i = 0; i < jarray.size(); i++){
                vo = (ReqResultVO)JSONObject.toBean(jarray.getJSONObject(i), ReqResultVO.class);
                vo.setOfficeid(user.getOfficeid());
                officialReqDetailService.addResultItemAll(vo);
                nJson.put("RESULT_YN"     ,"Y");
                nJson.put("RESULT_MESSAGE","");
            }
            officialReqDetailService.calPrice(vo);			//수수료 반영
        }catch(Exception e){
            nJson.put("RESULT_YN"     ,"N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }


    @RequestMapping(value="/officialExam/req/getItemMethodDetail.json")
    public @ResponseBody ItemMethodVO getItemMethodDetail(
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        String itemid              = StringUtils.nvl(req.getParameter("itemid"),"");
        String methodid              = StringUtils.nvl(req.getParameter("methodid"),"");

        ReqResultVO vo = new ReqResultVO();
        vo.setItemid(itemid);
        vo.setMethodid(methodid);
        return  officialReqDetailService.getItemMethodDetail(vo);
    }

    @RequestMapping(value="/officialExam/req/getItemConditionDetail.json")
    public @ResponseBody CondDetailVO getItemConditionDetail(
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        String itemid              = StringUtils.nvl(req.getParameter("itemid"),"");
        String condid              = StringUtils.nvl(req.getParameter("condid"),"");

        ReqResultVO vo = new ReqResultVO();
        vo.setItemid(itemid);
        vo.setCondid(condid);
        CondDetailVO vo2 = (CondDetailVO)officialReqDetailService.getItemConditionDetail(vo);
        return  vo2;
    }

    @RequestMapping(value="/officialExam/req/edtResultList.json")
    public void edtResultList(
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

        JSONObject nJson = new JSONObject();

        String data              = StringUtils.nvl(req.getParameter("data"),"");
        JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
        ReqResultVO vo = new ReqResultVO();
        try{
            for(int i = 0; i < jarray.size(); i++){
                vo = (ReqResultVO)JSONObject.toBean(jarray.getJSONObject(i), ReqResultVO.class);
                vo.setRegid(user.getAdminid());
                officialReqDetailService.upResultDetail(vo);
                nJson.put("RESULT_YN"     ,"Y");
                nJson.put("RESULT_MESSAGE","");
            }
            officialReqDetailService.calPrice(vo);			//수수료 반영
        }catch(Exception e){
            nJson.put("RESULT_YN"     ,"N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }

    @RequestMapping(value="/officialExam/req/upResultDetailAll.json")
    public void upResultDetailAll(
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

        JSONObject nJson = new JSONObject();

        String data              = StringUtils.nvl(req.getParameter("data"),"");
        String reqid="";
        JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
        ReqResultVO vo = new ReqResultVO();
        try{
            for(int i = 0; i < jarray.size(); i++){
                vo = (ReqResultVO)JSONObject.toBean(jarray.getJSONObject(i), ReqResultVO.class);
                vo.setRegid(user.getAdminid());
                officialReqDetailService.upResultDetailAll(vo);
                nJson.put("RESULT_YN"     ,"Y");
                nJson.put("RESULT_MESSAGE","");
            }
            officialReqDetailService.calPrice(vo);			//수수료 반영

        }catch(Exception e){
            nJson.put("RESULT_YN"     ,"N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
        }
        PrintWriter out = response.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }

    @RequestMapping(value="/officialExam/req/upReqPrice.json")
    public void upReqPrice(
            HttpServletRequest req,
            HttpServletResponse response,
            ReqPriceVO reqPriceVO,
            ReqResultVO vo
    ) throws Exception{
        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
        JSONObject nJson = new JSONObject();
        try{
            reqPriceVO.setDcprice(StringUtils.nvl(req.getParameter("dcprice"),""));
            reqPriceVO.setEtcprice(StringUtils.nvl(req.getParameter("etcprice"),""));
            reqPriceVO.setPricedesc(StringUtils.nvl(req.getParameter("pricedesc"),""));
            reqPriceVO.setRegid(user.getAdminid());
            vo.setRegid(StringUtils.nvl(req.getParameter("reqid"),""));

            officialReqDetailService.upReqPrice(reqPriceVO);
            officialReqDetailService.calPrice(vo);			//수수료 반영
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

    @RequestMapping(value="/officialExam/req/upReqStateOne.json")
    public void upReqState1111111111111111111(
            RequestListVO requestListVO,
            HttpServletRequest req,
            HttpServletResponse response
    ) throws Exception{

        LoginUserVO user = (LoginUserVO)req.getSession().getAttribute("loginUserVO");

        JSONObject nJson = new JSONObject();
        String reqid              = StringUtils.nvl(req.getParameter("reqid"),"");
        String cmbstate              = StringUtils.nvl(req.getParameter("cmbstate"),"");

        try{
            RequestListVO vo = new RequestListVO();
            vo.setModifyid(user.getAdminid());
            vo.setReqstate(cmbstate);
            vo.setReqid(reqid);
            officialReqService.upReqState(vo);				//sms e-mail 전송 및 시료도착정보 저장 해야함
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




}
