$(function(){
/*
	if(ip() != '202.167.218.23' && ip() != '202.167.218.26' && ip() != '202.167.218.35'){
		// pc browser일경우
		var filter = "win16|win32|win64|mac|macintel";
		if ( navigator.platform  ) {
			if ( filter.indexOf( navigator.platform.toLowerCase() ) > 0 ) {
				location.href = "/usr/main/pcBrowser.do"; //PC 페이지 경로
				return false;
			} 
		} 
	}
	*/

/*	
	var oldUrl = ${pageContext.request.contextPath} // 기본 URL
	var changeUrl = 'http://www.sooribingo.com/'; // 기본 URL로 사이트 접속 시 변경하고 싶은 URL
	var urlString = location.href;
	if (oldUrl.contains("com") == false){
	    window.location.replace(urlString.replace(oldUrl, changeUrl));
	} else {
	    // 주소창에 입력한 주소가 oldURL과 다를 경우 아무런 행위도 하지않는다.
	}
*/	
	
	// message 값이 존재하는 경우 alert을 띄웁니다.
    if( $("#message").length==1 && $("#message").val()!='' ){
        alert( $("#message").val() );
        $("#message").val('');
    }
    
    // 로그인 뒤로가기 제어
	history.pushState(null, null, location.href);
	window.onpopstate = function(event){
		if(document.location.href.indexOf("#") < 0){
			if( document.referrer.substr(0, document.referrer.lastIndexOf("/")) == location.href.substr(0, location.href.lastIndexOf("/")) ){
				if( location.href.indexOf("List.do") >= 0 ){
					location.href = "/";
				}else if( document.referrer.indexOf("View.do") >= 0 ){
					location.href = document.location.pathname.replace("View.do", "List.do").replace("Modify.do", "List.do");
				}else{
					location.href = document.referrer;
				}
			}else{
				location.href = "/";
			}
		}
    }
	
});

// 빙고만들기
function fn_memBingo_register(){
	location.href = "/usr/bingo/bingoRegister.do";
}

// 빙고 확인
function fn_memBingo_view(){
	location.href = "/usr/bingo/bingoView.do";
}

// 로그인 popup
function fn_loginPopup(){
	var tags = '<div class="pop-alert">';
	tags += '<a href="/usr/lgn/loginView.do"><img src="/assets/usr/images/main/soori_alert.gif" alt="로그인을 " />';
	tags += '<p class="alert-txt">앗! 수리와 함께 놀려면<br /><em style="font-size:6vw;">로그인</em>을 해주세요!</p></a>';
	tags += '<a href="#" onclick="fn_popup_close(); return false;" class="close-round">닫기</a>';
	tags += '</div>';
	tags += '<div class="dim"></div>';
	$("#alertPopup").append(tags);
}

// popup 닫기
function fn_popup_close(){
	$("#alertPopup").empty();
	location.reload();
}

// 뒤로가기
function fn_back(){
	history.go(-1);
}