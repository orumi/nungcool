	/* Angular app */
	var weekTestDtlApp = angular.module("weekTestDtlApp", []);
	
	weekTestDtlApp.controller("weekTestDtlController", function($scope, $http, $q, httpService){
		
		$scope.entity = {
				 selAstVers     : []
				,selAstVerId    : null
				,selAstGroups   : []
				,selAstGroupId  : null
				
				,wkTstDtls : []
		}
		
		
		
		$(function(){
			/*init select infor */
			console.log("weekTestDtlController Init Starting ... ");
			$scope.selectInitInfo().then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});
			
			
		});
		
		
		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			httpService._httpPost(weekTestDtlInitURL, null, null).then(
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
				
			httpService._httpPost(weekTestDtlDetailURL, pm, $scope.entity.wkTstDtls).then(
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
			httpService._httpPost(weekTestDtlDetailURL, {"mode":"select"}, $scope.entity.wkTstDtl).then(
				function(data){
					//$scope.entity.wkTstDtl.astgrpid = data.reDetail.astgrpid;
					/* set field */
					$scope.entity.wkTstDtl = data.reDetail;
					
					/* update delete key */
					$scope.entity.wkTstDtl.oldAstgrpid = $scope.entity.wkTstDtl.astgrpid;
					$scope.entity.wkTstDtl.oldTstDtlcd = $scope.entity.wkTstDtl.tstDtlcd;
					
					/*$scope.$apply();*/
					console.log("$scope.weekTestDtl tstDtlcd:"+$scope.entity.wkTstDtl.tstDtlcd);
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}
		
		$scope.setClearDetail = function(){
			
			 $scope.entity.wkTstDtl.astgrpid = $scope.entity.selAstGroupId;
			 $scope.entity.wkTstDtl.wktstfieldid="";
			 $scope.entity.wkTstDtl.wktstfieldnm="";
			 $scope.entity.wkTstDtl.tstDtlcd="";
			 $scope.entity.wkTstDtl.tstDtlnm="";
			 $scope.entity.wkTstDtl.importance="";
			 $scope.entity.wkTstDtl.tstscr="";
			 $scope.entity.wkTstDtl.useyn="";
			 $scope.entity.wkTstDtl.sortby="";
			 $scope.entity.wkTstDtl.actionmode="";
			 
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
				if($scope.entity.wkTstDtl.astgrpid == field.astgrpid){
					$scope.entity.selWkTstFields.push(field); 
				}
			}
			if($scope.entity.selWkTstFields[0]) $scope.entity.wkTstDtl.wktstfieldid = $scope.entity.selWkTstFields[0].wktstfieldid;
		}*/
		
		
		
	});	
	
	weekTestDtlApp.factory("httpService", function($http, $q){
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
	
	
	
	