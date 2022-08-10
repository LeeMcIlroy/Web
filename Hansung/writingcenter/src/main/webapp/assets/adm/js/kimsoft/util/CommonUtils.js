kimsoft.util.common = {
	// 팝업(no scroll)
	popsn : function(url, trgt, w, h) {
		var windowLeft = (screen.width-w)/2;
		var windowTop = (screen.height-h)/2;
	    var p = window.open(url,trgt,'width='+w+',height='+h+',scrollbars=no,resizable=no,copyhistory=no,toolbar=no,status=no,top=' + windowTop + ',left=' + windowLeft + '');
	    p.focus();
	    return p;
	},
	//팝업(scroll)
	popsy : function(url, trgt, w, h) { 
		var windowLeft = (screen.width-w)/2;
		var windowTop = (screen.height-h)/2;
	    var p = window.open(url,trgt,'width='+w+',height='+h+',scrollbars=yes,resizable=no,copyhistory=no,toolbar=no,status=no,top=' + windowTop + ',left=' + windowLeft + ''); 
	    p.focus();
	    return p;
	},
	// 쿠키 생성
	setCookie : function(cName, cValue, cDay){
		var expire = new Date();
		expire.setDate(expire.getDate() + cDay);
		cookies = cName + '=' + escape(cValue) + ';path=/';
		if (typeof cDay != 'undefined') {
			cookies += ';expires=' + expire.toGMTString() + ';';
		}
		document.cookie = cookies;
	},
	// 쿠키 가져오기
	getCookie : function(cName) {
		cName = cName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cName);
		var cValue = '';
		if(start != -1){
			start += cName.length;
			var end = cookieData.indexOf(';', start);
			if(end == -1) {
				end = cookieData.length;
			}
			cValue = cookieData.substring(start, end);
		}
		return unescape(cValue);
	},
	FIXME : function() {
		alert("서비스 준비중입니다.");
	},
	NA : function() {
		alert("서비스 준비중입니다.");
	},
	NO_AUTH : function() {
		alert("권한이 없습니다.");
	},
	//새로고침
	refreshForm : function() {
		document.location.href = document.location.href.replace(/#$/, '');
	},
	deepCopy : function(data) {
		return JSON.parse(JSON.stringify(data));
	},
	showData : function(data) {
		return alert(JSON.stringify(data));
	}
};
