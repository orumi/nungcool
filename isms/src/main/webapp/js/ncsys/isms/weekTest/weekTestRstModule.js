	/* Angular app */
	var weekTestRstApp = angular.module("weekTestRstApp", []);

	weekTestRstApp.controller("weekTestRstController", function($scope, $http, $q, httpService){

		$scope.entity = {
				 selAstVerid : null
				,selAstVers : []

				,wktstFieldRst : []
				,wktstFields : []
				,wktstFieldTotal : null

		}



		$(function(){
			/*init select infor */
			console.log("weekTestRstController Init Starting ... ");
			$scope.selectInitInfo().then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});


		});


		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			httpService._httpPost(weekTstRstInitURL, null, null).then(
					function(data){
						$scope.entity.selAstVers = data.assetVersionList;

						if($scope.entity.selAstVers[0]) {
							$scope.entity.selAstVerid = $scope.entity.selAstVers[0].astverid;
						}

						console.log("weekTestRstController selectInitInfo started ");

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
					$scope.entity.wkTstRst.actionmode = "I";
				} else if(tag == "updateDetail"){
					$scope.entity.wkTstRst.actionmode = "U";
				} else if(tag == "deleteDetail"){
					if(confirm("선택한 정보를 삭제하시겠습니까?")){
						$scope.entity.wkTstRst.actionmode = "D";
					}
				}

				httpService._httpPost(weekTestRstDetailURL, {"mode":"modify"}, $scope.entity.wkTstRst).then(
					function(data){
						if(data.reVal == "ok_resend"){
							actionClose();
							$scope.entity.selAstGroupId = $scope.entity.wkTstRst.astgrpid;
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

		$scope.selectWktstFieldRst = function(astverid){
			console.log("asterid : "+ astverid);

			httpService._httpPost(weekTstFieldRstURL, {"astverid":astverid}, null ).then(
				function(data){
					$scope.entity.wktstFieldRst = data.reWeekTestFieldRstList;
					$scope.entity.wktstFields = data.reWeekTestField;
					$scope.entity.wktstFieldTotal = data.totalWeekTestFieldRst;


					setTimeout(function(){
						reLoadGridField();
					},500);
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}


	});

	weekTestRstApp.factory("httpService", function($http, $q){
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


