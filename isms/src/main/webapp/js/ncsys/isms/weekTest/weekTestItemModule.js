	/* Angular app */
	var weekTestItemApp = angular.module("weekTestItemApp", []);

	weekTestItemApp.controller("weekTestItemController", function($scope, $http, $q, httpService){

		$scope.entity = {
				 selAstGroups : []
				,selAstGroupId : null
				,selWkTstFields : []

				,wkTstItem : {
						  "astgrpid" : null
						 ,"wktstfieldid" : null
						 ,"wktstfieldnm" : null
						 ,"tstitemcd" : null
						 ,"tstitemnm" : null
						 ,"importance" : null
						 ,"tstscr" : null
						 ,"useyn" : null
						 ,"sortby" : null
						 ,"actionmode" : null
						 ,"oldAstgrpid" : null
						 ,"oldTstitemcd" : null
				 }
		}



		$(function(){
			/*init select infor */
			console.log("weekTestItemController Init Starting ... ");
			$scope.selectInitInfo().then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});


		});


		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			httpService._httpPost(weekTestItemInitURL, null, null).then(
					function(data){
						$scope.entity.selAstGroups = data.reAssetGroupList;
						$scope.entity.selWkTstFields = data.reWeekTestField;

						if($scope.entity.selAstGroups[0]) {
							$scope.entity.wkTstItem.astgrpid = $scope.entity.selAstGroups[0].astgrpid;
							$scope.entity.selAstGroupId = $scope.entity.selAstGroups[0].astgrpid;
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
					$scope.entity.wkTstItem.actionmode = "I";
				} else if(tag == "updateDetail"){
					$scope.entity.wkTstItem.actionmode = "U";
				} else if(tag == "deleteDetail"){
					if(confirm("선택한 정보를 삭제하시겠습니까?")){
						$scope.entity.wkTstItem.actionmode = "D";
					}
				}

				httpService._httpPost(weekTestItemDetailURL, {"mode":"modify"}, $scope.entity.wkTstItem).then(
					function(data){
						if(data.reVal == "ok_resend"){
							actionClose();
							$scope.entity.selAstGroupId = $scope.entity.wkTstItem.astgrpid;
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

		$scope.actionSelectDetail = function(tstitemcd){
			$scope.entity.wkTstItem.astgrpid = $scope.entity.selAstGroupId;
			$scope.entity.wkTstItem.tstitemcd = tstitemcd;
			$scope.entity.wkTstItem.actionmode = "S";
			httpService._httpPost(weekTestItemDetailURL, {"mode":"select"}, $scope.entity.wkTstItem).then(
				function(data){
					//$scope.entity.wkTstItem.astgrpid = data.reDetail.astgrpid;
					/* set field */
					$scope.entity.wkTstItem = data.reDetail;

					/* update delete key */
					$scope.entity.wkTstItem.oldAstgrpid = $scope.entity.wkTstItem.astgrpid;
					$scope.entity.wkTstItem.oldTstitemcd = $scope.entity.wkTstItem.tstitemcd;

					/*$scope.$apply();*/
					console.log("$scope.weekTestItem tstitemcd:"+$scope.entity.wkTstItem.tstitemcd);
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}

		$scope.setClearDetail = function(){

			 $scope.entity.wkTstItem.astgrpid = $scope.entity.selAstGroupId;
			 $scope.entity.wkTstItem.wktstfieldid="";
			 $scope.entity.wkTstItem.wktstfieldnm="";
			 $scope.entity.wkTstItem.tstitemcd="";
			 $scope.entity.wkTstItem.tstitemnm="";
			 $scope.entity.wkTstItem.importance="";
			 $scope.entity.wkTstItem.tstscr="";
			 $scope.entity.wkTstItem.useyn="";
			 $scope.entity.wkTstItem.sortby="";
			 $scope.entity.wkTstItem.actionmode="";

			 $scope.$apply();
		}



		$scope.actionPerformedField = function(tag){
			if($scope.form_field.$valid){
				if(tag == "insertField"){
					$scope.entity.wkTstField.wktstfieldid = "0";
					$scope.entity.wkTstField.actionmode = "I";
				} else if(tag == "updateField") {
					$scope.entity.wkTstField.actionmode = "U";
				} else if(tag == "deleteField"){
					if(confirm("선택한 정보를 삭제하시겠습니까?")){
						$scope.entity.wkTstField.actionmode = "D";
					}
				}
				httpService._httpPost(weekTestFieldDetailURL, {"mode":"modify"}, $scope.entity.wkTstField).then(
					function(data){
						if(data.reVal == "ok_resend"){
							$scope.entity.wkTstFields = data.reWeekTestField;
							$scope.changeGroup();
							closeBranch();
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


		$scope.actionShowFieldDetail = function(field){

			$("#btn_insert_field").hide();
			$("#btn_update_field").show();
			$("#btn_delete_field").show();

			$scope.entity.wkTstField = field;
		}

		/*$scope.changeGroup = function(){
			$scope.entity.selWkTstFields = [];
			for(var i=0; i<$scope.entity.wkTstFields.length; i++){
				var field = $scope.entity.wkTstFields[i];
				if($scope.entity.wkTstItem.astgrpid == field.astgrpid){
					$scope.entity.selWkTstFields.push(field);
				}
			}
			if($scope.entity.selWkTstFields[0]) $scope.entity.wkTstItem.wktstfieldid = $scope.entity.selWkTstFields[0].wktstfieldid;
		}*/



	});

	weekTestItemApp.factory("httpService", function($http, $q){
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
	weekTestItemApp.directive("popupWeektestitemDetail", function(){
		return {
			templateUrl : "weekTstItemDetail.do"
	    };
	});


