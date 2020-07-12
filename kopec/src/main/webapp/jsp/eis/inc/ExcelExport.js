
	 function blueOneObjWrite(){
	    document.write('<OBJECT ID="exptool" WIDTH=100 HEIGHT=51 CLASSID="CLSID:178E9062-BA7B-4769-B0DC-AD8A013A2E6B" CODEBASE="./inc/ExcelExport.cab">');
	    document.write('<PARAM NAME="_Version" VALUE="65536">');
	    document.write('</OBJECT>');
    }   
	    
	//BlueDataGrid Exel Export
    function exportExcel(){
        if(exptool == null){
            alert('exptool is null');
        }else{
            try{
                exptool.exportExcel();
            }catch(e){
                var errorStr;
                errorStr = e +"\n";
                errorStr +=  e.number +"\n";
                errorStr +=  e.description +"\n";           
                alert(errorStr);
            }
   
        } 
        
    }

	blueOneObjWrite();