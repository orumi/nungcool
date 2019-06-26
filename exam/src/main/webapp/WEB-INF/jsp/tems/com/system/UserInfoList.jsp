<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script>
	var gridView;
	var dataProvider;
	
	var gridView2;
	var dataProvider2;
	
	var gpcode;	//선택된 권한그룹 코드
	
	$(document).ready( function(){
		
		RealGridJS.setTrace(false);
	    RealGridJS.setRootContext("<c:url value='/script'/>");
	    
	    dataProvider = new RealGridJS.LocalTreeDataProvider();
	    gridView = new RealGridJS.TreeView("realgrid");
	    gridView.setDataSource(dataProvider);   
	    
	    var fields = [
			{fieldName: "treeview"}
		   ,{fieldName: "officeid"}
	       ,{fieldName: "name"}
	       ,{fieldName: "uppofficeid"}
	       ,{fieldName: "uppname"}
	    ];
	    
	    //DataProvider의 setFields함수로 필드를 입력합니다.
	    dataProvider.setFields(fields);

	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
	    var columns = [
			{
	            name: "name", 
	            fieldName: "name", 
	            header : { text: "부서명" },
	            width : 150,
	            readOnly : "true"	                       
	        }
	    ];
	    
	    //컬럼을 GridView에 입력 합니다.
	    gridView.setColumns(columns);
	    
	    /* 그리드 row추가 옵션사용여부 */
	    gridView.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	        display : {
	            fitStyle : "evenFill"
	        }
	    });
	    
	    
	    //그리드 클릭 이벤트
	    gridView.onDataCellClicked =  function (grid, index) {
	    	gridView2.commit();
	    	var officeid = gridView.getValue(index.dataRow-1, "officeid");
	    	$.ajax({
				type : "post",
			    dataType : "json",
			    data : {"officeid":officeid},
	            url: "<c:url value='/system/selOfficeUserList.json'/>",
	            success: function (data) {
	                dataProvider2.fillJsonData(data);
	            },
	            error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            },
	            complete: function (data) {
	            	//gridView.hideToast();	            	
	            },
	            cache: false
	        });
	    };
	    
	    
	    
	    
	    /************
	    	그리드 2번!!!그룹별 권한목록
		************/	    	
	    dataProvider2 = new RealGridJS.LocalDataProvider();
	    gridView2 = new RealGridJS.GridView("realgrid2");
	    gridView2.setDataSource(dataProvider2);   
	    
	    
	    var fields2 = [
			{fieldName: "adminid"}
			,{fieldName: "officeid"}
			,{fieldName: "authorgpcode"}
			,{fieldName: "name"}
			,{fieldName: "adminpw"}
			,{fieldName: "uppofficeid"}
			,{fieldName: "empid"}
			,{fieldName: "ename"}
			,{fieldName: "cellphone"}
			,{fieldName: "telno"}
			,{fieldName: "extension"}
			,{fieldName: "email"}
			,{fieldName: "umjpname"}
			,{fieldName: "umjdname"}
			,{fieldName: "umpgname"}
			,{fieldName: "birthday"}
			,{fieldName: "skin"}
			,{fieldName: "useflag"}
	    ];
	    
	    //DataProvider의 setFields함수로 필드를 입력합니다.
	    dataProvider2.setFields(fields2);

	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
	    var columns2 = [
			{
	            name: "name", 
	            fieldName: "name", 
	            header : { text: "이름" },
	            width : 350,
	            readOnly : "true"	 
	        },
	        {
	            name: "authorgpcode", 
	            fieldName: "authorgpcode",
	            editor: {
	                type: "dropDown",
	                textReadOnly : true
	            },
	            lookupDisplay : true,
	            
	            editButtonVisibility : "always",
	            lookupSourceId: "AuthorGrp",
	            lookupKeyFields: ["useflag", "authorgpcode"],
	            header : { text: "권한그룹" },
	            width : 350
	            	 
	        },
	        {
	            name: "adminpw", 
	            fieldName: "adminpw", 
	            header : { text: "비밀번호" },
	            width : 350,
	            readOnly : "true"	 
	        },
	        {
	            name: "umjpname", 
	            fieldName: "umjpname", 
	            header : { text: "직위" },
	            width : 350,
	            readOnly : "true"	 
	        },
	        {
	            name: "umjdname", 
	            fieldName: "umjdname", 
	            header : { text: "직책" },
	            width : 350,
	            readOnly : "true"	 
	        },
	        {
	            name: "skin", 
	            fieldName: "skin", 
	            header : { text: "사용중인 스킨" },
	            width : 350,
	            readOnly : "true"	 
	        }
	    ];
	    
	    //컬럼을 GridView에 입력 합니다.
	    gridView2.setColumns(columns2);
	    
	    /* 그리드 row추가 옵션사용여부 */
	    gridView2.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	    	display : {
	            fitStyle : "evenFill"
	        }
	        
	    });
	    
	    //setLookups(gridView2);
	    
	    gridView2.setLookups([{
	        "id": "AuthorGrp",
	        "levels": 2,
	    }]);

	    
	});
	
	function lookupDataChange() {
		$.ajax({
			type : "post",
		    dataType : "json",
		    url: "<c:url value='/system/selAuthorGrpList.json'/>",
            success: function (data) {
            	var lookups = [];
            	for (var i =0; i < data.length ; i++) {
	            	if (!gridView2.existsLookupData("AuthorGrp", [1, data[i].authorgpcode])) {
	                    var lookup = [1, data[i].authorgpcode, data[i].authorgpnm];
	                    lookups.push(lookup);
	                }
	            }
	             gridView2.fillLookupData("AuthorGrp", {
	                rows: lookups
	            }); 
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    }

	
    $(function() {
	   $("#save2").click(btnSave);
	   
    });
		
	function sel(){
		$.ajax({
			type : "post",
		    dataType : "json",
            url: "<c:url value='/system/selOfficeList.json'/>",
            success: function (data) {
                dataProvider.setRows(data,"treeview", true, "", "");
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	gridView.expandAll();
            	lookupDataChange();
            },
            cache: false
        });
	}
	
	
	function btnSave(e) {
		
		gridView2.commit();	
		
		var state;
	    var jData;
	    var jRowsData = [];

	    var rows = dataProvider2.getAllStateRows();
	    
	    if(rows.updated.length > 0){
	        for(var i=0; i < rows.updated.length; i++){
	            jData = dataProvider2.getJsonRow(rows.updated[i]);
	            jData.state = "updated";
	            jRowsData.push(jData);
	        };
	    }

	    if (jRowsData.length == 0) {
	    	alert("변경된 내용이 없습니다.");
	        dataProvider2.clearRowStates(true);
	        return;
	    }
	    
	    
	    var val = JSON.stringify(jRowsData);
	    var data = {"data":val};
	    if(confirm("변경된 내용을 저장하시겠습니까?")){
	    	
	    	saveData("<c:url value='/system/edtOfficeUser.json'/>",data);	
	    }
	}
	
	function saveData(urlStr,data) {
	    $.ajax({
	        url : urlStr,
	        type : "post",
	        data : data,
	        dataType : "json",
	        success : function(data) {
	            if (data.RESULT_YN =="Y") {
	            	alert("정상 처리 되었습니다.");
	                dataProvider2.clearRowStates(true, true);
	            } else {
	                alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
	            }
	        },
	        error : function(request, status, error) {
	            alert("code:" + request.status + "\n" + "error:" + error);
	        }
	    });
	}
	
	sel();
	
</script>

<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">
	<!-- 여기서 부터 내용 작성 -->
	<table width="100%">
	<tr>
		<td width="38%">
			<!-- <span class="label label-xlg label-primary arrowed arrowed-right">권한그룹</span> -->
			<label>
				<i class="ace-icon fa fa-angle-double-right"></i>
				조직도
			</label>
		</td>
		<td rowspan="2" width="4%">
			&nbsp;
		</td>
		<td width="58%">
			<!-- <span class="label label-xlg label-primary arrowed arrowed-right">권한그룹</span> -->
			<label>
				<i class="ace-icon fa fa-angle-double-right"></i>
				부서별 사용자
			</label>
			<div class="text-right">
			<button class="btn btn-xs btn-white btn-default btn-round pull-right" id="save2">
				<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i>
				저장
			</button>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<div id="realgrid" style="width: 100%; height: 500px;"></div>
		</td>
		<td>
			<div id="realgrid2" style="width: 100%; height: 500px;"></div>
		</td>
	</tr>
	</table>
	<!-- 작성완료 -->
</div>
