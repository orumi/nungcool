﻿<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>sampleall</title>
<script type="text/javascript" src="./rexscript/getscript.jsp?f=rexpert.min"></script>
<script type="text/javascript" src="./rexscript/getscript.jsp?f=rexpert.properties"></script>
<script type="text/vbscript">
	Sub fnOpen()
		'필수 - 레포트 생성 객체
		Dim oReport
		Set oReport = GetfnParamSet()

		'필수 - 레포트 파일명
		oReport.rptname = "samples/simple"
		'옵션 - 데이터타입(csv - 기본값, xml)
		'oReport.datatype= "xml";

		'옵션 - 데이터베이스 연결 정보 (서버로 통해 데이터를 가져올 때)
		'oReport.connectname = "oracle1"

		'옵션 - 레포트 파라메터
		'oReport.param("param1").value = "param1"
		
		'옵션 - title
		'oReport.title = "리포트"

		'옵션 - Event
		Set oReport.event.init = fnVBEventHandler
		Set oReport.event.finishdocument = fnVBEventHandler
		'Set oReport.event.finishprint = fnVBEventHandler
		'Set oReport.event.finishexport = fnVBEventHandler
		'Set oReport.event.finishprintresult = fnVBEventHandler
		'Set oReport.event.hyperlinkclicked = fnVBEventHandler
		'Set oReport.event.finishexportserver = fnVBEventHandler
		'Set oReport.event.buttonprintclickbefore = fnVBEventHandler
		'Set oReport.event.buttonprintclickafter = fnVBEventHandler
		'Set oReport.event.buttonexportclickbefore = fnVBEventHandler
		'Set oReport.event.buttonexportclickafter = fnVBEventHandler
		'Set oReport.event.buttonrefreshclickbefore = fnVBEventHandler
		'Set oReport.event.buttonrefreshclickafter = fnVBEventHandler	
		'Set oReport.event.buttonexportxlsclickbefore = fnVBEventHandler
		'Set oReport.event.buttonexportxlsclickafter = fnVBEventHandler		
		'Set oReport.event.buttonexportpdfclickbefore = fnVBEventHandler
		'Set oReport.event.buttonexportpdfclickafter = fnVBEventHandler	
		'Set oReport.event.buttonexporthwpclickbefore = fnVBEventHandler
		'Set oReport.event.buttonexporthwpclickafter = fnVBEventHandler
		'Set oReport.event.cancelprint = fnVBEventHandler
		'Set oReport.event.buttonclosewindowclickbefore = fnVBEventHandler
		'Set oReport.event.buttonclosewindowclickafter = fnVBEventHandler
		'Set oReport.event.printpage = fnVBEventHandler
		'Set oReport.event.cancelexport = fnVBEventHandler	
		'Set oReport.event.finishprintresult = fnVBEventHandler
		'Set oReport.event.rexperterror = fnVBEventHandler
		'Set oReport.event.errorevent = fnVBEventHandler
		Msgbox "event"
		'필수 - 레포트 실행
		Call oReport.iframe(ifrmRexPreview1)
		'Call oReport.open()
	End Sub

	Sub fnPrintAll()
		Dim oReportAll
		Set oReportAll = GetfnParamSet("printall")
		Dim oReport1
		Set oReport1 = GetfnParamSet("0")
		Dim oReport2
		Set oReport2 = GetfnParamSet("1")

		oReport1.rptname = "oracle1"
		oReport1.connectname = "ora1"
		Set oReport1.event.finishprint = fnVBEventHandler
		Set oReport1.event.finishprintall = fnVBEventHandler
		Set oReport1.event.finishprintalleach = fnVBEventHandler
		MsgBox "A"
		
		oReport2.rptname = "oracle2"
		oReport2.connectname = "ora2"
		Set oReport2.event.finishprint = fnVBEventHandler
		Set oReport2.event.finishprintall = fnVBEventHandler
		Set oReport2.event.finishprintalleach = fnVBEventHandler
		MsgBox "B"
		Call oReportAll.pushclear()
		Call oReportAll.push(oReport1)
		Call oReportAll.push(oReport2)
		
		Call oReportAll.printall(true, 1, -1, 1, "")
	End Sub

	Sub fnReportEvent(oRexCtl, sEvent, oArgs) 
		Msgbox "Call EventHandler"
			If sEvent = "init" Then
				Msgbox "Init"
				Call oRexCtl.SetCSS("appearance.toolbar.button.export.visible=0")
				Call oRexCtl.SetCSS("appearance.toolbar.button.refresh.visible=0")
				Call oRexCtl.UpdateCSS()
			ElseIf sEvent = "finishdocument" Then
				Msgbox "finishdocument"
			ElseIf sEvent = "finishprint" Then
				Msgbox "Call finishprint"
			ElseIf sEvent = "finishprintall" Then
				Msgbox "Call finishprintall"
			ElseIf sEvent = "finishprintalleach" Then
				Msgbox "Call finishprintalleach"
			ElseIf sEvent = "finishexport" Then
			ElseIf sEvent = "finishprintresult" Then
			ElseIf sEvent = "hyperlinkclicked" Then
			ElseIf sEvent = "finishexportserver" Then
			ElseIf sEvent = "buttonprintclickbefore" Then
			ElseIf sEvent = "buttonprintclickafter" Then
			ElseIf sEvent = "buttonexportclickbefore" Then
			ElseIf sEvent = "buttonexportclickafter" Then
			ElseIf sEvent = "buttonrefreshclickbefore" Then
			ElseIf sEvent = "buttonrefreshclickafter" Then
			ElseIf sEvent = "buttonexportxlsclickbefore" Then
			ElseIf sEvent = "buttonexportxlsclickafter" Then
			ElseIf sEvent = "buttonexportpdfclickbefore" Then
			ElseIf sEvent = "buttonexportpdfclickafter" Then
			ElseIf sEvent = "buttonexporthwpclickbefore" Then
			ElseIf sEvent = "buttonexporthwpclickafter" Then
			ElseIf sEvent = "cancelprint" Then
			ElseIf sEvent = "buttonclosewindowclickbefore" Then
			ElseIf sEvent = "buttonclosewindowclickafter" Then
			ElseIf sEvent = "printpage" Then
			ElseIf sEvent = "cancelexport" Then
			ElseIf sEvent = "finishprintresult" Then
			ElseIf sEvent = "rexperterror" Then
			ElseIf sEvent = "errorevent" Then
		End If
	End Sub		
</script>
<script type="text/javascript">
	function fnPrintAll2() {
		var oReportAll = GetfnParamSet("printall");
		var oReport1 = GetfnParamSet("0");
		oReport1.rptname = "oracle1";
		oReport1.connectname = "ora1";
		//oReport1.event.finishprint = fnReportEvent;
		
		var oReport2 = GetfnParamSet("1");
		oReport2.rptname = "oracle2";
		oReport2.connectname = "ora2";
		//oReport2.event.finishprint = fnReportEvent;
		
		oReportAll.pushclear();
		oReportAll.push(oReport1);
		oReportAll.push(oReport2);
		alert(oReport1);
		alert(oReport2);
		alert(oReportAll);
	
		
		//oReportAll.event.finishprintalleach = fnReportEvent;
		//oReportAll.event.finishprintall = fnReportEvent;
		
		oReportAll.printall(true, 1, -1, 1, "");   // 다이얼로그표시유무, 시작페이지, 끝페이지, 카피수, 옵션
	}
	function fnPrint() {
		var oReport1 = GetfnParamSet("0");
		oReport1.rptname = "oracle1";
		oReport1.connectname = "ora1";
		//oReport1.event.finishprint = fnReportEvent;
		
		//oReportAll.event.finishprintalleach = fnReportEvent;
		//oReportAll.event.finishprintall = fnReportEvent;
		
		oReport1.open();
	}
</script>
</head>
<body>
	<button onclick="fnOpen()">레포트 보기</button>
	<button onclick="fnPrintAll()">레포트 전체 출력</button>
	<button onclick="fnPrint()">레포트 출력</button>
	<iframe name="rex_ifrmRexPreview" id="rex_ifrmRexPreview" src='rexpreview.jsp' width="100%" height="400"></iframe>
	<iframe name="ifrmRexPreview1" id="ifrmRexPreview1" src='rexpreview.jsp' width="100%" height="400"></iframe>
</body>
</html>