function openWindow(anchor, options) {
  var args = '';

  if (typeof(options) == 'undefined') { var options = new Object(); }
  if (typeof(options.name) == 'undefined') { options.name = 'win' + Math.round(Math.random()*100000); }

  if (typeof(options.height) != 'undefined' && typeof(options.fullscreen) == 'undefined') {
    args += "height=" + options.height + ",";
  }

  if (typeof(options.width) != 'undefined' && typeof(options.fullscreen) == 'undefined') {
    args += "width=" + options.width + ",";
  }

  if (typeof(options.fullscreen) != 'undefined') {
    args += "width=" + screen.availWidth + ",";
    args += "height=" + screen.availHeight + ",";
  }

  if (typeof(options.center) == 'undefined') {
    options.x = 0;
    options.y = 0;
    args += "screenx=" + options.x + ",";
    args += "screeny=" + options.y + ",";
    args += "left=" + options.x + ",";
    args += "top=" + options.y + ",";
  }

  if (typeof(options.center) != 'undefined' && typeof(options.fullscreen) == 'undefined') {
    options.y=Math.floor((screen.availHeight-(options.height || screen.height))/2)-(screen.height-screen.availHeight);
    options.x=Math.floor((screen.availWidth-(options.width || screen.width))/2)-(screen.width-screen.availWidth);
    args += "screenx=" + options.x + ",";
    args += "screeny=" + options.y + ",";
    args += "left=" + options.x + ",";
    args += "top=" + options.y + ",";
  }

  if (typeof(options.scrollbars) != 'undefined') { args += "scrollbars=1,"; }
  if (typeof(options.menubar) != 'undefined') { args += "menubar=1,"; }
  if (typeof(options.locationbar) != 'undefined') { args += "location=1,"; }
  if (typeof(options.resizable) != 'undefined') { args += "resizable=1,"; }

  var win = window.open(anchor, options.name, args);
  return false;

}

function SortableTable (tableEl) {

  this.tbody = tableEl.getElementsByTagName('tbody');
  this.thead = tableEl.getElementsByTagName('thead');
  this.tfoot = tableEl.getElementsByTagName('tfoot');

  this.getInnerText = function (el) {
    if (typeof(el.textContent) != 'undefined') return el.textContent;
    if (typeof(el.innerText) != 'undefined') return el.innerText;
    if (typeof(el.innerHTML) == 'string') return el.innerHTML.replace(/<[^<>]+>/g,'');
  }

  this.getParent = function (el, pTagName) {
    if (el == null) return null;
    else if (el.nodeType == 1 && el.tagName.toLowerCase() == pTagName.toLowerCase())
      return el;
    else
      return this.getParent(el.parentNode, pTagName);
  }

  this.sort = function (cell) {

      var column = cell.cellIndex;
      var itm = this.getInnerText(this.tbody[0].rows[1].cells[column]);
    var sortfn = this.sortCaseInsensitive;

    if (itm.match(/\d\d[-]+\d\d[-]+\d\d\d\d/)) sortfn = this.sortDate; // date format mm-dd-yyyy
    if (itm.replace(/^\s+|\s+$/g,"").match(/^[\d\.]+$/)) sortfn = this.sortNumeric;

    this.sortColumnIndex = column;

      var newRows = new Array();
      for (j = 0; j < this.tbody[0].rows.length; j++) {
      newRows[j] = this.tbody[0].rows[j];
    }

    newRows.sort(sortfn);

    if (cell.getAttribute("sortdir") == 'down') {
      newRows.reverse();
      cell.setAttribute('sortdir','up');
    } else {
      cell.setAttribute('sortdir','down');
    }

    for (i=0;i<newRows.length;i++) {
      this.tbody[0].appendChild(newRows[i]);
    }

  }

  this.sortCaseInsensitive = function(a,b) {
    aa = thisObject.getInnerText(a.cells[thisObject.sortColumnIndex]).toLowerCase();
    bb = thisObject.getInnerText(b.cells[thisObject.sortColumnIndex]).toLowerCase();
    if (aa==bb) return 0;
    if (aa<bb) return -1;
    return 1;
  }

  this.sortDate = function(a,b) {
    aa = thisObject.getInnerText(a.cells[thisObject.sortColumnIndex]);
    bb = thisObject.getInnerText(b.cells[thisObject.sortColumnIndex]);
    date1 = aa.substr(6,4)+aa.substr(3,2)+aa.substr(0,2);
    date2 = bb.substr(6,4)+bb.substr(3,2)+bb.substr(0,2);
    if (date1==date2) return 0;
    if (date1<date2) return -1;
    return 1;
  }

  this.sortNumeric = function(a,b) {
    aa = parseFloat(thisObject.getInnerText(a.cells[thisObject.sortColumnIndex]));
    if (isNaN(aa)) aa = 0;
    bb = parseFloat(thisObject.getInnerText(b.cells[thisObject.sortColumnIndex]));
    if (isNaN(bb)) bb = 0;
    return aa-bb;
  }

  // define variables
  var thisObject = this;
  var sortSection = this.thead;

  // constructor actions
  if (!(this.tbody && this.tbody[0].rows && this.tbody[0].rows.length > 0)) return;

  if (sortSection && sortSection[0].rows && sortSection[0].rows.length > 0) {
    var sortRow = sortSection[0].rows[0];
  } else {
    return;
  }

  for (var i=0; i<sortRow.cells.length; i++) {
    sortRow.cells[i].sTable = this;
    sortRow.cells[i].onclick = function () {
      this.sTable.sort(this);
      return false;
    }
  }

}

function ScrollableTable (tableEl, tableHeight, tableWidth) {

  this.initIEengine = function () {

    this.containerEl.style.overflowY = 'auto';
    if (this.tableEl.parentElement.clientHeight - this.tableEl.offsetHeight < 0) {
      this.tableEl.style.width = this.newWidth - this.scrollWidth +'px';
    } else {
      this.containerEl.style.overflowY = 'hidden';
      this.tableEl.style.width = this.newWidth +'px';
    }

    if (this.thead) {
      var trs = this.thead.getElementsByTagName('tr');
      for (x=0; x<trs.length; x++) {
        trs[x].style.position ='relative';
        trs[x].style.setExpression("top",  "this.parentElement.parentElement.parentElement.scrollTop + 'px'");
      }
    }

    if (this.tfoot) {
      var trs = this.tfoot.getElementsByTagName('tr');
      for (x=0; x<trs.length; x++) {
        trs[x].style.position ='relative';
        trs[x].style.setExpression("bottom",  "(this.parentElement.parentElement.offsetHeight - this.parentElement.parentElement.parentElement.clientHeight - this.parentElement.parentElement.parentElement.scrollTop) + 'px'");
      }
    }

    eval("window.attachEvent('onresize', function () { document.getElementById('" + this.tableEl.id + "').style.visibility = 'hidden'; document.getElementById('" + this.tableEl.id + "').style.visibility = 'visible'; } )");
  };


  this.initFFengine = function () {
    this.containerEl.style.overflow = 'hidden';
    this.tableEl.style.width = this.newWidth + 'px';

    var headHeight = (this.thead) ? this.thead.clientHeight : 0;
    var footHeight = (this.tfoot) ? this.tfoot.clientHeight : 0;
    var bodyHeight = this.tbody.clientHeight;
    var trs = this.tbody.getElementsByTagName('tr');
    if (bodyHeight >= (this.newHeight - (headHeight + footHeight))) {
      this.tbody.style.overflow = '-moz-scrollbars-vertical';
      for (x=0; x<trs.length; x++) {
        var tds = trs[x].getElementsByTagName('td');
        tds[tds.length-1].style.paddingRight += this.scrollWidth + 'px';
      }
    } else {
      this.tbody.style.overflow = '-moz-scrollbars-none';
    }

    var cellSpacing = (this.tableEl.offsetHeight - (this.tbody.clientHeight + headHeight + footHeight)) / 4;
    this.tbody.style.height = (this.newHeight - (headHeight + cellSpacing * 2) - (footHeight + cellSpacing * 2)) + 'px';

  };

  this.tableEl = tableEl;
  this.scrollWidth = 16;

  this.originalHeight = this.tableEl.clientHeight;
  this.originalWidth = this.tableEl.clientWidth;

  this.newHeight = parseInt(tableHeight);
  this.newWidth = tableWidth ? parseInt(tableWidth) : this.originalWidth;

  this.tableEl.style.height = 'auto';
  this.tableEl.removeAttribute('height');

  this.containerEl = this.tableEl.parentNode.insertBefore(document.createElement('div'), this.tableEl);
  this.containerEl.appendChild(this.tableEl);
  this.containerEl.style.height = this.newHeight + 'px';
  this.containerEl.style.width = this.newWidth + 'px';


  var thead = this.tableEl.getElementsByTagName('thead');
  this.thead = (thead[0]) ? thead[0] : null;

  var tfoot = this.tableEl.getElementsByTagName('tfoot');
  this.tfoot = (tfoot[0]) ? tfoot[0] : null;

  var tbody = this.tableEl.getElementsByTagName('tbody');
  this.tbody = (tbody[0]) ? tbody[0] : null;

  if (!this.tbody) return;

  if (document.all && document.getElementById && !window.opera) this.initIEengine();
  if (!document.all && document.getElementById && !window.opera) this.initFFengine();
}

/**************************************************************
 Split: Returns a zero-based, one-dimensional array containing
        a specified number of substrings

 Parameters:
      Expression = String expression containing substrings and
                   delimiters. If expression is a zero-length
                   string(""), Split returns an empty array,
                   that is, an array with no elements and no
                   data.
      Delimiter  = String character used to identify substring
                   limits. If delimiter is a zero-length
                   string (""), a single-element array
                   containing the entire expression string
                   is returned.

 Returns: String
***************************************************************/
function Split(Expression, Delimiter){
	var temp = Expression;
	var a, b = 0;
	var array = new Array();

	if (Delimiter.length == 0){
		array[0] = Expression;
		return (array);
	}

	if (Expression.length == ''){
		array[0] = Expression;
		return (array);
	}

	Delimiter = Delimiter.charAt(0);

	for (var i = 0; i < Expression.length; i++){
		a = temp.indexOf(Delimiter);
		if (a == -1){
			array[i] = temp;
			break;
		}else{
			b = (b + a) + 1;
			var temp2 = temp.substring(0, a);
			array[i] = temp2;
			temp = Expression.substr(b, Expression.length - temp2.length);
		}
	}

	return (array);
}
