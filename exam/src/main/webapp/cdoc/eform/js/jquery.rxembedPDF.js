(function($) {

	$.fn.embedPDF = function(options) {

		var frameCss = '';

		options = $.extend({}, $.fn.embedPDF.defaults, options);

		options.src = ((options.src).toLowerCase().indexOf('pdf') != -1) ? options.src
				: options.src + '&mime=.pdf';

		if (hasReaderActiveX()) {
			var pdfOpt = '#'
					+ $.fn.embedPDF.buildQueryString(options.pdfOpenParams);

			options.src = options.src + pdfOpt;
		}

		if ('100%' == options.width && '100%' == options.height) {
			options.style += ';overflow:hidden;overflow-x:hidden;overflow-y:hidden;height:100%;width:100%;position:absolute;top:-2px;left:-2px;right:0px;bottom:0px;';
			//$('body').css('overflow', 'hidden');
		}

		if ('get' == options.method.toLowerCase()) {
			var div = $('<iframe width="' + options.width + '" height="'
					+ options.height + '" src="' + options.src
					+ '" name="pdfViewer" id="pdfViewer" style="'
					+ options.style + '">');

			$(this).append(div);
		} else if ('post' == options.method.toLowerCase()) {
			var f = options.form;

			var div = $('<iframe width="' + options.width + '" height="'
					+ options.height
					+ '" name="pdfViewer" id="pdfViewer" style="'
					+ options.style + '">');

			$(this).append(div);

			f.attr('action', options.src);
			f.attr('target', 'pdfViewer');
			f.submit();
		} else {
			alert('전송 방식이 정의되지 않았습니다.(options.method)');
		}

    
		return this;

	};

	$.fn.embedPDF.buildQueryString = function(pdfParams) {

		var string = "", prop;
		if (!pdfParams) {
			return string;
		}
		for (prop in pdfParams) {
			if (pdfParams.hasOwnProperty(prop)) {
				string += prop + "=";
				if (prop === "search") {
					string += encodeURI(pdfParams[prop]);
				} else {
					string += pdfParams[prop];
				}
				string += "&";
			}
		}
		return string.slice(0, string.length - 1);

	};

	$.fn.embedPDF.defaults = {
		src : '',
		method : 'get',
		width : 400,
		height : 400,
		style : '',
		pdfOpenParams : {
			zoom : 'scale',
			view : 'FitV',
			pagemode : 'none',
			scrollbar : 1,
			toolbar : 1,
			statusbar : 1,
			messages : 1,
			navpanes : 1,
			page : 1
		},
		form : $('<form method="post">')
	};

	var hasReaderActiveX = function() {
		var axObj = null;
		try {
			if (window.ActiveXObject) {
				axObj = new ActiveXObject("AcroPDF.PDF");
				if (!axObj) {
					axObj = new ActiveXObject("PDF.PdfCtrl");
				}
				if (axObj !== null) {
					return true;
				}
			}
			return false;
		} catch (e) {
			return false;
		}

	};

	var hasReader = function() {
		var i, n = navigator.plugins, count = n.length, regx = /Adobe Reader|Adobe PDF|Acrobat/gi;
		for (i = 0; i < count; i++) {
			if (regx.test(n[i].name)) {
				return true;
			}
		}
		return false;
	};

	var hasGeneric = function() {
		var plugin = navigator.mimeTypes["application/pdf"];
		return (plugin && plugin.enabledPlugin);
	};

	var pluginFound = function() {
		var type = null;
		if (hasReader() || hasReaderActiveX()) {
			type = "Adobe";
		} else if (hasGeneric()) {
			type = "generic";
		}
		return type;
	};

})(jQuery);