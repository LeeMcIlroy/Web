<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div id="fb-root">
	
	</div>
	
	<script>
	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) return;
		js = d.createElement(s); js.id = id;
		js.src = "//connect.facebook.net/ko_KR/all.js#xfbml=1&appId=213363309007340";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
	
	window.fbAsyncInit = function() {
		FB.init({
			appId      : '213363309007340', // 앱 ID
			status     : true,          // 로그인 상태를 확인
			cookie     : true,          // 쿠키허용
			xfbml      : true           // parse XFBML
		});
	
		FB.Event.subscribe('auth.login', function(response) {
			document.location.reload();
		});
	};
	
	
	function fb_share(){
		FB.getLoginStatus(function(response) {
			if (response.status === 'connected') {
			  var app_link="http://ghkdxodn.tistory.com";
			  var app_thumnail="http://ghkdxodn.tistory.com";
				//var app_thumnail="http://ghkdxodn.tistory.com/"+data.image_name; 
				//var app_thumnail="http://ghkdxodn.tistory.com/show_img.php?no="+data.no;
				FB.api('/me/feed', 'post', {message: '보낼 메세지\n'+app_link ,link: app_thumnail}); 링크공유
				FB.api('/me/feed', 'post', {message: '보낼 메세지\n'+app_link}); 메시지 
			 	alert('공유되었습니다.\n');
	     		// 안드로이드에서는 등록 잘되는데.. 아이폰에서 등록 안됨 ㅡㅡ 		 								
			 										
			} else if (response.status === 'not_authorized') {
				alert('접속 안됨');
			 	//FB.login();
	                           FB.login(function(){}, {scope: 'publish_actions'}); //로그인하면서 글쓰기 권한
			} else {
			  //FB.login()
	                    FB.login(function(){}, {scope: 'publish_actions'}); //로그인하면서 글쓰기 권한
			}
		});
	}
	</script>
	<button id="fb-link-btn" onClick="fb_share()" >페이스북 공유</button>


</body>
</html>


