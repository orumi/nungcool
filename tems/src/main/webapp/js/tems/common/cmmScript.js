// console.log 사용
var console = window.console || {log:function(){}};

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 마우스 오른쪽 클릭, F5 키 방지
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
/*$(function() {   
	$("body").removeAttr("oncontextmenu").attr({"oncontextmenu":"return false"});  
	$("body").keydown(function(){    
		if(event.keyCode == 116){
		     event.keyCode = 505;  
		     event.cancelBubblue = true;
		     event.returnValue=false;
		     return false;  
		 }
	});    
});*/  

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 검색 : jqgrid 방식
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function gridSearch(grid, requestUrl, queryParam) {	
	try {
		grid.closest(".ui-jqgrid-bdiv").scrollLeft(0);
		var pageNumber = grid.jqGrid("getGridParam", "page");
		grid.clearGridData();
		grid.setGridParam({
			postData : queryParam,
			datatype : 'json',
			url : requestUrl,
			mtype : 'post',
			page : pageNumber,
			loadonce : true
		// 데이타 로딩 후, jqgrid의 로컬데이타 검색과 헤더 정렬 기능 사용을 위해 true로 설정.
		});
		grid.trigger('reloadGrid');
	} catch (e) {
		alert(e.message);
	}
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* (공통) Json 데이터 처리 AJAX
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function getAjaxJsonData(requestUrl, queryParam){
	var ReturnParam = "";
	var QueryParam = "";
	if($.trim(requestUrl) != ""){
		if(requestUrl.indexOf(".") != -1){
			requestUrl = $.trim(requestUrl);
		}else{
			requestUrl = requestUrl + ".json";  
		}
		if($.trim(queryParam) != ""){
			QueryParam = queryParam;
		}else{
			QueryParam = "";
		}
		console.log(QueryParam); 
		$.ajax({
			url : requestUrl,
			data : QueryParam, 
			type : "POST",  
			async : false,
			success : function(data){
				console.log(data.code); 
				if(data.code == '001'){
					ReturnParam = data;
				/*}else if(data.code == '002'){
					alert("프로세스 처리에 관련된 에러입니다.\r\n관리자에게 문의하시기 바랍니다. [002]");	
				}else if(data.code == '003'){
					alert("프로세스 처리에 관련된 에러입니다.\r\n관리자에게 문의하시기 바랍니다. [003]");*/
				}else if(data.code == '015'){
					alert("세션정보가 없습니다.\r\n로그인 후 이용하시기 바랍니다. [015]");
				} else if (data.code == "same_code") {     
					alert("중복된 값입니다 [same_code]");
				}else{
					ReturnParam = data;
				}
			},
		    error:function(XMLHttpRequest,textStatus,errorThrown){
		    	alert("getAjaxJsonData error");
			}
		});
		return ReturnParam;
	}
}

function getAjaxProcData(requestUrl, queryParam){
	var ReturnParam = "";
	var QueryParam = "";
	if($.trim(requestUrl) != ""){
		if(requestUrl.indexOf(".") != -1){
			requestUrl = $.trim(requestUrl);
		}else{
			requestUrl = requestUrl + ".json";  
		}
		if($.trim(queryParam) != ""){
			QueryParam = queryParam;
		}else{
			QueryParam = "";
		}
		console.log(QueryParam); 
		$.ajax({
			url : requestUrl,
			data : QueryParam, 
			type : "POST",  
			async : false,
			success : function(data){
				console.log(data.code); 
				if(data.code == '001'){
					ReturnParam = data;
				/*}else if(data.code == '002'){
					alert("프로세스 처리에 관련된 에러입니다.\r\n관리자에게 문의하시기 바랍니다. [002]");   
				}else if(data.code == '003'){
					alert("프로세스 처리에 관련된 에러입니다.\r\n관리자에게 문의하시기 바랍니다. [003]");*/
				}else if(data.code == '015'){ 
					alert("세션정보가 없습니다.\r\n로그인 후 이용하시기 바랍니다. [015]");
				}else if(data.code == 'LOGIN_FAIL'){ 
					top.location.href = "/";	 				
				}else{
					ReturnParam = data;
				}
			},
		    error:function(XMLHttpRequest,textStatus,errorThrown){
		    	//alert("getAjaxProcData error");
			}
		});
		return ReturnParam;
	}
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 체크박스 전체 선택
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function AllCheckbox(name, bln) { 
    var obj = document.getElementsByName(name); 
    if(obj == null) return;

    var max = obj.length;
    if(max == null) {
        obj.checked = bln;
    }else {
        for(var i = 0; i < max; i++) {
            obj[i].checked = bln;
        }
    }
}

/*---------------------------
 * chosen-select script 
 *----------------------------*/
function getChosenScript(selectID, size){	
	$("#"+selectID).chosen({allow_single_deselect:true}); 
	//resize the chosen on window resize
			
	$(window)
	.off('resize.chosen')
	.on('resize.chosen', function() {
		$('.chosen-select').each(function() {
			if($.trim(size)==""){
				$("#"+selectID).next().css({'width': '100%'});
			}else
				$("#"+selectID).next().css({'width': size});
			//$this.parent().width()-130
		});
	}).trigger('resize.chosen');
}
	
/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 다중 Select CSS 초기화 처리
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function setSelectChosen(wsize) {
	if(wsize == "" || wsize == undefined) {wsize = "100";}
	
	$('.chosen-select').chosen({
		allow_single_deselect : true
	});
	// resize the chosen on window resize
	$(window).off('resize.chosen').on('resize.chosen', function() {
		$('.chosen-select').each(function() {
			var $this = $(this);
			$this.next().css({
				'width' : ''+wsize+'%'
			});
		});
	}).trigger('resize.chosen');
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 코드 선택 목록 가져오기 AJAX
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function getAjaxSelectCodeList(sysCode){  
	var requestUrl = "/ajax/selectCodeList.json";     
	var queryParam = "code_group_cd=" + sysCode;        
	console.log(queryParam); 
	var returnParam = "";
	$.ajax({
		url : requestUrl,
		data : queryParam, 
		type : "POST",  
		async : false,
		success : function(data){
			console.log(data.code); 
			console.log(data.getCodeInfoList);
			if(data.code == '001'){
				returnParam = data;
			}else if(data.code == '002'){ 
				
			}
		},
	    error:function(XMLHttpRequest,textStatus,errorThrown){
	    	alert("getAjaxSelectCodeList error");
		}
	});
	return returnParam; 
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 파일 다운로드 AJAX
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/ 
function fn_egov_downFile(atchFileId, fileSn){
	if (atchFileId.indexOf("SR_") > -1) {
		//ajax롤 atchFileId, fileSn 키값으로 정보를 조회 . => 1건이 반환
		// str_cours 정보가 /uplaod가 아니면
		// window.open(str_cours)
		// /upload이면 아래와 동일.
		var data = getAjaxJsonData("/ajax/getAtchFileInfs.json", "ATCH_FILE_ID=" + atchFileId+"&fileSn="+fileSn);
		if (data != null && data.fileInfoList != null && data.fileInfoList.length > 0) {
			var filePath = data.fileInfoList[0].fileStreCours;
			var fileCn = data.fileInfoList[0].fileCn;
			var rdmsUrl = data.rdmsUrl;
			var fileName = data.fileInfoList[0].streFileNm;
			
			if(fileCn=="LAS") {
				window.open(rdmsUrl+ filePath + "/" + fileName);
			}
			else {
				var url = "/common/fms/FileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn;
				window.open(url);
			}	
		}	
	} else {
		var url = "/common/fms/FileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn;
		window.open(url);
	}
}  

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 파일 확장자 체크해서 확장자에 맞는 이미지 불러오기
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/ 
function FileExtCheck(FileName){
	var ImageFileName = "";
	var EndFileName = FileName.substring(FileName.indexOf(".")+1, FileName.length);
	
	if(EndFileName.length > 0){
		var EndFileNameLCase =   EndFileName.toLowerCase();

		if(EndFileNameLCase == "doc" || EndFileNameLCase == "docx"){
			ImageFileName = "ico_word.gif";	
		}else if(EndFileNameLCase == "pptx" || EndFileNameLCase == "pptx"){
			ImageFileName = "ico_ppt.gif";
		}else if(EndFileNameLCase == "hwp"){
			ImageFileName = "ico_han.gif";
		}else if(EndFileNameLCase == "pdf"){
			ImageFileName = "ico_pdf.gif";
		}else if(EndFileNameLCase == "jpg" || EndFileNameLCase == "gif" || EndFileNameLCase == "pcx" || EndFileNameLCase == "bmp" || EndFileNameLCase == "png" || EndFileNameLCase == "psd"){
			ImageFileName = EndFileName + ".gif";
		}else if(EndFileNameLCase == "avi" || EndFileNameLCase == "wmv" || EndFileNameLCase == "mp4"){
			ImageFileName = "movie.gif";
		}else if(EndFileNameLCase == "txt"){
			ImageFileName = "txt.gif";
		}else if(EndFileNameLCase == "htm" || EndFileNameLCase == "html" || EndFileNameLCase == "cab" || EndFileNameLCase == "zip" || EndFileNameLCase == "mp3" || EndFileNameLCase == "wav"){
			ImageFileName = EndFileName  + ".gif";
		}else{
			ImageFileName = "clip.gif";   
		}
	}	
	ImageFileName = "/images/newlims/fileIcon/" + ImageFileName.toLowerCase();    
	return ImageFileName;
}
	
/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 플래시 문구 보여주기
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function flashText(text){ 
	var styleItem = "";
	styleItem += "font-size: 15px;";
	styleItem += "z-index:99999;";
	styleItem += "position: absolute;";
	styleItem += "top: 100px;";
	styleItem += "border: 1px solid #d4d4d4;";
	styleItem += "width: 400px;";
	styleItem += "height:50px;";
	styleItem += "border-radius: 5px;";
	styleItem += "line-height:50px;";
	styleItem += "text-align: center;";
	styleItem += "opacity: 0.8;";
	styleItem += "background: black;";
	styleItem += "color: white;";
	styleItem += "display:none;";
	
	$("#flashArea").remove();   
	var flashArea = '<div id="flashArea" style="' + styleItem +'"></div>';
	$("body").append(flashArea); 
	
	var cw = screen.availWidth;     //화면 넓이
	var ch = screen.availHeight;     //화면 높이 
	
	var ml = (cw - 400) / 2;        //가운데 띄우기위한 창의 x위치   
	var mt = (ch - 50) / 3;         //가운데 띄우기위한 창의 y위치   
	
	$('html, body').animate({ scrollTop: 0},800); // 페이지 상단으로 이동!   
	$('#flashArea').css("left",ml).css("top",mt);  
	$('#flashArea').text(text);  
	$('#flashArea').show();   
	setTimeout(function() {  
		$('#flashArea').fadeOut(1000);       				
	}, 500);                     
} 

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 파일 삭제 AJAX (이미지 파일일 경우) 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/ 
// 파라메터 설명 **************************************
// atchFileId 	: 파일ID
// fileSn 			: 파일 시퀀스
// DelImgId 		: Default 이미지로 대체할 img 객체의 ID
// DefaultImg 	: Default 이미지 경로 
// Object		: Object
function ajaxFileDelete(atchFileId, fileSn, DelImgId , DefaultImg, Object, df){
	if(!confirm('파일을 삭제 하시겠습니까?')) {   
		return;
	}
	var requestUrl = "/ajax/fileDelete.json";     
	var queryParam = "atchFileId=" + atchFileId + "&fileSn=" + fileSn;         
	console.log(queryParam);  
	$.ajax({
		url : requestUrl,
		data : queryParam, 
		type : "POST",  
		async : false,
		success : function(data){
			console.log(data.code); 
			if(data.code == '001'){
				$("#" + DelImgId).attr("src", DefaultImg);
				if(df == "Y") {
					$("#attach_file" + fileSn).parent().find(".ace-file-container").removeAttr("onclick");
				} else {
					$("#file" + fileSn).parent().find(".ace-file-container").removeAttr("onclick");
				}
				if($.trim(DelImgId) == "" && $.trim(DefaultImg) == ""){
					$(Object).parent().remove();
				}else{
					$(Object).remove();
				}  
			}else if(data.code == '002'){  
				
			}
		},
	    error:function(XMLHttpRequest,textStatus,errorThrown){
	    	alert("ajaxFileDelete error");
		}
	});
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 
* 파일 업로드 제한
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function uploadfile_check(f2){
	var str_dotlocation, str_ext, str_low;
	var str_value = f2;
	str_low = str_value.toLowerCase(str_value);
	str_dotlocation = str_low.lastIndexOf(".");
	str_ext = str_low.substring(str_dotlocation + 1);
	
	switch(str_ext.toLowerCase()) {
		case "gif" :
		case "jpg" :
		case "jpeg" :
		case "png" :
		case "bmp" :
		case "" :  
			
			return false;
			break;
		default:
			alert("파일 업로드의 형식은 gif, jpg, jpeg, png, bmp 으로 제한됩니다.");
			return true ;	
	}
}
	
/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 
* 이메일 체크
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function validateEmail(sEmail) {
	var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;

	if (filter.test(sEmail)) {
		return true;
	} else {
		return false;
	}
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 숫자인지 여부 판단
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function isNumber(s) {
	  s += ''; // 문자열로 변환
	  s = s.replace(/^\s*|\s*$/g, ''); // 좌우 공백 제거
	  if (s == '' || isNaN(s)) return false;
	  return true;
}
	
/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 숫자만 입력 가능 (IE에서 사용)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function NumObj(obj){
	if (event.keyCode >= 48 && event.keyCode <= 57) { //숫자키만 입력
		return true;
	} else {
		event.returnValue = false;
	}
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 숫자 + . 입력 가능 (IE에서 사용)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function NumObj2(obj){
	if (event.keyCode >= 48 && event.keyCode <= 57 || event.keyCode == 45 || event.keyCode == 46) { //숫자 + -(45) + . (46) 입력
		return true;
	} else {
		event.returnValue = false;
	}
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 숫자만 입력 가능
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function fnChkNumber(arg){
	var val;
	val = arg.value;
	
	for(var i = 0; i < val.length; i++){
		if (val.charAt(i)<'0' || val.charAt(i)>'9'){
			alert("숫자만 입력이 가능합니다.") ;
			arg.value="";
			return false;
		}
	}
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 숫자 + . 입력 가능
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function fnChkNumber2(arg){
	var val;
	val = arg.value;
	var PointCount = 0;
	var MinusCount = 0;
	
	for(var i = 0; i < val.length; i++){
		if (val.charAt(i) == '-') {MinusCount += 1;}
		else if (val.charAt(i) == '.') {PointCount += 1;}
		else if (val.charAt(i)<'0' || val.charAt(i)>'9'){
			alert("숫자만 입력이 가능합니다.") ;
			arg.value="";
			return false;
		}
		if(PointCount > 1) {
			alert("소수점(.)이 한 개 이상입니다.") ;
			arg.value="";
			return false;			
		}
		if(MinusCount > 1) {
			alert("음수(-)가 한 개 이상입니다.") ;
			arg.value="";
			return false;			
		}		
	}
	return true;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 영문자만 입력 가능
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function fncCheckEng() {
    var objEvent = event.srcElement;
    var numPattern =/^[A-Za-z]*$/;
    numPattern = objEvent.value.match(numPattern);
 
    if (numPattern == null) {   
        //alert("영문자만 입력할 수 있습니다.");
        //objEvent.value = "";  
        objEvent.value = objEvent.value.substr(0, objEvent.value.length - 1);
        objEvent.focus();
        return false;
    }
} 

//━━━━━━━━━━━━━━━━━━━━━━━
// 브라우저 유형 체크 
//───────────────────────
var Browser = {
	a : navigator.userAgent.toLowerCase()
};

Browser = {
	id : /*@cc_on true || @*/ false,
	ie6 : Browser.a.indexOf('msie 6') != -1,
	ie7 : Browser.a.indexOf('msie 7') != -1,
	ie8 : Browser.a.indexOf('msie 8') != -1,
	ie9 : Browser.a.indexOf('msie 9') != -1,
	ie10 : Browser.a.indexOf('msie 10') != -1,
	opera : !!window.opera,
	safari : Browser.a.indexOf('safari') != -1,
	safari3 : Browser.a.indexOf('applewebkit/5') != -1,
	mac : Browser.a.indexOf('mac') != -1,
	chrome : Browser.a.indexOf('chrome') != -1,
	firefox : Browser.a.indexOf('firefox') != -1
};

function whatKindOfBrowser(){
	if(Browser.chrome){
		return "Chrome";
	}else if(Browser.ie6){
		return "IE 6";
	}else if(Browser.ie7){
		return "IE 7";
	}else if(Browser.ie8){
		return "IE 8";
	}else if(Browser.ie9){
		return "IE 9";
	}else if(Browser.ie10){
		return "IE 10";
	}else if(Browser.opera){
		return "Opera";
	}else if(Browser.safari){
		return "Safari";
	}else if(Browser.safari3){
		return "Safari3";
	}else if(Browser.mac){
		return "Mac";	
	}else if(Browser.firefox){
		return "Firefox";
	}else{
	
	}
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 엔터 시 검색
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function searchEnter(evt) {
	var evtCode = (window.netscape) ? evt.which : event.keyCode;
	if(evtCode == 13) {
		return true; 
	} else {
		return false; 
	}
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 날짜 체크
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function jsCheckDate(dateVal)
{
     var isDate  = true ;
     if ( dateVal.length != 8 )
     {
          isDate = false ;
     }
     else
     {
           var yy = dateVal.substring(0,4) +"" ;
           var mm = dateVal.substring(4,6) +"" ;
           var dd = dateVal.substring(6,8) +"" ;

           if ( !jsCheckYYYY(yy) )
              isDate = false ;
           else if ( !jsCheckMM(mm) )
              isDate = false ;
           else if ( !jsCheckDD (yy,mm,dd) )
              isDate = false ;
     }
     return isDate ;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 날짜 - 년도 체크
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function jsCheckYYYY(toCheck)
{
   return ( ( toCheck.length == 4) && ( jsCheckNumber(toCheck)  ) && ( toCheck != "0000") );
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 날짜 - 월 체크
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function jsCheckMM(toCheck)
{
      return ((toCheck.length > 0) && (jsCheckNumber(toCheck)) && (0< eval(toCheck)) && (eval(toCheck) < 13));
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 날짜 - 일 체크
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function jsCheckDD(yyyy,mm,toCheck)
{
      var isYMD  = false;
      var monthDD= new jsMonthArray(31,28,31,30,31,30,31,31,30,31,30,31);
      var im     = eval(mm) - 1;
      if ( toCheck.length == 0 )  return false;
      if ( !jsCheckNumber(toCheck)  )  return false;
      var dd     = eval(toCheck);
      if ( ( (yyyy%4 == 0) && (yyyy%100 != 0) ) || (yyyy%400 == 0) )
      {
           monthDD[1] = 29;
      }
      if ( (0 < dd) && (dd <= monthDD[im]) ) isYMD = true;
           return isYMD;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 숫자 여부 체크
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function jsCheckNumber(toCheck)
{
     var chkstr = toCheck+"" ;
     var isNum = true ;

     if ( jsCheckNull(toCheck) )
          return false;

     for (var j = 0 ; isNum && (j < toCheck.length) ; j++)
     {
          if ((toCheck.substring(j,j+1) < "0") || (toCheck.substring(j,j+1) > "9"))
          {
             if ( toCheck.substring(j,j+1) == "-" || toCheck.substring(j,j+1) == "+")
             {
                if ( j != 0 )
                {
                   isNum = false;
                }
             }
             else
       isNum = false;
     }
     }

     if (chkstr == "+" || chkstr == "-") isNum = false;

     return isNum;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Null 체크
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function jsCheckNull( toCheck )
{
     var chkstr = toCheck + "";
     var is_Space = true ;

     if ( ( chkstr == "") || ( chkstr == null ) )
    return( true );

     for (var  j = 0 ; is_Space && ( j < chkstr.length ) ; j++)
     {
      if( chkstr.substring( j , j+1 ) != " " )
         {
        is_Space = false ;
         }
     }
     return ( is_Space );
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* calender에서 사용할 월별 배열
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function jsMonthArray(m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11)
{
      this[0] = m0;
      this[1] = m1;
      this[2] = m2;
      this[3] = m3;
      this[4] = m4;
      this[5] = m5;
      this[6] = m6;
      this[7] = m7;
      this[8] = m8;
      this[9] = m9;
      this[10] = m10;
      this[11] = m11;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* TextArea Byte수 제한하기 자바 스크립트
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
var UIControls = {}; 
UIControls.RestrainString = {
	excute:function(sender, limitByte, viewText){
		var stringValue = sender.value;
		var _byteSize = 0;
		var _charByteSize = 0;
		for(var i=0; i<stringValue.length; i++){  
			_charByteSize = this.getCharByteSize(stringValue.charAt(i));
			_byteSize += _charByteSize;
			if(_byteSize > limitByte){
				if($.trim(viewText) != ""){
					alert(viewText + " " + limitByte + "byte 까지 입력하실 수 있습니다.");	
				}else{
					alert(limitByte + "byte 까지 입력하실 수 있습니다.");
				}
			    _byteSize -= _charByteSize;
			    sender.value = stringValue.substring(0, i);
			    break;
			}
		}
	},
	getCharByteSize: function(char){
		if(!char) return 0;
		
		var charCode = char.charCodeAt(0);
		
		if(charCode <= 0x00007F) return 1;
		if(charCode <= 0x0007FF) return 2;
		if(charCode <= 0x00FFFF) return 3;
		else return 4;
	}
};

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 문자열 길이를 바이트값으로 나타내기
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function strByteView(strId,viewId){  
	var stringValue = $("#"+strId).val();
	var _charByteSize = 0;
	for(var i=0; i<stringValue.length; i++){  
		var str = stringValue.charAt(i);
		if(escape(str).length > 4){
			_charByteSize	+= 2;
		}else{
			_charByteSize++;
		}
	}
	$("#"+viewId).text(_charByteSize);
}


/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 한글입력 방지
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function fn_press_han(obj) {
    //좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
    if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 
    || event.keyCode == 46 ) return;
    obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');     
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 특정 문자열 확인 1
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function isUpAlpha(input) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return containsCharsOnly(input,chars);
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 특정 문자열 확인 2 >> 입력값이 특정 문자(chars)만으로 되어있는지 체크
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function containsCharsOnly(input,chars) {
  for (var inx = 0; inx < input.length; inx++) {
     if (chars.indexOf(input.charAt(inx)) == -1)
         return false;
  }
  return true;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 숫자만 입력 받기 (2014-12-12)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function onlyNumber(e){  
    var event = e || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        return false;
}
function removeChar(e) {
    var event = e || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        event.target.value = event.target.value.replace(/[^0-9]/g, "");
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 한 달 전 날짜 가져오기
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function oneMonthDateSet(){
	var current_date = new Date();
	var theYear = current_date.getFullYear();
	var theMonth = current_date.getMonth() + 1; // 0 (1월) ~ 11 (12월) >> + 1 월
	var theDate = current_date.getDate();
	var final_current_date = "";
	
	theMonth = theMonth < 10? "0" + theMonth: theMonth;
	theDate = theDate < 10? "0" + theDate: theDate;
	
	final_current_date = theYear+"-"+theMonth+"-"+theDate;

	return final_current_date;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 오늘 날짜 가져오기
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function currentDateSet(){
	var current_date = new Date();
	var theYear = current_date.getFullYear();
	var theMonth = current_date.getMonth() + 1; // 0 (1월) ~ 11 (12월) >> + 1 월
	var theDate = current_date.getDate();
	var final_current_date = "";
	
	theMonth = theMonth < 10? "0" + theMonth: theMonth;
	theDate = theDate < 10? "0" + theDate: theDate;
	
	final_current_date = theYear+"-"+theMonth+"-"+theDate;

	return final_current_date;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 날짜에 월수를 더한다.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function jsAddMonths(startDt, plusMonth) {
	var rtnValue = -1;
	startDt = replaceAll(startDt,"-","");
	if (!jsCheckDate(startDt) || !jsCheckNumber(plusMonth)) {
		rtnValue = -1;
		return rtnValue;
	}
	var yyyy = startDt.substring(0, 4) + "";
	var mm = startDt.substring(4, 6) + "";
	var dd = startDt.substring(6, 8) + "";
	var newMm = null;
	if ((eval(mm) + eval(plusMonth)) == 0) {
		yyyy = eval(yyyy) - 1;
		newMm = 12 + eval(mm) + eval(plusMonth);
	} else if ((eval(mm) + eval(plusMonth)) > 12) {
		yyyy = eval(yyyy) + 1;
		newMm = eval(mm) + eval(plusMonth) - 12;
	} else {
		newMm = eval(mm) + eval(plusMonth);
	}
	var isYoonYear = false;
	if ((eval(yyyy) % 4) == 0)
		isYoonYear = true;
	if ((eval(yyyy) % 100) == 0)
		isYoonYear = false;
	if ((eval(yyyy) % 400) == 0)
		isYoonYear = true;
	if (isYoonYear) {
		if ((newMm == '02') && (dd == '30' || dd == '31')) {dd = '29';}			
	} else {
		if ((newMm == '02') && (dd == '29' || dd == '30' || dd == '31')) {dd = '28';}			
	}
	if (eval(newMm) < 10) {newMm = "0" + newMm;}
	rtnValue = yyyy + "-" + newMm + "-" + dd;
	return rtnValue;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* replaceAll
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function replaceAll(content,before,after){
    return content.split(before).join(after);
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 문자열 길이를 바이트 값 반환 1
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function strByteCheck(Object){  
	var stringValue = $(Object).val();
	var _charByteSize = 0;
	for(var i=0; i<stringValue.length; i++){  
		var str = stringValue.charAt(i);
		if(escape(str).length > 4){
			_charByteSize	+= 2;
		}else{
			_charByteSize++;
		}
	}
	return _charByteSize;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 문자열 길이를 바이트 값 반환 2
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function getByteLength(s){
	var len = 0;
	if ( s == null ) return 0;
	for(var i=0;i<s.length;i++){
		var c = escape(s.charAt(i));
		if ( c.length == 1 ) len ++;
		else if ( c.indexOf("%u") != -1 ) len += 2;
		else if ( c.indexOf("%") != -1 ) len += c.length/3;
	}
	return len;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 초과한 바이트에 해당하는 문자열 정리 함수 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function assert_msglen(message, maximum)
{
	var inc = 0;
	var nbytes = 0;
	var msg = "";
	var msglen = message.length;

	for (var i=0; i<msglen; i++) {
		var ch = message.charAt(i);
		if (escape(ch).length > 4) {
			inc = 2;
		} else if (ch == '\n') {
			if (message.charAt(i-1) != '\r') {
				inc = 1;
			}
		} else if (ch == '<' || ch == '>') {
			inc = 4;
		} else {
			inc = 1;
		}
		if ((nbytes + inc) > maximum) {
			break;
		}
		nbytes += inc;
		msg += ch;
	}
	return msg;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 벨리데이션 체크
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
//if(!CmnValChk("user_id", "출장자를 선택해 주세요.", "checkbox")){ return;}
function CmnValChk(id, alertText, type){ // 벨리데이션 체크
	switch ($.trim(type.toLowerCase())) {      
		case "text": case "selectbox": case "textarea":
			if($("#" + id).val() == null || $.trim($("#" + id).val()) == "" || $.type($("#" + id).val()) === "undefined"){
				alert(alertText);
				$("#" + id).focus();
				return false;
			}
			break;
		case "radio": case "checkbox":      
			var checkedCount = 0;
			$("input[id ^= '" + id +"']").each(function(){
				if($(this).is(":checked")){
					checkedCount++;
				}
			});
			if(checkedCount <= 0){      
				alert(alertText);   
				$("input[id ^= '" + id +"']").first().focus();
				return false;
			}
			break;
		default: 
			return false;   
			break;
	}  
	return true;	
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 사용하는 코드 선택 목록 가져오기 AJAX
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function getAjaxCodeUseList(codeGroupCd){  
	var requestUrl = "/ajax/codeUseList.json";     
	var queryParam = "w_code_group_cd=" + codeGroupCd;        
	console.log(queryParam); 
	var returnParam = "";
	$.ajax({
		url : requestUrl,
		data : queryParam, 
		type : "POST",  
		async : false,
		success : function(data){
			console.log(data.code); 
			console.log(data.getAjaxDataList);
			if(data.code == '001'){
				returnParam = data;
			}else if(data.code == '002'){ 
				
			}
		},
	    error:function(XMLHttpRequest,textStatus,errorThrown){
	    	alert("getAjaxCodeUseList error");
		}
	});
	return returnParam; 
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 사용하는 코드 선택 목록 가져오기 AJAX + CODE_ATTR1
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function getAjaxCodeUseList2(codeGroupCd, codeAttr1){  
	var requestUrl = "/ajax/codeUseList.json";     
	var queryParam = "w_code_group_cd=" + codeGroupCd + "&w_code_attr1=" + codeAttr1;        
	console.log(queryParam); 
	var returnParam = "";
	$.ajax({
		url : requestUrl,
		data : queryParam, 
		type : "POST",  
		async : false,
		success : function(data){
			console.log(data.code); 
			console.log(data.getAjaxDataList);
			if(data.code == '001'){
				returnParam = data;
			}else if(data.code == '002'){ 
				
			}
		},
	    error:function(XMLHttpRequest,textStatus,errorThrown){
	    	alert("getAjaxCodeUseList error");
		}
	});
	return returnParam; 
}

/**
 * Chosen 컨트롤에 COMM_CODE 데이터를 채움. 
 * @param obj : 데이터를 채울 컨트롤
 * @param codeGroup : 코드의 그룹코드
 * @param isAllDisplay : 전체를 표시할지 여부
 * @param EqVal : 값을 선택할 경우 선택할 값
 */
function setChosenCodeList(obj, codeGroup, isAllDisplay, EqVal) {
	var data = getAjaxCodeUseList(codeGroup);	
	FillChooseList(obj, data, data.getAjaxDataList, "COMM_CD", "COMM_NAME", true, EqVal);
}
// CODE_ATTR1 추가
function setChosenCodeList2(obj, codeGroup, codeAttr1, isAllDisplay, EqVal) {
	var data = getAjaxCodeUseList2(codeGroup, codeAttr1);	
	FillChooseList(obj, data, data.getAjaxDataList, "COMM_CD", "COMM_NAME", true, EqVal);
}

/**
 * 컨트롤에 요청한 테이블 정보의 데이터를 채움.
 * @param obj  : 데이터를 채울 컨트롤
 * @param requestUrl : 요청할 정보의 URL
 * @param queryParam : 요청할 정보의 조건
 * @param codeVal : 요청한 정보의 키코드컬럼
 * @param nameVal : 요청한 정보의 표시명컬럼
 * @param isAllDisplay : 전체를 표시할지 여부
 * @param EqVal : 값을 선택할 경우 선택할 값
 */
function setChosenList(obj, requestUrl, queryParam, codeVal, nameVal, isAllDisplay, EqVal, retObjList) {
	
	/**
	 * [example]
	 * setChosenList($("s_smp_class_id"), "/ajax/smpClassList.json", "", "SMP_CLASS_ID", "SMP_CLASS_NAME", true, "");
	 * setChosenList($("s_smp_class_id"), "/ajax/smpGroupList.json", "smp_class_id=" + $("#s_smp_class_id").val(), "SMP_GROUP_ID", "SMP_GROUP_NAME", true, "");
	 * 
	 * 업태 : setChosenList($("#search_comp_type_id"), "/ajax/compTypeList.json", "", "COMP_TYPE_ID", "COMP_TYPE_NAME", true, "");
	 * 지역 : setChosenList($("#search_company_region_id"), "/ajax/regionInfoList.json", "", "REGION_ID", "REGION_NAME", true, regionId);
	 * 시군구
	 * if(regionId != "") {
						setChosenList($("#search_company_city_id"),  "/ajax/cityInfoList.json", "region_id=" + regionId, "CITY_ID", "CITY_NAME", true, "");
					}					
	 */
	
	$.ajax({
		url : requestUrl,
		data : queryParam, 
		type : "POST",  
		async : false,
		success : function(data){
			if(data.code == '001'){
				if(retObjList != null) {
					FillChooseList(obj, data, eval("data."+retObjList), codeVal, nameVal, isAllDisplay, EqVal);
				}
				else {
					FillChooseList(obj, data, data.list, codeVal, nameVal, isAllDisplay, EqVal);
				}				
			}else if(data.code == '002'){ 	
				alert('002 error occurred!');
			}
		},
	    error:function(XMLHttpRequest,textStatus,errorThrown){
	    	alert("setChosenList error : ");
		}
	});
}

/**
 * CHOSEN 컨트롤에 데이터 채우기.
 * @param obj
 * @param data
 * @param codeVal
 * @param nameVal
 * @param isAllDisplay
 * @param EqVal
 */
function FillChooseList(obj, data, list, codeVal, nameVal, isAllDisplay, EqVal) {
	var setData = "";
	
	if(data != null && list != null && list.length > 0){
		for (var z = 0; z < list.length; z++) {
			var optionVal = "";
			var optionNm = "";
			
			if(z == 0 && isAllDisplay){ 
				setData += '<option value="">전체</option>'; 
			}
			
			optionVal = list[z][codeVal]; 
			optionNm = list[z][nameVal];
			
			if(EqVal != "" && EqVal == optionVal) {
				setData += '<option value="' + optionVal + '" selected>' + optionNm + '</option>';
			} else {
				setData += '<option value="' + optionVal + '">' + optionNm + '</option>';
			}
		}
	}else{
		setData += '<option value="">데이터가 없습니다</option>'; 
	} 				
	obj.empty();     
	obj.append(setData);
	obj.trigger("chosen:updated");
}

function FillChoosenClear(obj, isAllDisplay) {
	var setData = "";
	if(isAllDisplay){ 
		setData += '<option value="">전체</option>'; 
	} 
	else {
		setData += '<option value="">데이터가 없습니다</option>';
	}
	obj.empty();     
	obj.append(setData);
	obj.trigger("chosen:updated");	
}

function FillSelectClear(obj, isAllDisplay) {
	var setData = "";
	if(isAllDisplay){ 
		setData += '<option value="">전체</option>'; 
	} 
	else {
		setData += '<option value="">데이터가 없습니다</option>';
	}
	obj.empty();     
	obj.append(setData);	
}

function setSelectList(obj, requestUrl, queryParam, codeVal, nameVal, isAllDisplay, EqVal, retObjList) {

	$.ajax({
		url : requestUrl,
		data : queryParam, 
		type : "POST",  
		async : false,
		success : function(data){
			if(data.code == '001'){
				if(retObjList != null) {
					FillSelectList(obj, data, eval("data."+retObjList), codeVal, nameVal, isAllDisplay, EqVal);
				}
				else {
					FillSelectList(obj, data, data.list, codeVal, nameVal, isAllDisplay, EqVal);
				}				
			}else if(data.code == '002'){ 	
				alert('002 error occurred!');
			}
		},
	    error:function(XMLHttpRequest,textStatus,errorThrown){
	    	alert("setSelectList error : ");
		}
	});
}

function FillSelectList(obj, data, list, codeVal, nameVal, isAllDisplay, EqVal) {
	var setData = "";
	if(data != null && list != null && list.length > 0){
		for (var z = 0; z < list.length; z++) {
			var optionVal = "";
			var optionNm = "";
			
			if(z == 0 && isAllDisplay){ 
				setData += '<option value="">전체</option>'; 
			}
			
			optionVal = list[z][codeVal]; 
			optionNm = list[z][nameVal];
			
			if(EqVal != "" && EqVal == optionVal) {
				setData += '<option value="' + optionVal + '" selected>' + optionNm + '</option>';
			} else {
				setData += '<option value="' + optionVal + '">' + optionNm + '</option>';
			}
		}
	}else{
		setData += '<option value="">전체</option>'; 
	} 				
	obj.empty();     
	obj.append(setData);
}


function setSelectCodeList(obj, codeGroup, isAllDisplay, EqVal) {
	var data = getAjaxCodeUseList(codeGroup);	
	FillSelectList(obj, data, data.getAjaxDataList, "COMM_CD", "COMM_NAME", true, EqVal);
}


/**
 * function : isValidDateTime
 * @param dt : yyyy-mm-dd hh24:mi 형식의 날짜 문자열
 * @returns 날짜가 유효한 값인지 여부를 전달
 */
function isValidDateTime(dt) {	
	/* dt : 2015-01-01 13:15 */
	var r = /^((((19|[2-9]\d)\d{2})[\/\.-](0[13578]|1[02])[\/\.-](0[1-9]|[12]\d|3[01])\s(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9]))|(((19|[2-9]\d)\d{2})[\/\.-](0[13456789]|1[012])[\/\.-](0[1-9]|[12]\d|30)\s(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9]))|(((19|[2-9]\d)\d{2})[\/\.-](02)[\/\.-](0[1-9]|1\d|2[0-8])\s(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))[\/\.-](02)[\/\.-](29)\s(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])))$/g;	
	return r.test(dt);
}

function addComma(ivalue) {
	var input = String(ivalue);
	var output = "";

	for (var i = input.length; i >= 0; i--) {
		if ((input.length - i) % 3 == 1 && output.length != 0 && input.charAt(i) != "-") {
			output = "," + output;
		}
		output = input.charAt(i) + output;
	}

	return output;
}


/**
 * object to string function 
 * @param o
 * @returns {String}
 */
function objectToString(o) {

     var parse = function(_o) {

          var a = [], t;

          for (var p in _o) {

               if (_o.hasOwnProperty(p)) {

                    t = _o[p];

                    if (t && typeof t == "object") {

                         a[a.length] = p + ":{ " + arguments.callee(t).join(", ") + "}";

                    }

                    else {

                         if (typeof t == "string") {

                              a[a.length] = [ p + ": \"" + t.toString() + "\"" ];

                         }

                         else {

                              a[a.length] = [ p + ": " + t.toString()];

                         }

                    }

               }

          }

          return a;

     };

     return "{" + parse(o).join(", ") + "}";

}


function goBlank() {
	return;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 정규식 전화번호 형식 변경
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function phoneFormat(num){  
	return num.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, "$1-$2-$3");
}

//------------------------------------------------------------------
//월, 시간등의 값을 표시할때 09처럼 두자리로 맞춰줌.
//------------------------------------------------------------------
function Add0(param) {
	 var ret;
	 if (parseInt(param) < 10) {
	     ret = "0" + param;
	 }
	 else {
	     ret = param;
	 }
	 return ret;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 자바스크립트 - Mid
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function Mid(str, start, len) {
	if (start < 0 || len < 0) return "";
	var iEnd, iLen = String(str).length;
	if (start + len > iLen) {iEnd = iLen;}
	else {iEnd = start + len;}
	return String(str).substring(start,iEnd);
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 자바스크립트 - InStr
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function InStr(strSearch, charSearchFor) {
	for (var i = 0; i < strSearch.length; i++) {
		if (charSearchFor == Mid(strSearch, i, 1)) {
			return i;
		}
	}
	return -1;
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 검사정보 - 제품 변경 시 시료량 변경
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function checkSmpQty(){
	if($("#smp_master_id").val() != "") {
		var smp_master_text = $("#smp_master_id option:selected").text();
		var start_text = InStr(smp_master_text, "(") + 1;
		var end_text = InStr(smp_master_text, ")");
		var check_text = smp_master_text.substring(start_text, end_text);

		if(check_text == "휘발유") {
			$("#smp_qty").val("1.5");
		} else {
			$("#smp_qty").val("1.0");
		}
	}	
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* 자바스크립트 round
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function roundView(n, digits) {
	if (digits >= 0) return parseFloat(n.toFixed(digits)); // 소수부 반올림

	digits = Math.pow(10, digits); // 정수부 반올림
	var t = Math.round(n * digits) / digits;

	return parseFloat(t.toFixed(0));
}

/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* loading image
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/
function setLoading(PT) {
	
	$("#loading_view").css("left", "50%");
	$("#loading_view").css("top", "50%");
	
	if(PT == "SHOW") {
		$("#loading_view").show();		
	} else if(PT == "HIDE") {
		$("#loading_view").hide();
	}
}

var scriptCmmUtil = {
		/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
		* 날짜 계산
		━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/ 
		getSysDate : function(delimiter){ //현재날짜  
			var sysDate = "";
			var newDt = new Date();
			if($.trim(delimiter) != ""){
				sysDate = scriptCmmUtil.converDateString(newDt, delimiter);
			}else{
				sysDate = newDt.getFullYear() + scriptCmmUtil.addZero(eval(newDt.getMonth()+1)) + scriptCmmUtil.addZero(newDt.getDate());
			}
			return sysDate;   
		},
		getDtBefore : function(s, i, delimiter){ //몇일 전
			var newDt = new Date(s); //0000-00-00
			newDt.setDate( newDt.getDate() - i );
			return scriptCmmUtil.converDateString(newDt, delimiter);
		},
		getDtAfter : function(s, i, delimiter){ //몇일 후 
			var newDt = new Date(s); //0000-00-00
			newDt.setDate( newDt.getDate() + i );
			return scriptCmmUtil.converDateString(newDt, delimiter);    
		},
		getDtMonthBefore : function(s, i, delimiter){ //몇달 전
			var newDt = new Date(s); //0000-00-00
			newDt.setMonth(newDt.getMonth() - i);   
			return scriptCmmUtil.converDateString(newDt, delimiter);
		},
		getDtMonthAfter : function(s, i, delimiter){ //몇달 후
			var newDt = new Date(s); //0000-00-00
			newDt.setMonth(newDt.getMonth() + i);
			return scriptCmmUtil.converDateString(newDt, delimiter);  
		},
		converDateString : function(dt, delimiter){ 
			return dt.getFullYear() + delimiter + scriptCmmUtil.addZero(eval(dt.getMonth()+1)) + delimiter + scriptCmmUtil.addZero(dt.getDate());   
		},
		addZero : function(i){
			var rtn = i + 100;
			return rtn.toString().substring(1,3);  
		},
		parseISO8601 : function(dateStringInRange){ //IE8에서 NaN 깨짐 현상에 대비하여 사용
			var isoExp = /^\s*(\d{4})-(\d\d)-(\d\d)\s*$/,
				date = new Date(NaN), month,
				parts = isoExp.exec(dateStringInRange);

			if(parts) {
				month = +parts[2];
				date.setFullYear(parts[1], month - 1, parts[3]);
				if(month != date.getMonth() + 1) {
					date.setTime(NaN);
				}
			}
			return date;
		}
	};

/**
 * 문자열을  UTF-8로 변경
 * @param szInput
 * @returns {String}
 */
function toUTF(szInput) {
	var wch, x, uch = "", szRet = "";
	for (x = 0; x < szInput.length; x++) {
		wch = szInput.charCodeAt(x);
		if (!(wch & 0xFF80)) {
			szRet += "%" + wch.toString(16);
		}
		else if (!(wch & 0xF800)) {
			uch = "%" + (wch >> 6 | 0xC0).toString(16) +
      "%" + (wch & 0x3F | 0x80).toString(16);
			szRet += uch;
		}
		else {
			uch = "%" + (wch >> 12 | 0xE0).toString(16) +
      "%" + (((wch >> 6) & 0x3F) | 0x80).toString(16) +
      "%" + (wch & 0x3F | 0x80).toString(16);
			szRet += uch;
		}
	}
	return (szRet);
}



function js_yyyy_mm_dd_hh_mm_ss () {
	  now = new Date();
	  year = "" + now.getFullYear();
	  month = "" + (now.getMonth() + 1); if (month.length == 1) { month = "0" + month; }
	  day = "" + now.getDate(); if (day.length == 1) { day = "0" + day; }
	  hour = "" + now.getHours(); if (hour.length == 1) { hour = "0" + hour; }
	  minute = "" + now.getMinutes(); if (minute.length == 1) { minute = "0" + minute; }
	  second = "" + now.getSeconds(); if (second.length == 1) { second = "0" + second; }
	  return year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
}


/**
 * 문자열을  window.open으로 화면중앙에 화면을 연다.
 * @param sw : 지정된 넓이
 * @returns {String}
 */
function openFileCenter(url, sw, istoolbar, ismenubar, isscrollbar, isresizable) {
	sw = (sw == null ? 800 : sw);
	var sh  = screen.availHeight -50;
	px=(screen.availWidth-sw)/2;
	py=(screen.availHeight-sh)/2;
	
	var opts = "left=" +px+", top="+py+",width=" +sw+", height="+sh;
	opts += ", toolbar="+(istoolbar==null?"no":istoolbar)+", menubar="+(ismenubar==null?"no":ismenubar);
	opts += ", scrollbars="+(isscrollbar==null?"yes":isscrollbar)+", resizable="+(isresizable==null?"yes":isresizable);
	
	window.open(url, "_new", opts);
}

/**
 * 저장, 수정, 삭제등의 ajax 처리후 오류 메시지를 받아 처리함.
 * 컨트롤러에서 오류 메시지를 주어야 함.
 * @param data
 */
function onAjaxErrorCode(data) {
	if(data.code == '002'){ 
		alert("[처리 실패!] 데이터 처리시 오류가 발생했습니다.");return;		
	}else if(data.code == '007'){ 
		alert("[처리 실패!]\n\n[세션정보] 값이 없습니다.");
		top.location.href = "/";
		return;
	}else if(data.code == 'LOGIN_FAIL'){				
		alert("[처리 실패!]\n\n[로그인 인증] 값이 없습니다.");
		top.location.href = "/";
		return;
	}else if(data.code == 'UPDATE_FAIL'){				
		alert("[처리 실패!]\n\n[수정]이 불가능한 상태입니다.");return;
	}
	else {
		alert(data.code);
	}
}


function onAjaxErrorCodeReturn(data) {
	if(data.code == '002'){ 
		alert("[처리 실패!] 데이터 처리시 오류가 발생했습니다.");
		return false;		
	}else if(data.code == '007'){ 
		alert("[처리 실패!]\n\n[세션정보] 값이 없습니다.");
		top.location.href = "/";
		return false;
	}else if(data.code == 'LOGIN_FAIL'){				
		alert("[처리 실패!]\n\n[로그인 인증] 값이 없습니다.");
		top.location.href = "/";
		return false;
	}else if(data.code == 'UPDATE_FAIL'){				
		alert("[처리 실패!]\n\n[수정]이 불가능한 상태입니다.");
		return false;
	}
	else {
		return true;
	}
}

/**
 * 입력상하한값을 체크하여 값을 제한한다.
 * @param val
 * @param min
 * @param max
 */
function feasSpecCheck(val, min, max) {
	
	if((min != null && min != "") && (max != null && max != "")) {
		if((parseFloat(val) >= parseFloat(min)) && (parseFloat(val) <= parseFloat(max))) {
			return true;
		} 
		else {
			return false;
		}
	}
	else if((min != null && min != "") && (max == null || max == "")) {
		if(parseFloat(val) >= parseFloat(min)) {
			return true;
		} 
		else {
			return false;
		}
	}
	else if((min == null || min == "") && (max != null && max != "")) {
		if(parseFloat(val) <= parseFloat(max)) {
			return true;
		} 
		else {
			return false;
		}
	}
	
	return true;
}


function checkSpec(objVal, spec_type, spec_low, spec_high, spec_sel, result_type) {
	var offFlag = "N";
	
	//alert(objVal + "###" + spec_type + "###" + spec_low + "###" + spec_high + "###" + spec_sel + "###" + result_type);
	
	if(result_type == "RTN") {
		if(spec_type == "STR") {// 범위(이상이하)
			if(spec_low != "" && spec_high != "") {
				offFlag = ((parseFloat(objVal) < parseFloat(spec_low)) || (parseFloat(spec_high) < parseFloat(objVal)) ? "Y":"N");
			}
		}else if(spec_type == "STB") {// 범위(초과미만)
			if(spec_low != "" && spec_high != "") {
				offFlag = ((parseFloat(objVal) <= parseFloat(spec_low)) || (parseFloat(spec_high) <= parseFloat(objVal)) ? "Y":"N");
			}
		}else if(spec_type == "STE") {// 범위(초과이하)
			if(spec_low != "" && spec_high != "") {
				offFlag = ((parseFloat(objVal) <= parseFloat(spec_low)) || (parseFloat(spec_high) < parseFloat(objVal)) ? "Y":"N");
			}
		}else if(spec_type == "STT") {// 범위(이상미만)
			if(spec_low != "" && spec_high != "") {
				offFlag = ((parseFloat(objVal) < parseFloat(spec_low)) || (parseFloat(spec_high) <= parseFloat(objVal)) ? "Y":"N");
			}
		}else if(spec_type == "STH") {// 하한이상
			if(spec_low != "") {
				offFlag = (parseFloat(objVal) >= parseFloat(spec_low) ? "N" : "Y");
			}
		}else if(spec_type == "STX") {// 하한초과
			if(spec_low != "") {
				offFlag = (parseFloat(objVal) > parseFloat(spec_low) ? "N" : "Y");
			}
		}else if(spec_type == "STU") {// 상한미만
			if(spec_high != "") {
				offFlag = (parseFloat(objVal) < parseFloat(spec_high) ? "N" : "Y");
			}
		}else if(spec_type == "STL") {// 상한이하
			if(spec_high != "") {
				offFlag = (parseFloat(objVal) <= parseFloat(spec_high) ? "N" : "Y");
			}
		}		
	}
	else if(result_type == "RTS") {
		if(spec_sel != "" && (spec_sel != objVal)) {
			offFlag = "Y";
		}
	}
	
	return offFlag;
}



function setCookie(name, value){ 
	 deleteCookie(name);	
	 
	 
	 var today = new Date();
	 today.setDate( today.getDate() + 1 );
	 document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + today.toGMTString() + ";";
}

function deleteCookie( cookieName )
{
	var expireDate = new Date(); 
	//어제 날짜를 쿠키 소멸 날짜로 설정한다.
	expireDate.setDate( expireDate.getDate() - 100 );
	document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + "; path=/";
}


function getCookie(c_name)
{
	 var i,x,y,ARRcookies=document.cookie.split(";");
	 for (i=0;i<ARRcookies.length;i++) {
		 x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		 y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		 x=x.replace(/^\s+|\s+$/g,"");
		 if (x==c_name) {
			 return unescape(y);
		 }
	  }
}


/**
 * 정규식을 이용하여 년월을 체크
 * @param yyyymm
 * @returns {Boolean}
 */
function yearMonValidation( yyyymm ){
    //정규식을 사용하여 년월 체크   
    var pYearMm = /^[\d]{4}(0[1-9]|1[0-2])$/;
      
 
    //년월 입력 형식을 정규식 패턴을 이용하여 체크
     if( pYearMm.test(yyyymm) ){
         return false; 
     }else{
         return true;
     }
 } 