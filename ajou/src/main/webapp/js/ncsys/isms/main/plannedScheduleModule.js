	/* Angular app */
	var plannedScheduleApp = angular.module("plannedScheduleApp", []);
	
	plannedScheduleApp.controller("plannedScheduleController", function($scope, $http, $q, httpService){
		
		$scope.entity = {
				plannedSchedule : {
					"planid":"",
					"plandt":"",
					"remain":"",
					"remaintype":"",
					"plantitle":"",
					"plancontent":"",
					"period":"",
					"completeyn":"",
					"actionmode":""
				}
		};
		
		
		
		$(function(){
			/*init select infor */
			console.log("plannedScheduleController Init Starting ... ");
			reloadGrid();
			
		});
		
		
		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			
			return deferred.promise ;
		}
		
		
		
		
		//plannedScheduleDetailURL
		$scope.actionSelectDetail = function(detailId){
			$scope.entity.plannedSchedule.planid = detailId;
			$scope.entity.plannedSchedule.actionmode = "S";
			httpService._httpPost(plannedScheduleDetailURL,{"mode":"select"}, $scope.entity.plannedSchedule).then(
				function(data){
					$scope.entity.plannedSchedule = data.reDetail;
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}
		
		
		
		/* action performed */
		
		/* action performed */
		$scope.actionPerformed = function(tag){
			if(tag == "insertDetail"){
				if($scope.form_detail.$valid){
					$scope.entity.plannedSchedule.planid = "0";
					$scope.entity.plannedSchedule.actionmode = "I";
					httpService._httpPost(plannedScheduleDetailURL,{"mode":"modify"}, $scope.entity.plannedSchedule).then(
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
					$scope.entity.plannedSchedule.actionmode = "U";
					httpService._httpPost(plannedScheduleDetailURL,{"mode":"modify"}, $scope.entity.plannedSchedule).then(
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
					$scope.entity.plannedSchedule.actionmode = "D";
					httpService._httpPost(plannedScheduleDetailURL,{"mode":"modify"}, $scope.entity.plannedSchedule).then(
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
		}
		
		
		$scope.setClearDetail = function(){
			
			$scope.entity.plannedSchedule.planid="";
			$scope.entity.plannedSchedule.plandt="";
			
			$scope.entity.plannedSchedule.remain="";
			$scope.entity.plannedSchedule.remaintype="";
			$scope.entity.plannedSchedule.plantitle="";
			$scope.entity.plannedSchedule.plancontent="";
			$scope.entity.plannedSchedule.period="";
			$scope.entity.plannedSchedule.completeyn="";
			$scope.entity.plannedSchedule.actionmode="";
			
			$scope.$apply();
		};
		
		
	});	
	
	plannedScheduleApp.factory("httpService", function($http, $q){
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
	plannedScheduleApp.directive("popupPlannedscheduleDetail", function(){
		return {
			templateUrl : "plannedScheduleDetail.do"
	    };
	});
	
	
	plannedScheduleApp.directive("datepicker", ['$parse', function($parse) {
		  return {
		    restrict: "A",
		    link: function (scope, element, attrs) {
		    	var parsed = $parse(attrs.datepicker);
		    	var options = {
			         dateFormat: "yy-mm-dd"
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
			        	console.log("onSelect dateText : "+dateText);
			        	scope.$apply(function(){
			        		scope.entity.plannedSchedule.plandt = dateText;
	                    });
			        }
		    	};
		    	element.datepicker(options);
		    }
		  }
	}]);
	