// JavaScript Document

<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->

// UTF-8로 변환 함수
function toUTF8(szInput){
	var wch,x,uch="",szRet="";
	for (x=0; x<szInput.length; x++){
		wch=szInput.charCodeAt(x);
		if (!(wch & 0xFF80)) {
			//szRet += "%" + wch.toString(16);
			szRet += szInput.charAt(x);
		}else if (!(wch & 0xF000)) {
			uch = "%" + (wch>>6 | 0xC0).toString(16) + "%" + (wch & 0x3F | 0x80).toString(16);
			szRet += uch.toUpperCase();
		}else {
			uch = "%" + (wch >> 12 | 0xE0).toString(16) + "%" + (((wch >> 6) & 0x3F) | 0x80).toString(16) + "%" + (wch & 0x3F | 0x80).toString(16);
			szRet += uch.toUpperCase();
		}
	}
	return(szRet); 
}

//숫자 체크
function numcheck(check_num) {
	var inText = check_num;
	var ret;
	for (var i=0; i<inText.length; i++) {
		 ret = inText.charCodeAt(i);
		 if ((ret<48) || (ret>57)) {
			 return false
		  } // if 문
	 }
	 return true;
}

//숫자 체크, .,-는 한번씩 허용
function numcheck_pm(check_num) {
	var inText = check_num;
	var ret;
	var minus = 0;
	var point = 0;
	for (var i=0; i<inText.length; i++) {
		 ret = inText.charCodeAt(i);
		 if(ret == 45){
		 	minus++;
		 	if(minus > 1){
		 		alert('- 기호는 하나만 허용합니다.');
		 		return false;
		 	}
		 }else if(ret == 46){
		 	point++;
		 	if(point > 1){
		 		alert('. 기호는 하나만 허용합니다.');
		 		return false;
		 	}
		 }else if ((ret<48) || (ret>57)) {
			 return false;
		  } // if 문
	 } 
	 return true;
}

//팝업창 화면 가운데에 띄우기.
function f_opencenter(sURL, sName, sStyle, nWidth, nHeight){
    var nLeft = (screen.width - nWidth)/2;
    var nTop = (screen.height - nHeight)/2 -40;
    myStyle = sStyle 
              + ", width=" + nWidth  + ",height=" + nHeight 
              + ",top=" + nTop       + ",left=" + nLeft;

  	w = window.open(sURL,sName, myStyle);
  	w.focus();  	
}

//객체의 id를 넘겨준 후 해당 객체의 value가 널인지 아닌지 체
function isNullById(id){
	if($("#"+id).val() != ""){
		return false;
	}else{
		return true;
	}
}

//문자 앞 뒤의 널문자들을 없애는 함수
function trim(str){
	return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
}

//해당 객체의 height을 screen.height - subHeight로 설정한다.
function setHeightSubScreen(id, subHeight){
	var newHeight = screen.height - subHeight;
	$("#"+id).css("height", newHeight+"px");
}

//현재년도 가져오기
function fc_getYear(){
	//현재 년도 구하기
	var date = new Date();
	//date.getTime()는 1970년 1월 1일 이후의 시간을 밀리세컨드로 나눈 값이므로 년횟수를 구하고 1970을 더한다.
    var year = parseInt(date.getTime()/1000/60/60/24/365)+1970; 
    return year;
}
// --------------------------------------------------------- //
//  mouse over script !! used in GM
// --------------------------------------------------------- //
var oncell = "key";
var cell_color = "#ffffff";
var cell_color0 = "#E5F2FF";


function chgColor(celno)
{
	 var chgcell;
	 var index;
	 
	 if(oncell != "key")
	 {
	     document.getElementById(oncell+"r2").bgColor='#ffffFF';  
	 }
	 
	 oncell = celno; 
     chgcell1 = "document.getElementById('"+ celno + "r2').bgColor='" + cell_color0 + "'";
	 eval(chgcell1);
}

// --------------------------------------------------------- //
//  mouse over script !! used in GM
// --------------------------------------------------------- //
var oncell = "key";
var cell_color = "#ffffff";
var cell_color0 = "#E5F2FF";


function chgColor(celno)
{
	 var chgcell;
	 var index;
	 
	 if(oncell != "key")
	 {
	     document.getElementById(oncell+"r2").bgColor='#ffffFF';  
	 }
	 
	 oncell = celno; 
     chgcell1 = "document.getElementById('"+ celno + "r2').bgColor='" + cell_color0 + "'";
	 eval(chgcell1);
}



function chgColor2(celno)
{
	 var chgcell;
	 var index;
	 
	 if(oncell != "key")
	 {
	     document.getElementById(oncell+"r2").bgColor='#ffffFF';  
	     document.getElementById(oncell+"r1").bgColor='#ffffFF';  
	     
	 }
	 
	 oncell = celno; 
     chgcell1 = "document.getElementById('"+ celno + "r2').bgColor='" + cell_color0 + "'";
     chgcell2= "document.getElementById('"+ celno + "r1').bgColor='" + cell_color0 + "'";     
	 eval(chgcell1);
	 eval(chgcell2);
}

/*******************************************************************************************************************************************************
/** 여기서 부터는 조회조건에 사용되는 콤보박스를 만드는 부분이다.
/**
/**예시
	//자바스크립트
	$(document).ready(function(){  
		selectYear('selectYear');
		selectMonth('selectMonth');
		selectEval('selectEval', true, '<%=rootUrl%>');
		selectGrp('selectGrp', true, '<%=rootUrl%>', currYear, "eval_tp2", "0");
		selectDept3SB('selectDept', 1, 1, 3, false,'<%=rootUrl%>', $('#selectYear').val(), 'bid');
		var currYear = $('#selectYear').val();
		selectMeas('selectMeas', false, '<%=rootUrl%>', currYear, 'charge_yn', 'Y');
		selectDept('selectDept1', "selectDept1", true, '<%=rootUrl%>', '');
		$('#year').change(function(){
			$('#selectDept1').get(0).length=0;
			$('#selectDept2').get(0).length=0;
			$('#selectDept3').get(0).length=0;
			selectDept('selectDept1', "selectDept1", true, '<%=rootUrl%>', '');
		});
		$('#selectDept1').change(function(){$('#selectDept3').get(0).length=0; selectDept('selectDept1', 'selectDept2', true, '<%=rootUrl%>', '');});
		$('#selectDept2').change(function(){selectDept('selectDept2', 'selectDept3', false, '<%=rootUrl%>', '');});
		
	});
	
	//html>body 에는 배치할 위치에 아래저럼 id와 style을 정의 해준다.
	<select name="selDept3" id="selDept3" class="TFStyle03" style="width:140px">
	</select>
********************************************************************************************************************************************************/
/**
**콤보박스에 년도 옵션을 삽입하고 현재년도를 보여주게 하는 함수.
*@selectId 콤보박스의 id
*@totYn 콤보박스에 '전체' 옵션을 삽입 여부. boolean값
**/
function selectYear(selectId, totYn){
	var varTotYn;
	var varSelId;
	var oIdx;
	
	//현재 년도 구하기
	var date = new Date();
	//date.getTime()는 1970년 1월 1일 이후의 시간을 밀리세컨드로 나눈 값이므로 년횟수를 구하고 1970을 더한다.
    var year = parseInt(date.getTime()/1000/60/60/24/365)+1970; 

	//전체 옵션 삽입 여부 인수가 없을 경우 기본값인  false로 고정
	if(totYn == null || totYn == undefined){
		varTotYn = false;
	}else{
		varTotYn = totYn;
	}

	//selectId를 id로 가진 객체의 여부 판단. 없을 경우 selectYear를 id로 가진 객체의 여부 판단.
	if($("#"+selectId).get(0) == undefined){
		if($("#selectYear").get(0) == undefined){
			alert(selectId + 'is not exist!');
			return;
		}else{
			varSelId = "selectYear";
		}
	}else{
		varSelId = selectId;
	}

	//option 채우기 전에 기존의 option 삭제.
	if(varTotYn){
		if($("#"+varSelId).get(0).length == 0){
			$("#"+varSelId).get(0).options[0] = new Option("::All::","");
		}
		$("#"+varSelId).get(0).length = 1;
		oIdx = 1;
	}else{
		$("#"+varSelId).get(0).length = 0;
		oIdx = 0;
	}

	//option 채우기
	for(var i = 2009; i < (parseInt(year)+2); i++){
		$("#"+varSelId).get(0).options[oIdx] = new Option(i, i);
		oIdx++;
	}

	//default값 선택
	$("#"+varSelId).val(year);

}

/**
**콤보박스에 월 옵션을 삽입하고 현재월을 선택하게 하는 함수.
*@selectId 콤보박스의 id
*@totYn 콤보박스에 '전체' 옵션을 삽입 여부. boolean값
**/
function selectMonth(selectId, totYn){
	var varTotYn;
	var varSelId;
	var oIdx;
	
	//현재 월 구하기
	var date = new Date();
	var month = parseInt(date.getMonth())+1;
	
	//전체 옵션 삽입 여부 인수가 없을 경우 기본값인  false로 고정
	if(totYn == null || totYn == undefined){
		varTotYn = false;
	}else{
		varTotYn = totYn;
	}
	
	//selectId를 id로 가진 객체의 여부 판단. 없을 경우 selectYear를 id로 가진 객체의 여부 판단.
	if($("#"+selectId).get(0) == undefined){
		if($("#selectMonth").get(0) == undefined){
			alert(selectId + 'is not exist!');
			return;
		}else{
			varSelId = "selectMonth";
		}
	}else{
		varSelId = selectId;
	}
	
	//option 채우기 전에 기존의 option 삭제.
	if(varTotYn){
		if($("#"+varSelId).get(0).length == 0){
			$("#"+varSelId).get(0).options[0] = new Option("::All::","");
		}
		$("#"+varSelId).get(0).length = 1;
		oIdx = 1;
	}else{
		$("#"+varSelId).get(0).length = 0;
		oIdx = 0;
	}
	
	//option 채우기
	for(var i = 0; i < 12; i++){
		var iM = i+1;
		$("#"+varSelId).get(0).options[oIdx] = new Option(iM, iM<10?'0'+iM:iM);
		oIdx++;
	}

	//default값 선택
	month = parseInt(month)<10?'0'+month:month;
	$("#"+varSelId).val(month);
	
}

/**
**ajax를 이용해서 평가 콤보박스 채우는 함수.
*@selectId 	콤보박스 id
*@totYn		콤보박스에 "전체" 옵션 삽입 여부
*@url		rootUrl
*@param		파라메터
**/
function selectEval(selectId, totYn, url, eval_year){
	var varTotYn;
	var varSelId;
	var oIdx;
	
	//현재 년도 구하기
	var date = new Date();
	//date.getTime()는 1970년 1월 1일 이후의 시간을 밀리세컨드로 나눈 값이므로 년횟수를 구하고 1970을 더한다.
    var year = parseInt(date.getTime()/1000/60/60/24/365)+1970; 
	
	//전체 옵션 삽입 여부 인수가 없을 경우 기본값인  false로 고정
	if(totYn == null || totYn == undefined){
		varTotYn = false;
	}else{
		varTotYn = totYn;
	}
	
	if(url == null || url == undefined) url = "./../../";
	
	//파라메터 인수가 없을 경우 기본값인  현재년도로 고정
	if(eval_year == null || eval_year == undefined){
		eval_year = year;
	}
	
	//selectId를 id로 가진 객체의 여부 판단. 없을 경우 selectYear를 id로 가진 객체의 여부 판단.
	if($("#"+selectId).get(0) == undefined){
		if($("#selectEval").get(0) == undefined){
			alert(selectId + 'is not exist!');
			return;
		}else{
			varSelId = "selectEval";
		}
	}else{
		varSelId = selectId;
	}
	
	$.post(url+"jsp/common/common_X.jsp", { actGubn:"selectEval", eval_year : eval_year, type: "post" }, function(data){selectPost_rdr(data,varSelId, varTotYn) });
}

/**
**ajax를 이용해서 평가군 첫번째 콤보박스 채우는 함수.
*@selectId 	콤보박스 id
*@totYn		콤보박스에 "전체" 옵션 삽입 여부
*@url		rootUrl
*@eval_year	조회년도
*@colNm		조회조건에 사용되는 컬럼명. 여러개일 경우 :를 구분자로 이용.
*@colVal	조회조건에 사용되는 값. 여러개일 경우 :를 구분자로 이용.
**/
function selectGrp(selectId, totYn, url, eval_year, colNm, colVal){
	var varTotYn;
	var varSelId;
	var oIdx;
	
	//현재 년도 구하기
	var date = new Date();
	//date.getTime()는 1970년 1월 1일 이후의 시간을 밀리세컨드로 나눈 값이므로 년횟수를 구하고 1970을 더한다.
    var year = parseInt(date.getTime()/1000/60/60/24/365)+1970; 
	
	//전체 옵션 삽입 여부 인수가 없을 경우 기본값인  false로 고정
	if(totYn == null || totYn == undefined){
		varTotYn = false;
	}else{
		varTotYn = totYn;
	}
	
	if(url == null || url == undefined) url = "./../../";
	
	//파라메터 인수가 없을 경우 기본값인  현재년도로 고정
	if(eval_year == null || eval_year == undefined){
		eval_year = year;
	}
	if(colNm == null || colNm == undefined){
		colNm = "";
	}
	if(colVal == null || colVal == undefined){
		colVal = "";
	}
	
	//selectId를 id로 가진 객체의 여부 판단. 없을 경우 selectYear를 id로 가진 객체의 여부 판단.
	if($("#"+selectId).get(0) == undefined){
		if($("#selectGrp").get(0) == undefined){
			alert(selectId + 'is not exist!');
			return;
		}else{
			varSelId = "selectGrp";
		}
	}else{
		varSelId = selectId;
	}
	
	$.post(url+"jsp/common/common_X.jsp", { actGubn:"selectGrp", eval_year : eval_year, colNm : colNm, colVal : colVal, type: "post" }, function(data){selectPostTot_rdr(data,varSelId, varTotYn) });
}
/**
**ajax를 이용해서 평가군 첫번째 콤보박스 채우는 함수.
*@selectId 	콤보박스 id
*@totYn		콤보박스에 "전체" 옵션 삽입 여부
*@url		rootUrl
*@eval_year	조회년도
*@colNm		조회조건에 사용되는 컬럼명. 여러개일 경우 :를 구분자로 이용.
*@colVal	조회조건에 사용되는 값. 여러개일 경우 :를 구분자로 이용.
**/
function selectGrpDept(selectId, totYn, url, eval_year, grp_cd, colVal){
	var varTotYn;
	var varSelId;
	var oIdx;
	
	//현재 년도 구하기
	var date = new Date();
	//date.getTime()는 1970년 1월 1일 이후의 시간을 밀리세컨드로 나눈 값이므로 년횟수를 구하고 1970을 더한다.
    var year = parseInt(date.getTime()/1000/60/60/24/365)+1970; 
	
	//전체 옵션 삽입 여부 인수가 없을 경우 기본값인  false로 고정
	if(totYn == null || totYn == undefined){
		varTotYn = false;
	}else{
		varTotYn = totYn;
	}
	
	if(url == null || url == undefined) url = "./../../";
	
	//파라메터 인수가 없을 경우 기본값인  현재년도로 고정
	if(eval_year == null || eval_year == undefined){
		eval_year = year;
	}
	if(grp_cd == null || grp_cd == undefined){
		grp_cd = "";
	}
	if(colVal == null || colVal == undefined){
		colVal = "";
	}
	
	//selectId를 id로 가진 객체의 여부 판단. 없을 경우 selectYear를 id로 가진 객체의 여부 판단.
	if($("#"+selectId).get(0) == undefined){
		if($("#selectGrp").get(0) == undefined){
			alert(selectId + 'is not exist!');
			return;
		}else{
			varSelId = "selectGrp";
		}
	}else{
		varSelId = selectId;
	}
	
	$.post(url+"jsp/common/common_X.jsp", { actGubn:"selectGrpDept", eval_year : eval_year,grp_cd : grp_cd ,  colVal : colVal, type: "post" }, function(data){selectPost_rdr(data,varSelId, varTotYn) });
}

/**
**ajax를 이용해서 평가군 첫번째 콤보박스 채우는 함수.
*@selectId 	콤보박스 id
*@totYn		콤보박스에 "전체" 옵션 삽입 여부
*@url		rootUrl
*@eval_year	조회년도
*@colNm		조회조건에 사용되는 컬럼명. 여러개일 경우 :를 구분자로 이용.
*@colVal	조회조건에 사용되는 값. 여러개일 경우 :를 구분자로 이용.
**/
function selectEvalPosi(selectId, totYn, url, eval_year){
	var varTotYn;
	var varSelId;
	var oIdx;
	
	//현재 년도 구하기
	var date = new Date();
	//date.getTime()는 1970년 1월 1일 이후의 시간을 밀리세컨드로 나눈 값이므로 년횟수를 구하고 1970을 더한다.
    var year = parseInt(date.getTime()/1000/60/60/24/365)+1970; 
	
	//전체 옵션 삽입 여부 인수가 없을 경우 기본값인  false로 고정
	if(totYn == null || totYn == undefined){
		varTotYn = false;
	}else{
		varTotYn = totYn;
	}
	
	if(url == null || url == undefined) url = "./../../";
	
	//파라메터 인수가 없을 경우 기본값인  현재년도로 고정
	if(eval_year == null || eval_year == undefined){
		eval_year = year;
	}
	
	//selectId를 id로 가진 객체의 여부 판단. 없을 경우 selectYear를 id로 가진 객체의 여부 판단.
	if($("#"+selectId).get(0) == undefined){
		if($("#selectEvalPosi").get(0) == undefined){
			alert(selectId + 'is not exist!');
			return;
		}else{
			varSelId = "selectEvalPosi";
		}
	}else{
		varSelId = selectId;
	}
	
	$.post(url+"jsp/common/common_X.jsp", { actGubn:"selectEvalPosi", eval_year : eval_year, type: "post" }, function(data){selectPostTot_rdr(data,varSelId, varTotYn) });
}
function selectPosi(selectId, totYn, url){
	var varTotYn;
	var varSelId;
	var oIdx;
	
	
	//전체 옵션 삽입 여부 인수가 없을 경우 기본값인  false로 고정
	if(totYn == null || totYn == undefined){
		varTotYn = false;
	}else{
		varTotYn = totYn;
	}
	
	if(url == null || url == undefined) url = "./../../";

	
	//selectId를 id로 가진 객체의 여부 판단. 없을 경우 selectYear를 id로 가진 객체의 여부 판단.
	if($("#"+selectId).get(0) == undefined){
		if($("#selectPosi").get(0) == undefined){
			alert(selectId + 'is not exist!');
			return;
		}else{
			varSelId = "selectPosi";
		}
	}else{
		varSelId = selectId;
	}
	
	$.post(url+"jsp/common/common_X.jsp", { actGubn:"selectPosi",  type: "post" }, function(data){selectPost_rdr(data,varSelId, varTotYn) });
}
function selectEvalDept(selectId, totYn, url,eval_year){
	var varTotYn;
	var varSelId;
	var oIdx;
	
	//현재 년도 구하기
	var date = new Date();
	//date.getTime()는 1970년 1월 1일 이후의 시간을 밀리세컨드로 나눈 값이므로 년횟수를 구하고 1970을 더한다.
    var year = parseInt(date.getTime()/1000/60/60/24/365)+1970; 
	
	//전체 옵션 삽입 여부 인수가 없을 경우 기본값인  false로 고정
	if(totYn == null || totYn == undefined){
		varTotYn = false;
	}else{
		varTotYn = totYn;
	}
	
	if(url == null || url == undefined) url = "./../../";

	//파라메터 인수가 없을 경우 기본값인  현재년도로 고정
	if(eval_year == null || eval_year == undefined){
		eval_year = year;
	}
	//selectId를 id로 가진 객체의 여부 판단. 없을 경우 selectYear를 id로 가진 객체의 여부 판단.
	if($("#"+selectId).get(0) == undefined){
		if($("#selectEvalDept").get(0) == undefined){
			alert(selectId + 'is not exist!');
			return;
		}else{
			varSelId = "selectEvalDept";
		}
	}else{
		varSelId = selectId;
	}
	
	$.post(url+"jsp/common/common_X.jsp", { actGubn:"selectEvalDept",eval_year: eval_year,  type: "post" }, function(data){selectPost_rdr(data,varSelId, varTotYn) });
}

/**
**ajax를 이용해서 지표 리스트 콤보박스 채우는 함수.
*@selectId 	콤보박스 id
*@totYn		콤보박스에 "전체" 옵션 삽입 여부
*@url		rootUrl
*@colNm		조회조건에 사용되는 컬럼명. 여러개일 경우 :를 구분자로 이용.
*@colVal	조회조건에 사용되는 값. 여러개일 경우 :를 구분자로 이용.
*@customQuery 단순히 colNm = colVal로 할 수 없는 조건쿼리. 여러개일 경우 :를 구분자로 이용.
*@prgKbn    2010.09.03 추가 엑셀실적등록에 사용유무
**/
function selectMeas(selectId, totYn, url, eval_year, colNm, colVal, customQuery, prgKbn){
	var varTotYn;
	var varSelId;
	var oIdx;
	
	//현재 년도 구하기
	var date = new Date();
	//date.getTime()는 1970년 1월 1일 이후의 시간을 밀리세컨드로 나눈 값이므로 년횟수를 구하고 1970을 더한다.
    var year = parseInt(date.getTime()/1000/60/60/24/365)+1970; 
	
	//전체 옵션 삽입 여부 인수가 없을 경우 기본값인  false로 고정
	if(totYn == null || totYn == undefined){
		varTotYn = false;
	}else{
		varTotYn = totYn;
	}
	
	if(url == null || url == undefined) url = "./../../";
	
	//파라메터 인수가 없을 경우 기본값인  현재년도로 고정
	if(eval_year == null || eval_year == undefined){
		eval_year = year;
	}
	if(colNm == null || colNm == undefined){
		colNm = "";
	}
	if(colVal == null || colVal == undefined){
		colVal = "";
	}
	if(customQuery == null || customQuery == undefined){
		customQuery = "";
	}
	
	//selectId를 id로 가진 객체의 여부 판단. 없을 경우 selectYear를 id로 가진 객체의 여부 판단.
	if($("#"+selectId).get(0) == undefined){
		if($("#selectMeas").get(0) == undefined){
			alert(selectId + 'is not exist!');
			return;
		}else{
			varSelId = "selectMeas";
		}
	}else{
		varSelId = selectId;
	}
	
    if (prgKbn=="Y") {
	    $.post(url+"jsp/common/common_X.jsp", { actGubn:"selectMeasXls", 
					eval_year : eval_year, colNm : colNm, colVal : colVal, customQuery:customQuery, 
					type: "post" }, function(data){selectPost_rdr(data,varSelId, varTotYn) });
    } else {
  	    $.post(url+"jsp/common/common_X.jsp", { actGubn:"selectMeas", 
					eval_year : eval_year, colNm : colNm, colVal : colVal, customQuery:customQuery, 
					type: "post" }, function(data){selectPost_rdr(data,varSelId, varTotYn) });
    }
}


/**
**ajax를 이용해서 지표 리스트 콤보박스 채우는 함수.
*@selfId 		콤보박스 id, 상위부서ID를 구하는 콤보박스. 현재 함수를 호출하는 콤보박스. 
*@childId		자식 콤보박스 id, 실제 옵션들이 핸들링되는 콤보박스.
*@totYn			콤보박스에 "전체" 옵션 삽입 여부
*@url			rootUrl
*@eval_year		조회년도. 이 인수가 없을 경우 tblbsc에서 조회, 있을 경우 하이라키에서 조회.
**/
function selectDept(selfId, childId, totYn, url, eval_year){
	var varPid;
	var oIdx;
	
	//부서 콤보박스가 없을 경우 진행 안 한.
	if(selfId == null || selfId == undefined){ alert('selfId is undefined'); return;}
	if(childId == null || childId == undefined){ alert('childId is undefined'); return;}
	
	//전체 옵션 삽입 여부 인수가 없을 경우 기본값인  false로 고정
	if(totYn == null || totYn == undefined){
		totYn = false;
	}
	
	//url이 없을 경우
	if(url == null || url == undefined) url = "./../../";
	
	//파라메터 인수가 없을 경우 기본값인  현재년도로 고정
	if(eval_year == null || eval_year == undefined){
		eval_year = "";
	}
	
	if(selfId == childId){  //selfId == childId인 경우 첫번째 부서 콤보박스를 채우는 경우임.
		varPid = eval_year == ""?'1':"0";
	}else{					//selfId != childId인 경우 selfId에서 상위부서id를 구한다.
		varPid = $('#'+selfId).val();
	} 
	
	$.post(url+"jsp/common/common_X.jsp", { actGubn:"selectDept", eval_year : eval_year, pid : varPid, type: "post" }, function(data){selectPost_rdr(data,childId, totYn) });
}

/**
**ajax를 이용해서 콤보박스의 옵션을 채우는 함수의 공통콜백 함수.<b> 
*@data 			json 형태의 Text
*@varSelId		콤보박스 id
*@varTotYn		콤보박스에 "전체" 옵션 삽입 여부
*@defaultVal	콤보박스의 디폴트값
**/
function selectPost_rdr(data, varSelId, varTotYn, defaultVal){
	if(varSelId == null || varSelId == undefined){ alert('varSelId is undefined'); return;}
	if(varTotYn == null || varTotYn == undefined){ alert('varTotYn is undefined'); return;}
	
	//option 채우기 전에 기존의 option 삭제.
	if(varTotYn){
		if($("#"+varSelId).get(0).length == 0){
			$("#"+varSelId).get(0).options[0] = new Option("::Select::","");
		}
		$("#"+varSelId).get(0).length = 1;
		oIdx = 1;
	}else{
		$("#"+varSelId).get(0).length = 0;
		oIdx = 0;
	}
	
	if(trim(data) == ""){
		$("#"+varSelId).get(0).length = 0;
		$("#"+varSelId).get(0).options[0] = new Option("::Empty::", "no_data");
		return;
	}
	
	eval("var rs = " + data);
	
	var pid;
	
	//option 채우기
	for(var i = 0; i < rs.rs.length; i++){
		if(i == 0){
			pid = rs.rs[i].value;
		}
		$("#"+varSelId).get(0).options[oIdx] = new Option(rs.rs[i].text, rs.rs[i].value);
		oIdx++;
	}
	//default값 선택
	if(defaultVal != null && defaultVal != undefined)
		$("#"+varSelId).val(defaultVal);
}
/**
**ajax를 이용해서 콤보박스의 옵션을 채우는 함수의 공통콜백 함수.<b> 
*@data 			json 형태의 Text
*@varSelId		콤보박스 id
*@varTotYn		콤보박스에 "전체" 옵션 삽입 여부
*@defaultVal	콤보박스의 디폴트값
**/
function selectPostTot_rdr(data, varSelId, varTotYn, defaultVal){
	if(varSelId == null || varSelId == undefined){ alert('varSelId is undefined'); return;}
	if(varTotYn == null || varTotYn == undefined){ alert('varTotYn is undefined'); return;}
	
	//option 채우기 전에 기존의 option 삭제.
	if(varTotYn){
		if($("#"+varSelId).get(0).length == 0){
			$("#"+varSelId).get(0).options[0] = new Option("::All::","");
		}
		$("#"+varSelId).get(0).length = 1;
		oIdx = 1;
	}else{
		$("#"+varSelId).get(0).length = 0;
		oIdx = 0;
	}
	
	if(trim(data) == ""){
		$("#"+varSelId).get(0).length = 0;
		$("#"+varSelId).get(0).options[0] = new Option("::Empty::", "no_data");
		return;
	}
	
	eval("var rs = " + data);
	
	var pid;
	
	//option 채우기
	for(var i = 0; i < rs.rs.length; i++){
		if(i == 0){
			pid = rs.rs[i].value;
		}
		$("#"+varSelId).get(0).options[oIdx] = new Option(rs.rs[i].text, rs.rs[i].value);
		oIdx++;
	}

	//default값 선택
	if(defaultVal != null && defaultVal != undefined)
		$("#"+varSelId).val(defaultVal);
}

/**
**재귀호출을 통해 한번에 모든 콤보박스 채우는 함수.
*@selId		콤보박스의 id(뒤의 순번은 제외하고, 공통적인 영문 부분만)
*@sIdx		맨 첫 콤보박스의 id 순번
*@cIdx		콤보박스의 옵션을 채울 대상의 id의 순번
*@eIdx		마지막 콤보박스의 id의 순번.
*@totYn		전체 옵션의 유무 여부
*@url		root url
*@eval_year	조회년도. 있으면 하이라키 직재정보, 없으며 tblbsc 조회
*@dataField	하이라키 직재정보에서 마지막 부서 단계에서 옵션의 value에 삽입될 데이터컬럼명.
*@defaultVal 기본선택지.
**/
function selectDept3SB(selId, sIdx, cIdx, eIdx, totYn, url, eval_year, dataField, defaultVal){
	var varPid;
	
	//인수가 제대로 왔는 지 검증.
	if(selId == undefined || selId == ''){ alert('selId is undefined'); return;}
	if(sIdx == undefined || sIdx == ''){ alert('sIdx is undefined'); return;}
	if(cIdx == undefined || cIdx == ''){ alert('cIdx is undefined'); return;}
	if(eIdx == undefined || eIdx == ''){ alert('eIdx is undefined'); return;}
	if(url == '' || url == undefined) url = "./../../";
	if(eval_year == null || eval_year == undefined){
		eval_year = "";
	}
	if(dataField == null || dataField == undefined){
		dataField = "bid";
	}
	if(defaultVal == null || defaultVal == undefined){
		defaultVal = "";
	}
	
	//상위부서 id 구하기
	if(sIdx == cIdx){  //옵션을 채울  콤보박스가 첫번째 콤보박스일 경우
		varPid = eval_year == ""?'1':"0";
	}else{					//옵션을 채우 콤보박스가 첫콤보박스가 아닐 경우 이전 콤보박스에서 selfId에서 상위부서id를 구한다.
		var prevIdx = Number(cIdx)-1; 
		varPid = $('#'+selId+prevIdx).val();
	} 
	
	$.post(url+"jsp/common/common_X.jsp", { actGubn:"selectDept3SB", eval_year : eval_year, pid : varPid, dataField : dataField,type: "post" }, function(data){selectPost3SB_rdr(data,selId, sIdx, cIdx, eIdx, totYn, url, eval_year, dataField,defaultVal) });
}

/**
**ajax를 이용해서 콤보박스의 옵션을 채우는 함수의 재귀호출콜백 함수.<b> 
**/
function selectPost3SB_rdr(data, selId, sIdx, cIdx, eIdx, totYn, url, eval_year, dataField,defaultVal){
	var nextIdx = Number(cIdx)+1;	
	var oIdx;
	//option 채우기 전에 기존의 option 삭제.
	if(totYn){
		if($("#"+selId+cIdx).get(0).length == 0){
			$("#"+selId+cIdx).get(0).options[0] = new Option("::Select::","");
		}
		$("#"+selId+cIdx).get(0).length = 1;
		oIdx = 1;
	}else{
		$("#"+selId+cIdx).get(0).length = 0;
		oIdx = 0;
	}
	if(trim(data) == ""){
		$("#"+selId+cIdx).get(0).length = 0;
		$("#"+selId+cIdx).get(0).options[0] = new Option("::Empty::", "no_data");
		return;
	}
	eval("var rs = " + data);
	//option 채우기
	for(var i = 0; i < rs.rs.length; i++){
		$("#"+selId+cIdx).get(0).options[oIdx] = new Option(rs.rs[i].text, rs.rs[i].value);
		oIdx++;
	}
	//default값 선택
	if(defaultVal != ""){
		var dvs = defaultVal.split("|");
		var idx=Number(cIdx)-Number(sIdx);
		$("#"+selId+cIdx).val(dvs[idx]);
	}
	//옵션을 채울 콤보박스가 마지막 콤보박스가 아니고, 전체 옵션을 사용하지 않을때만 다음 단계 옵션을 채울 함수를 호출함.
	if(cIdx < eIdx && !totYn){
		selectDept3SB(selId, sIdx, nextIdx, eIdx, totYn, url, eval_year, dataField,defaultVal);
	}
}

function selectDeptEmp3SB(selId, sIdx, cIdx, eIdx, totYn, url, eval_year, dataField, defaultVal){
	var varPid;
	var level;
	
	//인수가 제대로 왔는 지 검증.
	if(selId == undefined || selId == ''){ alert('selId is undefined'); return;}
	if(sIdx == undefined || sIdx == ''){ alert('sIdx is undefined'); return;}
	if(cIdx == undefined || cIdx == ''){ alert('cIdx is undefined'); return;}
	if(eIdx == undefined || eIdx == ''){ alert('eIdx is undefined'); return;}
	if(url == '' || url == undefined) url = "./../../";
	if(eval_year == null || eval_year == undefined){
		eval_year = "";
	}
	if(dataField == null || dataField == undefined){
		dataField = "bid";
	}
	if(defaultVal == null || defaultVal == undefined){
		defaultVal = "";
	}
	
	//상위부서 id 구하기
	if(sIdx == cIdx){  //옵션을 채울  콤보박스가 첫번째 콤보박스일 경우
		varPid = eval_year == ""?'1':"0";
		level = "1";
	}else{					//옵션을 채우 콤보박스가 첫콤보박스가 아닐 경우 이전 콤보박스에서 selfId에서 상위부서id를 구한다.
		var prevIdx = Number(cIdx)-1;
		level = cIdx; 
		varPid = $('#'+selId+prevIdx).val();
	} 
	
	$.post(url+"jsp/common/common_X.jsp", { actGubn:"selectDeptEmp3SB", eval_year : eval_year, pid : varPid, level : level,type: "post" }, function(data){selectPostEmp3SB_rdr(data,selId, sIdx, cIdx, eIdx, totYn, url, eval_year, dataField,defaultVal) });
}

/**
**ajax를 이용해서 콤보박스의 옵션을 채우는 함수의 재귀호출콜백 함수.<b> 
**/
function selectPostEmp3SB_rdr(data, selId, sIdx, cIdx, eIdx, totYn, url, eval_year, dataField,defaultVal){
	var nextIdx = Number(cIdx)+1;	
	var oIdx;
	//option 채우기 전에 기존의 option 삭제.
	if(totYn){
		if($("#"+selId+cIdx).get(0).length == 0){
			$("#"+selId+cIdx).get(0).options[0] = new Option("::Select::","");
		}
		$("#"+selId+cIdx).get(0).length = 1;
		oIdx = 1;
	}else{
		$("#"+selId+cIdx).get(0).length = 0;
		oIdx = 0;
	}
	if(trim(data) == ""){
		$("#"+selId+cIdx).get(0).length = 0;
		$("#"+selId+cIdx).get(0).options[0] = new Option("::Empty::", "no_data");
		return;
	}
	eval("var rs = " + data);
	//option 채우기
	for(var i = 0; i < rs.rs.length; i++){
		$("#"+selId+cIdx).get(0).options[oIdx] = new Option(rs.rs[i].text, rs.rs[i].value);
		oIdx++;
	}
	//default값 선택
	if(defaultVal != ""){
		var dvs = defaultVal.split("|");
		var idx=Number(cIdx)-Number(sIdx);
		$("#"+selId+cIdx).val(dvs[idx]);
	}
	//옵션을 채울 콤보박스가 마지막 콤보박스가 아니고, 전체 옵션을 사용하지 않을때만 다음 단계 옵션을 채울 함수를 호출함.
	if(cIdx < eIdx && !totYn){
		selectDeptEmp3SB(selId, sIdx, nextIdx, eIdx, totYn, url, eval_year, dataField,defaultVal);
	}
}

/**
**ajax를 이용해서 직무 콤보박스 채우는 함수.
*@selectId 	콤보박스 id
*@totYn		콤보박스에 "전체" 옵션 삽입 여부
*@url		rootUrl
**/
function selectJob(selectId, totYn, url){
	var varTotYn;
	var varSelId;
	var oIdx;
	
	//전체 옵션 삽입 여부 인수가 없을 경우 기본값인  false로 고정
	if(totYn == null || totYn == undefined){
		varTotYn = false;
	}else{
		varTotYn = totYn;
	}
	
	if(url == null || url == undefined) url = "./../../";
	
	//selectId를 id로 가진 객체의 여부 판단. 없을 경우 selectYear를 id로 가진 객체의 여부 판단.
	if($("#"+selectId).get(0) == undefined){
		if($("#selectJob").get(0) == undefined){
			alert(selectId + 'is not exist!');
			return;
		}else{
			varSelId = "selectJob";
		}
	}else{
		varSelId = selectId;
	}
	
	$.post(url+"jsp/common/common_X.jsp", { actGubn:"selectJob", type: "post" }, function(data){selectPostTot_rdr(data, varSelId, varTotYn) });
}

/**
**ajax를 이용해서 중분류 콤보박스 채우는 함수.
*@ldiv_cd 	중분류 코드
*@selectId 	콤보박스 id
*@totYn		콤보박스에 "전체" 옵션 삽입 여부
*@url		rootUrl
**@defaultVal	콤보박스의 디폴트값
**/
function selectMdivCodeList(ldiv_cd, selectId, totYn, url, defaultVal){
	var varTotYn;
	var varSelId;
	var oIdx;
	
	varSelId = selectId;
	
	//전체 옵션 삽입 여부 인수가 없을 경우 기본값인  false로 고정
	if(totYn == null || totYn == undefined){
		varTotYn = false;
	}else{
		varTotYn = totYn;
	}
	
	if(url == null || url == undefined) url = "./../../";
	
	$.post(url+"jsp/common/common_X.jsp", { actGubn:"getMdivCodeList", ldiv_cd: ldiv_cd, type: "post" }, function(data){selectMdivCodeList_rdr(data, varSelId, varTotYn, defaultVal); });
}

/**
**ajax를 이용해서 중분류 콤보박스의 옵션을 채우는 함수의 공통콜백 함수.<b> 
*@data 			json 형태의 Text
*@varSelId		콤보박스 id
*@varTotYn		콤보박스에 "전체" 옵션 삽입 여부
*@defaultVal	콤보박스의 디폴트값
**/
function selectMdivCodeList_rdr(data, varSelId, varTotYn, defaultVal){
	if(varSelId == null || varSelId == undefined){ alert('varSelId is undefined'); return;}
	if(varTotYn == null || varTotYn == undefined){ alert('varTotYn is undefined'); return;}
	
	//option 채우기 전에 기존의 option 삭제.
	if(varTotYn){
		if($("#"+varSelId).get(0).length == 0){
			$("#"+varSelId).get(0).options[0] = new Option("::All::","");
		}
		$("#"+varSelId).get(0).length = 1;
		oIdx = 1;
	}else{
		$("#"+varSelId).get(0).length = 0;
		oIdx = 0;
	}
	
	if(trim(data) == ""){
		$("#"+varSelId).get(0).length = 0;
		$("#"+varSelId).get(0).options[0] = new Option("::Empty::", "");
		return;
	}
	
	eval("var rs = " + data);
	
	var pid;
	
	//option 채우기
	for(var i = 0; i < rs.rs.length; i++){
		if(i == 0){
			pid = rs.rs[i].value;
		}
		$("#"+varSelId).get(0).options[oIdx] = new Option(rs.rs[i].div_nm, rs.rs[i].sdiv_cd);
		oIdx++;
	}

	//default값 선택
	if(defaultVal != null && defaultVal != undefined)
		$("#"+varSelId).val(defaultVal);
}

/**
**ajax를 이용해서 부서레벨 콤보박스 채우는 함수.
*@ldiv_cd 	중분류 코드
*@selectId 	콤보박스 id
*@totYn		콤보박스에 "전체" 옵션 삽입 여부
*@url		rootUrl
*@defaultVal	콤보박스의 디폴트값
**/
function selectBscOrglevList(org_level, selectId, totYn, url, defaultVal){
	var varTotYn;
	var varSelId;
	var oIdx;
	
	varSelId = selectId;
	
	//전체 옵션 삽입 여부 인수가 없을 경우 기본값인  false로 고정
	if(totYn == null || totYn == undefined){
		varTotYn = false;
	}else{
		varTotYn = totYn;
	}
	
	if(url == null || url == undefined) url = "./../../";
	
	$.post(url+"jsp/common/common_X.jsp", { actGubn:"getBscOrglevList", org_level: org_level, type: "post" }, function(data){selectPostTot_rdr(data, varSelId, varTotYn, defaultVal); });
}

/*******************************************************************************************************************************************************/
/** json + jQuery 를 이용해서 테이블에 데이터 삽입하기.
/** 1.본 파일과 함께 jQuery.js 파일도 같이 import 되어야 한다. 
/** 2.json은 아래와 같은 형식으로 작성되어야 한다.
	{"rs" : [
		{"pid" : "sp_etlxxxxx1","pnm" : "테스트1","type" : "011"},
		{"pid" : "sp_etlxxxxx2","pnm" : "테스트2","type" : "012"},
		{"pid" : "sp_etlxxxxx3","pnm" : "테스트3","type" : "013"}
	]}
/** 3.table은 아래와 같은 형태로 구성되어야 한다. thead의 td 태그에 사용되는 dataField, textAlign은 필수기재 요소이다. dataField의 값과 json의 키값이 같아야 제대로 된 정보를 가져올 수 있다.
    textAlign은 thead의 td의 align을 지정하는 것이 아니라 tbody의 td의 align을 지정하는 것임을 명심하라.
	<table id="" style="">
		<thead id="">
			<tr>
				<th dataField="pid" textAlign="center">ETL ID<td>
				<th dataField="pnm" textAlign="left">ETL명<td>
				<th dataField="type" textAlign="center">ETL Type<td>
			</tr>
		</thead>
	</table> 
	<div id="" style="">
	<table id="" style="">
		<tbody id="sp_etlxxxxx1">
			<tr id="etl" >
				<td>sp_etlxxxxx1</td><td>테스트1</td><td>011</td>
			</tr>
			<tr id="sp_etlxxxxx2" >
				<td>sp_etlxxxxx2</td><td>테스트2</td><td>012</td>
			</tr>
			<tr id="sp_etlxxxxx3" >
				<td>sp_etlxxxxx2</td><td>테스트3</td><td>013</td>
			</tr>
		</tbody>
	</table>
	</div>
/** 4.아래에 작성된 함수들을 적절하게 활용해야 한다.
/*******************************************************************************************************************************************************/
//헤더정보를 저장하는 배열객체
var arrThead = new Array(); 
	
/**배열에 담을 객체(자바로 보면 빈객체?)
*@idx	td의 순번
*@width td의 width
*@align	td의 align
*@dataField	td에 대입되는 json의 key값
*@idKey tr의 id를 만들 때 쓰이는 앞전어
*@itemRender td에 일반 문자열이 들어가는 것이 아니라 checkbox, radiobutton, text같은 객체가 들어갈 경우 
*@href	a tag를 활용할 경우 href 속성에 들어갈 값.
*@src	itemRender가 image 일 경우 src 속성에 들어갈 값
*/
function theadBean(idx, width, align, dataField, idKey, itemRender, href, src, round)
{
	this.idx = idx;
	this.width = width;
	this.align = align;
	this.dataField = dataField;
	this.idKey = idKey;
	this.itemRender = itemRender;
	this.href = href;
	this.src = src;
	this.round = round;
}

//객체를 배열에 담는 함수.
function addThead(idx, width, align, dataField, idKey, itemRender, href, src, round)
{ 
 	arrThead[idx] = new theadBean(idx, width, align, dataField, idKey, itemRender, href, src, round); 	
}

/**json을 이용해서 json의 데이타를 테이블 바디에 삽입하는 함수.
*@json  json 
*@thead_id thead의 id
*@tbody_id tbody의 id
*@tbody_divid  tbody를 감싸고 있는 div의 id
*@tbody_div_width	tbody를 감싸고 있는 div의 width
*@tbody_div_height	tbody를 감싸고 있는 div의 height
*@trStyle tr에 적용할 style class
*@tdStyle td에 적용할 style class
*@idKey tr의 id를 생성할때 쓰이는 앞전어
*@trIdDataField		tr의 id에 들어가는 json의 키값
*@mode 1-기존 테이블로우 전체 삭제후 인서트, 2-기존 테이블로우중 없는 것만 인서트
*/
function createTableByJson(json, thead_id, tbody_id, tbody_divid, tbody_div_width, tbody_div_height, trStyle, tdStyle, idKey, trIdDataField, mode){
	//mode 값이 없거나 변수가 넘어오지 않았을 때 1로 지정.
	if(mode == undefined || mode == '') mode = '1';	

	//mode가 1일때 기존의 테이블로우가 있다면 삭제한다.
	if(mode == '1'){
		$("#"+tbody_id+ " tr").each(function () {
			var row = $("#"+this.id);
			row.remove();
		});
	}
	
	if($("#"+tbody_id+ " tr:first").attr("id") == "noresult"){
		var row = $("#"+$("#"+tbody_id+ " tr:first").attr("id"));
		row.remove();
	}

	//테이블의 헤더 정보를 가져온다.
	arrThead = new Array();
    $("#"+thead_id+" th").each(function (i) {
     	var width = this.width;
		if(width == ""){
			width = this.style.width;
			width = width.replace('px','');
		}
		var align = this.getAttribute("textAlign");
		if(align == "") align = "center";
		
		var itemRender = this.getAttribute("itemRender");
		if(itemRender == "" || itemRender == undefined) itemRender = "html";
		
		var href = this.getAttribute("href");
		if(href == "" || href == undefined) href = "";
		
		var src = this.getAttribute("src");
		if(src == "" || src == undefined) src = "";
		
       	var round = this.getAttribute("round");
		if(round == "" || round == undefined) round = "";
	
      	addThead(i, width, align, this.getAttribute("dataField"), idKey, itemRender, href, src, round);
    });
	
	var rowCnt = 0;	//실제 추가되는 row의 수
	var appHtml = ""; //실제 추가되는 tr, td 등의 html

	if(trim(json) != ""){
		eval("var rs = "+json); //일반 텍스트를 DOM 객체화 시킨다.

		//tbody_div_width를 컬럼수+1만큼 늘려준다. 늘려주는 이유는 테이블의 cellspacing="1"때문의 테이블과 div의 width가 어긋나기 때문이다.
        var divWidth = tbody_div_width;
        if(tbody_div_width != ""){
        	if(tbody_div_width.indexOf('%')<0){ //%가 있으면 굳이 이렇게 더할 필요가 없다. 픽셀로 따질 경우만 진행함.
        		var tmpWidth = divWidth.replace('px', '');
        		tmpWidth = parseInt(tmpWidth) + (arrThead.length+1);
        		divWidth = tmpWidth+'px';
        	}
        }

		//json 객체의 row수만큼 루프를 돌리면서 html을 생성한다.
		for(var i=0; i<rs.rs.length; i++){
			//새로 추가하는 부서가 기존에 있는 지 검증.
			var flag = 0;
			$("#"+tbody_id+" tr").each(function () {
		        if(this.id == idKey+eval("rs.rs[i]."+trIdDataField)){
		        	flag = 1;
		        }
		      });

		    //현재 부서가 기존에 없을 경우 새로 html을 생성한다.
		    if(!flag){
		    	eval("var trId = rs.rs["+i+"]."+trIdDataField);
				appHtml += "<tr id='"+idKey+trId+"' class='"+trStyle+"'>";
				for(var d = 0; d < arrThead.length; d++){
					var width = arrThead[d].width;
				    if(d == (arrThead.length-1)&& arrThead[d].width.indexOf('%') < 0){ width = width-17;}
					var padding = "";
				    if(arrThead[d].align == "right" && arrThead[d].width.indexOf('%') < 0){width = width-5; padding = "padding: 0 5 0 0";}
				    if(arrThead[d].align == "left" && arrThead[d].width.indexOf('%') < 0){width = width-5; padding = "padding: 0 0 0 5";}
					appHtml += "<td width='"+width+"' align='"+arrThead[d].align+"' class='"+tdStyle+"' style='"+padding+"' ";
					if(arrThead[d].itemRender == 'checkbox'){
						eval("var chkValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var chkId = rs.rs["+i+"]."+trIdDataField);
						var chkHtml = "";
						if(chkValue == "true" || chkValue == "1" || chkValue == "Y"){
							chkHtml = "checked";
						}
						appHtml += "> <input type='checkbox' id='chkbox"+chkId+"'"+chkHtml+" />";
					}else if(arrThead[d].itemRender == 'checkbox_click'){
						eval("var chkValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var chkId = rs.rs["+i+"]."+trIdDataField);
						var chkHtml = "";
						if(chkValue == "true" || chkValue == "1" || chkValue == "Y"){
							chkHtml = "checked";
						}
						appHtml += "> <input type='checkbox' id='chkboxc"+chkId+"'"+chkHtml+" onClick='clickCheckBox(this.id)'/>";
					}else if(arrThead[d].itemRender == 'text'){
						eval("var textValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var textId = rs.rs["+i+"]."+trIdDataField);
						if(arrThead[d].round != "" && numcheck_pm(textValue)){textValue = Number(textValue).toFixed(arrThead[d].round);}
						appHtml += "> <input type='text' id='text"+textId+"' value='"+textValue+"'/>";
					}else if(arrThead[d].itemRender == 'combobox'){
						eval("var comValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var comId = rs.rs["+i+"]."+trIdDataField);
						var chkHtml1 = " ";
						var chkHtml2 = " ";
						if(comValue == "1"){
							chkHtml1 = "selected";
						}
						if(comValue == "2"){
							chkHtml2 = "selected";
						}
						appHtml += "> <select id='combobox"+comId+"' >";
						appHtml += "<option value=1 "+chkHtml1+" >정상평가</option>";
						appHtml += "<option value=2 "+chkHtml2+" >신생부서</option>";
						appHtml += " </select>";	
					}else if(arrThead[d].itemRender == 'img'){
						eval("var textValue = rs.rs["+i+"]."+arrThead[d].dataField);
						var srcValue = arrThead[d].src;
						appHtml += "> ";
						if(arrThead[d].href != ""){
							appHtml += "<a href='"+arrThead[d].href+"'>";
						}
						appHtml += "<img src='"+srcValue+"'/>";
						if(arrThead[d].href != ""){
							appHtml += "</a>";
						}
					}else if(arrThead[d].itemRender == 'a'){
						eval("var textValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var hrefValue = rs.rs["+i+"]."+arrThead[d].href);
						if(hrefValue == "" || hrefValue == undefined) hrefValue = arrThead[d].href;
						appHtml += "> <a href='"+hrefValue+"'>"+textValue+"</a>";
					}else if(arrThead[d].itemRender == 'a_taskrptfile'){
						eval("var textValue = rs.rs["+i+"]."+arrThead[d].dataField);
						appHtml += "> <a href='./../../common/download.jsp?refreshYn=back&fileName="+textValue+"&filePath=upload/task/rpt/"+textValue+"'>"+textValue+"</a>";
					}else if(arrThead[d].itemRender == 'nobr'){
						eval("var tdHtml = rs.rs["+i+"]."+arrThead[d].dataField);
						if(arrThead[d].round != "" && numcheck_pm(tdHtml)){tdHtml = Number(tdHtml).toFixed(arrThead[d].round);}
						appHtml += "title='"+tdHtml+"' >";
						appHtml += "<nobr>"+tdHtml+"</nobr>";
						appHtml += "</td>";
					}else{
						eval("var tdHtml = rs.rs["+i+"]."+arrThead[d].dataField);
						if(arrThead[d].round != "" && numcheck_pm(tdHtml)){tdHtml = Number(tdHtml).toFixed(arrThead[d].round);}
						appHtml += "> "+tdHtml;
						appHtml += "</td>";
					}
				}
				appHtml += "</tr>";
			}
			rowCnt++;
		}
	}
	
	//rowCnt == 0이거나 json이 ""이면 데이터가 없다는 메시지를 보여준다.
	if(rowCnt == 0){
		var text = "조회 결과가 없습니다.";
		var totwidth= tbody_div_width.replace("px","");
		appHtml += "<tr id='noresult' class='"+trStyle+"'><td colspan='"+arrThead.length+"' align='center' >"+text+"</td></tr>";
		if(tbody_div_width.indexOf('%') < 0){
			divWidth = parseInt(totwidth)+(arrThead.length+1);
			divWidth = divWidth+"px";
		}else{
			divWidth = tbody_div_width;
		}
	}

	$("#"+tbody_id).append(
		appHtml
	);

	$("#"+tbody_divid).attr("style", "width:"+divWidth+";height:"+tbody_div_height+";overflow-y:scroll;overflow-x:hidden");
	
	if(mode == '2'){
		var div1 = $("#"+tbody_divid).get(0);
		$("#"+tbody_divid).scrollTop(div1.scrollHeight); //스크롤바 맨 밑으로 내리기.
	}
}

/**json을 이용해서 json의 데이타를 테이블 바디에 삽입하는 함수. tr클릭시 콜백함수 호출하는 기능 추가
*@json  	json 
*@thead_id 	thead의 id
*@tbody_id 	tbody의 id
*@tbody_divid  	tbody를 감싸고 있는 div의 id
*@tbody_div_width			tbody를 감싸고 있는 div의 width
*@tbody_div_height		tbody를 감싸고 있는 div의 height
*@trStyle 	tr에 적용할 style class
*@tdStyle 	td에 적용할 style class
*@idKey 	tr의 id를 생성할때 쓰이는 앞전어
*@trIdDataField		tr의 id에 들어가는 json의 키값
*@callbackFnc		tr을 클릭했을 때 호출되는 함수명
*@mouseOverBgColor		마우스 오버시 tr 배경색
*@mouseOutBgColor		마우스가 tr에서 나갔을때 배경색
*@mouseClickBgColor		마우스가 tr을 클릭했을때 배경색
*@variableName		tr의 mouse 이벤트에 활용되는 변수
*@mode 1-기존 테이블로우 전체 삭제후 인서트, 2-기존 테이블로우중 없는 것만 인서트
*/
function createTableByJsonOnClick(json, thead_id, tbody_id, tbody_divid, tbody_div_width, tbody_div_height
									, trStyle, tdStyle, idKey, trIdDataField, callbackFnc, mouseOverBgColor, mouseOutBgColor
									, mouseClickBgColor, variableName, mode
									){
									
	//mode 값이 없거나 변수가 넘어오지 않았을 때 1로 지정.
	if(mode == undefined || mode == '') mode = '1';	
	
	//variableName X로 초기화.
	if(!(variableName == undefined || variableName == '')){
		eval(variableName+" = 'X'");
	}

	//mode가 1일때 기존의 테이블로우가 있다면 삭제한다.
	if(mode == '1'){
		$("#"+tbody_id+ " tr").each(function (ai) {
			var row = $("#"+this.id);
			row.remove();
		});
	}
	if($("#"+tbody_id+ " tr:first").attr("id") == "noresult"){
		var row = $("#"+$("#"+tbody_id+ " tr:first").attr("id"));
		row.remove();
	}
	
	//테이블의 헤더 정보를 가져온다.
	arrThead = new Array();
    $("#"+thead_id+" th").each(function (i) {
     	var width = this.width;
		if(width == ""){
			width = this.style.width;
			width = width.replace('px','');
		}
		var align = this.getAttribute("textAlign");
		if(align == "") align = "center";
		
		var itemRender = this.getAttribute("itemRender");
		if(itemRender == "" || itemRender == undefined) itemRender = "html";
		
		var href = this.getAttribute("href");
		if(href == "" || href == undefined) href = "";
		
		var src = this.getAttribute("src");
		if(src == "" || src == undefined) src = "";
		
		var round = this.getAttribute("round");
		if(round == "" || round == undefined) round = "";
		
       	addThead(i, width, align, this.getAttribute("dataField"), idKey, itemRender, href, src, round);
    });
	
	
	var rowCnt = 0;	//실제 추가되는 row의 수
	var appHtml = ""; //실제 추가되는 tr, td 등의 html
	
	if(trim(json) != ""){
	
		eval("var rs = "+json); //일반 텍스트를 DOM 객체화 시킨다.
		
        //tbody_div_width를 컬럼수+1만큼 늘려준다. 늘려주는 이유는 테이블의 cellspacing="1"때문의 테이블과 div의 width가 어긋나기 때문이다.
        var divWidth = tbody_div_width;
        if(tbody_div_width != ""){
        	if(tbody_div_width.indexOf('%')<0){ //%가 있으면 굳이 이렇게 더할 필요가 없다. 픽셀로 따질 경우만 진행함.
        		var tmpWidth = divWidth.replace('px', '');
        		tmpWidth = parseInt(tmpWidth) + (arrThead.length+1);
        		divWidth = tmpWidth+'px';
        	}
        }
		
		//json 객체의 row수만큼 루프를 돌리면서 html을 생성한다.
		for(var i=0; i<rs.rs.length; i++){
			//새로 추가하는 부서가 기존에 있는 지 검증.
			var flag = 0;
			
			$("#"+tbody_id+" tr").each(function (r) {
		        if(this.id == idKey+eval("rs.rs[i]."+trIdDataField)){
		        	flag = 1;
		        }
		      });

		    //현재 부서가 기존에 없을 경우 새로 html을 생성한다.
		    if(!flag){
		    	rowCnt++;
		    	eval("var trId = rs.rs["+i+"]."+trIdDataField);
				appHtml += "<tr id='"+idKey+trId+"' style='cursor:hand;height:20px' class='"+trStyle+"' \n";
				appHtml += "onClick=\"var clickRow = this;	 \n";
			 	appHtml += "var value = clickRow.getAttribute('id');\n";
			 	appHtml += "if("+variableName+" != value){ \n";
			 	appHtml += "	 var oldId = "+variableName+"; \n";
			 	appHtml += "	 "+variableName+" = value; \n";
			 	appHtml += "	 clickRow.style.backgroundColor = '"+mouseClickBgColor+"'; \n";
			 	appHtml += "	 if(oldId != 'X') document.getElementById(oldId).style.backgroundColor = '"+mouseOutBgColor+"'; \n";
			 	appHtml += "}  \n" ;
			 	appHtml += ""+callbackFnc+"(value); \" \n"
				appHtml += "bgcolor=\""+mouseOutBgColor+"\" ONMOUSEOVER=\" var overRow = this; \n";
			 	appHtml += "	overRow.style.backgroundColor = '"+mouseOverBgColor+"';\" \n" ;
				appHtml += "ONMOUSEOUT=\"var outRow = this;	\n";
			 	appHtml += "	var value = outRow.getAttribute('id'); \n ";
			 	appHtml += "	if("+variableName+" != value ){ \n";
			 	appHtml += "		outRow.style.backgroundColor = '"+mouseOutBgColor+"';  \n";
			 	appHtml += "	}\"> \n";
				for(var d = 0; d < arrThead.length; d++){
					var width = arrThead[d].width;
				    if(d == (arrThead.length-1)&& arrThead[d].width.indexOf('%') < 0){ width = width-17;}
					var padding = "";
				    if(arrThead[d].align == "right" && arrThead[d].width.indexOf('%') < 0){width = width-5; padding = "padding: 0 5 0 0";}
				    if(arrThead[d].align == "left" && arrThead[d].width.indexOf('%') < 0){width = width-5; padding = "padding: 0 0 0 5";}
					appHtml += "<td width='"+width+"' align='"+arrThead[d].align+"' class='"+tdStyle+"' style='"+padding+"' ";
					if(arrThead[d].itemRender == 'checkbox'){
						eval("var chkValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var chkId = rs.rs["+i+"]."+trIdDataField);
						var chkHtml = "";
						if(chkValue == "true" || chkValue == "1" || chkValue == "Y"){
							chkHtml = "checked";
						}
						appHtml += "> <input type='checkbox' id='chkbox"+chkId+"'"+chkHtml+" />";
					}else if(arrThead[d].itemRender == 'text'){
						eval("var textValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var textId = rs.rs["+i+"]."+trIdDataField);
						if(arrThead[d].round != "" && numcheck_pm(textValue)){textValue = Number(textValue).toFixed(arrThead[d].round);}
						appHtml += "> <input type='text'  id='text"+textId+"' value='"+textValue+"'/>";
					}else if(arrThead[d].itemRender == 'img'){
						eval("var textValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var srcValue = rs.rs["+i+"]."+arrThead[d].src);
						if(srcValue == "" || srcValue == undefined) srcValue = arrThead[d].src;
						appHtml += "> <img src=''/>";
					}else if(arrThead[d].itemRender == 'a'){
						eval("var textValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var hrefValue = rs.rs["+i+"]."+arrThead[d].href);
						if(hrefValue == "" || hrefValue == undefined) hrefValue = arrThead[d].href;
						appHtml += "> <a href='"+hrefValue+"'>"+textValue+"</a>";
					}else if(arrThead[d].itemRender == 'nobr'){
						eval("var tdHtml = rs.rs["+i+"]."+arrThead[d].dataField);
						if(arrThead[d].round != "" && numcheck_pm(tdHtml)){tdHtml = Number(tdHtml).toFixed(arrThead[d].round);}
						appHtml += "title='"+tdHtml+"' >";
						appHtml += "<nobr>"+tdHtml+"</nobr>";
						appHtml += "</td>";
					}else{
						eval("var tdHtml = rs.rs["+i+"]."+arrThead[d].dataField);
						if(arrThead[d].round != "" && numcheck_pm(tdHtml)){tdHtml = Number(tdHtml).toFixed(arrThead[d].round);}
						appHtml += "> "+tdHtml;
						appHtml += "</td>";
					}
				}
				appHtml += "</tr>";
			}
		}
	}
	
	
	//rowCnt == 0이거나 json이 ""이면 데이터가 없다는 메시지를 보여준다.
	if(rowCnt == 0){
		var text = "조회 결과가 없습니다.";
		var totwidth= tbody_div_width.replace("px","");
		appHtml += "<tr id='noresult' bgcolor='"+mouseOutBgColor+"'><td colspan='"+arrThead.length+"' align='center' width='"+totwidth+"'>"+text+"</td></tr>";
		if(tbody_div_width.indexOf('%') < 0){
			divWidth = parseInt(totwidth)+(arrThead.length+1);
			divWidth = divWidth+"px";
		}else{
			divWidth = tbody_div_width;
		}
	}
	$("#"+tbody_id).append(
		appHtml
	);
	$("#"+tbody_divid).attr("style", "width:"+divWidth+";height:"+tbody_div_height+";overflow-y:scroll;overflow-x:hidden");
	
	if(mode == '2'){
		var div1 = $("#"+tbody_divid).get(0);
		$("#"+tbody_divid).scrollTop(div1.scrollHeight); //스크롤바 맨 밑으로 내리기.
	}
}

/**json을 이용해서 json의 데이타를 테이블 바디에 삽입하는 함수.
*@json  json 
*@thead_id thead의 id
*@tbody_id tbody의 id
*@tbody_divid  tbody를 감싸고 있는 div의 id
*@tbody_div_width	tbody를 감싸고 있는 div의 width
*@tbody_div_height	tbody를 감싸고 있는 div의 height
*@trStyle tr에 적용할 style class
*@tdStyle td에 적용할 style class
*@idKey tr의 id를 생성할때 쓰이는 앞전어
*@trIdDataField		tr의 id에 들어가는 json의 키값
*@mode 1-기존 테이블로우 전체 삭제후 인서트, 2-기존 테이블로우중 없는 것만 인서트
*/
function createTableByJsonText(json, thead_id, tbody_id, tbody_divid, tbody_div_width, tbody_div_height, trStyle, tdStyle, idKey, trIdDataField, mode){
	//mode 값이 없거나 변수가 넘어오지 않았을 때 1로 지정.
	if(mode == undefined || mode == '') mode = '1';	

	//mode가 1일때 기존의 테이블로우가 있다면 삭제한다.
	if(mode == '1'){
		$("#"+tbody_id+ " tr").each(function (ai) {
			var row = $("#"+this.id);
			row.remove();
		});
	}
	if($("#"+tbody_id+ " tr:first").attr("id") == "noresult"){
		var row = $("#"+$("#"+tbody_id+ " tr:first").attr("id"));
		row.remove();
	}

	//테이블의 헤더 정보를 가져온다.
	arrThead = new Array();
    $("#"+thead_id+" th").each(function (i) {
     	var width = this.width;
		if(width == ""){
			width = this.style.width;
			width = width.replace('px','');
		}
		var align = this.getAttribute("textAlign");
		if(align == "") align = "center";
		
		var itemRender = this.getAttribute("itemRender");
		if(itemRender == "" || itemRender == undefined) itemRender = "html";
		
		var href = this.getAttribute("href");
		if(href == "" || href == undefined) href = "";
		
		var src = this.getAttribute("src");
		if(src == "" || src == undefined) src = "";
		
       	var round = this.getAttribute("round");
		if(round == "" || round == undefined) round = "";
	
      	addThead(i, width, align, this.getAttribute("dataField"), idKey, itemRender, href, src, round);
    });
	
	var rowCnt = 0;	//실제 추가되는 row의 수
	var appHtml = ""; //실제 추가되는 tr, td 등의 html

	if(trim(json) != ""){
		eval("var rs = "+json); //일반 텍스트를 DOM 객체화 시킨다.
		
		//tbody_div_width를 컬럼수+1만큼 늘려준다. 늘려주는 이유는 테이블의 cellspacing="1"때문의 테이블과 div의 width가 어긋나기 때문이다.
        var divWidth = tbody_div_width;
        if(tbody_div_width != ""){
        	if(tbody_div_width.indexOf('%')<0){ //%가 있으면 굳이 이렇게 더할 필요가 없다. 픽셀로 따질 경우만 진행함.
        		var tmpWidth = divWidth.replace('px', '');
        		tmpWidth = parseInt(tmpWidth) + (arrThead.length+1);
        		divWidth = tmpWidth+'px';
        	}
        }

		//json 객체의 row수만큼 루프를 돌리면서 html을 생성한다.
		for(var i=0; i<rs.rs.length; i++){
			//새로 추가하는 부서가 기존에 있는 지 검증.
			var flag = 0;
			$("#"+tbody_id+" tr").each(function (r) {
		        if(this.id == idKey+eval("rs.rs[i]."+trIdDataField)){
		        	flag = 1;
		        }
		      });

		    //현재 부서가 기존에 없을 경우 새로 html을 생성한다.
		    if(!flag){
		    	eval("var trId = rs.rs["+i+"]."+trIdDataField);
				appHtml += "<tr id='"+idKey+trId+"' class='"+trStyle+"'>";
				for(var d = 0; d < arrThead.length; d++){
					var width = arrThead[d].width;
				    if(d == (arrThead.length-1)&& arrThead[d].width.indexOf('%') < 0){ width = width-17;}
				    var padding = "";
				    if(arrThead[d].align == "right" && arrThead[d].width.indexOf('%') < 0){width = width-5; padding = "padding: 0 5 0 0";}
				    if(arrThead[d].align == "left" && arrThead[d].width.indexOf('%') < 0){width = width-5; padding = "padding: 0 0 0 5";}
					appHtml += "<td width='"+width+"' align='"+arrThead[d].align+"' class='"+tdStyle+"' style='"+padding+"' ";
					if(arrThead[d].itemRender == 'checkbox'){
						eval("var chkValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var chkId = rs.rs["+i+"]."+trIdDataField);
						var chkHtml = "";
						if(chkValue == "true" || chkValue == "1" || chkValue == "Y"){
							chkHtml = "checked";
						}
						appHtml += "> <input type='checkbox' id='chkbox"+chkId+"'"+chkHtml+" />";
					}else if(arrThead[d].itemRender == 'text'){
						eval("var textValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var textId = rs.rs["+i+"]."+trIdDataField);
						
						if(arrThead[d].round != "" && numcheck_pm(textValue) ){textValue = Number(textValue).toFixed(arrThead[d].round);}
						appHtml += "> <input type='text' id='text"+textId+"' value='"+textValue+"' style='text-align:center;width:80%' onKeyUp=\"javascript:autoCalc('"+textId+"');\" onkeyPress=\"if ((event.keyCode<48) || (event.keyCode>57)){if(event.keyCode==45 || event.keyCode==46){}else{event.returnValue=false;}}\" style=\"ime-mode:disabled\"/>";
					
					}else if(arrThead[d].itemRender == 'text2'){
						eval("var textValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var textId = rs.rs["+i+"]."+trIdDataField);
						
						appHtml += "> <input type='text' id='text"+textId+"' value='"+textValue+"' style='text-align:left;width:98%' />";
					
					}else if(arrThead[d].itemRender == 'img'){
						eval("var textValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var srcValue = rs.rs["+i+"]."+arrThead[d].src);
						if(srcValue == "" || srcValue == undefined) srcValue = arrThead[d].src;
						appHtml += "<img src=''/>";
					}else if(arrThead[d].itemRender == 'a'){
						eval("var textValue = rs.rs["+i+"]."+arrThead[d].dataField);
						eval("var hrefValue = rs.rs["+i+"]."+arrThead[d].href);
						if(hrefValue == "" || hrefValue == undefined) hrefValue = arrThead[d].href;
						appHtml += "> <a href='"+hrefValue+"'>"+textValue+"</a>";
					}else if(arrThead[d].itemRender == 'nobr'){
						eval("var tdHtml = rs.rs["+i+"]."+arrThead[d].dataField);
						if(tdHtml == undefined){
							tdHtml = "";
						}
						if(arrThead[d].round != "" && numcheck_pm(tdHtml)){tdHtml = Number(tdHtml).toFixed(arrThead[d].round);}
						appHtml += "title='"+tdHtml+"' >";
						appHtml += "<nobr>"+tdHtml+"</nobr>";
						appHtml += "</td>";
					}else{
						eval("var tdHtml = rs.rs["+i+"]."+arrThead[d].dataField);
						if(tdHtml == undefined){
							tdHtml = "";
						}
						if(arrThead[d].round != "" && numcheck_pm(tdHtml)){tdHtml = Number(tdHtml).toFixed(arrThead[d].round);}
						appHtml += "> "+tdHtml;
						appHtml += "</td>";
					}
				}
				appHtml += "</tr>";
			}
			rowCnt++;
		}
	}
	
	//rowCnt == 0이거나 json이 ""이면 데이터가 없다는 메시지를 보여준다.
	if(rowCnt == 0){
		var text = "조회 결과가 없습니다.";
		var totwidth= tbody_div_width.replace("px","");
		appHtml += "<tr id='noresult' class='"+trStyle+"'><td colspan='"+arrThead.length+"' align='center' >"+text+"</td></tr>";
		if(tbody_div_width.indexOf('%') < 0){
			divWidth = parseInt(totwidth)+(arrThead.length+1);
			divWidth = divWidth+"px";
		}else{
			divWidth = tbody_div_width;
		}
	}
	$("#"+tbody_id).append(
		appHtml
	);
	$("#"+tbody_divid).attr("style", "width:"+divWidth+";height:"+tbody_div_height+";overflow-y:scroll;overflow-x:hidden");
	
	if(mode == '2'){
		var div1 = $("#"+tbody_divid).get(0);
		$("#"+tbody_divid).scrollTop(div1.scrollHeight); //스크롤바 맨 밑으로 내리기.
	}
}

/**
** 테이블 merge. rowSpan.
*@ tableId table id.
*@ tdIndex column index.
*/
function mergeTableRowSpan(tableId, tdIndex){
	var tbl = document.getElementById(tableId);
	var rows = tbl.getElementsByTagName("tr");
	var cells = 0;
	var str = "";
	var rowspan = 0;
	var startIdx = 0;
		
	for(var i = 0; i < rows.length; i++){
		if(i == 0){
			cells = rows[i].getElementsByTagName("td").length;
			str = rows[i].getElementsByTagName("td")[tdIndex].innerHTML;
			rowspan++;
		}else if(i == (rows.length-1)){
			var newIndex = parseInt(tdIndex) - (parseInt(cells) - rows[i].getElementsByTagName("td").length);		
			if(rows[i].getElementsByTagName("td")[newIndex].innerHTML == str){
				if(cells == rows[startIdx].getElementsByTagName("td").length){
					rows[startIdx].getElementsByTagName("td")[tdIndex].rowSpan = parseInt(rowspan)+1;
					rows[startIdx].getElementsByTagName("td")[tdIndex].style.verticalAlign="top";
				}else{
					newIndex = parseInt(tdIndex) - (parseInt(cells) - rows[startIdx].getElementsByTagName("td").length);
					rows[startIdx].getElementsByTagName("td")[newIndex].rowSpan = parseInt(rowspan)+1;
					rows[startIdx].getElementsByTagName("td")[newIndex].style.verticalAlign="top";
				}
				for(var y = startIdx+1; y <= i; y++ ){
					if(cells == rows[y].getElementsByTagName("td").length){
						rows[y].deleteCell(tdIndex);
					}else{
						newIndex = parseInt(tdIndex) - (parseInt(cells) - rows[y].getElementsByTagName("td").length);
						rows[y].deleteCell(newIndex);
					}
				}
			}else{
				if(cells == rows[startIdx].getElementsByTagName("td").length){
					rows[startIdx].getElementsByTagName("td")[tdIndex].rowSpan = rowspan;
					rows[startIdx].getElementsByTagName("td")[tdIndex].style.verticalAlign="top";
				}else{
					newIndex = parseInt(tdIndex) - (parseInt(cells) - rows[startIdx].getElementsByTagName("td").length);
					rows[startIdx].getElementsByTagName("td")[newIndex].rowSpan = rowspan;
					rows[startIdx].getElementsByTagName("td")[newIndex].style.verticalAlign="top";
				}
				for(var y = startIdx+1; y < i; y++ ){
					if(cells == rows[y].getElementsByTagName("td").length){
						rows[y].deleteCell(tdIndex);
					}else{
						newIndex = parseInt(tdIndex) - (parseInt(cells) - rows[y].getElementsByTagName("td").length);
						rows[y].deleteCell(newIndex);
					}
				}
			}
		}else{
			var newIndex = parseInt(tdIndex) - (parseInt(cells) - rows[i].getElementsByTagName("td").length);

			if(rows[i].getElementsByTagName("td")[newIndex].innerHTML == str){
				rowspan++;
			}else{
				str = rows[i].getElementsByTagName("td")[newIndex].innerHTML;
				if(cells == rows[startIdx].getElementsByTagName("td").length){
					rows[startIdx].getElementsByTagName("td")[tdIndex].rowSpan = rowspan;
					rows[startIdx].getElementsByTagName("td")[tdIndex].style.verticalAlign="top";
				}else{
					newIndex = parseInt(tdIndex) - (parseInt(cells) - rows[startIdx].getElementsByTagName("td").length);
					rows[startIdx].getElementsByTagName("td")[newIndex].rowSpan = rowspan;
					rows[startIdx].getElementsByTagName("td")[newIndex].style.verticalAlign="top";
				}
				
				for(var y = startIdx+1; y < i; y++ ){
					if(cells == rows[y].getElementsByTagName("td").length){
						rows[y].deleteCell(tdIndex);
					}else{
						newIndex = parseInt(tdIndex) - (parseInt(cells) - rows[y].getElementsByTagName("td").length);
						rows[y].deleteCell(newIndex);
					}
				}
				startIdx = i;
				rowspan = 1;
			}
		}
		
	}
}