/**
 * 카카오톡 로그인
 */
$(document).ready(function(){
		Kakao.init("f29f793671a2f7f805e36b37a38294f6");
		
	});
	function fn_kakaoLogin(){
		Kakao.Auth.login({
			persistAccessToken: true,
			persistRefreshToken: true,
			success: function(authObj) {
				getKakaotalkUserProfile();
				
			},
			fail: function(err) {
				console.log(err);
			}
		});		
	}
	
	
	function fn_kakaoLogout(){
		
		Kakao.Auth.logout();
	}
	
	function getKakaotalkUserProfile(){
		Kakao.API.request({
			url: '/v1/user/me',
			success: function(res) {
				$("#memId").val(res.kaccount_email);
				$("#memSns").val("K");
				$("#frm").attr("action","/usr/lgn/login.do").submit();
			},
			fail: function(error) {
				console.log(error);
			}
		});
	}