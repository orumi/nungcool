	/* Angular app */
	var angularApp = angular.module("angularApp", []);

	angularApp.controller("angularController", function($scope, $http, $q, angularService){

		$scope.entity = {
			selYear : null,
			years   : [],
			company : [],
			selCompany : null,
			sbu     : [],
			selSbu : null,
			bsc     : [],
			selBsc : null,
			hierarchy : {
				year:null,
				ccid:null,
				crank:null,
				scid:null,
				srank:null,
				bcid:null,
				brank:null,
				tId:null,
				newId:null,
				treeLevel:null,
				childCount:null
			}
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
                { name: 'rank'},
                { name: 'value' }
            ],
            id: 'id',
            icon: 'icon',
            localdata: null
        };

		$(function(){
			/*init select infor */
			//console.log("hierarchyController Init Starting ... ");
			/* 초기 설정 */
			$scope.init().then(
					function(rslv){
						$scope.selectHierarchy($scope.entity.selYear.value);
						//$scope.selectMapImages();
						$scope.selectComponent();
					},
					function(error){});

			$scope.initButton();

		});

		$scope.initButton = function () {
			$("#btnAdd").show();
			$("#btnCancel").hide();
			$("#btnMod").hide();
			$("#btnDel").hide();

			$("#selCom").attr("disabled", false);
			$("#selSbu").attr("disabled", false);
			$("#selBsc").attr("disabled", false);

			$("#selCom").css({"background-color":"","color":""});
			$("#selSbu").css({"background-color":"","color":""});
			$("#selBsc").css({"background-color":"","color":""});

			$scope.entity.hierarchy.crank = null;
			$scope.entity.hierarchy.srank = null;
			$scope.entity.hierarchy.brank = null;

		}

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
					},
					function(error){
						console.log("actionPerformed error: "+error);
					}
				);
		}

		$scope.selectComponent = function (){
			angularService._httpPost(selectComponentUrl).then(
					function(data){
						$scope.entity.company = data.company;
						$scope.entity.sbu = data.sbu;
						$scope.entity.bsc = data.bsc;

						$scope.entity.selCompany = $scope.entity.company[0].id
						$scope.entity.selSbu = $scope.entity.sbu[0].id
						$scope.entity.selBsc = $scope.entity.bsc[0].id

					},
					function(error){
						console.log("actionPerformed error: "+error);
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


		$scope.changeYear = function(){
			$scope.initButton();
			$scope.selectHierarchy($scope.entity.selYear.value);
		}

		$scope.changeTreeNode = function(level, id, contentid, parentId, childCount){
			var curNode = null;

			for(var i in $scope.source.localdata){
				//console.log("treenode id : "+$scope.source.localdata[i].id);

				if(id == $scope.source.localdata[i].id){
					curNode = $scope.source.localdata[i];
					break;
				}
			}
			$scope.entity.hierarchy.crank = null;
			$scope.entity.hierarchy.srank = null;
			$scope.entity.hierarchy.brank = null;

			if(level==0){
				$("#selCom").attr("disabled", false);
				$("#selSbu").attr("disabled", true);
				$("#selBsc").attr("disabled", true);

				$("#selCom").css({"background-color":"","color":""});
				$("#selSbu").css({"background-color":"#f1f1f1","color":"#c1c1c1"});
				$("#selBsc").css({"background-color":"#f1f1f1","color":"#c1c1c1"});

				$scope.entity.selCompany = contentid;
				$scope.entity.hierarchy.crank = curNode.rank;
			} else if(level==1){
				$("#selCom").attr("disabled", true);
				$("#selSbu").attr("disabled", false);
				$("#selBsc").attr("disabled", true);

				$("#selCom").css({"background-color":"#f1f1f1","color":"#c1c1c1"});
				$("#selSbu").css({"background-color":"","color":""});
				$("#selBsc").css({"background-color":"#f1f1f1","color":"#c1c1c1"});

				$scope.entity.selSbu = contentid;
				$scope.entity.hierarchy.srank = curNode.rank;
			} else if(level==2){
				$("#selCom").attr("disabled", true);
				$("#selSbu").attr("disabled", true);
				$("#selBsc").attr("disabled", false);

				$("#selCom").css({"background-color":"#f1f1f1","color":"#c1c1c1"});
				$("#selSbu").css({"background-color":"#f1f1f1","color":"#c1c1c1"});
				$("#selBsc").css({"background-color":"","color":""});

				$scope.entity.selBsc = contentid;
				$scope.entity.hierarchy.brank = curNode.rank;

			}

			$scope.entity.hierarchy.tId = id;
			$scope.entity.hierarchy.treeLevel = level;
			$scope.entity.hierarchy.childCount = childCount;

			$scope.$apply();

			$("#btnAdd").hide();
			$("#btnCancel").show();
			$("#btnMod").show();
			if(childCount == 0 ){
				$("#btnDel").show();
			} else {
				$("#btnDel").hide();
			}

			//console.log("item property level:" + level + " id:" + id + " contentid :"+contentid+" pid:" + parentId);
		}



		$scope.actionPerformed = function(tag){
			//console.log("tag : "+tag);

			if(tag == "add"){

				$scope.entity.hierarchy.year = $scope.entity.selYear.value;
				$scope.entity.hierarchy.ccid = $scope.entity.selCompany;
				$scope.entity.hierarchy.scid = $scope.entity.selSbu;
				$scope.entity.hierarchy.bcid = $scope.entity.selBsc;

				angularService._httpPost(adjusttHierarchyUrl, {"actionmode":"I"}, $scope.entity.hierarchy).then(
						function(data){
							if(data.reVal == "ok_resend"){
								$scope.source.localdata = data.node;

		                    	var dataAdapter = new $.jqx.dataAdapter($scope.source);
		                        dataAdapter.dataBind();
		                        var records = dataAdapter.getRecordsHierarchy('id', 'parentid', 'items', [{ name: 'label', map: 'label'}]);
		                        $('#jqxTree').jqxTree({ source: records });
		                        $('#jqxTree').jqxTree('expandAll');
		                        $('#jqxTree').jqxTree('render');

		                        alert("추가되었습니다.");
		                        $scope.initButton();
							}
						},
						function(error){
							console.log("actionPerformed error: "+error);
						}
					);
			} else if(tag == "mod"){
				$scope.entity.hierarchy.year = $scope.entity.selYear.value;
				$scope.entity.hierarchy.ccid = $scope.entity.selCompany;
				$scope.entity.hierarchy.scid = $scope.entity.selSbu;
				$scope.entity.hierarchy.bcid = $scope.entity.selBsc;

				if($scope.entity.hierarchy.tId != null) {
					angularService._httpPost(adjusttHierarchyUrl, {"actionmode":"U"}, $scope.entity.hierarchy).then(
							function(data){
								if(data.reVal == "ok_resend"){
									$scope.source.localdata = data.node;

			                    	var dataAdapter = new $.jqx.dataAdapter($scope.source);
			                        dataAdapter.dataBind();
			                        var records = dataAdapter.getRecordsHierarchy('id', 'parentid', 'items', [{ name: 'label', map: 'label'}]);
			                        $('#jqxTree').jqxTree({ source: records });
			                        $('#jqxTree').jqxTree('expandAll');
			                        $('#jqxTree').jqxTree('render');

			                        alert("수정되었습니다.");
			                        $scope.initButton();
								}
							},
							function(error){
								console.log("actionPerformed error: "+error);
							}
						);

				}
			} else if(tag == "del") {

				if($scope.entity.hierarchy.childCount != 0){
					alert("하위노드부터 삭제하십시오.");
					return;
				}


				$scope.entity.hierarchy.year = $scope.entity.selYear.value;
				$scope.entity.hierarchy.ccid = $scope.entity.selCompany;
				$scope.entity.hierarchy.scid = $scope.entity.selSbu;
				$scope.entity.hierarchy.bcid = $scope.entity.selBsc;

				if($scope.entity.hierarchy.tId != null) {
					if(confirm("선택한 정보를 삭제하시겠습니까?")){
						angularService._httpPost(adjusttHierarchyUrl, {"actionmode":"D"}, $scope.entity.hierarchy).then(
							function(data){
								if(data.reVal == "ok_resend"){
									$scope.source.localdata = data.node;

			                    	var dataAdapter = new $.jqx.dataAdapter($scope.source);
			                        dataAdapter.dataBind();
			                        var records = dataAdapter.getRecordsHierarchy('id', 'parentid', 'items', [{ name: 'label', map: 'label'}]);
			                        $('#jqxTree').jqxTree({ source: records });
			                        $('#jqxTree').jqxTree('expandAll');
			                        $('#jqxTree').jqxTree('render');

			                        $scope.initButton();

								} else if (data.reVal == "existChild"){
									alert("하위노드부터 삭제하십시오.");
								}
							},
							function(error){
								console.log("actionPerformed error: "+error);
							}
						);
					}
				} else {
					alert("삭제할 정보를 선택하십시오.");
				}

			} else if (tag == "cancel"){
				$scope.initButton();
			}
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

