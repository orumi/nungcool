<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*,java.util.*,java.lang.*, java.text.*" %>
<%@ page language="java" import="org.apache.commons.logging.Log"%>
<%@ page language="java" import="org.apache.commons.logging.LogFactory"%>
<%@ page import="com.cabsoft.smartcert.SerialReportExpressPrint"%>
<%@ page import="com.cabsoft.rx.engine.ReportExpressPrint" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%@ page language="java" import="com.cabsoft.utils.SimpleQuery"%>
<%@ page language="java" import="com.cabsoft.RXSession"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.RSAKey"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.RSAKeyInstance"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.RSA"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.TEA"%>

<%!public class SerialBeans {

	private final Log log = LogFactory.getLog(SerialBeans.class);
	
	public String processRequest(HttpServletRequest request, HttpServletResponse response) {
		String ret = "";
		try{
			String jobID = "";
			RXSession ss = null;
			
			String __p = (String)request.getParameter("__p");
			String __q = (String)request.getParameter("__q");

			__p = __p==null ? "" : __p;
			__q = __q == null ? "" : __q;
			
			if(!"".equals(__p) && !"".equals(__q)){
				RSAKeyInstance key = RSAKeyInstance.getInstance();
				RSAKey rsaKey = key.getKey();
				RSA rsa = new RSA(rsaKey);
				String teaKey = rsa.decrypt(__q);
				TEA tea = new TEA(teaKey);
				__p = tea.decrypt(__p);

				log.debug("params = " + __p);
				
				SimpleQuery qry = new SimpleQuery();
				qry.setQuery(__p);
				jobID = qry.getQuery("jobID");
				
				ss = (RXSession)request.getSession().getAttribute(jobID+"_session");
				
				if(ss==null){
					ret = "세션에 저장된 데이터(RXSession)가 없습니다.";
				}else if(!jobID.equalsIgnoreCase(ss.getJobID())){
					ret = "세션 ID가 일치하지 않습니다.";
				}else{
					String issuerID = ss.getIssueID();
				
					/*
					 * 발급번호 관련 처리
					 */
					ret = "OK";
				}				
			}else{
				ret = "데이터 요청이 잘못되었습니다(암호화)";
			}
		}catch(Exception e){
			ret = e.toString();
		}
		
		return ret;
	}

}
%>