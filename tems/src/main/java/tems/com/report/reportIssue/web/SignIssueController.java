package tems.com.report.reportIssue.web;


import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class SignIssueController {
	/** Log Info */
    protected Log log = LogFactory.getLog(this.getClass());
    
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	
    /**
     * <설명> 전자결재 정보 전송처리
     * 
     * @param [request] 
     * @return [modelAndView]
     * @throws [예외명] [설명] // 각 예외 당 하나씩
     * @author [열린기술]
     * @fix(<수정자명>) [yyyy.mm.dd]: [수정 내용]
     * @URL테스트: 
     */ 
    @RequestMapping(value="/ajax/executeESign.json", method={RequestMethod.POST,RequestMethod.GET})
    public ModelAndView executeESign(ModelMap model, HttpServletRequest request){        
        ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
        try {
            
            String USER_AGENT = "Mozilla/5.0";
            String url = "http://" +propertyService.getString("Globals.eleSignServer") + propertyService.getString("Globals.createEleSignUrl");
            URL obj = new URL(url);
            //HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            
            log.error("executeElecSign url:" + url);
     
            // optional default is GET
            //con.setRequestMethod("POST");
     
            //add request header
            //con.setRequestProperty("User-Agent", USER_AGENT);
            String marshalledXml = org.apache.commons.io.IOUtils.toString(request.getInputStream());
            //System.out.println("## param:" + marshalledXml);
            String urlParameters = marshalledXml;

            //con.setDoOutput(true);
            //DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            //wr.writeBytes(urlParameters);
            //wr.flush();
            //wr.close();
     
            //int responseCode = con.getResponseCode();
            System.out.println("\nSending 'POST' request to URL : " + url);
            System.out.println("Post parameters : " + urlParameters);
            //System.out.println("Response Code : " + responseCode);
     
            
            //log.error("executeElecSign responseCode:" + responseCode);
            
            
            //BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();
     
            //while ((inputLine = in.readLine()) != null) {
              //  response.append(inputLine);
            //}
            //in.close();
            
            log.error("executeElecSign response:" + response.toString());
            
            //System.out.println(response.toString());

            /**
             * <?xml version="1.0" encoding="utf-8"?>
             * <ndata>                    
             * <status>Success</status>        
             * <code>0</code>
             * </ndata>
             * <?xml version="1.0" encoding="utf-8"?><ndata>    <status>Error</status>      <code>3</code>      <message>중복된 문서 ID</message></ndata>
             */
            
            Document doc = this.convertStringToDocument(response.toString());
            NodeList nodes = doc.getElementsByTagName("ndata");
            Element element = (Element) nodes.item(0);
            NodeList status = element.getElementsByTagName("status");
            
            String strStatus = status.item(0).getFirstChild().getNodeValue();
            if(!strStatus.toLowerCase().equals("success")) {
                modelAndView.addObject("status", "error");
                NodeList message = element.getElementsByTagName("message");
                String strMessage = message.item(0).getFirstChild().getNodeValue();
                modelAndView.addObject("message", strMessage);
            }
            else {
                modelAndView.addObject("status", "success");
                modelAndView.addObject("message", "");
            }
             
            log.error("executeElecSign Success:");
            
            modelAndView.addObject("ConstantValue.RESULT_CODE","ConstantValue.RESULT_SUCCESS");
        } catch (Exception e) {
            modelAndView.addObject("ConstantValue.RESULT_CODE", "ConstantValue.RESULT_FAIL");
            log.error(e);
        }    
        
        return modelAndView;
    }    
    
    private Document convertStringToDocument(String xmlStr) {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();  
        DocumentBuilder builder;  
        try  
        {  
            builder = factory.newDocumentBuilder();  
            Document doc = builder.parse( new InputSource( new StringReader( xmlStr ) ) ); 
            return doc;
        } catch (Exception e) {  
            log.error(e);  
        } 
        return null;
    }    

}
