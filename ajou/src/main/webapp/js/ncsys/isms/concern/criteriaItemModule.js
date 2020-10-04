	/* Angular app */
	var criteriaItemApp = angular.module("criteriaItemApp", []);
	
	criteriaItemApp.controller("criteriaItemController", function($scope, $http, $q, httpService){
		
		$scope.entity = {
				 selCriteriaVers     : []
				,selCriteriaVerId    : null
				,criteriaVer : {
					 ctrverid : null
					,ctrvernm : null
					,sortby : null
					,actionmode : null
				}
		
				,criteriaItem :{
					 ctrverid : null
					,ctritemid : null
					,currentstate : null
					,guideline : null
					,article : null
					,ctrcnt : null
					,ctrccn : null
					,legal : null
					,protect : null
					,actionplan : null
					,rmk : null
					,sortby : null
					,actionmode : null
				}
		}
		
		
		
		$(function(){
			/*init select infor */
			console.log("criteriaItemController Init Starting ... ");
			$scope.selectInitInfo().then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});
			
			
		});
		
		
		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			httpService._httpPost(criteriaItemInitURL, null, null).then(
					function(data){
						$scope.entity.selCriteriaVers = data.reCriteriaVersion;
						
						if($scope.entity.selCriteriaVers[0]) {
							$scope.entity.selCriteriaVerId = $scope.entity.selCriteriaVers[0].ctrverid;
						}
						
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
			if($scope.form_detail.$valid){
				var pm = {mode:"modify"};
				if(tag == "insertDetail"){
					$scope.entity.criteriaItem.actionmode = "I";
					$scope.entity.criteriaItem.ctrverid = $scope.entity.selCriteriaVerId;
				} else if (tag == "updateDetail"){
					$scope.entity.criteriaItem.actionmode = "U";
				} else if (tag == "deleteDetail"){
					if(confirm("선택한 정보를 삭제하시겠습니까?")){
						$scope.entity.criteriaItem.actionmode = "D";
					} else {
						return;
					}
				}
				
				httpService._httpPost(criteriaItemDetailURL, pm, $scope.entity.criteriaItem).then(
					function(data){
						if(data.reVal == "ok_resend"){
							setTimeout(function(){
								actionClose();
								reloadGrid();
							},500);
						} else if(data.reVal == "failure_resend") {
							alert("저장하는데 오류가 발생되었습니다. 관리자에게 문의바랍니다.")
						}
						
					},
					function(error){
						console.log("actionPerformed error: "+error);
					}
				);
			} else {
				alert("입력하지 않는 정보가 있습니다.");
			}	
1		}
		
		$scope.actionSelectDetail = function(ctritemid){
			
			$scope.entity.criteriaItem.ctritemid = ctritemid;
			$scope.entity.criteriaItem.actionmode = "S";
			httpService._httpPost(criteriaItemDetailURL, {"mode":"select"}, $scope.entity.criteriaItem).then(
				function(data){
					$scope.entity.criteriaItem = data.reCriteriaItem;
					/*$scope.$apply();*/
					//console.log("$scope.criteriaItem tstDtlcd:"+$scope.entity.wkTstDtl.tstDtlcd);
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}
		
		$scope.setClearDetail = function(){
			
			$scope.entity.criteriaItem.ctrverid = null;
			$scope.entity.criteriaItem.ctritemid = null;
			$scope.entity.criteriaItem.currentstate = null;
			$scope.entity.criteriaItem.guideline = null;
			$scope.entity.criteriaItem.article = null;
			$scope.entity.criteriaItem.ctrcnt = null;
			$scope.entity.criteriaItem.ctrccn = null;
			$scope.entity.criteriaItem.legal = null;
			$scope.entity.criteriaItem.protect = null;
			$scope.entity.criteriaItem.actionplan = null;
			$scope.entity.criteriaItem.rmk = null;
			$scope.entity.criteriaItem.sortby = null;
			$scope.entity.criteriaItem.actionmode = null;
			
			$scope.$apply();
		};
		
		
		$scope.actionPerformedVersion = function(tag){
			if($scope.form_version.$valid){
				if(tag == "insertVersion"){
					$scope.entity.criteriaVer.ctrverid   = "0";
					$scope.entity.criteriaVer.actionmode = "I";
				} else if(tag == "updateVersion") {
					$scope.entity.criteriaVer.actionmode = "U";
				} else if(tag == "deleteVersion"){
					if(confirm("선택한 정보를 삭제하시겠습니까?")){
						$scope.entity.criteriaVer.actionmode = "D";
					} else {
						return;
					}
				}
				httpService._httpPost(criteriaVersionDetailURL, {"mode":"modify"}, $scope.entity.criteriaVer).then(
					function(data){
						if(data.reVal == "ok_resend"){
							$scope.entity.selCriteriaVers = data.reCriteriaVersion;
							closeEditVersion();
						}
					},
					function(error){
						console.log("actionPerformed error: "+error);
					}
				);
			} else {
				alert("입력하지 않는 정보가 있습니다.");
			}	
		}
		
		
		$scope.actionShowVersion = function(ver){
			$("#btn_insert_version").hide();
			$("#btn_update_version").show();
			$("#btn_delete_version").show();
			$scope.entity.criteriaVer = ver;
		}
		
		
		
		
	});	
	
	criteriaItemApp.factory("httpService", function($http, $q){
		var factory = {
				_httpPost:function(url, params, data){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:url,
						data:data,
						params:params,
						headers: {'Content-Type': 'application/json'}
					}).then(
						function successCallback(response) {
							deferred.resolve(response.data);
						}, 
						function errorCallback(data) {
							console.log("failed to httpPost  ");
							deferred.reject("failed to select");
						}
					);
					return deferred.promise ;
				},
				_httpGet:function(url, params, data){
					var deferred  = $q.defer();
					$http({
						method:'GET',
						url:url,
						data:data,
						params:params,
						headers: {'Content-Type': 'application/json'}
					}).then(
						function successCallback(response) {
							deferred.resolve(response.data);
						}, 
						function errorCallback(data) {
							console.log("failed to httpGet ");
							deferred.reject("failed to select");
						}
					);
					return deferred.promise ;
				}
		}
		
		return factory;
	})
	
	
		/* angular directive */
	criteriaItemApp.directive("popupCriteriaitemDetail", function(){
		return {
			templateUrl : "criteriaItemDetail.do"
	    };
	});
	
	criteriaItemApp.directive("popupCriteriaVersion", function(){
		return {
			templateUrl : "criteriaVersion.do"
	    };
	});
	