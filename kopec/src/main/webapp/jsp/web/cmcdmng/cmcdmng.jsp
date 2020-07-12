<%@ page language    = "java"
    contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"
    import      = "java.util.*,
    			   java.text.SimpleDateFormat"
%>
<%
	String rootUrl = request.getRequestURI();
	rootUrl = rootUrl.substring(1);
	rootUrl = "../../../../"+rootUrl.substring(0, rootUrl.indexOf("/"))+"/";

	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","0");
	response.setHeader("pragma","no-cache");

	//파라메터 구하기
	String sUserId = (String) session.getAttribute("userId");
	if (sUserId == null){ %>
	<script>
		alert("다시 접속하여 주십시오");
	  	top.location.href = "<%=rootUrl%>jsp/web/loginProc.jsp";
	</script>
	<%}

	//현재년도 구하기
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");  //날자 포맷
	String now = df.format(new Date());			//현재 일자 구하기
	int iYear =Integer.parseInt(now.substring(0,4));
	int iMm =Integer.parseInt(now.substring(4,6));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
			"http://www.w3.org/TR/xhttml11/DTD/xhtml-strict.dtd">
<html>
<head>

<title>공통코드관리</title>
<link type="text/css" rel="stylesheet" href="<%=rootUrl%>css/hrdk_style.css"/>
<script src="<%=rootUrl%>js/common.js"></script>
<script src="<%=rootUrl %>bootstrap/js/libs/jquery-2.1.1.min.js"></script>
<script type="text/javascript">

//팝업창에서 선택한 부서를 json형태로 넘길때 받는 변수.
var jsonOrg;
var oldClickedRow = 'X';
var oldClickedRow1 = 'X';

//onload와 비슷한 역활을 하는 ready메소드임.(속도 수행은 더 빠르다. DOM객체별로 준비시키기 때문에)
$(document).ready(function(){
	list('000');
	//id가"#~"인 객체를 클릭할 경우 함수 실행
	$("#btAddCode0").click(function(){form0.reset();});
	$("#btEditCode0").click(function(){saveCode('0');});
	$("#btDelCode0").click(function(){delCode('0');});
	$("#btAddCode1").click(function(){form1.reset();});
	$("#btEditCode1").click(function(){saveCode('1');});
	$("#btDelCode1").click(function(){delCode('1');});
});

//대분류코드 조회
function list(ldiv_cd){
	//타겟페이지, 파라메터, 성공시콜백함수. ajaxPost_rdr처럼 파라메터가 있는 함수를 호출할때는 function(data){}로 감싸야 한다.
	$.post("cmcdmng_X.jsp", { actGubn:"list", ldiv_cd:ldiv_cd, type: "post" }, function(data){list_rdr(data, ldiv_cd) });
}

//평가군 조회한 후 리턴 텍스트를 받아서  테이블 추가
function list_rdr(data, ldiv_cd){
	if('000' == ldiv_cd){ //대분류 코드의 ldiv_cd는 '000'으로 고정됨.
		createTableByJsonOnClick(data, "tblDeptHeader0","res_tr0","res0","380px","200px","bg_wt","","ldivcd","sdiv_cd","clickLcd", "#dadeea", "#ffffff", "#dadeea", "oldClickedRow");
	}else{
		createTableByJsonOnClick(data, "tblDeptHeader1","res_tr1","res1","380px","200px","bg_wt","","sdivcd","sdiv_cd","clickScd", "#dadeea", "#ffffff", "#dadeea", "oldClickedRow1");
		oldClickedRow1 = 'X';
	}

}

//코드 추가
function saveCode(flag){
	var cd = $("#sdiv_cd"+flag).val();
	var nm = $("#div_nm"+flag).val();
	if(cd == ""){alert("코드를 입력하십시오."); $("#sdiv_cd"+flag).focus(); return;}
	if(nm == ""){alert("코드명을 입력하십시오."); $("#div_nm"+flag).focus();  return;}
	if(!numcheck($("#sort_seq"+flag).val())){alert('순서는 숫자만 입력하셔야 합니다.'); $("#sort_seq"+flag).val(''); $("#sort_seq"+flag).focus(); return;};
	var mng1 = $("#mng1"+flag).val();
	if($("#ldiv_cd"+flag).val() == "S01"){
		mng1 = $("#sel_mng1"+flag).val();
	}

	//코드 체크
	var NumEng = /^[A-Za-z0-9]+$/;
	if(!NumEng.test(cd)){
		alert("코드는 숫자와 영문자로만 입력하세요.");
		$("#sdiv_cd"+flag).focus();
	}
	cd = cd.toUpperCase();

	$.post("cmcdmng_X.jsp", { actGubn:"save", type: "post",  ldiv_cd: $("#ldiv_cd"+flag).val(), sdiv_cd: $("#sdiv_cd"+flag).val(), div_nm: $("#div_nm"+flag).val(),
							div_short_mn: $("#div_short_mn"+flag).val(), mng1: mng1, mng2: $("#mng2"+flag).val(), mng3: $("#mng3"+flag).val(),
							use_yn: $("#use_yn"+flag).val(), sort_seq: $("#sort_seq"+flag).val()}
	, function(data){saveCode_rdr(data, flag)}, "json");

}

function saveCode_rdr(data, flag){
	alert(data.msg);
	if(flag == 0){
		form1.reset();
		//기존의 테이블로우가 있다면 삭제한다.
		$("#res_rt1 tr").each(function (ai) {
			var row = $("#"+this.id);
			row.remove();
		});
		list('000');
		if(data.msg == '성공적으로 삭제되었습니다.'){form0.reset();}
	}else{
		list($('#ldiv_cd1').val());
		if(data.msg == '성공적으로 삭제되었습니다.'){form1.reset();}
	}
}

//코드 삭제
function delCode(flag){
	var cd = $("#sdiv_cd"+flag).val();
	if(cd == ""){alert('삭제할 코드를 선택하셔야 합니다.'); return;};
	if(!confirm($("#div_nm"+flag).val()+'를 삭제하시겠습니까?')){return;}
	$.post("cmcdmng_X.jsp", { actGubn:"del", type: "post",  ldiv_cd: $("#ldiv_cd"+flag).val(), sdiv_cd: $("#sdiv_cd"+flag).val()}
	, function(data){saveCode_rdr(data, flag)}, "json");
}

//대분류 코드  클릭시
function clickLcd(cd){
	var flag = '0'
	cd = cd.replace('ldivcd','');
	$("#ldiv_cd"+flag).val("000");
	$("#sdiv_cd"+flag).val(cd);
	$("#ldiv_cd1").val(cd); //하위메뉴의 상위코드를 부여!
	$.post("cmcdmng_X.jsp", { actGubn:"list", type: "post",  ldiv_cd: $("#ldiv_cd"+flag).val(), sdiv_cd: $("#sdiv_cd"+flag).val()}
	, function(data){clickLcd_rdr(data, cd)}, "json");
}

function clickLcd_rdr(data, cd){
	form0.reset();
	form1.reset();
	$("#ldiv_cd1").val(cd); //하위메뉴의 상위코드를 부여!

	if(cd == "S01"){
		$("#sel_mng11").css("display","block");
		$("#mng11").css("display","none");
	}else{
		$("#sel_mng11").css("display","none");
		$("#mng11").css("display","block");
	}

	$("#res_rt1 tr").each(function (ai) {
		var row = $("#"+this.id);
		row.remove();
	});

	if(data == null || data.rs.length < 1){alert('조회결과가 없습니다.'); return; }

	var flag = 0;
	$("#ldiv_cd"+flag).val(data.rs[0].ldiv_cd);
	$("#sdiv_cd"+flag).val(data.rs[0].sdiv_cd);
	$("#div_nm"+flag).val(data.rs[0].div_nm);
	$("#div_short_mn"+flag).val(data.rs[0].div_snm);
	$("#mng1"+flag).val(data.rs[0].mng1);
	$("#mng2"+flag).val(data.rs[0].mng2);
	$("#sort_seq"+flag).val(data.rs[0].ord);
	$("#use_yn"+flag).val(data.rs[0].use_yn);

	list(data.rs[0].sdiv_cd);
}

//소분류 코드  클릭시
function clickScd(cd){
	var ldivcd = $("#sdiv_cd0").val();
	cd = cd.replace('sdivcd','');
	$.post("cmcdmng_X.jsp", { actGubn:"list", type: "post",  ldiv_cd: ldivcd, sdiv_cd: cd}
	, function(data){clickScd_rdr(data)}, "json");
}

function clickScd_rdr(data){
	form1.reset();

	if(data == null || data.rs.length < 1){alert('조회결과가 없습니다.'); return; }

	var flag = 1;
	$("#ldiv_cd"+flag).val(data.rs[0].ldiv_cd);
	$("#sdiv_cd"+flag).val(data.rs[0].sdiv_cd);
	$("#div_nm"+flag).val(data.rs[0].div_nm);
	$("#div_short_mn"+flag).val(data.rs[0].div_snm);
	if(data.rs[0].ldiv_cd == "S01"){
		$("#sel_mng1"+flag).val(data.rs[0].mng1);
	}else{
		$("#mng1"+flag).val(data.rs[0].mng1);
	}
	$("#mng2"+flag).val(data.rs[0].mng2);
	$("#mng2"+flag).val(data.rs[0].mng2);
	$("#sort_seq"+flag).val(data.rs[0].ord);

	$("#use_yn"+flag).val(data.rs[0].use_yn);

}


</script>
</head>

<body>
<!-- 본문 영역 시작 -->
<table style="width:100%;" cellpadding="0" cellspacing="2" border="0">
	<tr>
		<td style="width:100%;" valign="top">
			<!-- 좌측 프레임 상단 박스 시작 -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #c1c1c1;">

	            <tr>
	              <td>&nbsp;</td>
	              <td valign="top" bgcolor="ffffff" style="padding:5">
	        <!-- 좌측 프레임 상단 박스 끝 -->
					<!-- 좌측 상세 화면 -->
					<table width="100%" border="0" cellpadding="0" cellspacing="10">
						<tr>
							<td colspan="2">
								<img src="<%=rootUrl %>images/icon/blit01.gif" height="15" width="15" align="absmiddle">
								<span class="f02">대분류코드</span>
							</td>
						</tr>
						<tr>
							<td width="400px" valign="top">
								<table   border="0" cellpadding="0" cellspacing="1" class="bg_gray01" style="width:380px;TABLE-layout:fixed">
									<thead id="tblDeptHeader0">
								        <tr  align="center">
								          <th class="tbg01" width="40" dataField="sdiv_cd" textAlign="center">코드</th>
								          <th class="tbg01" width="250" dataField="div_nm" textAlign="left">코드명</th>
								          <th class="tbg01" width="90" dataField="use_yn" textAlign="center">사용여부</th>
								        </tr>
							        </thead>
								</table>
								<div id="res0" style="width:380px;height:200px;overflow: scroll;overflow-x: hidden;overflow-y: scroll">
								<table border="0" cellspacing="1" cellpadding="0" class="bg_gray01" style="width:363px;table-layout:fixed">
									<tbody id="res_tr0">
									</tbody>
								</table>
								</div>
							</td>
							<td width="100%" valign="top">
								<form name = 'form0'>
								<table width="100%" border="0" cellspacing="1" cellpadding="0">
									<tr height="2">
										<td class="tbg02" width="20%"></td>
										<td class="tbg02" width="15%"></td>
										<td class="tbg02" width="20%"></td>
										<td class="tbg02" width="45%"></td>
									</tr>
									<tr height="30">
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">코드</td>
										<td><input type="text" name="sdiv_cd0" id="sdiv_cd0"  value="" class="TFStyle03" maxlength="3" style="width:30px"/></td>
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">코드명</td>
										<td><input type="text" name="div_nm0" id="div_nm0"  value="" class="TFStyle03" maxlength="100" style="width:95%;"/></td>
									</tr>
									<tr>
										<td colspan="4" class="dot01"></td>
									</tr>
									<tr height="30">
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">조회순서</td>
										<td><input type="text" name="sort_seq0" id="sort_seq0"  value="" class="TFStyle03" maxlength="3" style="width:30px;"/></td>
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">약명</td>
										<td><input type="text" name="div_short_mn0" id="div_short_mn0"  value="" class="TFStyle03" maxlength="20" style="width:95%;"/></td>
									</tr>
									<tr>
										<td colspan="4" class="dot01"></td>
									</tr>
									<tr height="30">
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">사용여부</td>
										<td colspan="3"><select name="use_yn0" id="use_yn0">
															<option value = '' >::선택::</option><option value = 'Y' >사용함</option><option value = 'N'>사용안함</option>
														</select>
										</td>
									</tr>
									<tr>
										<td colspan="4" class="dot01"></td>
									</tr>
									<tr height="30">
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">관리항목1</td>
										<td colspan="3"><input type="text" name="mng10" id="mng10"  value="" class="TFStyle03" maxlength="5" style="width:95%;"/></td>
									</tr>
									<tr>
										<td colspan="4" class="dot01"></td>
									</tr>
									<tr height="30">
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">관리항목2</td>
										<td colspan="3"><input type="text" name="mng20" id="mng20"  value="" class="TFStyle03" maxlength="5" style="width:95%;"/></td>
									</tr>
									<tr>
										<td colspan="4" class="dot01"></td>
									</tr>
									<tr height="2">
										<td class="tbg02" ></td>
										<td class="tbg02" ></td>
										<td class="tbg02" ></td>
										<td class="tbg02" ></td>
									</tr>
									<tr height="25">
										<td style="text-align: right; border: 0px" colspan="4">
											<img src="<%=rootUrl %>images/btn/btnInit.gif" id="btAddCode0" alt="항목초기화" style="cursor:pointer;"/>&nbsp;
											<img src="<%=rootUrl %>images/btn/btnSave.gif" id="btEditCode0" alt="항목저장" style="cursor:pointer;"/>&nbsp;
											<img src="<%=rootUrl %>images/btn/btnDelete.gif" id="btDelCode0" alt="항목삭제" style="cursor:pointer;"/>&nbsp;
										</td>
									</tr>
								</table>
								<input type="hidden" name="ldiv_cd0" id="ldiv_cd0" value="000" />
								<input type="hidden" name="who" id="who" value="<%=sUserId %>" />
								</form>
							</td>
						</tr>
					</table>
					<!-- //좌측 상세 화면 -->
			<!-- 좌측 프레임 하단 박스 시작 -->
				</td>
			    <td >&nbsp;</td>
			  </tr>
			</table>
			<!-- 좌측 프레임 하단 박스 끝 -->
		</td>
	</tr>
	<tr>
		<td style="width:100%;" valign="top">
			<!-- 우측 프레임 상단 박스 시작 -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #c1c1c1;">
	            <tr>
	              <td>&nbsp;</td>
	              <td valign="top" bgcolor="ffffff" style="padding:5">
	         <!-- 우측 프레임 상단 박스 끝 -->
					<!-- 우측 상세 화면 -->
					<table width="100%" border="0" cellpadding="0" cellspacing="10">
						<tr>
							<td colspan="2">
								<img src="<%=rootUrl %>images/icon/blit01.gif" height="15" width="15" align="absmiddle">
								<span class="f02">소분류코드</span>
							</td>
						</tr>
						<tr>
							<td width="400px" valign="top">
								<table   border="0" cellpadding="0" cellspacing="1" class="bg_gray01" style="width:380px;TABLE-layout:fixed">
									<thead id="tblDeptHeader1">
								        <tr  align="center">
								          <th class="tbg01" width="40" dataField="sdiv_cd" textAlign="center">코드</th>
								          <th class="tbg01" width="250" dataField="div_nm" textAlign="left">코드명</th>
								          <th class="tbg01" width="90" dataField="use_yn" textAlign="center">사용여부</th>
								        </tr>
							        </thead>
								</table>
								<div id="res1" style="width:380px;height:200px;overflow: scroll;overflow-x: hidden;overflow-y: scroll">
								<table border="0" cellspacing="1" cellpadding="0" class="bg_gray01" style="width:363px;table-layout:fixed">
									<tbody id="res_tr1">
									</tbody>
								</table>
								</div>
							</td>
							<td width="100%" valign="top">
								<form name = 'form1'>
								<table width="100%" border="0" cellspacing="1" cellpadding="0">
									<tr height="2">
										<td class="tbg02" width="20%"></td>
										<td class="tbg02" width="15%"></td>
										<td class="tbg02" width="20%"></td>
										<td class="tbg02" width="45%"></td>
									</tr>
									<tr height="30">
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">코드</td>
										<td><input type="text" name="sdiv_cd1" id="sdiv_cd1"  value="" class="TFStyle03" maxlength="5" style="width:30px;ime-mode:disabled"/></td>
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">코드명</td>
										<td><input type="text" name="div_nm1" id="div_nm1"  value="" class="TFStyle03" maxlength="100" style="width:95%;"/></td>
									</tr>
									<tr>
										<td colspan="4" class="dot01"></td>
									</tr>
									<tr height="30">
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">조회순서</td>
										<td><input type="text" name="sort_seq1" id="sort_seq1"  value="" class="TFStyle03" maxlength="3" style="width:30px;"/></td>
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">약명</td>
										<td><input type="text" name="div_short_mn1" id="div_short_mn1"  value="" class="TFStyle03" maxlength="20" style="width:95%;"/></td>
									</tr>
									<tr>
										<td colspan="4" class="dot01"></td>
									</tr>
									<tr height="30">
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">사용여부</td>
										<td colspan="3"><select name="use_yn1" id="use_yn1">
															<option value = '' >::선택::</option><option value = 'Y' >사용함</option><option value = 'N'>사용안함</option>
														</select>
										</td>
									</tr>
									<tr>
										<td colspan="4" class="dot01"></td>
									</tr>
									<tr height="30">
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">관리항목1</td>
										<td colspan="3">
											<input type="text" name="mng11" id="mng11"  value="" class="TFStyle03" maxlength="3" style="width:95%;"/>
										</td>
									</tr>
									<tr>
										<td colspan="4" class="dot01"></td>
									</tr>
									<tr height="30">
										<td class="ta_td06"><img src="<%=rootUrl %>images/icon/blit02.gif" width="11" height="11" align="absmiddle">관리항목2</td>
										<td colspan="3"><input type="text" name="mng21" id="mng21"  value="" class="TFStyle03" maxlength="3" style="width:95%;"/></td>
									</tr>
									<tr>
										<td colspan="4" class="dot01"></td>
									</tr>
									<tr height="2">
										<td class="tbg02" ></td>
										<td class="tbg02" ></td>
										<td class="tbg02" ></td>
										<td class="tbg02" ></td>
									</tr>
									<tr height="25">
										<td style="text-align: right; border: 0px" colspan="4">
											<img src="<%=rootUrl %>images/btn/btnInit.gif" id="btAddCode1" alt="항목초기화" style="cursor:hand;"/>&nbsp;
											<img src="<%=rootUrl %>images/btn/btnSave.gif" id="btEditCode1" alt="항목저장" style="cursor:hand;"/>&nbsp;
											<img src="<%=rootUrl %>images/btn/btnDelete.gif" id="btDelCode1" alt="항목삭제" style="cursor:hand;"/>&nbsp;
										</td>
									</tr>
								</table>
								<input type="hidden" name="ldiv_cd1" id="ldiv_cd1" value="" />
								</form>
							</td>
						</tr>
					</table>

					<!-- //우측 상세 화면 -->
				<!-- 우측 프레임 하단 박스 시작 -->
			   </td>
			    <td >&nbsp;</td>
			  </tr>
			</table>
			<!-- 우측 프레임 하단 박스 끝-->
		</td>
	</tr>
</table>
<!-- 본문 영역 끝 -->
</body>
</html>