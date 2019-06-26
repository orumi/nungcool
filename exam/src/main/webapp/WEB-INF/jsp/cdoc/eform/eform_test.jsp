<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="utf-8">
<title>증명발급 테스트 페이지</title>
<script src="../cdoc/eform/js/jquery-1.9.1.js" ></script>
</head>
<body>

<form>
	<table>
		<tr>
			<td>구분</td>
			<td>서식타이틀</td>
			<td>서식파일명</td>
			<td>DB데이터</td>
			<td></td>
		</tr>
		<tr>
			<td>증명발급 팝업</td>
			<td>
				<input type="text" id="txt_title1" name="txt_title1" value="시험성적서" />
			</td>
			<td>
				<input type="text" id="txt_file1" name="txt_file1" value="report1" />
			</td>
			<td>
				<select id="sel_db1" name="sel_db1">
					<option value="N">사용안함</option>
					<option value="Y">사용</option>
				</select>
			</td>
			<td>
				<input type="button" value="클릭" onclick="eformOpenPop();">
			</td>
		</tr>
		<tr>
			<td>결재용 PDF 생성</td>
			<td>
				<input type="text" id="txt_title2" name="txt_title2" value="시험성적서" />
			</td>
			<td>
				<input type="text" id="txt_file2" name="txt_file2" value="report1" />
			</td>
			<td>
				<select id="sel_db2" name="sel_db2">
					<option value="N">사용안함</option>
					<option value="Y">사용</option>
				</select>
			</td>
			<td>
				<input type="button" value="클릭" onclick="eformDownload();">
			</td>
		</tr>
		<tr height="20px"></tr>
		<tr>
			<td colspan="5">XML데이터</td>
		</tr>	
		<tr>
			<td colspan="5"><textarea id="txt_xmlData" name="txt_xmlData" style="width: 100%; height: 500px;"></textarea></td>
		</tr>
	</table>
</form>

<!-- 증명발급 팝업 호출 -->
<!-- 민원인 접근 - 시험성적서 <input type="button" value="증명발급" onclick="eformOpenPop();"> -->
<br/><br/>
<!-- 직원용 증명발급 PDF 다운로드 -->
<!-- 직원 접근 - 시험성적서 <input type="button" value="증명발급" onclick="eformDownload();"> -->
</body>

<script>
	$(document).ready(function(){
		document.getElementById("txt_xmlData").value = xmlString;
	});

	// 증명발급 팝업 호출
	function eformOpenPop(){
		var reportTitle = document.getElementById("txt_title1").value;
		var reportFile = document.getElementById("txt_file1").value;
		var xmlData = document.getElementById("txt_xmlData").value;
		var dbUse = document.getElementById("sel_db1").value;
		
		if(dbUse == "N" && $.trim(xmlData) == ""){
			alert("XML 데이터를 입력해주세요");
			return;
		}
		
		f = makeForm("../cdoc/eform/smartcert.jsp");										// 증명발급 호출 팝업 jsp
		f.appendChild(addData("Servlet", "/eform/smartcert.do"));							// 증명발급 서비스 URL
		f.appendChild(addData("xmlType", "xmlstring"));										// 서식 데이터 타입
		f.appendChild(addData("plugin", "1"));												// PDF Viewer Plugin 사용 여부
		f.appendChild(addData("rptTitle", encodeURIComponent(reportTitle)));				// 서식 타이틀
		f.appendChild(addData("ReportFile", reportFile));									// 서식 파일명
		
		
		f.appendChild(addData("xmlData", encodeURIComponent(xmlData)));						// ★★★ xmlData는 테스트페이지에서만 사용하는 파라미터
		f.appendChild(addData("dbUse", dbUse));												// ★★★ dbUse는 테스트페이지에서만 사용하는 파라미터

		
		window.open ("","ReportView",f);
		f.target = "ReportView";
		f.submit();
	}
	
	function makeForm(url){
		var f = document.createElement("form");
	    f.setAttribute("method", "post");
	    f.setAttribute("action", url);
	    document.body.appendChild(f);
	      
	    return f;
	}
	
	function addData(name, value){
		var i = document.createElement("input");
		i.setAttribute("type","hidden");
		i.setAttribute("name",name);
		i.setAttribute("value",value);
		return i;
	}
	
	// 직원용 증명발급 PDF 다운로드
	function eformDownload(){
		
		var reportTitle = document.getElementById("txt_title2").value;
		var reportFile = document.getElementById("txt_file2").value;
		var xmlData = document.getElementById("txt_xmlData").value;
		var dbUse = document.getElementById("sel_db2").value;
		
		if(dbUse == "N" && $.trim(xmlData) == ""){
			alert("XML 데이터를 입력해주세요");
			return;
		}
	 	
	 	$.ajax({
			type     : "post",
		    dataType : "json",
		    async    : false,
		    data: { 
				"ReportFile": "report1", 								// 서식 파일명
				"rptTitle": encodeURIComponent(reportTitle), 			// 서식 타이틀
				"xmlType": "xmlstring", 								// 서식 데이터 타입
				
				
				"xmlData": encodeURIComponent(xmlData),					// ★★★ xmlData는 테스트페이지에서만 사용하는 파라미터
				"dbUse": dbUse											// ★★★ dbUse는 테스트페이지에서만 사용하는 파라미터
				
			},
	        url      : "<c:url value='/eform/smartcertTempPdf.do'/>",	// 호출 url
	        success: function (data) {
				if(data.result == 'OK'){
					alert("PDF 생성에 성공하였습니다.");
				}else{
					alert("PDF 생성에 실패하였습니다.");
				}
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        },
	        complete: function (data) {
	        	//gridView.hideToast();
	        },
	        cache: false
	    });
		
	}
	
var xmlString = "<?xml version=\"1.0\" encoding=\"euc-kr\"?> \n"+
"<root> \n"+
"	<kpetro> \n"+
"		<comname><![CDATA[대성나찌공업]]></comname>						<!-- 업체명 -->                                                         \n"+
"		<mngname><![CDATA[대표자1]]></mngname>							<!-- 대표자 -->                                                         \n"+
"		<rcvaddr><![CDATA[경상남도 양산시 유산동 289-22]]></rcvaddr>	<!-- 주소 -->                                                           \n"+
"		<acceptno><![CDATA[TSC2016-0342]]></acceptno>					<!-- 접수번호 -->                                                       \n"+
"		<reportno><![CDATA[TSC2016-0158L]]></reportno>					<!-- 성적서번호 -->                                                     \n"+
"		<receiptdate><![CDATA[2016년 01월 29일]]></receiptdate>			<!-- 접수일자 -->                                                       \n"+
"		<testenddate><![CDATA[2016년 02월 12일]]></testenddate>			<!-- 시험완료일자 -->                                                   \n"+
"		<currpagecnt><![CDATA[1]]></currpagecnt>						<!-- 현재페이지 -->                                                     \n"+
"		<pagecnt><![CDATA[2]]></pagecnt>								<!-- 총페이지 -->                                                       \n"+
"		<codename><![CDATA[품질관리용]]></codename>						<!-- 성적서용도 -->                                                     \n"+
"		<draftnm><![CDATA[담당자1]]></draftnm>							<!-- 담당자 -->                                                         \n"+
"		<apprnm><![CDATA[승인자1]]></apprnm>							<!-- 승인자 -->                                                         \n"+
"		<agreedate><![CDATA[2016년 02월 18일]]></agreedate>				<!-- 승인날짜 -->			<!-- 컬럼 없음 -->                          \n"+
"	<!-- 	<docno><![CDATA[0000-0000-0000-0000]]></docno>	 -->				<!-- 문서확인번호 -->		<!-- 컬럼 없음 -->				<!-- 삭제 -->"+
"		<resulttxt><![CDATA[붙임참조]]></resulttxt>						<!-- 시험결과 -->											<!-- 추가 -->"+
"		<draftsign><![CDATA[http://blog.jinbo.net/attach/615/200937431.jpg]]></draftsign>						<!-- 담당자서명 -->             \n"+
"		<apprsign><![CDATA[http://10.1.11.149:8088/tems/images/sign/9754.gif]]></apprsign>						<!-- 승인자서명 -->	<!-- 추가 -->"+
"		<rows smpnm=\"JP-8\">												<!-- 시료명 -->                                                     \n"+
"			<row lvl=\"1\">                                                                                                                     \n"+
"				<itemname1><![CDATA[밀도(15 ℃)]]></itemname1>                                                                                  \n"+
"				<displayunit><![CDATA[㎏/㎥]]></displayunit>                                                                                    \n"+
"				<resultvalue><![CDATA[775.5]]></resultvalue>                                                                                    \n"+
"				<methodnm><![CDATA[ASTM D4052-11]]></methodnm>                                                                                  \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"1\">                                                                                                                     \n"+
"				<itemname1><![CDATA[색(세이볼트색도)]]></itemname1>                                                                             \n"+
"				<displayunit><![CDATA[-]]></displayunit>                                                                                        \n"+
"				<resultvalue><![CDATA[+20]]></resultvalue>                                                                                      \n"+
"				<methodnm><![CDATA[ASTM D156-11]]></methodnm>                                                                                   \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"1\" total=\"8\"><![CDATA[증류성상]]></itemname1>                                                               \n"+
"				<itemname2><![CDATA[초류점(IBP))]]></itemname2>                                                                                 \n"+
"				<displayunit><![CDATA[℃]]></displayunit>                                                                                       \n"+
"				<resultvalue><![CDATA[175.1]]></resultvalue>                                                                                    \n"+
"				<methodnm idx=\"1\" total=\"8\"><![CDATA[ASTM D86-15]]></methodnm>                                                              \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"2\" total=\"8\"><![CDATA[증류성상]]></itemname1>                                                               \n"+
"				<itemname2><![CDATA[10 % 유출온도]]></itemname2>                                                                                \n"+
"				<displayunit><![CDATA[℃]]></displayunit>                                                                                       \n"+
"				<resultvalue><![CDATA[204.3]]></resultvalue>                                                                                    \n"+
"				<methodnm idx=\"2\" total=\"8\"><![CDATA[ASTM D86-15]]></methodnm>                                                              \n"+
"				<commend><![CDATA[주석내용2]]></commend>                                                                                        \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"3\" total=\"8\"><![CDATA[증류성상]]></itemname1>                                                               \n"+
"				<itemname2><![CDATA[20 %  유출온도]]></itemname2>                                                                               \n"+
"				<displayunit><![CDATA[℃]]></displayunit>                                                                                       \n"+
"				<resultvalue><![CDATA[220.4]]></resultvalue>                                                                                    \n"+
"				<methodnm idx=\"3\" total=\"8\"><![CDATA[ASTM D86-15]]></methodnm>                                                              \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"4\" total=\"8\"><![CDATA[증류성상]]></itemname1>                                                               \n"+
"				<itemname2><![CDATA[50 % 유출온도]]></itemname2>                                                                                \n"+
"				<displayunit><![CDATA[℃]]></displayunit>                                                                                       \n"+
"				<resultvalue><![CDATA[260.8]]></resultvalue>                                                                                    \n"+
"				<methodnm idx=\"4\" total=\"8\"><![CDATA[ASTM D86-15]]></methodnm>                                                              \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"5\" total=\"8\"><![CDATA[증류성상]]></itemname1>                                                               \n"+
"				<itemname2><![CDATA[90 % 유출온도]]></itemname2>                                                                                \n"+
"				<displayunit><![CDATA[℃]]></displayunit>                                                                                       \n"+
"				<resultvalue><![CDATA[290.5]]></resultvalue>                                                                                    \n"+
"				<methodnm idx=\"5\" total=\"8\"><![CDATA[ASTM D86-15]]></methodnm>                                                              \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"6\" total=\"8\"><![CDATA[증류성상]]></itemname1>                                                               \n"+
"				<itemname2><![CDATA[종말점(FBP)]]></itemname2>                                                                                  \n"+
"				<displayunit><![CDATA[℃]]></displayunit>                                                                                       \n"+
"				<resultvalue><![CDATA[295.6]]></resultvalue>                                                                                    \n"+
"				<methodnm idx=\"6\" total=\"8\"><![CDATA[ASTM D86-15]]></methodnm>                                                              \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"7\" total=\"8\"><![CDATA[증류성상]]></itemname1>                                                               \n"+
"				<itemname2><![CDATA[잔류량]]></itemname2>                                                                                       \n"+
"				<displayunit><![CDATA[(v/v) %]]></displayunit>                                                                                  \n"+
"				<resultvalue><![CDATA[1.1]]></resultvalue>                                                                                      \n"+
"				<methodnm idx=\"7\" total=\"8\"><![CDATA[ASTM D86-15]]></methodnm>                                                              \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"8\" total=\"8\"><![CDATA[증류성상]]></itemname1>                                                               \n"+
"				<itemname2><![CDATA[손실량]]></itemname2>                                                                                       \n"+
"				<displayunit><![CDATA[(v/v) %]]></displayunit>                                                                                  \n"+
"				<resultvalue><![CDATA[1.2]]></resultvalue>                                                                                      \n"+
"				<methodnm idx=\"8\" total=\"8\"><![CDATA[ASTM D86-15]]></methodnm>                                                              \n"+
"			</row>		                                                                                                                        \n"+
"			<row lvl=\"1\">                                                                                                                     \n"+
"				<itemname1><![CDATA[검함량(수증기분사법, 현존검)]]></itemname1>                                                                 \n"+
"				<displayunit><![CDATA[㎎/100 mL]]></displayunit>                                                                                \n"+
"				<resultvalue><![CDATA[6]]></resultvalue>                                                                                        \n"+
"				<methodnm><![CDATA[ASTM D381-12]]></methodnm>                                                                                   \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"1\">                                                                                                                     \n"+
"				<itemname1><![CDATA[빙점)]]></itemname1>                                                                                        \n"+
"				<displayunit><![CDATA[℃]]></displayunit>                                                                                       \n"+
"				<resultvalue><![CDATA[-50.0]]></resultvalue>                                                                                    \n"+
"				<methodnm><![CDATA[ASTM D7153-15]]></methodnm>                                                                                  \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"1\">                                                                                                                     \n"+
"				<itemname1><![CDATA[동판부식(100 ℃, 2 h))]]></itemname1>                                                                       \n"+
"				<displayunit><![CDATA[-]]></displayunit>                                                                                        \n"+
"				<resultvalue><![CDATA[1]]></resultvalue>                                                                                        \n"+
"				<methodnm><![CDATA[ASTM D130-12]]></methodnm>                                                                                   \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"3\">                                                                                                                     \n"+
"				<itemname1 idx=\"1\" total=\"2\"><![CDATA[부식성 (55 ℃, 7일)]]></itemname1>                                                    \n"+
"				<itemname2 idx=\"1\" total=\"2\"><![CDATA[알루미늄]]></itemname2>                                                               \n"+
"				<itemname3><![CDATA[무게변화]]></itemname3>                                                                                     \n"+
"				<displayunit><![CDATA[㎎/㎠]]></displayunit>                                                                                    \n"+
"				<resultvalue><![CDATA[+0.01]]></resultvalue>                                                                                    \n"+
"				<methodnm idx=\"1\" total=\"2\"><![CDATA[KS M 2109:2014]]></methodnm>                                                           \n"+
"			</row>	                                                                                                                            \n"+
"			<row lvl=\"3\">                                                                                                                     \n"+
"				<itemname1 idx=\"2\" total=\"2\"><![CDATA[부식성 (55 ℃, 7일)]]></itemname1>                                                    \n"+
"				<itemname2 idx=\"2\" total=\"2\"><![CDATA[알루미늄]]></itemname2>                                                               \n"+
"				<itemname3><![CDATA[겉모양]]></itemname3>                                                                                       \n"+
"				<displayunit><![CDATA[㎎/㎠]]></displayunit>                                                                                    \n"+
"				<resultvalue><![CDATA[표면거칠음, 오염 및 변색없음]]></resultvalue>                                                             \n"+
"				<methodnm idx=\"2\" total=\"2\"><![CDATA[KS M 2109:2014]]></methodnm>                                                           \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"1\" total=\"2\"><![CDATA[열산화안정도 (JFTOT) 260 ℃]]></itemname1>                                            \n"+
"				<itemname2><![CDATA[표준압력강화]]></itemname2>                                                                                 \n"+
"				<displayunit><![CDATA[㎜Hg]]></displayunit>                                                                                     \n"+
"				<resultvalue><![CDATA[18.2]]></resultvalue>                                                                                     \n"+
"				<methodnm idx=\"1\" total=\"2\"><![CDATA[ASTM D3241-15e2]]></methodnm>                                                          \n"+
"			</row>	                                                                                                                            \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"2\" total=\"2\"><![CDATA[증류성상]]></itemname1>                                                               \n"+
"				<itemname2><![CDATA[표준색코드번호]]></itemname2>                                                                               \n"+
"				<displayunit><![CDATA[-]]></displayunit>                                                                                        \n"+
"				<resultvalue><![CDATA[2]]></resultvalue>                                                                                        \n"+
"				<methodnm idx=\"2\" total=\"2\"><![CDATA[ASTM D3241-15e2]]></methodnm>                                                          \n"+
"			</row>	                                                                                                                            \n"+
"		</rows>                                                                                                                                 \n"+
"		<rows smpnm=\"전기절연유\">	                                                                                                            \n"+
"			<row lvl=\"1\">                                                                                                                     \n"+
"				<itemname1><![CDATA[도막제거성(세척기를 사용하지   않는 방법, 습윤 168 h 후)]]></itemname1>                                     \n"+
"				<displayunit><![CDATA[-]]></displayunit>                                                                                        \n"+
"				<resultvalue><![CDATA[막이제거되어 있음]]></resultvalue>                                                                        \n"+
"				<methodnm><![CDATA[KS M 2109:2014]]></methodnm>                                                                                \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"3\">                                                                                                                     \n"+
"				<itemname1 idx=\"1\" total=\"2\"><![CDATA[부식성 (55 ℃, 7일)]]></itemname1>                                                    \n"+
"				<itemname2 idx=\"1\" total=\"2\"><![CDATA[알루미늄]]></itemname2>                                                               \n"+
"				<itemname3><![CDATA[무게변화]]></itemname3>                                                                                     \n"+
"				<displayunit><![CDATA[㎎/㎠]]></displayunit>                                                                                    \n"+
"				<resultvalue><![CDATA[+0.01]]></resultvalue>                                                                                    \n"+
"				<methodnm idx=\"1\" total=\"2\"><![CDATA[KS M 2109:2014]]></methodnm>                                                           \n"+
"			</row>	                                                                                                                            \n"+
"			<row lvl=\"3\">                                                                                                                     \n"+
"				<itemname1 idx=\"2\" total=\"2\"><![CDATA[부식성 (55 ℃, 7일)]]></itemname1>                                                    \n"+
"				<itemname2 idx=\"2\" total=\"2\"><![CDATA[알루미늄]]></itemname2>                                                               \n"+
"				<itemname3><![CDATA[겉모양]]></itemname3>                                                                                       \n"+
"				<displayunit><![CDATA[㎎/㎠]]></displayunit>                                                                                    \n"+
"				<resultvalue><![CDATA[표면거칠음, 오염 및 변색없음]]></resultvalue>                                                             \n"+
"				<methodnm idx=\"2\" total=\"2\"><![CDATA[KS M 2109:2014]]></methodnm>                                                           \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"1\" total=\"9\"><![CDATA[용존가스분석 (Method C)]]></itemname1>                                                \n"+
"				<itemname2><![CDATA[C2H2]]></itemname2>                                                                                         \n"+
"				<displayunit><![CDATA[ppm(㎎/㎏)]]></displayunit>                                                                               \n"+
"				<resultvalue><![CDATA[20]]></resultvalue>                                                                                       \n"+
"				<methodnm idx=\"1\" total=\"9\"><![CDATA[STM D612-02(2009)]]></methodnm>                                                      \n"+
"			</row>	                                                                                                                            \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"2\" total=\"9\"><![CDATA[용존가스분석 (Method C)]]></itemname1>                                                \n"+
"				<itemname2><![CDATA[C2H4]]></itemname2>                                                                                         \n"+
"				<displayunit><![CDATA[ppm(㎎/㎏)]]></displayunit>                                                                               \n"+
"				<resultvalue><![CDATA[1]]></resultvalue>                                                                                        \n"+
"				<methodnm idx=\"2\" total=\"9\"><![CDATA[STM D612-02(2009)]]></methodnm>                                                      \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"3\" total=\"9\"><![CDATA[용존가스분석 (Method C)]]></itemname1>                                                \n"+
"				<itemname2><![CDATA[C2H6]]></itemname2>                                                                                         \n"+
"				<displayunit><![CDATA[ppm(㎎/㎏)]]></displayunit>                                                                               \n"+
"				<resultvalue><![CDATA[5]]></resultvalue>                                                                                        \n"+
"				<methodnm idx=\"3\" total=\"9\"><![CDATA[STM D612-02(2009)]]></methodnm>                                                      \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"4\" total=\"9\"><![CDATA[용존가스분석 (Method C)]]></itemname1>                                                \n"+
"				<itemname2><![CDATA[CH4]]></itemname2>                                                                                          \n"+
"				<displayunit><![CDATA[ppm(㎎/㎏)]]></displayunit>                                                                               \n"+
"				<resultvalue><![CDATA[86]]></resultvalue>                                                                                       \n"+
"				<methodnm idx=\"4\" total=\"9\"><![CDATA[STM D612-02(2009)]]></methodnm>                                                      \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"5\" total=\"9\"><![CDATA[용존가스분석 (Method C)]]></itemname1>                                                \n"+
"				<itemname2><![CDATA[CO]]></itemname2>                                                                                           \n"+
"				<displayunit><![CDATA[ppm(㎎/㎏)]]></displayunit>                                                                               \n"+
"				<resultvalue><![CDATA[500]]></resultvalue>                                                                                      \n"+
"				<methodnm idx=\"5\" total=\"9\"><![CDATA[STM D612-02(2009)]]></methodnm>                                                      \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"6\" total=\"9\"><![CDATA[용존가스분석 (Method C)]]></itemname1>                                                \n"+
"				<itemname2><![CDATA[CO2]]></itemname2>                                                                                          \n"+
"				<displayunit><![CDATA[ppm(㎎/㎏)]]></displayunit>                                                                               \n"+
"				<resultvalue><![CDATA[200]]></resultvalue>                                                                                      \n"+
"				<methodnm idx=\"6\" total=\"9\"><![CDATA[STM D612-02(2009)]]></methodnm>                                                      \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"7\" total=\"9\"><![CDATA[용존가스분석 (Method C)]]></itemname1>                                                \n"+
"				<itemname2><![CDATA[H2]]></itemname2>                                                                                           \n"+
"				<displayunit><![CDATA[ppm(㎎/㎏)]]></displayunit>                                                                               \n"+
"				<resultvalue><![CDATA[불검출 주)]]></resultvalue>                                                                               \n"+
"				<methodnm idx=\"7\" total=\"9\"><![CDATA[STM D612-02(2009)]]></methodnm>                                                      \n"+
"				<commend><![CDATA[주)상기시험 결과는 검출되지 않음.]]></commend>                                                                \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"8\" total=\"9\"><![CDATA[용존가스분석 (Method C)]]></itemname1>                                                \n"+
"				<itemname2><![CDATA[N2]]></itemname2>                                                                                           \n"+
"				<displayunit><![CDATA[ppm(㎎/㎏)]]></displayunit>                                                                               \n"+
"				<resultvalue><![CDATA[800]]></resultvalue>                                                                                      \n"+
"				<methodnm idx=\"8\" total=\"9\"><![CDATA[STM D612-02(2009)]]></methodnm>                                                      \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"2\">                                                                                                                     \n"+
"				<itemname1 idx=\"9\" total=\"9\"><![CDATA[용존가스분석 (Method C)]]></itemname1>                                                \n"+
"				<itemname2><![CDATA[O2]]></itemname2>                                                                                           \n"+
"				<displayunit><![CDATA[ppm(㎎/㎏)]]></displayunit>                                                                               \n"+
"				<resultvalue><![CDATA[100]]></resultvalue>                                                                                      \n"+
"				<methodnm idx=\"9\" total=\"9\"><![CDATA[STM D612-02(2009)]]></methodnm>                                                      \n"+
"			</row>			                                                                                                                    \n"+
"		</rows>                                                                                                                                 \n"+
"		<rows smpnm=\"JP-8-333\">	                                                                                                            \n"+
"			<row lvl=\"1\">                                                                                                                     \n"+
"				<itemname1><![CDATA[밀도31]]></itemname1>                                                                                       \n"+
"				<displayunit><![CDATA[kg/㎥]]></displayunit>                                                                                    \n"+
"				<resultvalue><![CDATA[775.5]]></resultvalue>                                                                                    \n"+
"				<methodnm><![CDATA[ASTM D4052-11]]></methodnm>                                                                                  \n"+
"				<commend><![CDATA[주석내용31]]></commend>                                                                                       \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"1\">                                                                                                                     \n"+
"				<itemname1><![CDATA[밀도32]]></itemname1>                                                                                       \n"+
"				<displayunit><![CDATA[kg/㎥]]></displayunit>                                                                                    \n"+
"				<resultvalue><![CDATA[775.5]]></resultvalue>                                                                                    \n"+
"				<methodnm><![CDATA[ASTM D4052-11]]></methodnm>                                                                                  \n"+
"				<commend><![CDATA[주석내용2]]></commend>                                                                                        \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"1\">                                                                                                                     \n"+
"				<itemname1><![CDATA[밀도33]]></itemname1>                                                                                       \n"+
"				<displayunit><![CDATA[kg/㎥]]></displayunit>                                                                                    \n"+
"				<resultvalue><![CDATA[775.5]]></resultvalue>                                                                                    \n"+
"				<methodnm><![CDATA[ASTM D4052-11]]></methodnm>                                                                                  \n"+
"				<commend><![CDATA[주석내용3]]></commend>                                                                                        \n"+
"			</row>                                                                                                                              \n"+
"			<row lvl=\"1\">                                                                                                                     \n"+
"				<itemname1><![CDATA[밀도34]]></itemname1>                                                                                       \n"+
"				<displayunit><![CDATA[kg/㎥]]></displayunit>                                                                                    \n"+
"				<resultvalue><![CDATA[775.5]]></resultvalue>                                                                                    \n"+
"				<methodnm><![CDATA[ASTM D4052-11]]></methodnm>                                                                                  \n"+
"				<commend><![CDATA[주석내용4]]></commend>                                                                                        \n"+
"			</row>                                                                                                                              \n"+
"		</rows>                                                                                                                                 \n"+
"		                                                                                                                                        \n"+
"	</kpetro>                                                                                                                                   \n"+
"</root>                                                                                                                                         ";
</script>
</html>