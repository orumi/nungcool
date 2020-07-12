	$(document).ready(function() {

		var date = new Date();
		var year = date.getFullYear();
		funcSetDate(year);

		actionInit();

		 $("#selYear").change(function(){ actionInit(); });


	});


    function funcSetDate(curYear) {
        for (i=0,j=curYear-6; i<=6;i++,j++) {
        	 $("#selYear").append("<option value='"+j+"'>"+j+"</option>");
        }
        $("#selYear option:eq(5)").attr("selected", "selected");
    }




    function actionInit(){
    	/* select tblpsnbaseline */

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(selectInit, param)
    	.done(function(data){
    		//console.log("data : "+data.reCode);
    		//if(data.selectPsnBaseLine.length > 0){
    			displayBaseLine(data.selectPsnBaseLine);
    			displayJikgub(data.selectPsnJikgub);

    			displayPsnBscMapping(data.selectPsnBscMapping);
    			displayPsnSbuMapping(data.selectPsnSubMapping);

    		//} else {
    			//console.log("data clear : "+data.selectPsnBaseLine.length);
    			//clearBaseLine();
    		//}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});


    }


    function actionPsnBaseLine(){
    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.rCo   = $("#rCo").val();
    	param.r1S	= $("#r1S").val();
    	param.r1A	= $("#r1A").val();
    	param.r1B	= $("#r1B").val();
    	param.r1C	= $("#r1C").val();
    	param.r1D	= $("#r1D").val();
    	param.r2S	= $("#r2S").val();
    	param.r2A	= $("#r2A").val();
    	param.r2B	= $("#r2B").val();
    	param.r2C	= $("#r2C").val();
    	param.r2D	= $("#r2D").val();
    	param.exceptBscmh	= $("#exceptBscmh").val();
    	param.exceptMh	= $("#exceptMh").val();

    	_xAjax(psnBaseLine, param)
    	.done(function(data){
    		if(data.selectPsnBaseLine.length > 0){
    			displayBaseLine(data.selectPsnBaseLine);
    			alert("저장되었습니다.");
    		} else {
    			clearBaseLine();
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }


    function actionPsnBaseLineDelete(){

    	if(confirm("삭세시 기존 데이타가 모두 초기화됩니다. \r입력테이타를 삭제하시겠습니까?")){
	    	var param = new Object();
	    	param.year = $("#selYear option:selected").val();

	    	_xAjax(deletePsnBaseLine, param)
	    	.done(function(data){
    			alert("삭제되었습니다.");

    			displayBaseLine(data.selectPsnBaseLine[0]);
    			displayJikgub(data.selectPsnJikgub);

    			displayPsnBscMapping(data.selectPsnBscMapping);
    			displayPsnSbuMapping(data.selectPsnSubMapping);


	    	}).fail(function(error){
	    		console.log("actionInit error : "+error);
	    	});

    	}
    }


    function displayBaseLine(psnBaseLine){
    	if(psnBaseLine && psnBaseLine.length>0){
        	$("#rCo").val(psnBaseLine[0].RCo);
        	$("#r1S").val(psnBaseLine[0].r1S);
        	$("#r1A").val(psnBaseLine[0].r1A);
        	$("#r1B").val(psnBaseLine[0].r1B);
        	$("#r1C").val(psnBaseLine[0].r1C);
        	$("#r1D").val(psnBaseLine[0].r1D);
        	$("#r2S").val(psnBaseLine[0].r2S);
        	$("#r2A").val(psnBaseLine[0].r2A);
        	$("#r2B").val(psnBaseLine[0].r2B);
        	$("#r2C").val(psnBaseLine[0].r2C);
        	$("#r2D").val(psnBaseLine[0].r2D);
        	$("#exceptBscmh").val(psnBaseLine[0].exceptBscmh);
        	$("#exceptMh").val(psnBaseLine[0].exceptMh);
    	} else {
    		clearBaseLine();
    	}

    }

    function clearBaseLine(){
    	$("#rCo").val("");
    	$("#r1S").val("");
    	$("#r1A").val("");
    	$("#r1B").val("");
    	$("#r1C").val("");
    	$("#r1D").val("");
    	$("#r2S").val("");
    	$("#r2A").val("");
    	$("#r2B").val("");
    	$("#r2C").val("");
    	$("#r2D").val("");
    	$("#exceptBscmh").val("");
    	$("#exceptMh").val("");
    }

   /* jikgub */
    var curRowId = 0;
    var psnJikgubHtml = "<tr role=\"row\" id=\"####rowId###\">";
    psnJikgubHtml += "<td style=\"padding:0px;\"><input type=\"text\" style=\"width:100%\"/></td>";
    psnJikgubHtml += "<td style=\"padding:0px;\"><input type=\"text\" style=\"width:100%\"/></td>";
    psnJikgubHtml += "<td style=\"padding:0px;text-align: center\"><a class=\"btn btn-default btn-sm\" onClick=\"javascript:delPsnJikgub('####id###');\">삭제</a></td>";
    psnJikgubHtml += "</tr>";

    function addPsnJikgub(){
    	var tmpHtml = "";
    	curRowId = curRowId + 1;
    	var newRowId = "rowId_"+curRowId;
    	tmpHtml = psnJikgubHtml.replace("####rowId###",newRowId).replace("####id###",newRowId);
    	$("#bd_psnJikgub").append(tmpHtml);

    	return newRowId;
    }

    function delPsnJikgub(rowId){
    	$("#"+rowId).remove();
    }

    function actionPsnJikgub(){
    	var aParam = new Array();
    	$("#bd_psnJikgub tr").each(function(i){
    		var trObj = $("#bd_psnJikgub tr").eq(i);
    		var tdObj = trObj.children();

    		var pm = new Object();
    		pm.year = $("#selYear option:selected").val();
    		pm.jikGubCd = tdObj.eq(0).find("input").val();
    		pm.jikGubNm = tdObj.eq(1).find("input").val();

    		aParam.push(pm);

    	});

    	var param = new Object();
    	param.jikgubs = JSON.stringify(aParam);


    	_xAjax(psnJikgub, param)
    	.done(function(data){
    		if(data.selectPsnJikgub.length > 0){
    			displayJikgub(data.selectPsnJikgub);
    			alert("저장되었습니다.");
    		} else {
    			clearBaseLine();
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
    }

    function displayJikgub(psnJikgub){
    	clearJikgub();

    	for(var i in psnJikgub){
    		var rowId = addPsnJikgub();

    		var trObj = $("#"+rowId);
    		var tdObj = trObj.children();

    		tdObj.eq(0).find("input").val(psnJikgub[i].jikgubCd);
    		tdObj.eq(1).find("input").val(psnJikgub[i].jikgubNm);
    	}
    }

    function clearJikgub(){
    	curRowId = 0;
    	$("#bd_psnJikgub").empty();
    }






    /* psnSubMapping */
    var curBscMap ;

    function actionClickBsc(rowObj){
    	$(curBscMap).removeClass("select_row");
    	curBscMap = $(rowObj)
    	$(curBscMap).addClass("select_row");
    }

    function addBscMapping(){
    	if(!curBscMap){
    		alert("단본부를 선택하십시오.");
    		return;
    	}

    	if(!curSbuMap){
    		alert("평가군을 선택하십시오.");
    		return;
    	}


    	var rdObj = $(curBscMap).children();
    	var bscid = $(curBscMap).attr("bscid");
    	var bsccid = rdObj.eq(0).text()

    	var tgtTdObj = $(curSbuMap).children();

    	$(curSbuMap).attr("bscid", bscid);
    	$(curSbuMap).attr("bsccid", bsccid);
    	tgtTdObj.eq(1).text(rdObj.eq(1).text());

    }

    function delBscMapping(){
    	if(!curSbuMap){
    		alert("평가군을 선택하십시오.");
    		return;
    	}

    	var tgtTdObj = $(curSbuMap).children();

    	$(curSbuMap).attr("bscid", "");
    	$(curSbuMap).attr("bsccid", "");
    	tgtTdObj.eq(1).text("");

    }

    var bscMappingHtml = "<tr role=\"row\" bscid=\"###bscid###\">";
    bscMappingHtml += "<td style=\"\">###bsccid###</td>";
    bscMappingHtml += "<td style=\"\">###bscnm###</td>";
    bscMappingHtml += "</tr>";

    function displayPsnBscMapping(psnBscMapping){
    	curBscMap = null;
    	$("#bd_bscMapping").empty();
    	for(var i in psnBscMapping){
    		var bscMapping = psnBscMapping[i];
    		var tmpHtml = bscMappingHtml.replace("###bscid###",bscMapping.bscid)
    		.replace("###bsccid###",bscMapping.bsccid)
    		.replace("###bscnm###",bscMapping.bscnm);

    		$("#bd_bscMapping").append(tmpHtml);
    	}

		$("#bd_bscMapping tr").click(function(){
			actionClickBsc($(this));
		})

    }


    var sbuMappingHtml = "<tr role=\"row\" bscid=\"###bscid###\" bsccid=\"###bsccid###\">";
    sbuMappingHtml += "<td style=\"\" sbuid=\"###sbuid###\" sbucid=\"###sbucid###\">###sbunm###</td>";
    sbuMappingHtml += "<td style=\"\">###bscnm###</td>";
    sbuMappingHtml += "</tr>";

    function displayPsnSbuMapping(psnSbuMapping){
    	curSbuMap = null;
    	$("#bd_sbuMapping").empty();
    	for(var i in psnSbuMapping){
    		var sbuMapping = psnSbuMapping[i];
    		var tmpHtml = sbuMappingHtml.replace("###bscid###",sbuMapping.bscid?sbuMapping.bscid:"")
    		.replace("###bsccid###",sbuMapping.bsccid?sbuMapping.bsccid:"")
    		.replace("###sbuid###",sbuMapping.sbuid).replace("###sbucid###",sbuMapping.sbucid)
    		.replace("###bscnm###",sbuMapping.bscnm?sbuMapping.bscnm:"")
    		.replace("###sbunm###",sbuMapping.sbunm);

    		$("#bd_sbuMapping").append(tmpHtml);
    	}

    	$("#bd_sbuMapping tr").click(function(){
			actionClickSbu($(this));
		})

    }

    var curSbuMap ;

    function actionClickSbu(rowObj){
    	$(curSbuMap).removeClass("select_row");
    	curSbuMap = $(rowObj)
    	$(curSbuMap).addClass("select_row");
    }



    function actionPsnSbuMapping(){
    	var aParam = new Array();
    	$("#bd_sbuMapping tr").each(function(i){
    		var trObj = $("#bd_sbuMapping tr").eq(i);
    		var tdObj = trObj.children();

    		var bscid = $(trObj).attr("bscid");

    		if(bscid!=null && ""!=bscid){
    			console.log("bscid : "+bscid);
    			var bsccid = $(trObj).attr("bsccid");

    			var pm = new Object();
    			pm.bscid = bscid;
    			pm.bsccid = bsccid;
    			pm.sbuid = tdObj.eq(0).attr("sbuid");
    			pm.sbucid = tdObj.eq(0).attr("sbucid");
    			pm.year = $("#selYear option:selected").val();

    			aParam.push(pm);
    		}


    	});

    	var param = new Object();

    	param.year = $("#selYear option:selected").val();
    	param.subMapping = JSON.stringify(aParam);


    	_xAjax(psnSbuMapping, param)
    	.done(function(data){
    		if(data.selectPsnSubMapping.length > 0){
    			displayPsnSbuMapping(data.selectPsnSubMapping);
    			alert("저장되었습니다.");
    		} else {
    			//clearBaseLine();
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});



    }



    function openExceptUser(){
    	$("#div_properties").show();
		$(".wrap").after("<div class='overlay'></div>");

		actionExceptInit();
    }


    function closeExceptUser(){
    	$("#div_properties").hide();
    	$(".wrap").after("<div class='overlay'></div>");

    	$(".overlay").remove();
    }


    function openExceptLabor(){
    	$("#div_labor").show();
		$(".wrap").after("<div class='overlay'></div>");

		actionLaborInit();
    }


    function closeExceptLabor(){
    	$("#div_labor").hide();
    	$(".wrap").after("<div class='overlay'></div>");

    	$(".overlay").remove();
    }














    /* 5등급 세부 배분포 */

    // select grade
    function seletePsnGrade(){
    	var param = new Object();

    	param.year = $("#selYear option:selected").val();

    	_xAjax(psnGradeURL, param)
    	.done(function(data){
    		if(data.selectPsnGradeBase.length > 0){
    			displayPsnGrade(data.selectPsnGradeBase);
    		} else {
    			//clearBaseLine();
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});



    }

    var psnGradeHtml = "<tr role=\"row\" >";
    psnGradeHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###org_cnt###\"/></td>";
    psnGradeHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###org_s###\"/></td>";
    psnGradeHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###org_a###\"/></td>";
    psnGradeHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###org_b###\"/></td>";
    psnGradeHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###org_c###\"/></td>";
    psnGradeHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###org_d###\"/></td>";
    psnGradeHtml += "</tr>";

    //db_psnGrade
    function displayPsnGrade(psnGradeBase){
    	$("#db_psnGrade").empty();
    	for(var i in psnGradeBase){
    		var psnGrade = psnGradeBase[i];
    		var tmpHtml = psnGradeHtml.replace("###org_cnt###",psnGrade.orgCnt)
    		.replace("###org_s###",psnGrade.orgS?psnGrade.orgS:"")
    		.replace("###org_a###",psnGrade.orgA?psnGrade.orgA:"")
    		.replace("###org_b###",psnGrade.orgB?psnGrade.orgB:"")
    		.replace("###org_c###",psnGrade.orgC?psnGrade.orgC:"")
    		.replace("###org_d###",psnGrade.orgD?psnGrade.orgD:"");

    		$("#db_psnGrade").append(tmpHtml);
    	}
    	/*console.log(psnGradeBase);*/
    }

    // add grade
    function addPsnGrade(){
    	var tmpHtml = psnGradeHtml.replace("###org_cnt###", "")
		.replace("###org_s###", "")
		.replace("###org_a###", "")
		.replace("###org_b###", "")
		.replace("###org_c###", "")
		.replace("###org_d###", "");

		$("#db_psnGrade").append(tmpHtml);
    }


    // adjust grade
    function adjustPsnGrade(){

    	var aParam = new Array();

    	var step = true;
    	$("#db_psnGrade tr").each(function(i){
    		var trObj = $("#db_psnGrade tr").eq(i);
    		var tdObj = trObj.children();

			var pm = new Object();
			pm.year   = $("#selYear option:selected").val();
			pm.orgCnt  = tdObj.eq(0).find("input").val();
			pm.orgS  = tdObj.eq(1).find("input").val();
			pm.orgA  = tdObj.eq(2).find("input").val();
			pm.orgB  = tdObj.eq(3).find("input").val();
			pm.orgC  = tdObj.eq(4).find("input").val();
			pm.orgD  = tdObj.eq(5).find("input").val();

			if(pm.orgCnt > 0){
				var totCnt = Number(pm.orgS)+Number(pm.orgA)+Number(pm.orgB)+Number(pm.orgC)+Number(pm.orgD);
				if( Number(pm.orgCnt) != Number(totCnt) ){
					alert("평가등급갯수와 부서수가 일치하지 않습니다. 부서수 :"+pm.orgCnt);
					step = false;
					return;
				}

				for(var j in aParam){
					var tmpCnt = aParam[j].orgCnt;
					if(pm.orgCnt == tmpCnt){
						step = false;
						alert("같은 부서수가 등록되어이습니다. 부서수 : "+pm.orgCnt);
					}
				}
				/* */
				aParam.push(pm);
			}

    	});

    	if(step){
	    	var param = new Object();
	    	param.year = $("#selYear option:selected").val();
	    	param.psnGrade = JSON.stringify(aParam);

	    	_xAjax(adjustPsnGradeURL, param)
	    	.done(function(data){
	    		if(data.selectPsnGradeBase.length > 0){
	    			displayPsnGrade(data.selectPsnGradeBase);
	    			alert("저장되었습니다.");
	    		}
	    	}).fail(function(error){
	    		console.log("actionInit error : "+error);
	    	});
    	}

    }













    /*  부서별 성과 지급률 */
    function selectPsnBscGrade(){
    	var param = new Object();

    	param.year = $("#selYear option:selected").val();

    	_xAjax(psnBscGradeURL, param)
    	.done(function(data){
    		if(data.selectPsnBscGrade.length > 0){
    			displayPsnBscGrade(data.selectPsnBscGrade);
    		} else {
    			clearPsnBscGrade();
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }

    var psnGradeBscHtml = "<tr role=\"row\" bscid=\"###bscid###\">";
    psnGradeBscHtml += "<td class=\"\">###sbunm###</td>";
    psnGradeBscHtml += "<td class=\"\">###bscnm###</td>";
    psnGradeBscHtml += "<td class=\"\">###scoreQty###</td>";
    psnGradeBscHtml += "<td class=\"\">###scoreQly###</td>";
    psnGradeBscHtml += "<td class=\"\">###scoreSum###</td>";
    psnGradeBscHtml += "<td class=\"\">###scoreAdd###</td>";
    psnGradeBscHtml += "<td class=\"\">###scoreSum###</td>";
    psnGradeBscHtml += "<td class=\"\">###grpRank###</td>";
    psnGradeBscHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###grade1###\"/></td>";
    psnGradeBscHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###grade2###\"/></td>";
    psnGradeBscHtml += "<td class=\"\">###orgRate1###</td>";
    psnGradeBscHtml += "<td class=\"\">###orgRate2###</td>";
    psnGradeBscHtml += "</tr>";

    function displayPsnBscGrade(psnBscGrade){
    	clearPsnBscGrade();
    	for(var i in psnBscGrade){

			var bscGrade = psnBscGrade[i];
    		var tmpHtml = psnGradeBscHtml.replace("###bscid###",bscGrade.bscid?bscGrade.bscid:"").replace("###sbunm###",bscGrade.sbunm?bscGrade.sbunm:"")
    		.replace("###bscnm###",bscGrade.bscnm?bscGrade.bscnm:"").replace("###scoreQty###",bscGrade.scoreQty?bscGrade.scoreQty:"")
    		.replace("###scoreQly###",bscGrade.scoreQly?bscGrade.scoreQly:"").replace("###scoreSum###",bscGrade.scoreSum?bscGrade.scoreSum:"")
    		.replace("###scoreAdd###",bscGrade.scoreAdd?bscGrade.scoreAdd:"")
    		.replace("###scoreSum###",bscGrade.scoreSum?bscGrade.scoreSum:"").replace("###grpRank###",bscGrade.grpRank?bscGrade.grpRank:"")
    		.replace("###grade1###",bscGrade.grade1?bscGrade.grade1:"").replace("###grade2###",bscGrade.grade2?bscGrade.grade2:"")
    		.replace("###orgRate1###",bscGrade.orgRate1?bscGrade.orgRate1:"").replace("###orgRate2###",bscGrade.orgRate2?bscGrade.orgRate2:"")
    		;

    		$("#bd_psnBscGrade").append(tmpHtml);

		}
    }

    function clearPsnBscGrade(){
    	$("#bd_psnBscGrade").empty();
    }


    function adjustPsnBscGrade(){
    	var param = new Object();

    	param.year = $("#selYear option:selected").val();
    	param.val = getValStr(); //"28813,B,B,U`28814,C,C,U`28815,,,U";

    	_xAjax(adjustPsnBscGradeURL, param)
    	.done(function(data){
    		if(data.selectPsnBscGrade.length > 0){
    			alert("저장하였습니다.");
    			displayPsnBscGrade(data.selectPsnBscGrade);
    		} else {
    			clearPsnBscGrade();
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }

    function getValStr(){
    	var tmpStr = "";
    	$("#bd_psnBscGrade tr").each(function(i){
    		var trObj = $("#bd_psnBscGrade tr").eq(i);
    		var tdObj = trObj.children();
    		var bscid = $(trObj).attr("bscid");
    		tmpStr = tmpStr+"`"+bscid+","+tdObj.eq(8).find("input").val()+","+tdObj.eq(9).find("input").val()+",U";
		});

    	return tmpStr;

    }








    /*  부서별 성과 지급률 */
    function selectPsnBizMh(){

    	var param = new Object();

    	param.year = $("#selYear option:selected").val();
    	param.empNm = $("#txtEmpNm").val();

    	_xAjax(psnBizMhURL, param)
    	.done(function(data){
    		if(data.selectPsnBizMh.length > 0){
    			displayPsnBizMh(data.selectPsnBizMh);
    		} else {
    			$("#bd_psnBizMh").empty();
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }


    var psnBizMhHtml = "<tr role=\"row\" >";
    psnBizMhHtml += "<td class=\"\">###empNo###</td>";
    psnBizMhHtml += "<td class=\"\">###empNm###</td>";
    psnBizMhHtml += "<td class=\"\">###jikgbNm###</td>";
    psnBizMhHtml += "<td class=\"\">###deptCd###</td>";
    psnBizMhHtml += "<td class=\"\">###deptNm###</td>";
    psnBizMhHtml += "<td class=\"\">###mh###</td>";
    psnBizMhHtml += "<td class=\"\">###exceptCmt###</td>";
    psnBizMhHtml += "</tr>";

    function displayPsnBizMh(psnBizMh){
    	$("#bd_psnBizMh").empty();
    	for(var i in psnBizMh){

			var bizMh = psnBizMh[i];
    		var tmpHtml = psnBizMhHtml.replace("###empNo###",bizMh.empNo?bizMh.empNo:"")
    		.replace("###empNm###",bizMh.empNm?bizMh.empNm:"")
    		.replace("###jikgbNm###",bizMh.jikgbNm?bizMh.jikgbNm:"")
    		.replace("###deptCd###",bizMh.deptCd?bizMh.deptCd:"")
    		.replace("###deptNm###",bizMh.deptNm?bizMh.deptNm:"")
    		.replace("###mh###",bizMh.mh?bizMh.mh:"")
    		.replace("###exceptCmt###",bizMh.exceptCmt?bizMh.exceptCmt:"")
    		;

    		$("#bd_psnBizMh").append(tmpHtml);

		}
    }





    /*  부서별 성과 지급률 */
    function selectPsnScore(){

    	var param = new Object();

    	param.year = $("#selYear option:selected").val();
    	param.empNm = $("#txtEmpNm2").val();

    	_xAjax(psnScoreURL, param)
    	.done(function(data){
    		if(data.selectPsnScore.length > 0){
    			displayPsnScore(data.selectPsnScore);
    		} else {
    			$("#bd_psnScore").empty();
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }


    var psnScoreHtml = "<tr role=\"row\" >";
    psnScoreHtml += "<td class=\"\">###empNo###</td>";
    psnScoreHtml += "<td class=\"\">###empNm###</td>";
    psnScoreHtml += "<td class=\"\">###jikgbNm###</td>";
    psnScoreHtml += "<td class=\"\">###bscRate###</td>";
    psnScoreHtml += "<td class=\"\">###sbunm###</td>";
    psnScoreHtml += "<td class=\"\">###sbuGrade###</td>";
    psnScoreHtml += "<td class=\"\">###bscnm###</td>";
    psnScoreHtml += "<td class=\"\">###bscGrade###</td>";
    psnScoreHtml += "<td class=\"\">###bscRate###</td>";
    psnScoreHtml += "<td class=\"\">###bscMh###</td>";
    psnScoreHtml += "<td class=\"\">###bscMhRate###</td>";
    psnScoreHtml += "<td class=\"\">###bscMhSum###</td>";
    psnScoreHtml += "<td class=\"\">###deptCd###</td>";
    psnScoreHtml += "<td class=\"\">###deptNm###</td>";
    psnScoreHtml += "<td class=\"\">###mh###</td>";
    psnScoreHtml += "</tr>";

    function displayPsnScore(psnScore){
    	$("#bd_psnScore").empty();
    	for(var i in psnScore){

			var bizScr = psnScore[i];
    		var tmpHtml = psnScoreHtml.replace("###empNo###",bizScr.empNo?bizScr.empNo:"")
    		.replace("###empNm###",bizScr.empNm?bizScr.empNm:"")
    		.replace("###jikgbNm###",bizScr.jikgbNm?bizScr.jikgbNm:"")
    		.replace("###bscRate###",bizScr.bscRate?bizScr.bscRate:"")
    		.replace("###sbunm###",bizScr.sbunm?bizScr.sbunm:"")
    		.replace("###sbuGrade###",bizScr.sbuGrade?bizScr.sbuGrade:"")
    		.replace("###bscnm###",bizScr.bscnm?bizScr.bscnm:"")
    		.replace("###bscGrade###",bizScr.bscGrade?bizScr.bscGrade:"")
    		.replace("###bscRate###",bizScr.bscRate?bizScr.bscRate:"")
    		.replace("###bscMh###",bizScr.bscMh?bizScr.bscMh:"")
    		.replace("###bscMhRate###",bizScr.bscMhRate?bizScr.bscMhRate:"")
    		.replace("###bscMhSum###",bizScr.bscMhSum?bizScr.bscMhSum:"")
    		.replace("###deptCd###",bizScr.deptCd?bizScr.deptCd:"")
    		.replace("###deptNm###",bizScr.deptNm?bizScr.deptNm:"")
    		.replace("###mh###",bizScr.mh?bizScr.mh:"")
    		;

    		$("#bd_psnScore").append(tmpHtml);

		}
    }






    /*  기준 성과 지급률 */
    function selectPsnScoreList(){

    	var param = new Object();

    	param.year = $("#selYear option:selected").val();
    	param.empNm = $("#txtEmpNm3").val();

    	_xAjax(psnScoreListURL, param)
    	.done(function(data){
    		if(data.selectPsnScoreList.length > 0){
    			displayPsnScoreList(data.selectPsnScoreList);
    		} else {
    			$("#bd_psnScoreList").empty();
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }


    var psnScoreListHtml = "<tr role=\"row\" >";
    psnScoreListHtml += "<td class=\"\">###empNo###</td>";
    psnScoreListHtml += "<td class=\"\">###empNm###</td>";
    psnScoreListHtml += "<td class=\"\">###jikgbNm###</td>";
    psnScoreListHtml += "<td class=\"\">###bscRate###</td>";
    psnScoreListHtml += "<td class=\"\">###sbunm###</td>";
    psnScoreListHtml += "<td class=\"\">###sbuGrade###</td>";
    psnScoreListHtml += "<td class=\"\">###bscnm###</td>";
    psnScoreListHtml += "<td class=\"\">###bscGrade###</td>";
    psnScoreListHtml += "<td class=\"\">###bscRate###</td>";
    psnScoreListHtml += "<td class=\"\">###bscMh###</td>";
    psnScoreListHtml += "<td class=\"\">###bscMhRate###</td>";
    psnScoreListHtml += "<td class=\"\">###bscMhSum###</td>";
    psnScoreListHtml += "</tr>";

    function displayPsnScoreList(psnScoreList){
    	$("#bd_psnScoreList").empty();
    	for(var i in psnScoreList){

			var bizScr = psnScoreList[i];
    		var tmpHtml = psnScoreListHtml.replace("###empNo###",bizScr.empNo?bizScr.empNo:"")
    		.replace("###empNm###",bizScr.empNm?bizScr.empNm:"")
    		.replace("###jikgbNm###",bizScr.jikgbNm?bizScr.jikgbNm:"")
    		.replace("###bscRate###",bizScr.bscRate?bizScr.bscRate:"")
    		.replace("###sbunm###",bizScr.sbunm?bizScr.sbunm:"")
    		.replace("###sbuGrade###",bizScr.sbuGrade?bizScr.sbuGrade:"")
    		.replace("###bscnm###",bizScr.bscnm?bizScr.bscnm:"")
    		.replace("###bscGrade###",bizScr.bscGrade?bizScr.bscGrade:"")
    		.replace("###bscRate###",bizScr.bscRate?bizScr.bscRate:"")
    		.replace("###bscMh###",bizScr.bscMh?bizScr.bscMh:"")
    		.replace("###bscMhRate###",bizScr.bscMhRate?bizScr.bscMhRate:"")
    		.replace("###bscMhSum###",bizScr.bscMhSum?bizScr.bscMhSum:"")
    		;

    		$("#bd_psnScoreList").append(tmpHtml);

		}
    }


    //dt_psnBizHm
    function actionDownloadCSV(tblNm){

    	var tblObj = $("#"+tblNm);
    	var csvCntnt = "";
    	$("#"+tblNm+" thead tr th").each(function(i){
    		csvCntnt += $(this).text().replace(/"/g, '""').replace(/,/g , '\\,')+",";
    	});
    	csvCntnt += "\r\n";

    	$("#"+tblNm+" tbody tr").each(function(i){
    		$(this).find("td").each(function(j){
    			/*console.log(","+$(this).text());*/
    			csvCntnt += $(this).text()
    			.replace(/(\r\n|\n|\r|\s+|\t|&nbsp;)/gm,' ')
    			.replace(/"/g, '""')
    			.replace(/,/g, ' ') +",";
    		});
    		csvCntnt += "\r\n";
    	});


    	if ( window.navigator.msSaveOrOpenBlob && window.Blob ) {
    	    var blob = new Blob( [ "\ufeff"+csvCntnt ], { type: "text/csv" } );
    	    navigator.msSaveOrOpenBlob( blob, tblNm+".csv" );
    	} else {
    		var downloadLink = document.createElement("a");
    		var csvFile = new Blob(["\ufeff"+csvCntnt], {type: 'text/csv;charset=utf-8;'});

    		downloadLink.download = tblNm+".csv";
    		downloadLink.href = window.URL.createObjectURL(csvFile);
    		downloadLink.style.display = "none";

    		document.body.appendChild(downloadLink);
    		downloadLink.click();

    	}


    }



















    function _xAjax(url, param){
    	var deferred = $.Deferred();
		$.ajax({
			url     :  url,
			type    : 'POST',
			data    : param,
			dataType: 'json',
			success : function(data){
				deferred.resolve(data);
			},
			error   : function(err){
		    	deferred.reject(err);
			}
		});
		return deferred.promise();
    }