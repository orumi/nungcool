	$(document).ready(function() {



	});



	function actionExceptInit(){
		clearExceptEmp();

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(psnExceptInit, param)
    	.done(function(data){
    		//console.log("data : "+data.reCode);
    		if(data.selectExceptBsc.length > 0){

    			displayPsnExceptBsc(data.selectExceptBsc);
    			displayPsnEmp(data.selectPsnEmp);

    		} else {
    			console.log("data clear : "+data.selectPsnBaseLine.length);
    			clearBaseLine();
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});


	}


    var exceptBscHtml = "<tr role=\"row\" sid=\"###sid###\" scid=\"###scid###\" bid=\"###bid###\" bcid=\"###bcid###\"  >";
    exceptBscHtml += "<td style=\"\">###sname###</td>";
    exceptBscHtml += "<td style=\"\">###bname###</td>";
    exceptBscHtml += "<td style=\"\">###empcnt###</td>";
    exceptBscHtml += "</tr>";

    var curExceptBsc = null;
	function displayPsnExceptBsc(exceptBsc){
		curExceptBsc = null;
		$("#bd_bsc").empty();
		for(var i in exceptBsc){

			var bsc = exceptBsc[i];
    		var tmpHtml = exceptBscHtml.replace("###sid###",bsc.sid)
    		.replace("###scid###",bsc.scid)
    		.replace("###bid###",bsc.bid)
    		.replace("###bcid###",bsc.bcid)
    		.replace("###sname###",bsc.sname)
    		.replace("###bname###",bsc.bname)
    		.replace("###empcnt###",bsc.empcnt?bsc.empcnt:"");

    		$("#bd_bsc").append(tmpHtml);

		}
		$("#bd_bsc tr").click(function(){
			actionClickExceptBsc($(this));
		})

	}

	function actionClickExceptBsc(rowObj){
		$(curExceptBsc).removeClass("select_row");
		curExceptBsc = $(rowObj)
    	$(curExceptBsc).addClass("select_row");

		actionSelectExceptEmp();
	}




    var psnEmpHtml = "<tr role=\"row\" >";
    psnEmpHtml += "<td style=\"\">###empNo###</td>";
    psnEmpHtml += "<td style=\"\">###empNm###</td>";
    psnEmpHtml += "<td style=\"\">###jikgbNm###</td>";
    psnEmpHtml += "</tr>";

    var curPsnEmp = null;
	function displayPsnEmp(psnEmp){
		curPsnEmp = null;
		$("#bd_psnEmp").empty();
		for(var i in psnEmp){

			var emp = psnEmp[i];
    		var tmpHtml = psnEmpHtml.replace("###empNo###",emp.empNo)
    		.replace("###empNm###",emp.empNm)
    		.replace("###jikgbNm###",emp.jikgbNm?emp.jikgbNm:"")
    		.replace("###bcid###",emp.bcid);

    		$("#bd_psnEmp").append(tmpHtml);

		}

		$("#bd_psnEmp tr").click(function(){
			actionClickEmp($(this));
		})

	}

	function actionClickEmp(rowObj){
		$(curPsnEmp).removeClass("select_row");
		curPsnEmp = $(rowObj)
    	$(curPsnEmp).addClass("select_row");
	}



    var psnExceptEmpHtml = "<tr role=\"row\" >";
    psnExceptEmpHtml += "<td style=\"\">###sbunm###</td>";
    psnExceptEmpHtml += "<td style=\"\">###bscnm###</td>";
    psnExceptEmpHtml += "<td style=\"\">###empNo###</td>";
    psnExceptEmpHtml += "<td style=\"\">###empNm###</td>";
    psnExceptEmpHtml += "</tr>";

	function displayExceptEmp(psnExceptEmp){
		$("#bd_exceptEmp").empty();
		for(var i in psnExceptEmp){

			var bsc = psnExceptEmp[i];
    		var tmpHtml = psnExceptEmpHtml.replace("###sbunm###",bsc.sbunm)
    		.replace("###bscnm###",bsc.bscnm)
    		.replace("###empNo###",bsc.empNo)
    		.replace("###bcid###",bsc.bcid)
    		.replace("###empNm###",bsc.empNm);

    		$("#bd_exceptEmp").append(tmpHtml);

		}

		$("#bd_exceptEmp tr").click(function(){
			actionClickExceptEmp($(this));
		})

	}


	function actionSelectExceptEmp(){
		var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.bsccid   = $(curExceptBsc).attr("bcid");

    	_xAjax(psnExceptEmpURL, param)
    	.done(function(data){
    		if(data.selectPsnExceptEmp.length > 0){
    			displayExceptEmp(data.selectPsnExceptEmp);
    		} else {

    			clearExceptEmp();
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}

	function clearExceptEmp(){
		curExceptEmp = null;
		$("#bd_exceptEmp").empty();
	}


	var curExceptEmp = null;
	function addExceptEmp(){
		if(!curPsnEmp){
			alert("제외 대상자를 선택하십시오.");
			return;
		}

		if(!curExceptBsc){
			alert("부서를 선택하십시오.");
			return;
		}

		var rdObj = $(curPsnEmp).children();
		var rdBsc = $(curExceptBsc).children();

		var empNo = rdObj.eq(0).text();
		var step = true;
		$("#bd_exceptEmp tr").each(function(i){
    		var trObj = $("#bd_exceptEmp tr").eq(i);
    		var tdObj = trObj.children();

    		if(empNo == tdObj.eq(2).text()){
    			step = false;
    		}
    	});


		if(step){
	   		var tmpHtml = psnExceptEmpHtml.replace("###sbunm###",rdBsc.eq(0).text())
	   		.replace("###bscnm###",rdBsc.eq(1).text())
	   		.replace("###empNo###",rdObj.eq(0).text())
	   		.replace("###bcid###", $(curExceptBsc).attr("bcid"))
	   		.replace("###empNm###",rdObj.eq(1).text());

	   		$("#bd_exceptEmp").append(tmpHtml);

	   		$("#bd_exceptEmp tr").click(function(){
				actionClickExceptEmp($(this));
			})
		}

	}



	function delExceptEmp(){
		$(curExceptEmp).remove();

		curExceptEmp = null;
	}
	function actionClickExceptEmp(rowObj){
		$(curExceptEmp).removeClass("select_row");
		curExceptEmp = $(rowObj)
    	$(curExceptEmp).addClass("select_row");
	}


	function actionExceptEmp(){
		var aParam = new Array();

		var bscid = $(curExceptBsc).attr("bid");
		var bsccid = $(curExceptBsc).attr("bcid");
		var sbuid = $(curExceptBsc).attr("sid");
		var sbucid = $(curExceptBsc).attr("scid");

    	$("#bd_exceptEmp tr").each(function(i){
    		var trObj = $("#bd_exceptEmp tr").eq(i);
    		var tdObj = trObj.children();


			var pm = new Object();
			pm.bscid  = bscid;
			pm.bsccid = bsccid;
			pm.sbuid  = sbuid;
			pm.sbucid = sbucid;
			pm.empNo  = tdObj.eq(2).text();
			pm.year   = $("#selYear option:selected").val();

			aParam.push(pm);


    	});

    	var param = new Object();

    	param.year = $("#selYear option:selected").val();
    	param.bscid = bscid;
    	param.bsccid = bsccid;
    	param.sbuid = sbuid;
    	param.sbucid = sbucid;
    	param.exceptEmp = JSON.stringify(aParam);


    	_xAjax(adjustPsnExceptEmpURL, param)
    	.done(function(data){
    		if(data.selectExceptBsc.length > 0){
    			displayPsnExceptBsc(data.selectExceptBsc);
    			clearExceptEmp();
    			alert("저장되었습니다.");
    		} else {
    			//clearBaseLine();
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}










	/* except labor*/
	//bd_laborEmp
	//bd_laborUser
	function actionLaborInit(){
		clearLaborUser();
		clearLaborEmp();

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(psnLaborInitURL, param)
    	.done(function(data){
			displayLaborUser(data.selectPsnEmp);
			displayLaborEmp(data.selectPsnLabor);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});


	}

	function clearLaborUser(){
		curLaborUser = null;
    	$("#bd_laborUser").empty();
	}

	function displayLaborUser(psnEmp){
		clearLaborUser();
    	for(var i in psnEmp){
    		var emp = psnEmp[i];
    		var tmpHtml = psnEmpHtml.replace("###empNo###",emp.empNo)
    		.replace("###empNm###",emp.empNm)
    		.replace("###jikgbNm###",emp.jikgbNm?emp.jikgbNm:"")
    		.replace("###bcid###",emp.bcid);

    		$("#bd_laborUser").append(tmpHtml);
    	}

    	$("#bd_laborUser tr").click(function(){
    		actionClickLaborUser($(this));
		})
	}

    var curLaborUser ;

    function actionClickLaborUser(rowObj){
    	$(curLaborUser).removeClass("select_row");
    	curLaborUser = $(rowObj)
    	$(curLaborUser).addClass("select_row");
    }










    var psnLaborEmpHtml = "<tr role=\"row\" >";
    psnLaborEmpHtml += "<td style=\"\">###empNo###</td>";
    psnLaborEmpHtml += "<td style=\"\">###empNm###</td>";
    psnLaborEmpHtml += "</tr>";

    var curLaborEmp;
	function displayLaborEmp(psnLaborEmp){
		clearLaborEmp();
		for(var i in psnLaborEmp){

			var laborEmp = psnLaborEmp[i];
    		var tmpHtml = psnLaborEmpHtml.replace("###empNo###",laborEmp.empNo)
    		.replace("###empNm###",laborEmp.empNm);

    		$("#bd_laborEmp").append(tmpHtml);

		}

		$("#bd_laborEmp tr").click(function(){
			actionClickLaborEmp($(this));
		})
	}
    function actionClickLaborEmp(rowObj){
    	$(curLaborEmp).removeClass("select_row");
    	curLaborEmp = $(rowObj)
    	$(curLaborEmp).addClass("select_row");
    }




	function clearLaborEmp(){
		curLaborEmp = null;
		$("#bd_laborEmp").empty();
	}


	function addLaborEmp(){
		if(!curLaborUser) {
			alert("제외 대상자를 선택하십시오.");
			return;
		}

		var rdObj = $(curLaborUser).children();

		var empNo = rdObj.eq(0).text();

		var step = true;
		$("#bd_laborEmp tr").each(function(i){
    		var trObj = $("#bd_laborEmp tr").eq(i);
    		var tdObj = trObj.children();

    		if(empNo == tdObj.eq(0).text()){
    			step = false;
    		}
		});

		if(step){
    		var tmpHtml = psnLaborEmpHtml.replace("###empNo###",rdObj.eq(0).text())
    		.replace("###empNm###",rdObj.eq(1).text());

    		$("#bd_laborEmp").append(tmpHtml);

    		$("#bd_laborEmp tr").click(function(){
    			actionClickLaborEmp($(this));
    		})
		}

	}


	function delLaborEmp(){
		if(!curLaborEmp) {
			alert("삭제 대상자를 선택하십시오.");
			return;
		}

		$(curLaborEmp).remove();

		curLaborEmp = null;
	}


	function actionLaborEmp(){

		var aParam = new Array();

    	$("#bd_laborEmp tr").each(function(i){
    		var trObj = $("#bd_laborEmp tr").eq(i);
    		var tdObj = trObj.children();

			var pm = new Object();
			pm.empNo  = tdObj.eq(0).text();
			pm.year   = $("#selYear option:selected").val();

			aParam.push(pm);


    	});

    	var param = new Object();

    	param.year = $("#selYear option:selected").val();
    	param.laborEmp = JSON.stringify(aParam);


    	_xAjax(adjustPsnLaborEmpURL, param)
    	.done(function(data){
			displayLaborEmp(data.selectPsnLabor);
			alert("저장되었습니다.");

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

	}






	function actionPsnBscScore(){

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(psnBscScoreURL, param)
    	.done(function(data){
    		//console.log("data : "+data.reCode);
    		alert("저장되었습니다.");

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

	}


	function actionPsnBizMh(){

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(psnBizMhURL, param)
    	.done(function(data){
    		//console.log("data : "+data.reCode);
    		alert("저장되었습니다.");

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

	}

	function actionPsnScore(){

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(psnScoreURL, param)
    	.done(function(data){
    		//console.log("data : "+data.reCode);
    		alert("저장되었습니다.");

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

	}




































