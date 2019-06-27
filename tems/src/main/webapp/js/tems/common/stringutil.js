/**
 * 숫자만 찾아내어 리턴.
 */
function findnumber(val){
	var str = val.replace(/[^0-9]/g,'');
	return str;
}

function findstring(val){
	var str = val.replace(/[0-9]/g,'');
	return str;
}

function addComma(n) {
	if(isNaN(n)){return 0;}
	var reg = /(^[+-]?\d+)(\d{3})/;   
	n += '';
	while (reg.test(n))
		n = n.replace(reg, '$1' + ',' + '$2');
	return n;
}

function addNbsp(n) {
	if(isNaN(n)){return 0;}
	var reg = /(^[+-]?\d+)(\d{3})/;   
	n += '';
	while (reg.test(n))
		n = n.replace(reg, '$1' + ' ' + '$2');
	return n;
}


function roundXL(n, digits) {
    if(n==0) return 0;

    if (digits >= 0) return parseFloat(n.toFixed(digits)); // 소수부 반올림
    digits = Math.pow(10, digits); // 정수부 반올림
    var t = Math.round(n * digits) / digits;
    if(n==0) t=0;
    

    return parseFloat(t.toFixed(0));
}

function floorXL(n, digits) {
    
	if(n==0) return 0;
    digits = Math.pow(10, digits); // 정수부 반올림
    var t = Math.floor(n * digits) / digits; 
    if(n==0) t=0; 
    return parseFloat(t);
}


