	/* Angular app */
	var assetMngApp = angular.module("assetMngApp", []);
	
	assetMngApp.controller("assetMngController", function($scope, $http, $q, assetMngService){

		$scope.entity = {
				selAstVerId : null,
				selAstVers : [],
				selAstVer : null,
				selAstGrpId : null,
				selAstGrps : [],
				asset : {
					"astverid":"",
					"astvernm":"",
					"astgrpid":"",
					"astgrpnm":"",
					"assetid":"",
					"mgnno":"",
					"cate01":"",
					"cate02":"",
					"assetnm":"",
					"assetdfn":"",
					"imptc":"",
					"impti":"",
					"impta":"",
					"wktstyn":"",
					"certiyn":"",
					"ipinfo":"",
					"ea":"",
					"position":"",
					"modelnm":"",
					"astno":"",
					"ownerid":"",
					"mgnid":"",
					"operyn":"",
					"introdept":"",
					"introcmpny":"",
					"introdt":"",
					"ascmpny":"",
					"sortby":"",
					"actionmode":""
				}
		};
		
		$(function(){
			/*init select infor */
			console.log("assetMngController Init Starting ... ");
			$scope.selectInitInfo().then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});
			
			
		});
		
		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			assetMngService._selectInitInfo().then(
					function(data){
						$scope.entity.selAstVers = data.assetVersionList;
						if($scope.entity.selAstVers[0]) {$scope.entity.selAstVerId = $scope.entity.selAstVers[0].astverid; }
						
						$scope.entity.selAstGrps = data.reAssetGroupList;
						$scope.entity.selAstGrpId = "0"; 
						if($scope.entity.selAstGrps[0]) {$scope.entity.asset.astgrpid = $scope.entity.selAstGrps[0].astgrpid; }
						
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
				
					$scope.entity.asset.assetid = "0";
					$scope.entity.asset.astverid = $scope.entity.selAstVerId;
					$scope.entity.asset.actionmode = "I";
					assetMngService._storeDetail($scope.entity.asset).then(
							function(data){
								if(data.reVal == "ok_resend"){
									actionClose();
									reloadGrid();
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
					$scope.entity.asset.astverid = $scope.entity.selAstVerId;
					$scope.entity.asset.actionmode = "U";
					assetMngService._storeDetail($scope.entity.asset).then(
							function(data){
								if(data.reVal == "ok_resend"){
									actionClose();
									reloadGrid();
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
					$scope.entity.asset.astverid = $scope.entity.selAstVerId;
					$scope.entity.asset.actionmode = "D";
					assetMngService._storeDetail($scope.entity.asset).then(
							function(data){
								if(data.reVal == "ok_resend"){
									actionClose();
									reloadGrid();
								}
							},
							function(error){
								console.log("actionPerformed error: "+error);
							}
						);
				}
			}
		};

		$scope.actionPerformedVersion = function(tag){
			if(tag == "insertVersion"){
				$scope.entity.selAstVer.astverid = "0";
				$scope.entity.selAstVer.actionmode = "I";
				assetMngService._storeVersion($scope.entity.selAstVer).then(
						function(data){
							if(data.reVal == "ok_resend"){
								$scope.entity.selAstVers = data.assetVersionList;
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "updateVersion") {
				$scope.entity.selAstVer.actionmode = "U";
				assetMngService._storeVersion($scope.entity.selAstVer).then(
						function(data){
							if(data.reVal == "ok_resend"){
								$scope.entity.selAstVers = data.assetVersionList;
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "deleteVersion"){
				if(confirm("선택한 정보를 삭제하시겠습니까?")){
					$scope.entity.selAstVer.actionmode = "D";
					assetMngService._storeVersion($scope.entity.selAstVer).then(
							function(data){
								if(data.reVal == "ok_resend"){
									$scope.entity.selAstVers = data.assetVersionList;
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
			$scope.entity.asset.assetid = detailId;
			$scope.entity.asset.actionmode = "S";
			assetMngService._selectDetail($scope.entity.asset).then(
				function(data){
					$scope.entity.asset = data.reAssetDetail;
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}
		
		
		$scope.setClearDetail = function(){
			
			$scope.entity.asset.astverid="";
			$scope.entity.asset.astvernm="";
			
			if($scope.entity.selAstGrps[0]){ 
				$scope.entity.asset.astgrpid = $scope.entity.selAstGrps[0].astgrpid; 
			} else {$scope.entity.asset.astgrpid="";}
			
			$scope.entity.asset.astgrpnm="";
			$scope.entity.asset.assetid="";
			$scope.entity.asset.mgnno="";
			$scope.entity.asset.cate01="";
			$scope.entity.asset.cate02="";
			$scope.entity.asset.assetnm="";
			$scope.entity.asset.assetdfn="";
			$scope.entity.asset.imptc="";
			$scope.entity.asset.impti="";
			$scope.entity.asset.impta="";
			$scope.entity.asset.wktstyn="Y";
			$scope.entity.asset.certiyn="Y";
			$scope.entity.asset.ipinfo="";
			$scope.entity.asset.ea="";
			$scope.entity.asset.position="";
			$scope.entity.asset.modelnm="";
			$scope.entity.asset.astno="";
			$scope.entity.asset.ownerid="";
			$scope.entity.asset.mgnid="";
			$scope.entity.asset.operyn="Y";
			$scope.entity.asset.introdept="";
			$scope.entity.asset.introcmpny="";
			$scope.entity.asset.introdt="";
			$scope.entity.asset.ascmpny="";
			$scope.entity.asset.sortby="";
			$scope.entity.asset.actionmode="";
			
			$scope.$apply();
		};
		
		
		$scope.actionShowVersion = function(ver){
			$("#btn_insert_version").hide();
			$("#btn_update_version").show();
			$("#btn_delete_version").show();
			$scope.entity.selAstVer = ver;
		};
		
		
	});	
	
	assetMngApp.factory("assetMngService", function($http, $q){
		
		var factory = {
				_selectInitInfo:function(pm){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:assetInitURL,
						data:pm,
						headers: {'Content-Type': 'application/json'}
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
						url:assetDetailURL,
						params:{"mode":"select"},
						data:detail,
						headers: {'Content-Type': 'application/json'}
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
						url:assetDetailURL,
						params:{"mode":"modify"},
						data:detail,
						headers: {'Content-Type': 'application/json'}
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
				_storeVersion:function(version){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:assetVersionURL,
						params:{"mode":"modify"},
						data:version,
						headers: {'Content-Type': 'application/json'}
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
	assetMngApp.directive("popupAssetDetail", function(){
		return {
			templateUrl : "assetDetail.do"
	    };
	});

	/* angular directive */
	assetMngApp.directive("popupAssetVersion", function(){
		return {
			templateUrl : "assetVersion.do"
	    };
	});
	
	assetMngApp.directive("datepicker", ['$parse', function($parse) {
		  return {
		    restrict: "A",
		    link: function (scope, element, attrs) {
		    	var parsed = $parse(attrs.datepicker);
		    	var options = {
			         dateFormat: "yy/mm/dd"
			        ,prevText : '<i class="fa fa-chevron-left"></i>'
					,nextText : '<i class="fa fa-chevron-right"></i>'
					,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	                ,changeYear: true        //콤보박스에서 년 선택 가능
	                ,changeMonth: true //콤보박스에서 월 선택 가능                
	                ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	                ,yearSuffix: "년"  //달력의 년도 부분 뒤에 붙는 텍스트
	                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
			        ,onSelect: function (dateText) {
			        	scope.$apply(function(){
			        		scope.entity.asset.introdt = dateText;
			        		//parsed.assign(scope, dateText);
	                    });
			        }
		    	};
		    	element.datepicker(options);
		    }
		  }
	}]);
	
	