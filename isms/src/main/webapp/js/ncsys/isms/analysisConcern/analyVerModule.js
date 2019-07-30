	/* Angular app */
	var analyVerApp = angular.module("analyVerApp", []);

	analyVerApp.controller("analyVerController", function($scope, $http, $q, httpService){

		$scope.entity = {
				 selVersions    : []
				,selAstVersions : []
				,selCtrVersions : []

				,analysis : {
						  "analysisid" : null
						 ,"analysisnm" : null
						 ,"versionid" : null
						 ,"assetverid" : null
						 ,"criteriaverid" : null
						 ,"sortby" : null
						 ,"actionmode" : null
				 }
		}



		$(function(){
			/*init select infor */
			console.log("analyVerController Init Starting ... ");
			$scope.selectInitInfo().then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});


		});


		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			httpService._httpPost(analysisVerInitURL, null, null).then(
					function(data){
						$scope.entity.selVersions    = data.versions;
						$scope.entity.selAstVersions = data.astVersions;
						$scope.entity.selCtrVersions = data.ctrVersions;

						if($scope.entity.selVersions[0]) {
							$scope.entity.analysis.versionid = $scope.entity.selVersions[0].verid;
						}
						if($scope.entity.selAstVersions[0]) {
							$scope.entity.analysis.assetverid = $scope.entity.selAstVersions[0].astverid;
						}
						if($scope.entity.selCtrVersions[0]) {
							$scope.entity.analysis.criteriaverid = $scope.entity.selCtrVersions[0].ctrverid;
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
				if(tag == "insertDetail"){
					$scope.entity.analysis.actionmode = "I";
				} else if(tag == "updateDetail"){
					$scope.entity.analysis.actionmode = "U";
				} else if(tag == "deleteDetail"){
					if(confirm("선택한 정보를 삭제하시겠습니까?")){
						$scope.entity.analysis.actionmode = "D";
					}
				}

				httpService._httpPost(analysisVerDetailURL, {"mode":"modify"}, $scope.entity.analysis).then(
					function(data){
						if(data.reVal == "ok_resend"){
							actionClose();
							setTimeout(function(){
								reloadGrid();
							},500);
						} else if(data.reVal == "failure_resend") {
							alert("항목코드가 이미 있거나 저장하는데 오류가 발생되었습니다.")
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

		$scope.actionSelectDetail = function(analysisid){
			$scope.entity.analysis.analysisid = analysisid;
			$scope.entity.analysis.actionmode = "S";

			httpService._httpPost(analysisVerDetailURL, {"mode":"select"}, $scope.entity.analysis).then(
				function(data){

					$scope.entity.analysis = data.reDetail;

					/*$scope.$apply();*/
					//console.log("$scope.analyVer tstitemcd:"+$scope.entity.wkTstItem.tstitemcd);
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}

		$scope.setClearDetail = function(){

			 $scope.entity.analysis.analysisid = "";
			 $scope.entity.analysis.analysisnm = "";
			 $scope.entity.analysis.sortby = "";
			 $scope.entity.analysis.actionmode = "";


			 if($scope.entity.selVersions[0]) {
				 $scope.entity.analysis.versionid = $scope.entity.selVersions[0].verid;
			 }
			 if($scope.entity.selAstVersions[0]) {
				 $scope.entity.analysis.assetverid = $scope.entity.selAstVersions[0].astverid;
			 }
			 if($scope.entity.selCtrVersions[0]) {
				 $scope.entity.analysis.criteriaverid = $scope.entity.selCtrVersions[0].ctrverid;
			 }

			 $scope.$apply();
		}




	});

	analyVerApp.factory("httpService", function($http, $q){
		var factory = {
				_httpPost:function(url, params, data){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:url,
						data:data,
						params:params,
						headers: {'Content-Type': 'application/json','X-CSRF-TOKEN': token}
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
						headers: {'Content-Type': 'application/json','X-CSRF-TOKEN': token}
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
	analyVerApp.directive("popupAnalyverDetail", function(){
		return {
			templateUrl : "analyVerDetail.do"
	    };
	});
