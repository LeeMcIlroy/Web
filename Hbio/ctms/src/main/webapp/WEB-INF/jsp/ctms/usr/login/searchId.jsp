<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<script type="text/javascript">
	$(function(){
		$("#cert_num").attr('disabled', 'true');
	});

	function fn_setAuthNo(){
		var userNameYn = $('#user_Name').val();		
		if(userNameYn==''){
			alert('이름을 입력해주세요')
			$('#user_Name').focus();
			return;
		}
		
		var userphoneYn = $('#user_phone').val();		
		if(userphoneYn==''){
			alert('핸드폰번호를 입력해주세요')
			$('#user_phone').focus();
			return;
		}
		
		var name = $("#user_Name").val();
		var hpNo = $("#user_phone").val();
		if(confirm('인증번호를 핸드폰번호로 수신 하시겠습니까?')){
			$.ajax({
				url: "<c:url value='/usr/login/sendAjaxSetAuthNoId.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"hpNo="+hpNo+"&"+"name="+name
				, dataType: "json"
				, success: function(data){

					if(data.resultSt) {
						$("#user_Name").attr('disabled', 'true');
						$("#user_phone").attr('disabled', 'true');
						$("#cert_num").removeAttr('disabled');	
					}
					var message = data.message;
					alert(message);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	function fn_authCdCheck(){
		var userNameYn = $('#user_Name').val();		
		if(userNameYn==''){
			alert('이름이 없습니다. 인증코드발송을 먼저해주세요')
			$('#user_Name').focus();
			return;
		}
		
		var userphoneYn = $('#user_phone').val();		
		if(userphoneYn==''){
			alert('핸드폰번호가 없습니다. 인증코드발송을 먼저해주세요')
			$('#user_phone').focus();
			return;
		}
		
		var certNumYn = $('#cert_num').val();		
		if(certNumYn==''){
			alert('인증번호를 입력해주세요.')
			$('#cert_num').focus();
			return;
		}
		
		$("#user_Name").removeAttr('disabled');
		$("#user_phone").removeAttr('disabled');
		$("#cert_num").removeAttr('disabled');
		$("#detailForm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/login/authCdCheck.do'/>").submit();
	}
	
</script>
<body>
<!-- wrap -->
<div class="com_wrap">
	<h1>H&amp;Bio</h1>
	<div class="com_top">
		<h2>아이디 찾기</h2>
		하단정보를 입력 후 아이디 찾기를 클릭하세요.
	</div>
	<form:form commandName="sb1000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
		<input type="hidden" id="corpCd" name="corpCd" value="${sb1000mVO.corpCd}">
	<!-- 정보입력 -->
	<div class="com_reg">
		<input type="text" placeholder="이름" id="user_Name" value="<c:out value="${sb1000mVO.rsjName }"/>" name="rsjName" />
		<p>
			<input type="text" placeholder="핸드폰 번호" id="user_phone" value="<c:out value="${sb1000mVO.hpNo }"/>" name="hpNo" />
			핸드폰번호는 숫자만 입력
			<a href="#" onClick="fn_setAuthNo()">인증코드발송</a>
			
		</p>		
		<input type="text" placeholder="인증번호" id="cert_num" name="authCd" />
		<div>
			<ul>

				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/login/joinMem.do'/>">회원가입</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/login/searchPw.do'/>">비밀번호 찾기</a></li>
			</ul>
		</div>
		</form:form>
		<a href="#" onclick="fn_authCdCheck();">아이디 찾기</a>
		<a href="<c:out value='${pageContext.request.contextPath }/usr/login/loginView.do'/>">로그인</a>
	</div>
	<!-- //정보입력 -->
</div>
<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
<!-- //wrap -->
</body>
</html>
