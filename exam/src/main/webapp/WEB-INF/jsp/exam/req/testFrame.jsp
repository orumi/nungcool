<%@page language="java"  contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<script>

	function getSelectItems (){
		var reqid = $("#reqid").val();
		var smpid = $("#smpid").val();
		
		
		var chkResultId = "";
		var chkItemId   = "";
		var chkItemIds  = "";
		var chkLeafs    = "";
		
		var result = "";
		
		$("input[name=chk_tbl_item]:checkbox").each(function(i){
			if($(this).is(":checked")){
				chkResultId += "│" + $(this).val() ;
				chkItemId   += "│" + $(this).attr("itemid");
				chkItemIds  += "│" + $(this).attr("itemids");
				chkLeafs    += "|" + $(this).attr("leafs");
				
				var cond_id = $("#sel_cond_"+$(this).val()).val()?$("#sel_cond_"+$(this).val()).val():"";
				var cond_etc = $("#etc_cond_"+$(this).val()).val()?$("#etc_cond_"+$(this).val()).val():"";
				result      += "│" + cond_id +"├"+cond_etc
				             + "├" + $("#sel_unit_"+$(this).val()).val() +"├"+$("#etc_unit_"+$(this).val()).val()
				             + "├" + $("#sel_method_"+$(this).val()).val() 
				             + "├" + $("#txt_reqspec_"+$(this).val()).val()
				             + "├" + $(this).attr("itemid") ;
				
			}
		}) 
		
		
		return {"mode":"saveItems", "reqid":reqid , "smpid":smpid ,"chkResultId":chkResultId, "chkItemId":chkItemId, "chkItemIds":chkItemIds, "result":result, "chkLeafs":chkLeafs};
	}
	/* 저장시 전체 선택  */
	function getAllItems (){
		var reqid = $("#reqid").val();
		var smpid = $("#smpid").val();
		
		
		var chkResultId = "";
		var chkItemId   = "";
		var chkItemIds  = "";
		var chkLeafs    = "";
		
		var result = "";
		
		$("input[name=chk_tbl_item]:checkbox").each(function(i){
				chkResultId += "│" + $(this).val() ;
				chkItemId   += "│" + $(this).attr("itemid");
				chkItemIds  += "│" + $(this).attr("itemids");
				chkLeafs    += "|" + $(this).attr("leafs");
				
				var cond_id = $("#sel_cond_"+$(this).val()).val()?$("#sel_cond_"+$(this).val()).val():"";
				var cond_etc_temp = $("#etc_temp_"+$(this).val()).val()?$("#etc_temp_"+$(this).val()).val():"";
				var cond_etc_time = $("#etc_time_"+$(this).val()).val()?$("#etc_time_"+$(this).val()).val():"";
				
				var cond_etc_temp_unitid = $("#etc_temp_unitid_"+$(this).val()).val()?$("#etc_temp_unitid_"+$(this).val()).val():"";
				var cond_etc_time_unitid = $("#etc_time_unitid_"+$(this).val()).val()?$("#etc_time_unitid_"+$(this).val()).val():"";
				
				var unit_id = $("#sel_unit_"+$(this).val()).val()?$("#sel_unit_"+$(this).val()).val():"-";
				var unit_etc = $("#etc_unit_"+$(this).val()).val()?$("#etc_unit_"+$(this).val()).val():"";
				
				var mehtod_id = $("#sel_method_"+$(this).val()).val() ?$("#sel_method_"+$(this).val()).val() :"1";
				var reqspec = $("#txt_reqspec_"+$(this).val()).val()?$("#txt_reqspec_"+$(this).val()).val():"";
				
				result      += "│" + cond_id 
				             + "├" + cond_etc_temp + "├" + cond_etc_temp_unitid
				             + "├" + cond_etc_time + "├" + cond_etc_time_unitid
				             + "├" + unit_id +"├"+unit_etc
				             + "├" + mehtod_id
				             + "├" + reqspec
				             + "├" + $(this).attr("itemid") ;
				
		}) 
		
		
		return {"mode":"saveItems", "reqid":reqid , "smpid":smpid ,"chkResultId":chkResultId, "chkItemId":chkItemId, "chkItemIds":chkItemIds, "result":result, "chkLeafs":chkLeafs};
	}
	
	
	
	/* 
	function actionSaveItems(){
		
		//var reqid = $("#reqid").val();
		//var smpid = $("#current_smpid").val();
		
		var chkResultId = "";
		var chkItemId = "";
		
		var result = "";
		
			$("input[name=chk_tbl_item]:checkbox").each(function(i){
			if($(this).is(":checked")){
				chkResultId += "│" + $(this).val() ;
				chkItemId   += "│" + $(this).attr("itemid");
				
				result      += "│" + $("#sel_cond_"+$(this).val()).val() +"├"+$("#etc_cond_"+$(this).val()).val()
				             + "├" + $("#sel_unit_"+$(this).val()).val() +"├"+$("#etc_unit_"+$(this).val()).val()
				             + "├" + $("#sel_method_"+$(this).val()).val() 
				             + "├" + $("#txt_reqspec_"+$(this).val()).val();
				
			}
		})  
	
		fmResults.mode.value = "saveItems";
		//fmResults.action = "<c:url value='/req/selectResult.json'/>";
		fmResults.chkResultId.value = chkResultId;
		fmResults.chkItemId.value = chkItemId;
		fmResults.result.value = result;
		
		//alert(result); 
		fmResults.submit();
		
		
		 
	/* 		$('input[name=mode]').val("saveItems");
		$('input[name=chkResultId]').val(chkResultId);
		$('input[name=chkItemId]').val(chkItemId);
		$('input[name=result]').val(result);
		
		$("form[name=fmResults]").attr("action","<c:url value='/req/selectResult.json'/>").submit(); */
		
		/*
	}
	
	
		 */
		
		
	
	function changeMethod(resultid){
  		    
			if($("#sel_method_"+resultid +" option:selected").val() == -1){
				$("#txt_reqspec_"+resultid).css("display","inline");
			} else {
				$("#txt_reqspec_"+resultid).css("display","none");
			}		 
	
	}
	
	
	
	/* 단위 그외 변경 이벤트 */
	function changeUnit(obj){
		//alert(obj.id);
		//alert($("#"+obj.id +" option:selected").val() );
		//alert($("#"+obj.id).attr("items") );
		
		if($("#"+obj.id +" option:selected").val() == -1){
			$("#etc_unit_"+$("#"+obj.id).attr("items")).css("display","inline");
			$("#sel_unit_"+$("#"+obj.id).attr("items")).width("48px");
		} else {
			$("#etc_unit_"+$("#"+obj.id).attr("items")).css("display","none");
			$("#sel_unit_"+$("#"+obj.id).attr("items")).width("92px");
		}
	}
	
	/* 시험조건 그외 변경 */
	function changeCond(obj){
		if($("#"+obj.id +" option:selected").val() == -1){
			$("#div_unit_etc_"+$("#"+obj.id).attr("items")).css("display","inline");
			
			if( $("#etc_temp_"+$("#"+obj.id).attr("items")) ){
				$("#etc_temp_"+$("#"+obj.id).attr("items")).val("");
			}
			if( $("#etc_time_"+$("#"+obj.id).attr("items")) ){
				$("#etc_time_"+$("#"+obj.id).attr("items")).val("");
			}
			
			//$("#etc_cond_unit_"+$("#"+obj.id).attr("items")).css("display","inline");
			$("#sel_cond_"+$("#"+obj.id).attr("items")).width("48px");
		} else {
			$("#div_unit_etc_"+$("#"+obj.id).attr("items")).css("display","none");
			//$("#etc_cond_unit_"+$("#"+obj.id).attr("items")).css("display","none");
			$("#sel_cond_"+$("#"+obj.id).attr("items")).width("98px");
		}
		
	}
	
	
	function clickItem(obj){
		/*자식 항목*/
		checkTree(obj.value, obj.checked);
	}
	
	function checkTree(resultid, chk){
		var chkVal="" ;
		$("input[name=chk_tbl_item]:checkbox").each(function(i){
			if( $(this).attr("resultpid") == resultid ){
				chkVal = $(this).val();
				$(this).prop("checked",chk);
				
				
			}
			if(chkVal != null && $(this).attr("resultpid")==chkVal){
				$(this).prop("checked",chk);
				
				
			}
		})
	}
	
	
	function clickCheckAll(obj){
		$("input[name=chk_tbl_item]:checkbox").each(function(i){
				$(this).prop("checked", obj.checked);
		});
	}

</script>

<div id="div_result" style="overflow: hidden;">
<table summary="검사항목" class="table_h" >

	<colgroup>
	<col width="4%"/>
	<col width="4%"/>
	<col width="16%"/>   <!--항목명   -->
	<col width="16%"/>   <!--시험조건   -->
	
	<col width="13%"/>   <!--단위   -->
	<col width="15%"/>   <!--시험방법   -->
	<col width="7%"/>    <!--수수료   -->
	
	<col width="14%"/>   <!--비고   -->
	<col width="10%"/>     <!--요구규격   -->
	</colgroup>
	
	<tr>
		<th>선택<br><input type="checkbox" id="chkAll" name="chkAll" onclick="javascript:clickCheckAll(this);"></th>
		<th>순번</th>
		<th>항목명</th>
		<th>시험조건</th>
		<th>단위</th>
		<th>시험방법</th>
		<th>수수료</th>
		<th>비고</th>
		<th class="b_R_none">요구규격</th>
	</tr>

</table>	
</div>
						
									




