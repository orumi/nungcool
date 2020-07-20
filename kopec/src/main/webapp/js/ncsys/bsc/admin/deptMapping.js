	$(document).ready(function() {
		$('form').bind('submit', function () {return false})
		var date = new Date();
		var year = date.getFullYear();
		funcSetDate(year);
		setFrToYear(year);

		actionInit();

		 $("#selYear").change(function(){ actionInit(); });

		 $("#searchName").keydown(function (key) { //검색창에서 Enter눌렀을 때 검색
	            if (key.keyCode == 13) {
	            	searchDept();
	            }
	        });

	});


    function funcSetDate(curYear) {
        for (i=0,j=curYear-6; i<=6;i++,j++) {
        	 $("#selYear").append("<option value='"+j+"'>"+j+"</option>");
        }
        $("#selYear option:eq(5)").attr("selected", "selected");
    }

    function setFrToYear(curYear) {
    	for (i=0,j=curYear-6; i<=6;i++,j++) {
    		$("#selFrYear").append("<option value='"+j+"'>"+j+"</option>");
    		$("#selToYear").append("<option value='"+j+"'>"+j+"</option>");
       }
    	$("#selFrYear option:eq(5)").attr("selected", "selected");
    	$("#selToYear option:eq(5)").attr("selected", "selected");
    }



    function actionInit(){
    	/* select tblpsnbaseline */

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(selectInitURL, param)
    	.done(function(data){

   			displayBsc(data.selectBsc);
   			//displayDept(data.selectDept);


    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    	searchDept();
    }


   /* bsc */
    var curBsc = 0;

    var bscHtml = "<tr role=\"row\" bcid=\"###bcid###\">";
    bscHtml += "<td style=\"\">###sname###</td>";
    bscHtml += "<td style=\"\">###bname###</td>";
    bscHtml += "<td style=\"\">###deptCnt###</td>";
    bscHtml += "</tr>";

    function displayBsc(bsc){
    	curBsc = null;
    	$("#bd_bsc").empty();

    	curDeptMapping = null;
    	$("#bd_deptMapping").empty();

    	curDept = null;
		$("#bd_dept").empty();


    	for(var i in bsc){
    		var aBsc = bsc[i];
    		var tmpHtml = bscHtml.replace("###bcid###",aBsc.bcid)
    		.replace("###sname###",aBsc.sname)
    		.replace("###bname###",aBsc.bname)
    		.replace("###deptCnt###",aBsc.deptCnt);

    		$("#bd_bsc").append(tmpHtml);
    	}

		$("#bd_bsc tr").click(function(){
			actionClickBsc($(this));
		})

    }
    function adjustBsc(bsc){
    	curBsc = null;
    	$("#bd_bsc").empty();

    	curDeptMapping = null;
    	$("#bd_deptMapping").empty();

    	curDept = null;
		$("#bd_dept").empty();


    	for(var i in bsc){
    		var aBsc = bsc[i];
    		var tmpHtml = bscHtml.replace("###bcid###",aBsc.bcid)
    		.replace("###sname###",aBsc.sname)
    		.replace("###bname###",aBsc.bname)
    		.replace("###deptCnt###",aBsc.deptCnt);

    		$("#bd_bsc").append(tmpHtml);
    	}

		$("#bd_bsc tr").click(function(){
			actionClickBsc($(this));
		})

		searchDept();

    }

    function actionClickBsc(rowObj){
    	$(curBsc).removeClass("select_row");
    	curBsc = $(rowObj)
    	$(curBsc).addClass("select_row");
    	selectDeptMapping();
    }



    function searchDept(){

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.searchName = $("#searchName").val();

    	_xAjax(selectDeptURL, param)
    	.done(function(data){
   			displayDept(data.selectDept);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});


    }


    var curDept = null;

    var deptHtml = "<tr role=\"row\">";
    deptHtml += "<td style=\"\">###did###</td>";
    deptHtml += "<td style=\"\">###udname###</td>";
    deptHtml += "<td style=\"\">###dname###</td>";
    deptHtml += "</tr>";

    function displayDept(dept){
    	curDept = null;
    	$("#bd_dept").empty();
    	for(var i in dept){
    		var aDept = dept[i];
    		var tmpHtml = deptHtml.replace("###did###",aDept.did)
    		.replace("###udname###",aDept.udname)
    		.replace("###dname###",aDept.dname);

    		$("#bd_dept").append(tmpHtml);
    	}

		$("#bd_dept tr").click(function(){
			actionClickDept($(this));
		})

    }
    function actionClickDept(rowObj){
    	$(curDept).removeClass("select_row");
    	curDept = $(rowObj)
    	$(curDept).addClass("select_row");
    }



    function selectDeptMapping(){
    	var bcid = $(curBsc).attr("bcid");

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.bcid = bcid;

    	_xAjax(selectDeptMappingURL, param)
    	.done(function(data){
   			displayDeptMapping(data.selectDeptMapping);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }

    var curDeptMapping;
    var deptMappingHtml = "<tr role=\"row\" deptCd=\"###deptCd###\" bcid=\"###bcid###\"  >";
    deptMappingHtml += "<td style=\"\">###udname###</td>";
    deptMappingHtml += "<td style=\"\">###dname###</td>";
    deptMappingHtml += "</tr>";
    function displayDeptMapping(deptMapping){
    	curDeptMapping = null;
    	$("#bd_deptMapping").empty();
    	for(var i in deptMapping){
    		var aDept = deptMapping[i];
    		var tmpHtml = deptMappingHtml.replace("###deptCd###",aDept.deptCd)
    		.replace("###bcid###",aDept.orgCd)
    		.replace("###udname###",aDept.udname)
    		.replace("###dname###",aDept.dname);

    		$("#bd_deptMapping").append(tmpHtml);
    	}

		$("#bd_deptMapping tr").click(function(){
			actionClickDeptMapping($(this));
		})
    }

    function actionClickDeptMapping(rowObj){
    	$(curDeptMapping).removeClass("select_row");
    	curDeptMapping = $(rowObj)
    	$(curDeptMapping).addClass("select_row");
    }




    function addDeptMapping(){
    	var rdObj = $(curDept).children();
    	var bcid = $(curBsc).attr("bcid");
    	var deptCd = rdObj.eq(0).text()

    	var tmpHtml = deptMappingHtml.replace("###deptCd###",deptCd)
		.replace("###bcid###",bcid)
		.replace("###udname###",rdObj.eq(1).text())
		.replace("###dname###",rdObj.eq(2).text());

		$("#bd_deptMapping").append(tmpHtml);
    }


    function delDeptMapping(){

    	if(!curDeptMapping){
    		alert("매핑정보를 선택하십시오.");
    		return;
    	}

    	$(curDeptMapping).remove();

    	curDeptMapping = null;

    }

    function delAll(){
    	curDeptMapping = null;
    	$("#bd_deptMapping").empty();
    }



    function adjustDeptMapping(){
    	var aParam = new Array();
    	$("#bd_deptMapping tr").each(function(i){
    		var trObj = $("#bd_deptMapping tr").eq(i);

    		var pm = new Object();
    		pm.year = $("#selYear option:selected").val();
    		pm.bcid = $(trObj).attr("bcid");
    		pm.deptCd = $(trObj).attr("deptcd");

    		aParam.push(pm);

    	});

    	var param = new Object();
    	param.deptMapping = JSON.stringify(aParam);
    	param.year = $("#selYear option:selected").val();
    	param.bcid = $(curBsc).attr("bcid");


    	_xAjax(adjustDeptMappingURL, param)
    	.done(function(data){
    		if(data.selectBsc.length > 0){
    			adjustBsc(data.selectBsc);
    			alert("저장되었습니다.");
    		} else {

    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
    }





















    function actionYearCopy(){
    	var param = new Object();

    	param.frYear = $("#selFrYear option:selected").val();
    	param.toYear = $("#selToYear option:selected").val();

    	_xAjax(copyDeptMappingURL, param)
    	.done(function(data){
    		alert("적용되었습니다.");

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
    }



    function actionYearCopyOpen(){
    	$("#div_year").show();
		$(".wrap").after("<div class='overlay'></div>");
    }


    function closePopup(){
    	$("#div_year").hide();
    	$(".wrap").after("<div class='overlay'></div>");

    	$(".overlay").remove();
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