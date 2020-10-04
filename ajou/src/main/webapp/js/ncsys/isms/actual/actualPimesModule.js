	/* Angular app */
	var actualPimesApp = angular.module("actualPimesApp", []);
	
	actualPimesApp.controller("actualPimesController", function($scope, $http, $q, actualPimesService){
		
		$scope.selYear ;
		$scope.years = [] ;
		
		$scope.selDiagnosis ;
		$scope.diagnosis = [];
		
		
		$scope.actualDetail = {
				"dgsid":"",
				"msrdtlid":"",
				"pifldnm":"",
				"msrname":"",
				"msrdtlnm":"",
				"msrdtl":"",
				"certiact":"",
				"calmtd":"",
				"weight":"",
				"actual":"",
				"year":"",
				"detail":"",
				"actionmode":""
		}
		
		$scope.attachPlnFiles = [];
		$scope.attachActFiles = [];
		$scope.attachAggFiles = [];
		
		$scope.actualFile = {
				"dgsid":"",
				"attachseq":"",
				"msrdtlid":"",
				"attachtype":"",
				"orginfilename":"",
				"newname":"",
				"storedfilepath":"",
				"fileext":""
		}
		
		
		$(function(){
			/*init select infor */
			console.log("actualPimesController Init Starting ... ");
			
			$scope.init().then(
				function(data){	
					//console.log("$scope.selYear : "+$scope.selYear.value);					
					$scope.selectInitInfo().then(
						function (rslv){
							"reloadGrid "
						},function(error){});
				}
			);
			
			
		});
		
		$scope.selectInitInfo = function(){
			var deferred = $q.defer();
			var pm = {"year":$scope.selYear.value};
			actualPimesService._selectInitInfo(pm).then(
					function(data){
						$scope.diagnosis = data.listDiagnosis;
						if($scope.diagnosis[0]) $scope.selDiagnosis = $scope.diagnosis[0].dgsid;
						
						setTimeout(function(){
							reloadGrid();
						},1000);
						
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
			var deferred = $q.defer();
			
			var date = new Date();
			var fYear = date.getFullYear();
			
			for(var y=10; y>0; y--){
				$scope.years[$scope.years.length] = {"value":(fYear-y+3)};
			}
			$scope.selYear = $scope.years[7];
			
			if($scope.selYear) deferred.resolve(true);
			else deferred.reject("failed to init");
			
			return deferred.promise ;
		}
		
		$scope.actionPerformed = function(tag){
			//console.log("tag : "+tag);
			
		}
		
		
		$scope.actionSelectDetail = function(dgsid, msrdtlid){
			$scope.actualDetail.dgsid = dgsid;
			$scope.actualDetail.msrdtlid = msrdtlid;
			$scope.actualDetail.actionmode = "R";
			
			actualPimesService._selectDetail($scope.actualDetail).then(
				function(data){
					$scope.actualDetail = data.actualPimesDetail;
					$scope.attachPlnFiles = data.actualPimesPlnFiles;
					$scope.attachActFiles = data.actualPimesActFiles;
					$scope.attachAggFiles = data.actualPimesAggFiles;
					
					//console.log("$scope.attachFiles file length:"+$scope.attachFiles.length);
					//console.log("data actualDetail year :"+data.actualDetail.year);
				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}

		$scope.actionPerformed = function(tag){
			
			if(tag == "updateDetail"){
				if($scope.form_actualDetail.$valid){
					$scope.actualDetail.actionmode = "U";
					actualPimesService._storeDetail($scope.actualDetail).then(
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
					actualPimesService._storeDetail($scope.actualDetail).then(
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
		
		$scope.actionDeleteFile = function(actualFile) {
			
			$scope.actualFile = actualFile;
			
			actualPimesService._deleteFile($scope.actualFile).then(
					function(data){
						
						if($scope.actualFile.attachtype == "PLN") $scope.attachPlnFiles = data.actualFiles;
		            	else if($scope.actualFile.attachtype == "ACT") $scope.attachActFiles = data.actualFiles;
		            	else if($scope.actualFile.attachtype == "AGG") $scope.attachAggFiles = data.actualFiles;
					},
					function(error){
						console.log("actionPerformed error: "+error);
					}
				);
			
		}
		
		// fileUpload
	    $scope.fileUpload = function (event) {
	    	var filetype = $(event.target).attr("filetype");
	    	
	    	$scope.actualFile.attachtype = filetype;
	    	
	        var files = event.target.files;
	        for (var i = 0; i < files.length; i++) {
	        	var file = files[i];
	        	var reader = new FileReader();
	        	
        		reader.onload = _fileIsLoaded;
	        	reader.readAsDataURL(file);
	        }
	        
	    }
	    
	    $scope.fileDown = function(actualFile) {
	    	var aURL = attachURL+"?atchFileId="+actualFile.msrdtlid+"&fileSn="+actualFile.attachseq;
	    	
	    	//console.log(aURL);
	    			
	    	window.open(aURL);
	    }
	    
	    
	    _fileIsLoaded = function (e) {
	        $scope.$apply(function () {
	        	
	        	var file = $scope.myFile;
	        	
	        	var data = new FormData();
	        	data.append('file', file);
	        	data.append('dgsid', $scope.actualDetail.dgsid);
	            data.append('msrdtlid', $scope.actualDetail.msrdtlid);
	            data.append('attachtype', $scope.actualFile.attachtype);
	            
	            var config = {
	         	   	transformRequest: angular.identity,
	         	   	transformResponse: angular.identity,
	     	   		headers : {
	     	   			'Content-Type': undefined
	     	   	    }
	            }
	            
	            $http.post(uploadFileURL, data, config).then(function (response) {
	            	var reJson = $.parseJSON(response.data)
	            	
	            	if($scope.actualFile.attachtype == "PLN") $scope.attachPlnFiles = reJson.actualFiles;
	            	else if($scope.actualFile.attachtype == "ACT") $scope.attachActFiles = reJson.actualFiles;
	            	else if($scope.actualFile.attachtype == "AGG") $scope.attachAggFiles = reJson.actualFiles;
	            	
	            	
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
				if(0 <= tmpAct && tmpAct <=100){
					
				} else {
					alert("진척율은 0에서 100사이 입력가능합니다.");
					$scope.actualDetail.actual = "";
				}
			} else {
				$scope.actualDetail.actual = "";
			}
			//console.log("$scope.actualDetail.actual  : "+ $scope.actualDetail.actual);
			return true;
		}
		
	});	
	
	actualPimesApp.factory("actualPimesService", function($http, $q){
		
		var factory = {
				_selectInitInfo:function(pm){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:initInfoURL,
						params:pm,
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
				_storeDetail:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:actualDetailURL,
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
				_selectDetail:function(detail){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:actualDetailURL,
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
				_deleteFile:function(actualFile){
					var deferred  = $q.defer();
					$http({
						method:'POST',
						url:deleteFileURL,
						params:{"mode":"delete"},
						data:actualFile,
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
	
	
	actualPimesApp.directive('fileModel', ['$parse', function ($parse) {
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
	actualPimesApp.directive("popupActualDetail", function(){
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
	