	/* Angular app */
	var inspectMngApp = angular.module("inspectMngApp", []);

	inspectMngApp.controller("inspectMngController", function($scope, $http, $q, inspectMngService){
		$scope.verid;

		$scope.version = [];
		$scope.selVersion ;

		$scope.field = [];
		$scope.selField ;


		$scope.inspectDetail = {
				"rgldtlid":"",
				"itemseq":"",
				"inspectitem":"",
				"inspectdetail":"",
				"actionmode":"",
				"fldid":"",
				"fldnm":"",
				"rgldtlnm":"",
				"ismsstd":"",
				"rglid":"",
				"rglnm":"",
				"verid":""
		}


		$(function(){
			/*init select infor */
			console.log("inspectMngController Init Starting ... ");
			$scope.selectInitInfo($scope.verid).then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});


		});

		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			inspectMngService._selectInitInfo().then(
					function(data){
						$scope.version = data.listVersion;
						$scope.field = data.listField;
						$scope.regulation = data.listRegulation;

						if($scope.version[0]) {$scope.verid = $scope.version[0].verid; }
						deferred.resolve(true);
					},
					function(error){
						console.log("actionPerformed insert error: "+error);
						deferred.reject("failed to selectInitInfo");
					}
				);

			return deferred.promise ;
		}


		$scope.actionPerformed = function(tag){
			if(tag == "insertDetail"){
				$scope.inspectDetail.itemseq = "0";
				$scope.inspectDetail.actionmode = "C";
				inspectMngService._storeDetail($scope.inspectDetail).then(
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
			} else if(tag == "updateDetail"){
				$scope.inspectDetail.actionmode = "U";
				inspectMngService._storeDetail($scope.inspectDetail).then(
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
			} else if(tag == "deleteDetail"){
				if(confirm("선택한 정보를 삭제하시겠습니까?")){
					$scope.inspectDetail.actionmode = "D";
					inspectMngService._storeDetail($scope.inspectDetail).then(
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
			}
		}


		$scope.actionSelectDetail = function(detailId, itemseq){
			$scope.inspectDetail.rgldtlid = detailId;
			$scope.inspectDetail.itemseq = itemseq;
			$scope.inspectDetail.actionmode = "R";

			inspectMngService._selectDetail($scope.inspectDetail).then(
				function(data){
					$scope.inspectDetail = data.inspectDetail;
					console.log("$scope.inspectDetail rgldtlid:"+$scope.inspectDetail.rgldtlid);
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}


	});

	inspectMngApp.factory("inspectMngService", function($http, $q){

		var factory = {
				_selectInitInfo:function(pm){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:regulationDetialInfoURL,
						data:pm,
						headers: {'Content-Type': 'application/json','X-CSRF-TOKEN': token}
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
				_storeDetail:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:inspectDetialURL,
						params:{"mode":"modify"},
						data:detail,
						headers: {'Content-Type': 'application/json','X-CSRF-TOKEN': token}
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
				_selectDetail:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:inspectDetialURL,
						params:{"mode":"select"},
						data:detail,
						headers: {'Content-Type': 'application/json','X-CSRF-TOKEN': token}
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



	/* angular directive */
	inspectMngApp.directive("popupInspectDetail", function(){
		return {
			templateUrl : "inspectDetail.do"
	    };
	});

