	/* Angular app */
	var mainMngApp = angular.module("mainMngApp", []);

	mainMngApp.controller("mainMngController", function($scope, $http, $q, mainMngService){

		$scope.selYear ;
		$scope.years = [] ;

		$scope.verid;
		$scope.version = [];

		$scope.field = [];
		$scope.selField ;

		$scope.opProe = [{"val":"P"},{"val":"R"},{"val":"O"},{"val":"E"}];

		/* 담당자 구분 공통코드 */
		$scope.ownerType = [];

		/* 수행 주기 */
		$scope.opFrequency = [{"val":"월"},{"val":"분기"},{"val":"반기"},{"val":"년"}];

		$scope.radarSearchInfor = {
				"year":"",
				"verid":"",
		}
		$scope.radarLabels=[];
		$scope.radarDataP=[];
		$scope.radarDataA=[];

		/*planned Schedule */
		$scope.plannedSchedule = [];

		$scope.mainDetail = {
				"year":"",
				"month":"",
				"rgldtlid":"",
				"proofid":"",
				"proofitem":"",
				"frequency":"",
				"ownertype":"",
				"ownertypenm":"",
				"proe":"",
				"actionmode":"",
				"fldid":"",
				"fldnm":"",
				"rgldtlnm":"",
				"ismsstd":"",
				"rglid":"",
				"rglnm":"",
				"main":"",
				"maindetail":"",
				"verid":""
		}


		$scope.config = {
				type: 'radar',
				data: {
					labels: $scope.radarLabels,
					datasets: [{
						label: '전체건수',
						backgroundColor: "rgba(220,220,220,0.2)",
						borderColor: "rgba(158,158,158,0.5)",
						pointBackgroundColor: "rgba(158,158,158,0.5)",
						data: $scope.radarDataP
					}, {
						label: '완료건수',
						backgroundColor: "rgba(70,226,33,0.2)",
						borderColor: "rgba(70,226,33,1)",
						pointBackgroundColor: "rgba(70,226,33,1)",
						 data: $scope.radarDataA
					}]
				},
				options: {
					legend: {
						position: 'right',
					},
					title: {
						display: false,
						text: '분야별 완료현황'
					},
					scale: {
						ticks: {
							beginAtZero: true
						}
					}
				}
			};

		$scope.myRadar = new Chart(document.getElementById('radarChart01'), $scope.config);

		$(function(){
			/* 초기 설정 */
			$scope.init();

			/*init select infor */
			console.log("mainMngController Init Starting ... ");
			$scope.selectInitInfo().then(
					function (rslv){
						setTimeout(function(){
							//reloadGrid();
						},1000);
					},function(error){});

			/* 일정 계획 */
			$scope.selectPlannedSchedule();

		});

		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			mainMngService._selectInitInfo().then(
					function(data){
						$scope.version = data.listVersion;
						$scope.field = data.listField;
						$scope.regulation = data.listRegulation;

						if($scope.version[0]) {$scope.verid = $scope.version[0].verid; }

						$scope.selectRadarInfor();

						deferred.resolve(true);
					},
					function(error){
						console.log("actionPerformed insert error: "+error);
						deferred.reject("failed to selectInitInfo");
					}
				);

			return deferred.promise ;
		}


		$scope.selectPlannedSchedule = function(){
			//plannedScheduleURL
			mainMngService._httpPost(plannedScheduleURL,null,null).then(
					function(data){
						if(data.reVal == "ok_resend"){
							/* plannedSchedule */

							$scope.plannedSchedule = data.rePlannedSchedule;

						}
					},
					function(error){
						console.log("actionPerformed error: "+error);
					}
				);

		}


		$scope.init = function(){
			var date = new Date();
			var fYear = date.getFullYear();

			for(var y=10; y>0; y--){
				$scope.years[$scope.years.length] = {"value":(fYear-y+3)};
			}
			$scope.selYear = $scope.years[7];
		}


		/*select radar information */
		$scope.selectRadarInfor = function(){
			$scope.radarSearchInfor.year = $scope.selYear.value;
			$scope.radarSearchInfor.verid = $scope.verid;

			mainMngService._selectRadarInfor($scope.radarSearchInfor).then(
					function(data){
						if(data.reVal == "ok_resend"){
							/* 초기화 */
							var lng = $scope.radarLabels.length;
							for(var j=0; j<lng; j++){
								$scope.radarLabels.splice(0,1);
								$scope.radarDataP.splice(0,1);
								$scope.radarDataA.splice(0,1);
							}

							/* 정보 적용 */
							for(var i=0;i<data.radarDetail.length;i++){
								$scope.radarLabels[i] = data.radarDetail[i].fldnm;
								$scope.radarDataP[i] = data.radarDetail[i].tcnt;
								$scope.radarDataA[i] = data.radarDetail[i].ccnt;
							}

							$scope.myRadar.update();
						}
					},
					function(error){
						console.log("actionPerformed error: "+error);
					}
				);
		}



		$scope.actionPerformed = function(tag){
			//console.log("tag : "+tag);

			if(tag == "updateDetail"){
				if($scope.form_mainDetail.$valid){
					$scope.mainDetail.actionmode = "U";
					mainMngService._storeDetail($scope.mainDetail).then(
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
					console.log("form invalided");
					alert("입력하지 않거나 잘못된 정보가 있습니다.");
				}
			} else if(tag == "deleteDetail"){
				if(confirm("선택한 정보를 삭제하시겠습니까?")){
					$scope.mainDetail.actionmode = "D";
					mainMngService._storeDetail($scope.mainDetail).then(
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


		$scope.actionSelectDetail = function(year,month,proofid,rgldtlid){
			$scope.mainDetail.year = year;
			$scope.mainDetail.month = month;
			$scope.mainDetail.rgldtlid = rgldtlid;
			$scope.mainDetail.proofid = proofid;
			$scope.mainDetail.actionmode = "R";

			mainMngService._selectDetail($scope.mainDetail).then(
				function(data){
					$scope.mainDetail = data.mainDetail;
					$scope.attachFiles = data.mainFiles;

					//console.log("$scope.attachFiles file length:"+$scope.attachFiles.length);
					//console.log("data mainDetail year :"+data.mainDetail.year);
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}



	});

	mainMngApp.factory("mainMngService", function($http, $q){

		var factory = {
				_selectInitInfo:function(pm){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:regulationDetialInfoURL,
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
						url:mainDetailURL,
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
				_selectDetail:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:mainDetailURL,
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
				_deleteFile:function(mainFile){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:deleteFileURL,
						params:{"mode":"delete"},
						data:mainFile,
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
				_selectRadarInfor:function(radarInfor){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:radarInforURL,
						params:{"mode":"select"},
						data:radarInfor,
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
				}
		}
		return factory;

	});



