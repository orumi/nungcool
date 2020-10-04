	/* Angular app */
	var concernItemApp = angular.module("concernItemApp", []);
	
	concernItemApp.controller("concernItemController", function($scope, $http, $q, httpService){
		
		$scope.entity = {
				 selAstGroups : []
				,selAstGroupId : null
				
				,concernItem : {
						  "astgrpid" : null
						 ,"ccnitemcd" : null
						 ,"ccnitemnm" : null
						 ,"ccnvalue" : null
						 ,"actionplan" : null
						 ,"actionperiod": null
						 ,"useyn" : null
						 ,"sortby" : null
						 ,"actionmode" : null
						 ,"oldAstgrpid" : null
						 ,"oldCcnitemcd" : null
						 
				 } 
		}
		
		
		
		$(function(){
			/*init select infor */
			console.log("concernItemController Init Starting ... ");
			$scope.selectInitInfo().then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});
			
			
		});
		
		
		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			httpService._httpPost(concernItemInitURL, null, null).then(
					function(data){
						$scope.entity.selAstGroups = data.reAssetGroupList;
						
						if($scope.entity.selAstGroups[0]) {
							$scope.entity.concernItem.astgrpid = $scope.entity.selAstGroups[0].astgrpid;
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
					$scope.entity.concernItem.actionmode = "I";
				} else if(tag == "updateDetail"){
					$scope.entity.concernItem.actionmode = "U";
				} else if(tag == "deleteDetail"){
					if(confirm("선택한 정보를 삭제하시겠습니까?")){
						$scope.entity.concernItem.actionmode = "D";
					}
				}
				
				httpService._httpPost(concernItemDetailURL, {"mode":"modify"}, $scope.entity.concernItem).then(
					function(data){
						if(data.reVal == "ok_resend"){
							actionClose();
							$scope.entity.selAstGroupId = $scope.entity.concernItem.astgrpid;
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
		
		$scope.actionSelectDetail = function(ccnitemcd){
			$scope.entity.concernItem.astgrpid = $scope.entity.selAstGroupId;
			$scope.entity.concernItem.ccnitemcd = ccnitemcd;
			$scope.entity.concernItem.actionmode = "S";
			httpService._httpPost(concernItemDetailURL, {"mode":"select"}, $scope.entity.concernItem).then(
				function(data){
					/* set field */
					$scope.entity.concernItem = data.reDetail;
					
					/* update delete key */
					$scope.entity.concernItem.oldAstgrpid = $scope.entity.concernItem.astgrpid;
					$scope.entity.concernItem.oldCcnitemcd = $scope.entity.concernItem.ccnitemcd;
					
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}
		
		$scope.setClearDetail = function(){
			
			 $scope.entity.concernItem.astgrpid = $scope.entity.selAstGroupId;
			 
			 $scope.entity.concernItem.ccnitemcd="";
			 $scope.entity.concernItem.ccnitemnm="";
			 $scope.entity.concernItem.ccnvalue="";
			 $scope.entity.concernItem.actionplan="";
			 $scope.entity.concernItem.actionperiod="";
			 $scope.entity.concernItem.useyn="";
			 $scope.entity.concernItem.sortby="";
			 $scope.entity.concernItem.actionmode="";
			 
			 $scope.$apply();
		}
		
		
		$scope.actionShowFieldDetail = function(field){
			
			$("#btn_insert_field").hide();
			$("#btn_update_field").show();
			$("#btn_delete_field").show();
			
			$scope.entity.wkTstField = field;
		}
		
		
	});	
	
	concernItemApp.factory("httpService", function($http, $q){
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
	concernItemApp.directive("popupConcernitemDetail", function(){
		return {
			templateUrl : "concernItemDetail.do"
	    };
	});

	
	