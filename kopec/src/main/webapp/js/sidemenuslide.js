    //sidemenu, slide fx script
	<!--
	function MFXinitMenu(){
	//IE = document.all ? 1:0;
	//NN = document.layers ? 1:0; 
	IE = 1;
	NN = 0;
	HIDDEN = (NN) ? 'hide' : 'hidden';
	VISIBLE = (NN) ? 'show' : 'visible';
	myLayer=new Array();
	mySpeed=8; 
	subLeft=0;
	closes=true;
	allShow = false;
	
	divs = document.getElementsByTagName("div");
	layerCnt = 0;
	for(ix = 0; ix < divs.length; ix++){
		if(divs[ix].id.indexOf("MFX") > -1)
			layerCnt++;
	}
	
	var layerNm;
	for(iCnt = 0; iCnt < layerCnt; iCnt++){
    	layerNm = "MFX"+iCnt;
		myLayer[iCnt]=(NN) ? document.getElementById(layerNm) : document.getElementById(layerNm).style;
	}
	
	running=false;
	whichOpen=-1;
	lastMain=myLayer.length-2;
	MFXmain=new Array();
	
	for(i=0; i<myLayer.length; i++)
	{
		mainORsub= i % 2;
		MFXmain[i] = mainORsub ? 0:1;
	}
	
	myTop=new Array();
	myLeft=new Array();
	myHeight=new Array();
	myWidth=new Array();
	mySlide=new Array();
	

	for(i=0; i<myLayer.length; i++)
	{
		if(NN&&MFXmain[i])
		{
			if(i==0){
				myTop[i]=myLayer[i].top;
				myLeft[i]=myLayer[i].left;
			}else{
				myLeft[i]=myLeft[i-2];
				myTop[i]=myTop[i-2]+myHeight[i-2];
			}
			myHeight[i]=myLayer[i].clip.height;
			myWidth[i]=myLayer[i].clip.width;
			myLayer[i].left=myLeft[i];
			myLayer[i].top=myTop[i];
			myLayer[i].visibility=VISIBLE;
		}
		if(NN&&!MFXmain[i]){
			myTop[i]=myTop[i-1]+myHeight[i-1];
			myLeft[i]=myLeft[i-1];
			myHeight[i]=myLayer[i].clip.height;
			myWidth[i]=myLayer[i].clip.width;
			mySlide[i]=myTop[i]+myHeight[i];
			myLayer[i].left=myLeft[i]+subLeft;
			myLayer[i].top=myTop[i];
		}
		if(IE&&MFXmain[i]){			
							
			if(i==0){
				//myLeft[i]=myLayer[i].pixelLeft;
				//myTop[i]=myLayer[i].pixelTop;				
				myLeft[i]=7;
				myTop[i]=132;
			}else{
				myLeft[i]=myLeft[i-2];
				myTop[i]=myTop[i-2]+myHeight[i-2];
			}
			myHeight[i]=myLayer[i].pixelHeight;
			myWidth[i]=myLayer[i].pixelWidth;
			myLayer[i].left=myLeft[i];
			myLayer[i].top=myTop[i];
			myLayer[i].visibility=VISIBLE;
		}
		if(IE&&!MFXmain[i]){
						
			myTop[i]=myTop[i-1]+myHeight[i-1];
			myLeft[i]=myLeft[i-1];
			myHeight[i]=myLayer[i].pixelHeight;
			myWidth[i]=myLayer[i].pixelWidth;
			myLayer[i].pixelLeft=myLeft[i]+subLeft;
			myLayer[i].pixelTop=myTop[i];
			mySlide[i]=myTop[i]+myHeight[i];
		}
	}
	}
	
	function MFXAllMenuShow()
	{   
	    for(i=0; i<myLayer.length; i++){
			if(MFXmain[i]){
				if(NN){
					alert("Only IE!");
				}
				if(IE){
					myLayer[i+1].clip= "rect(" + ("auto") +" "+ ("auto") +" "+ (0) +" "+ ("auto") +")";
					myLayer[i+1].visibility=VISIBLE;
					myLayer[i].position="relative";
					myLayer[i+1].position="relative";
					myLayer[i].top="1px";
					myLayer[i].left="-2px";
					myLayer[i+1].top="1px";
					myLayer[i+1].left="-2px";
				}
			}
		}
		allShow = true;
	}
	
	function MFXAllMenuClose()
	{   
	    for(i=0; i<myLayer.length; i++){
			if(MFXmain[i]){
				if(NN){
					alert("Only IE!");
				}
				if(IE){
					//myLayer[i+1].clip= "rect(" + ("auto") +" "+ ("auto") +" "+ (0) +" "+ ("auto") +")";
					myLayer[i+1].visibility="hidden";
					myLayer[i].position="absolute";
					myLayer[i+1].position="absolute";
					myLayer[i].top=myTop[i];
					myLayer[i].left=myLeft[i];
					myLayer[i+1].top=myTop[i+1];
					myLayer[i+1].left=myLeft[i+1];
				}
			}
		}
		allShow = false;
	}
		
	function MFXrunMenu(myName,newspeed)
	{   
	    if(allShow) MFXAllMenuClose();
		ieStep=0;
		thereS=false;
		thereC=false;
		if(newspeed>0){mySpeed=newspeed;}
		first=myName;
		if(whichOpen==-1 && !running && MFXmain[myName] && !(whichOpen==myName)){
			running=true;
			if(NN){
				myLayer[myName+1].clip.height=0;
				myLayer[myName+1].visibility=VISIBLE;
			}
			if(IE){
				myLayer[myName+1].clip= "rect(" + ("auto") +" "+ ("auto") +" "+ (0) +" "+ ("auto") +")";
				myLayer[myName+1].visibility=VISIBLE;
			}
			MFXopenMenuS(myName);
			MFXopenMenuC(myName);
		}
		if(whichOpen>=0&&!running&&!(whichOpen==myName)){
			running=true;
			second=whichOpen;
			ieStep1=myHeight[second+1];
			thereCS=false;
			thereCC=false;
			MFXcloseMenuS(second);
			MFXcloseMenuC(second);
		}
		if(whichOpen>=0&&!running&&whichOpen==myName&&closes){
			running=true;
			second=whichOpen;
			ieStep1=myHeight[second+1];
			thereCS=false;
			thereCC=false;
			MFXcloseMenuS(second);
			MFXcloseMenuC(second);
		}
	}
	
	function MFXstopCloseS(myName){
		running=false;
		thereCS=true;
		if(closes&&first==whichOpen){
			whichOpen=-1;
		}else{
			whichOpen=-1;
			MFXrunMenu(first);
		}
	}
	
	
	function MFXstopOpenS(myName){
		running=false;
		thereS=true;
		if(IE){myLayer[myName+1].clip= "rect(" + ("auto") +" "+ ("auto") +" "+ ("auto") +" "+ ("auto") +")";}
		whichOpen=myName;
	}
	
	
	function MFXopenMenuS(myName)
	{
		myStep=mySpeed;
		if(NN&&!thereS&&!(first==lastMain)){
			if(myLayer[first+2].top+myStep>mySlide[first+1]){
				myStep=mySlide[first+1]-myLayer[first+2].top;
			}
			for(i=first+2; i<myLayer.length; i+=2){
				myLayer[i].top+=myStep;
			}
			if(myLayer[first+2].top==mySlide[first+1]){
				MFXstopOpenS(first)
			}
			if(running)setTimeout('MFXopenMenuS(first)',10);
		}
		if(IE&&!thereS&&!(first==lastMain)){
			if(myLayer[first+2].pixelTop+myStep>mySlide[first+1]){
				myStep=mySlide[first+1]-myLayer[first+2].pixelTop;
			}
			for(i=first+2; i<myLayer.length; i+=2){
				myLayer[i].pixelTop+=myStep;
			}
			if(myLayer[first+2].pixelTop==mySlide[first+1]){
				MFXstopOpenS(first)
			}
			if(running)setTimeout('MFXopenMenuS(first)',10);
		}
	}
	
	function MFXopenMenuC(myName)
	{
		myStep=mySpeed;
		if(NN&&!thereC){
			if ((myLayer[first+1].clip.height+myStep)>myHeight[first+1]){
			myLayer[first+1].clip.height=myHeight[first+1]
			}
			if(myLayer[first+1].clip.height==myHeight[first+1]){
				thereC=true;
				whichOpen=first;
				MFXstopOpenS(first)
	
			}else{
				myLayer[first+1].clip.height+=myStep;
	
			}
			if(running) setTimeout('MFXopenMenuC(first)',10);
		}
		if(IE&&!thereC){
			ieStep+=myStep;
			myLayer[myName+1].clip= "rect(" + ("auto") +" "+ ("auto") +" "+ (ieStep) +" "+ ("auto") +")";
	
				if(ieStep>=myHeight[first+1]){
					thereC=true;
					whichOpen=first;
					MFXstopOpenS(first)
				}
			if(running) setTimeout('MFXopenMenuC(first)',10);
		}
	}
	
	
	function MFXcloseMenuS(myName){
		myStep=mySpeed;
		if(NN&&!thereCS&&!(second==lastMain)){
			if(myLayer[second+2].top-myStep<myTop[second+2]){
				myStep=myLayer[second+2].top-myTop[second+2];
			}
			for(i=second+2; i<myLayer.length; i+=2){
				myLayer[i].top-=myStep;
	
			}
			if(myLayer[second+2].top==myTop[second+2]){
				MFXstopCloseS(second);
			}
			if(running)setTimeout('MFXcloseMenuS(second)',10);
		}
		if(IE&&!thereCS&&!(second==lastMain)){
			if(myLayer[second+2].pixelTop-myStep<myTop[second+2]){
				myStep=myLayer[second+2].pixelTop-myTop[second+2];
			}
			for(i=second+2; i<myLayer.length; i+=2){
				myLayer[i].pixelTop-=myStep;
		
			}
			if(myLayer[second+2].pixelTop==myTop[second+2]){
				MFXstopCloseS(second);
			}
			if(running)setTimeout('MFXcloseMenuS(second)',10);
		}
	}
	
	
	function MFXcloseMenuC(myName){
		myStep=-mySpeed;
		ieStep1-=mySpeed;
		if(NN&&!thereCC){
			if ((myLayer[second+1].clip.bottom+myStep)<0){
				myLayer[second+1].clip.bottom=0;
			}
			if(myLayer[second+1].clip.bottom==0){
				thereCC=true;
		
				if(second==lastMain)MFXstopCloseS(second);
			}else{
				myLayer[second+1].clip.bottom+=myStep;
		
			}
			if(running)setTimeout('MFXcloseMenuC(second)',10);
		}
		if(IE&&!thereCC){
			if(ieStep1<=0){
				myLayer[myName+1].clip= "rect(" + ("auto") +" "+ ("auto") +" "+ (0) +" "+ ("auto") +")";
				thereCC=true;
				if(second==lastMain)MFXstopCloseS(second);
			}else{
				myLayer[myName+1].clip= "rect(" + ("auto") +" "+ ("auto") +" "+ (ieStep1) +" "+ ("auto") +")";
		
			}
			if(running)setTimeout('MFXcloseMenuC(second)',10);
		}
	}
	//-->
	
