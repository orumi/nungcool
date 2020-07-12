
	var svgMoveAndResizeTool;
	var svgCompus ;
	var MoveAndResizeTool_ElementWrapper_wrappersCounter = 0;
	var shapeType = {Line:0, Rect:1, Ellipse:2};

	$(function () {
		svgCompus = $( "#section" );
		//svgCompus = $( "body" );
		svgMoveAndResizeTool = WrapWithMoveAndResizeTool(null);

		//svgCompus.css('background-image', 'url(../../mapImage/division_2018.jpg)');
		svgCompus.css('background-repeat', 'no-repeat');

		//$("#section").click(function(){clearSVGObject();});

	});

	var strEllipse = '<svg id="id_svg" style="left:##posLeft##px;top:##posTop##px;width:##posWidth##px;height:##posHeight##px;position:absolute" class="mySvgs"> '
        			+' <ellipse id="id_element" cx="50%" cy="50%" rx="50%" ry="50%" stroke="#969696" stroke-width="1" fill="#b3b3b3" /> '
        			+' <text id="id_element_text" x="50%" y="55%" alignment-baseline="middle" text-anchor="middle" font-size="14" fill="#ffffff"></text> '
        			+'</svg>';

	var strRect    = '<svg id="id_svg" style="left:##posLeft##px;top:##posTop##px;width:##posWidth##px;height:##posHeight##px;position:absolute" class="mySvgs"> '
						+' <rect id="id_element" x=0 y=0 width=100% height=100% stroke="#969696" stroke-width="1" fill="#b3b3b3" /> '
						+' <text id="id_element_text" x="50%" y="55%" alignment-baseline="middle" text-anchor="middle" font-size="14" fill="#ffffff"></text> '
					+'</svg>';


	function addSVGObject(icon){
		console.log("add SVG Icon ");
		var svgObject = new SVGObject(icon);
		svgMoveAndResizeTool.addWrapper(svgObject);
	}


	function delSVGObject(){
		svgMoveAndResizeTool.delWrapper();
	}

	function clearSVGObject(){
		svgMoveAndResizeTool.clearWrapper();

		svgCompus.children().remove();
	}

	function SVGObject(icon){
		this.icon = icon;

		this.moveAndResizeElementWrapper = null;
		this.svgMoveAndResizeTool = svgMoveAndResizeTool;
		MoveAndResizeTool_ElementWrapper_wrappersCounter++;


		this.wrappersCounter = MoveAndResizeTool_ElementWrapper_wrappersCounter.toString();
		this.element_id = "element_"+MoveAndResizeTool_ElementWrapper_wrappersCounter.toString();
		this.svg_id = "svg_"+MoveAndResizeTool_ElementWrapper_wrappersCounter.toString();
		this.id_element_text = "element_text_"+MoveAndResizeTool_ElementWrapper_wrappersCounter.toString();

		//console.log("icon x : "+icon.x+" icon y : "+icon.y);


		this.svgEllipse = strEllipse.replace("id_svg", this.svg_id).replace("id_element", this.element_id).replace("id_element_text", this.id_element_text).replace("##posLeft##",icon.x).replace("##posTop##",icon.y).replace("##posWidth##",icon.width).replace("##posHeight##",icon.height);
		this.svgRect = strRect.replace("id_svg", this.svg_id).replace("id_element", this.element_id).replace("id_element_text", this.id_element_text).replace("##posLeft##",icon.x).replace("##posTop##",icon.y).replace("##posWidth##",icon.width).replace("##posHeight##",icon.height);


		if(icon.iconstyle == "e"){
			this.shapeType = shapeType.Ellipse;
			svgCompus.append( this.svgEllipse );
		} else {
			this.shapeType = shapeType.Rect;
			svgCompus.append( this.svgRect );
		}


	}



	function changeRectangle(){

		if(svgMoveAndResizeTool.currentWrapper != null){
			var svgObject = svgMoveAndResizeTool.currentWrapper.originalSvg;
			if(svgObject.shapeType != shapeType.Rect){
				$(svgMoveAndResizeTool.currentWrapper.originalElement).replaceWith(svgObject.svgRect);
				svgObject.shapeType = shapeType.Rect;
				svgMoveAndResizeTool.currentWrapper.reDrawWrapper();
			}
		}
	}

	function changeEllipse(){

		if(svgMoveAndResizeTool.currentWrapper != null){
			var svgObject = svgMoveAndResizeTool.currentWrapper.originalSvg;
			if(svgObject.shapeType != shapeType.Ellipse){
				$(svgMoveAndResizeTool.currentWrapper.originalElement).replaceWith(svgObject.svgEllipse);
				svgObject.shapeType = shapeType.Ellipse;
				svgMoveAndResizeTool.currentWrapper.reDrawWrapper();
			}
		}
	}