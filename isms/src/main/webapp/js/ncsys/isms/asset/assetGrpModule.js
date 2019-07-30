	/* Angular app */
	var assetGrpApp = angular.module("assetGrpApp", []);

	assetGrpApp.controller("assetGrpController", function($scope, $http, $q, assetGrpService){

		$scope.entity = {
				 selAstVerId : null
				,selAstVers : []

				,selAstGrps : []
				,assetGrp : {
					"astgrpid":"",
					"astgrpkind":"",
					"astgrpkindnm":"",
					"astgrpnm":"",
					"astgrpdfn":"",
					"useyn":"",
					"delyn":"",
					"sortby":"",
					"actionmode":""
				}
				,selAstKinds : []
				,selAstKindId : null
		};

		$(function(){
			/*init select infor */
			console.log("assetGrpController Init Starting ... ");
			$scope.selectInitInfo().then(
					function (rslv){
						setTimeout(function(){
							reload();
						},1000);
					},function(error){});


		});

		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			assetGrpService._selectInitInfo().then(
					function(data){
						$scope.entity.selAstVers = data.assetVersionList;
						if($scope.entity.selAstVers[0]) {$scope.entity.selAstVerId = $scope.entity.selAstVers[0].astverid; }

						$scope.entity.selAstKinds = data.assetKind;
						if($scope.entity.selAstKinds[0]) {$scope.entity.selAstKindId = $scope.entity.selAstKinds[0].astgrpkind; }

						deferred.resolve(true);
					},
					function(error){
						console.log("actionPerformed insert error: "+error);
						deferred.reject("failed to selectInitInfo");
					}
				);

			return deferred.promise ;
		};

		/* action performed */
		$scope.actionPerformed = function(tag){
			if(tag == "insertDetail"){
				if($scope.form_detail.$valid){

					$scope.entity.assetGrp.astgrpid = "0";
					$scope.entity.assetGrp.astgrpkind = $scope.entity.selAstKindId;
					$scope.entity.assetGrp.actionmode = "I";
					assetGrpService._storeDetail($scope.entity.assetGrp).then(
							function(data){
								if(data.reVal == "ok_resend"){
									actionClose();
									reloadGridGrp();
								}
							},
							function(error){
								console.log("actionPerformed error: "+error);
							}
						);
				} else {
					alert("입력하지 않는 정보가 있습니다.");
				}
			} else if(tag == "updateDetail"){
				if($scope.form_detail.$valid){
					$scope.entity.assetGrp.actionmode = "U";
					$scope.entity.assetGrp.astgrpkind = $scope.entity.selAstKindId;
					assetGrpService._storeDetail($scope.entity.assetGrp).then(
							function(data){
								if(data.reVal == "ok_resend"){
									actionClose();
									reloadGridGrp();
								}
							},
							function(error){
								console.log("actionPerformed error: "+error);
							}
						);
				} else {
					alert("입력하지 않는 정보가 있습니다.");
				}
			} else if(tag == "deleteDetail"){
				if(confirm("선택한 정보를 삭제하시겠습니까?")){
					$scope.entity.assetGrp.actionmode = "D";
					$scope.entity.assetGrp.astgrpkind = $scope.entity.selAstKindId;
					assetGrpService._storeDetail($scope.entity.assetGrp).then(
							function(data){
								if(data.reVal == "ok_resend"){
									actionClose();
									reloadGridGrp();
								}
							},
							function(error){
								console.log("actionPerformed error: "+error);
							}
						);
				}
			}
		};


		$scope.actionSelectDetail = function(detailId){
			$scope.entity.assetGrp.astgrpid = detailId;
			$scope.entity.assetGrp.actionmode = "S";
			assetGrpService._selectDetail($scope.entity.assetGrp).then(
				function(data){
					$scope.entity.assetGrp = data.reDetail;
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}


		$scope.setClearDetail = function(){

			$scope.entity.assetGrp.astgrpid="";
			$scope.entity.assetGrp.astgrpkind="";
			$scope.entity.assetGrp.astgrpkindnm="";
			$scope.entity.assetGrp.astgrpnm="";
			$scope.entity.assetGrp.astgrpdfn="";
			$scope.entity.assetGrp.useyn="Y";
			$scope.entity.assetGrp.delyn="N";
			$scope.entity.assetGrp.sortby="";
			$scope.entity.assetGrp.actionmode="";

			$scope.$apply();
		};



	});

	assetGrpApp.factory("assetGrpService", function($http, $q){

		var factory = {
				_selectInitInfo:function(pm){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:assetGrpInitURL,
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
				_selectDetail:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:assetGrpDetailURL,
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
				},
				_storeDetail:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:assetGrpDetailURL,
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
				}

		}

		return factory;

	});


	/* angular directive */
	assetGrpApp.directive("popupAssetgrpDetail", function(){
		return {
			templateUrl : "assetGroupDetail.do"
	    };
	});

