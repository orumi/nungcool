	/* Angular app */
	var actualMngApp = angular.module("actualMngApp", []);

	actualMngApp.controller("actualMngController", function($scope, $http, $q, actualMngService){

		$scope.selYear ;
		$scope.years = [] ;


		$scope.verid;

		$scope.version = [];
		$scope.selVersion ;

		$scope.field = [];
		$scope.selField ;

		$scope.opProe = [{"val":"P"},{"val":"R"},{"val":"O"},{"val":"E"}];

		/* 담당자 구분 공통코드 */
		$scope.ownerType = [];

		/* 수행 주기 */
		$scope.opFrequency = [{"val":"월"},{"val":"분기"},{"val":"반기"},{"val":"년"}];

		$scope.actualDetail = {
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
				"actual":"",
				"actualdetail":"",
				"verid":""
		}

		$scope.attachFiles = [];

		$scope.actualFile = {
				"year":"",
				"month":"",
				"proofid":"",
				"attachseq":"",
				"orginfilename":"",
				"newname":"",
				"storedfilepath":"",
				"fileext":""
		}


		$(function(){
			/*init select infor */
			console.log("actualMngController Init Starting ... ");
			$scope.selectInitInfo($scope.verid).then(
					function (rslv){
						setTimeout(function(){
							reloadGrid();
						},1000);
					},function(error){});

			/* 초기 설정 */
			$scope.init();

		});

		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			actualMngService._selectInitInfo().then(
					function(data){
						$scope.version = data.listVersion;
						$scope.field = data.listField;
						$scope.regulation = data.listRegulation;

						if($scope.version[0]) {$scope.verid = $scope.version[0].verid; }
						deferred.resolve(true);
					},
					function(error){
						console.log("actionPerformed insert error: "+error);
						deferred.reject("failed to selectInitInfo");
					}
				);

			return deferred.promise ;
		}

		$scope.init = function(){
			var date = new Date();
			var fYear = date.getFullYear();

			for(var y=10; y>0; y--){
				$scope.years[$scope.years.length] = {"value":(fYear-y+3)};
			}
			$scope.selYear = $scope.years[7];
		}

		$scope.actionPerformed = function(tag){
			//console.log("tag : "+tag);

			if(tag == "updateDetail"){
				if($scope.form_actualDetail.$valid){
					$scope.actualDetail.actionmode = "U";
					actualMngService._storeDetail($scope.actualDetail).then(
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
					$scope.actualDetail.actionmode = "D";
					actualMngService._storeDetail($scope.actualDetail).then(
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
			$scope.actualDetail.year = year;
			$scope.actualDetail.month = month;
			$scope.actualDetail.rgldtlid = rgldtlid;
			$scope.actualDetail.proofid = proofid;
			$scope.actualDetail.actionmode = "R";

			actualMngService._selectDetail($scope.actualDetail).then(
				function(data){
					$scope.actualDetail = data.actualDetail;
					$scope.attachFiles = data.actualFiles;

					//console.log("$scope.attachFiles file length:"+$scope.attachFiles.length);
					//console.log("data actualDetail year :"+data.actualDetail.year);
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}

		$scope.actionDeleteFile = function(actualFile) {
			/*$scope.actualFile.year = year;
			$scope.actualFile.month = month;
			$scope.actualFile.proofid = proofid;
			$scope.actualFile.attachseq = attachseq;*/

			$scope.actualFile = actualFile;

			console.log("$scope.actualFile.attachseq : "+$scope.actualFile.attachseq);

			actualMngService._deleteFile($scope.actualFile).then(
					function(data){
						$scope.attachFiles = data.actualFiles;
					},
					function(error){
						console.log("actionPerformed error: "+error);
					}
				);

		}

		// fileUpload
	    $scope.fileUpload = function (event) {
	    	//var fileId = $(event.target).attr("id");

	        var files = event.target.files;
	        for (var i = 0; i < files.length; i++) {
	        	var file = files[i];
	        	var reader = new FileReader();

        		reader.onload = _fileIsLoaded;
	        	reader.readAsDataURL(file);
	        }

	    }

	    $scope.fileDown = function(actualFile) {
	    	var aURL = attachURL+"?atchFileId="+actualFile.proofid+"&fileSn="+actualFile.attachseq;

	    	console.log(aURL);

	    	window.open(aURL);
	    }


	    _fileIsLoaded = function (e) {
	        $scope.$apply(function () {

	        	var file = $scope.myFile;
	        	/*console.log('file is ' );
	        	console.dir(file);*/

	        	var data = new FormData();
	        	data.append('file', file);
	        	data.append('year', $scope.actualDetail.year);
	            data.append('month', $scope.actualDetail.month);
	            data.append('rgldtlid', $scope.actualDetail.rgldtlid);
	            data.append('proofid', $scope.actualDetail.proofid);

	            var config = {
	         	   	transformRequest: angular.identity,
	         	   	transformResponse: angular.identity,
	     	   		headers : {
	     	   			'Content-Type': undefined
	     	   	    }
	            }

	            $http.post(uploadFileURL, data, config).then(function (response) {
	            	var reJson = $.parseJSON(response.data)
	            	$scope.attachFiles = reJson.actualFiles;

	            	console.log("upload success");
	    		}, function (response) {
	    			console.log("upload failure");
	    			//$scope.uploadResult=response.data;
	    		});


	        });
	    }



	    /* actual validate */

		$scope.isActualDetailRequired = function(){
			var tmpAct = $scope.actualDetail.actual;
			if($.isNumeric(tmpAct)){
				if(0 <= tmpAct && tmpAct <=1){

				} else {
					alert("실적은 0.0에서 1사이 입력가능합니다. (예:0.5)");
					$scope.actualDetail.actual = "";
				}
			} else {
				$scope.actualDetail.actual = "";
			}
			//console.log("$scope.actualDetail.actual  : "+ $scope.actualDetail.actual);
			return true;
		}

	});

	actualMngApp.factory("actualMngService", function($http, $q){

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
						url:actualDetailURL,
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
						url:actualDetailURL,
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
				_deleteFile:function(actualFile){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:deleteFileURL,
						params:{"mode":"delete"},
						data:actualFile,
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


	actualMngApp.directive('fileModel', ['$parse', function ($parse) {
	    return {
	        restrict: 'A',
	        link: function(scope, element, attrs) {
	            var model = $parse(attrs.fileModel);
	            var modelSetter = model.assign;

	            element.bind('change', function(){
	                scope.$apply(function(){
	                    modelSetter(scope, element[0].files[0]);
	                });
	            });
	        }
	    };
	}]);


	/* angular directive */
	actualMngApp.directive("popupActualDetail", function(){
		return {
			templateUrl : "actualDetail.do"
	    };
	});


	actualMngApp.directive('numbersOnly', function() {
	    return {
	        require: 'ngModel',
	        link: function(scope, element, attrs, modelCtrl) {
	            modelCtrl.$parsers.push(function(inputValue) {
	                if (inputValue == undefined) return ''
	                var onlyNumeric = inputValue.replace(/[^0-9 ^.]/g, '');
	                onlyNumeric = onlyNumeric.replace(/[\ㄱ-ㅎ ㅏ-ㅣ 가-힣]/g, '');
	                if (onlyNumeric != inputValue) {
	                    modelCtrl.$setViewValue(onlyNumeric);
	                    modelCtrl.$render();
	                }
	                return onlyNumeric;
	            });
	        }
	    };
	 });
