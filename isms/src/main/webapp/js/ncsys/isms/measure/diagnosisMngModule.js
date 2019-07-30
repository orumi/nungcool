	/* Angular app */
	var diagnosisMngApp = angular.module("diagnosisMngApp", []);

	diagnosisMngApp.controller("diagnosisMngController", function($scope, $http, $q, diagnosisMngService){

		$scope.years = [] ;


		$scope.selDiagnosis ; //
		$scope.dgsid ; // select option model
		$scope.diagnosis = [];

		$scope.versions = [];

		$scope.diagnosisDetail = {
			"dgsid":"",
			"piversionid":"",
			"year":"",
			"begindt":"",
			"enddt":"",
			"dgsname":"",
			"sortby":"",
			"actionmode":""
		};
		$scope.diagnosisWeight = {
				"dgsid":"",
				"year":"",
				"actionmode":"",
				"wgts":""
			}



		$(function(){
			/*init select infor */
			console.log("diagnosisMngController Init Starting ... ");

			$scope.selectInit().then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});

			/* 초기 설정 */
			$scope.init();


		});


		$scope.init = function(){
			var date = new Date();
			var fYear = date.getFullYear();

			for(var y=15; y>0; y--){
				$scope.years[$scope.years.length] = (fYear-y+5);
			}
		}

		$scope.selectInit = function(){
			var deferred = $q.defer();
			diagnosisMngService._selectInit().then(
					function(data){
						$scope.diagnosis = data.listDiagnosis;
						$scope.versions = data.listVersion;

						if($scope.diagnosis[0]) {$scope.dgsid = $scope.diagnosis[0].dgsid; }
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
		$scope.actionSaveWgt = function(){
			var i = 0;
			var tmpWgts = [];
			var totWgt = 0;
			$("#jqgrid > tbody  > tr").each(function() {
				if(i > 0){
					var txt = $(this).find("td").eq(4).find("input[name=txtWgt]");
					tmpWgts[tmpWgts.length] = { "dgsid":$scope.dgsid, "msrdtlid":txt.attr("id"), "weight":txt.val() };
					totWgt += Number(txt.val());
				}
				i++;
			});

			if(totWgt != 100){
				alert("가중치의 합이 100이 아닙니다.	현재합 : "+totWgt);
				return;
			}

			//가중치 100 체크
			$scope.diagnosisWeight.dgsid = $scope.dgsid;
			$scope.diagnosisWeight.actionmode = "X";

			$scope.diagnosisWeight.wgts = tmpWgts;

			diagnosisMngService._storeWeght($scope.diagnosisWeight).then(
				function(data){
					if(data.reVal == "ok_resend"){
						//closeEditDiagnosis();
						alert("적용되었습니다. ");
						reloadGrid();
					}
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}

		$scope.actionPerformed = function(tag){
			if(tag == "insertDetail"){
				$scope.diagnosisDetail.dgsid = "0";
				$scope.diagnosisDetail.actionmode = "I";

				diagnosisMngService._storeDetail($scope.diagnosisDetail).then(
						function(data){
							if(data.reVal == "ok_resend"){
								$scope.diagnosis = data.listDiagnosis;
								closeEditDiagnosis();
								setTimeout(function(){
									reloadGrid();
								},1000);
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "updateDetail"){
				$scope.diagnosisDetail.piverid = $scope.piverid;
				$scope.diagnosisDetail.actionmode = "U";


				$scope.diagnosisDetail.msrdtl = $("#txtDetail").val();
				$scope.diagnosisDetail.calmtd = $("#txtCalMtd").val();

				diagnosisMngService._storeDetail($scope.diagnosisDetail).then(
						function(data){
							if(data.reVal == "ok_resend"){
								$scope.diagnosis = data.listDiagnosis;
								closeEditDiagnosis();
								setTimeout(function(){
									reloadGrid();
								},1000);
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "deleteDetail"){
				if(confirm("선택한 정보를 삭제하시겠습니까?")){
					$scope.diagnosisDetail.piverid = $scope.piverid;
					$scope.diagnosisDetail.actionmode = "D";
					diagnosisMngService._storeDetail($scope.diagnosisDetail).then(
							function(data){
								if(data.reVal == "ok_resend"){
									$scope.diagnosis = data.listDiagnosis;
									closeEditDiagnosis();

									if($scope.diagnosis[0]) {$scope.dgsid = $scope.diagnosis[0].dgsid; }
									setTimeout(function(){
										reloadGrid();
									},1000);
								}
							},
							function(error){
								console.log("actionPerformed error: "+error);
							}
						);
				}
			} else if(tag == "resetDetail"){
				$scope.setClearDetail();
			}
		}

		$scope.actionSelectDetail = function(detailId){
			$scope.diagnosisDetail.msrdtlid = detailId;
			$scope.diagnosisDetail.piverid = $scope.selVersion;
			$scope.diagnosisDetail.actionmode = "S";
			diagnosisMngService._selectDetail($scope.diagnosisDetail).then(
				function(data){
					$scope.diagnosisDetail = data.diagnosisDetail;

				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}

		$scope.setClearDetail = function(){
			$("#form_list").hide();
			$("#div_detail").show();

			$scope.diagnosisDetail = new Object();
			$scope.diagnosisDetail.year = $scope.years[10].toString();

			$("#btn_insert").show();
			$("#btn_update").hide();
			$("#btn_delete").hide();
			$("#btn_reset").hide();
		}

		$scope.actionShowDiagonsis = function(dgs){
			$("#btn_insert").hide();
			$("#btn_update").show();
			$("#btn_delete").show();
			$("#btn_reset").show();

			$scope.diagnosisDetail = dgs;
		}

	});

	diagnosisMngApp.factory("diagnosisMngService", function($http, $q){

		var factory = {
				_selectInit:function(pm){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:diagnosisInitURL,
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
				_storeDetail:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:diagnosisDetailURL,
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
				},
				_storeWeght:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:diagnosisDetailURL,
						params:{"mode":"weight"},
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
				_selectDetail:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:diagnosisDetailURL,
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
				}




		}

		return factory;

	});


	/* angular directive */
/*	diagnosisMngApp.directive("popupDiagnosisDetail", function(){
		return {
			templateUrl : "diagnosisDetail.do"
	    };
	});*/

