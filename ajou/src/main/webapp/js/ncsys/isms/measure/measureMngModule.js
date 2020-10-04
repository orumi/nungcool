	/* Angular app */
	var measureMngApp = angular.module("measureMngApp", []);
	
	measureMngApp.controller("measureMngController", function($scope, $http, $q, measureMngService){
		
		$scope.version = [];
		$scope.selVersion ; // version Object
		$scope.piverid ; // select option model 
		
		$scope.field = [];
		$scope.selField ;   // field Object
		
		$scope.measure = [];
		$scope.selMeasure ;  // measure Object
		
		$scope.measureDetail = {
				"msrdtlid":"", 
				"piverid":"", 
				"pifldid":"", 
				"msrid":"", 
				"msrdtlnm":"",
				"msrdtl":"",
				"certiact":"",
				"proofpds":"",
				"calmtd":"",
				"sortby":"",
				"actionmode":""
		}
		
		
		
		$(function(){
			/*init select infor */
			console.log("measureMngController Init Starting ... ");

			$scope.selectInitInfo().then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});
			
			
		});
		
		
		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			measureMngService._selectInitInfo().then(
					function(data){
						$scope.version = data.listVersion;
						$scope.field = data.listField;
						$scope.measure = data.listMeasure;
						
						if($scope.version[0]) {$scope.piverid = $scope.version[0].piverid; }
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
				$scope.measureDetail.msrdtlid = "0";
				$scope.measureDetail.piverid = $scope.piverid;
				$scope.measureDetail.actionmode = "I";
				
				oEditors.getById["txtDetail"].exec("UPDATE_CONTENTS_FIELD", []);
				oEditors.getById["txtCalMtd"].exec("UPDATE_CONTENTS_FIELD", []);
				
				$scope.measureDetail.msrdtl = $("#txtDetail").val();
				$scope.measureDetail.calmtd = $("#txtCalMtd").val();
				
				measureMngService._storeDetail($scope.measureDetail).then(
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
				$scope.measureDetail.piverid = $scope.piverid;
				$scope.measureDetail.actionmode = "U";
				
				oEditors.getById["txtDetail"].exec("UPDATE_CONTENTS_FIELD", []);
				oEditors.getById["txtCalMtd"].exec("UPDATE_CONTENTS_FIELD", []);
				
				$scope.measureDetail.msrdtl = $("#txtDetail").val();
				$scope.measureDetail.calmtd = $("#txtCalMtd").val();
				
				measureMngService._storeDetail($scope.measureDetail).then(
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
					$scope.measureDetail.piverid = $scope.piverid;
					$scope.measureDetail.actionmode = "D";
					measureMngService._storeDetail($scope.measureDetail).then(
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
			$scope.measureDetail.msrdtlid = detailId;
			$scope.measureDetail.piverid = $scope.selVersion;
			$scope.measureDetail.actionmode = "S";
			measureMngService._selectDetail($scope.measureDetail).then(
				function(data){
					$scope.measureDetail = data.measureDetail;
					
					/* textarea adjust */
					
					$("#txtDetail").val($scope.measureDetail.msrdtl);
					$("#txtCalMtd").val($scope.measureDetail.calmtd);
					
					if(oEditors.length > 0){
						/* 최초에는 textarea에 정보가 옮겨진 후에 에디터에 반영됨. */
						oEditors.getById["txtDetail"].exec("LOAD_CONTENTS_FIELD");
						oEditors.getById["txtCalMtd"].exec("LOAD_CONTENTS_FIELD");
					}
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}
		
		$scope.setClearDetail = function(){
			$scope.measureDetail.msrdtlid="";
			$scope.measureDetail.piverid=""; 
			$scope.measureDetail.pifldid="";
			$scope.measureDetail.msrid="";
			$scope.measureDetail.msrdtlnm="";
			$scope.measureDetail.msrdtl="";
			$scope.measureDetail.certiact="";
			$scope.measureDetail.proofpds="";
			$scope.measureDetail.calmtd="";
			$scope.measureDetail.sortby="";
			$scope.measureDetail.actionmode="";
			
			
			$("#txtDetail").val($scope.measureDetail.msrdtl);
			$("#txtCalMtd").val($scope.measureDetail.calmtd);
			if(oEditors.length>0){
				oEditors.getById["txtDetail"].exec("LOAD_CONTENTS_FIELD");
				oEditors.getById["txtCalMtd"].exec("LOAD_CONTENTS_FIELD");
			}
			$scope.$apply();
		}
		
		
		
		$scope.actionPerformedField = function(tag){
			if(tag == "insertField"){
				$scope.selField.pifldid = "0";
				$scope.selField.actionmode = "I";
				measureMngService._storeField($scope.selField).then(
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
				measureMngService._storeField($scope.selField).then(
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
					measureMngService._storeField($scope.selField).then(
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
		
		$scope.actionPerformedMeasure = function(tag){
			if(tag == "insertMeasure"){
				$scope.selMeasure.msrid = "0";
				$scope.selMeasure.actionmode = "I";
				measureMngService._storeMeasure($scope.selMeasure).then(
						function(data){
							if(data.reVal == "ok_resend"){
								$scope.measure = data.listMeasure;
								//closeBranch();
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "updateMeasure") {
				$scope.selMeasure.actionmode = "U";
				measureMngService._storeMeasure($scope.selMeasure).then(
						function(data){
							if(data.reVal == "ok_resend"){
								$scope.measure = data.listMeasure;
								//closeBranch();
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "deleteMeasure"){
				if(confirm("선택한 정보를 삭제하시겠습니까?")){
					$scope.selMeasure.actionmode = "D";
					measureMngService._storeMeasure($scope.selMeasure).then(
							function(data){
								if(data.reVal == "ok_resend"){
									$scope.Measure = data.listMeasure;
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
				$scope.selVersion.piverid = "0";
				$scope.selVersion.actionmode = "I";
				measureMngService._storeVersion($scope.selVersion).then(
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
				measureMngService._storeVersion($scope.selVersion).then(
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
					measureMngService._storeVersion($scope.selVersion).then(
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
		
		$scope.actionShowFieldDetail = function(field){
			
			$("#btn_insert_field").hide();
			$("#btn_update_field").show();
			$("#btn_delete_field").show();
			$scope.selField = field;
		}
		
		$scope.actionShowMeasure = function(msr){
			$("#btn_insert_measure").hide();
			$("#btn_update_measure").show();
			$("#btn_delete_measure").show();
			$scope.selMeasure = msr;
		}
		
		$scope.actionShowVersion = function(ver){
			$("#btn_insert_version").hide();
			$("#btn_update_version").show();
			$("#btn_delete_version").show();
			$scope.selVersion = ver;
		}
		
	});	
	
	measureMngApp.factory("measureMngService", function($http, $q){
		
		var factory = {
				_selectInitInfo:function(pm){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:measureDetailInfoURL,
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
						url:measureDetailURL,
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
						url:measureDetailURL,
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
						url:measureFieldURL,
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
				_storeMeasure:function(measure){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:measureURL,
						params:{"mode":"modify"},
						data:measure,
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
	measureMngApp.directive("popupMeasureDetail", function(){
		return {
			templateUrl : "measureDetail.do"
	    };
	});

	/* angular directive */
	measureMngApp.directive("popupMeasureVersion", function(){
		return {
			templateUrl : "version.do"
	    };
	});
	
	