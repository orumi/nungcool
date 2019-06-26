	/* Angular app */
	var regulationDetailApp = angular.module("regulationDetailApp", []);
	
	regulationDetailApp.controller("regulationDetailController", function($scope, $http, $q, regulationDetailService){
		
		$scope.verid;
		
		$scope.version = [];
		$scope.selVersion ;
		
		$scope.field = [];
		$scope.selField ; 
		
		$scope.regulation = [];
		$scope.selRegulation ;
		
		$scope.regulationDetail = {
				"rgldtlid":"", 
				"verid":"", 
				"fldid":"", 
				"rglid":"", 
				"rglnm":"", 
				"sortby":"",
				"dsort":"", 
				"rgldtlnm":"", 
				"mgrgoal":"",
				"ismsstd":"",
				"referdoc":"",
				"referpds":"",
				"adjustyn":"",
				"adjustcnt":"",
				"actionmode":""
		}
		
		
		
		$(function(){
			/*init select infor */
			console.log("regulationDetailController Init Starting ... ");
			$scope.selectInitInfo($scope.verid).then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});
			
			
		});
		
		
		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			regulationDetailService._selectInitInfo().then(
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
		
		/* action performed */
		
		$scope.actionPerformed = function(tag){
			if(tag == "insertDetail"){
				$scope.regulationDetail.rgldtlid = "0";
				$scope.regulationDetail.verid = $scope.verid;
				$scope.regulationDetail.actionmode = "I";
				regulationDetailService._storeDetail($scope.regulationDetail).then(
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
				$scope.regulationDetail.verid = $scope.verid;
				$scope.regulationDetail.actionmode = "U";
				regulationDetailService._storeDetail($scope.regulationDetail).then(
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
					$scope.regulationDetail.verid = $scope.verid;
					$scope.regulationDetail.actionmode = "D";
					regulationDetailService._storeDetail($scope.regulationDetail).then(
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
		
		$scope.actionSelectDetail = function(detailId){
			$scope.regulationDetail.rgldtlid = detailId;
			$scope.regulationDetail.verid = $scope.verid;
			$scope.regulationDetail.actionmode = "S";
			regulationDetailService._selectDetail($scope.regulationDetail).then(
				function(data){
					$scope.regulationDetail = data.regulationDetail;
					console.log("$scope.regulationDetail rgldtlnm:"+$scope.regulationDetail.rgldtlnm);
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}
		
		$scope.setClearDetail = function(){
			$scope.regulationDetail.rgldtlid=""; 
			$scope.regulationDetail.verid="";
			$scope.regulationDetail.fldid="";
			$scope.regulationDetail.rglid=""; 
			$scope.regulationDetail.rglnm="";
			$scope.regulationDetail.sortby="";
			$scope.regulationDetail.dsort=""; 
			$scope.regulationDetail.rgldtlnm="";
			$scope.regulationDetail.mgrgoal="";
			$scope.regulationDetail.ismsstd="";
			$scope.regulationDetail.referdoc="";
			$scope.regulationDetail.referpds="";
			$scope.regulationDetail.adjustyn="";
			$scope.regulationDetail.adjustcnt="";
			
			$scope.$apply();
		}
		
		
		
		$scope.actionPerformedField = function(tag){
			if(tag == "insertField"){
				$scope.selField.fldid = "0";
				$scope.selField.actionmode = "I";
				regulationDetailService._storeField($scope.selField).then(
						function(data){
							if(data.reVal == "ok_resend"){
								$scope.field = data.listField;
								//closeBranch();
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "updateField") {
				$scope.selField.actionmode = "U";
				regulationDetailService._storeField($scope.selField).then(
						function(data){
							if(data.reVal == "ok_resend"){
								$scope.field = data.listField;
								//closeBranch();
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "deleteField"){
				if(confirm("선택한 정보를 삭제하시겠습니까?")){
					$scope.selField.actionmode = "D";
					regulationDetailService._storeField($scope.selField).then(
							function(data){
								if(data.reVal == "ok_resend"){
									$scope.field = data.listField;
									//closeBranch();
								}
							},
							function(error){
								console.log("actionPerformed error: "+error);
							}
						);
				}
			}
		}
		
		$scope.actionPerformedRegulation = function(tag){
			if(tag == "insertRegulation"){
				$scope.selRegulation.rglid = "0";
				$scope.selRegulation.actionmode = "I";
				regulationDetailService._storeRegulation($scope.selRegulation).then(
						function(data){
							if(data.reVal == "ok_resend"){
								$scope.regulation = data.listRegulation;
								//closeBranch();
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "updateRegulation") {
				$scope.selRegulation.actionmode = "U";
				regulationDetailService._storeRegulation($scope.selRegulation).then(
						function(data){
							if(data.reVal == "ok_resend"){
								$scope.regulation = data.listRegulation;
								//closeBranch();
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "deleteRegulation"){
				if(confirm("선택한 정보를 삭제하시겠습니까?")){
					$scope.selRegulation.actionmode = "D";
					regulationDetailService._storeRegulation($scope.selRegulation).then(
							function(data){
								if(data.reVal == "ok_resend"){
									$scope.regulation = data.listRegulation;
									//closeBranch();
								}
							},
							function(error){
								console.log("actionPerformed error: "+error);
							}
						);
				}
			}
		}
		
		
		$scope.actionPerformedVersion = function(tag){
			if(tag == "insertVersion"){
				$scope.selVersion.verid = "0";
				$scope.selVersion.actionmode = "I";
				regulationDetailService._storeVersion($scope.selVersion).then(
						function(data){
							if(data.reVal == "ok_resend"){
								$scope.version = data.listVersion;
								//closeBranch();
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "updateVersion") {
				$scope.selVersion.actionmode = "U";
				regulationDetailService._storeVersion($scope.selVersion).then(
						function(data){
							if(data.reVal == "ok_resend"){
								$scope.version = data.listVersion;
								//closeBranch();
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "deleteVersion"){
				if(confirm("선택한 정보를 삭제하시겠습니까?")){
					$scope.selVersion.actionmode = "D";
					regulationDetailService._storeVersion($scope.selVersion).then(
							function(data){
								if(data.reVal == "ok_resend"){
									$scope.version = data.listVersion;
									//closeBranch();
								}
							},
							function(error){
								console.log("actionPerformed error: "+error);
							}
						);
				}
			}
		}
		
		$scope.actionShowYieldDetail = function(yield){
			
			$("#btn_insert_field").hide();
			$("#btn_update_field").show();
			$("#btn_delete_field").show();
			$scope.selField = yield;
		}
		
		$scope.actionShowRegulation = function(rgl){
			$("#btn_insert_regulation").hide();
			$("#btn_update_regulation").show();
			$("#btn_delete_regulation").show();
			$scope.selRegulation = rgl;
		}
		
		$scope.actionShowVersion = function(ver){
			$("#btn_insert_version").hide();
			$("#btn_update_version").show();
			$("#btn_delete_version").show();
			$scope.selVersion = ver;
		}
		
	});	
	
	regulationDetailApp.factory("regulationDetailService", function($http, $q){
		
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
				_storeDetail:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:regulationDetialURL,
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
						url:regulationDetialURL,
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
				},
				_storeField:function(field){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:regulationFieldURL,
						params:{"mode":"modify"},
						data:field,
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
				_storeRegulation:function(regulation){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:regulationURL,
						params:{"mode":"modify"},
						data:regulation,
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
				_storeVersion:function(version){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:versionURL,
						params:{"mode":"modify"},
						data:version,
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
	regulationDetailApp.directive("popupRegulationDetail", function(){
		return {
			templateUrl : "regulationDetail.do"
	    };
	});

	/* angular directive */
	regulationDetailApp.directive("popupRegulationVersion", function(){
		return {
			templateUrl : "version.do"
	    };
	});
	
	