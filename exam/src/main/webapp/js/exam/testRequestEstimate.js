
    /* modal_addSample */
    var dialog_addSample, form_addSample;
    /* modal_editSample */
    var dialog_editSample, form_editSample;

    /* modal_copySample */
    var dialog_copySample, form_copySample;
    
    /* modal_addItems */
	var dialog_addItems, form_addItems;
	
	
    /* modal_insertTemplet */
	var dialog_insertTemplet, form_insertTemplet;
	
	/* modal_selectTemplet */
	var dialog_adjustTemplet, form_adjustTemplet;
	
	
	/* modal_zipcode */
	var dialog_zipcode, form_zipcode;
	
	
	$(function() {    
		
		/* jquery init condition */
		$( "button" )
		.button()
		.click(function( event ) {
			event.preventDefault();
		});
		
		$( "#radio" ).buttonset();
		
		//$('input, textarea').placeholder({customClass:'my-placeholder'});
		
		/* set mask  */
		$('#mnghp').mask('999-9999-9999');
		$('#mngphone').mask('999-9999-9999');
		$('#fax').mask('999-9999-9999');
		
		$('#rcvhp').mask('999-9999-9999');
		$('#rcvphone').mask('999-9999-9999');
		$('#rcvfax').mask('999-9999-9999');
		
		$('#taxhp').mask('999-9999-9999');
		$('#taxphone').mask('999-9999-9999');
		$('#taxfax').mask('999-9999-9999');
		
		/* window close icon */
		$("#icon_div1_open").css({'display' : "none" });
		//$("#icon_div2_open").css({'display' : "none" });
		
		
		
		/* init get information  
		 * session 기본 정보 가져오기 
		 * */
		// 최초 로그인 정보 가져오기 
		//setSelectInfo("getMemberInfo", {"formTag":"getMemberInfo"} );
		/* 기존 신청 가져오기 */
		//setSelectInfo("requestInfo",{"formTag":"requestInfo",  "reqid":"24270"});
		
		
		/* end of init */
		
		/* input file */
		var input = $( "input:file" ).css({
			  background: "#F7F8F9",
			  border: "1px #D4D4D4 solid"
		});
		
		
		
		
		
		/* get Class   
		 * 유종제품정보 기본 적용 
		 * */
		setSelectInfo("selectClass", {"formTag":"selectClass"} );
		
		/*get Search Detail */
		setSelectInfo("selectDetailSearch", {"formTag":"selectDetailSearch"});
		
		/* modal window */
		
		
		var emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
		//name = $( "#name" ),
		//email = $( "#email" ),
		//password = $( "#password" ),
		//allFields = $( [] ).add( name ).add( email ).add( password ),
		tips = $( ".validateTips" );

	    function updateTips( t ) {
	      tips
	        .text( t )
	        .addClass( "ui-state-highlight" );
	      setTimeout(function() {
	        tips.removeClass( "ui-state-highlight", 1500 );
	      }, 500 );
	    }
	 
	    function checkLength( o, n, min, max ) {
	      if ( o.val().length > max || o.val().length < min ) {
	        o.addClass( "ui-state-error" );
	        updateTips( "Length of " + n + " must be between " +
	          min + " and " + max + "." );
	        return false;
	      } else {
	        return true;
	      }
	    }
	 
	    function checkRegexp( o, regexp, n ) {
	      if ( !( regexp.test( o.val() ) ) ) {
	        o.addClass( "ui-state-error" );
	        updateTips( n );
	        return false;
	      } else {
	        return true;
	      }
	    }
	 
	    function addUser() {
	      var valid = true;
	      allFields.removeClass( "ui-state-error" );
	 
	      //valid = valid && checkLength( name, "username", 3, 16 );
	      //valid = valid && checkLength( email, "email", 6, 80 );
	      //valid = valid && checkLength( password, "password", 5, 16 );
	 
	      //valid = valid && checkRegexp( name, /^[a-z]([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter." );
	      //valid = valid && checkRegexp( email, emailRegex, "eg. ui@jquery.com" );
	      //valid = valid && checkRegexp( password, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9" );
	 
	      if ( valid ) {
	        $( "#users tbody" ).append( "<tr>" +
	          "<td>" + name.val() + "</td>" +
	          "<td>" + email.val() + "</td>" +
	          "<td>" + password.val() + "</td>" +
	        "</tr>" );
	        dialog_addSample.dialog( "close" );
	      }
	      return valid;
	    }

	    
	    
		
		/* add Items modal */
		
		dialog_addItems = $("#form_addItems").dialog({
			autoOpen:false,
			width: 900,
			height: 845,
			modal: true,
			buttons:{
				"추가":function(){
					actionAddItemsCheck();
					
				},
				"취소":function(){
					dialog_addItems.dialog("close");
				}
			},
			close:function(){
				form_addItems[0].reset();
			}
		});
		
		form_addItems = dialog_addItems.find("form").on("submit", function (event){
			event.preventDefault();
		})
		
		// open Modal Window
	    $( "#btn_addItems" ).button().on( "click", function() {
	    	if($("#current_smpid").val()==""){
	    		alert("시료정보를 선택하십시오.");
	    		
	    	} else {
	    		dialog_addItems.dialog( "open" );
	    		
	    		$("#tbl_selectItems tr").each(function(){
	    			var row = $("#"+this.id);
	    			row.remove();
	    		})
	    		
	    		/*heating init */
	    		$("#searchItemname").val("");
	    		actionSearchDetail();
	    		$("input:checkbox[id='rdo_searchDetail']").attr("checked", false);
	    		
	    	}
	      	
	      	//select items 
	      	//$("#btn_select_items").click();
	    });
		
		
		
	    
	    /* add Sample */
	    dialog_addSample = $( "#form_addSample" ).dialog({
	      autoOpen: false,
	      height: 800,
	      width: 1080,
	      modal: true,
	      buttons: {
	        "취소": function() {
	          dialog_addSample.dialog( "close" );
	        }
	      },
	      close: function() {
	    	  form_addSample[ 0 ].reset();
	        //allFields.removeClass( "ui-state-error" );
	      }
	    });
	 
	    
	    form_addSample = dialog_addSample.find( "form" ).on( "submit", function( event ) {
	      event.preventDefault();
	    });
	    
		// open Modal Window
		/* addSample  */
	    $( "#btn_setRequest" ).button().on( "click", function() {
	      	dialog_addSample.dialog( "open" );
	      	
	      	/* set first class */
	      	$("#class_1").click();
	      	
	      	
	    });
		
	    

	    /* copy Sample */
	    dialog_copySample = $( "#form_copySample" ).dialog({
	      autoOpen: false,
	      width: 600,
	      height: 400,
	      modal: true,
	      buttons: {
	         "복사": function(){
	        	
	        	 adjustCopySample(); 
	        	 dialog_copySample.dialog( "close" );
	        },
	    	 "취소": function() {
	          dialog_copySample.dialog( "close" );
	        }
	      },
	      close: function() {
	    	  form_copySample[0].reset();
	        //allFields.removeClass( "ui-state-error" );
	      }
	    });
	 
	    
	    form_copySample = dialog_copySample.find( "form" ).on( "submit", function( event ) {
	    	event.preventDefault();
	    });
	    
		// open Modal Window
		/* copySample  */
	    $( "#btn_copySample" ).button().on( "click", function() {
	      	dialog_copySample.dialog( "open" );
	      	
	      	actionCopySample();
	    });
		

	    
	    
	    
		/* edit Sample modal */
		
		dialog_editSample = $("#form_editSample").dialog({
			autoOpen:false,
			height: 240,
			width: 600,
			modal: true,
			buttons:{
				"적용":function(){
					actionAddSample();
					dialog_editSample.dialog("close");
				},
				"취소":function(){
					dialog_editSample.dialog("close");
				}
			},
			close:function(){
				form_editSample[0].reset();
			}
		});
		
		form_editSample = dialog_editSample.find("form").on("submit", function (event){
			event.preventDefault();
		})
		
		
		
		
		
		/* insert Templet modal */
		
		dialog_insertTemplet = $("#form_insertTemplet").dialog({
			autoOpen:false,
			height: 400,
			width: 600,
			modal: true,
			buttons:{
				"추가":function(){
					actionInsertTemplet();
					dialog_insertTemplet.dialog("close");
				},
				"삭제":function(){
					actionDeleteTemplet();
					
				},
				"닫기":function(){
					dialog_insertTemplet.dialog("close");
				}
			},
			close:function(){
				form_insertTemplet[0].reset();
			}
		});
		
		form_insertTemplet = dialog_insertTemplet.find("form").on("submit", function (event){
			event.preventDefault();
		})
		
		// open Modal Window
	    $( "#btn_insertTemplet" ).on( "click", function() {
	      	dialog_insertTemplet.dialog( "open" );
	      	
	      	setSelectInfo("selectTemplet",{"formTag":"selectTemplet"});
	      	//select items 
	      	//$("#btn_select_items").click();
	    });
		
		
		
		
		
		
		
		/* adjustTemplet modal */
		
		dialog_adjustTemplet = $("#form_adjustTemplet").dialog({
			autoOpen:false,
			height: 400,
			width: 600,
			modal: true,
			buttons:{
				"가져오기":function(){
					actionAdjustTemplet();
					dialog_adjustTemplet.dialog("close");
				},
				"닫기":function(){
					dialog_adjustTemplet.dialog("close");
				}
			},
			close:function(){
				form_adjustTemplet[0].reset();
			}
		});
		
		form_adjustTemplet = dialog_adjustTemplet.find("form").on("submit", function (event){
			event.preventDefault();
		})
		
		// open Modal Window
	    $( "#btn_adjustTemplet" ).on( "click", function() {
	      	dialog_adjustTemplet.dialog( "open" );
	      	
	      	setSelectInfo("adjustTemplet",{"formTag":"selectTemplet"});
	      	//select items 
	      	//$("#btn_select_items").click();
	    });
		
		
		
		
		/* form to JSON */
	    $.fn.serializeFormJSON = function () {

	        var o = {};
	        var a = this.serializeArray();
	        $.each(a, function () {
	            if (o[this.name]) {
	                if (!o[this.name].push) {
	                    o[this.name] = [o[this.name]];
	                }
	                o[this.name].push(this.value || '');
	            } else {
	                o[this.name] = this.value || '';
	            }
	        });
	        return o;
	    };
    
    
		
	    
	    

		/* zip code modal setting  */
		
		dialog_zipcode = $("#form_zipcode").dialog({
			autoOpen:false,
			width: 600,
			height: 700,
			modal: true,
			buttons:{
				"취소":function(){
					dialog_zipcode.dialog("close");
				}
			},
			close:function(){
				form_zipcode[0].reset();
			}
		});
		
		form_zipcode = dialog_zipcode.find("form").on("submit", function (event){
			event.preventDefault();
		})
		
		// open Modal Window
	    $( "#btn_zipcode1" ).button().on( "click", function() {
	      	dialog_zipcode.dialog( "open" );
	      	zipcodeTarget = "receive";
	      	zipTableInit();
	    });
		
		$("#btn_zipcode2").button().on("click", function(){
			dialog_zipcode.dialog( "open" );
	      	zipcodeTarget = "tax";
	      	zipTableInit();
		});	    
	    
		actionInitZipCode();
	    


	});	
	
    /*   end of init documents functions */	
	//   end of functions 		
	
	
	

    /* ********************** setting Zipcode  **************************************** */
    var zipcodeTarget;
    
    function actionInitZipCode(){
    	actionAjaxZipcode({"formTag":"siguList"});
    }
    function actionSearchZipCode(){
    	var searchKey = $("#txtSearch").val();
    	if(searchKey==""){alert("검색할 주소를 입력하십시오."); return; }
    	
    	var pm = {"formTag":"zipcodeSearch", "sido":$("#cbLvl1").val(), "searchKey":$("#txtSearch").val(), "searchType":$("#searchType").val() };
    	
    	actionAjaxZipcode(pm);
    }

    
    function resultSiguList(list){
    	for(var i=0; i<list.length; i++){
    		$("#cbLvl1").append("<option value='"+list[i]["sidocode"]+"'>"+list[i]["sido"]+"</option>");
    	}
    }
    
    function zipTableInit(){
   		$("#tblList tr").each(function (){
            var row = $("#"+this.id);
            row.remove();
        });
    }
    
    function resultZipcodeList(data){
    	zipTableInit();
    	
    	var vCnt  = data["RESULT_CNT"];
    	if(vCnt == 0){
    		alert("검색 정보가 없습니다. ");
    		return;
    	} else if (vCnt > 150){
    		alert("검색정보가 많습니다. 세부적으로 검색바랍니다. ");
    	}
    	
    	vList = data["RESULT_LIST"];
    	
  		var tblHTML = "<table class='table_h'>";
  		for(var i=0; i<vList.length; i++){
  			tblHTML += "<tr id='tr_zip_"+vList[i]["rn"]+"' style='height:24px;'>";
  			tblHTML += "<td style='width:5%;text-align:center;'>"+vList[i]["rn"]+"</td>";
  			tblHTML += "<td style='width:15%;text-align:center;'>"+vList[i]["zipcode"]+"</td>";
  			tblHTML += "<td style='width:35%;'><a href='javascript:actionZipcodesend(\""+vList[i]["zipcode"]+"\",\""+vList[i]["roadnamefull"]+"\");'>"+vList[i]["roadnamefull"]+"</a></td>";
  			tblHTML += "</tr>";
  		}
  	
  		tblHTML += "</table>";
  		
  		$("#tblList").append(tblHTML);
    }
    
    function actionZipcodesend(zipcode, fullname){
    	if(zipcodeTarget == "receive") {
    		$("#rcvzipcode").val(zipcode);
    		$("#rcvaddr1").val(fullname);
    		$("#rcvaddr2").val("");
    		
    	} else if(zipcodeTarget == "tax"){
    		$("#taxzipcode").val(zipcode);
    		$("#taxaddr1").val(fullname);
    		$("#taxaddr2").val("");
    		
    	}
    	
    	dialog_zipcode.dialog("close");
    	
    	//alert(zipcode+"/"+fullname);
    }
    
    
    /* ********************** end of setting Zipcode  **************************************** */
    
    
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

    /* resultData */
	
	var memberData ;
	
    //  성적서 기본정보 표시 기본정보 
	function setFrmMember(data){
		memberData = data;
		frmMember.reset();
		
		if(!data) {
			alert("해당하는 정보가 없습니다. ");
			return;
		}
		
		$("#frmMember input").each(function(i){
			var objName = this.name;
			
			if (objName){
				if(data[objName])
				var dataVal = data[objName]; //eval("data."+objName);
				if(dataVal){
					switch($(this).attr("type")){
					case "text":
						this.value = dataVal
					case "checkbox":
						// check valu
						;
					case "radio":
						// radio ;
						;
					case "select":
						;
					default:
						break;
					}
				} else {
					switch($(this).attr("type")){
					case "text":
						this.value = "";
					default:
						break;
					}
				}
			}
		});

		
		// reqid가 있을 경우 
		if(data["reqid"]){
			$("#reqid").val(data["reqid"]);
			
			
		} else {
			
			
		}
		
	}	
	
	function setInitResultTable(){
		$("#txt_samplenm").val("");
		$("#lbl_masternm").html("");
		
		$('#ifrmResults').contents().find('div[id=div_result]').html("");
	}	
	
	
	function setSample(data){
		// init
		$("#current_smpid").val("");
		setInitResultTable();
		
		/*// add Sample */
		$("#reqid").val(data["REQID"]);
		var reqid = $("#reqid").val();
		var smpid = data["SMPID"];
		var firstsmpid = 0;
		// init
		$("#tbl_sample tr").each(function (){
            var row = $("#"+this.id);
            row.remove();
        });
		
		var re_sample = data["RESULT_SAMPLEVO"];

		var tbl_row = "";
		
		var reqstate = $("#reqstate").val();
		for(s=0; s<re_sample.length; s++){
			if(s==0) firstsmpid = re_sample[s]["smpid"];
			
			tbl_row += "<tr id=\"rowid_"+re_sample[s]["smpid"]+"\" >";
			tbl_row += "<td class=\"txt_C\" onclick='javascript:actionSelectResult(\""+re_sample[s]["smpid"]+"\");' style='cursor:pointer'>"+(s+1)+"</td>";
			tbl_row += "<td id=\"td_sname_"+re_sample[s]["smpid"]+"\" onclick='javascript:actionSelectResult(\""+re_sample[s]["smpid"]+"\");' style='cursor:pointer'>"+re_sample[s]["sname"]+"</td>";
			tbl_row += "<td id=\"td_mname_"+re_sample[s]["smpid"]+"\"onclick='javascript:actionSelectResult(\""+re_sample[s]["smpid"]+"\");' style='cursor:pointer'>"+re_sample[s]["mname"]+"</td>";
			
			tbl_row += "</tr>";

		}
		
		$("#tbl_sample").append(tbl_row);
		
		// price;
		var re_price = data["RESULT_PRICEVO"];
		if(re_price){
			setPrice(re_price);
		}
		
		
		if(smpid) actionSelectResult(smpid);
		else if(firstsmpid != 0) {
			//actionSelectResult(firstsmpid);
			
			setTimeout(function(){ actionSelectResult(firstsmpid); }, 500);
		}
	}
	
	function setCopySample(data){
		var reqid = $("#reqid").val();
		
		// reset Table;
		$("#tbl_copySample tr").each(function (){
            var row = $("#"+this.id);
            row.remove();
        });
		
		var re_sample = data["RESULT_SAMPLEVO"];

		var tbl_row = "";
		
		
		for(s=0; s<re_sample.length; s++){
		
			tbl_row += "<tr id=\"rowid_copy_"+re_sample[s]["smpid"]+"\" >";
			tbl_row += "<td class=\"txt_C\"><input type='radio' name='rdo_copySample' value='"+re_sample[s]["smpid"]+"'></td>";
			tbl_row += "<td id=\"tdid_"+re_sample[s]["smpid"]+"\">"+re_sample[s]["sname"]+"</td>";
			tbl_row += "<td>"+re_sample[s]["mname"]+"</td>";
			tbl_row += "</tr>";

		}
		
		$("#tbl_copySample").append(tbl_row);
		
		
	}
	
	
	
	function setSelectItems(data){
	    var re_items = data["RESULT_ITEMVO"];	
	    
	    /*reset Table*/
	    
		// reset table
		$("#tbl_selectItems tr").each(function(){
			var row = $("#"+this.id);
			row.remove();
		})
	    
	    var tbl_row = "";

		// 겨로가 검색 표시 
		if (re_items.length>0){
		    for(var i=0;i<re_items.length; i++){
		    	tbl_row += "<tr  id=\"tr_selectItem_"+re_items[i]["itemid"]+"\">";
		    	if(re_items[i]["leafs"] == 0 ){
		    		/*자식 유무 여부에 따른 선택 */
		    		tbl_row += "	<td class=\"txt_C\"><input type=\"checkbox\" id='chk_sel_item' name='chk_sel_item' treeid=\""+re_items[i]["treeitemid"]+"\" itempid=\""+re_items[i]["itempid"]+"\"  value=\""+re_items[i]["itemid"]+"\" leafs='false' onclick='javascript:clickPitem(this);' /></td>";
		    	} else {
		    		tbl_row += "	<td class=\"txt_C\"><input type=\"checkbox\" id='chk_sel_item' name='chk_sel_item' treeid=\""+re_items[i]["treeitemid"]+"\" itempid=\""+re_items[i]["itempid"]+"\"  value=\""+re_items[i]["itemid"]+"\"  leafs='true'  onclick='javascript:clickItem(this);' /></td>";
		    	}
		    	//tbl_row += "	<td class=\"txt_C\">"+re_items[i]["treeitemid"]+"</td>";
		    	tbl_row += "	<td class=\"txt_L\">"+re_items[i]["tname"]+"</td>";
	
		    	
		    	
		    	var setc = (re_items[i]["setc"]).split(",");
		    	var smethodid = (re_items[i]["smethodid"]).split(",");
		    	var smethodnm = (re_items[i]["smethodname"]).split(",");
		    	
		    	var innerTxt = "";
		    
		    	for(var j=0; j<smethodid.length;j++){
		    		if(smethodid[j]!="" && smethodid[j]!="1"){
		    			if(setc[j]!= "" && "-"!=setc[j] ){
		    				innerTxt += "<input class='input_items' type='radio' value='"+smethodid[j]+"' id='rdo_"+re_items[i]["itemid"]+"' name='rdo_"+re_items[i]["itemid"]+"' onclick='javascript:clickRdoMethod(this, \""+re_items[i]["itemid"]+"\");'> "+smethodnm[j]+"("+setc[j].replace(/\└/g,',')+")"+"<br>"
		    			} else {
		    				innerTxt += "<input class='input_items' type='radio' value='"+smethodid[j]+"' id='rdo_"+re_items[i]["itemid"]+"' name='rdo_"+re_items[i]["itemid"]+"' onclick='javascript:clickRdoMethod(this, \""+re_items[i]["itemid"]+"\");'> "+smethodnm[j]+"<br>"
		    			}
		    		}
		    	}
		    	
		    	tbl_row += "	<td class=\"txt_L tr_items\">"+innerTxt+"</td>";
		    	tbl_row += "</tr>";
		    }
	    
		} else {
			//검색결과가 없을 경우 
			tbl_row += "<tr  id=\"tr_selectItem_0\">";
			tbl_row += "	<td class=\"txt_C\" colspan=\"3\"> 검색항목이 없습니다. </td>";
	    	tbl_row += "</tr>";
		}
	    $("#tbl_selectItems").append(tbl_row);
	}
	
	function clickRdoMethod(obj, itemid){
		if($("input[value="+itemid+"]:checkbox ")){
			if($("input[value="+itemid+"]:checkbox ").prop("checked")){
				
			} else{
				$("input[value="+itemid+"]:checkbox ").click();
				obj.checked = true;
			}
		}
	}
	
	function clickPitem(obj){
		/*상위 항목*/
		var itempid = obj.getAttribute("itempid");
		if($("input[value="+itempid+"]:checkbox ")){
			$("input[value="+itempid+"]:checkbox ").prop("checked",obj.checked);
			
			if($("#rdo_"+itempid).is(":radio") ){
				if(obj.checked){
					document.getElementById("rdo_"+itempid ).checked = true;
				} else {
					var chks = document.getElementsByName("rdo_"+ itempid )
					if(chks.length>0){
						for(var k=0; k<chks.length; k++){
							chks[k].checked = false;
						}
					}
				}
			}
			
		}
		/*자식 항목*/
		checkTree(obj.value, obj.checked);
		
		/*check box*/
		if($("#rdo_"+ obj.value).is(":radio") ){
			if(obj.checked){
				document.getElementById("rdo_"+obj.value ).checked = true;
			} else {
				var chks = document.getElementsByName("rdo_"+ obj.value )
				if(chks.length>0){
					for(var k=0; k<chks.length; k++){
						chks[k].checked = false;
					}
				}
			}
		}
	}
	
	function checkTree(treeid, chk){
		var chkVal="" ;
		$("input[name=chk_sel_item]:checkbox").each(function(i){
			if( $(this).attr("itempid") == treeid ){
				chkVal = $(this).val();
				$(this).prop("checked",chk);
				
				/*radio box*/
				if($("#rdo_"+ chkVal).is(":radio") ){
					if(chk){
						document.getElementById("rdo_"+chkVal ).checked = true;
					} else {
						var chks = document.getElementsByName("rdo_"+ chkVal )
						if(chks.length>0){
							for(var k=0; k<chks.length; k++){
								chks[k].checked = false;
							}
						}
					}
				}
			}
			if(chkVal != null && $(this).attr("itempid")==chkVal){
				$(this).prop("checked",chk);
				
				/*radio box*/
				if($("#rdo_"+ $(this).val()).is(":radio") ){
					if(chk){
						document.getElementById("rdo_"+$(this).val() ).checked = true;
					} else {
						var chks = document.getElementsByName("rdo_"+ $(this).val() )
						if(chks.length>0){
							for(var k=0; k<chks.length; k++){
								chks[k].checked = false;
							}
						}
					}
				}
			}
		})
	}
	
	
	
	/* click Item check method */
	/* 항목선택 항목클릭 */
	function clickItem(obj){
		actionCheckItme(obj);
		
		/* check item method */
		if($("#rdo_"+obj.value).is(":radio") ){
			
			if(obj.checked){
				document.getElementById("rdo_"+obj.value ).checked = true;
			} else {
				var chks = document.getElementsByName("rdo_"+obj.value )
				if(chks.length>0){
					for(var k=0; k<chks.length; k++){
						chks[k].checked = false;
					}
				}
			}
			//$("#rdo_"+obj.value).attr("checked", obj.checked);
		}
		
		/* check */
		//alert(obj.value);
		//alert( obj.getAttribute("treeid") );
		//alert( obj.checked );
		
		var treeid = obj.getAttribute("treeid");
		var aTreeid = treeid.split(",");
		
		
		
		if(aTreeid.length>2){
			var aTree = aTreeid[1];
			
			if(obj.checked){
				$("input[value="+aTree+"]:checkbox ").prop("checked",true);
				if($("#rdo_"+aTree).is(":radio") ){
					var stepChecked = false;
					var chks = document.getElementsByName("rdo_"+aTree )
					if(chks.length>0){
						for(var k=0; k<chks.length; k++){
							if(chks[k].checked){
								stepChecked = true;
							}
						}
					}
					
					if(!stepChecked){
						document.getElementById("rdo_"+aTree ).checked = true;
					}
				}
			} else {
				// 하위 체크 여부 
				var chkBoolean = false;
				$("input[name=chk_sel_item]:checkbox").each(function(i){
					if( $(this).attr("itempid") == aTree ){
						if( $(this).prop("checked")==true ){
							chkBoolean = true;
						}
					}
				})
				
				if(chkBoolean){
					$("input[value="+aTree+"]:checkbox ").prop("checked",true);
					if($("#rdo_"+aTree).is(":radio") ){
						var stepChecked = false;
						var chks = document.getElementsByName("rdo_"+aTree )
						if(chks.length>0){
							for(var k=0; k<chks.length; k++){
								if(chks[k].checked){
									stepChecked = true;
								}
							}
						}
						
						if(!stepChecked){
							document.getElementById("rdo_"+aTree ).checked = true;
						}
					}
				} else {
					$("input[value="+aTree+"]:checkbox ").prop("checked",false);
					if($("#rdo_"+aTreeid[1]).is(":radio") ){
						//document.getElementById("rdo_"+aTreeid[0] ).checked = false;
						var chks = document.getElementsByName("rdo_"+aTree )
						if(chks.length>0){
							for(var k=0; k<chks.length; k++){
								chks[k].checked = false;
							}
						}
					}
				}
				
			}
		}
		
		
		if(aTreeid.length>1){
			var aTree = aTreeid[0];
			/*if($("#rdo_"+aTreeid[0]).is(":radio") ){
				if(obj.checked){
					document.getElementById("rdo_"+aTreeid[0] ).checked = true;
				}
			}*/
			
			if(obj.checked){
				$("input[value="+aTree+"]:checkbox ").prop("checked",true);
				if($("#rdo_"+aTree).is(":radio") ){
					var stepChecked = false;
					var chks = document.getElementsByName("rdo_"+aTree )
					if(chks.length>0){
						for(var k=0; k<chks.length; k++){
							if(chks[k].checked){
								stepChecked = true;
							}
						}
					}
					
					if(!stepChecked){
						document.getElementById("rdo_"+aTree ).checked = true;
					}
				}
			} else {
				// 하위 체크 여부 
				var chkBoolean = false;
				$("input[name=chk_sel_item]:checkbox").each(function(i){
					if( $(this).attr("itempid") == aTree ){
						if( $(this).prop("checked")==true ){
							chkBoolean = true;
						}
					}
				})
				
				if(chkBoolean){
					$("input[value="+aTree+"]:checkbox ").prop("checked",true);
					if($("#rdo_"+aTree).is(":radio") ){
						var stepChecked = false;
						var chks = document.getElementsByName("rdo_"+aTree )
						if(chks.length>0){
							for(var k=0; k<chks.length; k++){
								if(chks[k].checked){
									stepChecked = true;
								}
							}
						}
						
						if(!stepChecked){
							document.getElementById("rdo_"+aTree ).checked = true;
						}
					}
				} else {
					$("input[value="+aTree+"]:checkbox ").prop("checked",false);
					if($("#rdo_"+aTree).is(":radio") ){
						//document.getElementById("rdo_"+aTreeid[0] ).checked = false;
						var chks = document.getElementsByName("rdo_"+aTree )
						if(chks.length>0){
							for(var k=0; k<chks.length; k++){
								chks[k].checked = false;
							}
						}
					}
				}
			}
			
		}
		
		

		
	}
	
	function actionCheckItme(obj){
		for(var i=0; i<sItems.length;i++){
			var cItem = sItems[i];
			if(obj.value == cItem.itemid){
				$("input[value="+cItem.sitemid+"]:checkbox ").prop("checked",obj.checked);
				
				if($("#rdo_"+cItem.sitemid).is(":radio") ){
					if(obj.checked){
						document.getElementById("rdo_"+cItem.sitemid ).checked = true;
					} else {
						var chks = document.getElementsByName("rdo_"+cItem.sitemid )
						if(chks.length>0){
							for(var k=0; k<chks.length; k++){
								chks[k].checked = false;
							}
						}
					}
				}
				
			}
		}
	}
	
	var sItems = new Array();
	function sItem(itemid, itempid, sitemid){
		this.itemid = itemid;
		this.pitempid = itempid;
		this.sitemid = sitemid;
	}
	function addSItem(itemid, itempid, sitemid){
		sItems[sItems.length] = new sItem(itemid, itempid, sitemid);
	}
	
	
	function setItemGroup(itemGroup){
		
		for(var i=0; i<itemGroup.length;i++){
			addSItem(itemGroup[i].itemid, itemGroup[i].itempid, itemGroup[i].bitemid);
		}
	}
	
	var aItems ;
	function item(itemid, itempid, methodid){
		this.itemid = itemid;
		this.itempid = itempid;
		this.methodid = methodid;
	}
	function addItem(itemid, itempid, methodid){
		aItems[aItems.length] = new item(itemid,itempid,methodid);
	}
	function getItem(pItemid){
		for(var i=0; i<aItems.length; i++){
			if(aItems[i].itemid == pItemid){
				return aItems[i];
			}
		}
		
		return null;
	}
	 
	/*사용하지 않음. 테스트 용으로 */
	function actionSelectItemsCheck(){
		aItems = new Array();
		
		var chkItems = "";
		var pItems = "";
		
		var step = true;
		$("input[name=chk_sel_item]:checkbox").each(function(i){
			if($(this).is(":checked")){
				var treeids = $(this).attr("treeid");
				/*상위항목 메소드 처리 */
				var aTreeid = treeids.split(",");
				if(aTreeid.length > 1){
					if($("#rdo_"+aTreeid[0]).is(":radio") ){
						if($(":radio[name='rdo_"+aTreeid[0]+"']:checked").val()){
						    //alert(   $(":radio[name='rdo_"+aTreeid[0]+"']:checked").val()    );
						    if(getItem(aTreeid[0])!=null){
						    	
						    } else {
						    	addItem(aTreeid[0],$(":radio[name='rdo_"+aTreeid[0]+"']:checked").val());
						    	pItems += "|"+aTreeid[0]+","+$(":radio[name='rdo_"+aTreeid[0]+"']:checked").val() 
						    }
						} else {
							alert("선택한 상위항목의 시험방법을 체크하십시오.");
							step = false;
							return;
						}
					} else {
						/*상위 시험방법이 없을 경우 */
						pItems += "|"+aTreeid[0]+","+"1";
					}
					
				}
				
				/*자신 메소드 가져오기 */
				var currentMethod = "";
				if($("#rdo_"+$(this).val()).is(":radio") ){
					if($(":radio[name='rdo_"+$(this).val()+"']:checked").val()){
						currentMethod = $(":radio[name='rdo_"+$(this).val()+"']:checked").val()
					} else {
						alert("선택한 항목의 시험방법을 체크하십시오.");
						step = false;
						return;
					}
				}
				chkItems += "|"+$(this).val()+","+currentMethod ;
			}
		})
		
		
		if(step){
			alert(chkItems);
			
			alert(pItems);
		}
		
	}
	
	
	function setResultItem(re_items){
		/* display result items */
		/* 속도 문제로 사용하지 않음 */
		
		
	}
	
	
	// set Class // 유종정보 표시  
	function setClass(data){
		$("#div_class").append("");
		var tabs = "<div id=\"radio\">";
		for(var i=0; i<data.length; i++){
			tabs += "<input type=\"radio\" id=\"class_"+data[i]["classid"]+"\" name=\"radio\" onclick=\"javascript:setSelectInfo('selectMaster', {'formTag':'selectMaster', 'pm':'"+data[i]["classid"]+"'});\"><label for=\"class_"+data[i]["classid"]+"\">"+data[i]["name"]+"</label>";
		}
		tabs += "</div>";
		$("#div_class").append(tabs);
		$( "#radio" ).buttonset();
	}
	
	// 제품정보 표시 
	function setMaster(data){
		
		// reset Table;
		$("#tbl_master_list tr").each(function (){
            var row = $("#"+this.id);
            row.remove();
        });
		
		var gname = "";
		
		var varTR="";
		for(var i=0; i<data.length; i++){
			if(gname != data[i]["gname"]){
				if (varTR != ""){
					varTR += "</div> </td>";
					varTR += "</tr>";
					
					$("#tbl_master_list").append(varTR);
					
					varTR = "";
				}
				gname = data[i]["gname"];
				varTR = "<tr id=\"td_"+data[i]["groupid"]+"\">";
				varTR += "<td class=\"td_class\">"+gname.replace("(","<br>(")+"</td> ";
				varTR += "<td class=\"b_R_none\"> <div>";
				
				varTR += "<div class='div_master'><a href=\"javascript:actionEvent('selectSample', '"+data[i]["masterid"]+"');\" >"+data[i]["mname"]+"</a> </div>";
			
			} else {
				varTR += "<div class='div_master'><a href=\"javascript:actionEvent('selectSample', '"+data[i]["masterid"]+"');\" >"+data[i]["mname"]+"</a> </div>";
			}
		}
		
		
		$("#tbl_master_list").append(varTR);
	}
	
	
	function setTemplet(data){
		var re_templet = data["RESULT_TEMPLETVO"];
		
		
		// reset table
		$("#tbl_selectTemplet tr").each(function(){
			var row = $("#"+this.id);
			row.remove();
		})
	    
	    var tbl_row = "";
	    for(var i=0;i< re_templet.length; i++){
	    	tbl_row += "<tr id=\"tr_selectTemplet_"+re_templet[i]["templetid"]+"\">";
	    	
	    	tbl_row += "	<td class=\"txt_C\"><input type=\"checkbox\" id='chk_sel_templet' name='chk_sel_templet' value=\""+re_templet[i]["templetid"]+"\"  /></td>";
	    	tbl_row += "	<td class=\"txt_L\">"+re_templet[i]["templetname"]+"</td>";
	    	tbl_row += "	<td class=\"txt_L\">"+re_templet[i]["fname"]+"</td>";
	    	tbl_row += "	<td class=\"txt_L b_R_none\">"+re_templet[i]["templetdesc"]+"</td>";
	    	tbl_row += "</tr>";
	    }
	    
		tbl_row += "<tr id=\"tr_selectTemplet_new\">";
    	
    	tbl_row += "	<td class=\"txt_C\">추가</td>";
    	tbl_row += "	<td class=\"txt_L\"><input type='text' name='txt_newTemplet' id='txt_newTemplet' style='width:140px;'></td>";
    	tbl_row += "	<td class=\"txt_L\">-</td>";
    	tbl_row += "	<td class=\"txt_L b_R_none\"><input type='text' name='txt_newTempletDesc' id='txt_newTempletDesc' style='width:140px;'></td>";
    	tbl_row += "</tr>";
    
	    
	    
	    $("#tbl_selectTemplet").append(tbl_row);
		
	    $('#div_templet').scrollTop($('#div_templet')[0].scrollHeight);
		//alert(data["RESULT_TEMPLETVO"]);
	}
	
	
	
	function setAdjustTemplet(data){
		var re_templet = data["RESULT_TEMPLETVO"];
		
		
		// reset table
		$("#tbl_adjustTemplet tr").each(function(){
			var row = $("#"+this.id);
			row.remove();
		})
	    
	    var tbl_row = "";
	    for(var i=0;i< re_templet.length; i++){
	    	tbl_row += "<tr id=\"tr_adjustTemplet_"+re_templet[i]["templetid"]+"\">";
	    	
	    	tbl_row += "	<td class=\"txt_C\"><input type=\"radio\" id='chk_rdo_templet' name='chk_rdo_templet' value=\""+re_templet[i]["templetid"]+"\"  /></td>";
	    	tbl_row += "	<td class=\"txt_L\">"+re_templet[i]["templetname"]+"</td>";
	    	tbl_row += "	<td class=\"txt_L\">"+re_templet[i]["fname"]+"</td>";
	    	tbl_row += "	<td class=\"txt_L b_R_none\">"+re_templet[i]["templetdesc"]+"</td>";
	    	tbl_row += "</tr>";
	    }
	    
	    
	    $("#tbl_adjustTemplet").append(tbl_row);
		
	    $('#div_adjustTemple').scrollTop($('#div_adjustTemple')[0].scrollHeight);
		//alert(data["RESULT_TEMPLETVO"]);
	}	
	
	function setActionTemplet(data){
		var new_reqid = data["RESULT_REQID"];
		var list_requet = data["RESULT_REQUESTVO"];
		
		setFrmMember(list_requet[0]);
		setSample(data);
		actionDivWindow("div_detail_open");
		//alert(new_reqid);
		
	}
	
	function setRequestInfo(data){
		var new_reqid = data["RESULT_REQID"];
		var list_requet = data["RESULT_REQUESTVO"];
		
		setFrmMember(list_requet[0]);
		setSample(data);
		actionDivWindow("div_detail_open");
		
		resultAttach(data["RESULT_ATTACH"]);
	}
	
	
	function setPrice(priceVO){
		var price = priceVO[0];
		
		$("#itemdesc").html(price["itemdesc"]);
		$("#totalprice").val(price["totalprice"]);
		
	}
	

	

	
	function resultAttach(attachList){
		//alert(attachList[0]["orgname"]);
		
		// reset table
		$("#tbl_attach tr").each(function(){
			var row = $("#"+this.id);
			row.remove();
		});
		
		var tbl_row = "";
	    for(var i=0;i< attachList.length; i++){
	    	tbl_row += "<tr id=\"tr_attach_"+attachList[i]["reqfid"]+"\">";
	    	tbl_row += " <td class=\"txt_C\">"+(i+1)+"</td>";
	    	tbl_row += " <td class=\"txt_L\"><a href='javascript:actionDownload(\""+attachList[i]["filepath"]+"\",\""+attachList[i]["orgname"]+"\");'>"+attachList[i]["orgname"]+"</a></td>";
	    	tbl_row += " <td class=\"txt_C b_R_none\"><div class=\"btn_erase\" onclick=\"javascript:actionEvent('eraseAttach',['"+attachList[i]["reqfid"]+"','"+attachList[i]["filepath"]+"']);\"></div></td>";
	    	tbl_row += "</tr>";
	    }
	    
	    
	    $("#tbl_attach").append(tbl_row);
	}
	
	
	
	// set Class // 유종정보 표시  
	function setDetailSearch(data){
		// reset table
		$("#tbl_searchDetail tr").each(function(){
			var row = $("#"+this.id);
			row.remove();
		});
		
		var tbl_row = "";
		for(var i=0; i<data.length; i++){
			tbl_row += "<tr id=\"tr_searchDetail_"+data[i]["exceptid"]+"\">";
	    	tbl_row += " <td style=\"height:28px;\" class=\"txt_C\"><input type=\"radio\" id='rdo_searchDetail' name='rdo_searchDetail' value=\""+data[i]["exceptid"]+"\"  onClick=\"javascript:actionSelectItemsDetail('"+data[i]["exceptid"]+"');\"/></td>";
	    	tbl_row += " <td style=\"height:28px;\" class=\"txt_L\">"+data[i]["name"]+"</td>";
	    	tbl_row += "</tr>";
			
			//$("#selExceptItem").append("<option value='"+data[i].exceptid+"'>"+data[i].name+"</option>");
		}
		
		 $("#tbl_searchDetail").append(tbl_row);
		
	}
	
	
	

    /* end of result Data */
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
    /*################################# action Event #################################*/

	function checkRequest(){
		
		/*var varRcv = $("input:radio[name='rcvtype']:checked").val(); 
		
		if(($("#mngdept").val()).trim() == ""){
			alert("담당부서정보가 입력되지 않았습니다.");
			$("#mngdept").focus();
			return false ;
		} else if(($("#mngname").val()).trim() == ""){
			alert("담당자정보가 입력되지 않았습니다.");
			$("#mngname").focus();
			return false ;
		} else if(($("#mnghp").val()).trim() == ""){
			alert("휴대폰정보가 입력되지 않았습니다.");
			$("#mnghp").focus();
			return false ;
		} else if(($("#mngemail").val()).trim() == ""){
			alert("이메일정보가 입력되지 않았습니다.");
			$("#mngemail").focus();
			return false ;
		} else if(($("#mngphone").val()).trim() == ""){
			alert("전화번호정보가 입력되지 않았습니다.");
			$("#mngphone").focus();
			return false ;
		} else if(($("#fax").val()).trim() == ""){
			alert("팩스번호정보가 입력되지 않았습니다.");
			$("#fax").focus();
			return false ;
			
		} else if($("#usage").val() == "-1") {
			alert("성적서용도를 선택하십시오.");
			$("#usage").focus();
			return false;
		} else if($("#pricechargetype").val()=="-1") {
			alert("세금계산서 청구유형을 선택하십시오.");
			$("#pricechargetype").focus();
			return false;
		} 

		if (varRcv == 2){
			// 성적서 받는 주소 신규 체크
			
			if ($("#rcvcompany").val()==""){
				alert("성적서받는 업체명정보가 입력되지 않았습니다.");
				$("#rcvcompany").focus();
				return false;
			} else if ($("#rcvceo").val()==""){
				alert("성적서받는 대표자정보가 입력되지 않았습니다.");
				$("#rcvceo").focus();
				return false;
			} else if ($("#rcvzipcode").val()==""){
				alert("성적서받는 우편번호 정보가 입력되지 않았습니다.");
				$("#rcvzipcode").focus();
				return false;
			} else if ($("#rcvaddr1").val()==""){
				alert("성적서받는 주소정보가 입력되지 않았습니다.");
				$("#rcvaddr1").focus();
				return false;
			} else if ($("#rcvaddr2").val()==""){
				alert("성적서받는 세부주소정보가 입력되지 않았습니다.");
				$("#rcvaddr2").focus();
				return false;
			} else if ($("#rcvmngname").val()==""){
				alert("성적서받는 담당자정보가 입력되지 않았습니다.");
				$("#rcvmngname").focus();
				return false;
			} else if ($("#rcvhp").val()==""){
				alert("성적서받는 휴대폰정보가 입력되지 않았습니다.");
				$("#rcvhp").focus();
				return false;
			} else if ($("#rcvemail").val()==""){
				alert("성적서받는 이메일정보가 입력되지 않았습니다.");
				$("#rcvemail").focus();
				return false;
			} else if ($("#rcvphone").val()==""){
				alert("성적서받는 전화번호정보가 입력되지 않았습니다.");
				$("#rcvphone").focus();
				return false;
			} 
			
		} 
		
		 세금 계산서 
		if ($("#pricechargetype").val() == "26" || $("#pricechargetype").val() == "28" ) {
			
			if ($("#taxcompany").val()==""){
				alert("세금계산서 받는 업체명정보가 입력되지 않았습니다.");
				$("#taxcompany").focus();
				return false;
			} else if ($("#taxceo").val()==""){
				alert("세금계산서 받는 대표자정보가 입력되지 않았습니다.");
				$("#taxceo").focus();
				return false;
			} else if ($("#taxzipcode").val()==""){
				alert("세금계산서 받는 우편번호 정보가 입력되지 않았습니다.");
				$("#taxzipcode").focus();
				return false;
			} else if ($("#taxaddr1").val()==""){
				alert("세금계산서 받는 주소정보가 입력되지 않았습니다.");
				$("#taxaddr1").focus();
				return false;
			} else if ($("#taxaddr2").val()==""){
				alert("세금계산서 받는 세부주소정보가 입력되지 않았습니다.");
				$("#taxaddr2").focus();
				return false;
			} else if ($("#taxbizno").val()==""){
				alert("세금계산서 받는 사업자번호정보가 입력되지 않았습니다.");
				$("#taxbizno").focus();
				return false;
			} else if ($("#taxbiztype").val()==""){
				alert("세금계산서 받는 업태정보가 입력되지 않았습니다.");
				$("#taxbiztype").focus();
				return false;
			} else if ($("#taxmngname").val()==""){
				alert("세금계산서 받는 담당자정보가 입력되지 않았습니다.");
				$("#rcvmngname").focus();
				return false;
			} else if ($("#taxhp").val()==""){
				alert("세금계산서 받는 휴대폰정보가 입력되지 않았습니다.");
				$("#rcvhp").focus();
				return false;
			} else if ($("#taxemail").val()==""){
				alert("세금계산서 받는 이메일정보가 입력되지 않았습니다.");
				$("#rcvemail").focus();
				return false;
			} else if ($("#taxphone").val()==""){
				alert("세금계산서 받는 전화번호정보가 입력되지 않았습니다.");
				$("#rcvphone").focus();
				return false;
			} 
			
		}
		*/
		
		if($("#usage").val() == "-1") {
			alert("성적서용도를 선택하십시오.");
			$("#usage").focus();
			return false;
		}
		
		return true;
		
	}

	function actionPerformed(tag){
		
		// 시료추가 
		if(tag == "addSample"){
		
		// 시료복사 	
		} else if (tag == "copySample") {
			
		} else if (tag == "setRequest") {	
			// send ajax
			
			if(checkRequest()){
				actionAdjustRequest();
			}
			
		} else if (tag == "selectItems"){
			// 추가하기 위한 항목 정보 가져오기

			if("참발열량"==$("#searchItemname").val()
					|| "발열량"==$("#searchItemname").val()
					|| "발열" ==$("#searchItemname").val()
					|| "참발열"==$("#searchItemname").val()
					|| "참발"==$("#searchItemname").val()
			){
	    		$("#tbl_selectItems tr").each(function(){
	    			var row = $("#"+this.id);
	    			row.remove();
	    		})
				actionSearchDetail("heating");
			} else {
				actionSearchDetail();
				actionSelectItems();
			}
		
		} else if (tag == "openSelectItems"){
			// open item window
			//항목추가시 현재정보 저장
			var pm = $('#ifrmResults').get(0).contentWindow.getAllItems();
			pm["samplename"] = $("#txt_samplenm").val();
			
			actionSaveItemsAuto("saveItems", pm );
			
			$("#td_sname_"+pm["smpid"]).html(pm["samplename"]);
			
		// 템블릿 가져오기 	
		} else if( tag == "selectTemplet"){
			
			setSelectInfo("selectTemplet");
			
		} else if( tag == "getTemplate"){
			actionDivWindow('div1_close');
			
        /* about items */			
		} else if (tag == "saveItems") {
		// savaItems;
			
			if($("#current_smpid").val()==""){
	    		alert("시료정보를 선택하십시오.");
	    	} else {
			
				var pm = $('#ifrmResults').get(0).contentWindow.getAllItems();
				pm["samplename"] = $("#txt_samplenm").val();
				
				actionSaveItems("saveItems", pm );
				
				$("#td_sname_"+pm["smpid"]).html(pm["samplename"]);
				
	    	}
		} else if (tag == "updateItemsCopy") {
			if($("#current_smpid").val()==""){
	    		alert("시료정보를 선택하십시오.");
	    	} else {
				var pm = $('#ifrmResults').get(0).contentWindow.getSelectItems();
				pm["mode"] = "updateItemsCopy";
				actionUpdateItemsCopy(pm);
	    	}
		} else if (tag == "insertItemsCopy") {
			if($("#current_smpid").val()==""){
	    		alert("시료정보를 선택하십시오.");
	    	} else {
				var pm = $('#ifrmResults').get(0).contentWindow.getSelectItems();
				pm["mode"] = "insertItemsCopy";
				actionInsertItemsCopy(pm);
	    	}
		} else if (tag == "deleteItemsCopy") {
			if($("#current_smpid").val()==""){
	    		alert("시료정보를 선택하십시오.");
	    	} else {
				if(confirm("선택한 검사항목을 삭제하시겠습니까? \r\n(주의 : 선택하신항목의 모든 하위항목도 같이 삭제 됩니다. )")){
					var pm = $('#ifrmResults').get(0).contentWindow.getSelectItems();
					pm["mode"] = "deleteItemsCopy";
					actionDeleteItemsCopy(pm);
				}
	    	}
		} else if (tag == "deleteItems") {
			if($("#current_smpid").val()==""){
	    		alert("시료정보를 선택하십시오.");
	    	} else {
				if(confirm("선택한 검사항목을 삭제하시겠습니까? \r\n(주의 : 모든 하위항목도 같이 삭제 됩니다)")){
					var pm = $('#ifrmResults').get(0).contentWindow.getSelectItems();
					pm["mode"] = "deleteItems";
					actionDeleteItems(pm);
				}
	    	}
		} else if (tag == "requestConfirm"){
			if(confirm("작성한 시험의뢰정보를 접수하시겠습니까?")){
				setSelectInfo("requestConfirm", {"formTag":"requestConfirm", "itemdesc":$("#itemdesc").val(), "reqid":$("#reqid").val() } );
			}
		} else if (tag == "deleteRequest"){
			if(confirm("시험의뢰정보를 삭제하시겠습니까?")){
				setSelectInfo("deleteRequest", {"formTag":"deleteRequest", "reqid":$("#reqid").val() } );
			}
		}
		
		
	}
	

	function actionSearchDetail(tag){
		if(tag=="heating"){
			$("#tbl_searchDetail input[id='rdo_searchDetail']:radio").each(function(){
				$(this).attr("checked", false);
			});
			
			$("#div_searchDetail").css("display","inline");
			$("#div_selectItems").css("display","inline");
			$("#div_duplicate").css("display","none");
			
			$("#div_selectItems").height("320px");
		} else if(tag == "duplicate"){
			
			$("#div_searchDetail").css("display","none");
			$("#div_selectItems").css("display","none");
			$("#div_duplicate").css("display","inline");
			
		} else {
			$("#div_searchDetail").css("display","none");
			$("#div_selectItems").css("display","inline");
			$("#div_duplicate").css("display","none");
			
			$("#div_selectItems").height("540px");
		}
		
	}
	
	
	
	
	// about Templet
	function actionAdjustTemplet(){
		var templetid = "";
		
		$("#tbl_adjustTemplet input[name=chk_rdo_templet]:radio").each(function(i){
			if($(this).is(":checked")){
				//alert($(this).val());
				templetid = $(this).val() ;
			}
		})
		
		//alert(templetid);
		setSelectInfo("actionTemplet", {"formTag":"actionTemplet", "templetid":templetid });
	}
	
	function actionInsertTemplet(){
		
		var templetname = $("#txt_newTemplet").val();
		var templetdesc = $("#txt_newTempletDesc").val();
		var reqid   = $("#reqid").val();
		
		pm = {"formTag":"insertTemplet",templetname:templetname, templetdesc:templetdesc, reqid:reqid};
		
		setSelectInfo("insertTemplet", pm);
		
		//alert(pm);
	}
	
	function actionDeleteTemplet(){
		//alert('actionAdditems');
		var chkTemplets = "";
		$("#tbl_selectTemplet input[name=chk_sel_templet]:checkbox").each(function(i){
			if($(this).is(":checked")){
				//alert($(this).val());
				chkTemplets += "|"+$(this).val() ;
			}
		})
		
		setSelectInfo("deleteTemplet", {"formTag":"deleteTemplet", "chkTemplets":chkTemplets });
	}
	
	// selectItems 
	// add Items
	function actionSelectItems(){
		var reqid = $("#reqid").val();
		var smpid = $("#current_smpid").val();
		var itemname = $("#searchItemname").val();
		
		setSelectInfo("selectItems", {"formTag":"selectItems","reqid":reqid, "smpid":smpid, "searchType":"single", "itemname":itemname, "kolasyn":$("#kolasyn").val() });
	
	}
	function actionSelectItemsDetail(detailid){
		var reqid = $("#reqid").val();
		var smpid = $("#current_smpid").val();
		var kolasyn = $("#kolasyn").val();
		
		setSelectInfo("selectItems", {"formTag":"selectItems","reqid":reqid, "smpid":smpid, "searchType":"detail", "exceptid":detailid, "kolasyn":kolasyn  });
	
	}
	function actionSelectItemsRange(searchText1, searchText2){
		$("#searchItemname").val("");
		
		actionSearchDetail();
		var reqid = $("#reqid").val();
		var smpid = $("#current_smpid").val();
		var itemname = $("#searchItemname").val();
		var kolasyn = $("#kolasyn").val();

		setSelectInfo("selectItems", {"formTag":"selectItems","reqid":reqid, "smpid":smpid, "searchType":"range", "itemname":itemname, "searchText1":searchText1, "searchText2":searchText2, "kolasyn":kolasyn });
	}
	
	
	
	// actionAddItems
	/*항목추가전 중복 항목 체크 절차 */
	var parentItems = "";
	function actionAddItemsCheck(){
		parentItems = "";
		
		if($("#div_duplicate").css("display") =="inline" ){
		/* 상위항목 선택 표시 */	
			$("tr[name='tr_duplicate_item'] " ).each(function(){
				var dupItem = $(this).attr("itemid");     // istitemid
				var duppItem = $(this).attr("itempid");   // istitempid
				if($("#rdo_duplicate_"+dupItem).is(":radio") ){
					
					if( $(":radio[name='rdo_duplicate_"+dupItem+"']:checked").val() ){
						parentItems += "|"+dupItem+","+duppItem+","+$(":radio[name='rdo_duplicate_"+dupItem+"']:checked").val();
					}  else {
						alert("상위항목을 선택하십시오.");
						
						return;
					}
				}
			});
			
			actionAddItems(parentItems);
			
		} else {
		
			aItems = new Array();
			
			var chkItems = "";
			var pItems = "";
			
			var step = true;
			$("input[name=chk_sel_item]:checkbox").each(function(i){
				if($(this).is(":checked") && $(this).attr("leafs")=="true"){
					var treeids = $(this).attr("treeid");
					var itempid = $(this).attr("itempid");
					/*상위항목 메소드 처리 */
					var aTreeid = treeids.split(",");
					/*레벨이 최상위 */
					if(aTreeid.length > 1){
						if($("#rdo_"+aTreeid[0]).is(":radio") ){
							if($(":radio[name='rdo_"+aTreeid[0]+"']:checked").val()){
							    //alert(   $(":radio[name='rdo_"+aTreeid[0]+"']:checked").val()    );
							    //if(getItem(aTreeid[0])!=null){
							    	
							    //} else {
							    	addItem(aTreeid[0], aTreeid[1], $(":radio[name='rdo_"+aTreeid[0]+"']:checked").val()   );
							    	pItems += "|"+aTreeid[0]+","+aTreeid[1]+","+$(":radio[name='rdo_"+aTreeid[0]+"']:checked").val() ;
							    //}
							} else {
								alert("선택한 상위항목의 시험방법을 체크하십시오.");
								step = false;
								return;
							}
						} else {
							/*상위 시험방법이 없을 경우 */
							pItems += "|"+aTreeid[0]+","+aTreeid[1]+","+"1";
						}
						
						
					}
					/* level이 3레벨중에 가운데 항목 */
					if(aTreeid.length > 2){
						if($("#rdo_"+aTreeid[1]).is(":radio") ){
							if($(":radio[name='rdo_"+aTreeid[1]+"']:checked").val()){
							    //alert(   $(":radio[name='rdo_"+aTreeid[0]+"']:checked").val()    );
							    //if(getItem(aTreeid[1])!=null){
							    	
							    //} else {
							    	addItem(aTreeid[1], aTreeid[2], $(":radio[name='rdo_"+aTreeid[1]+"']:checked").val());
							    	pItems += "|"+aTreeid[1]+","+aTreeid[2]+","+$(":radio[name='rdo_"+aTreeid[1]+"']:checked").val(); 
							    //}
							} else {
								alert("선택한 상위항목의 시험방법을 체크하십시오.");
								step = false;
								return;
							}
						} else {
							/*상위 시험방법이 없을 경우 */
							pItems += "|"+aTreeid[1]+","+aTreeid[2]+","+"1";
						}
						
					}
					
					/*자신 메소드 가져오기 */
					var currentMethod = "0";
					if($("#rdo_"+$(this).val()).is(":radio") ){
						if($(":radio[name='rdo_"+$(this).val()+"']:checked").val()){
							currentMethod = $(":radio[name='rdo_"+$(this).val()+"']:checked").val();
						} else {
							alert("선택한 항목의 시험방법을 체크하십시오.");
							step = false;
							return;
						}
					}
					
					chkItems += "|"+$(this).val()+","+itempid+","+currentMethod ;
				}
			})
			
			
			if(step){
				actionInsertItemsCheck(chkItems, pItems);
			}
		}
	}
	

	
	function actionAddItems(parentItems){
		
		
		aItems = new Array();
		
		var chkItems = "";
		var pItems = "";
		
		var step = true;
		$("input[name=chk_sel_item]:checkbox").each(function(i){
			if($(this).is(":checked") && $(this).attr("leafs")=="true"){
				var treeids = $(this).attr("treeid");
				var itempid = $(this).attr("itempid");
				
				/*상위항목 메소드 처리 */
				var aTreeid = treeids.split(",");
				/*레벨이 최상위 */
				if(aTreeid.length > 1){
					if($("#rdo_"+aTreeid[0]).is(":radio") ){
						if($(":radio[name='rdo_"+aTreeid[0]+"']:checked").val()){
						    //alert(   $(":radio[name='rdo_"+aTreeid[0]+"']:checked").val()    );
						    //if(getItem(aTreeid[0])!=null){
						    	
						    //} else {
						    	//addItem(aTreeid[0], aTreeid[1], $(":radio[name='rdo_"+aTreeid[0]+"']:checked").val()   );
						    	pItems += "|"+aTreeid[0]+","+aTreeid[1]+","+$(":radio[name='rdo_"+aTreeid[0]+"']:checked").val() ;
						    //}
						} else {
							alert("선택한 상위항목의 시험방법을 체크하십시오.");
							step = false;
							return;
						}
					} else {
						/*상위 시험방법이 없을 경우 */
						pItems += "|"+aTreeid[0]+","+aTreeid[1]+","+"1";
					}
					
					
				}
				/* level이 3레벨중에 가운데 항목 */
				if(aTreeid.length > 2){
					if($("#rdo_"+aTreeid[1]).is(":radio") ){
						if($(":radio[name='rdo_"+aTreeid[1]+"']:checked").val()){
						    //alert(   $(":radio[name='rdo_"+aTreeid[0]+"']:checked").val()    );
						    //if(getItem(aTreeid[1])!=null){
						    	
						    //} else {
						    	//addItem(aTreeid[1], aTreeid[2], $(":radio[name='rdo_"+aTreeid[1]+"']:checked").val());
						    	pItems += "|"+aTreeid[1]+","+aTreeid[2]+","+$(":radio[name='rdo_"+aTreeid[1]+"']:checked").val() ;
						    //}
						} else {
							alert("선택한 상위항목의 시험방법을 체크하십시오.");
							step = false;
							return;
						}
					} else {
						/*상위 시험방법이 없을 경우 */
						pItems += "|"+aTreeid[1]+","+aTreeid[2]+","+"1";
					}
					
				}
				
				/*자신 메소드 가져오기 */
				var currentMethod = "0";
				if($("#rdo_"+$(this).val()).is(":radio") ){
					if($(":radio[name='rdo_"+$(this).val()+"']:checked").val()){
						currentMethod = $(":radio[name='rdo_"+$(this).val()+"']:checked").val()
					} else {
						alert("선택한 항목의 시험방법을 체크하십시오.");
						step = false;
						return;
					}
				}
				chkItems += "|"+$(this).val()+","+itempid+","+currentMethod ;
			}
		})
		
		
		if(step){
			
			actionInsertItems(parentItems, chkItems, pItems);
			dialog_addItems.dialog("close");
		}
		
		

	}
	
	
	function actionAddItemDuplicate(data){
		if("Y" == data["RESULT_DUPLICATE"]){
			/*display duplicate div */
			actionSearchDetail("duplicate");
			
			/* init table*/
			$("#tbl_duplicate tr").each(function(){
				var row = $("#"+this.id);
				row.remove();
			});
			
			var duplicateList = data["RESULT_DUPLICATEVO"];
			var tbl_row = "";
			var istitempid = "";
			var lastIndx = "";
			
			for(var i=0;i<duplicateList.length;i++){
				
				if(istitempid != duplicateList[i].istitempid ) {

					if("" != istitempid){
						// add new parents
						tbl_row += "<tr id=\"tr_duplicate_"+duplicateList[i].istitempid+"\">";
						tbl_row += " <td class=\"txt_C\" style=\"border-bottom-color: #929292;\"><input type=\"radio\" id='rdo_duplicate_"+duplicateList[i-1].istitempid+"' name='rdo_duplicate_"+duplicateList[i-1].istitempid+"' value=-1  onClick=\"javascript:actionSelectDuplicate('-1');\"/></td>";
						tbl_row += " <td class=\"txt_L\" style=\"border-bottom-color: #929292;\" colspan=\"5\" >신규 추가</td>";
						tbl_row += "</tr>";
					}
					
					istitempid = duplicateList[i].istitempid;
					
					tbl_row += "<tr id=\"tr_duplicate_itemid_"+istitempid+"\" name=\"tr_duplicate_item\"  itemid=\""+duplicateList[i].istitempid+"\" itempid=\""+duplicateList[i].itempid+"\"  >";
					tbl_row += " <td class=\"txt_L\" style=\"border-bottom-color: #929292;\" colspan=\"6\" >"+duplicateList[i].istname+"</td>";
					tbl_row += "</tr>";
					
					tbl_row += "<tr id=\"tr_duplicate_"+duplicateList[i].istitempid+"\">";
			    	tbl_row += " <td class=\"txt_C\"><input type=\"radio\" id='rdo_duplicate_"+duplicateList[i].istitempid+"' name='rdo_duplicate_"+duplicateList[i].istitempid+"' value=\""+duplicateList[i].resultid+"\"  onClick=\"javascript:actionSelectDuplicate('"+duplicateList[i].istitempid+"');\"/></td>";
			    	tbl_row += " <td class=\"txt_L\">"+duplicateList[i].itemname+"</td>";
			    	tbl_row += " <td class=\"txt_L\">"+duplicateList[i].condname+"</td>";
			    	tbl_row += " <td class=\"txt_L\">"+duplicateList[i].unitid+"</td>";
			    	tbl_row += " <td class=\"txt_L\">"+duplicateList[i].methodnm+"</td>";
			    	tbl_row += " <td class=\"txt_L\">"+duplicateList[i].remark+"</td>";
			    	tbl_row += "</tr>";
			    	
			    	
			    	
				} else {
					tbl_row += "<tr id=\"tr_duplicate_"+duplicateList[i].istitempid+"\">";
			    	tbl_row += " <td class=\"txt_C\"><input type=\"radio\" id='rdo_duplicate_"+duplicateList[i].istitempid+"' name='rdo_duplicate_"+duplicateList[i].istitempid+"' value=\""+duplicateList[i].resultid+"\"  onClick=\"javascript:actionSelectDuplicate('"+duplicateList[i].istitempid+"');\"/></td>";
			    	tbl_row += " <td class=\"txt_L\">"+duplicateList[i].itemname+"</td>";
			    	tbl_row += " <td class=\"txt_L\">"+duplicateList[i].condname+"</td>";
			    	tbl_row += " <td class=\"txt_L\">"+duplicateList[i].unitid+"</td>";
			    	tbl_row += " <td class=\"txt_L\">"+duplicateList[i].methodnm+"</td>";
			    	tbl_row += " <td class=\"txt_L\">"+duplicateList[i].remark+"</td>";
			    	tbl_row += "</tr>";
				}
				
				lastIndx = i;
				
				
			}
			
			// add new parents
			tbl_row += "<tr id=\"tr_duplicate_"+duplicateList[lastIndx].istitempid+"\">";
			tbl_row += " <td class=\"txt_C\" style=\"border-bottom-color: #929292;\"><input type=\"radio\" id='rdo_duplicate_"+duplicateList[lastIndx].istitempid+"' name='rdo_duplicate_"+duplicateList[lastIndx].istitempid+"' value=-1  onClick=\"javascript:actionSelectDuplicate('-1');\"/></td>";
			tbl_row += " <td class=\"txt_L\" style=\"border-bottom-color: #929292;\" colspan=\"5\" >신규 추가</td>";
			tbl_row += "</tr>";
			
			
			 $("#tbl_duplicate").append(tbl_row);
			 
			//alert(data["RESULT_DUPLICATEVO"][0]["istname"]);
		}
		
		if("Y" == data["RESULT_EXCEPT"]){
			
		}
		//var exceptItems = data["RESULT_EXCEPTITEM"][0]["itemname"];
		
		
	}
	
	
	function actionSelectDuplicate(resultid){
		
	}
	
	
	
	function actionCopySample(){
		var reqid = $("#reqid").val();
		setSelectInfo("selectCopySample", {"formTag":"selectCopySample","reqid":reqid});
	}

	function adjustCopySample(){
		var reqid = $("#reqid").val();
		var rdoSampleId = $("input:radio[name='rdo_copySample']:checked").val();
		
		setSelectInfo("adjustCopySample",{"formTag":"adjustCopySample","reqid":reqid, "smpid":rdoSampleId, "smplcopycnt":$("#smplcopycnt").val() });
		
	}
	
	
 // paramter 있는 function event 
	function actionEvent(tag, pm){
		if(tag == "selectSample"){
			// 팝업에서 제품정보를 선택한 후			
			actionSelectSample(pm);
		} else if (tag == "eraseSample") {
			// 시료삭제
			actionEraseSample(pm);
		} else if (tag == "eraseAttach") {
			actionEraseAttach(pm);
		}
	}
	
	/* deleteSample */
	function actionEraseSample(pm){
		
		actionDeleteSample(pm)
	}
	
	
	
	/* close select sample window and open sample name edit window */
	function actionSelectSample(pm){
		
		dialog_addSample.dialog( "close" );
		
		$("#add_masterId").val(pm);
		dialog_editSample.dialog( "open" );
	}
	
	
	// addSample
	function actionAddSample(){
		actionAdjustSample();
	}
	
	
	
	
	
 /* 화면 조정 */
	

	
	/* action  copy cnt   */
	function actionChangeCopycnt(){
		if($("#copycnt").val()=="etc"){
			$("#copycnt_etc").css({"display":"inline"});
		} else {
			$("#copycnt_etc").css({"display":"none"});
			$("#span_copycnt_etc").css({"margin":"0px"});
		}
	}
	
	
	/* action tax price */
	function actionChangePriceType(){
		if($("#pricechargetype").val()=="26" || $("#pricechargetype").val()=="28" ){
			$("#tbl_tax").css({"display":"inline"});
		} else {
			$("#tbl_tax").css({"display":"none"});
		}
		
	}
	
	/* receive report */
	function actionClickRcv(){
		var varRcv = $("input:radio[name='rcvtype']:checked").val(); 
		
		if(varRcv == 1){
			$("#tbl_rcv").css({"display":"none"});
			resetRcv();
		} else if(varRcv == 2){
			$("#tbl_rcv").css({"display":"inline"});
			resetRcvEmpty();
		}
		
	}
	
	/*reset rcv address*/
	function resetRcv(){
		$("#rcvcompany").val(memberData["cname"]);
		$("#rcvceo").val(memberData["ceoname"]);
		
		$("#rcvzipcode").val(memberData["zipcode"]);
		$("#rcvaddr1").val(memberData["addr1"]);
		$("#rcvaddr2").val(memberData["addr2"]);
		$("#rcvdept").val(memberData["mngdept"]);
		$("#rcvmngname").val(memberData["mngname"]);
		
		$("#rcvemail").val(memberData["mngemail"]);
		$("#rcvphone").val(memberData["mngphone"]);
		$("#rcvhp").val(memberData["mnghp"]);
		$("#rcvfax").val(memberData["fax"]);
	}
	
	/*reset rcv address*/
	function resetRcvEmpty(){
		$("#rcvcompany").val("");
		$("#rcvceo").val("");
		
		$("#rcvzipcode").val("");
		$("#rcvaddr1").val("");
		$("#rcvaddr2").val("");
		$("#rcvdept").val("");
		$("#rcvmngname").val("");
		
		$("#rcvemail").val("");
		$("#rcvphone").val("");
		$("#rcvhp").val("");
		$("#rcvfax").val("");
	}
	
	
	// div window close & open 
	function actionDivWindow(tag){
		
		
		
		
		if("div1_open" == tag){
			
			$("#div1_win_content").attr("style","");
			$("#div2_win_content").attr("style","");
			
			$("#div1_win_content").css({ 'display': "block"});
			$("#div2_win_content").css({ 'display': "block"});
			
			$("#div2_btn").css({ 'display': "block" });
			$("#div2_h4").css({ 'display': "block" });
			
			$("#icon_div1_open").css({'display' : "none" });
			$("#icon_div1_close").css({'display' : "block" });
			
		} else if ("div1_close" == tag) {
			
		    setTimeout(function() {
		    	$("#div1_win_content").css({ 'display': "none" });
		    	$("#div2_win_content").css({ 'display': "none" });
   	        }, 450 );
			
			$("#div1_win_content").animate({height:'0px'},"slow");
			$("#div2_win_content").animate({height:'0px'},"slow");
				
			$("#div2_btn").css({ 'display': "none" });
			$("#div2_h4").css({ 'display': "none" });
			
			$("#icon_div1_open").css({'display' : "block" });
			$("#icon_div1_close").css({'display' : "none" });
		
		} else if("div_detail_open" == tag){
			$("#div_detail").css({'display':'block'});
		} else if("div_detail_close" == tag){
			$("#div_detail").css({'display':'none'});
		}
		
		
		/*} else if("div2_open" == tag){
			
			
			$("#icon_div2_open").css({'display' : "none" });
			$("#icon_div2_close").css({'display' : "block" });
		} else if ("div2_close" == tag) {
			
			
			$("#icon_div2_open").css({'display' : "block" });
			$("#icon_div2_close").css({'display' : "none" });
			
		}*/

		
	}
	
	

	