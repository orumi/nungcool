<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
%>

<style>
<!--
	.hidden-menu #tabs {
		left:12px !important;
	}
	
	.minified #tabs {
		left:47px !important;
	}
-->
</style>

<script type="text/javascript">

	

	function actionMenu(menuId, pm){
		//console.log("portal page menuId : "+menuId);
		/* menu open */
		$("#leftMenu_plannedSchedule").click();
		
		$("#ifm_plannedSchedule").ready(function () {
			//console.log('myframe is loaded');
			setTimeout(function(){
				$("#ifm_plannedSchedule").get(0).contentWindow.actionEdit(pm);
			},1000);
			
		});
		
	}
	

</script>


	<!-- row -->
	<div id="tabs" class="sub_bg" style="position:absolute;top:50px;left:222px;right:2px;bottom:46px; border-width:1px;border-collapse:collapse;border-color:#aaaaaa;" >
		<ul><li><a href="#tabs-1">ISMS 운영현황</a></li></ul>
		<div id="tabs-1" style="height:100%;border-width:0px;border-collapse:collapse;border-color:red">				
			<iframe src="../isms/main.do" style="width:100%;height:100%;border:0px;" scrolling="auto"></iframe>
		</div>
	</div>	


