	/* Angular app */
	var app = angular.module("exlApp", []);
	
	app.controller("exlController",function($scope, $http, $q, exlService ){
		
		$scope.gridData ; 
		$scope.errData;
		
		$(function(){
			/*init select infor */
			$("#out").html("- 엑셀등록양식을 다운로드 받을 수 있습니다.");	
			$("#out").append("<br>- 체계정보를 이미 등록되어 있어야 합니다.");	
			
		});
		
		$scope.actionPerformed = function(){
			if($scope.gridData && $scope.gridData.length>0){
				exlService._httpPost(rgstrExlAstURL, {"mode":currentView}, $scope.gridData).then(
					function(data){
						jQuery("#jqgrid").jqGrid("clearGridData", true);
						$("#xlf").val("");
						
						if(data.errorCnt == 0){
							$("#out").html("총 "+data.totalCnt+"개의 상품목록이 등록 완료되었습니다!");	
						} else {
							$("#out").html("<font color='red'>총 "+data.totalCnt+"개의 상품 등록 중 "+data.errorCnt+"개의 오류정보가 발생되었습니다! 아래목록은 오류발생 정보입니다.</font>");
							$scope.errData = data.errorList;
							
							for(var i=0; i < $scope.errData.length; i++){
								$("#jqgrid").jqGrid('addRowData',i+1,$scope.errData[i]);
							}
							
						}
						
					},
					function(error){console.log("actionPerformed insert error: "+error);}
				
				);
				
			}
			console.log("actionPerformed : "+$scope.gridData);
		};
		
		$scope.setGridData = function(data) {
			
			$("#out").html("<font color='red'> - "+data.length+"개의 통제항목이 로딩되었습니다! "+"</font>");	
			$("#out").append("<br><font color='red'> - 아래 [일괄저장] 버튼을 클릭하시면 등록됩니다.</font>");	
			$scope.gridData = data;
		}
		
		
	});
	
	
	app.factory("exlService", function($http, $q ){
		
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
		
	});
	

		
		