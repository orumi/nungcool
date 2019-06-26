<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : TestItemList.jsp
  * @Description : TestItem List 화면
  * @Modification Information
  * 
  * @author test
  * @since 1
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>목록</title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
<script type="text/javascript" src="<c:url value='/script/dlgrids_eval.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/realgridjs.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jszip.min.js'/>"></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */


function fn_egov_select(tblItemCode) {
	document.getElementById("listForm").tblItemCode.value = tblItemCode;
   	document.getElementById("listForm").action = "<c:url value='/testItem/updateTestItemView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
   	document.getElementById("listForm").action = "<c:url value='/testItem/addTestItemView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	$.ajax({
		type : "post",
	    dataType : "json",
	    data : "pageIndex="+pageNo,
        url: "TestItemList.json",
        success: function (data) {
            var rows = data.Data;
            dataProvider.setRows(rows);
        },
        error: function (xhr, status, error, data) {
            $("#loadResult").css("color", "red").text("Load failed: " + error).show();
        },
        cache: false
    });
}

 // -->
</script>
<script>
	var gridView;
	var dataProvider;
	
	$(document).ready( function(){
	    RealGridJS.setTrace(false);
	    RealGridJS.setRootContext("/script");
	    
	    dataProvider = new RealGridJS.LocalDataProvider();
	    gridView = new RealGridJS.GridView("realgrid");
	    gridView.setDataSource(dataProvider);   
	    
	    gridView.onPageChanging = function (grid, newPage) {
	    };
	    gridView.onPageChanged = function (grid, newPage) {
	        $("#txtPage").val(newPage);
	    };

	  //다섯개의 필드를 가진 배열 객체를 생성합니다.
	    var fields = [
			    		{
	            fieldName: "tblItemCode"
	        }
	    		    	      ,{
	            fieldName: "tblItemName"
	        }
	    		    	      ,{
	            fieldName: "tblItemEname"
	        }
	    		    	      ,{
	            fieldName: "tblSItemCode"
	        }
	    		    	      ,{
	            fieldName: "tblUserId"
	        }
	    		    	      ,{
	            fieldName: "tblReportclasscode"
	        }
	    		    	      ,{
	            fieldName: "tblEndterm"
	        }
	    		    	      ,{
	            fieldName: "tblEndtermK"
	        }
	    		    	      ,{
	            fieldName: "tblEndtermJ"
	        }
	    		    	      ,{
	            fieldName: "tblEndtermC"
	        }
	    		    	      ,{
	            fieldName: "tblEndtermG"
	        }
	    		    	      ,{
	            fieldName: "tblTestmethod"
	        }
	    		    	      ,{
	            fieldName: "tblReferencebook"
	        }
	    		    	      ,{
	            fieldName: "tblGubun"
	        }
	    		    	      ,{
	            fieldName: "tblOrderby"
	        }
	    		    	      ,{
	            fieldName: "tblUseYn"
	        }
	    		    	      ,{
	            fieldName: "tblSysmuser"
	        }
	    		    	      ,{
	            fieldName: "tblSysmdate"
	        }
	    		    	      ,{
	            fieldName: "tblFupduser"
	        }
	    		    	      ,{
	            fieldName: "tblFupddate"
	        }
	    		    	      ,{
	            fieldName: "mssqlGubun"
	        }
	    		    	      ,{
	            fieldName: "mssqlTestitemcode"
	        }
	    		    	      ,{
	            fieldName: "mssqlSTestitemcode"
	        }
	    		    ];
	    //DataProvider의 setFields함수로 필드를 입력합니다.
	    dataProvider.setFields(fields);

	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
	    var columns = [
			    		{
	            name: "tblItemCode",
	            fieldName: "tblItemCode",
	            header : {
	                text: "tblItemCode"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblItemName",
	            fieldName: "tblItemName",
	            header : {
	                text: "tblItemName"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblItemEname",
	            fieldName: "tblItemEname",
	            header : {
	                text: "한글"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblSItemCode",
	            fieldName: "tblSItemCode",
	            header : {
	                text: "tblSItemCode"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblUserId",
	            fieldName: "tblUserId",
	            header : {
	                text: "tblUserId"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblReportclasscode",
	            fieldName: "tblReportclasscode",
	            header : {
	                text: "tblReportclasscode"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblEndterm",
	            fieldName: "tblEndterm",
	            header : {
	                text: "tblEndterm"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblEndtermK",
	            fieldName: "tblEndtermK",
	            header : {
	                text: "tblEndtermK"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblEndtermJ",
	            fieldName: "tblEndtermJ",
	            header : {
	                text: "tblEndtermJ"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblEndtermC",
	            fieldName: "tblEndtermC",
	            header : {
	                text: "tblEndtermC"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblEndtermG",
	            fieldName: "tblEndtermG",
	            header : {
	                text: "tblEndtermG"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblTestmethod",
	            fieldName: "tblTestmethod",
	            header : {
	                text: "tblTestmethod"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblReferencebook",
	            fieldName: "tblReferencebook",
	            header : {
	                text: "tblReferencebook"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblGubun",
	            fieldName: "tblGubun",
	            header : {
	                text: "tblGubun"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblOrderby",
	            fieldName: "tblOrderby",
	            header : {
	                text: "tblOrderby"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblUseYn",
	            fieldName: "tblUseYn",
	            header : {
	                text: "tblUseYn"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblSysmuser",
	            fieldName: "tblSysmuser",
	            header : {
	                text: "tblSysmuser"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblSysmdate",
	            fieldName: "tblSysmdate",
	            header : {
	                text: "tblSysmdate"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblFupduser",
	            fieldName: "tblFupduser",
	            header : {
	                text: "tblFupduser"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "tblFupddate",
	            fieldName: "tblFupddate",
	            header : {
	                text: "tblFupddate"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "mssqlGubun",
	            fieldName: "mssqlGubun",
	            header : {
	                text: "mssqlGubun"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "mssqlTestitemcode",
	            fieldName: "mssqlTestitemcode",
	            header : {
	                text: "mssqlTestitemcode"
	            },
	            width : 60            
	        }
	    		    	      ,{
	            name: "mssqlSTestitemcode",
	            fieldName: "mssqlSTestitemcode",
	            header : {
	                text: "mssqlSTestitemcode"
	            },
	            width : 60            
	        }
	    		    ];
	    
	    //컬럼을 GridView에 입력 합니다.
	    gridView.setColumns(columns);
	    
	    /* 그리드 row추가 옵션사용여부 */
	    gridView.setOptions({
	        edit : {
	            insertable : true,
	            appendable : true
	        }
	    });
	    
	    
	    
	});
	
	   $(function() {
		$("#sel").click(sel);
	        $("#btnInsert").click(btnInsertClickHandler);
	        $("#btnAppend").click(btnAppendClickHandler);
	        $("#btnSave").click(btnSave);
	        //setupGridJs("realgrid", "300", "300");
	    	$("#btnPage").click(btnPageClickHandler);
		    $("#btnFirst").click(btnFirstClickHandler);
		    $("#btnPrev").click(btnPrevClickHandler);
		    $("#btnNext").click(btnNextClickHandler);
		    $("#btnLast").click(btnLastClickHandler);
		    //$("#btnPageSize").click(btnPageSizeClickHandler);
		    $("#btnExcel").click(saveExcel);
	    });
		
	function sel(){
		//gridView.showProgress();
		gridView.showToast("Load data...", true);
		$.ajax({
			type : "post",
		    dataType : "json",
            //url: "TestItemList.json",
            url: "TestItemList.json",
            success: function (data) {
                dataProvider.fillJsonData(data);
                
                var pageSize = parseInt($('#txtPageSize').val());
                var rowCount = parseInt(data);
                var pageCount = Math.round((rowCount + pageSize / 2) / pageSize);
                gridView.setPaging(true, pageSize, pageCount);
                
                setPage(0);

            },
            error: function (xhr, status, error, data) {
                $("#loadResult").css("color", "red").text("Load failed: " + error).show();
            },
            complete: function (data) {
                //gridView.closeProgress();
            	gridView.hideToast();
            },
            cache: false
        });
	}
	
	function btnInsertClickHandler(e) {
	    var curr = gridView.getCurrent();
	    gridView.beginInsertRow(Math.max(0, curr.itemIndex));
	    gridView.showEditor();
	    gridView.setFocus();
	}
	
	function btnAppendClickHandler(e) {
		gridView.beginAppendRow();
		gridView.showEditor();
		gridView.setFocus();
	}
	
	function btnSave(e) {
		gridView.commit();
		saveData("/sample/insertSamples.json");
	}
	
	function saveData(urlStr) {
		var state;
	    var jData;
	    var jRowsData = [];

	    var rows = dataProvider.getAllStateRows();
	    
	    if (rows.created.length > 0) {
	        $.each(rows, function(k, v) {
	            jData = dataProvider.getJsonRow(v);
	            jData.state = "created";
	            jRowsData.push(jData);
	        });
	    }
	    
	    if (rows.updated.length > 0) {
	        $.each(rows, function(k, v) {
	            jData = dataProvider.getJsonRow(v);
	            jData.state = "updated";
	            jRowsData.push(jData);
	        });
	    }
		
	    if (jRowsData.length == 0) {
	        dataProvider.clearRowStates(true);
	        return;
	    }

	    $.ajax({
	        headers : {
	            "Accept" : "application/json",
	            "Content-Type" : "application/json"
	        },
	        url : urlStr,
	        type : "post",
	        data : JSON.stringify(jRowsData),
	        dataType : "json",
	        success : function(data) {
	            if (data > 0) {
	                alert("저장 성공!");
	                dataProvider.clearRowStates(true);
	                sel2();
	            } else {
	                alert("저장 실패!");
	            }
	        },
	        error : function(request, status, error) {
	            alert("code:" + request.status + "\n" + "error:" + error);
	        }
	    });
	}
	
	var rowSize = 0;
	var pageSizeChanged = false;
	
	
	function setPage(page) {
		// grid page setting
	    var count = gridView.getPageCount();
	    page = Math.max(0, Math.min(page, count - 1));
	 
	    var pageSize = 10;
	    var rows = (page + 1) * pageSize;
	    if (rows > dataProvider.getRowCount()) {
	        dataProvider.setRowCount(rows);
	    }
	 
	    gridView.setPage(page);
	 
	    // 한번 읽어온 페이지는 데이타를 다시 읽지 않도록
	    if (!dataProvider.hasData(page * pageSize)) {
	        loadData(dataProvider, page * pageSize);
	    }
	 
	    var displayPage = parseInt(page) + 1;
	 
	    // page number show
	    var pageNumbers = 10;
	    var startPage = Math.floor(page / pageNumbers) * pageNumbers + 1;
	    var endPage = startPage + pageNumbers - 1;
	    endPage = Math.min(endPage, gridView.getPageCount());
	 
	    $("#pageNumbers").empty();
	    for (var i = startPage; i <= endPage; i++) {
	        if (i == displayPage) { //current page
	            $("#pageNumbers").append("<input type='button' value='" + i + "' class='button gray small2' style='cursor:pointer;'/>");
	        } else {
	            $("#pageNumbers").append("<input type='button' value='" + i + "' onclick='btnPageNumClickHandler(this)' class='button white small2'/>");
	        }
	    }

	}
	
	function btnPageNumClickHandler(obj) {
	    var page = parseInt($(obj).val())-1;
	    setPage(page);
	}
	 
	function btnPageClickHandler(e) {
	    var page = parseInt($("#txtPage").val())-1;
	    setPage(page);
	}
	 
	function btnFirstClickHandler(e) {
	    setPage(0);
	}
	 
	function btnPrevClickHandler(e) {
	    var page = gridView.getPage();
	    setPage(page - 1);
	}
	 
	function btnNextClickHandler(e) {
	    var page = gridView.getPage();
	    setPage(page + 1);
	}
	 
	function btnLastClickHandler(e) {
	    var count = gridView.getPageCount();
	    setPage(count - 1);
	}
	
	function saveExcel(){
		gridView.exportGrid({
            type: "excel",
            target: "local",
            fileName: "gridExportSample.xlsx",
            showConfirm: false,
            linear: true    // Expand all columns and Export
        });
	}

</script>
</head>
<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	<input type="hidden" name="tblItemCode" />
<div id="content_pop">
<div role="main" class="ui-content jqm-content">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt="title" /> List </li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<div id="realgrid" style="width: 100%; height: 400px;"></div>
    <input type="text" id="txtPageSize" value="10" style="text-align:right"/>
	<input type="button" id="sel" value="조회"/>
	<input type="button" id="btnExcel" value="Excel출력" class="button black medium3"/>
	<input type="button" id="btnInsert" value="Insert Row" />
	<input type="button" id="btnAppend" value="Append Row" />
	<input type="button" id="btnSave" value="Save Row" />
		<input type="button" id="btnFirst" value="First" class="button black medium3"/>
    <input type="button" id="btnPrev" value="<" class="button black medium3"/>
    <div id="pageNumbers" style="display: inline-block; white-space: nowrap;">
        <input type='button' value='1' class='button white small2' style="cursor:pointer" />
        <input type='button' value='2' class='button white small2'/>
        <input type='button' value='3' class='button white small2'/>
        <input type='button' value='4' class='button white small2'/>
        <input type='button' value='5' class='button white small2'/>
        <input type='button' value='6' class='button white small2'/>
        <input type='button' value='7' class='button white small2'/>
        <input type='button' value='8' class='button white small2'/>
        <input type='button' value='9' class='button white small2'/>
        <input type='button' value='10' class='button white small2'/>
    </div>
    <input type="hidden" id="txtPage" value="1" style="text-align:right" maxlength="4" size="4"/>
    <input type="button" id="btnPage" value="Go" class="button black medium3"/>
    <input type="button" id="btnNext" value=">" class="button black medium3"/>
    <input type="button" id="btnLast" value="Last" class="button black medium3"/>
    
	
</div>
</div>
</form:form>
</body>
</html>
