  // MoveAndResizeTool.js - Implementaion for MoveAndResizeTool.
  // This code uses JQuery so, include the JQuery library before including this file.

  function WrapWithMoveAndResizeTool(jquerySelector) {
      var resizeTool = new MoveAndResizeTool(jquerySelector);
      resizeTool.show();

      return resizeTool;
  }

  // Define MoveAndResizeTool constructor
  function MoveAndResizeTool(jquerySelector) {
      this.wrappedElements = new Array();
      this.isShown = false;
      this.currentWrapper = null ;

      if(jquerySelector != null){
	      var selectedElements = $(jquerySelector);

	      for (var elementInx = 0; elementInx < selectedElements.length; elementInx++) {
	          var currElement = selectedElements[elementInx];
	          this.wrappedElements[elementInx] = new MoveAndResizeElementWrapper(currElement);

	      }
	  }
  }

  MoveAndResizeTool.prototype.addWrapper = function (svgObject) {
      var tempMARWrapper= new MoveAndResizeElementWrapper(svgObject);
      this.wrappedElements[this.wrappedElements.length] = tempMARWrapper;
      if(svgObject.icon.fixed){
    	  console.log("svgObject.element_id : "+svgObject.element_id);
    	  $("#"+svgObject.element_id).attr("fill",svgObject.icon.background);
    	  if(svgObject.icon.showText != 0){
    		  $("#"+svgObject.id_element_text).append(svgObject.icon.text);
        	  $("#"+svgObject.id_element_text).attr("fill", svgObject.icon.txtColor);
    	  }
      } else {
    	  //$("id_element_text"+svgObject.id_element_text).attr("visibility","hidden");
    	  tempMARWrapper.showWrapper();
      }
  }

  MoveAndResizeTool.prototype.delWrapper = function () {
	  if(this.currentWrapper != null){
		  this.wrappedElements = this.wrappedElements.filter(function(element){ return element != svgMoveAndResizeTool.currentWrapper; });
		  this.currentWrapper.removeWrapper();
	  }
  }

  MoveAndResizeTool.prototype.clearWrapper = function (){
	  if(this.wrappedElements.length>0){
		  for(var i=0; i<this.wrappedElements.length;i++){
			  this.currentWrapper = this.wrappedElements[i];
			  this.currentWrapper.removeWrapper();
		  }
		  this.wrappedElements.length = 0;
	  }
  }

  // Define MoveAndResizeTool prototype
  MoveAndResizeTool.prototype.show = function () {
      if (this.isShown == false) {
          for (var elementInx = 0; elementInx < this.wrappedElements.length; elementInx++) {
              var currElement = this.wrappedElements[elementInx];
              currElement.showWrapper();
          }

          this.isShown = true;
      }
  }

  // Define MoveAndResizeTool prototype
  MoveAndResizeTool.prototype.hiddenAllHandler = function (wrapper) {
      for (var elementInx = 0; elementInx < this.wrappedElements.length; elementInx++) {
    	  var currElement = this.wrappedElements[elementInx];
    	  if(wrapper != currElement){
    		  currElement.enabledElements('hidden');
    	  }
      }

  }


  MoveAndResizeTool.prototype.hide = function () {
      if (this.isShown == true) {
          for (var elementInx = 0; elementInx < this.wrappedElements.length; elementInx++) {
              var currElement = this.wrappedElements[elementInx];
              currElement.hideWrapper();
          }

          this.isShown = false;
      }
  }

  MoveAndResizeTool.prototype.updateAll = function(icon){
	  for (var elementInx = 0; elementInx < this.wrappedElements.length; elementInx++) {
          var currElement = this.wrappedElements[elementInx];
       	  currElement.updateAllIcon(icon);
      }
  }




  // var MoveAndResizeTool_ElementWrapper_wrappersCounter = 0;

  // Define MoveAndResizeElementWrapper constructor
  function MoveAndResizeElementWrapper(svgObject) {
	  this.originalSvg = svgObject;
	  this.originalSvg.moveAndResizeElementWrapper = this;
	  this.elementToWrap = "#"+this.originalSvg.svg_id;
      this.originalElement = this.elementToWrap;

      // Since we want a unique id for each wrapper, we add a counter value to the end of each id.
      // MoveAndResizeTool_ElementWrapper_wrappersCounter++;

      this.wrapperId = 'MoveAndResizeTool_ElementWrapper_' + this.originalSvg.wrappersCounter;
          // MoveAndResizeTool_ElementWrapper_wrappersCounter.toString();

      this.wrapperStr = '<div style="left:0px;top:0px;position:relative" id="' + this.wrapperId + '">' +
          				'<div style="left:8px;top:8px;position:absolute" class="internalWrapper"></div>' +
          				'</div>';

      this.externalWrapperQueryStr = '#' + this.wrapperId;
      this.internalWrapperQueryStr = this.externalWrapperQueryStr + ' .internalWrapper';

      // Query strings for the action-triggers.
      this.moveActionTriggerQueryStr = this.externalWrapperQueryStr + ' .moveActionTrigger';
      this.topActionTriggerQueryStr = this.externalWrapperQueryStr + ' .topActionTrigger';
      this.bottomActionTriggerQueryStr = this.externalWrapperQueryStr + ' .bottomActionTrigger';
      this.leftActionTriggerQueryStr = this.externalWrapperQueryStr + ' .leftActionTrigger';
      this.rightActionTriggerQueryStr = this.externalWrapperQueryStr + ' .rightActionTrigger';
      this.topLeftActionTriggerQueryStr = this.externalWrapperQueryStr + ' .topLeftActionTrigger';
      this.topRightActionTriggerQueryStr = this.externalWrapperQueryStr + ' .topRightActionTrigger';
      this.bottomLeftActionTriggerQueryStr = this.externalWrapperQueryStr + ' .bottomLeftActionTrigger';
      this.bottomRightActionTriggerQueryStr = this.externalWrapperQueryStr + ' .bottomRightActionTrigger';

      // Query strings for the resizing border's drawings.
      this.topDrawingQueryStr     = this.externalWrapperQueryStr + ' .topDrawing';
      this.bottomDrawingQueryStr  = this.externalWrapperQueryStr + ' .bottomDrawing';
      this.leftDrawingQueryStr    = this.externalWrapperQueryStr + ' .leftDrawing';
      this.rightDrawingQueryStr   = this.externalWrapperQueryStr + ' .rightDrawing';
      this.topLeftDrawingQueryStr = this.externalWrapperQueryStr + ' .topLeftDrawing';
      this.topRightDrawingQueryStr = this.externalWrapperQueryStr + ' .topRightDrawing';
      this.bottomLeftDrawingQueryStr = this.externalWrapperQueryStr + ' .bottomLeftDrawing';
      this.bottomRightDrawingQueryStr = this.externalWrapperQueryStr + ' .bottomRightDrawing';

      this.currentAction = this.ActionsEnum.None;

      this.lastMouseX = 0;
      this.lastMouseY = 0;

      console.log("New MoveAndResizeElementWrapper end this.wrapperId :"+ this.wrapperId);
  }

  // Define MoveAndResizeElementWrapper prototype
  MoveAndResizeElementWrapper.prototype.ActionsEnum = {
      None: 0,
      LeftResize: 1,
      TopResize: 2,
      RightResize: 3,
      BottomResize: 4,
      TopLeftResize: 5,
      BottomLeftResize: 6,
      TopRightResize: 7,
      BottomRightResize: 8,
      Move: 9
  }

  MoveAndResizeElementWrapper.prototype.cornerActionTriggerRadius = 8;

  MoveAndResizeElementWrapper.prototype.resizingBorderStr =
      '<svg xmlns="http://www.w3.org/2000/svg" version="1.1" style="left:0px;top:0px;position:relative;width:100%;height:100%" >' +
      '<line x1="0" y1="0" x2="100%" y2="0" stroke="#808080" stroke-width="1" stroke-dasharray="3,3" class="topDrawing" />' +
      '<line x1="0" y1="100%" x2="100%" y2="100%" stroke="#808080" stroke-width="1" stroke-dasharray="3,3" class="bottomDrawing" />' +
      '<line x1="0" y1="0" x2="0" y2="100%" stroke="#808080" stroke-width="1" stroke-dasharray="3,3" class="leftDrawing" />' +
      '<line x1="100%" y1="0" x2="100%" y2="100%" stroke="#808080" stroke-width="1" stroke-dasharray="3,3" class="rightDrawing" />' +
      '<rect x="6" y="6" width="6" height="6" class="topLeftDrawing topLeftActionTrigger"         style="opacity:0.3;fill:#353535;cursor:nw-resize" />' +
      '<rect x="6" y="6" width="6" height="6" class="topRightDrawing topRightActionTrigger"       style="opacity:0.3;fill:#353535;cursor:ne-resize" />' +
      '<rect x="6" y="6" width="6" height="6" class="bottomLeftDrawing bottomLeftActionTrigger"   style="opacity:0.3;fill:#353535;cursor:sw-resize" />' +
      '<rect x="6" y="6" width="6" height="6" class="bottomRightDrawing bottomRightActionTrigger" style="opacity:0.3;fill:#353535;cursor:se-resize" />' +
      '<rect x="6" y="6" width="6" height="6" class="topDrawing topActionTrigger"                 style="opacity:0.3;fill:#353535;cursor:n-resize" />' +
      '<rect x="6" y="6" width="6" height="6" class="bottomDrawing bottomActionTrigger"           style="opacity:0.3;fill:#353535;cursor:s-resize" />' +
      '<rect x="6" y="6" width="6" height="6" class="leftDrawing leftActionTrigger"               style="opacity:0.3;fill:#353535;cursor:w-resize" />' +
      '<rect x="6" y="6" width="6" height="6" class="rightDrawing rightActionTrigger"             style="opacity:0.3;fill:#353535;cursor:e-resize" />' +
      '<rect x="0" y="0" width="100%" height="100%" fill-opacity="0.5" opacity="0" class="moveActionTrigger" style="cursor:move" />' +
      '</svg>';

  MoveAndResizeElementWrapper.prototype.showWrapper = function () {
      this.addWrapperElements();
      this.initializeEventHandlers();
      this.enabledElements('hidden');
  }

  MoveAndResizeElementWrapper.prototype.hideWrapper = function () {
      // Set original element's position, to be in the same position, after the wrapper is removed.
      var wrapperLeft = parseInt($(this.externalWrapperQueryStr).css('left'));
      var wrapperTop = parseInt($(this.externalWrapperQueryStr).css('top'));
      var elemLeft = (wrapperLeft + this.cornerActionTriggerRadius) + 'px';
      var elemTop = (wrapperTop + this.cornerActionTriggerRadius) + 'px';
      $(this.originalElement).css('left', elemLeft);
      $(this.originalElement).css('top', elemTop);
      $(this.originalElement).css('position', $(this.externalWrapperQueryStr).css('position'));

      // Put the original element instead of the wrapped element.
      $(this.externalWrapperQueryStr).replaceWith(this.originalElement);
  }

  MoveAndResizeElementWrapper.prototype.reDrawWrapper = function () {
      // Set original element's position, to be in the same position, after the wrapper is removed.
      $(this.originalElement).css('left', 0);
      $(this.originalElement).css('top', 0);
      $(this.originalElement).css('width', "100%");
      $(this.originalElement).css('height', "100%");
      $(this.originalElement).css('position', 'relative');;

  }

  MoveAndResizeElementWrapper.prototype.removeWrapper = function () {
	  $(this.externalWrapperQueryStr).remove();
  }

  MoveAndResizeElementWrapper.prototype.enabledElements = function (tag) {
	  $(this.externalWrapperQueryStr).find(".topRightDrawing").css('visibility',tag);
	  $(this.externalWrapperQueryStr).find(".topLeftDrawing").css('visibility',tag);
      $(this.externalWrapperQueryStr).find(".bottomRightDrawing").css('visibility',tag);
      $(this.externalWrapperQueryStr).find(".bottomLeftDrawing").css('visibility',tag);

      $(this.externalWrapperQueryStr).find(".topDrawing").css('visibility',tag);
      $(this.externalWrapperQueryStr).find(".bottomDrawing").css('visibility',tag);
      $(this.externalWrapperQueryStr).find(".leftDrawing").css('visibility',tag);
      $(this.externalWrapperQueryStr).find(".rightDrawing").css('visibility',tag);
  }


  MoveAndResizeElementWrapper.prototype.addWrapperElements = function () {
      // Wrap the original element with a resizing border.
      $(this.originalElement).wrap(this.wrapperStr);
      $(this.internalWrapperQueryStr).after(this.resizingBorderStr);

      // Set the external wrapper's position to be 8 (the radius of the corner action trigger) pixels less than the original element's position.
      var elemLeft = parseInt($(this.originalElement).css('left'));
      var elemTop = parseInt($(this.originalElement).css('top'));
      var wrapperLeft = (elemLeft - this.cornerActionTriggerRadius) + 'px';
      var wrapperTop = (elemTop - this.cornerActionTriggerRadius) + 'px';

      $(this.externalWrapperQueryStr).css('left', wrapperLeft);
      $(this.externalWrapperQueryStr).css('top', wrapperTop);


      $(this.externalWrapperQueryStr).css('position', $(this.originalElement).css('position'));

      // Set original element's position to be at the top-left corner of the internal wrapper.
      $(this.originalElement).css('left', 0);
      $(this.originalElement).css('top', 0);
      $(this.originalElement).css('position', 'relative');

      this.adjustWrapper();
  }

  MoveAndResizeElementWrapper.prototype.initializeEventHandlers = function () {
      var wrapper = this;

      $(this.moveActionTriggerQueryStr).mousedown(function (event) {
    	  //console.log("event target id : "+wrapper.originalSvg.svg_id);
    	  wrapper.originalSvg.svgMoveAndResizeTool.hiddenAllHandler(wrapper);
    	  wrapper.originalSvg.svgMoveAndResizeTool.currentWrapper = wrapper;
    	  wrapper.enabledElements('visible');

          wrapper.currentAction = wrapper.ActionsEnum.Move;

          /* click event */
          //console.log("mousedown");
          var scope = angular.element(document.getElementById("organizationApp")).scope();
          scope.entity.curWrap = wrapper;
          scope.entity.curIcon = wrapper.originalSvg.icon;

          scope.entity.icon.iconstyle = scope.entity.curIcon.iconstyle;
          scope.entity.icon.icontext  = scope.entity.curIcon.icontext;
          scope.entity.icon.x         = scope.entity.curIcon.x;
          scope.entity.icon.y         = scope.entity.curIcon.y;
          scope.entity.icon.width     = scope.entity.curIcon.width;
          scope.entity.icon.height    = scope.entity.curIcon.height;
          scope.entity.icon.showtext  = scope.entity.curIcon.showtext;
          scope.entity.icon.showscore = scope.entity.curIcon.showscore;

          scope.$apply();

      });

      $(this.topActionTriggerQueryStr).mousedown(function (event) {
          wrapper.currentAction = wrapper.ActionsEnum.TopResize;
      });

      $(this.bottomActionTriggerQueryStr).mousedown(function (event) {
          wrapper.currentAction = wrapper.ActionsEnum.BottomResize;
      });

      $(this.leftActionTriggerQueryStr).mousedown(function (event) {
          wrapper.currentAction = wrapper.ActionsEnum.LeftResize;
      });

      $(this.rightActionTriggerQueryStr).mousedown(function (event) {
          wrapper.currentAction = wrapper.ActionsEnum.RightResize;
      });

      $(this.topLeftActionTriggerQueryStr).mousedown(function (event) {
          wrapper.currentAction = wrapper.ActionsEnum.TopLeftResize;
      });

      $(this.topRightActionTriggerQueryStr).mousedown(function (event) {
          wrapper.currentAction = wrapper.ActionsEnum.TopRightResize;
      });

      $(this.bottomLeftActionTriggerQueryStr).mousedown(function (event) {
          wrapper.currentAction = wrapper.ActionsEnum.BottomLeftResize;
      });

      $(this.bottomRightActionTriggerQueryStr).mousedown(function (event) {
          wrapper.currentAction = wrapper.ActionsEnum.BottomRightResize;
      });

      $(document).mouseup(function (event) {
          // Clear the current action.
    	  //console.log("document mouseup");
          wrapper.currentAction = wrapper.ActionsEnum.None;
      });

      $(document).mousemove(function (event) {
    	  //console.log("document mousemove");
          wrapper.onMouseMove(event);
      });
  }

  MoveAndResizeElementWrapper.prototype.onMouseMove = function (event) {
      var currMouseX = event.clientX;
      var currMouseY = event.clientY;

      var deltaX = currMouseX - this.lastMouseX;
      var deltaY = currMouseY - this.lastMouseY;

      this.applyMouseMoveAction(deltaX, deltaY);

      this.lastMouseX = event.pageX;
      this.lastMouseY = event.pageY;
  }

  MoveAndResizeElementWrapper.prototype.applyMouseMoveAction = function (deltaX, deltaY) {

	  //console.log("applyMouseMoveAction deltaX : "+deltaX+" / deltaY : "+deltaY);
	  var deltaTop = 0;
      var deltaLeft = 0;
      var deltaWidth = 0;
      var deltaHeight = 0;

      if (this.currentAction == this.ActionsEnum.RightResize ||
               this.currentAction == this.ActionsEnum.TopRightResize ||
               this.currentAction == this.ActionsEnum.BottomRightResize) {
          deltaWidth = deltaX;
      }

      if (this.currentAction == this.ActionsEnum.LeftResize ||
               this.currentAction == this.ActionsEnum.TopLeftResize ||
               this.currentAction == this.ActionsEnum.BottomLeftResize) {
          deltaWidth = -deltaX;
          deltaLeft = deltaX;
      }

      if (this.currentAction == this.ActionsEnum.BottomResize ||
               this.currentAction == this.ActionsEnum.BottomLeftResize ||
               this.currentAction == this.ActionsEnum.BottomRightResize) {
          deltaHeight = deltaY;
      }

      if (this.currentAction == this.ActionsEnum.TopResize ||
               this.currentAction == this.ActionsEnum.TopLeftResize ||
               this.currentAction == this.ActionsEnum.TopRightResize) {
          deltaHeight = -deltaY;
          deltaTop = deltaY;
      }

      if (this.currentAction == this.ActionsEnum.Move) {
          deltaLeft = deltaX;
          deltaTop = deltaY;
      }

      this.updatePosition(deltaLeft, deltaTop);
      this.updateSize(deltaWidth, deltaHeight);
      this.adjustWrapper();
  }

  MoveAndResizeElementWrapper.prototype.updateIcon = function (icon) {
	  // Set the new size.
      $(this.originalElement).css('width', icon.width + 'px');
      $(this.originalElement).css('height', icon.height + 'px');

      // set the icon
      this.originalSvg.icon.width = parseInt($(this.originalElement).css('width'));
      this.originalSvg.icon.height = parseInt($(this.originalElement).css('height'));


      $(this.externalWrapperQueryStr).css('left', icon.x + 'px');
      $(this.externalWrapperQueryStr).css('top', icon.y + 'px');

      // set the icon
      this.originalSvg.icon.x = parseInt($(this.externalWrapperQueryStr).css('left'));
      this.originalSvg.icon.y = parseInt($(this.externalWrapperQueryStr).css('top'));

      this.originalSvg.icon.iconstyle = icon.iconstyle;

      if(icon.iconstyle == "e"){
    	  changeEllipse();
      } else if (icon.iconstyle == "r"){
    	  changeRectangle();
      }

  }

  MoveAndResizeElementWrapper.prototype.updateAllIcon = function (icon) {

	  this.originalSvg.icon.iconstyle = icon.iconstyle;
      if(icon.iconstyle == "e"){
    	  this.changeEllipse();
      } else if (icon.iconstyle == "r"){
    	  this.changeRectangle();
      }

	  // Set the new size.
      $(this.originalElement).css('width', icon.width + 'px');
      $(this.originalElement).css('height', icon.height + 'px');

      // set the icon
      this.originalSvg.icon.width = parseInt($(this.originalElement).css('width'));
      this.originalSvg.icon.height = parseInt($(this.originalElement).css('height'));


  }


  MoveAndResizeElementWrapper.prototype.changeRectangle = function(){
	var svgObject = this.originalSvg;
	if(svgObject.shapeType != shapeType.Rect){
		$(this.originalElement).replaceWith(svgObject.svgRect);
		svgObject.shapeType = shapeType.Rect;
		this.reDrawWrapper();
	}
  }

  MoveAndResizeElementWrapper.prototype.changeEllipse = function(){
	var svgObject = this.originalSvg;
	if(svgObject.shapeType != shapeType.Ellipse){
		$(this.originalElement).replaceWith(svgObject.svgEllipse);
		svgObject.shapeType = shapeType.Ellipse;
		this.reDrawWrapper();
	}
  }

  MoveAndResizeElementWrapper.prototype.updateSize = function (deltaWidth, deltaHeight) {
      // Calculate the new size.
      var elemWidth = parseInt($(this.originalElement).width());
      var elemHeight = parseInt($(this.originalElement).height());
      var newWidth = elemWidth + deltaWidth;
      var newHeight = elemHeight + deltaHeight;

      // Don't allow a too small size.
      var minumalSize = this.cornerActionTriggerRadius * 2;
      if (newWidth < minumalSize) {
          newWidth = minumalSize;
      }
      if (newHeight < minumalSize) {
          newHeight = minumalSize;
      }

      // Set the new size.
      $(this.originalElement).css('width', newWidth + 'px');
      $(this.originalElement).css('height', newHeight + 'px');

      // set the icon
      this.originalSvg.icon.width = parseInt($(this.originalElement).css('width'));
      this.originalSvg.icon.height = parseInt($(this.originalElement).css('height'));

      // set angular
      if (deltaWidth != 0 || deltaHeight != 0){
	      var scope = angular.element(document.getElementById("organizationApp")).scope();
	      if(scope.entity.curIcon){
	    	  scope.entity.icon.width     = scope.entity.curIcon.width;
	    	  scope.entity.icon.height    = scope.entity.curIcon.height;
	    	  scope.$apply();
	      }
      }
  }

  MoveAndResizeElementWrapper.prototype.updatePosition = function (deltaLeft, deltaTop) {
      // Calculate the new position.

	  //console.log("updatePosition deltaLeft : "+deltaLeft+" / deltaTop : "+deltaTop);

      var elemLeft = parseInt($(this.externalWrapperQueryStr).css('left'));
      var elemTop = parseInt($(this.externalWrapperQueryStr).css('top'));
      var newLeft = elemLeft + deltaLeft;
      var newTop = elemTop + deltaTop;

      //console.log("updatePosition elemLeft : "+$(this.externalWrapperQueryStr).css('left')+" / elemTop : "+$(this.externalWrapperQueryStr).css('top'));
      // Set the new position.
      $(this.externalWrapperQueryStr).css('left', newLeft + 'px');
      $(this.externalWrapperQueryStr).css('top', newTop + 'px');

      // set the icon
      this.originalSvg.icon.x = parseInt($(this.externalWrapperQueryStr).css('left'));
      this.originalSvg.icon.y = parseInt($(this.externalWrapperQueryStr).css('top'));

      // set angular
      if(deltaLeft != 0 || deltaTop != 0) {
	      var scope = angular.element(document.getElementById("organizationApp")).scope();
	      if(scope.entity.curIcon){
		      scope.entity.icon.x = scope.entity.curIcon.x;
		      scope.entity.icon.y = scope.entity.curIcon.y;
		      scope.$apply();
	      }
      }

  }

  MoveAndResizeElementWrapper.prototype.adjustWrapper = function () {
      var elemWidth = parseInt($(this.originalElement).width());
      var elemHeight = parseInt($(this.originalElement).height());
      var externalWrapperWidth = (elemWidth + this.cornerActionTriggerRadius * 2) + 'px';
      var externalWrapperHeight = (elemHeight + this.cornerActionTriggerRadius * 2) + 'px';

      $(this.internalWrapperQueryStr).width($(this.originalElement).width());
      $(this.internalWrapperQueryStr).height($(this.originalElement).height());
      $(this.externalWrapperQueryStr).width(externalWrapperWidth);
      $(this.externalWrapperQueryStr).height(externalWrapperHeight);

      // Adjust the resizing border.
      this.adjustResizingBorder();
  }

  MoveAndResizeElementWrapper.prototype.adjustResizingBorder = function () {
      var elemWidth = parseInt($(this.originalElement).width());
      var elemHeight = parseInt($(this.originalElement).height());

      // Get the minimum and maximum values for X and Y.
      var minX = this.cornerActionTriggerRadius + 'px';
      var minY = this.cornerActionTriggerRadius + 'px';
      var maxX = (this.cornerActionTriggerRadius + elemWidth) + 'px';
      var maxY = (this.cornerActionTriggerRadius + elemHeight) + 'px';

      // Adjust moving rectange.
      this.setRectangleAttributes(this.moveActionTriggerQueryStr, minX, minY, elemWidth + 'px', elemHeight + 'px');

      // Adjust resizing border lines.
      this.setLineAttributes(this.topDrawingQueryStr, minX, minY, maxX, minY);
      this.setLineAttributes(this.bottomDrawingQueryStr, minX, maxY, maxX, maxY);
      this.setLineAttributes(this.leftDrawingQueryStr, minX, minY, minX, maxY);
      this.setLineAttributes(this.rightDrawingQueryStr, maxX, minY, maxX, maxY);
      this.setLineAttributes(this.topActionTriggerQueryStr, minX, minY, maxX, minY);
      this.setLineAttributes(this.bottomActionTriggerQueryStr, minX, maxY, maxX, maxY);
      this.setLineAttributes(this.leftActionTriggerQueryStr, minX, minY, minX, maxY);
      this.setLineAttributes(this.rightActionTriggerQueryStr, maxX, minY, maxX, maxY);

      // Adjust resizing border circles.
      /*this.setCircleAttributes(this.topLeftDrawingQueryStr, minX, minY);
      this.setCircleAttributes(this.topRightDrawingQueryStr, maxX, minY);
      this.setCircleAttributes(this.bottomLeftDrawingQueryStr, minX, maxY);
      this.setCircleAttributes(this.bottomRightDrawingQueryStr, maxX, maxY);
      this.setCircleAttributes(this.topLeftActionTriggerQueryStr, minX, minY);
      this.setCircleAttributes(this.topRightActionTriggerQueryStr, maxX, minY);
      this.setCircleAttributes(this.bottomLeftActionTriggerQueryStr, minX, maxY);
      this.setCircleAttributes(this.bottomRightActionTriggerQueryStr, maxX, maxY);*/



      // Adjust Handlers
      $(this.externalWrapperQueryStr).find(".topRightDrawing").attr('x',(elemWidth+4)+'px');
      $(this.externalWrapperQueryStr).find(".bottomRightDrawing").attr('x',(elemWidth+4)+'px');
      $(this.externalWrapperQueryStr).find(".bottomRightDrawing").attr('y',(elemHeight+4)+'px');
      $(this.externalWrapperQueryStr).find(".bottomLeftDrawing").attr('y',(elemHeight+4)+'px');
      $(this.externalWrapperQueryStr).find(".topDrawing").attr('x',(elemWidth+8)/2+'px');
      $(this.externalWrapperQueryStr).find(".bottomDrawing").attr('x',(elemWidth+8)/2+'px');
      $(this.externalWrapperQueryStr).find(".bottomDrawing").attr('y',(elemHeight+4)+'px');
      $(this.externalWrapperQueryStr).find(".leftDrawing").attr('y',(elemHeight+8)/2+'px');
      $(this.externalWrapperQueryStr).find(".rightDrawing").attr('x',(elemWidth+4)+'px');
      $(this.externalWrapperQueryStr).find(".rightDrawing").attr('y',(elemHeight+8)/2+'px');

  }

  MoveAndResizeElementWrapper.prototype.setRectangleAttributes = function (rectQueryStr, x, y, width, height) {
      var rectElem = $(rectQueryStr);
      rectElem.attr('x', x);
      rectElem.attr('y', y);
      rectElem.attr('width', width);
      rectElem.attr('height', height);
  }

  MoveAndResizeElementWrapper.prototype.setLineAttributes = function (lineQueryStr, x1, y1, x2, y2) {
      var lineElem = $(lineQueryStr);
      lineElem.attr('x1', x1);
      lineElem.attr('y1', y1);
      lineElem.attr('x2', x2);
      lineElem.attr('y2', y2);
  }

  MoveAndResizeElementWrapper.prototype.setCircleAttributes = function (circleQueryStr, cx, cy) {
      var circleElem = $(circleQueryStr);
      circleElem.attr('cx', cx);
      circleElem.attr('cy', cy);
  }