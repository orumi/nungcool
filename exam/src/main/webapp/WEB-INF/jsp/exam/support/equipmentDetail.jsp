<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%

	String equipreqid = request.getParameter("equipreqid")!=null?request.getParameter("equipreqid"):"";

%>

<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/additional-methods.js"></script>
<script>


	/* modal_addItems */
	var dialog_addItems, form_addItems;

	/* modal_zipcode */
	var dialog_zipcode, form_zipcode;
	
    $(function () {
        /* jquery init condition */
        $("button").button().click(function (event) {
            event.preventDefault();
        });

        <% if("".equals(equipreqid)){ %>
        	actionAjax({ "formTag":"selectInfo"  });
        <% } else { %>
        	actionAjax({ "formTag":"selectEquipReq", "equipreqid":"<%=equipreqid%>"  });
        <% } %>
        
        

        $("#startdate").datepicker({
            changeMonth: true,
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage: "<c:url value='/images/calendar.gif'/>",
            buttonImageOnly: true,
            buttonText: "일자선택",
            dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            onClose: function (selectedDate) {
                //$("#issueDate2").datepicker("option", "minDate", selectedDate);
            	$("#enddate").datepicker("setDate", $("#startdate").val() );
            	$("#enddate").datepicker("setDate", "c+1y" );
            	$("#enddate").datepicker("setDate", "c-1d" );
            }
        });

        $("#enddate").datepicker({
            changeMonth: true,
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage: "<c:url value='/images/calendar.gif'/>",
            buttonImageOnly: true,
            buttonText: "일자선택",
            dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            onClose: function (selectedDate) {
                //$("#issueDate1").datepicker("option", "maxDate", selectedDate);
            	$("#startdate").datepicker("setDate", $("#enddate").val() );
            	$("#startdate").datepicker("setDate", "c-1y" );
            	$("#startdate").datepicker("setDate", "c+1d" );
                
            }
        });
        
        
		/* add Items modal */
		
		dialog_addItems = $("#form_addItems").dialog({
			autoOpen:false,
			width: 900,
			height: 845,
			modal: true,
			buttons:{
				"추가":function(){
					actionAddItemsCheck();
				},
				"취소":function(){
					dialog_addItems.dialog("close");
				}
			},
			close:function(){
				//form_addItems[0].reset();
			}
		});
		
		// open Modal Window
	    $( "#btn_addEquip" ).button().on( "click", function() {
	    	
	    		dialog_addItems.dialog( "open" );
	    	
	    		
	    		$("#tbl_selectItems").find("tr:not(:first)").each(function () {
	                $(this).remove();
	            });
	    		
	    		
	    		$("#searchEquip").val("");
	    		
	    });
		
		
        
        
		/* form to JSON */
	    $.fn.serializeFormJSON = function () {

	        var o = {};
	        var a = this.serializeArray();
	        $.each(a, function () {
	            if (o[this.name]) {
	                if (!o[this.name].push) {
	                    o[this.name] = [o[this.name]];
	                }
	                o[this.name].push(this.value || '');
	            } else {
	                o[this.name] = this.value || '';
	            }
	        });
	        return o;
	    };
	    
	    
	    


		/* zip code modal setting  */
		
		dialog_zipcode = $("#form_zipcode").dialog({
			autoOpen:false,
			width: 600,
			height: 700,
			modal: true,
			buttons:{
				"취소":function(){
					dialog_zipcode.dialog("close");
				}
			},
			close:function(){
				form_zipcode[0].reset();
			}
		});
		
		form_zipcode = dialog_zipcode.find("form").on("submit", function (event){
			event.preventDefault();
		})
		
		
		$("#btn_zipcode2").button().on("click", function(){
			dialog_zipcode.dialog( "open" );
	      	zipcodeTarget = "tax";
	      	zipTableInit();
		});	    
	    
		actionInitZipCode();
    });


    
    function actionPerformed(tag) {

        if (tag == "updateMembership") {
        	
        	if($("#issueDate1").val()=="" || $("#issueDate2").val()==""){
        		alert("신청기간을 선택하십시오.");
        		return;
        	}
        	
        	
        	
        } else if (tag == "updateCompany") {
            if(confirm("업체정보를 수정하시겠습니까?")){
	        	var frmData = JSON.stringify( $("#frmCompany").serializeFormJSON() );
	        	actionAjax({"formTag":"updateCompany","frmData":frmData});
            }
        } else if (tag == "selectEquips" ) {
        	actionAjax({"formTag":"selectEquips","searchkey":$("#searchEquip").val() });
        
        } else if (tag == "setDelete"){
        	
        	if(confirm("신청정보를 삭제하시겠습니까?")){
	        	var equipreqid = $("#equipreqid").val();
	        	
	        	actionAjax({"formTag":"setDelete", "equipreqid":equipreqid });
        	}
        } else if (tag == "setRequest"){
        	if($("#startdate").val()=="" || $("#enddate").val()==""){
        		alert("신청기간을 선택하십시오.");
        		return;
        	} else if($("#pricechargetype").val()=="-1") {
    			alert("세금계산서 청구유형을 선택하십시오.");
    			$("#pricechargetype").focus();
    			return false;
    		} else if($("#useobject").val() ==""){
        		alert("사용목적을 작성하십시오.");
        		return;
        	}
        	
        	/* 세금 계산서 */
    		if ($("#pricechargetype").val() == "26" || $("#pricechargetype").val() == "28" ) {
    			
    			if ($("#taxcompany").val()==""){
    				alert("세금계산서 받는 업체명정보가 입력되지 않았습니다.");
    				$("#taxcompany").focus();
    				return false;
    			} else if ($("#taxceo").val()==""){
    				alert("세금계산서 받는 대표자정보가 입력되지 않았습니다.");
    				$("#taxceo").focus();
    				return false;
    			} else if ($("#taxzipcode").val()==""){
    				alert("세금계산서 받는 우편번호 정보가 입력되지 않았습니다.");
    				$("#taxzipcode").focus();
    				return false;
    			} else if ($("#taxaddr1").val()==""){
    				alert("세금계산서 받는 주소정보가 입력되지 않았습니다.");
    				$("#taxaddr1").focus();
    				return false;
    			} else if ($("#taxaddr2").val()==""){
    				alert("세금계산서 받는 세부주소정보가 입력되지 않았습니다.");
    				$("#taxaddr2").focus();
    				return false;
    			} else if ($("#taxbizno").val()==""){
    				alert("세금계산서 받는 사업자번호정보가 입력되지 않았습니다.");
    				$("#taxbizno").focus();
    				return false;
    			} else if ($("#taxbiztype").val()==""){
    				alert("세금계산서 받는 업태정보가 입력되지 않았습니다.");
    				$("#taxbiztype").focus();
    				return false;
    			} else if ($("#taxmngname").val()==""){
    				alert("세금계산서 받는 담당자정보가 입력되지 않았습니다.");
    				$("#rcvmngname").focus();
    				return false;
    			} else if ($("#taxhp").val()==""){
    				alert("세금계산서 받는 휴대폰정보가 입력되지 않았습니다.");
    				$("#rcvhp").focus();
    				return false;
    			} else if ($("#taxemail").val()==""){
    				alert("세금계산서 받는 이메일정보가 입력되지 않았습니다.");
    				$("#rcvemail").focus();
    				return false;
    			} else if ($("#taxphone").val()==""){
    				alert("세금계산서 받는 전화번호정보가 입력되지 않았습니다.");
    				$("#rcvphone").focus();
    				return false;
    			} 
    			
    		}
        	
    		var tag   = $("#tag").val();
    		var equipreqid = $("#equipreqid").val();
    		
    		/* form to JSON */
    	    $.fn.serializeFormJSON = function () {

    	        var o = {};
    	        var a = this.serializeArray();
    	        $.each(a, function () {
    	            if (o[this.name]) {
    	                if (!o[this.name].push) {
    	                    o[this.name] = [o[this.name]];
    	                }
    	                o[this.name].push(this.value || '');
    	            } else {
    	                o[this.name] = this.value || '';
    	            }
    	        });
    	        return o;
    	    };
    	    
    		var frmData = JSON.stringify( $("#frmMember").serializeFormJSON() );
    		
    		var selEquip = getSelectEquip();
    		
    		if(selEquip == ""){
    			alert("장비를 추가하십시오.");
    			return;
    		}
    		
    		
    		actionAjax({"formTag":"setRequest", "tag":tag, "equipreqid":equipreqid, "frmData": frmData, "selEquip":selEquip });
    		
        	
        } else if("cancel" == tag ){
        	
        	window.location.href = "/exam/member/equipment.do?sub=support&menu=equipment";
        	
        }

    }
    
    
	function getSelectEquip(){
		var selChk = "";
		$("input[name=chk_sel_equip]:checkbox").each(function(i){
			selChk += "|"+$(this).val();
		})
		
		return selChk;
	}
	
    
	function actionAjax (pm){

		var url = "<c:url value='/member/actionEquipment.json' />";
		
		$.ajax({
			type     : "post",
		   	dataType : "json",
		   	data     : pm,
		    url      : url,
		    success: function(result){	
		    	// session check
		    	if(result["CHECK_SESSION"] == "N"){
		    		alert("로그아웃 되었습니다. 다시 로그인 바랍니다.");
		    		return;
		    	}
		    	
		        if(pm["formTag"]=="selectInfo"){
		        	
		        	if(result["RESULT_YN"]=="Y" ){
		        		setFrmMember( result["info"][0] );
			        	
		        	} else {
		        		alert("해당하는 정보가 없습니다. 운영자에게 문의바랍니다.");
		        	}
		        } else if(pm["formTag"]=="selectEquipReq") {
		        	if(result["RESULT_YN"]=="Y" ){
		        		
		        		setFrmMember( result["info"][0] );
		        		
		        		setFrmEquipReq(result["RESULT_EQUIPREQ"][0]);
		        		
		        		setEquipreqList(result["RESULT_EQUIPREQLIST"]);
		        	}
		        } else if(pm["formTag"]=="selectEquips"){
		        	
		        	if(result["RESULT_YN"] == "Y"){
		        		resultEquips(result);
		        	} else {
		        		alert("처리중오류가 발생되었습니다. 운영자에게 문의바랍니다.");
		        	}
		        } else if(pm["formTag"]=="updateMembership"){
		        	
		        	if(result["RESULT_YN"] == "Y"){
		        		//resultMember(result["RESULT_Member"][0]);
		        		alert("회원신청이 완료 되었습니다. ");
		        		resultMembership(result["RESULT_MEMBERSHIP"][0]);
		        	} else {
		        		alert("처리중오류가 발생되었습니다. 운영자에게 문의바랍니다.");
		        	}
		        } else if(pm["formTag"]=="setRequest"){
		        	if(result["RESULT_YN"] == "Y"){
		        		alert("신청이 완료 되었습니다. ");
		        		window.location.href = "/exam/member/equipment.do?sub=support&menu=equipment";
		        	} else {
		        		alert("처리중오류가 발생되었습니다. 운영자에게 문의바랍니다.");
		        	}
		        	
		        } else if (pm["formTag"] == "setDelete"){
		        	if(result["RESULT_YN"] == "Y"){
		        		alert("신청정보가 삭제되었습니다. ");
		        		window.location.href = "/exam/member/equipment.do?sub=support&menu=equipment";
		        	} else {
		        		alert("처리중오류가 발생되었습니다. 운영자에게 문의바랍니다.");
		        	}
		        }
		    },
		    error:function(request,status,error){
		    	alert("Error : "+error);
		    	//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    },
		    complete: function (data) {
		      	//gridView.hideToast();
		    },
		   
		});
	}    
    
	
	
	function resultEquips(data){
		/* reset table   */
        $("#tbl_selectItems").find("tr:not(:first)").each(function () {
        	$(this).remove();
        });

        var tbl_row = "";

        $(data["RESULT_EQUIPS"]).each(function (index, obj) {
        	tbl_row += "<tr  id=\"tr_selectItem_"+obj.equipid+"\">";
        	tbl_row += "<td class=\"txt_C\"><input type=\"checkbox\" id='chk_sel_item' name='chk_sel_item' treeid=\""+obj.equipid+"\"  value=\""+obj.equipid+"\" onclick='javascript:clickItem(this);' /></td>";
        	tbl_row += "<td class=\"txt_L\">" + obj.eqname + "</td>";
        	tbl_row += "<td class=\"txt_R\">" + obj.yearprice + "</td>";
        	tbl_row += "<td class=\"txt_R\">" + obj.dcrate + "% </td>";
        	tbl_row += "<td>" + obj.itemname + "</td>";
        	tbl_row += "<tr>";
        });
        
        
        $('#tbl_selectItems').append(tbl_row);
        
	}
	
	
	function clickItem(obj){
		//alert(obj.id);
	}
	
	// actionAddItems
	function actionAddItemsCheck(){
		aItems = new Array();
		
		var chkItems = "";
		
		var step = true;
		$("input[name=chk_sel_item]:checkbox").each(function(i){
			if($(this).is(":checked")){
				chkItems += "|"+$(this).val()+"┘"+$(this).closest('tr').find('td').eq(1).text()+"┘"+$(this).closest('tr').find('td').eq(2).text()+"┘"+$(this).closest('tr').find('td').eq(3).text() ;
			}
		})
		
		if(step){
			actionInsertItemsCheck(chkItems);
		}
		
		
	}
	
	
	function actionInsertItemsCheck(equips){
		// display add equip list
		var aEquips = equips.split("|");
		
		
        for(var i=0; i<aEquips.length; i++){
        	var aEquip = aEquips[i];
        	
        	if(aEquip!=""){
        		var equip = aEquip.split("┘");
        		
        		if( !$("#tr_equip_"+equip[0]).is("tr") ){
        		
        			var tbl_row = "";
        			
		        	tbl_row += "<tr  id=\"tr_equip_"+equip[0]+"\">";
		        	tbl_row += "<td class=\"txt_C\"><input type=\"checkbox\" id='chk_sel_equip' name='chk_sel_equip' treeid=\""+equip[0]+"\"  value=\""+equip[0]+"\" onclick='javascript:clickItem(this);' /></td>";
		        	tbl_row += "<td>" + equip[1] + "</td>";
		        	tbl_row += "<td>" + equip[2] + "</td>";
		        	tbl_row += "<td>" + equip[3] + "</td>";
		        	tbl_row += "<tr>";
		        	
		        	$('#tbl_equipList').append(tbl_row);
        		} else {
        			alert(equip[1]+" - 이미 추가 되었습니다. ");
        		}
	        	
        	}
        }
        
		
		dialog_addItems.dialog("close");
	}
	
	
	
	function actiondeleteEquip(){
		$("input[name=chk_sel_equip]:checkbox").each(function(i){
			if($(this).is(":checked")){
				$(this).closest('tr').remove();
			}
		})
	}
	
	
	
	/* get equipreq list form database   */
	function setEquipreqList(data){
		/* reset table   */
        $("#tbl_equipList").find("tr:not(:first)").each(function () {
            this.remove();
        });

        var tbl_row = "";

        $(data).each(function (index, obj) {
        	tbl_row += "<tr  id=\"tr_equip_"+obj.equipid+"\">";
        	tbl_row += "<td class=\"txt_C\"><input type=\"checkbox\" id='chk_sel_equip' name='chk_sel_equip' treeid=\""+obj.equipid+"\"  value=\""+obj.equipid+"\" onclick='javascript:clickItem(this);' /></td>";
        	tbl_row += "<td>" + obj.name + "</td>";
        	tbl_row += "<td>" + obj.eqpay + "</td>";
        	tbl_row += "<td>" + obj.dcrate + "</td>";
        	tbl_row += "<tr>";
        });
        
        
        $('#tbl_equipList').append(tbl_row);
	}
	
	
	
	
    /* resultData */
	
	var memberData ;
	
    //  성적서 기본정보 표시 기본정보 
	function setFrmMember(data){
		memberData = data;
		frmMember.reset();
		
		if(!data) {
			alert("해당하는 정보가 없습니다. ");
			return;
		}
		
		$("#frmMember input").each(function(i){
			var objName = this.name;
			
			if (objName){
				if(data[objName])
				var dataVal = data[objName]; //eval("data."+objName);
				if(dataVal){
					switch($(this).attr("type")){
					case "text":
						this.value = dataVal
					case "checkbox":
						// check valu
						;
					case "radio":
						// radio ;
						;
					case "select":
						;
					default:
						break;
					}
				} else {
					switch($(this).attr("type")){
					case "text":
						this.value = "";
					default:
						break;
					}
				}
			}
		});

		
		$("#frmMember label").each(function(i){
			var objName = $(this).attr("fieldName");
			if(objName){
				$(this).html(data[objName]);
			}
		});
		
		// reqid가 있을 경우 
		if(data["equipreqid"]){
			$("#reqid").val(data["reqid"]);
			
			/* 시험성적서 받는 주소  */
			$("#langtype").val(data["langtype"]);
			$("#usage").val(data["usage"]);
			$("#copycnt").val(data["copycnt"]);
			// 부본 갯수 
			
			$("#itemafter").val(data["itemafter"]);
			
			if(data["rcvtype"] == 2) {
				$("input:radio[name='rcvtype']:input[value='2']").prop("checked", true);
			} else {
				$("input:radio[name='rcvtype']:input[value='1']").prop("checked", true);
			}
			actionClickRcv();
			$("#rcvcompany").val(data["rcvcompany"]);
			$("#rcvceo").val(data["rcvceo"]);
			
			$("#rcvzipcode").val(data["rcvzipcode"]);
			$("#rcvaddr1").val(data["rcvaddr1"]);
			$("#rcvaddr2").val(data["rcvaddr2"]);
			$("#rcvdept").val(data["mngdept"]);
			$("#rcvmngname").val(data["rcvmngname"]);
			
			$("#rcvemail").val(data["rcvemail"]);
			$("#rcvphone").val(data["rcvphone"]);
			$("#rcvhp").val(data["rcvhp"]);
			$("#rcvfax").val(data["rcvfax"]);
			
			
			/*일반/KOLAS*/
			if(data["kolasyn"]){
				$("#kolasyn").val(data["kolasyn"]);
			}
			$("#kolasyn").prop("disabled", "disabled");
			
	        /* 세금계산서 청구  */
			
			$("#pricechargetype").val(data["pricechargetype"]);
			
			actionChangePriceType();
			
			$("#taxcompany").val(data["taxcompany"]);
			$("#taxceo").val(data["taxceo"]);
			$("#taxzipcode").val(data["taxzipcode"]);
			$("#taxaddr1").val(data["taxaddr1"]);
			$("#taxaddr2").val(data["taxaddr2"]);
			$("#taxdept").val(data["taxdept"]);
			$("#taxmngname").val(data["taxmngname"]);
			$("#taxbizno").val(data["taxbizno"]);
			$("#taxbiztype").val(data["taxbiztype"]);
			
			$("#taxemail").val(data["taxemail"]);
			$("#taxphone").val(data["taxphone"]);
			$("#taxhp").val(data["taxhp"]);
			$("#taxfax").val(data["taxfax"]);
			
		} else {
			
			
	        /* 세금계산서 청구  */
			
			$("#taxcompany").val(data["cname"]);
			$("#taxceo").val(data["ceoname"]);
			
			$("#taxzipcode").val(data["zipcode"]);
			$("#taxaddr1").val(data["addr1"]);
			$("#taxaddr2").val(data["addr2"]);
			$("#taxdept").val(data["mngdept"]);
			$("#taxmngname").val(data["mngname"]);
			$("#taxbizno").val(data["bizno"]);
			$("#taxbiztype").val(data["biztype"]);
			
			$("#taxemail").val(data["mngemail"]);
			$("#taxphone").val(data["mngphone"]);
			$("#taxhp").val(data["mnghp"]);
			$("#taxfax").val(data["fax"]);
			
		}
		
		
		// reqstate상태에 따른 버튼 활성화
/* 		if( data["reqstate"] > 1 ){
			$("#reqstate").val(data["reqstate"]);
			$("#btn_delRequest").css("display","none");
			$("#btn_setRequest").css("display","none");
			
			$("#div_sample").css("display","none");
			$("#div_items").css("display","none");
			$("#btn_confirm").css("display","none");
			
		} else {
			$("#reqstate").val(data["reqstate"]);
			if(data["reqid"]){
				$("#btn_delRequest").css("display","inline-block");
			} else {
				$("#btn_delRequest").css("display","none");
			}
			$("#btn_setRequest").css("display","inline-block");
			
			$("#div_sample").css("display","inline");
			$("#div_items").css("display","inline");
			$("#btn_confirm").css("display","inline-block");
		} */
		
		
		
	}	
    
	function setFrmEquipReq(data){
		
		$("#useobject").val(data["useobject"]);
		
		$("#startdate").val(data["startdate"]);
		$("#enddate").val(data["enddate"]);
		
		
		$("#pricechargetype").val(data["pricechargetype"]);
		
		
		actionChangePriceType();
		
		$("#taxcompany").val(data["taxcompany"]);
		$("#taxceo").val(data["taxceo"]);
		$("#taxzipcode").val(data["taxzipcode"]);
		$("#taxaddr1").val(data["taxaddr1"]);
		$("#taxaddr2").val(data["taxaddr2"]);
		$("#taxdept").val(data["taxdept"]);
		$("#taxmngname").val(data["taxmngname"]);
		$("#taxbizno").val(data["taxbizno"]);
		$("#taxbiztype").val(data["taxbiztype"]);
		
		$("#taxemail").val(data["taxemail"]);
		$("#taxphone").val(data["taxphone"]);
		$("#taxhp").val(data["taxhp"]);
		$("#taxfax").val(data["taxfax"]);
		
		
		
		if( data["state"] > 1 ){
			$("#btn_setDelete").css("display","none");
			$("#btn_setRequest").css("display","none");
			
			
			$("#btn_addEquip").css("display","none");
			$("#btn_delEquip").css("display","none");
			
		} else if (data["state"] == 0) {
			$("#btn_setDelete").css("display","inline-block");
			$("#btn_setRequest").css("display","inline-block");
			
			$("#equipreqid").val(data["equipreqid"]);
			$("#tag").val("U");
		}
	}
	

    
    function resultCompany(data){
    	
		$("#frmCompany input").each(function(i){
			var objName = this.name;
			
			if (objName){
				if(data[objName])
				var dataVal = data[objName]; //eval("data."+objName);
				if(dataVal){
					switch($(this).attr("type")){
					case "text":
						this.value = dataVal;
					case "hidden":
						this.value = dataVal;
					case "checkbox":
						;
					case "radio":
						;
					case "select":
						;
					default:
						break;
					}
				} else {
					switch($(this).attr("type")){
					case "text":
						this.value = "";
					default:
						break;
					}
				}
			}
		});
		
    }
	
    function resultMembership(data){
		//alert(data.startdate);
		
		$("#div").val(data.div);
		$("#state").val(data.state);
		
		$("#issueDate1").val(data.startdate);
		$("#issueDate2").val(data.enddate);
		
		$("#mshipid").text(data.mshipid);
		
		if(data.comid){
			$("#tag").val("U");
			
		}
		
		
		
		if(data.divtag == "1"){

			$("#btn_newid").css("display","none");
			$("#btn_update").css("display","none");
			$("#div_text").text(" ");
		} else if (data.divtag == "-1"){
			$("#btn_newid").css("display","none");
			$("#btn_update").css("display","inline");
			$("#div_text").text(" ");
		} else if (data.divtag == "2"){
			// 기간 만료
			$("#btn_newid").css("display","inline");
			$("#btn_update").css("display","none");
			
		}
		
		
    }

    


    function bisNumCheck() {

        var bisNum1 = $("#bisNum1").val();
        var bisNum2 = $("#bisNum2").val();
        var bisNum3 = $("#bisNum3").val();

        var bisNum = bisNum1 + bisNum2 + bisNum3;

        $.ajax({
            type: "POST",
            url: "<c:url value= '/member/bisNumCheck.json'/>",
            data: {"data": bisNum},
            dataType: "JSON",
            success: function (data) {
                alert(data);
            },
            error: function (xhr, status, error, data) {
                alert("에러가 발생 하였습니다, 문제가 지속되면 관리자에게 문의하여 주세요.");
            }
        });
    }

    function injectDataToModal(data) {

        $("#output").find("tr:not(:first)").each(function () {
            this.remove();
        });

        var output = "";

        $(data).each(function (index, item) {
            output += "<tr>";
            output += "<td>" + item.compName + "</td>";
            output += "<td>" + item.bisNum + "</td>";
            output += "<td>" + item.ceoNm + "</td>";
            output += "<td>" + item.compAddr1 + "</td>";
            output += "<td class='txt_C'><a href='javascript:choiceCompany(\"" + item.compName + "///" + item.comId + "\");'><img src='' alt='선택'/></a></td>";
            output += "<tr>";
        });
        $('#output').append(output);
    }


    function compValidation() {
        if ($("#compName").val() == "") {
            alert("업체명은 필수값 입니다.");
            return false;
        } else if ($("#bisNum1").val() == "" || $("#bisNum2").val() == "" || $("#bisNum3").val() == "") {
            alert("사업자 등록번호는 필수값 입니다.");
            return false;
        } else if ($("#bisType1").val() == "" || $("#bisType2").val() == "") {
            alert("사업유형은 필수값 입니다.");
            return false;
        } else if ($("#ceoNm").val() == "") {
            alert("대표자명은 필수값 입니다.");
            return false;
        } else if ($("#compTelNum1").val() == "" || $("#compTelNum2").val() == "" || $("#compTelNum3").val() == "") {
            alert("대표 전화번호는 필수값 입니다.");
            return false;
        } else if ($("#mngNm").val() == "") {
            alert("담당자명은 필수값 입니다.");
            return false;
        } else if ($("#mngPhone1").val() == "" || $("#mngPhone2").val() == "" || $("#mngPhone3").val() == "") {
            alert("담당자 전화번호는 필수값 입니다.");
            return false;
        } else if ($("#compFaxNum1").val() == "" || $("#compFaxNum2").val() == "" || $("#compFaxNum3").val() == "") {
            alert("대표 팩스번호는 필수값 입니다.");
            return false;
        } else if ($("#mngEmail").val() == "") {
            alert("담당자 email은 필수값 입니다.");
            return false;
        } else if ($("#mngDept").val() == "") {
            alert("담당자 부서는 필수값 입니다.");
            return false;
        }
        return true;
    }

    function userValidation() {

        if ($("#userId").val() == "") {
            alert("유저 아이디는 필수값 입니다.");
        }
        if ($("#userId").val().length < 3) {
            alert("유저 아이디는 3글자 이상이어야 합니다.");
        }

    }

    function finallyJoinMember() {

        var form = $("#form_joinMember");
        form.submit();
    }

    $(function () {
        $("form").validate({

            submitHandler: function () {
                var f = confirm("회원가입을 완료 하시겠습니까?");
                if (f) {
                    return true;
                }
                else {
                    return false;
                }
            },

            rules: {
                bisNum1: {
                    required: true
                }
            }
        })
    })


    
    
    
    	/* action tax price */
	function actionChangePriceType(){
		if($("#pricechargetype").val()=="26" || $("#pricechargetype").val()=="28" ){
			$("#tbl_tax").css({"display":"inline"});
		} else {
			$("#tbl_tax").css({"display":"none"});
		}
		
	}
    
    
    

    /* ********************** setting Zipcode  **************************************** */
    var zipcodeTarget;
    
    function actionInitZipCode(){
    	actionAjaxZipcode({"formTag":"siguList"});
    }
    function actionSearchZipCode(){
    	var searchKey = $("#txtSearch").val();
    	if(searchKey==""){alert("검색할 주소를 입력하십시오."); return; }
    	
    	var pm = {"formTag":"zipcodeSearch", "sido":$("#cbLvl1").val(), "searchKey":$("#txtSearch").val(), "searchType":$("#searchType").val() };
    	
    	actionAjaxZipcode(pm);
    }

    
    function resultSiguList(list){
    	for(var i=0; i<list.length; i++){
    		$("#cbLvl1").append("<option value='"+list[i]["sidocode"]+"'>"+list[i]["sido"]+"</option>");
    	}
    }
    
    function zipTableInit(){
   		$("#tblList tr").each(function (){
            var row = $("#"+this.id);
            row.remove();
        });
    }
    
    function resultZipcodeList(data){
    	zipTableInit();
    	
    	var vCnt  = data["RESULT_CNT"];
    	if(vCnt == 0){
    		alert("검색 정보가 없습니다. ");
    		return;
    	} else if (vCnt > 150){
    		alert("검색정보가 많습니다. 세부적으로 검색바랍니다. ");
    	}
    	
    	vList = data["RESULT_LIST"];
    	
  		var tblHTML = "<table class='table_h'>";
  		for(var i=0; i<vList.length; i++){
  			tblHTML += "<tr id='tr_zip_"+vList[i]["rn"]+"' style='height:24px;'>";
  			tblHTML += "<td style='width:5%;text-align:center;'>"+vList[i]["rn"]+"</td>";
  			tblHTML += "<td style='width:15%;text-align:center;'>"+vList[i]["zipcode"]+"</td>";
  			tblHTML += "<td style='width:35%;'><a href='javascript:actionZipcodesend(\""+vList[i]["zipcode"]+"\",\""+vList[i]["roadnamefull"]+"\");'>"+vList[i]["roadnamefull"]+"</a></td>";
  			tblHTML += "</tr>";
  		}
  	
  		tblHTML += "</table>";
  		
  		$("#tblList").append(tblHTML);
    }
    
    function actionZipcodesend(zipcode, fullname){
    	if(zipcodeTarget == "receive") {
    		$("#rcvzipcode").val(zipcode);
    		$("#rcvaddr1").val(fullname);
    		$("#rcvaddr2").val("");
    		
    	} else if(zipcodeTarget == "tax"){
    		$("#taxzipcode").val(zipcode);
    		$("#taxaddr1").val(fullname);
    		$("#taxaddr2").val("");
    		
    	}
    	
    	dialog_zipcode.dialog("close");
    	
    	//alert(zipcode+"/"+fullname);
    }
    
    
    

	/* zipcode   */
    function actionAjaxZipcode(pm){
		var url = "<c:url value='/main/zipcodeService.json' />";
		
		$.ajax({
			type     : "post",
		   	dataType : "json",
		   	data     : pm,
		    url      : url,
		    success: function(result){	
		    	// session check
		    	if(result["CHECK_SESSION"] == "N"){
		    		alert("로그아웃 되었습니다. 다시 로그인 바랍니다.");
		    		return;
		    	}
		    	
		        if(pm.formTag == "siguList"){
		        	
		        	if(result["RESULT_YN"]=="Y" ){
		        		// 정보 가져오기 
			        	resultSiguList(result["RESULT_LIST"]);
		        	} else {
		        		alert("해당하는 정보가 없습니다. 운영자에게 문의바랍니다.");
		        	}
		        } else if(pm.formTag == "zipcodeSearch"){
		        	
		        	resultZipcodeList(result);
		        	
		        }
		    },
		    error:function(request,status,error){
		    	alert("Error : "+error);
		    },
		    complete: function (data) {
		    },
		   
		});
    }
	
    /* ********************** end of setting Zipcode  **************************************** */
    
    
    
</script>

<style>

    /* datepicker css  */

    .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
        border: 1px solid #37A3D0;
        background: #71B9D7;
        font-weight: normal;
        color: #fff !important;
    }

    .ui-state-default:HOVER, .ui-widget-content .ui-state-default:HOVER, .ui-widget-header .ui-state-default:HOVER {
        border: 1px solid #227BB3;
        background: #4B93C0;
        font-weight: normal;
        color: #fff !important;
    }

    .ui-datepicker-trigger {
        cursor: pointer;
        border: 1px solid #C7C7C7;
        padding: 4px;
        border-left: none;
    }

</style>


    <!-- right_warp(오른쪽 내용) -->
    <div class="right_warp loginproc">
        <div class="title_route">
            <h3>설비계약서비스</h3>

            <p class="route">
                <img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/> <img
                    src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 고객지원 센터 <img
                    src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> <span>설비계약서비스</span>
            </p>
        </div>


	<form name="frmMember" id="frmMember">
		    <input type="hidden" id="reqid" name="reqid" value=""  />
		    <input type="hidden" id="current_smpid" name="current_smpid" />
		    <input type="hidden" id="reqstate" name="reqstate" />
		    
			<!-- 신청자정보 -->
			<div class="table_warp">
				<span class="back_bg_t">&nbsp;</span>
				<!-- table_w_in -->
				<div id="" class="table_w_in">
					
					<h4 class="title01">신청자 정보 <span class="surely"> * 는 필수입력항목입니다.</span></h4>
					<!-- table_bg -->
					<div id="div1_win_content" class="table_bg">
						<table summary="신청자정보" class="table_w">
							<colgroup>
							<col width="134px"/>
							<col width="275px"/>
							<col width="134px"/>
							<col width="*"/>
							</colgroup>
							<tr>
								<th>업체명</th>
								<td><label id="cname" fieldName="cname" ></label></td>
								<th>사업자번호</th>
								<td><label id="bizno" fieldName="bizno" ></label></td>
							</tr>
							<tr>
								<th>업태</th>
								<td><label id="biztype" fieldName="biztype" ></label></td>
								<th>대표자</th>
								<td><label id="ceoname" fieldName="ceoname" ></label></td>
							</tr>
							<tr>
								<th>담당자</th>
								<td><label id="mngname" fieldName="mngname" ></label> </td>
								<th>담당부서 </th>
								<td><label id="mngdept" fieldName="mngdept" ></label></td>
							</tr>
						</table>
					</div>
					<!-- //table_bg  -->


					<h4 id="div2_h4" class="title01">설비계약 기본정보</h4>
					<!-- table_bg -->
					<div id="div2_win_content" class="table_bg">
						<table summary="성적서 기본정보" class="table_w">
							<colgroup>
							<col width="134px"/>
							<col width="275px"/>
							<col width="134px"/>
							<col width="*"/>
							</colgroup>
							
							<tr>
								<th>사용목적</th>
								<td colspan="3">
									<input id="useobject" name="useobject" type="text" value="" class="h30" style="width:600px;" />
								</td>
							</tr>
							<tr>
								<th>계약시작</th>
								<td>
									<input type="text" id="startdate" name="startdate" value="" class="h30" style="width:190px;"/>
								</td>
								<th>계약종료</th>
								<td>
									<input type="text" id="enddate" name="enddate" value="" class="h30" style="width:190px;"/>
								</td>
							</tr>
							
							
							<tr>
								<th>세금계산서 청구</th>
								<td colspan="3">
									<select id="pricechargetype" name="pricechargetype" class="h30" style="width:100px; margin-bottom:6px; margin-top:3px;" onchange="javascript:actionChangePriceType();">
										<option value="-1">##선택##</option>
										<option value="26">청구</option>
										<option value="27">카드</option>
										<option value="28">영수</option>
									</select>
									
									<table id="tbl_tax" class="table_sub_w" style="display:none;">
										<colgroup>
											<col width="105px"/>
											<col width="130px"/>
											<col width="100px"/>
											<col width="*"/>
										</colgroup>									
									
										<tr>
											<th class="cor01">업체명 <span class="surely01">*</span></th>
											<td ><input id="taxcompany" name="taxcompany" type="text" value="" class="h30" style="width:220px;" /></td>
											<th  class="cor01">대표자 <span class="surely01">*</span></th>
											<td><input id="taxceo" name="taxceo" type="text" value="" class="h30" style="width:220px;" /></td>
										</tr>
										<tr>
											<th class="cor01" style="height:70px;">주소 <span class="surely01">*</span></th>
											<td colspan="3">
											<input id="taxzipcode" name="taxzipcode" type="text" value="" class="h30" style="width:60px;"/>
				                            <a href="#"><img id="btn_zipcode2" name="btn_zipcode2" src="<c:url value='/images/exam/btn/btn_addr.gif'/>" alt="우편번호찾기" style="border:0px;"/></a>
				                            <br>
											<input id="taxaddr1" name="taxaddr1" type="text" value="" class="h30" style="width:365px; margin-top:3px;" />
											<br>
											<input id="taxaddr2" name="taxaddr2" type="text" value="" class="h30" style="width:180px; margin-top:3px;" />
											</td>
										</tr>
										<tr>
											<th class="cor01">사업자번호 <span class="surely01">*</span></th>
											<td ><input id="taxbizno" name="taxbizno" type="text" value="" class="h30" style="width:220px;" /></td>
											<th class="cor01">업태 <span class="surely01">*</span></th>
											<td><input type="text" id="taxbiztype" name="taxbiztype" value=" " class="h30" style="width:220px;" /></td>
										</tr>
										<tr>
											<th class="cor01">담당자 <span class="surely01">*</span></th>
											<td><input type="text" id="taxmngname" name="taxmngname" value=" " class="h30" style="width:220px;" /></td>
											<th class="cor01">담당부서</th>
											<td ><input id="taxdept" name="taxdept" type="text" value="" class="h30" style="width:220px;" /></td>
										</tr>										
										<tr>
											<th class="cor01">휴대폰 <span class="surely01">*</span></th>
											<td >
												<input type="text" id="taxhp" name="taxhp" value="" class="h30" style="width:108px;" placeholder="010-0000-0000" />
											</td>
											<th class="cor01">이메일 <span class="surely01">*</span></th>
											<td ><input id="taxemail" name="taxemail" type="text" value="" class="h30" style="width:220px;" /></td>
										</tr>
										<tr>
											<th class="cor01">전화번호 <span class="surely01">*</span></th>
											<td >
												<input type="text" id="taxphone" name="taxphone" value="" class="h30" style="width:108px;" placeholder="010-0000-0000" />
											</td>
											<th class="b_B_none cor01">팩스번호</th>
											<td class="b_B_none">
												<input type="text" id="taxfax" name="taxfax" value="" class="h30" style="width:108px;" placeholder="010-0000-0000" />
											</td>
										</tr>									
									
									
									</table>
									
									
									
									
								</td>
							</tr>
							

						</table>
					</div>
					
				</div>
				
				
				
				<!-- //table_w_in -->
				<span class="back_bg_b">&nbsp;</span>
			</div>
			<!-- //성적서 기본정보 -->
	</form>	


	        <div style="text-align: center;">

       	  	</div>
       	  	
<form id="frmEquipment" name="frmEquipment" action="<c:url value=''/>" method="post" class="formClass">
	<input type="hidden" name="memid" id="memid" >
	<input type="hidden" name="comid" id="comid" >
	<input type="hidden" name="equipreqid" id="equipreqid" >
	<input type="hidden" name="tag" id="tag" value="N"> 
        <!--  -->
        <div style="float:left;width:100%">
        <h4 class="title01" style="display:table-cell;float:left;">
        	<span class="txt">설비계약</span>
        </h4>
        		<div style="float:right;margin-top:8px;margin-right:2px;">
                   
                   <button id="btn_addEquip" name="btn_addEquip" class="btn" style="display: inline;" >설비추가
                   </button>
                   
                   <button id="btn_delEquip" name="btn_delEquip" class="btn" style="display: inline;" onclick="javascript:actiondeleteEquip();" >설비삭제
                   </button>
                </div>
        </div>
        
        <!-- 사용자 디폴트 값들 -->

        <div class="table_bg " style="clear:both;">
            <table summary="사용자정보" class="table_w" id="tbl_equipList" name="tbl_equiplist">
                <colgroup>
                    <col width="10%"/>
                    <col width="50%"/>
                    <col width="20%"/>
                    <col width="20%"/>
                </colgroup>
                
                <tr>
					<th class="font13 txt_C">선택</th>
					<th class="font13 txt_C">설비명</th>
                    <th class="font13 txt_C">계약금액</th>
                    <th class="font13 txt_C">활인률</th>
                </tr>


            </table>
        </div>
</form>
       
					<div id="div2_btn" style="height:60px;width:100%;text-align: center;margin-top:6px;">
					<div type="button" id="btn_setRequest" class="btn btn-primary btn-normal" style="height:32px;padding:1px 24px 1px 24px !important; margin-right:8px; font-weight:700 !important; font-size:16px !important" onclick="javascript:actionPerformed('setRequest');">
						적 용
					</div>
					<div type="button" id="btn_setDelete" class="btn btn-danger btn-normal" style="display:none;height:32px;padding:1px 24px 1px 24px !important; margin-right:8px; font-weight:700 !important; font-size:16px !important" onclick="javascript:actionPerformed('setDelete');">
						신청 삭제
					</div>
					
					<div type="button" id="btn_setCancel" class="btn btn-primary btn-normal" style="height:32px;padding:1px 24px 1px 24px !important; margin-right:8px; font-weight:700 !important; font-size:16px !important" onclick="javascript:actionPerformed('cancel');">
						목 록
					</div>
					</div>
    <!-- //right_warp(오른쪽 내용) -->






<!--  항목 추가  -->
<div id="form_addItems" title="설비계약" >
  <form>
    <fieldset>

	<!-- popup_In -->
	<div class="popup_In">
		<!-- popup_In_table -->
		<div style="width:100%;float:left;">
			<div class="popup_In_table">
				<table summary="" class="table_w">
					<colgroup>
					<col width="120px"/>
					<col width="*"/>
					</colgroup>
					<tr>
						<th class="bor_T_color01 bor_B_color01 bor_L_color01" >설비검색</th>
						<td class="bor_T_color01 bor_R_color01 bor_B_color01 ">
						<div class="input-group">
							<input type="text" id="searchEquip" name="searchEquip" value="" class="inputBox" style="width:68%" />
							<div class="input-group-btn">
								<button id="btn_select_items" name="btn_select_items" class="btn" onclick="javascript:actionPerformed('selectEquips'); ">검색</button>
							</div>
						</div>	
						</td>
					</tr>
				</table>
			</div>	
			
			<!-- table_bg -->
			<div id="div_selectItems" class="table_bg" style="width:100%; height:580px;overflow: scroll;overflow-y: scroll; overflow-x: hidden; display:inline;">
				<table summary="항목 목록" class="table_h" id="tbl_selectItems" name="tbl_selectItems" style="border-top: 2px solid #D4D4D4;">
					<colgroup>
					<col width="10%"/>
					<col width="30%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="*"/>
					</colgroup>
					<tr>
						<th>선택</th>
						<th class="b_R_none">설비명</th>
						<th class="b_R_none">연간기본료</th>
						<th class="b_R_none">할인률</th>
						<th class="b_R_none">검사항목</th>
					</tr>
					
				</table>
			</div>
		</div>
		
		</div>
	<!-- //popup_In -->
	
	
	
	
    <!-- Allow form submission with keyboard without duplicating the dialog button  -->
    <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    
    </fieldset>
    
    
  </form>
</div>





<!-- 우편번호 검색  -->
<div id="form_zipcode" title="우편번호 검색" style="    overflow: hidden;">
  <form>
    <fieldset>

	<!-- popup_In -->
	<div class="" style="width:100%;float:left;">
		<!-- popup_In_table -->
		
			<!-- popup -->
			<div class="" style="width:100%;border:0px;float:left;">
			 <h4 class="title01">도로명 주소 찾기</h4>
			 <!-- popup_In -->
			 <div class="popup_In" style="float:left;height:182px;">
			   
			     <div class="left_Box" style="float:left;   margin: 10px;" >
				     <div class="h5_title">
				      <h5>주소명 검색방법</h5>
				     </div>
					<div class="h_Table_line02"  style="float:left;width:100%; ">
						 <div class="top_Table_box" style="float:left;width:100%; overflow-x:hidden; overflow-y:hidden;"  >  
						 <table style="margin: 4px;">
						 <tr><td >
						 	1. 동 + 검물명 입력 : 예) '충무로1가(동명) 중앙우체국(건물명)'<br>
						 	2. 도로명 + 건물번호 입력 : 예)'소공로(도로명) 70(건물번호)'<br>
						 	3. 건물명 입력 : 예)'중앙우체국(건물명)'
						 </td></tr>
						 </table>
						 </div>
					</div>	 
				</div>
				   
			   <div class="search_Box" style="float:left;width:92%;margin-left:12px;margin-bottom: 12px;">
			    <table summary="검색" class="table01" >
			     <caption>검색</caption>
			     <colgroup>
			     <col width="80px"/>
			     <col width="*"/>
			     </colgroup>
			     <tr>
			      <th>시/도</th>
			      <td>
			       <select style="width:180px;"  name="cbLvl1" id="cbLvl1" onchange="">
			       </select>
			      </td>
			     </tr>
			     <tr><td style="height:3px;" colspan="4"></td></tr>
			     <tr>
			      <th>
					주소검색
			      </th>
			      <td  colspan="3">
			      	<select name="searchType" id="searchType" style="width:80px;">
			      		<option value="road">도로명</option>
			      		<option value="area">지번</option>
			      	</select>      
			       <input type="text" style="width:200px;"  name="txtSearch" id="txtSearch"  >
			      	<a href="#" onclick="actionSearchZipCode();" id="btnSearch" ><img src="<c:url value='/images/exam/btn/btn_inquiry01.gif'/>" alt="검색"  /></a>
			      </td>
			     </tr>     
			    </table>
			   </div>
			   
			
			
			    <div class="con_right_in" style="float:left; width:100%; ">
			
			

		
		    <!-- left_Box_top -->
		     <div class="left_Box" style="width:100%;" >
			     <!-- h5_title -->
			     <div class="h5_title">
			      <h5>주소목록</h5>
				      <div align="right" style="margin-right: 20px;margin-top:5px;">
				      		주소를 클릭하십시오.
				      </div>
			     </div>
		     <!-- //h5_title -->
		        
		        <!-- DataGrid 전체 DIV -->
				<div class="h_Table_line02"  style="width:100%;">
					 <div class="table_bg" style="width:100%; overflow-x:hidden; overflow-y:scroll;"  >      
					       <table summary="" class="table_h">
					        <thead id="tblHeader">
						        <tr>
						         <th style="width:5%"  dataField="rn" textAlign="center" >검색<br>순번</th>
						         <th style="width:15%" dataField="tblZipcode" textAlign="center" >우편번호</th>
						         <th style="width:35%"  dataField="tblRoadNameFull" textAlign="left" > 주소</th>
						        </tr>
					       	</thead>
					       </table>
					   </div>
					<!-- Grid List 전체 DIV width-2px  -->
		            <div class="bottom_T_box" id="tblList" style="width:100%;height:280px;overflow-x:hidden;overflow-y:scroll" onscroll="">
			            <table style="" class="table_h">
			                <tbody id="tblListbody"></tbody>    
			            </table>
		            </div>
		            <div style="margin-top: 7px;">
		            <!-- 
		            	<div id="paging"><strong>[</strong> 전체수:  0,  전체페이지 : 0,  현재페이지 : 0 <strong>]</strong> </div>
		             -->	
		            </div>            
				</div>
		    
		    
		    </div>
		    <!-- left_Box_top -->
		
		     </div>
		  </div>
		  <!-- //con_right -->
		 </div>
		 <!-- //container -->
 
 
 
			<!-- //table_bg  -->
		<!-- //popup_In_table -->
	</div>
	<!-- //popup_In -->
	
	
	
	
    <!-- Allow form submission with keyboard without duplicating the dialog button  -->
    <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    
    </fieldset>
    
    
  </form>
</div>






