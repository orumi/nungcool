	/* Angular app */
	var regulationTstApp = angular.module("regulationTstApp", []);
	
	regulationTstApp.controller("regulationTstController", function($scope, $http, $q, httpService){
		
		$scope.entity = {
				 selVers     : []
				,selVerId    : null
				,selFields   : []
				,selFieldId  : null
				
				,regulationTsts : []
		}
		
		
		
		$(function(){
			/*init select infor */
			console.log("regulationTstController Init Starting ... ");
			$scope.selectInitInfo().then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});
			
			
		});
		
		
		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			httpService._httpPost(regulationTstInitURL, null, null).then(
					function(data){
						$scope.entity.selVers = data.listVersion;
						$scope.entity.selFields = data.listField;
						
						if($scope.entity.selVers[0]) {
							$scope.entity.selVerId = $scope.entity.selVers[0].verid;
						}
						if($scope.entity.selFields[0]) {
							$scope.entity.selFieldId = $scope.entity.selFields[0].fldid;
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
		
		$scope.actionPerformed = function(pm){
				
			httpService._httpPost(regulationTstDetailURL, pm, $scope.entity.regulationTsts).then(
				function(data){
					if(data.reVal == "ok_resend"){
						setTimeout(function(){
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
1		}
		
		$scope.actionSelectDetail = function(tstDtlcd){
			$scope.entity.wkTstDtl.astgrpid = $scope.entity.selAstGroupId;
			$scope.entity.wkTstDtl.tstDtlcd = tstDtlcd;
			$scope.entity.wkTstDtl.actionmode = "S";
			httpService._httpPost(regulationTstDetailURL, {"mode":"select"}, $scope.entity.wkTstDtl).then(
				function(data){
					//$scope.entity.wkTstDtl.astgrpid = data.reDetail.astgrpid;
					/* set field */
					$scope.entity.wkTstDtl = data.reDetail;
					
					/* update delete key */
					$scope.entity.wkTstDtl.oldAstgrpid = $scope.entity.wkTstDtl.astgrpid;
					$scope.entity.wkTstDtl.oldTstDtlcd = $scope.entity.wkTstDtl.tstDtlcd;
					
					/*$scope.$apply();*/
					console.log("$scope.regulationTst tstDtlcd:"+$scope.entity.wkTstDtl.tstDtlcd);
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}
		
		
		
		
	});	
	
	regulationTstApp.factory("httpService", function($http, $q){
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
	
	
	
	