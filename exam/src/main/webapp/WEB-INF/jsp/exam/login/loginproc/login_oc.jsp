<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="exam.com.main.model.LoginOldUserVO" %>

<head>
<%

	LoginOldUserVO loginOldUserVO = (LoginOldUserVO) request.getSession().getAttribute("loginOldUserVO");
	
	String oldUsername = "";

	if(loginOldUserVO == null){
		%>
		 	<script>
		 		alert("로그인 정보가 없습니다. 다시 접속바랍니다. ");
		 		history.back();
		 	</script>
		<%
		
		return ;
	} else {
		oldUsername = loginOldUserVO.getMemname();
	}
	
	 
%>
<script>
    
    $(function () {
        /* jquery init condition */
        $("button").button().click(function (event) {
            event.preventDefault();
        });
    });
    
    
    function actionPerformed(){
    	var newid = $("#newid").val();
    	var cnt = $("#newidcnt").val();
		
    	if(Number(cnt) == 0){
    		if(confirm("입력된 아이디를 생성하시겠습니까?")){
    			actionAjax('actionAdjustNewid');
    		}
    	} else if(Number(cnt) == -1){
    		alert("[사용여부확인] 바랍니다.");
    		return;
    	} else {
    		alert("중복된 아이디가 있습니다. 다른 아이디를 입력하십시오.");
    		return;
    	}
    	
    	
    	
    }
    
	function actionAjax (tag){
		var newid = $("#newid").val();
		if(newid == ""){
			alert("아이디를 입력하여 주시기 바랍니다.");
			return;
		} 
		
		var url = "<c:url value='/login/loginProcService.do' />";
		
		$.ajax({
			type     : "post",
		   	dataType : "json",
		   	data     : { "tag":tag,  "newid":newid },
		    url:url,
		    success: function(result){	
		        if(tag=="actionChkNewId"){
		        	// 아이디 체크 
					resultCheckId(result.RESULT_CNT);
		        } else if(tag=="actionAdjustNewid"){
		        	// 신규아이디 생성
		        	if(result.RESULT_YN == "Y"){
		        		alert("신규 아이디가 생성되었습니다. ");
		        		resultAdjustId();	
		        	} else {
		        		alert("오류가 발생되었습니다. 운영자에게 문의바랍니다. ");
		        	}
		        	
		        }
		    },
		    error:function(request,status,error){
		    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    },
		    complete: function (data) {
		      	//gridView.hideToast();
		    },
		   
		});
	}
	
	function resultAdjustId(){
		window.location.href = "<c:url value='/login/loginProc.do?sub=support&menu=loginProc&loginTag=UD' />";		
	}
	
	function resultCheckId(cnt){
		if(0==cnt){
			$("#div_display").css("display","block");
			$("#span_msg").html("사용가능한 아이디입니다.");
			$("#newidcnt").val(cnt);
		} else if (cnt>0){
			$("#newidcnt").val(cnt);
			$("#div_display").css("display","block");
			$("#span_msg").html("중복된 아이디가 있습니다.");
		}
		
	}
	
	function eventInputId(){
		$("#newidcnt").val(-1);
		$("#div_display").css("display","none");
	}
</script>    

</head>
<body >
<form action="" method="post">
<input type="hidden" name="newidcnt" id="newidcnt" value="-1">
<!-- wrap -->

		<!-- right_warp(오른쪽 내용) -->
		<div class="right_warp loginproc">
			<div class="title_route">
				<h3>아이디 생성</h3>
				<p class="route">
					<img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/> <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 고객지원 센터 <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt="" /> <span>회원가입</span>
				</p>
			</div>
			<!-- m_screen01  -->
			<div class="m_screen01">
				<p class="name">
					<span class="txt01"><%=oldUsername %></span>
					<span class="txt02">님!</span><br>
					<span class="txt03">KPetro TEMS시스템</span>
					방문을 환영합니다. 
				</p>
				<!-- m_screen01_in -->
				<div class="m_screen01_in" style="padding-top:50px;">
					<p class="txt01">기존 시스템 회원정보의 효율적인 관리를 위하여 <br>개별아이디를 발급하고 있습니다.</p>
					<p class="txt01">아이디를 생성하신 후 아이디를 이용하여 로그인하실 수 있습니다. </p>
					
					       <div class="table_bg m_B10" style="width: 600px; 
					                                          margin-left:85px; margin-top:54px;
					                                          margin-bottom:60px !important;">
			            	<table summary="사용자정보" class="table_w">
			                <colgroup>
			                    <col width="130px"/>
			                    <col width="*"/>
			                </colgroup>
			                <tr>
			                    <th class="font13" style="width:100px;">아이디</th>
			                    <td class="" colspan="3">
			                        <div style="float:left;height:30px;">
			                        <input id="newid" name="newid" type="text" value="사용하실 아이디 입력" class="h30 txt_color02"
			                               style="width:140px;ime-mode:inactive;" onfocus="javascript:this.value='';eventInputId();"  onchange="javascript:eventInputId();" />&nbsp;
			                        <a href="javascript:actionAjax('actionChkNewId');"><img src="<c:url value='/images/exam/btn/btn_check05.gif'/>" alt="사용여부확인"/></a>&nbsp;
			                        </div>
			                        <div style="float:left;padding-top:8px;display:none;" id="div_display">
                                        <img style="float:left;padding-left:3px;" src="<c:url value='/images/exam/ico/ico06.gif'/>" alt=""/>
                                        <span class="txt_color03" style="display:table-cell; padding-left:6px;" id="span_msg"> 중복된 아이디가 있습니다. </span>
			                        </div>                                         
			                                                                 
			                    </td>
			                </tr>
			                </table>
			                </div>
					
					
					 

				</div>
				<!-- //m_screen01_in -->
				<%-- 
				<p class="txt_C m_T40"><a href="#"><img src="<c:url value='/images/exam/btn/btn_check06.gif'/>" alt="확인"/></a></p>
				 --%>
		        <div style="text-align: center;">
                     <button id="btn_newid" name="btn_newid" class="btn"
                             onclick="actionPerformed('UD');">신규 아이디 생성
                     </button>
         	  	</div>
         	  	
         	  	<div class="m_screen01_in" style="padding-top:50px;">
					<p class="txt02" sytle="margin-top:60px;"><strong>[아이디 발급 ]</strong> 아래의 연락처로 문의하시면 안내해 드리겠습니다.</p>
					 
					
					<ul class="mail_phon">
						<li>-</li>
						<li>043-243-7980</li>
					</ul>         	  	
         	  	</div>
			</div>
			
			
			<!-- //m_screen01  -->
		</div>
		<!-- //right_warp(오른쪽 내용) -->


</form>
</body>
</html>
