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
        //var year = parseInt(date.getTime()/1000/60/60/24/365)+1970; 
    	var year = date.getFullYear();
        
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
    			$("#"+varSelId).get(0).options[0] = new Option("::전체::","");
    		}
    		$("#"+varSelId).get(0).length = 1;
    		oIdx = 1;
    	}else{
    		$("#"+varSelId).get(0).length = 0;
    		oIdx = 0;
    	}

    	//option 채우기
    	for(var i = 2007; i < (parseInt(year)+1); i++){
    		$("#"+varSelId).get(0).options[oIdx] = new Option(i, i);
    		oIdx++;
    	}

    	//default값 선택
    	$("#"+varSelId).val(year);

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
        //var year = parseInt(date.getTime()/1000/60/60/24/365)+1970; 
    	var year = date.getFullYear();
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
    	
    	$.post("common_X.jsp", { actGubn:"selectGrp", eval_year : eval_year, colNm : colNm, colVal : colVal, type: "post" }, function(data){selectPostTot_rdr(data,varSelId, varTotYn) });
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
    			$("#"+varSelId).get(0).options[0] = new Option("전체","");
    		}
    		$("#"+varSelId).get(0).length = 1;
    		oIdx = 1;
    	}else{
    		$("#"+varSelId).get(0).length = 0;
    		oIdx = 0;
    	}
    	
    	if(trim(data) == ""){
    		$("#"+varSelId).get(0).length = 0;
    		$("#"+varSelId).get(0).options[0] = new Option("없음", "no_data");
    		return;
    	}
    	 eval("var rs = " + data); 
    	/*  var rs = eval('('+data+')'); */ 
    	
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
    	
    	list();
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
    function selectGrpDept(selectId, totYn, url, eval_year, grp_cd, colVal, kbn){

    	var varTotYn;
    	var varSelId;
    	var oIdx;
    	
    	//현재 년도 구하기
    	var date = new Date();
    	//date.getTime()는 1970년 1월 1일 이후의 시간을 밀리세컨드로 나눈 값이므로 년횟수를 구하고 1970을 더한다.
        //var year = parseInt(date.getTime()/1000/60/60/24/365)+1970; 
    	var year = date.getFullYear();
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

    	if (kbn!=undefined && kbn=="전체") {
         	$.post("common_X.jsp", { actGubn:"selectGrpDept", eval_year : eval_year,grp_cd : grp_cd ,  colVal : colVal, type: "post" }, function(data){selectPostTot_rdr(data,varSelId, varTotYn) });
    	} else {
         	$.post("common_X.jsp", { actGubn:"selectGrpDept", eval_year : eval_year,grp_cd : grp_cd ,  colVal : colVal, type: "post" }, function(data){selectPost_rdr(data,varSelId, varTotYn) });
    	}
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
    			$("#"+varSelId).get(0).options[0] = new Option("::선택::","");
    		}
    		$("#"+varSelId).get(0).length = 1;
    		oIdx = 1;
    	}else{
    		$("#"+varSelId).get(0).length = 0;
    		oIdx = 0;
    	}
    	
    	if(trim(data) == ""){
    		$("#"+varSelId).get(0).length = 0;
    		$("#"+varSelId).get(0).options[0] = new Option("없음", "no_data");
    		return;
    	}
    	
    	 eval("var rs = " + data); 
    	 /* var rs = eval('('+data+')'); */ 
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
    	
    	list();
    }  
    
  //문자 앞 뒤의 널문자들을 없애는 함수
    function trim(str){
    	return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
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
    function selectMeas(selectId, totYn, url, eval_year, pst, colNm, colVal, customQuery, prgKbn){
    	var varTotYn;
    	var varSelId;
    	var oIdx;
    	
    	//현재 년도 구하기
    	var date = new Date();
    	//date.getTime()는 1970년 1월 1일 이후의 시간을 밀리세컨드로 나눈 값이므로 년횟수를 구하고 1970을 더한다.
        //var year = parseInt(date.getTime()/1000/60/60/24/365)+1970; 
    	var year = date.getFullYear();
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
    	
    	if(pst == null || pst == undefined){
    		pst = "";
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
    	    $.post("common_X.jsp", { actGubn:"selectMeasXls", 
    					eval_year : eval_year, colNm : colNm, colVal : colVal, customQuery:customQuery, 
    					type: "post" }, function(data){selectPost_rdr(data,varSelId, varTotYn) });
        } else {
      	    $.post("common_X.jsp", { actGubn:"selectMeas", 
    					eval_year : eval_year, pst: pst, colNm : colNm, colVal : colVal, customQuery:customQuery, 
    					type: "post" }, function(data){selectPost_rdr(data,varSelId, varTotYn) });
        }
    }

    /**
     **ajax를 이용해서 콤보박스의 옵션을 채우는 함수의 공통콜백 함수.<b> 
     *@data 			json 형태의 Text
     *@varSelId		콤보박스 id
     *@varTotYn		콤보박스에 "전체" 옵션 삽입 여부
     *@defaultVal	콤보박스의 디폴트값
     **/
    function selectPst(selectId, totYn, url, eval_year, colNm, colVal){
    	var varTotYn;
    	var varSelId;
    	var oIdx;
    	
    	//현재 년도 구하기
    	var date = new Date();
    	//date.getTime()는 1970년 1월 1일 이후의 시간을 밀리세컨드로 나눈 값이므로 년횟수를 구하고 1970을 더한다.
        //var year = parseInt(date.getTime()/1000/60/60/24/365)+1970; 
    	var year = date.getFullYear();
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
    			varSelId = "selectPst";
    		}
    	}else{
    		varSelId = selectId;
    	}
    	
    	$.post("common_X.jsp", { actGubn:"selectPst", eval_year : eval_year, colNm : colNm, colVal : colVal, type: "post" }, function(data){selectPostTot_rdr(data,varSelId, varTotYn) });
   
    }