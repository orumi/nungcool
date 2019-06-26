var RxAcrobatInfo = function(bwinfo) {

	var getActiveXObject = function(name) {
		try {
			return new ActiveXObject(name);
		} catch (e) {
		}
	};

	var getNavigatorPlugin = function(name) {
		for (key in navigator.plugins) {
			var plugin = navigator.plugins[key];
			if (plugin.name == name)
				return plugin;
		}
	};

	var getPDFPlugin = function() {
		try {
			return this.plugin = this.plugin
					|| function() {
						if (bwinfo == 'ie') {
							return getActiveXObject('AcroPDF.PDF')
									|| getActiveXObject('PDF.PdfCtrl');
						} else {
							return getNavigatorPlugin('Adobe Acrobat')
									|| getNavigatorPlugin('eFormPDF Browser Plugin')
									|| getNavigatorPlugin('Chrome PDF Viewer')
									|| getNavigatorPlugin('WebKit built-in PDF');
						}
					}();
		} catch (e) {
			alert(e.description);
		}
	};

	var isAcrobatInstalled = function() {
		return !!getPDFPlugin();
	};

	var getAcrobatVersion = function() {
		try {
			var plugin = getPDFPlugin();
			if (bwinfo == 'ie') {
				var versions = plugin.GetVersions().split(',');
				var latest = versions[0].split('=');
				return parseFloat(latest[1]);
			}

			if (plugin.version)
				return parseInt(plugin.version);
			return plugin.name;

		} catch (e) {
			return null;
		}
	};

	return {
		browser : bwinfo,
		acrobat : isAcrobatInstalled(),
		acrobatVersion : getAcrobatVersion()
	};
};
