/******************************************
 * MS WINDOWS용
 ******************************************/

/*******************************************************************************
 * A4 용지: 755px X 1084px 1inch = 25.4mm = 96pixel 1mm = 3.78px
 ******************************************************************************/

var ver = "eForm Viewer 3.0";

var menuOffset = ('ios' == toolBarType) ? 10 : 40;
var pgViewOffset = 0;

var dhxWins, help_win;
var currheight;
var move_page = false;
var max_page = 4;
var page_no = 1;
var scr_width;
var scr_height;
var hFlag = 27;
var pageWidth;
var pageHeight;
var jobID = "";
//var maxPageView = -1;
//var curPageView = -1;
//var totalRecords = -1;
//var startRecords = -1;
//var endRecords = -1;
var mm = "";
var ee = "";
var isExcel = false;

//var dpath = "./";

var dpath = "../cdoc/eform/";

var doProcess = "smartcert_process.jsp";

var agent = navigator.userAgent.toLowerCase();
var exportType = "";

var jspAtt = "";

Browser = {
		os : function() {
			if (agent.indexOf("windows") > -1) {
				return "ms";
			} else if (agent.indexOf("android") > -1) {
				if (agent.indexOf("shw-m380w") > -1) {
					return "galexytab";
				} else if ((agent.indexOf("shw-m480w") > -1)
						|| (agent.indexOf("tablet") > -1)) {
					os = "galexytabnote";
				} else {
					return "android";
				}
			} else if (agent.indexOf("linux") > -1) {
				return "linux";
			} else if (agent.indexOf("iphone") > -1) {
				return "iphone";
			} else if (agent.indexOf("ipad") > -1) {
				return "ipad";
			} else if (agent.indexOf("mac") > -1) {
				return "mac";
			} else {
				return "unknown";
			}
		},

		bw : function() {
			if ((agent.indexOf("msie") > -1) || agent.indexOf("trident") > -1) {
				return "ie";
			} else if ((agent.indexOf("opera") > -1) || (agent.indexOf("opr") > -1)){
				return "opera";
			} else if (agent.indexOf("chrome") > -1) {
				return "chrome";
			} else if (agent.indexOf("safari") > -1) {
				return "safari";
			} else if (agent.indexOf("firefox") > -1) {
				return "firefox";
			} else {
				return "unknown";
			}
		},

		version : function() {
			if (this.os() == "ms" && this.bw() == "ie") {
				var start = agent.indexOf("msie");
				if(start>-1){
					var tmp = agent.substring(start);
					var end = tmp.indexOf(";");
					tmp = tmp.substring(0, end);
					tmp = tmp.substring(tmp.lastIndexOf(" "));
					return tmp;
				}else{
					start = agent.indexOf("rv:");
					var tmp = agent.substring(start);
					var end = tmp.indexOf(")");
					tmp = tmp.substring("rv:".length, end);
					return tmp;
				}
			} else {
				return 99999;
			}
		}
	};

var os = Browser.os();
var bw = Browser.bw();
var version = Browser.version();

window.onload = function() {
	
	var w = pageWidth + 120;
	var h0 = window.screen.availHeight;
	var a4h = 297 * 96 / 25.4;
	if (a4h > h0)
		a4h = h0;

	if (bw == "opera")
		a4h = a4h - 100;

	window.top.resizeTo(w,  a4h);

	var canvas = document.getElementById("canvas");
	canvas.setAttribute('onscroll', "movescroll();");

	document.getElementById("canvas").style.overflowY = "scroll";

	setToolbarText("pageno", page_no + "/" + max_page + "&nbsp;");
	
	if('default' == toolBarType){
		document.getElementById("version").innerHTML = ver;
		document.getElementById("hversion").title = "ReportExpress " + ver;
		var opt = {
				width			: 450,
				left 				: 30,
				top 				: 45,
				arrowpos	: 20,
				autoClose : 0,
				color		: "#b3d0e7",
				html		: "<small>확인증을 인쇄하시려면 위 <font color='red'>PDF내보내기</font> 하시어 출력하시기 바랍니다.</small>"
		};
		$('.popbox').popbox(opt);
	}else if('ios' == toolBarType){
		$('.chromestyle ul').css('padding', '0px');
		$('.chromestyle ul').css('background', 'none');
	}
	ScreenSize();

};


window.onresize = function() {
	ScreenSize();
	currheight = document.documentElement.clientHeight;
};

function movescroll() {
	try {
		if(move_page == true){
			move_page = false;
		} else {
			var scrollTop = document.getElementById("canvas").scrollTop;
			page_no = Math.ceil(scrollTop / pageHeight + 0.5);
			page_no = page_no < 1 ? 1 : page_no;
			page_no = page_no > max_page ? max_page : page_no;
			setToolbarText("pageno", page_no + "/" + max_page + "&nbsp;");
			$('.popbox').fadeOut("fast");
		} 
	} catch (e) {
	}
}

function ScreenSize() {
	try {
		var doc_left;

		scr_width = window.document.body.offsetWidth;
		scr_height = window.document.body.offsetHeight;

		doc_left = (scr_width - pageWidth) / 2;
		doc_left = (doc_left < 0) ? 6 : doc_left;
		
		if(maxPageView<0 || curPageView<0){
			document.getElementById("canvas").style.height = (document.documentElement.clientHeight - menuOffset) + "px";
		}else{
			document.getElementById("canvas").style.height = (document.documentElement.clientHeight - menuOffset - pgViewOffset) + "px";
		}
		
		document.getElementById("doc").style.left = doc_left + "px";

		if (version <= 7.0)
			document.getElementById("paper").style.overflowY = "visible";
		document.getElementById("canvas").style.overflowY = "scroll";
		
	} catch (e) {
	}
}

function setToolbarText(id, text) {
	try {
		document.getElementById(id).innerHTML = text;
		setToolbarTitle("hpageno");
	} catch (e) {
	}
}

function setToolbarTitle(id) {
	try {
		document.getElementById(id).title = "현재 페이지는 " + max_page + " 페이지 중 " + page_no + " 페이지입니다.";
	} catch (e) {
	}
}

function Help() {
	var w, h;
	var base_url = dpath + "/smartcertviewer/help/";
	var help_url = "";
	var help_caption = "ReportExpress™ Enterprise 페이지 설정 도움말";

	if (os == "android" || os == "galexytab" || version <= 6.0) {
		alert("해당 운영체제 또는 브라우저는 인쇄를 지원하지 않습니다.\n페이지 인쇄를 선택하시면 PDF로 저장됩니다.");
		return false;
	}

	if (bw == "ie" || bw == "opera") {
		dhxWins = new dhtmlXWindows();
		dhxWins.enableAutoViewport(false);
		dhxWins.attachViewportTo("smartcertviewer");
		dhxWins.setImagePath(dpath + "/smartcertviewer/toolbar/imgs/");
	}

	if (bw == "ie") {
		help_caption = "Internet Explorer 페이지 설정 도움말";
		h = 720;
		w = 620;
		help_url = base_url + "ie_help.htm";
		showHelpWin(help_url, help_caption, w, h);
	} else if (bw == "firefox") {
		help_caption = "Firefox 페이지 설정 도움말";
		h = 680;
		w = 620;
		help_url = base_url + "firefox_help.htm";

		alert("Firefox의 경우 페이지 설정\n\n" + "용지 및 배경: 페이지 폭에 맞춤 설정\n"
				+ "여백 및 머리글/바닥글:\n"
				+ "     모든 여백은 0으로 설정하며 머리글/바닥글은 모두 [공백]으로 설정");
	} else if (bw == "opera") {
		h = 655;
		w = 620;
		help_caption = "Opera페이지 설정 도움말";
		help_url = base_url + "opera_help.htm";
		showHelpWin(help_url, help_caption, w, h);
	} else if (bw == "chrome") {
		h = 400;
		w = 560;
		help_caption = "Chrome 페이지 설정 도움말";
		help_url = base_url + "chrome_help.htm";
		alert("Chrome 페이지 설정\n\n" + "Chrome의 경우는 페이지 설정 옵션이 없습니다.");
	} else if (bw == "safari") {
		h = 400;
		w = 560;
		help_caption = "Safari 페이지 설정 도움말";
		help_url = base_url + "safari_help.htm";
		alert("Safari 페이지 설정\n\n"
				+ "Safari의 경우 브라우저 자체에서 페이지 설정 옵션이 적용되지 않습니다.");
	} else {
		h = 680;
		w = 620;
		help_caption = "Internet Explorer 페이지 설정 도움말";
		help_url = base_url + "ie_help.htm";
		showHelpWin(help_url, help_caption, w, h);
	}
}

function showHelpWin(url, caption, w, h) {
	help_win = dhxWins.createWindow("w1", 0, 0, w, h);
	help_win.setText(caption);
	help_win.button("park").hide();
	help_win.button("minmax1").hide();
	dhxWins.window("w1").centerOnScreen();
	dhxWins.window("w1").attachURL(url);
	dhxWins.window("w1").setModal(true);
}

function RXHelp() {
	var url = dpath + "/smartcertviewer/help/help.htm";
	dhxWins = new dhtmlXWindows();
	dhxWins.enableAutoViewport(false);
	dhxWins.attachViewportTo("smartcertviewer");
	dhxWins.setImagePath(dpath + "/smartcertviewer/toolbar/imgs/");
	help_win = dhxWins.createWindow("w1", 0, 0, 620, 420);
	help_win.setText(ver + " 도움말");
	help_win.button("park").hide();
	help_win.button("minmax1").hide();
	dhxWins.window("w1").centerOnScreen();
	dhxWins.window("w1").attachURL(url);
	dhxWins.window("w1").setModal(true);
}

function Close() {
	//ClearSession();

	top.window.opener = top;
	top.window.open('', '_parent', '');
	top.window.close();
}

function makeFormUrl(url){
	var f = document.createElement("form");
    f.setAttribute("method", "post");
    f.setAttribute("action", url);
    document.body.appendChild(f);
      
    return f;
}

function makeForm(id){
	var f = document.createElement("form");
	f.setAttribute("id", id);
	f.setAttribute("name", id);
	f.setAttribute("enctype", "application/x-www-form-urlencoded");
    f.setAttribute("method", "post");
    document.body.appendChild(f);
      
    return f;
}

function addData(name, value){
	var i = document.createElement("input");
	i.setAttribute("type","hidden");
	i.setAttribute("name",name);
	i.setAttribute("value",value);
	return i;
}

function doIssue(){
	showMask();
	setInterval(checkDownload,500);
	
//	dpath = "../cdoc/eform/";
	
	if('default'==toolBarType){
		document.getElementById("issue").style.display = "none";
	}else if('ios'==toolBarType){
		$("#toolbar-modal-controls a.pdf").css("background","url(" + dpath + "smartcertviewer/css/images/icon_doc_click.png) no-repeat 50% 50%");
		$("#toolbar-modal-controls a.pdf").prop('onclick', 'javascript:return false;');
		$("#toolbar-modal-controls a.pdf").prop('title', '전자문서가 이미 발급되었습니다.');
	}	

	var errUrl = dpath +"error.jsp?msg=";
	
	doProcess = dpath + "smartcert"+jspAtt+"_process.jsp";
	
	var p = "SignOnly=1&Type=signedpdf&jobID=" + document.frmcert.jobID.value + "&p=" + document.frmcert.userpwd.value;
	var pp = encrypt(p, mm, ee);

	var f = makeForm("smartForm");
	f.appendChild(addData('__p', pp[0]));http://localhost:8080/eformbank/cdoc/eform/smartcert_service.jsp#
	f.appendChild(addData('__q', pp[1]));
	
	$.ajax({
		type: "GET",
		url: doProcess + "?__p=" + pp[0] + "&__q=" + pp[1],
		dataType: "json",
		//data: $('#smartForm').serialize(),
		success: function(msg){
			var status = msg.result;
			if(status=="OK"){
				var url = doProcess + "?__p=" + pp[0] + "&__q=" + pp[1];
				
				if(pluginmode){
					url = dpath + "plugins/pdf_plugin_viewer.jsp"
					
					var f = "width=800,height=600,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,copyhistory=no,resizable=yes";
					window.open(url + "?__p=" + pp[0] + "&__q=" + pp[1] + "&mode=smartcert", "Download", f);
				}else{
					window.location.replace(dpath+"smartcert"+jspAtt+"_serviceexport.jsp?__p=" + pp[0] + "&__q=" + pp[1]);
				}
				
				return false;
/*
				var url = dpath + "smartcert"+jspAtt+"_serviceexport.jsp?__p=" + pp[0] + "&__q=" + pp[1];
				$.getJSON(url, function(data){
					if(data.result=="OK"){
						window.location.replace(dpath +"smartcert"+jspAtt+"_serviceexport2.jsp?__p=" + pp[0] + "&__q=" + pp[1]);
					}else{
						window.location.replace(errUrl + data.result);
					}
				});
*/
			}else{
				window.location.replace(errUrl + status);
			}
		}
	});
	

/*
	var url = dpath + doProcess + "?__p=" + pp[0] + "&__q=" + pp[1];
	window.location.replace(dpath + "smartcert"+jspAtt+"_serviceexport.jsp?__p=" + pp[0] + "&__q=" + pp[1]);
*/
}

function checkDownload(){
	if (document.cookie.indexOf("cabsoftfileDownload=true") != -1) {
		document.cookie = "cabsoftfileDownload=; expires=" + new Date(1000).toUTCString() + "; path=/";
		hideMask();
	}
}

function doMenu(mnu_id) {
	if (mnu_id == "rxhtml_help") {
		RXHelp();
	} else if (mnu_id == "print_help") {
		Help();
	} else if (mnu_id == "print_page") {
		if (rxprintable() == true) {
			window.print();
		} else {
			download("pdf", '');
		}
	} else if (mnu_id == "close") {
		Close();
	} else if (mnu_id == "next") {
		page_no++;
		if (page_no > max_page) {
			alert("마지막 페이지입니다.");
			page_no = max_page;
		} else {
			move_page = true;
			window.location.href = "#RX_PAGE_ANCHOR_" + page_no;
			setToolbarText("pageno", page_no + "/" + max_page + "&nbsp;");
		}
	} else if (mnu_id == "before") {
		page_no--;
		if (page_no < 1) {
			alert("첫 페이지입니다.");
			page_no = 1;
		} else {
			move_page = true;
			window.location.href = "#RX_PAGE_ANCHOR_" + page_no;
			setToolbarText("pageno", page_no + "/" + max_page + "&nbsp;");
		}
	} else if (mnu_id == "first") {
		page_no = 1;
		move_page = true;
		window.location.href = "#RX_PAGE_ANCHOR_" + page_no;
		setToolbarText("pageno", page_no + "/" + max_page + "&nbsp;");
	} else if (mnu_id == "last") {
		page_no = max_page;
		move_page = true;
		window.location.href = "#RX_PAGE_ANCHOR_" + page_no;
		setToolbarText("pageno", page_no + "/" + max_page + "&nbsp;");
	} else if (mnu_id == "save_signedpdf") {
		exportType = "save_signedpdf";
		if("ms"==os){
			if(RxAcrobatInfo(bw).acrobat){
				doIssue();
			}else{
				acrobatHelp();
			}
		}else{
			doIssue();
		}
	} else if (mnu_id == "save_signedpdfpwd") {
		exportType = "save_signedpdfpwd";
		if("ms"==os){
			if(RxAcrobatInfo(bw).acrobat){
				IssueDRM();
			}else{
				acrobatHelp();
			}
		}else{
			IssueDRM();
		}
	} else if (mnu_id == "save_signedpdf_m") {
		jspAtt = "mp";
		exportType = "save_signedpdf";
		if("ms"==os){
			if(RxAcrobatInfo(bw).acrobat){
				doIssue();
			}else{
				acrobatHelp();
			}
		}else{
			doIssue();
		}
	} else if (mnu_id == "save_signedpdfpwd_m") {
		exportType = "save_signedpdfpwd";
		jspAtt = "mp";
		if("ms"==os){
			if(RxAcrobatInfo(bw).acrobat){
				IssueDRM();
			}else{
				acrobatHelp();
			}
		}else{
			IssueDRM();
		}
	}
}

function acrobatHelp2Export(){

	if(null != dhxWins){
		if(null != dhxWins.window("w1")){
			dhxWins.window("w1").close();
		}
	}
	
	if("save_signedpdf"==exportType){
		doIssue();
	}else if("save_signedpdfpwd"==exportType){
		IssueDRM();
	}
}

function closedhxWins(){
	dhxWins.window("w1").close();
	var elem=document.getElementById("viewer");

	if(elem!=null){
		elem.parentNode.removeChild(elem);
	}
}

function IssueDRM() {
	var url = dpath + "smartcert_drm.jsp";
	dhxWins = new dhtmlXWindows();
	dhxWins.enableAutoViewport(false);
	dhxWins.attachViewportTo("smartCertViewer"); // boby id값
	dhxWins.setImagePath(dpath + "smartcertviewer/window/imgs/");
	help_win = dhxWins.createWindow("w1", 0, 0, 550, 180);
	help_win.setText("전자문서 비밀번호 설정");
	help_win.button("park").hide();
	help_win.button("minmax1").hide();
	help_win.button("close").hide();
	dhxWins.window("w1").centerOnScreen();
	dhxWins.window("w1").attachURL(url);

	dhxWins.window("w1").setModal(true);
}

function IssueP() {
	//dhxWins.window("w1").close();
	doIssue();
}

function ClearSession() {
	// 서버에 서비스 종료 호출
	var p = "jobID=" + document.frmcert.jobID.value + "&p=" + document.frmcert.userpwd.value;
	var pp = encrypt(p, mm, ee);
	
	$.ajax({
		type: "GET",
		url:  "clearsession.jsp?__p=" + pp[0] + "&__q=" + pp[1],
    	dataType: "json",
		success: function(msg){
			var status = msg.result;
			alert(msg.result);
//			if(status=="OK"){
//			}
		}
	});	
}

function openDrillDown(hyperlink) {
	var f = "width=1050,height=800,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,copyhistory=no,resizable=yes,left=0,top=0";
	window.open("/eForm/" + hyperlink, "DrillDown", f);
}

function rxprintable() {
	if ((version <= 6.0) || (os != "mac" && bw == "safari") || os == "android"
			|| os == "galexytab") {
		return false;
	} else if (os != "mac" && bw == "safari") {
		return false;
	} else {
		return true;
	}
}

$(function() {
	$( document ).tooltip();
});


function showMask() {
	$.blockUI({
		message : $('#ajax_indicator'),
		fadeIn : 700,
		fadeOut : 700,
		showOverlay : true,
		centerY : true,
		css : {
			width : '300px',
			border : 'none',
			height : '60px'
		},
		overlayCSS : {
			backgroundColor : '#B3B3B3'
		}
	});
}

function hideMask() {
	$.unblockUI();
}

function acrobatHelp() {
	var url = dpath + "acrobatHelp.jsp?type=smartcert";
	dhxWins = new dhtmlXWindows();
	dhxWins.enableAutoViewport(false);
	dhxWins.attachViewportTo("smartCertViewer"); // boby id값
	dhxWins.setImagePath(dpath + "smartcertviewer/window/imgs/");
	help_win = dhxWins.createWindow("w1", 0, 0, 550, 180);
	help_win.setText("Acrobat Reader 설치 안내");
	help_win.button("park").hide();
	help_win.button("minmax1").hide();
	help_win.button("close").hide();
	dhxWins.window("w1").centerOnScreen();
	dhxWins.window("w1").attachURL(url);

	dhxWins.window("w1").setModal(true);
}
/*******************************************************************************
 * 
 ******************************************************************************/
var cssdropdown = {
	disappeardelay : 250, // set delay in miliseconds before menu disappears
							// onmouseout
	dropdownindicator : '<img src="' + dpath
			+ '/smartcertviewer/css/down.gif" border="0" />', // specify full HTML
															// to add to end of
															// each menu item
															// with a drop down
															// menu
	enablereveal : [ true, 5 ], // enable swipe effect? [true/false, steps
								// (Number of animation steps. Integer between
								// 1-20. Smaller=faster)]
	enableiframeshim : 1, // enable "iframe shim" in IE5.5 to IE7? (1=yes,
							// 0=no)

	// No need to edit beyond here////////////////////////

	dropmenuobj : null,
	asscmenuitem : null,
	domsupport : document.all || document.getElementById,
	standardbody : null,
	iframeshimadded : false,
	revealtimers : {},

	getposOffset : function(what, offsettype) {
		var totaloffset = (offsettype == "left") ? what.offsetLeft
				: what.offsetTop;
		var parentEl = what.offsetParent;
		while (parentEl != null) {
			totaloffset = (offsettype == "left") ? totaloffset
					+ parentEl.offsetLeft : totaloffset + parentEl.offsetTop;
			parentEl = parentEl.offsetParent;
		}
		return totaloffset;
	},

	css : function(el, targetclass, action) {
		var needle = new RegExp("(^|\\s+)" + targetclass + "($|\\s+)", "ig")
		if (action == "check")
			return needle.test(el.className)
		else if (action == "remove")
			el.className = el.className.replace(needle, "")
		else if (action == "add" && !needle.test(el.className))
			el.className += " " + targetclass
	},

	showmenu : function(dropmenu, e) {
		if (this.enablereveal[0]) {
			if (!dropmenu._trueheight || dropmenu._trueheight < 10)
				dropmenu._trueheight = dropmenu.offsetHeight
			clearTimeout(this.revealtimers[dropmenu.id])
			dropmenu.style.height = dropmenu._curheight = 0
			dropmenu.style.overflow = "hidden"
			dropmenu.style.visibility = "visible"
			this.revealtimers[dropmenu.id] = setInterval(function() {
				cssdropdown.revealmenu(dropmenu)
			}, 10)
		} else {
			dropmenu.style.visibility = "visible"
		}
		this.css(this.asscmenuitem, "selected", "add")
	},

	revealmenu : function(dropmenu, dir) {
		var curH = dropmenu._curheight, maxH = dropmenu._trueheight, steps = this.enablereveal[1]
		if (curH < maxH) {
			var newH = Math.min(curH, maxH)
			dropmenu.style.height = newH + "px"
			dropmenu._curheight = newH + Math.round((maxH - newH) / steps) + 1
		} else { // if done revealing menu
			dropmenu.style.height = "auto"
			dropmenu.style.overflow = "hidden"
			clearInterval(this.revealtimers[dropmenu.id])
		}
	},

	clearbrowseredge : function(obj, whichedge) {
		var edgeoffset = 0
		if (whichedge == "rightedge") {
			var windowedge = document.all && !window.opera ? this.standardbody.scrollLeft
					+ this.standardbody.clientWidth - 15
					: window.pageXOffset + window.innerWidth - 15
			var dropmenuW = this.dropmenuobj.offsetWidth
			if (windowedge - this.dropmenuobj.x < dropmenuW) // move menu to
																// the left?
				edgeoffset = dropmenuW - obj.offsetWidth
		} else {
			var topedge = document.all && !window.opera ? this.standardbody.scrollTop
					: window.pageYOffset
			var windowedge = document.all && !window.opera ? this.standardbody.scrollTop
					+ this.standardbody.clientHeight - 15
					: window.pageYOffset + window.innerHeight - 18
			var dropmenuH = this.dropmenuobj._trueheight
			if (windowedge - this.dropmenuobj.y < dropmenuH) { // move up?
				edgeoffset = dropmenuH + obj.offsetHeight
				if ((this.dropmenuobj.y - topedge) < dropmenuH) // up no good
																// either?
					edgeoffset = this.dropmenuobj.y + obj.offsetHeight
							- topedge
			}
		}
		return edgeoffset
	},

	dropit : function(obj, e, dropmenuID) {
		if (this.dropmenuobj != null) // hide previous menu
			this.hidemenu() // hide menu
		this.clearhidemenu()
		this.dropmenuobj = document.getElementById(dropmenuID) // reference
																// drop down
																// menu
		this.asscmenuitem = obj // reference associated menu item
		this.showmenu(this.dropmenuobj, e)
		this.dropmenuobj.x = this.getposOffset(obj, "left")
		this.dropmenuobj.y = this.getposOffset(obj, "top")
		this.dropmenuobj.style.left = this.dropmenuobj.x
				- this.clearbrowseredge(obj, "rightedge") + "px"
		this.dropmenuobj.style.top = this.dropmenuobj.y
				- this.clearbrowseredge(obj, "bottomedge") + obj.offsetHeight
				+ 1 + "px"
		this.positionshim() // call iframe shim function
	},

	positionshim : function() { // display iframe shim function
		if (this.iframeshimadded) {
			if (this.dropmenuobj.style.visibility == "visible") {
				this.shimobject.style.width = this.dropmenuobj.offsetWidth
						+ "px"
				this.shimobject.style.height = this.dropmenuobj._trueheight
						+ "px"
				this.shimobject.style.left = parseInt(this.dropmenuobj.style.left)
						+ "px"
				this.shimobject.style.top = parseInt(this.dropmenuobj.style.top)
						+ "px"
				this.shimobject.style.display = "block"
			}
		}
	},

	hideshim : function() {
		if (this.iframeshimadded)
			this.shimobject.style.display = 'none'
	},

	isContained : function(m, e) {
		var e = window.event || e
		var c = e.relatedTarget
				|| ((e.type == "mouseover") ? e.fromElement : e.toElement)
		while (c && c != m)
			try {
				c = c.parentNode
			} catch (e) {
				c = m
			}
		if (c == m)
			return true
		else
			return false
	},

	dynamichide : function(m, e) {
		if (!this.isContained(m, e)) {
			this.delayhidemenu()
		}
	},

	delayhidemenu : function() {
		this.delayhide = setTimeout("cssdropdown.hidemenu()",
				this.disappeardelay) // hide menu
	},

	hidemenu : function() {
		this.css(this.asscmenuitem, "selected", "remove")
		this.dropmenuobj.style.visibility = 'hidden'
		this.dropmenuobj.style.left = this.dropmenuobj.style.top = "-1000px"
		this.hideshim()
	},

	clearhidemenu : function() {
		if (this.delayhide != "undefined")
			clearTimeout(this.delayhide)
	},

	addEvent : function(target, functionref, tasktype) {
		if (target.addEventListener)
			target.addEventListener(tasktype, functionref, false);
		else if (target.attachEvent)
			target.attachEvent('on' + tasktype, function() {
				return functionref.call(target, window.event)
			});
	},

	startchrome : function() {
		if (!this.domsupport)
			return

		this.standardbody = (document.compatMode == "CSS1Compat") ? document.documentElement
				: document.body
		for ( var ids = 0; ids < arguments.length; ids++) {
			var menuitems = document.getElementById(arguments[ids])
					.getElementsByTagName("a")
			for ( var i = 0; i < menuitems.length; i++) {
				if (menuitems[i].getAttribute("rel")) {
					var relvalue = menuitems[i].getAttribute("rel")
					var asscdropdownmenu = document.getElementById(relvalue)
					this.addEvent(asscdropdownmenu, function() {
						cssdropdown.clearhidemenu()
					}, "mouseover")
					this.addEvent(asscdropdownmenu, function(e) {
						cssdropdown.dynamichide(this, e)
					}, "mouseout")
					this.addEvent(asscdropdownmenu, function() {
						cssdropdown.delayhidemenu()
					}, "click")
					try {
						menuitems[i].innerHTML = menuitems[i].innerHTML + " "
								+ this.dropdownindicator
					} catch (e) {
					}
					this.addEvent(menuitems[i], function(e) { // show drop
																// down menu
																// when main
																// menu items
																// are mouse
																// over-ed
						if (!cssdropdown.isContained(this, e)) {
							var evtobj = window.event || e
							cssdropdown.dropit(this, evtobj, this
									.getAttribute("rel"))
						}
					}, "mouseover")
					this.addEvent(menuitems[i], function(e) {
						cssdropdown.dynamichide(this, e)
					}, "mouseout") // hide drop down menu when main menu items
									// are mouse out
					this.addEvent(menuitems[i], function() {
						cssdropdown.delayhidemenu()
					}, "click") // hide drop down menu when main menu items are
								// clicked on
				}
			} // end inner for
		} // end outer for
		if (this.enableiframeshim && document.all && !window.XDomainRequest
				&& !this.iframeshimadded) { // enable iframe shim in IE5.5 thru
											// IE7?
			document
					.write('<IFRAME id="iframeshim" src="about:blank" frameBorder="0" scrolling="no" style="left:0; top:0; position:absolute; display:none;z-index:90; background: transparent;"></IFRAME>')
			this.shimobject = document.getElementById("iframeshim") // reference
																	// iframe
																	// object
			this.shimobject.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)'
			this.iframeshimadded = true
		}
	} // end startchrome

};

$(document)
		.ready(
				function() {
					var method = "POST";
					if(os!="ms") method = "GET";
					$(document)
							.on(
									"click",
									".rxFileDown",
									function() {
										$
												.fileDownload(
														exportSrc,
														{
//															preparingMessageHtml : "We are preparing your report, please wait...",
//															failMessageHtml : "There was a problem generating your report, please try again.",

															httpMethod : method,
															// data:
															// $(this).serialize()
															data : {
																SignOnly : 1,
																Type : $(this).attr("href"),
																jobID : jobID,
																curPageView: curPageView
															},
															successCallback : function() {
																hideMask();
															},
															failCallback : function(responseHtml, url) {
																hideMask();
															},
															checkInterval : 10
														}

												);
										return false;
									});
				});

String.prototype.trim = function(chars) {
	if (chars) {
		var str = "[" + chars + "\\s]+";
		return this.replace(new RegExp(str, "g"), "");
	}

	return this.replace(/^\s+|\s+$/g, "");

}
String.prototype.ltrim = function(chars) {
	if (chars) {
		var str = "^[" + chars + "\\s]+";
		return this.replace(new RegExp(str, "g"), "");
	}

	return this.replace(/^\s+/, "");
}
String.prototype.rtrim = function(chars) {
	if (chars) {
		var str = "[" + chars + "\\s]+$";
		return this.replace(new RegExp(str, "g"), "");
	}

	return this.replace(/\s+$/, "");
}

window.onunload = function () {
	ClearSession();
};
