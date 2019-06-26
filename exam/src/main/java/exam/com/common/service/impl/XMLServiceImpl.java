package exam.com.common.service.impl;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.xerces.dom.DocumentImpl;
import org.apache.xml.serialize.XMLSerializer;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import exam.com.common.StringUtils;
import exam.com.common.model.XmlItemVO;
import exam.com.common.model.XmlReportVO;
import exam.com.common.service.XMLService;

/**
 * Created by owner1120 on 2016-01-26.
 */
@Service("xmlService")
public class XMLServiceImpl implements XMLService {

    @Resource(name = "xmlDAO")
    XMLDAO xmlDAO;

    @Override
    public String selectXML(HashMap<String, String> map) throws Exception {
    	
    	XmlGenerator generator = new XmlGenerator();
    	generator.addRootElement("root");
    	generator.addElement("root", 0, "kpetro");
    	//generator.print();
    		
    	List<XmlReportVO> list_report = (List<XmlReportVO>)xmlDAO.selectXmlReport(map);
    	//성적서 기본 정보 
    	if(list_report!=null && list_report.size()>0){
    		XmlReportVO reportVO = list_report.get(0);
    		if(reportVO!=null){
    			generator.addElementCDATA("kpetro", 0, "comname",   StringUtils.nvl(reportVO.getRcvcompany(),"") );   /* 업체명 */
    			generator.addElementCDATA("kpetro", 0, "mngname",   StringUtils.nvl(reportVO.getRcvceo(),"")  );       /* 대표자 */
    			
    			generator.addElementCDATA("kpetro", 0, "rcvaddr",   StringUtils.nvl(reportVO.getRcvaddr(),"")  );      /* 주소 */
    			generator.addElementCDATA("kpetro", 0, "acceptno",  StringUtils.nvl(reportVO.getAcceptno(),"")  );     /* 접수번호 */
    			generator.addElementCDATA("kpetro", 0, "reportno",  StringUtils.nvl(reportVO.getReportno(),"")  );     /* 성적서번호 */
    			generator.addElementCDATA("kpetro", 0, "receiptdate", StringUtils.nvl(reportVO.getReceiptdate(),"")  );  /* 접수일자 */
    			generator.addElementCDATA("kpetro", 0, "testenddate", StringUtils.nvl(reportVO.getTestenddate(),"")  );  /* 시험완료일자 */
    			generator.addElementCDATA("kpetro", 0, "codename",  StringUtils.nvl(reportVO.getCodename(),"")  );     /* 성적서용도 */
    			generator.addElementCDATA("kpetro", 0, "draftnm",   StringUtils.nvl(reportVO.getRcvmngname(),"")  );   /* 담당자 */
    			generator.addElementCDATA("kpetro", 0, "apprnm",    StringUtils.nvl(reportVO.getApprnm(),"")  );       /* 승인자 */
    			generator.addElementCDATA("kpetro", 0, "agreedate", StringUtils.nvl(reportVO.getIssuedate(),"")  );    /* 승인날짜 */
    			
    		} else {
    			generator.addElementCDATA("kpetro", 0, "error", "reportVO is null");
    		}
    	} else {
    		generator.addElementCDATA("kpetro", 0, "error", "list_report is null");
    	}
    	
    	// 시료 정보 적용 
    	List<XmlItemVO> list_item = (List<XmlItemVO>) xmlDAO.selectXmlItem(map);
    	String smpid = "";
    	Element elSmp = null;
    	if(list_item!=null && list_item.size()>0){
    		// 시료 추가
    			// 항목 추가
    		for (int i = 0; i < list_item.size(); i++) {
    			XmlItemVO itemVO = list_item.get(i);

    			// new sample
				if(!smpid.equals(itemVO.getSmpid())){
					elSmp = generator.addElementCDATA("kpetro", 0, "rows");
					generator.addAttribute(elSmp, "smpnm", itemVO.getSmpnm());
					smpid = itemVO.getSmpid();
				}
				
				/* adjust items */
				/*Element elItem = generator.addElementCDATA(elSmp, "row");
				generator.addAttribute(elItem, "lvl", itemVO.getLvl());
				generator.addAttribute(elItem, "idx", itemVO.getRowidx() );
				generator.addAttribute(elItem, "total", itemVO.getItemtotal() );
				
				generator.addElementCDATA(elItem, "itemname",  StringUtils.nvl(itemVO.getItemname(),"")) ;
		
				
				Element elItemname1 = generator.addElementCDATA(elItem, "itemname1", StringUtils.nvl(itemVO.getItemname1(),""));
				generator.addAttribute(elItemname1, "idx", itemVO.getItemidx());
				generator.addAttribute(elItemname1, "total", itemVO.getItemcnt());
				
				generator.addElementCDATA(elItem, "itemname2", StringUtils.nvl(itemVO.getItemname2(),""));
				generator.addElementCDATA(elItem, "itemname3", StringUtils.nvl(itemVO.getItemname3(),""));
				
				generator.addElementCDATA(elItem, "displayunit", StringUtils.nvl(itemVO.getDisplayunit(),""));
				
				generator.addElementCDATA(elItem, "resultvalue", StringUtils.nvl(itemVO.getResultvalue(),""));
				generator.addElementCDATA(elItem, "resultflag", StringUtils.nvl(itemVO.getResultflag(),""));
				generator.addElementCDATA(elItem, "resultlevel", StringUtils.nvl(itemVO.getResultlevel(),""));
				
				Element elMethod = generator.addElementCDATA(elItem, "methodnm", StringUtils.nvl(itemVO.getMethodnm(),""));
				generator.addAttribute(elMethod, "idx", itemVO.getItemidx());
				generator.addAttribute(elMethod, "total", itemVO.getItemcnt());*/
				
				
				Element elItem = generator.addElementCDATA(elSmp, "item");
				generator.addAttribute(elItem, "lvl", itemVO.getRlvl());
				generator.addAttribute(elItem, "total", itemVO.getTcnt() );
				generator.addAttribute(elItem, "idx", itemVO.getPageitemidx());
				
				
				//generator.addElementCDATA(elItem, "itemname",  StringUtils.nvl(itemVO.getItemname(),"")) ;
		
				
				Element elItemname1 = generator.addElementCDATA(elItem, "data01", StringUtils.nvl(itemVO.getItemname1(),""));
				if(itemVO.getRlvl().equals("3")){
				generator.addAttribute(elItemname1, "lev", itemVO.getLev());
				generator.addAttribute(elItemname1, "levcnt", itemVO.getLevcnt());
				}
				
				generator.addElementCDATA(elItem, "data02", StringUtils.nvl(itemVO.getItemname2(),""));
				generator.addElementCDATA(elItem, "data03", StringUtils.nvl(itemVO.getItemname3(),""));
				
				generator.addElementCDATA(elItem, "data04", StringUtils.nvl(itemVO.getDisplayunit(),""));
				
				generator.addElementCDATA(elItem, "data05", StringUtils.nvl(itemVO.getResultvalue(),""));
				//generator.addElementCDATA(elItem, "resultflag", StringUtils.nvl(itemVO.getResultflag(),""));
				//generator.addElementCDATA(elItem, "resultlevel", StringUtils.nvl(itemVO.getResultlevel(),""));
				
				//Element elMethod = generator.addElementCDATA(elItem, "data06", StringUtils.nvl(itemVO.getMethodnm(),""));
				generator.addElementCDATA(elItem, "data06", StringUtils.nvl(itemVO.getMethodnm(),""));
				//generator.addAttribute(elMethod, "idx", itemVO.getItemidx());
				//generator.addAttribute(elMethod, "total", itemVO.getItemcnt());
			}
    		
    		
    		
    	} else {
    		generator.addElementCDATA("kpetro", 0, "error", "list_item is null");
    	}
   
    	
    	return generator.toString();
    }



}
