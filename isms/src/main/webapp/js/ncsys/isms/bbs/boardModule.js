	/* Angular app */
	var boardApp = angular.module("boardApp", []);

	boardApp.controller("boardController", function($scope, $http, $q, httpService){

		$scope.entity = {
				board : {
					"bbsId":"",
					"bbsAttrbCode":"",
					"bbsNm":"",
					"nttId":"",
					"nttSj":"",
					"nttCn":"",
					"ntcrId":"",
					"ntcrNm":"",
					"password":"",
					"inqireCo":"",


					"ntceBgnde":"",
					"ntceEndde":"",
					"replyAt":"N",
					"parnts":"0",
					"replyLc":"0",
					"atchFileId":"",

					"actionmode":""
				}
		};



		$(function(){
			/*init select infor */
			console.log("boardScheduleController Init Starting ... ");
			reloadGrid();

		});


		$scope.selectInitInfo = function(){
			var deferred = $q.defer();

			return deferred.promise ;
		}




		//plannedScheduleDetailURL
		$scope.actionSelectDetail = function(detailId){
			$scope.entity.board.nttId = detailId;
			$scope.entity.board.bbsId  = $("#bbsId").val();
			$scope.entity.board.bbsAttrbCode  = $("#bbsAttrbCode").val();

			$scope.entity.board.actionmode = "S";
			httpService._httpPost(boardDetailURL,{"mode":"select"}, $scope.entity.board).then(
				function(data){
					$scope.entity.board = data.reDetail;

					/* editor textarea adjust */
					$("#txtDetail").val($scope.entity.board.nttCn);

					if(oEditors.length > 0){
						/* 최초에는 textarea에 정보가 옮겨진 후에 에디터에 반영됨. */
						oEditors.getById["txtDetail"].exec("LOAD_CONTENTS_FIELD");
					}


				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}



		/* action performed */

		/* action performed */
		$scope.actionPerformed = function(tag){

			$scope.entity.board.bbsId  = $("#bbsId").val();
			$scope.entity.board.bbsAttrbCode  = $("#bbsAttrbCode").val();
			if(oEditors.length > 0){
				oEditors.getById["txtDetail"].exec("UPDATE_CONTENTS_FIELD", []);
				$scope.entity.board.nttCn = $("#txtDetail").val();
			}



			if(tag == "insertDetail"){
				if($scope.form_detail.$valid){
					$scope.entity.board.nttId = "0";
					$scope.entity.board.actionmode = "I";

					httpService._httpPost(boardDetailURL,{"mode":"modify"}, $scope.entity.board).then(
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
					$scope.entity.board.actionmode = "U";
					httpService._httpPost(boardDetailURL,{"mode":"modify"}, $scope.entity.board).then(
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
					$scope.entity.board.actionmode = "D";
					httpService._httpPost(boardDetailURL,{"mode":"modify"}, $scope.entity.board).then(
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

			$scope.entity.board.nttId="";
			$scope.entity.board.nttSj="";

			$scope.entity.board.nttCn="";
			$scope.entity.board.ntcrId="";
			$scope.entity.board.ntcrNm="";
			$scope.entity.board.password="";
			$scope.entity.board.ntceBgnde="";
			$scope.entity.board.ntceEndde="";

			$scope.entity.board.replyAt="N",
			$scope.entity.board.parnts="0",
			$scope.entity.board.replyLc ="0",

			$scope.entity.board.actionmode="";

			$("#txtDetail").val($scope.entity.board.nttCn);
			if(oEditors.length>0){
				oEditors.getById["txtDetail"].exec("LOAD_CONTENTS_FIELD");
			}

			$scope.$apply();
		};


	});

	boardApp.factory("httpService", function($http, $q){
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
	boardApp.directive("popupBoardDetail", function(){
		var bbsId = $("#bbsId").val();
		var bbsAttrbCode = $("#bbsAttrbCode").val();
		return {
			templateUrl : "boardDetail.do?"+"bbsId="+bbsId+"&bbsAttrbCode="+bbsAttrbCode
	    };
	});


	boardApp.directive("datepicker", ['$parse', function($parse) {
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
			        	//console.log("onSelect dateText element : "+element.attr("id") );
			        	//console.log("onSelect dateText attrs : "+attrs);
			        	scope.$apply(function(){
			        		if(element.attr("id")=="ntceBgnde"){
			        			scope.entity.board.ntceBgnde = dateText;
			        		} else if (element.attr("id")=="ntceEndde"){
			        			scope.entity.board.ntceEndde = dateText;
			        		}

	                    });
			        }
		    	};
		    	element.datepicker(options);
		    }
		  }
	}]);
