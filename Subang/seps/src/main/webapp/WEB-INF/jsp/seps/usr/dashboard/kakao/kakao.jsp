<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<c:out value='${sessionScope.KAKAO_API_KEY }'/>"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
//사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('<c:out value="${sessionScope.KAKAO_API_KEY }"/>');
function fn_kakaoShare(){
	
	/*	*/
	if($('#ch_div1').css('display') == 'block'){
		if($('#kakaoTitle1').val() == ''){
			alert('구분을 선택해주세요.');
			return false;
		}
	}else{
		if($('#kakaoTitle').val() == ''){
			alert('제목을 입력해주세요.');
			return false;
		}else if($('#kakaoContent').val() == ''){
// 			alert('내용을 입력해주세요.');
// 			return false;
		}
	}
	
	var kakaoTitle = '';
	var kakaoContent = '';
	if($('.share_cont_box').find('ul > li > a.on').parent().attr('id') == 'copy_box_t'){
		kakaoTitle = $('#ch_div1').find('#kakaoTitle1').val() + ':' + $('#ch_div1').find('#kakaoTitle2').val();
		kakaoContent = $('#ch_div1').find('#kakaoContent').val();
	}else{
		kakaoTitle = $('#ch_div2').find('#kakaoTitle').val();
		kakaoContent = $('#ch_div2').find('#kakaoContent').val();
	}
	// 내용초기화 - start
	$('#ch_div1').find('#kakaoTitle1').val('');
	$('#ch_div1').find('#kakaoTitle2').val('');
	$('#ch_div1').find('#kakaoContent').val('');
	$('#ch_div2').find('#kakaoTitle').val('');
	$('#ch_div2').find('#kakaoContent').val('');
	$('#kakaoTitle2Result').empty();
	popup_name3(share_box);
	// 내용초기화 - end
	
	$.ajax({
		url: "<c:url value='/usr/dashboard/kakaoShareInsertAjax.do'/>"
		, type: "post"
		, data: {
			kakaoTitle : kakaoTitle
			, kakaoContent : kakaoContent
		}
		, dataType:"json"
		, async : false
		, success: function(data){
			// 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
			Kakao.Link.sendDefault({
				objectType: 'feed'
				, content: {
						title: kakaoTitle
						, description: kakaoContent
						, imageUrl: location.origin+"/assets/img/ci_character.png"
						, link: {
							mobileWebUrl: location.origin
							, webUrl: location.origin
						}
						, imageWidth : 535
						, imageHeight : 558
				}
				, installTalk : true
				, serverCallbackArgs: '{"statusCode":"200"}' // 콜백 파라미터 설정
			});
			
		}, error: function(){
			alert("오류가 발생하였습니다.");
		}
	});
	
	
}
</script>