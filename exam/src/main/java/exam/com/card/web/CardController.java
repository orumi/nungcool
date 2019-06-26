package exam.com.card.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import exam.com.card.model.ReqCardVO;
import exam.com.card.service.CardService;
import exam.com.main.model.LoginUserVO;
import exam.com.req.model.ResultVO;

@Controller
public class CardController {

	
    @Resource(name = "cardService")
    private CardService cardService;
    
    
 	/* open Page */
 	@RequestMapping("/INIpay/INIpayresult.do")
 	public String INIpayresult(HttpServletRequest request, HttpServletResponse response) throws Exception {
 		LoginUserVO loginUser = (LoginUserVO)request.getSession().getAttribute("loginUserVO");
 		
 		try {
 			List<ReqCardVO> listVO = (List<ReqCardVO>) request.getSession().getAttribute("INI_REQS");
 			
 			if(listVO != null)
 				for (int i = 0; i < listVO.size(); i++) {
					ReqCardVO vo = (ReqCardVO) listVO.get(i);
					
					System.out.println(vo.getReqid());
				}
		
 		} catch(Exception e) {
 			request.setAttribute("msg", "failure");
 		}
 		
 		/* tiles setting tiles.xml */
 		return "intro/INIpay/INIpayresult";
 	} 	
}
