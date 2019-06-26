	/* Angular app */
	var concernDtlApp = angular.module("concernDtlApp", []);
	
	concernDtlApp.controller("concernDtlController", function($scope, $http, $q, httpService){
		
		$scope.entity = {
				 selAstVers     : []
				,selAstVerId    : null
				,selAstGroups   : []
				,selAstGroupId  : null
				
				,concernDtls : []
		}
		
		
		
		$(function(){
			/*init select infor */
			console.log("concernDtlController Init Starting ... ");
			$scope.selectInitInfo().then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});
			
			
		});
		
		
		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			httpService._httpPost(concernDtlInitURL, null, null).then(
					function(data){
						$scope.entity.selAstVers = data.reAssetVersionList;
						$scope.entity.selAstGroups = data.reAssetGroupList;
						
						if($scope.entity.selAstGroups[0]) {
							$scope.entity.selAstGroupId = $scope.entity.selAstGroups[0].astgrpid;
						}
						if($scope.entity.selAstVers[0]) {
							$scope.entity.selAstVerId = $scope.entity.selAstVers[0].astverid;
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
				
			httpService._httpPost(concernDtlDetailURL, pm, $scope.entity.concernDtls).then(
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
		}
		
		
		
		
		
		
	});	
	
	concernDtlApp.factory("httpService", function($http, $q){
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
	
	
	
	