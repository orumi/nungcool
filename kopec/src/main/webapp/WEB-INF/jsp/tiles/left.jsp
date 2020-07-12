<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
%>
<style>
	.leftMenu{
	}
</style>

<script type="text/javascript">
               
    		$(function() {
    			
    			var 
    			tabTemplate = "<li style='position:relative;'><span class='air air-top-left delete-tab' style='top:7px; left:7px;'><button class='btn btn-xs font-xs btn-default hover-transparent'><i class='fa fa-times'></i></button></span></span><a href='{href}'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {label}</a></li>", 
    			tabCounter = 2;

    			var tabs = $( "#tabs" ).tabs();
    			//tabs.tabs( "option", "heightStyle", "fill" );
    			
    			
    			// tabs id index array
    		  	var aTabs = new Array();
    		    
    			function tabEntity(id,title){
    		       this.id = id;
    		       this.title = title;
    		   	}
    			
    			function insertTab(id, title){
    				aTabs[aTabs.length] = new tabEntity(id, title);
    			}
    			
    			function deleteTab(id){
    				for(var i=0;i<aTabs.length;i++){
    					if(id==aTabs[i].id){
    						aTabs.splice(i,1);
    						return;
    					}
    				}
    			}
    			
    			

    			// actual addTab function: adds new tab using the input from the form above
    			function addTab(menuId, menuTitle, con) {
    				
    				var label = menuTitle || "Tab " + tabCounter,
    					//id = "tabs-" + tabCounter,   // 기존 아이디는 텝인덴스 기준으로 처리 됨.
    					id = menuId,              // 버튼아이디. 
    					li = $( tabTemplate.replace( /\{href\}/g, "#" + id ).replace( /\{label\}/g, label ) ),
    					tabContentHtml = con || "Tab " + tabCounter + " content.";

    				// check opened
    				var tab_index = checkTabIndex(id);
    				
    				//alert(id+"///"+tab_index)
    				
    				if(tab_index > -1){
    					tabs.tabs( "option", "active", tab_index );
    				} else {
    					insertTab(id, menuTitle );
    					
    					tabs.find( ".ui-tabs-nav" ).append( li );
    					tabs.append( "<div id='" + id + "' style='position:absolute;top:28px;left:0px;right:1px;bottom:1px;border-width:0px;border-collapse:collapse;border-color:red;'>" + tabContentHtml + "</div>" );
    					tabs.tabs( "refresh" );
    					tabs.tabs( "option", "active", tabCounter-1 );
    					
    					tabCounter++;
    					
    				}
    			}
    			
    			
    			function checkTabIndex(id){
    				if(aTabs.length == 0) return -1;
    				
    				for(var i=0;i<aTabs.length;i++){
    					//alert(aTabs[i].id);
    					if(id == aTabs[i].id){
    						i = i+1; //main index 0 
    						return i;
    					}
    				}
    				
    				return -1;
    			}
    			
    			$(".leftMenu").click(function() {
    				/* console.log("click ojbect is : "+$(this).attr("menuId")); */
    				actionMenu($(this).attr("menuId"), $(this).attr("menuTitle"), $(this).attr("menuUrl"));
    			});
    			
    			// close icon: removing the tab on click
    			tabs.delegate( "span.delete-tab", "click", function() {
    				var panelId = $( this ).closest( "li" ).remove().attr( "aria-controls" );
    				deleteTab(panelId); // array tabs remove
    				
    				$( "#" + panelId ).remove();
    				tabCounter--;
    				tabs.tabs( "refresh" );
    			});

    			tabs.bind( "keyup", function( event ) {
    				if ( event.altKey && event.keyCode === $.ui.keyCode.BACKSPACE ) {
    					var panelId = tabs.find( ".ui-tabs-active" ).remove().attr( "aria-controls" );
    					$( "#" + panelId ).remove();
    					tabCounter--;
    					tabs.tabs( "refresh" );
    				}
    			});    			
    			
    			function actionMenu(menuId, menuTitle, menuUrl){
   					$( "#tab_title" ).val(menuTitle);
   					var con = "<iframe id=\"ifm_"+menuId+"\" src=\""+menuUrl+"\" width=\"100%\" height=\"100%\" style=\"border-width:0px;border-collapse: collapse;\"></iframe>";
   					$( "#tab_content" ).val(con);
   					$( "#tab_id" ).val(menuId);
   					
   					addTab(menuId, menuTitle, con);
    					
    			}
    			
    		});   
			
    		function openScoreTable(dId, tId, level, year, month){
    			
    			if($("#ifm_scoreTable").length ){
    				//console.log("iframe : "+$("#ifm_scoreTable"));
    				$("#ifm_scoreTable")[0].contentWindow.openScoreIcon(dId,tId,level,year,month);
    				$("#leftMenu_scoreTable").click();
    			} else {
	    			var pm = "dId="+dId+"&tId="+tId+"&level="+level+"&year="+year+"&month="+month;
	    			//console.log("menuUrl : "+"../jsp/flex/scoreTable.jsp"+"?"+pm);
	    			$("#leftMenu_scoreTable").attr("menuUrl","../jsp/flex/scoreTable.jsp"+"?"+pm);
	    			$("#leftMenu_scoreTable").click();
	    			$("#leftMenu_scoreTable").attr("menuUrl","../jsp/flex/scoreTable.jsp");
    			}
    			
    		}
    		
    		function openMeasureTable(year, sbuId, bscId, mid){
    			if($("#ifm_measureTable").length ){
    				$("#ifm_measureTable")[0].contentWindow.openMeasureTable(year,sbuId,bscId,mid);
    				$("#leftMenu_measureTable").click();
    			} else {
    				var pm = "year="+year+"&sbuId="+sbuId+"&bscId="+bscId+"&mid="+mid;
    				$("#leftMenu_measureTable").attr("menuUrl","../jsp/flex/measureTable.jsp"+"?"+pm);
	    			$("#leftMenu_measureTable").click();
	    			$("#leftMenu_measureTable").attr("menuUrl","../jsp/flex/measureTable.jsp");
    			}

    		}  		
               
</script>

		
<!-- #NAVIGATION -->
		<!-- Left panel : Navigation area -->
		<!-- Note: This width of the aside area can be adjusted through LESS variables -->
		<aside id="left-panel">

			<!-- User info -->
			<div class="login-info">
				<span> <!-- User image size is adjusted inside CSS, it should stay as it --> 
					
					<a href="javascript:void(0);" id="show-shortcut" data-action="toggleShortcut">
						<img src="<c:url value='/bootstrap/img/avatars/sunny.png'/> " alt="me" class="online" /> 
						<span>
							홍길동 [운영자]
						</span>
					</a> 
					
				</span>
			</div>
			<!-- end user info -->

			<!-- NAVIGATION : This navigation is also responsive-->
			<nav>
				<ul>
				<c:forEach var="eMenu" items="${leftMenu}" varStatus="status">
					<c:if test="${eMenu.level eq '2' && eMenu.urlPath eq 'dir'}">
						<c:if test="${!status.first}">
							</ul>
						</li>
						</c:if>
						<li>
							<a href="#"><i class="fa fa-lg fa-fw fa-bar-chart-o"></i> <span class="menu-item-parent"><c:out value="${eMenu.menuNm}"/></span></a>
							<!-- <ul style="display:block;"> -->
							<ul>
					</c:if>
					<c:if test="${eMenu.level ne '2' && eMenu.urlPath ne 'dir'}">
							<li>
								<a href="#" class="leftMenu" id="leftMenu_<c:out value="${eMenu.progrmFileNm}"/>"  menuId="<c:out value="${eMenu.progrmFileNm}"/>"  menuTitle="<c:out value="${eMenu.menuNm}"/>", menuUrl="<c:out value="${eMenu.urlPath}"/>"><c:out value="${eMenu.menuNm}"/></a>
							</li>
					</c:if>
					<c:if test="${status.last}">
							</ul>
						</li>
					</c:if>
				</c:forEach>
					
					
<!-- 					<li>
						<a href="#"><i class="fa fa-lg fa-fw fa-bar-chart-o"></i> <span class="menu-item-parent">s</span></a>
						<ul style="display:block;">
							<li >
								<a href="flot.html">수행실적 등록</a>
							</li>
							<li>
								<a href="morris.html">수행실적 승인</a>
							</li>
							<li>
								<a href="inline-charts.html">운영현황 조회</a>
							</li>
						</ul>
					</li>
					
					<li>
						<a href="#"><i class="fa fa-lg fa-fw fa-pencil-square-o"></i> <span class="menu-item-parent">ISMS 인증관리</span></a>
						<ul>
							<li>
								<a href="#" class="leftMenu" menuId="certiManage" menuTitle="ISMS 기준정의", menuUrl="../certification/certiManage.do">ISMS 기준정의</a>
							</li>
						</ul>
					</li>
					
					<li>
						<a href="#"><i class="fa fa-lg fa-fw fa-list-alt"></i> <span class="menu-item-parent">운영체계관리</span></a>
						<ul>
							<li>
								<a href="#" class="leftMenu" menuId="requlation" menuTitle="통제항목", menuUrl="../jsp/web/actual/actual.jsp">통제항목</a>
							</li>
							<li>
								<a href="#" class="leftMenu" menuId="inspect" menuTitle="점검항목", menuUrl="../hierarchy/regulation.do">점검항목</a>
							</li>
							<li>
								<a href="#" class="leftMenu" menuId="exlImport" menuTitle="일괄등록", menuUrl="../hierarchy/exlImports.do">일괄등록</a>
							</li>
						</ul>
					</li>
					
					
					<li>
						<a href="#"><i class="fa fa-lg fa-fw fa-puzzle-piece"></i> <span class="menu-item-parent">시스템 관리</span></a>
						<ul>
							<li >
								<a href="flot.html">사용자 정보</a>
							</li>
							<li>
								<a href="morris.html">부서정보</a>
							</li>
							<li>
								<a href="inline-charts.html">공통코드 관리</a>
							</li>
						</ul>
					</li> -->
					
					
					
					
					
				</ul>
			</nav>

		</aside>
		<!-- END NAVIGATION -->