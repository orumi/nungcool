	/* Angular app */
	var certiMngApp = angular.module("certiMngApp", []);
	
	certiMngApp.controller("certiMngController", function($scope, $http, $q, certiMngService){
		$scope.verid;
		
		$scope.version = [];
		$scope.selVersion ;
		
		$scope.field = [];
		$scope.selField ; 
		
		$scope.opProe = [{"val":"P"},{"val":"R"},{"val":"O"},{"val":"E"}];
		
		/* 담당자 구분 공통코드 */
		$scope.ownerType = [];
		
		/* 수행 주기 */
		$scope.opFrequency = [{"val":"월"},{"val":"분기"},{"val":"반기"},{"val":"년"}];
		
		$scope.certiDetail = {
				"rgldtlid":"", 
				"proofid":"", 
				"proofitem":"", 
				"frequency":"",
				"ownertype":"",
				"proe":"",
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
			console.log("certiMngController Init Starting ... ");
			$scope.selectInitInfo($scope.verid).then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});
			
			/* 공통 코드 */
			$scope.selectInit();
					
			
			
		});
		
		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			certiMngService._selectInitInfo().then(
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
		
		
		$scope.selectInit = function(){
			var deferred = $q.defer();
			certiMngService._selectCommonCd( {'codeid': 'COM077'} ).then(
					function(data){
						$scope.ownerType = data.commonCd;
						
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
			console.log("tag : "+tag);
			
			if(tag == "insertDetail"){
				$scope.certiDetail.proofid = "0";
				$scope.certiDetail.actionmode = "C";
				certiMngService._storeDetail($scope.certiDetail).then(
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
				$scope.certiDetail.actionmode = "U";
				certiMngService._storeDetail($scope.certiDetail).then(
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
					$scope.certiDetail.actionmode = "D";
					certiMngService._storeDetail($scope.certiDetail).then(
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
		
		
		$scope.actionSelectDetail = function(detailId, proofid){
			$scope.certiDetail.rgldtlid = detailId;
			$scope.certiDetail.proofid = proofid;
			$scope.certiDetail.actionmode = "R";
			
			certiMngService._selectDetail($scope.certiDetail).then(
				function(data){
					$scope.certiDetail = data.certiDetail;
					console.log("$scope.certiDetail rgldtlid:"+$scope.certiDetail.rgldtlid);
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}
		
		
	});	
	
	certiMngApp.factory("certiMngService", function($http, $q){
		
		var factory = {
				_selectInitInfo:function(pm){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:regulationDetialInfoURL,
						data:pm,
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
				_selectCommonCd:function(pm){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:commonCdURL,
						params:pm,
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
				_storeDetail:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:certiDetailURL,
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
				_selectDetail:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:certiDetailURL,
						params:{"mode":"select"},
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
	
	
	
	/* angular directive */
	certiMngApp.directive("popupCertiDetail", function(){
		return {
			templateUrl : "certiDetail.do"
	    };
	});
	
	