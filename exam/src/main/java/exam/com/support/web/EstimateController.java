package exam.com.support.web;


import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.apache.commons.lang.time.FastDateFormat;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import tems.com.common.StringUtils;
import egovframework.com.cmm.service.EgovProperties;
import exam.com.main.model.LoginUserVO;
import exam.com.req.model.ClassVO;
import exam.com.req.model.DuplicateVO;
import exam.com.req.model.ExceptItem;
import exam.com.req.model.ItemGroupVO;
import exam.com.req.model.ItemVO;
import exam.com.req.model.MasterVO;
import exam.com.req.model.MemberInfo;
import exam.com.req.model.MethodCheckVO;
import exam.com.req.model.PriceVO;
import exam.com.req.model.RequestAttachVO;
import exam.com.req.model.RequestVO;
import exam.com.req.model.ResultVO;
import exam.com.req.model.SampleVO;
import exam.com.req.model.SearchDetailItem;
import exam.com.req.model.TempletVO;
import exam.com.req.model.TreeVO;
import exam.com.support.service.EstimateService;



@Controller
public class EstimateController {

    @Resource(name = "EstimateService")
    private EstimateService estimateService;
    
	/* open Page */
	
    private static final Logger LOGGER = LoggerFactory.getLogger(EstimateController.class);
    
 	
 	/* open Page */
 	@RequestMapping("/support/testRequest.do")
 	public String pageTestRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
 		
 		/* tiles setting tiles.xml */
 		return "support/testRequest";
 	}
 	
 	/* iframe */
 	@RequestMapping("/support/testIframe.do")
 	public String testIframe(HttpServletRequest req, HttpServletResponse resp) throws Exception {
 		return "ds/support/testFrame";
 	}
 	
 	
	/* result list */
 	@RequestMapping(value="/support/selectResult.json" )
 	public String actionSelectResult(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	request.setCharacterEncoding("UTF-8"); 
    	response.setContentType("text/html;charset=UTF-8");
    	
 		
 		
		String reqid = request.getParameter("reqid");
		if(reqid==null) return "ds/support/testResult";
		
		String smpid = request.getParameter("smpid");
		
		
		SampleVO sampleVO = new SampleVO();
		sampleVO.setReqid(reqid);
		sampleVO.setSmpid(smpid);
		
		
		String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
		
		if ("insertItems".equals(mode)){
			/*항목 추가 */
			try{
		    	String items = request.getParameter("items");
		    	String pItems = request.getParameter("pItems");
		    	
		    	String parentItems = request.getParameter("parentItems");
		    	/* 항목 상위에 대한 메소드 정보 */
		    	HashMap<String, TreeVO> mapPid = new HashMap<String, TreeVO>();
		    	
		    	String[] aPItems = pItems.split("\\|");
		    	//pitems |2683,2822,1|2683,2816,1|2683,2823,1|2683,2818,1
		    	for (int i = 0; i < aPItems.length; i++) {
		    		String pItemid = aPItems[i];
					if(pItemid !=null && !"".equals(pItemid)){
						String[] aPitem = pItemid.split(",");
						
						TreeVO treeVO = new TreeVO();
						treeVO.setItemid(aPitem[1]);
						treeVO.setItempid(aPitem[0]);
						treeVO.setMethodid(aPitem[2]);
						
						mapPid.put(treeVO.getItemid(), treeVO);
					}
		    	}
		    	/* 시존 상위 또는 신규 상위 */
		    	HashMap<String, TreeVO> mapResult = new HashMap<String, TreeVO>();
		    	//parents |2683,0,-1
		    	
		    	String[] aParentItems = parentItems.split("\\|");
		    	for (int i = 0; i < aParentItems.length; i++) {
					String pParentItem = aParentItems[i];
					if(pParentItem !=null && !"".equals(pParentItem)){
						String[] aParent = pParentItem.split(",");
						if(aParent.length > 2){
							TreeVO treeVO = new TreeVO();
							treeVO.setItemid(aParent[0]);
							treeVO.setItempid(aParent[1]);
							treeVO.setResultpid(aParent[2]);
							mapResult.put(treeVO.getItemid(), treeVO);
						}
					}
				}
		    	
		    	/* 상위 -1에 대한 동잏한 상위 항목 정보 */
		    	HashMap<String, TreeVO> mapNewParent = new HashMap<String, TreeVO>();
		    	
		    	HashMap<String, String> map = new HashMap<String, String>();
	    		map.put("reqid", reqid);
	    		map.put("smpid", smpid);
	    		map.put("regid", "supoort");
	    		
	    		
		    	String[] aItems = items.split("\\|");
	    		//items |2822,2683,388|2816,2683,388|2823,2683,388|2818,2683,388
	    		for (int i = 0; i < aItems.length; i++) {
	    			String itemid = aItems[i];
	    			if(itemid !=null && !"".equals(itemid)){
	    				String[] aItem = itemid.split(",");
	    				
	    				if("0".equals(aItem[1])){
	    				/* 상위 항목이 없는 경우 
	    				 *  just insert 
	    				 * */
	    					map.put("itemid", aItem[0]);
		    				map.put("resultpid", "0");
		    				
		    				if(aItem[2]!=null && !"".equals(aItem[2])){
		    					map.put("methodid", aItem[2]);
		    				} else {
		    					map.put("methodid", "0");
		    				}
	    					// 기존항목 있으면 삭제
		    				estimateService.deleteExcept(map);
		    				
		    				TreeVO itemVO = new TreeVO();
		    				itemVO.setReqid(map.get("reqid"));
		    				itemVO.setSmpid(map.get("smpid"));
		    				itemVO.setRegid(map.get("regid"));
		    				itemVO.setItemid(map.get("itemid"));
		    				itemVO.setResultpid(map.get("resultpid"));
		    				itemVO.setMethodid(map.get("methodid"));
		    				
		    				estimateService.insertResultItem(itemVO);
	    				} else {
	    					/*상위 항목이 있을 경우 */
	    					TreeVO parentVO1 = mapResult.get(aItem[1]);
	    					if(parentVO1!=null && !"-1".equals(parentVO1.getResultpid())){
	    						/* 기존 resultid resutlpid 사용*/
	    						
	    						map.put("itemid", aItem[0]);
			    				map.put("resultpid", parentVO1.getResultpid());
			    				
			    				if(aItem[2]!=null && !"".equals(aItem[2])){
			    					map.put("methodid", aItem[2]);
			    				} else {
			    					map.put("methodid", "0");
			    				}
		    					// 기존항목 있으면 삭제
			    				//supportuestService.deleteExcept(map);
			    				
			    				
			    				TreeVO itemVO = new TreeVO();
			    				itemVO.setReqid(map.get("reqid"));
			    				itemVO.setSmpid(map.get("smpid"));
			    				itemVO.setRegid(map.get("regid"));
			    				itemVO.setItemid(map.get("itemid"));
			    				itemVO.setResultpid(map.get("resultpid"));
			    				itemVO.setMethodid(map.get("methodid"));
			    				
			    				estimateService.insertResultItem(itemVO);
	    					} else {
	    						TreeVO itemVO = new TreeVO();
			    				itemVO.setReqid(map.get("reqid"));
			    				itemVO.setSmpid(map.get("smpid"));
			    				itemVO.setRegid(map.get("regid"));
			    				itemVO.setItemid(aItem[0]);
			    				
			    				
	    						/*신규 검색*/
	    						TreeVO treeVOP1 = mapNewParent.get(aItem[1]);
	    						
	    						if(treeVOP1!=null){
	    							itemVO.setResultpid(treeVOP1.getResultid() );
	    						} else {
		    						/* 신규 상위 항목 추가 */
		    						TreeVO pTreeVO1 = mapPid.get(aItem[0]);
		    						if(pTreeVO1!=null){
		    								    							
		    							TreeVO pTree1 = new TreeVO();
		    							pTree1.setReqid(map.get("reqid"));
		    							pTree1.setSmpid(map.get("smpid"));
		    							pTree1.setRegid(map.get("regid"));
		    							
		    							pTree1.setItemid(pTreeVO1.getItempid());
		    							pTree1.setMethodid(pTreeVO1.getMethodid());
		    							
		    							// 3레벨 상위 체트 mapPid.get(pid);
		    							TreeVO pTreeVO2 = mapPid.get(pTreeVO1.getItempid());
		    							if(pTreeVO2!=null){
		    								TreeVO treeVOP2 = mapNewParent.get(pTreeVO2.getItempid());
		    								if(treeVOP2!=null){
		    									pTree1.setResultpid(treeVOP2.getResultid());
		    								} else {
		    									TreeVO parentVO2 = mapResult.get(pTreeVO2.getItempid());
		    									if(parentVO2!=null && !"-1".equals(parentVO2.getResultpid()) ){
		    										pTree1.setResultpid(parentVO2.getResultpid());
		    									} else {
			    									TreeVO pTree2 = new TreeVO();
				    								pTree2.setReqid(map.get("reqid"));
					    							pTree2.setSmpid(map.get("smpid"));
					    							pTree2.setRegid(map.get("regid"));
					    							
					    							pTree2.setItemid(pTreeVO2.getItempid());
					    							pTree2.setMethodid(pTreeVO2.getMethodid());
					    							pTree2.setResultpid("0");   // level 3의 최상
					    							
					    							estimateService.insertResultItem(pTree2);
					    							mapNewParent.put(pTree2.getItemid(), pTree2);
					    							
					    							
					    							pTree1.setResultpid(pTree2.getResultid());
		    									}
		    								}
		    							} else {
		    								TreeVO treeVOP2 = mapNewParent.get(pTreeVO1.getItempid());
		    								if(treeVOP2!=null){
		    									pTree1.setResultpid(treeVOP2.getResultid());
		    								} else {
		    									pTree1.setResultpid("0");
		    								}
		    							}
		    							
		    							estimateService.insertResultItem(pTree1);
		    							mapNewParent.put(pTree1.getItemid(), pTree1);
		    							
		    							itemVO.setResultpid(pTree1.getResultid() );
		    						}  // end of parent item 
	    						}
	    						
    							// addPitems;
    							
	    						if(aItem[2]!=null && !"".equals(aItem[2])){
			    					map.put("methodid", aItem[2]);
			    				} else {
			    					map.put("methodid", "0");
			    				}
	    						map.put("itemid", aItem[0]);
			    				itemVO.setMethodid(map.get("methodid"));
			    				
			    				estimateService.deleteExcept(map);
			    				estimateService.insertResultItem(itemVO);
			    				
	    					}
	    					
	    				}
	    			}
	    		}
		    	
		    	
	    		
	    		estimateService.procCalPrice(sampleVO);
	    		
	    		
	    		/* 담당자 */
	    		estimateService.deleteAssignSmple(sampleVO);
	    		estimateService.insertAssignSmple(sampleVO);
	    		
			} catch (Exception e){
				System.out.println(e);
				return "ds/support/testResult";
			}
    		
			
		} else if ("saveItems".equals(mode)){
			/*항목 저장*/
			try {
				// update Sample
				String smplename = request.getParameter("samplename");
				sampleVO.setSname(smplename);
				estimateService.updateSample(sampleVO);
				
				
				saveItem(request, response);
    		
				
				estimateService.procCalPrice(sampleVO);
				
				/* 담당자 */
	    		estimateService.deleteAssignSmple(sampleVO);
	    		estimateService.insertAssignSmple(sampleVO);
	    		
			} catch (Exception e){
				
				return "ds/support/testResult";
			}
    		
		
			
		} else if ("deleteItems".equals(mode)) {
			/*항목삭제*/
			try {
	    		String chkResultId = request.getParameter("chkResultId");
	    		String chkItemId  = request.getParameter("chkItemId");
	    		
	    		String[] aResultId = chkResultId.split("\\│");
	    		String[] aItemId   = chkItemId.split("\\│");
	    		HashMap<String, String> map = new HashMap<String, String>();
	    		map.put("reqid", reqid);
	    		map.put("smpid", smpid);
	    		
	    		for (int i = 0; i < aResultId.length; i++) {
					String resultId = aResultId[i];
					if(resultId!=null && !"".equals(resultId)){
						
						map.put("resultid", resultId);
						
						estimateService.deleteItems(map);
						
					}
				}				
				
	    		
	    		estimateService.procCalPrice(sampleVO);
	    		
			} catch (Exception e) {
				return "ds/support/testResult";
			}
			
		} else if ("insertItemsCopy".equals(mode)){
			/*항목 복사*/
			try {
	    		String chkResultId = request.getParameter("chkResultId");
	    		String chkItemId   = request.getParameter("chkItemId");
	    		String chkItemIds  = request.getParameter("chkItemIds");
	    		String chkLeafs    = request.getParameter("chkLeafs");
	    		
	    		String[] aResultId = chkResultId.split("\\│");
	    		String[] aItemId   = chkItemId.split("\\│");
	    		String[] aItemIds  = chkItemIds.split("\\│");
	    		String[] aLeafs    = chkLeafs.split("\\|");
	    		
	    		HashMap<String, String> map = new HashMap<String, String>();
	    		map.put("reqid", reqid);
	    		map.put("smpid", smpid);
	    		map.put("regid", "supoort");
	    		
	    		// 시료정보 가져오기
	    		List<SampleVO> list_sampleVO = estimateService.selectSample(sampleVO);
	    		
				// 선택한 항목별로 돌면서 	
 	    		for (int i = 0; i < aResultId.length; i++) {
					String resultId = aResultId[i];
					if(resultId!=null && !"".equals(resultId)){
						map.put("resultid", resultId);
						map.put("itemid", aItemId[i]);
						
						if(aLeafs[i].equals("1")){
							// 자식이 없는 항목 만 
				    		for (int j = 0; j < list_sampleVO.size(); j++) {
								SampleVO re_sampleVO = list_sampleVO.get(j);
								
								// 자신 항목 제외 
								if(!smpid.equals(re_sampleVO.getSmpid())){
									map.put("target_smpid", re_sampleVO.getSmpid());
									estimateService.insertItemsCopy(map);	
								}
						    }
							
						}
						
								
					}
	    		}
 	    		
 	    		for (int j = 0; j < list_sampleVO.size(); j++) {
					SampleVO re_sampleVO = list_sampleVO.get(j);
					
					// 자신 항목 제외 
					if(!smpid.equals(re_sampleVO.getSmpid())){
						map.put("target_smpid", re_sampleVO.getSmpid());
						estimateService.updateItemsCopyParent(map);	
					}
			    }
 	    		
 	    		
				// 전체 
 	    		/* 담당자 */
	    		estimateService.deleteAssign(sampleVO);
	    		estimateService.insertAssign(sampleVO);
	    		
	    		
 	    		estimateService.procCalPrice(sampleVO);
			} catch (Exception e) {
				return "ds/support/testResult";
			}
		} else if ("deleteItemsCopy".equals(mode)){
			/*동일항목 삭제*/
			try {
	    		String chkResultId = request.getParameter("chkResultId");
	    		String chkItemId  = request.getParameter("chkItemId");
	    		
	    		String[] aResultId = chkResultId.split("\\│");
	    		String[] aItemId   = chkItemId.split("\\│");
	    		HashMap<String, String> map = new HashMap<String, String>();
	    		map.put("reqid", reqid);
	    		map.put("smpid", smpid);
	    		
	    		// 시료정보 가져오기
	    		List<SampleVO> list_sampleVO = estimateService.selectSample(sampleVO);
	    		for (int j = 0; j < list_sampleVO.size(); j++) {
					SampleVO re_sampleVO = list_sampleVO.get(j);
	    		    map.put("smpid", re_sampleVO.getSmpid());
	    		    
		    		for (int i = 0; i < aItemId.length; i++) {
						String itemid = aItemId[i];
						if(itemid!=null && !"".equals(itemid)){
							
							map.put("itemid", itemid);
							
							estimateService.deleteItemsCopy(map);
							
						}
					}				
	    		} 
	    		// END OF FOR 
	    		estimateService.procCalPrice(sampleVO);
	    		
	    		// 전체 
 	    		/* 담당자 */
	    		estimateService.deleteAssign(sampleVO);
	    		estimateService.insertAssign(sampleVO);
	    		
	    		// reset smpid 
	    		map.put("smpid", smpid);
			} catch (Exception e) {
				return "ds/support/testResult";
			}
		} else if ("updateItemsCopy".equals(mode)){
			/*동일항목 속성일괄 복사*/
				try {
					// 선택 검사항목 저장 함. 
					saveItem(request, response);
					
					
		    		String chkResultId = request.getParameter("chkResultId");
		    		String chkItemId  = request.getParameter("chkItemId");
		    		
		    		String[] aResultId = chkResultId.split("\\│");
		    		String[] aItemId   = chkItemId.split("\\│");
		    		HashMap<String, String> map = new HashMap<String, String>();
		    		map.put("reqid", reqid);
		    		map.put("smpid", smpid);
		    		
		    		for (int i = 0; i < aItemId.length; i++) {
						String itemid = aItemId[i];
						if(itemid!=null && !"".equals(itemid)){
							
							map.put("itemid", itemid);
							map.put("resultid", aResultId[i]);
							
							estimateService.updateItemsCopy(map);
							
						}
					}				
					
		    		// 전체 
	 	    		/* 담당자 */
		    		estimateService.deleteAssign(sampleVO);
		    		estimateService.insertAssign(sampleVO);
		    		
				} catch (Exception e) {
					return "ds/support/testResult";
				}
		}
		
		
		
		
		
		/* select Results */
		
		List<ResultVO> listVO = estimateService.selectResult(sampleVO);
 		
 		request.setAttribute("listVO", listVO);
 		
 		/*select price */
 		List<PriceVO> priceVO = estimateService.selectPrice(sampleVO);
 		request.setAttribute("priceVO", priceVO);
 		
 		return "ds/support/testResult";
 	}
 	
 	
 	private void saveItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
	 		
	 		
			String reqid = request.getParameter("reqid");
			String smpid = request.getParameter("smpid");		
	 		
	 		String chkResultId = request.getParameter("chkResultId");
			String chkItemId  = request.getParameter("chkItemId");
			String result     = request.getParameter("result");
			
			String[] aResultId = chkResultId.split("\\│");
			String[] aItemId   = chkItemId.split("\\│");
			String[] aResult   = result.split("\\│");
			
			for (int i = 0; i < aResultId.length; i++) {
				String resultId = aResultId[i];
				if(resultId!=null && !"".equals(resultId)){
					ResultVO updateVO = new ResultVO();
					updateVO.setReqid(reqid);
					updateVO.setSmpid(smpid);
					updateVO.setResultid(resultId);
					
					String[] aResultData = aResult[i].split("\\├");
					// set condid
					updateVO.setCondid(aResultData[0]);
					
					updateVO.setTempercond(aResultData[1]);
					updateVO.setStempunitid(aResultData[2]);
					updateVO.setTimecond(aResultData[3]);
					updateVO.setStimecondunitid(aResultData[4]);
					
					// set unit 
					updateVO.setUnitid(     (aResultData[5]!=null && "-1".equals(aResultData[5]))?aResultData[6]:aResultData[5]);
					updateVO.setDisplayunit((aResultData[5]!=null && "-1".equals(aResultData[5]))?aResultData[6]:aResultData[5]);
					updateVO.setReportunit( (aResultData[5]!=null && "-1".equals(aResultData[5]))?aResultData[6]:aResultData[5]);
					
					// set method
					updateVO.setMethodid(aResultData[7]);
					// set method name 
					
					
					updateVO.setRegid("support");
					updateVO.setReqspec(aResultData[8]);
					
					estimateService.updateItems(updateVO);
					
				}
			}
			
				
			/*
			0 "│" + cond_id 
            1 + "├" + cond_etc_temp + 
            2 "├" + cond_etc_temp_unitid
            3 + "├" + cond_etc_time + 
            4├" + cond_etc_time_unitid
            5 + "├" + unit_id +
            6"├"+unit_etc
            7 + "├" + $("#sel_method_"+$(this).val()).val() 
            8 + "├" + $("#txt_reqspec_"+$(this).val()).val()
            9 + "├" + $(this).attr("itemid") ;
			*/
 	}
 	
 	
 	
 	
 	
 	/* 일반시험의뢰  */
 	
 	// 신청자 기본정보 가져오기 
    @RequestMapping(value="/support/selectInfo.json")
    public @ResponseBody void setSelectInfo(HttpServletRequest req, HttpServletResponse res ) throws Exception{
    	req.setCharacterEncoding("UTF-8"); 
    	res.setContentType("text/html;charset=UTF-8");
    	
    	String formTag = req.getParameter("formTag");
    	
    	JSONObject nJson = new JSONObject();
    	
    	try {
    	
    	
	    	if("getMemberInfo".equals(formTag)) {
	    	
	    		List<MemberInfo> memberInfo = estimateService.getMemberInfo(null);
	    		nJson.put("info", memberInfo);
	    	} else if ("selectClass".equals(formTag)){
	    		List<ClassVO> listClass = estimateService.selectClass();
	    		
	    		nJson.put("info", listClass);
	    	} else if ("selectMaster".equals(formTag)){
	    		String classId      = req.getParameter("pm");
	
	    		ClassVO classVO = new ClassVO();
	    		classVO.setClassid(classId);
	    			
	    		List<MasterVO> listVO = estimateService.selectMaster(classVO);
	    			
	    		nJson.put("info", listVO);
	    	} else if ("selectResult".equals(formTag)){
	    		String reqid = req.getParameter("reqid");
	    		String smpid = req.getParameter("smpid");
	    		
	    		SampleVO sampleVO = new SampleVO();
	    		sampleVO.setReqid(reqid);
	    		sampleVO.setSmpid(smpid);
	    		
	    		List<ResultVO> listVO = estimateService.selectResult(sampleVO);
	    		
	    		nJson.put("info", listVO);
	    	} else if ("selectSample".equals(formTag)){
	    		String reqid = req.getParameter("reqid");
	    		
	    		SampleVO sampleVO = new SampleVO();
	    		sampleVO.setReqid(reqid);
	    		
	    		List<SampleVO> reval_sampleVO = estimateService.selectSample(sampleVO);
	    		
	    		nJson.put("RESULT_SAMPLEVO", reval_sampleVO);
	    	} else if ("selectCopySample".equals(formTag)){
	    		String reqid = req.getParameter("reqid");
	    		
	    		SampleVO sampleVO = new SampleVO();
	    		sampleVO.setReqid(reqid);
	    		
	    		List<SampleVO> reval_sampleVO = estimateService.selectSample(sampleVO);
	    		
	    		nJson.put("RESULT_SAMPLEVO", reval_sampleVO);
	    	} else if("adjustCopySample".equals(formTag)){
	            String reqid = req.getParameter("reqid");
	    		
	    		SampleVO sampleVO = new SampleVO();
	    		sampleVO.setReqid(reqid);
	    		
	    		// copy sample 
	    		
	    		String smpid = req.getParameter("smpid");
	    		String copycnt = req.getParameter("smplcopycnt");
	    		
	    		// get next sample id 
	    		String nextSmpid = estimateService.selectNextSmpid(reqid);
	    		
	    		int intNextSmpid = Integer.valueOf(nextSmpid);
	    		int intCopy = Integer.valueOf(copycnt);
	    		
	    		HashMap map = new HashMap<String, String>();
	    		map.put("reqid", reqid);
	    		map.put("smpid", smpid);
	    		map.put("regid", "support");
	    		
	    		for (int i = 0; i < intCopy; i++) {
	    			int target_smpid = intNextSmpid+i;
	    			map.put("target_smpid", String.valueOf(target_smpid));
	    			map.put("serial", String.valueOf(i+1));
	    			
	    			estimateService.copySample(map);
				}
	    		
	    		
	    		// recalculate
	    		estimateService.procCalPrice(sampleVO);
	    		
	    		
	    		List<PriceVO> list_priceVO = estimateService.selectPrice(sampleVO);
	    		nJson.put("RESULT_PRICEVO", list_priceVO);
	    		
	            List<SampleVO> reval_sampleVO = estimateService.selectSample(sampleVO);
	    		nJson.put("RESULT_SAMPLEVO", reval_sampleVO);
	    		
	    	} else if ("selectItems".equals(formTag)){
	    		String itemname = req.getParameter("itemname");
	    		String searchType = req.getParameter("searchType");
	    		String searchText1 = req.getParameter("searchText1");
	    		String searchText2 = req.getParameter("searchText2");
	    		String exceptid    = req.getParameter("exceptid");
	    		String kolasyn     = req.getParameter("kolasyn");
	    		
	    		HashMap<String, String> map = new HashMap<String, String>();
	    		map.put("itemname", itemname);
	    		map.put("searchType", searchType);
	    		map.put("searchText1", searchText1);
	    		map.put("searchText2", searchText2);
	    		map.put("exceptid", exceptid);
	    		map.put("kolasyn", kolasyn);
	    		
	    		List<ItemVO> reval_itemVO = estimateService.selectItems(map);
	    		
	    		nJson.put("RESULT_ITEMVO", reval_itemVO);
	    	} else if ("saveItems".equals(formTag)){
	    		
	
	    	} else if ("selectTemplet".equals(formTag)){
	    		HashMap<String, String> map = new HashMap<String, String>();
	    		map.put("memid", "support");
	    		List<TempletVO> re_templetVO = estimateService.selectTemplet(map);
	    		
	    		nJson.put("RESULT_TEMPLETVO", re_templetVO);
	    	} else if ("insertTemplet".equals(formTag)){
	    		String reqid = req.getParameter("reqid");
	    		String templetname = req.getParameter("templetname");
	    		String templetdesc = req.getParameter("templetdesc");
	    		
	    		TempletVO templetVO = new TempletVO();
	    		templetVO.setReqid(reqid);
	    		templetVO.setTempletid(estimateService.selectNextTempletId());
	    		templetVO.setTempletname(templetname);
	    		templetVO.setTempletdesc(templetdesc);
	    		templetVO.setMemid("support");
	
	    		estimateService.insertTemplet(templetVO);
	    		
	    		HashMap<String, String> map = new HashMap<String, String>();
	    		map.put("memid", "support");
	    		List<TempletVO> re_templetVO = estimateService.selectTemplet(map);
	    		
	    		nJson.put("RESULT_TEMPLETVO", re_templetVO);
	    		
	    	} else if ("deleteTemplet".equals(formTag)){
	    		
	    		String chkTemplets = req.getParameter("chkTemplets");
	    		String[] aTemplet  = chkTemplets.split("\\|");
	    		TempletVO templetVO = new TempletVO();
	    		
	    		for (int i = 0; i < aTemplet.length; i++) {
	    			String templetid = aTemplet[i];
	    			if(templetid!=null && !"".equals(templetid)){
		        		templetVO.setTempletid(templetid);
		        		estimateService.deleteTemplet(templetVO);
	    			}
				}
	    	
	    		HashMap<String, String> map = new HashMap<String, String>();
	    		map.put("memid", "support");
	    		List<TempletVO> re_templetVO = estimateService.selectTemplet(map);
	    		
	    		nJson.put("RESULT_TEMPLETVO", re_templetVO);
	    	} else if ("actionTemplet".equals(formTag)){
	    		String templetid = req.getParameter("templetid");
	    		String nextReqid = estimateService.getRequestNextVal();
	    		
	    		HashMap<String, String> map = new HashMap<String, String>();
	    		map.put("reqid", nextReqid);
	    		map.put("templetid", templetid);
	    		
	    		// adjustTemplet
	    		estimateService.adjustTemplet(map);
	    		
	    		// select Request 
	    		RequestVO requestVO = new RequestVO();
	    		requestVO.setReqid(nextReqid);
	    		
	    		List<RequestVO> list_requestVO = estimateService.getRequest(requestVO);
	    		
	    		// select sample
	    		
	    		SampleVO sampleVO = new SampleVO();
	    		sampleVO.setReqid(nextReqid);
	    		
	    		// 전체 
 	    		/* 담당자 */
	    		estimateService.deleteAssign(sampleVO);
	    		estimateService.insertAssign(sampleVO);
	    		
	    		List<SampleVO> list_sampleVO = estimateService.selectSample(sampleVO);

	    		/* 상위 아이디 조정 resultpid */
	    		
 	    		for (int j = 0; j < list_sampleVO.size(); j++) {
					SampleVO re_sampleVO = list_sampleVO.get(j);
					map.put("target_smpid", re_sampleVO.getSmpid());
					estimateService.updateItemsCopyParent(map);
					
			    }
	    		
	    		
	    		
	    		nJson.put("RESULT_REQID", nextReqid);
	    		nJson.put("RESULT_REQUESTVO", list_requestVO);
	    		nJson.put("RESULT_SAMPLEVO", list_sampleVO);
	    		
	    	} else if ("requestInfo".equals(formTag)){
	    		String selectReqid = req.getParameter("reqid");
	    		
	    		// select Request 
	    		RequestVO requestVO = new RequestVO();
	    		requestVO.setReqid(selectReqid);
	    		
	    		List<RequestVO> list_requestVO = estimateService.getRequest(requestVO);
	    		
	    		// select sample
	    		
	    		SampleVO sampleVO = new SampleVO();
	    		sampleVO.setReqid(selectReqid);
	    		
	    		List<SampleVO> list_sampleVO = estimateService.selectSample(sampleVO);
	    		
	    		List<PriceVO> list_priceVO = estimateService.selectPrice(sampleVO);
	    		
	    		List<RequestAttachVO> listAttachVO = estimateService.selectAttach(selectReqid);
	    		
	    		nJson.put("RESULT_REQID",     selectReqid);
	    		nJson.put("RESULT_REQUESTVO", list_requestVO);
	    		nJson.put("RESULT_SAMPLEVO",  list_sampleVO);
	    		nJson.put("RESULT_PRICEVO",   list_priceVO);
	    		nJson.put("RESULT_ATTACH",    listAttachVO);
	    		
	    	} else if ("requestConfirm".equals(formTag)){
	    		
	    		/*check Method */
	    		SampleVO sampleVO = new SampleVO();
	    		sampleVO.setReqid(req.getParameter("reqid"));
	    		List<MethodCheckVO> listMethodCheckVO = estimateService.selectCheckMethod(sampleVO);
	    		
	    		if(listMethodCheckVO.size()>0){
	    			nJson.put("RESULT_METHODCHECK", listMethodCheckVO);
	    			nJson.put("RESULT_YN", "XM");   // method error
	    		} else {
	    		
	    			List<MethodCheckVO> listConditionCheckVO = estimateService.selectCheckCondition(sampleVO);	
	    			
	    			if(listConditionCheckVO.size()>0) {
	    				nJson.put("RESULT_CONDITIONCHECK", listConditionCheckVO);	
	    				nJson.put("RESULT_YN", "XC");   // method error
	    			} else {
	    			
			    		PriceVO priceVO = new PriceVO();
			    		priceVO.setReqid(req.getParameter("reqid"));
			    		priceVO.setItemdesc(req.getParameter("itemdesc"));
			    		priceVO.setRegid("");
			    		
			    		estimateService.updateState(priceVO);
			    		
			    		nJson.put("RESULT_YN", "Y");
			    		
	    			}
	    		}
	    	} else if ("deleteRequest".equals(formTag)){
	    		
	    		String reqid = req.getParameter("reqid");
	    		// 전체 
 	    		/* 담당자 */
	    		SampleVO sampleVO = new SampleVO();
	    		sampleVO.setRegid(reqid);
	    		
	    		estimateService.deleteAssign(sampleVO);
	    		
	    		estimateService.deleteRequest(reqid);
	    		nJson.put("RESULT_YN", "Y");
	    		
	    	} else if ("selectDetailSearch".equals(formTag)){
	    		List<SearchDetailItem> searchDetailItem = estimateService.selectHeating();
	    		
	    		nJson.put("info", searchDetailItem);
	    		
	    		
	    		List<ItemGroupVO> itemGroup = estimateService.selectItemGroup();
	    		nJson.put("itemGroup", itemGroup);
	    		
	    		nJson.put("RESULT_YN", "Y");
	    		
	    	} else if ("insertItemsCheck".equals(formTag)){
	    		/* addItems 전 예외 처리 사항 */
	    		String reqid = req.getParameter("reqid");
	    		String smpid = req.getParameter("smpid");
	    		
	    		String items = req.getParameter("items");
		    	//String pItems = req.getParameter("pItems");
	    		HashMap<String, Object> map = new HashMap<String, Object>();
	    		map.put("reqid", reqid);
	    		map.put("smpid", smpid);
	    		map.put("regid", "support");
	    		
		    	
		    	/*items*/
	    		String[] aItems = items.split("\\|");
	    		ArrayList< String> itemList = new ArrayList<String>();
	    		
	    		for (int i = 0; i < aItems.length; i++) {
	    			String itemid = aItems[i];
	    			if(itemid !=null && !"".equals(itemid)){
	    				String[] aItem = itemid.split(",");
	    				itemList.add(aItem[0]);
	    			}
				}
	    		
	    		map.put("itemList", itemList);
	    		
	    		
	    		if(itemList.size()>0){
		    		List<ExceptItem> exceptItem = estimateService.selectExceptItems(map);
		    		nJson.put("RESULT_EXCEPTITEM", exceptItem);
		    		/* 기존 항목 삭제 여부 */
		    		if(exceptItem.size()>0){
		    			nJson.put("RESULT_EXCEPT", "Y");
		    		} else {
		    			nJson.put("RESULT_EXCEPT", "N");	
		    		}
		    		
		    		List<DuplicateVO> duplicateVO = estimateService.selectDuplicate(map);
		    		nJson.put("RESULT_DUPLICATEVO", duplicateVO);
		    		
		    		if(duplicateVO.size()>0){
		    			nJson.put("RESULT_DUPLICATE", "Y");
		    			
		    		} else {
		    			nJson.put("RESULT_DUPLICATE", "N");
		    		}
	    		
	    		} else {
	    			nJson.put("RESULT_DUPLICATE", "N");
	    			nJson.put("RESULT_EXCEPT", "N");
	    		}
	    		
	    	}

    	} catch (Exception e){
    		nJson.put("RESULT_ERRER", "Y");
    	}
    	
    	PrintWriter out = res.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }
    
    
 	// 의뢰정보 적용하기 ;
    
    @RequestMapping(value="/support/setRequest.json")
    public @ResponseBody void  setRequest(HttpServletRequest req, HttpServletResponse res) throws Exception{
    	req.setCharacterEncoding("UTF-8"); 
    	res.setContentType("text/html;charset=UTF-8");
    	
    	JSONObject nJson = new JSONObject();
    	String data      = StringUtils.nvl(req.getParameter("frmData"),"");
    	
    	
    	try{
    		JSONArray jarray = JSONArray.fromObject(JSONSerializer.toJSON(data));
    		
	        for(int i = 0; i < jarray.size(); i++){
	        	RequestVO vo = (RequestVO)JSONObject.toBean(jarray.getJSONObject(i), RequestVO.class);
	        	vo.setMemid("support");
	        	vo.setRegid("support");
	        	
	        	// request 
	        	vo.setReqstate("-1");                    // 일반의뢰 상태 임시
	        	
	        	// report
	        	vo.setReportid("1");      // 최초 보고서 아이디 
	        	vo.setOrgcnt("1");        // 원본 성적서 수량 
	        	vo.setReportstate("-1");  // 성석저 임시저장
	        	vo.setType("O");          // 성적서 유형
	        	
            	List<RequestVO> revalRequestVO = estimateService.setRequest(vo);
            	nJson.put("RESULT_YN"     ,"Y");
        		nJson.put("RESULT_MESSAGE","");
        		nJson.put("RESULT_VO", revalRequestVO);
        		
        		
        		// 수수료 계산 정보 
        		// calPrice
        		SampleVO sampleVO = new SampleVO();
        		if(revalRequestVO.size()>0) sampleVO.setReqid(revalRequestVO.get(0).getReqid());
        		estimateService.procCalPrice(sampleVO);
        		 
        		List<PriceVO> reval_priceVO = estimateService.selectPrice(sampleVO);
        		nJson.put("RESULT_PRICEVO", reval_priceVO);
	        }
    	}catch(Exception e){
      	  nJson.put("RESULT_YN"     ,"N");
          nJson.put("RESULT_MESSAGE",e.getMessage());
    	}
    	
    	PrintWriter out = res.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }
    
    
 	// 시료정보 적용하기 ;
    
    @RequestMapping(value="/support/setSample.json")
    public @ResponseBody void  setSample(HttpServletRequest req, HttpServletResponse res, SampleVO sampleVO) throws Exception{
    	
    	req.setCharacterEncoding("UTF-8"); 
    	res.setContentType("text/html;charset=UTF-8");
    	
    	JSONObject nJson = new JSONObject();
    	String reqid = req.getParameter("reqid");
    	String masterid = req.getParameter("masterid");
    	String samplename = req.getParameter("samplename");
    	
    	
    	try{

    		if(reqid == null || "".equals(reqid)){
    			RequestVO vo = new RequestVO();
	        	vo.setMemid("support");
	        	vo.setRegid("support");
	        	
	        	// request 
	        	vo.setReqstate("-1");                    // 일반의뢰 상태 임시
	        	
	        	// report
	        	vo.setReportid("1");      // 최초 보고서 아이디 
	        	vo.setOrgcnt("1");        // 원본 성적서 수량 
	        	vo.setReportstate("-1");  // 성석저 임시저장
	        	vo.setType("O");          // 성적서 유형
	        	
            	List<RequestVO> revalRequestVO = estimateService.setRequest(vo);
        		
        		reqid = revalRequestVO.get(0).getReqid();
        		
        		sampleVO.setReqid(reqid);
    		} else {
    			// delete sample
    			estimateService.deleteRequestSample(reqid);;
    		}
    		
    		
    		sampleVO.setRegid("support");
    		
    		SampleVO saveSampleVO = estimateService.adjustSample(sampleVO);
    		
    		
    		// calPrice
    		estimateService.procCalPrice(sampleVO);
    		
    		
    		// get sample 
    		List<SampleVO> reval_sampleVO = estimateService.selectSample(sampleVO);
    		// get price
    		List<PriceVO> reval_priceVO = estimateService.selectPrice(sampleVO);
    		
            nJson.put("RESULT_YN"     ,"Y");
        	nJson.put("RESULT_MESSAGE","");
        	nJson.put("SMPID", saveSampleVO.getSmpid());
        	nJson.put("REQID", saveSampleVO.getReqid());
        	nJson.put("RESULT_SAMPLEVO", reval_sampleVO);
        	nJson.put("RESULT_PRICEVO", reval_priceVO);
	        
    	}catch(Exception e){
      	  nJson.put("RESULT_YN"     ,"N");
          nJson.put("RESULT_MESSAGE",e.getMessage());
    	}
    	
    	PrintWriter out = res.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    } 
 	
    /* delete Sample */
    @RequestMapping(value="/support/deleteSample.json")
    public @ResponseBody void  deleteSample(HttpServletRequest req, HttpServletResponse res) throws Exception{
    	
    	req.setCharacterEncoding("UTF-8"); 
    	res.setContentType("text/html;charset=UTF-8");
    	
    	JSONObject nJson = new JSONObject();
    	String reqid = req.getParameter("reqid");
    	String smpid = req.getParameter("smpid");
    	
    	
    	try{
    		SampleVO sampleVO = new SampleVO();
    		sampleVO.setReqid(reqid);
    		sampleVO.setSmpid(smpid);
    		
    		sampleVO.setRegid("support");
    		
    		/* 담당자 삭제 */
    		estimateService.deleteAssignSmple(sampleVO);
    		List<SampleVO> re_sampleVO = estimateService.deleteSample(sampleVO);

    		//cal price
    		estimateService.procCalPrice(sampleVO);
    		List<PriceVO> re_priceVO = estimateService.selectPrice(sampleVO);
    		
            nJson.put("RESULT_YN"     ,"Y");
        	nJson.put("RESULT_MESSAGE","OK");
        	nJson.put("RESULT_SAMPLEVO", re_sampleVO);
        	nJson.put("RESULT_PRICEVO", re_priceVO);
	        
    	}catch(Exception e){
      	    
    		nJson.put("RESULT_YN"     ,"N");
            nJson.put("RESULT_MESSAGE",e.getMessage());
    	}
    	
    	PrintWriter out = res.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }
    
    
 	// 항목 추가하기  ;
    /*
    @RequestMapping(value="/support/addItems.json")
    public @ResponseBody void  addItems(HttpServletRequest req, HttpServletResponse res) throws Exception{
    	
    	
    	LoginUserVO loginUser = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
    	
    	JSONObject nJson = new JSONObject();
    	String reqid = req.getParameter("reqid");
    	String smpid = req.getParameter("smpid");
    	String items = req.getParameter("items");
    	
    	
    	try{
    		
    		String[] aItem = items.split("\\|");
    		
    		HashMap<String, String> map = new HashMap<String, String>();
    		map.put("reqid", reqid);
    		map.put("smpid", smpid);
    		
    		for (int i = 0; i < aItem.length; i++) {
    			String itemid = aItem[i];
    			if(itemid !=null && !"".equals(itemid)){
    				
    				map.put("itemid", itemid);
    				
    				estimateService.insertResultItem(map);
    			}
			}
    		
    		
    		
    		SampleVO sampleVO = new SampleVO();
    		sampleVO.setReqid(reqid);
    		sampleVO.setSmpid(smpid);
    		
    		 담당자 
    		estimateService.deleteAssignSmple(sampleVO);
    		estimateService.insertAssignSmple(sampleVO);
    		
    		List<ResultVO> resultVO = estimateService.selectResult(sampleVO);
    				
    		
            nJson.put("RESULT_YN"     ,"Y");
        	nJson.put("RESULT_MESSAGE","");
        	nJson.put("RESULT_ITEMS", resultVO);
	        
    	}catch(Exception e){
      	  nJson.put("RESULT_YN"     ,"N");
          nJson.put("RESULT_MESSAGE",e.getMessage());
    	}
    	
    	PrintWriter out = res.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
    }*/
    
    
	@RequestMapping(value="/supportuest/attachFile.json")
    public void fileAttach(HttpServletRequest req, HttpServletResponse resp, RequestAttachVO requestAttachVO) throws Exception {
		LoginUserVO loginUser = (LoginUserVO)req.getSession().getAttribute("loginUserVO");
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;   
		MultipartFile file = (MultipartFile) multipartRequest.getFile("attach");   
		
		String newFileName = System.currentTimeMillis() + UUID.randomUUID().toString() +file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		Date date = new Date();
		//SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM");
		FastDateFormat dateFormat = FastDateFormat.getInstance( "yyyyMM", Locale.getDefault());

		String osname = System.getProperty("os.name");
		String saveDir = dateFormat.format(date);
		
		//저장할 디렉토리	임시
		if(osname.equals("Windows 7")){
			saveDir = EgovProperties.getProperty("Globals.WinfilePath")+saveDir+"/";
		} else {
			saveDir = EgovProperties.getProperty("Globals.LinuxfilePath")+saveDir+"/";
		}
		String filePath = saveDir + newFileName;
		
		File target = new File(saveDir, newFileName);
		target.mkdirs();
        file.transferTo(target);
        
        String reqid = req.getParameter("file_reqid");
        
        requestAttachVO.setFilepath(filePath);
        requestAttachVO.setOrgname(new String(file.getOriginalFilename().getBytes("8859_1"),"UTF-8"));
        requestAttachVO.setSavename(newFileName);
        requestAttachVO.setReqid(reqid);        
        requestAttachVO.setRegid(loginUser.getMemid());
        
        JSONObject nJson = new JSONObject();
        
        try{
        	estimateService.insertAttach(requestAttachVO);

        	List<RequestAttachVO> listAttachVO = estimateService.selectAttach(reqid);
        	
        	nJson.put("RESULT_ATTACH" ,listAttachVO);
    		nJson.put("RESULT_YN"     ,"Y");
    		nJson.put("RESULT_MESSAGE","");
		}catch(Exception e){
			nJson.put("RESULT_YN"     ,"N");
			nJson.put("RESULT_MESSAGE",e.getMessage());
		}
		
        PrintWriter out = resp.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
        
	}
	
	
	@RequestMapping("/supportuest/deleteFile.json")
    public void delSampleFile(HttpServletRequest req, HttpServletResponse resp, RequestAttachVO requestAttachVO ) throws Exception {
		
		JSONObject nJson = new JSONObject();
        try{
        	String reqid = req.getParameter("reqid");
        	String reqfid = req.getParameter("reqfid");
        	
        	HashMap<String, String> map = new HashMap<String, String>();
        	map.put("reqid", reqid);
        	map.put("reqfid", reqfid);
        	estimateService.deleteAttach(map);
        	
        	File target = new File(requestAttachVO.getFilepath());
    		target.delete();
    		
    		List<RequestAttachVO> listAttachVO = estimateService.selectAttach(reqid);
    		
    		nJson.put("RESULT_ATTACH" ,listAttachVO);
    		nJson.put("RESULT_YN"     ,"Y");
    		nJson.put("RESULT_MESSAGE","");
		}catch(Exception e){
			nJson.put("RESULT_YN"     ,"N");
			nJson.put("RESULT_MESSAGE",e.getMessage());
		}
		
        PrintWriter out = resp.getWriter();
        out.write(nJson.toString());
        out.flush();
        out.close();
	}
    
}
