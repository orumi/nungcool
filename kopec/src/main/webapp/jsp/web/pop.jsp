<%@ page contentType="text/html; charset=euc-kr" %>
<%	
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"))+"/jsp/web/";


%>

<script>
	var left_margin;
	var top_margin;
	
	function goMain() {
		if (screen.width >= 1024) {
			left_margin = (screen.width-1016)/2;
			top_margin = (screen.height-738)/2;
		} else {
			left_margin = 0;
			top_margin = 0;
		}
		
		url = "http://203.255.122.35:8088/bsc/jsp/web/loginProc.jsp?userId=admin";
 		w = window.open(url, 'BSC',"top=" + top_margin + ",left= " + left_margin + ",width=1016, height=738,toolbar=0,scrollbars=0,location=0,status=0,menubar=0");
	}

</script>

<html>
<head>
<title>NungCool BSC Manager</title>
<input type="button" value="goMain" onclick="javascript:goMain();">