		/* jshint browser:true */
		/* eslint-env browser */
		/* eslint no-use-before-define:0 */
		/* global Uint8Array, Uint16Array, ArrayBuffer */

		
		var rABS = typeof FileReader !== "undefined" && typeof FileReader.prototype !== "undefined" && typeof FileReader.prototype.readAsBinaryString !== "undefined";
		if(!rABS) {
			document.getElementsByName("userabs")[0].disabled = true;
			document.getElementsByName("userabs")[0].checked = false;
		}
		
		var use_worker = typeof Worker !== 'undefined';
		if(!use_worker) {
			document.getElementsByName("useworker")[0].disabled = true;
			document.getElementsByName("useworker")[0].checked = false;
		}
		
		var transferable = use_worker;
		if(!transferable) {
			document.getElementsByName("xferable")[0].disabled = true;
			document.getElementsByName("xferable")[0].checked = false;
		}
		
		var wtf_mode = false;
		
		function fixdata(data) {
			var o = "", l = 0, w = 10240;
			for(; l<data.byteLength/w; ++l) o+=String.fromCharCode.apply(null,new Uint8Array(data.slice(l*w,l*w+w)));
			o+=String.fromCharCode.apply(null, new Uint8Array(data.slice(l*w)));
			return o;
		}
		
		function ab2str(data) {
			var o = "", l = 0, w = 10240;
			for(; l<data.byteLength/w; ++l) o+=String.fromCharCode.apply(null,new Uint16Array(data.slice(l*w,l*w+w)));
			o+=String.fromCharCode.apply(null, new Uint16Array(data.slice(l*w)));
			return o;
		}
		
		function s2ab(s) {
			var b = new ArrayBuffer(s.length*2), v = new Uint16Array(b);
			for (var i=0; i != s.length; ++i) v[i] = s.charCodeAt(i);
			return [v, b];
		}
		
		function xw_noxfer(data, cb) {
			var worker = new Worker(XW.noxfer);
			worker.onmessage = function(e) {
				switch(e.data.t) {
					case 'ready': break;
					case 'e': console.error(e.data.d); break;
					case XW.msg: cb(JSON.parse(e.data.d)); break;
				}
			};
			var arr = rABS ? data : btoa(fixdata(data));
			worker.postMessage({d:arr,b:rABS});
		}
		
		function xw_xfer(data, cb) {
			var worker = new Worker(rABS ? XW.rABS : XW.norABS);
			worker.onmessage = function(e) {
				switch(e.data.t) {
					case 'ready': break;
					case 'e': console.error(e.data.d); break;
					default: var xx=ab2str(e.data).replace(/\n/g,"\\n").replace(/\r/g,"\\r"); console.log("done"); cb(JSON.parse(xx)); break;
				}
			};
			if(rABS) {
				var val = s2ab(data);
				worker.postMessage(val[1], [val[1]]);
			} else {
				worker.postMessage(data, [data]);
			}
		}
		
		function xw(data, cb) {
			transferable = document.getElementsByName("xferable")[0].checked;
			if(transferable) xw_xfer(data, cb);
			else xw_noxfer(data, cb);
		}
		
		function get_radio_value( radioName ) {
			var radios = document.getElementsByName( radioName );
			for( var i = 0; i < radios.length; i++ ) {
				if( radios[i].checked || radios.length === 1 ) {
					return radios[i].value;
				}
			}
		}
		
		function to_json(workbook) {
			var result = {};
			workbook.SheetNames.forEach(function(sheetName) {
				var roa = X.utils.sheet_to_json(workbook.Sheets[sheetName]);
				if(roa.length > 0){
					result[sheetName] = roa;
				}
			});
			return result;
		}
		
		function to_csv(workbook) {
			var result = [];
			workbook.SheetNames.forEach(function(sheetName) {
				var csv = X.utils.sheet_to_csv(workbook.Sheets[sheetName]);
				if(csv.length > 0){
					result.push("SHEET: " + sheetName);
					result.push("");
					result.push(csv);
				}
			});
			return result.join("\n");
		}
		
		function to_formulae(workbook) {
			var result = [];
			workbook.SheetNames.forEach(function(sheetName) {
				var formulae = X.utils.get_formulae(workbook.Sheets[sheetName]);
				if(formulae.length > 0){
					result.push("SHEET: " + sheetName);
					result.push("");
					result.push(formulae.join("\n"));
				}
			});
			return result.join("\n");
		}
		
		var HTMLOUT = document.getElementById('htmlout');
		function to_html(workbook) {
			HTMLOUT.innerHTML = "";
			workbook.SheetNames.forEach(function(sheetName) {
				var htmlstr = X.write(workbook, {sheet:sheetName, type:'binary', bookType:'html'});
				HTMLOUT.innerHTML += htmlstr;
			});
		}
		
		
		
		var OUT = document.getElementById('out');
		var global_wb;
		function process_wb(wb) {
			global_wb = wb;
			var output = "";
			switch(get_radio_value("format")) {
				case "json":
					output = JSON.stringify(to_json(wb), 2, 2);
					break;
				case "form":
					output = to_formulae(wb);
					break;
				case "html": return to_html(wb);
				default:
					output = to_csv(wb);
			}
			
			loadJqGrid(output);
			//console.log("output : "+output);
			console.log("output", new Date());
			
			/* if(OUT.innerText === undefined) OUT.textContent = output;
			else OUT.innerText = output;
			if(typeof console !== 'undefined') console.log("output", new Date()); */
		}
		function setfmt() {if(global_wb) process_wb(global_wb); }
		window.setfmt = setfmt;
		
		
		function smartFile(e){
			var files = e.target.files;
			var f = files[0];
			{
				var reader = new FileReader();
				//var name = f.name;
				reader.onload = function(e) {
					if(typeof console !== 'undefined') console.log("smart onload", new Date());
					var data = e.target.result;
					xw(data, process_wb);
				};
				if(rABS) reader.readAsBinaryString(f);
				else reader.readAsArrayBuffer(f);
			}
		}
		
		var xlf = document.getElementById('xlf');
		if(xlf.addEventListener) xlf.addEventListener('change', smartFile, false);	
		
		
			