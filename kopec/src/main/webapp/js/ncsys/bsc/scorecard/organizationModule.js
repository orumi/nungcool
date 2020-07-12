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
						$scope.selectMaps($scope.entity.selYear);
					},
					function(error){});

		});


		$scope.selectMaps = function(year) {
			clearSVGObject();
			$scope.entity.icons = null;
			$scope.entity.maps = null;
			$scope.entity.selMapId = null;

			organizationService._selectMapList({"year":year}).then(
					function(data){
						$scope.entity.maps = data.maps;

						if($scope.entity.maps.length>0){
							$scope.entity.selMapId = $scope.entity.maps[0].id;
							$scope.entity.curMap = $scope.entity.maps[0];
							$scope.adjustMap();
							svgCompus.css('background-image', 'url(../../mapImage/'+$scope.entity.curMap.background+')');
							$scope.selectIcons($scope.entity.selMapId);
						} else {
							console.log("map list noting");
							$scope.entity.icons = null;
						}
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
			console.log("selectIcons : "+ mapid);
			clearSVGObject();
			$scope.entity.icons = null;
			organizationService._selectIcons({"mapId":mapid, year:$scope.entity.selYear}).then(
					function(data){
						$scope.entity.icons = data.icon;
						//console.log($scope.entity.icons);
						if($scope.entity.icons.length>0){
							var idxMonth = Number($("#selMonth").val())-1;
							for(var i=0;i<$scope.entity.icons.length;i++){
								var icon = $scope.entity.icons[i];

								var color = getColor(icon.score[idxMonth]);
								icon.background = color.bgColor;
								icon.txtColor = color.txtColor;

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
				$scope.entity.years[$scope.entity.years.length] = Number(fYear-y+3);
			}
			//$scope.entity.selYear = $scope.entity.years[7];

			$scope.entity.selYear = Number(showyear);
			$scope.$apply();

			$("#selMonth").val(showmonth);

			deferred.resolve(true);
			return deferred.promise ;
		}



		$scope.changeYear = function(){
			$scope.selectMaps($scope.entity.selYear);
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



	});

	organizationApp.factory("organizationService", function($http, $q){

		var factory =
		{
				_selectMapList:function(pm){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:selectMapsUrl,
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

