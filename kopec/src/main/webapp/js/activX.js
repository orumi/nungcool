function getActiveReport(realUrl,ServiceNm,ServiceURL,UserID,UserNM,UserGRP) {	
	document.write('<OBJECT ID="reportCtl" ');
	document.write('    classid="clsid:3C217DB6-B1BD-4813-9320-7AC0F3B08611" ');
	document.write('    codebase='+realUrl+'/jsp/web/Act_pBscReport.cab#version=1,2,1,3 > ');
	document.write('    width=946 height=631 align="center" hspace=0 vspace=0> ');
	document.write('    <param name="ServiceNm" value="'+ServiceNm+'"> ');
	document.write('    <param name="ServiceURL" value='+ServiceURL+'/jsp/xml/reportPrt/ > ');
	document.write('    <param name="UserID" value="'+UserID+'"> ');
	document.write('    <param name="UserNM" value="'+UserNM+'"> ');
	document.write('    <param name="UserGRP" value="'+UserGRP+'"> ');
	document.write('</OBJECT> ');
}  


