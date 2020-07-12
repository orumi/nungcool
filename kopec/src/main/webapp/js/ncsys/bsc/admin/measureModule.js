	/* Angular app */
	var angularApp = angular.module("angularApp", []);

	angularApp.controller("angularController", function($scope, $http, $q, angularService){

		$scope.entity = {
			selYear : null,
			years   : [],
			pst     : [],
			selPst  : null,
			object     : [],
			selObject  : null,
			measure    : [],
			selMeasure : null,

			hierarchy : {
				year:null,
				ccid:null,
				scid:null,
				bcid:null,
				tId:null,
				newId:null,
				treeLevel:null,
				childCount:null
			},

			measureDefine : {
				 mode:null
				,id:null
				,bid:null
				,year:null
				,pcid:null
				,ocid:null
				,measureid:null
				,mean:null
				,detaildefine:null
				,weight:null
				,unit:null
				,planned:100
				,plannedBasePlus:95
				,plannedBase:90
				,basePlus:85
				,base:80
				,baseLimitPlus:75
				,baseLimit:70
				,limitPlus:65
				,limit:65
				,measurement:null
				,trend:null
				,frequency:null
/*				,eval_frq:null
				,evalmethod:null*/
				,equation:null
				,equationdefine:null
				,etlkey:null
				,updateid:null
				,equationType:"A"
				,plannedFlag:"U"
				,authority:[]
				,items: []
				,itemcnt:0
			},

			measureUpdater:[],

			measureUsers:[]

		}

		/* Tree load data */
		$scope.source =
        {
            datatype: "json",
            datafields: [
                { name: 'id' },
                { name: 'parentid' },
                { name: 'label' },
                { name: 'icon'},
                { name: 'value' }
            ],
            id: 'id',
            icon: 'icon',
            localdata: null
        };

		$(function(){
			/*init select infor */
			console.log("measureController Init Starting ... ");
			/* 초기 설정 */
			$scope.init().then(
					function(rslv){
						$scope.selectHierarchy($scope.entity.selYear.value);

						$scope.selectComponent();

						$scope.selectMeasureUser();

						/*setTimeout(function(){
							reloadGrid();
						},1000);*/
					},
					function(error){});

		});


		$scope.selectHierarchy = function (year){
			angularService._httpPost(selectHerarchyUrl, {"year":year}).then(
					function(data){
						$scope.source.localdata = data.node;

                    	var dataAdapter = new $.jqx.dataAdapter($scope.source);
                        // perform Data Binding.
                        dataAdapter.dataBind();
                        // get the tree items. The first parameter is the item's id. The second parameter is the parent item's id. The 'items' parameter represents
                        // the sub items collection name. Each jqxTree item has a 'label' property, but in the JSON data, we have a 'text' field. The last parameter
                        // specifies the mapping between the 'text' and 'label' fields.
                        var records = dataAdapter.getRecordsHierarchy('id', 'parentid', 'items', [{ name: 'label', map: 'label'}]);

                        $('#jqxTree').jqxTree({ source: records });
                        $('#jqxTree').jqxTree('expandAll');

                        $('#jqxTree').jqxTree('render');

                        //$scope.openProperties();
					},
					function(error){
						console.log("actionPerformed error: "+error);
					}
				);
		}

		$scope.selectComponent = function (){
			angularService._httpPost(selectComponentUrl).then(
				function(data){
					$scope.entity.pst = data.pst;
					$scope.entity.object = data.object;
					$scope.entity.measure = data.measure;

					$scope.entity.selPst = $scope.entity.pst[0].id
					$scope.entity.selObject = $scope.entity.object[0].id
					$scope.entity.selMeasure = $scope.entity.measure[0].id

				},
				function(error){
					console.log("actionPerformed error: "+error);
				}
			);
		}

		$scope.selectMeasureUser = function (){
			angularService._httpPost(selectMeasureUserUrl).then(
				function(data){
					$scope.entity.measureUsers = data.selectMeasureUser;

				},
				function(error){
					console.log("selectMeasureUser error: "+error);
				}
			);
		}

		$scope.init = function(){
			var deferred = $q.defer();
			var date = new Date();
			var fYear = date.getFullYear();

			for(var y=10; y>0; y--){
				$scope.entity.years[$scope.entity.years.length] = {"value":(fYear-y+3)};
			}
			$scope.entity.selYear = $scope.entity.years[7];

			$scope.$apply();

			deferred.resolve(true);
			return deferred.promise ;
		}


		$scope.clearMeasureDetail = function(){
			$scope.entity.measureDefine.mode=null;
			$scope.entity.measureDefine.id=null;
			$scope.entity.measureDefine.bid=null;
			$scope.entity.measureDefine.year=null;
			$scope.entity.measureDefine.pcid=null;
			$scope.entity.measureDefine.ocid=null;
			$scope.entity.measureDefine.measureid=null;
			$scope.entity.measureDefine.mean=null;
			$scope.entity.measureDefine.detaildefine=null;
			$scope.entity.measureDefine.weight=null;
			$scope.entity.measureDefine.unit=null;
			$scope.entity.measureDefine.planned=100;
			$scope.entity.measureDefine.plannedBasePlus=95;
			$scope.entity.measureDefine.plannedBase=90;
			$scope.entity.measureDefine.basePlus=85;
			$scope.entity.measureDefine.base=80;
			$scope.entity.measureDefine.baseLimitPlus=75;
			$scope.entity.measureDefine.baseLimit=70;
			$scope.entity.measureDefine.limitPlus=65;
			$scope.entity.measureDefine.limit=65;
			$scope.entity.measureDefine.measurement=null;
			$scope.entity.measureDefine.trend=null;
			$scope.entity.measureDefine.frequency=null;
			$scope.entity.measureDefine.equation=null;
			$scope.entity.measureDefine.equationdefine=null;
			$scope.entity.measureDefine.etlkey=null;
			$scope.entity.measureDefine.updateid=null;
			$scope.entity.measureDefine.equationType="A";
			$scope.entity.measureDefine.plannedFlag="U";
			$scope.entity.measureDefine.authority=[];
			$scope.entity.measureDefine.items= [];
			$scope.entity.measureDefine.itemcnt=0;

			$scope.entity.measureUpdater = [];


		}




		$scope.changeYear = function(){
			$scope.selectHierarchy($scope.entity.selYear.value);
		}

		$scope.changeTreeNode = function(level, id, contentid, parentId, childCount){

			//console.log("item property level:" + level + " id:" + id + " contentid :"+contentid+" pid:" + parentId);

			if(level==0){
//
			} else if(level==1){
//
			} else if(level==2){
				$scope.entity.hierarchy.tId = id;
				$scope.entity.hierarchy.treeLevel = level;
				$scope.entity.hierarchy.childCount = childCount;

				console.log("item property level:" + level + " id:" + id + " contentid :"+contentid+" pid:" + parentId);
				console.log("tid : "+$scope.entity.hierarchy.tId);
				reloadGrid();
//
//
			}
//
//
			//console.log("item property level:" + level + " id:" + id + " contentid :"+contentid+" pid:" + parentId);
		}



		$scope.actionPerformed = function(tag){

			if(tag == "adjustMeasure"){

				$scope.entity.measureDefine.year = $scope.entity.selYear.value;
				/*$scope.entity.measureDefine.pcid = $scope.entity.selPst;
				$scope.entity.measureDefine.ocid = $scope.entity.selObject;
				$scope.entity.measureDefine.measureid = $scope.entity.selMeasure;*/
				$scope.entity.measureDefine.bid = $scope.entity.hierarchy.tId;



				angularService._httpPost(adjustMeasureDefineUrl, {"actionmode":"U"}, $scope.entity.measureDefine).then(
						function(data){
							if(data.reVal == "ok_resend"){

								alert("저장하였습니다.");
								$scope.closeProperties();
								reloadGrid();
							} else {
								alert("저장하는데 실패하였습니다.");
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "deleteMeasure") {

				$scope.entity.measureDefine.year = $scope.entity.selYear.value;
				$scope.entity.measureDefine.bid = $scope.entity.hierarchy.tId;



				if(confirm("선택한 정보를 삭제하시겠습니까?")){
					angularService._httpPost(deleteMeasureDefineUrl, {"actionmode":"D"}, $scope.entity.measureDefine).then(
						function(data){
							if(data.reVal == "ok_resend"){
								alert("삭제하였습니다.");
								$scope.closeProperties();
								reloadGrid();
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
				}


			} else if (tag == "cancel"){
				$scope.initButton();
			}
		}


		$scope.addUpdater = function(user){
			$scope.entity.measureUpdater[0] = user;

			$scope.entity.measureDefine.updateid = user.userId;
		}

		$scope.addAuthority = function(user){

			//$scope.entity.measureAuthority[$scope.entity.measureAuthority.length] = user;
			$scope.entity.measureDefine.authority[$scope.entity.measureDefine.authority.length] = user;
		}


		$scope.delUpdater = function(user){

			$scope.entity.measureDefine.updateid = null;
			$scope.entity.measureUpdater.splice(0, 1);
		}

		$scope.delAuthority = function(user){

			for(var i=0;i<$scope.entity.measureDefine.authority.length;i++){
				var selUser = $scope.entity.measureDefine.authority[i];
				if(user.userId == selUser.userId){
					$scope.entity.measureDefine.authority.splice(i, 1);
				}
			}
		}







		$scope.actionItemAdd = function(){

			$scope.entity.measureDefine.itemcnt = Number($scope.entity.measureDefine.itemcnt) + Number(1);

			var newCode = $scope.entity.measureDefine.itemcnt<10?"X0"+$scope.entity.measureDefine.itemcnt:"X"+$scope.entity.measureDefine.itemcnt;
			var newItem = {
					 "idx":$scope.entity.measureDefine.itemcnt
					,"code":newCode
					,"itemname":"신규항목"
					,"itemfixed":"N"
			}

			$scope.entity.measureDefine.items.push(newItem);
		}

		$scope.actionItemDel = function(opt){

			var idx = -1;
			for(var i=0; i<$scope.entity.measureDefine.items.length;i++){
				if(opt.idx == $scope.entity.measureDefine.items[i].idx){
					idx = i;
				}
			}

			if (idx > -1) {
				$scope.entity.measureDefine.items.splice(idx,1);

			}

		};

		/* properties controller */
		$scope.openProperties = function(defineid){
			$scope.clearMeasureDetail();

			if($scope.entity.hierarchy.tId){
				$("#div_properties").show();
				$(".wrap").after("<div class='overlay'></div>");

				if(defineid == "add"){
					$scope.entity.measureDefine.mode = "insert";
					$("#btn_delete_measure").hide();
				} else {
					$scope.entity.measureDefine.id = defineid;
					$scope.entity.measureDefine.year = $scope.entity.selYear.value;

					console.log("$scope.entity.measureDefine.id : "+$scope.entity.measureDefine.id);


					angularService._httpPost(selectMeasureDefineUrl, {"actionmode":"U"}, $scope.entity.measureDefine).then(
						function(data){
							if(data.reVal == "ok_resend"){

								$scope.entity.measureDefine = data.reMeasure;
								$scope.entity.measureDefine.mode = "update";

								/* items*/
								var items = data.reItem;
								for(var k=0;k<items.length;k++){
									var item = items[k];
									$scope.entity.measureDefine.itemcnt = Number($scope.entity.measureDefine.itemcnt) + Number(1);
									var newItem = {
											 "idx":$scope.entity.measureDefine.itemcnt
											,"code":item.code
											,"itemname":item.itemname
											,"itemfixed":item.itemfixed
									}

									$scope.entity.measureDefine.items.push(newItem);
								}

								/* updaters */
								var updateUsers = data.reUpdater;
								for(var i=0; i<updateUsers.length;i++){
									var user = updateUsers[i];
									if(user.tp == "Y"){
										$scope.addUpdater(user);
									} else {
										$scope.addAuthority(user);
									}
								}


							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);



					$("#btn_delete_measure").show();
				}



			} else {
				alert("추가하려는 부서를 선택하십시오.");
			}
		}

		$scope.closeProperties = function(){
			$("#div_properties").hide();
        	$(".wrap").after("<div class='overlay'></div>");

        	$(".overlay").remove();
		}


		$scope.openMeasureUser = function(){
			console.log("openMeasureUser");

			$("#div_properties").hide();
			$("#div_measureUser").show();
        	/*$(".wrap").after("<div class='overlay'></div>");*/
		}


		$scope.closeMeasureUser = function(){
			$("#div_properties").show();
			$("#div_measureUser").hide();
		}




	});

	angularApp.factory("angularService", function($http, $q){

		var factory =
		{
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

	});


	/* angular directive */
	angularApp.directive("popupDetailProperties", function(){
		return {
			templateUrl : "measureDetail.do"
	    };
	});

	/* angular directive */
	angularApp.directive("popupDetailMeasureuser", function(){
		return {
			templateUrl : "measureUser.do"
	    };
	});
