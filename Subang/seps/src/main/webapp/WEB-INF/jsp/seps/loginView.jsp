<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath }/assets/css/main_animate.css'/>">
<!-- Custom Stylesheet -->
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath }/assets/css/main_style.css'/>">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<script type="text/javascript">
	
	// 로그인
	function fn_login(){
		if($("#uuid").val() == ''){
		    if($("#userId").val() == ''){
		        alert("아이디를 입력해주세요.");
		        $("#userId").focus();
		        return false;
		    }else if($("#userPw").val() == ''){
		        alert("비밀번호를 입력해주세요.");
		        $("#userPw").focus();
		        return false;
		    }
		}
		
		//자동로그인 설정(안드로이드 용)
		var browserInfo = navigator.userAgent;
		if(browserInfo.indexOf('SEPS_TEST')>-1){
			auto_login_edit.setFlag(true);
			auto_login_edit.setID($("#userId").val());
		}
		$("#frm").submit();
    }
	
	function fn_auto(userId){
		$("#userId").val(userId);
		if($("#autoLogin").val()=='N'){
			//자동로그인 해제
			auto_login_edit.setFlag(false);
		}else{
    	    fn_login();
		}
    }
	
	function fn_uuid(uuid){
		$("#uuid").val(uuid);
	}
	
	
	function fn_token(token){
		$("#token").val(token);
	}
	
</script>
<body>
<form action="/login.do" id="frm" name="frm" method="post">
<input type="hidden" name="uuid" id="uuid"/>
<input type="hidden" name="token" id="token"/>
	<div class="container">
		<div class="top">
			<h1 id="title" class="hidden"><img src="/assets/img/top_logo.png"></h1>
		</div>
		<div class="login-box animated">
			<ul>
				<li><label for="username"><input type="text" id="userId" name="userId" placeholder="USER ID" ></label></li>
				<li><label for="password"><input type="password" id="userPw" name="userPw" placeholder="PASSWORD"></label></li>
				<li><!-- <input type="checkbox" id="login_ck" ><label for="login_ck">자동 로그인</label> --></li>				
			</ul>
			<button onclick="fn_login(); return false;">LOG IN</button>			
			<a href="#" class="small">※ 계정은 관리자에게 문의바랍니다.</a>
		</div>
	</div>
</form>
<input type="hidden" id="message" name="message" value="${message }">
<input type="hidden" id="autoLogin" name="autoLogin" value="${autoLogin }">
</body>

<script>
	$(document).ready(function () {
    	$('#logo').addClass('animated fadeInDown');
    	$("input:text:visible:first").focus();
	});
	$('#username').focus(function() {
		$('label[for="username"]').addClass('selected');
	});
	$('#username').blur(function() {
		$('label[for="username"]').removeClass('selected');
	});
	$('#userPw').focus(function() {
		$('label[for="userPw"]').addClass('selected');
	});
	$('#userPw').blur(function() {
		$('label[for="userPw"]').removeClass('selected');
	});
</script>
</html>