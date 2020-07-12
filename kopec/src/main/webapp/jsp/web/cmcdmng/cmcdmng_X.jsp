<%@ page language    = "java"
    contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"
    import      = "java.util.*,
                   java.io.*,
                   com.nc.util.DataSet,
                   com.nc.common.CmCdMng,
                   com.nc.util.ConvUtil"
%><%
	/********************************************************************************************************
	* ajax 적극 활용
	*********************************************************************************************************/
	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","0");
	response.setHeader("pragma","no-cache");

	request.setCharacterEncoding("utf-8");  //ajax에서 한글 전송하기 위해 utf-8 캐릭터셋으로 받아야 한다.
	String sFlag = request.getParameter("actGubn") != null ? request.getParameter("actGubn") : "err";

	System.out.println(sFlag+"//");
	CmCdMng cdm = new CmCdMng();
	String sMsg = "";
	DataSet ds = null;
	String json = "";

	if("save".equals(sFlag)||"del".equals(sFlag)){
		cdm.setCodeDefine(request, response);
		sMsg = (String)request.getAttribute("sMsg");
		json =	"{ \n" +
	    		"\"msg\" : \"" + sMsg + "\"" +
	    		"}";
	} else if ("list".equals(sFlag)){
		cdm.getCodeList(request, response);
		ds= (DataSet)request.getAttribute("ds");
		if(ds.getRowCount() >0){
			sMsg="성공";
			json = ConvUtil.DsToJson(ds);
		}
	}

	/*
	올바른 json 형태 : 나중에 다중열 데이타를 받아올때 쓰면 될듯 :
		콜한 jsp에서 json 사용법 : eval("var result = " + request.responseText);
    							 alert(result.rs[1].pnm);

	{"rs" : [
		{"pid" : "sp_etlxxxxx1","pnm" : "테스트1","type" : "011"},
		{"pid" : "sp_etlxxxxx2","pnm" : "테스트2","type" : "012"},
		{"pid" : "sp_etlxxxxx3","pnm" : "테스트3","type" : "013"}
	]}
	*/

%><%=json %>