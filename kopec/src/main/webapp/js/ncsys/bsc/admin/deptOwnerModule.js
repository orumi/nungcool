/* VUE */


$(document).ready(function() {

	var mixin =
	{
	    methods : {
		  _xAjax : function(url, param){
		    	var deferred = $.Deferred();
				$.ajax({
					url     :  url,
					type    : 'POST',
					data    : param,
					dataType: 'json',
					success : function(data){
						deferred.resolve(data);
					},
					error   : function(err){
				    	deferred.reject(err);
					}
				});
				return deferred.promise();
		    }
		}
	}


	var app = new Vue({
		el : "#vueApp",
		mixins: [mixin],
		data : function(){
			return {
				years : [],
				selYear : null,
				SBUs : [],
				curSBU : null,
				users : [],
				curUser : null,
				sbuOwners : [],
				curOwner : null
			}
		},
		methods:{
			actionPerformed : function(){

				var param = new Object();
				param.owners = JSON.stringify(this.sbuOwners);
				param.year = this.selYear;
				param.scid = this.curSBU.scid;

				this._xAjax(adjustOwnersURL, param)
		    	.done(function(data){
		    		app.selectSBU();
		    	}).fail(function(error){
		    		console.log("actionPerformed error : "+error);
		    	});

			},
			addOwner : function(){

				if(this.curSBU == null){
					alert("적용할 사업단위를 선택하십시오.");
					return;
				}
				//기존 등록 여부 체크
				for(var i=0; i<this.sbuOwners.length; i++){
					var owner = this.sbuOwners[i];
					if(owner.userid == this.curUser.userid){
						this.curOwner = owner;
						return;
					}
				}

				var owner = new Object();
				owner.scid = this.curSBU.scid;
				owner.sname = this.curSBU.sname;
				owner.userid = this.curUser.userid;
				owner.username = this.curUser.username;

				this.curOwner = owner;
				this.sbuOwners.push(owner);

			},
			delOwner : function(){
				var idx = -1;
				for(var i=0; i<this.sbuOwners.length;i++){
					if(this.curOwner.userid == this.sbuOwners[i].userid){
						idx = i;
					}
				}
				if (idx > -1) {
					this.sbuOwners.splice(idx,1);

				}
			},
			clearOwner : function(){
				this.curOwner = null;
				this.sbuOwners = [];

			},
			clickOwner : function(owner){
				console.log("owner : "+owner.userid+" / "+owner.username);
				this.curOwner = owner;
			},
			selectSBU : function(){
				var param = new Object();
		    	param.year = this.selYear;

				this._xAjax(selectSBUURL, param)
		    	.done(function(data){
		    		app.SBUs = data.node;
		    		app.clearOwner();
		    	}).fail(function(error) {
		    		console.log("selectSBU error : "+error);
		    	});

			},
			selectUserList : function(){
				var param = new Object();
		    	param.year = this.selYear;

				this._xAjax(selectUserListURL, param)
		    	.done(function(data){
		    		app.users = data.userList;
		    	}).fail(function(error){
		    		console.log("selectUserList error : "+error);
		    	});

			},
			changeYear : function(){
				this.selectSBU();
				console.log("changeYear");
			},
			clickSBU : function(sbu){
				this.curSBU = sbu;

				var param = new Object();
		    	param.year = this.selYear;
		    	param.scid = this.curSBU.scid;

		    	this._xAjax(selectOwnerBySbuIdURL, param)
		    	.done(function(data){
		    		app.sbuOwners = data.ownerBySbuId;
		    	}).fail(function(error){
		    		console.log("selectUserList error : "+error);
		    	});
			},
			clickUserList : function(user){
				this.curUser = user;
				//console.log("username : "+user.username);
			}
		},
		created : function(){
			/* before dom instance  */
			console.log("init ...created");
			this.selYear = [];
			var date = new Date();
			var fYear = date.getFullYear();
			for(var y=10; y>0; y--){
				this.years[this.years.length] = (fYear-y+3);
			}
			this.selYear = this.years[6];
		},
		mounted : function(){
			/* after dom instance  */
			this.selectSBU();
			this.selectUserList();
		}
	});



});



















