	/* Angular app */
	var organizationApp = angular.module("organizationApp", []);

	organizationApp.controller("organizationController", function($scope, $http, $q, organizationService){

		$scope.entity = {
			selYear : null,
			years : [],
			maps : [],
			mapImages : [],
			selMapId : null,
			curMap : null,
			icons : [],
			curIcon : null,
			curWrap : null,
			map : {
				"actionmode":"",
				"year":"",
				"id":"",
				"mapname":"",
				"background":"",
				"iconprops":"",
				"maprank":"",
				"iconWidth":"",
				"iconHeight":"",
				"iconShape":"",
				"showtext":"",
				"showscore":"",
				"mapkind":""
			},
			icon : {
				"id":"",
				"mapid":"",
				"iconstyle":"",
				"icontext":"",
				"x":"",
				"y":"",
				"width":"",
				"height":"",
				"treelevel":"",
				"treeid":"",
				"showtext":"",
				"showscore":""
			}

		}

		/* tree load data */
		$scope.source =
        {
            datatype: "json",
            datafields: [
                { name: 'id' },
                { name: 'parentid' },
                { name: 'label' },
                { name: 'icon'},
                { name: 'value' }
            ],
            id: 'id',
            icon: 'icon',
            localdata: null
        };

		$(function(){
			/*init select infor */
			console.log("organizationController Init Starting ... ");
			/* 초기 설정 */
			$scope.init().then(
					function(rslv){
						$scope.selectHierarchy($scope.entity.selYear.value);
						$scope.selectMapImages();
					},
					function(error){});

		});


		$scope.selectHierarchy = function (year){
			organizationService._selectOrgList({"year":year}).then(
					function(data){
						$scope.entity.maps = data.maps;

						if($scope.entity.maps.length>0){
							$scope.entity.selMapId = $scope.entity.maps[0].id;
							$scope.entity.curMap = $scope.entity.maps[0];
							$scope.adjustMap();
							svgCompus.css('background-image', 'url(../../mapImage/'+$scope.entity.curMap.background+')');
							$scope.selectIcons($scope.entity.selMapId);
						}

						$scope.source.localdata = data.node;

                    	var dataAdapter = new $.jqx.dataAdapter($scope.source);
                        // perform Data Binding.
                        dataAdapter.dataBind();
                        // get the tree items. The first parameter is the item's id. The second parameter is the parent item's id. The 'items' parameter represents
                        // the sub items collection name. Each jqxTree item has a 'label' property, but in the JSON data, we have a 'text' field. The last parameter
                        // specifies the mapping between the 'text' and 'label' fields.
                        var records = dataAdapter.getRecordsHierarchy('id', 'parentid', 'items', [{ name: 'label', map: 'label'}]);

                        $('#jqxTree').jqxTree({ source: records });
                        $('#jqxTree').jqxTree('expandAll');

                        $('#jqxTree').jqxTree('render');
					},
					function(error){
						console.log("actionPerformed error: "+error);
					}
				);
		}
		$scope.selectMapImages = function (){
			organizationService._selectMapImages().then(
					function(data){
						$scope.entity.mapImages = data.images;
					},
					function(error){
						console.log("actionPerformed error: "+error);
					}
				);

		}

		$scope.adjustMap = function(){
			var iconProps = $scope.entity.curMap.iconprops;
			if(iconProps != null ){
				var iconP = iconProps.split(",");
				$scope.entity.curMap.iconWidth = iconP[0];
				$scope.entity.curMap.iconHeight = iconP[1];
				$scope.entity.curMap.iconShape = iconP[2];
				$scope.entity.curMap.showtext = iconP[3];
				$scope.entity.curMap.showscore = iconP[4];

			}
		}


		$scope.selectIcons = function(mapid){
			clearSVGObject();
			organizationService._selectIcons({"mapid":mapid}).then(
					function(data){
						$scope.entity.icons = data.icon;
						//console.log($scope.entity.icons);
						if($scope.entity.icons.length>0){
							for(var i=0;i<$scope.entity.icons.length;i++){
								var icon = $scope.entity.icons[i];
								addSVGObject(icon);
							}
						}
					},
					function(error){
						console.log("actionPerformed error: "+error);
					}
				);
		}

		$scope.init = function(){
			var deferred = $q.defer();
			var date = new Date();
			var fYear = date.getFullYear();

			for(var y=10; y>0; y--){
				$scope.entity.years[$scope.entity.years.length] = {"value":(fYear-y+3)};
			}
			$scope.entity.selYear = $scope.entity.years[7];

			$scope.$apply();

			deferred.resolve(true);
			return deferred.promise ;
		}



		$scope.changeYear = function(){
			$scope.selectHierarchy($scope.entity.selYear.value);
		}

		$scope.changeMapList = function(){
			// current Map
			var maps = $scope.entity.maps;
			for(var i=0; i<maps.length; i++){

				if($scope.entity.selMapId == maps[i].id){
					$scope.entity.curMap = maps[i];
				}
			}

			if($scope.entity.curMap != null){
				//$scope.selectIcons($scope.entity.selMapId);
				$scope.adjustMap();
				//console.log("map background : "+$scope.entity.curMap.background);
				svgCompus.css('background-image', 'url(../../mapImage/'+$scope.entity.curMap.background+')');
				svgCompus.css('background-repeat', 'no-repeat');

				$scope.selectIcons($scope.entity.curMap.id);
			}
		}


		/* properties controller */
		$scope.openProperties = function(tag){

			if (tag == "U"){
				$scope.entity.map.actionmode = "U";
				$scope.entity.map.year = $scope.entity.curMap.year;
				$scope.entity.map.id = $scope.entity.curMap.id;
				$scope.entity.map.mapname = $scope.entity.curMap.mapname;
				$scope.entity.map.background=$scope.entity.curMap.background;
				$scope.entity.map.iconprops=$scope.entity.curMap.iconprops;
				$scope.entity.map.maprank=$scope.entity.curMap.maprank;
				$scope.entity.map.iconWidth=$scope.entity.curMap.iconWidth;
				$scope.entity.map.iconHeight=$scope.entity.curMap.iconHeight;
				$scope.entity.map.iconShape=$scope.entity.curMap.iconShape;
				$scope.entity.map.showtext=$scope.entity.curMap.showtext;
				$scope.entity.map.showscore=$scope.entity.curMap.showscore;
				$scope.entity.map.mapkind=$scope.entity.curMap.mapkind;

				$("#btn_delete_map").show();

			} else if (tag== "C") {
				$scope.entity.map.actionmode = "C";
				$scope.entity.map.year="";
				$scope.entity.map.id="";
				$scope.entity.map.mapname="";
				$scope.entity.map.background="";
				$scope.entity.map.iconprops="";
				$scope.entity.map.maprank="";
				$scope.entity.map.iconWidth="";
				$scope.entity.map.iconHeight="";
				$scope.entity.map.iconShape="";
				$scope.entity.map.showtext="";
				$scope.entity.map.showscore="";
				$scope.entity.map.mapkind="";

				$("#btn_delete_map").hide();

			}

			$("#div_properties").show();
        	$(".wrap").after("<div class='overlay'></div>");
		}

		$scope.closeProperties = function(){
			$("#div_properties").hide();
        	$(".wrap").after("<div class='overlay'></div>");

        	$(".overlay").remove();
		}

		// file upload
	    $scope.fileUpload = function (event) {

	        var files = event.target.files;
	        for (var i = 0; i < files.length; i++) {
	        	var file = files[i];
	        	var reader = new FileReader();

        		reader.onload = _fileIsLoaded;
	        	reader.readAsDataURL(file);
	        }

	    }

	    /* file down load */
	    $scope.fileDown = function(actualFile) {
	    	var aURL = attachURL+"?atchFileId="+actualFile.proofid+"&fileSn="+actualFile.attachseq;

	    	console.log(aURL);

	    	window.open(aURL);
	    }

	    /* action file upload */
	    _fileIsLoaded = function (e) {
	        $scope.$apply(function () {

	        	var file = $scope.myFile;
	        	//var file = $('input[type=file]')[0].files[0];
	        	/*
	        	console.log('file is ' );
	        	console.dir(file);
	        	organizationApp.directive('fileModel', ['$parse', function ($parse) {
	        	*/

	        	var formData = new FormData();
	        	formData.append('file', file);
	        	formData.append('fileTag', "mapImage");

	            var config = {
	         	   	transformRequest: angular.identity,
	         	   	transformResponse: angular.identity,
	     	   		headers : {
	     	   			'Content-Type': undefined
	     	   	    }
	            }

	            $http.post(uploadFileURL, formData, config).then(function (response) {
	            	var reJson = $.parseJSON(response.data)
	            	$scope.entity.mapImages = reJson.images;

	            	console.log("upload success");
	    		}, function (response) {
	    			console.log("upload failure");
	    		});


	        });
	    }


		$scope.actionPerformed = function(tag){
			//console.log("tag : "+tag);

			if(tag == "adjustMap"){
				if($scope.form_detail.$valid){

					$scope.entity.map.year = $scope.entity.selYear.value;
					$scope.entity.map.mapkind = "0";  //조직체계도 종류

					var showText = $scope.entity.map.showtext == true?"1":"0";
					var showScore = $scope.entity.map.showscore == true?"1":"0";

					$scope.entity.map.iconprops = $scope.entity.map.iconWidth+","+$scope.entity.map.iconHeight+","+$scope.entity.map.iconShape+","+showText+","+showScore;

					organizationService._storeDetail($scope.entity.map).then(
							function(data){
								if(data.reVal == "ok_resend"){
									$scope.closeProperties();
									$scope.entity.maps = data.maps;
									// change mapImage
									if(data.map.actionmode=="U"){
										$scope.entity.curMap = data.map;
										$scope.adjustMap();
										svgCompus.css('background-image', 'url(../../mapImage/'+$scope.entity.curMap.background+')');
									}


								}
							},
							function(error){
								console.log("actionPerformed error: "+error);
							}
						);
				} else {
					console.log("form invalided");
					alert("입력하지 않거나 잘못된 정보가 있습니다.");
				}
			} else if(tag == "updateIcons"){
				// select icons;
				var length = svgMoveAndResizeTool.wrappedElements.length;

				$scope.entity.icons.length = 0;

				for(var i=0; i<length; i++){
					var wrapper = $(svgMoveAndResizeTool.wrappedElements[i].externalWrapperQueryStr)
					var icon = svgMoveAndResizeTool.wrappedElements[i].originalSvg.icon;

					icon.mapid = $scope.entity.curMap.id;

				    icon.x = parseInt(wrapper.css('left'))+8;
				    icon.y = parseInt(wrapper.css('top'))+8;
				    icon.width = parseInt(wrapper.css('width'))-16;
				    icon.height = parseInt(wrapper.css('height'))-16;

					$scope.entity.icons[i] = icon;

				}

				organizationService._storeIcons($scope.entity.icons).then(
					function(data){
						if(data.reVal == "ok_resend"){
							clearSVGObject();
							$scope.entity.icons = data.icon;
							//console.log($scope.entity.icons);
							if($scope.entity.icons.length>0){
								for(var i=0;i<$scope.entity.icons.length;i++){
									var icon = $scope.entity.icons[i];
									addSVGObject(icon);
								}
							}

							alert("조직체계구성이 저장되었습니다.");
						}
					},
					function(error){
						console.log("actionPerformed error: "+error);
					}
				);
			} else if(tag == "deleteDetail"){
				if(confirm("선택한 정보를 삭제하시겠습니까?")){
					$scope.actualDetail.actionmode = "D";
					actualMngService._storeDetail($scope.actualDetail).then(
							function(data){
								if(data.reVal == "ok_resend"){
									actionClose();
									reloadGrid();
								}
							},
							function(error){
								console.log("actionPerformed error: "+error);
							}
						);
				}
			} else if(tag == "iconSave") {
				var icon = new Object();
				icon.x = $scope.entity.icon.x;
				icon.y = $scope.entity.icon.y;
				icon.width = $scope.entity.icon.width;
				icon.height = $scope.entity.icon.height;

				icon.iconstyle = $scope.entity.icon.iconstyle;

				$scope.entity.curWrap.updateIcon(icon);
				$scope.entity.curWrap.adjustWrapper();

			} else if (tag == "iconDelete") {
				svgMoveAndResizeTool.delWrapper();
			} else if ( tag == "iconAllSave") {

				var icon = new Object();
				icon.x = $scope.entity.icon.x;
				icon.y = $scope.entity.icon.y;
				icon.width = $scope.entity.icon.width;
				icon.height = $scope.entity.icon.height;

				icon.iconstyle = $scope.entity.icon.iconstyle;

				svgMoveAndResizeTool.updateAll(icon);
				$scope.entity.curWrap.adjustWrapper();

			}
		}

	});

	organizationApp.factory("organizationService", function($http, $q){

		var factory =
		{
				_selectOrgList:function(pm){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:selectHerarchyUrl,
						params:pm,
						headers: {'Content-Type': 'application/json'}
					}).then(
						function successCallback(response) {
							deferred.resolve(response.data);
						},
						function errorCallback(response) {
							console.log("failed to http ");
							deferred.reject("failed to select");
						}
					);
					return deferred.promise ;
				},
				_selectMapImages:function(){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:selectMapImagesUrl,
						params:{},
						headers: {'Content-Type': 'application/json'}
					}).then(
						function successCallback(response) {
							deferred.resolve(response.data);
						},
						function errorCallback(response) {
							console.log("failed to http ");
							deferred.reject("failed to select");
						}
					);
					return deferred.promise ;
				},
				_selectIcons:function(pm){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:selectIconsUrl,
						params:pm,
						headers: {'Content-Type': 'application/json'}
					}).then(
						function successCallback(response) {
							deferred.resolve(response.data);
						},
						function errorCallback(response) {
							console.log("failed to http ");
							deferred.reject("failed to select");
						}
					);
					return deferred.promise ;
				},
				_storeDetail:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:setMapPropertyUrl,
						params:{"mode":"modify"},
						data:detail,
						headers: {'Content-Type': 'application/json'}
					}).then(
						function successCallback(response) {
							deferred.resolve(response.data);
						},
						function errorCallback(data) {
							console.log("failed to http ");
							deferred.reject("failed to select");
						}
					);
					return deferred.promise ;
				},
				_storeIcons:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:setMapIconsUrl,
						params:{"mode":"modify"},
						data:detail,
						headers: {'Content-Type': 'application/json'}
					}).then(
						function successCallback(response) {
							deferred.resolve(response.data);
						},
						function errorCallback(data) {
							console.log("failed to http ");
							deferred.reject("failed to select");
						}
					);
					return deferred.promise ;
				}
		}
		return factory;

	});


	organizationApp.directive('fileModel', ['$parse', function ($parse) {
	    return {
	        restrict: 'A',
	        link: function(scope, element, attrs) {
	            var model = $parse(attrs.fileModel);
	            var modelSetter = model.assign;

	            element.bind('change', function(){
	                scope.$apply(function(){
	                    modelSetter(scope, element[0].files[0]);
	                });
	            });
	        }
	    };
	}]);

	/* angular directive */
	organizationApp.directive("popupMapProperties", function(){
		return {
			templateUrl : "mapProperties.do"
	    };
	});

