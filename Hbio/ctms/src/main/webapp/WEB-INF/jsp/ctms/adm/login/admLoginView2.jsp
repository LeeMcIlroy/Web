<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	$(function(){
		$("#adminId").focus();
		
		$("#adminPw").keyup(function(e){
			if(e.keyCode == 13){
				fn_login();
			}
		});
	});
	
	function fn_login(){
		var adminId = $("#adminId").val();
		var adminPw = $("#adminPw").val();
		
		if(adminId == ''){
			alert('아이디를 입력해 주세요.');
			$("#adminId").focus();
			return;
		}else if(adminPw == ''){
			alert('비밀번호를 입력해 주세요.');
			$("#adminPw").focus();
			return;
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxsepmny/lgn/admLoginProc.do'/>").submit();
	}
</script>
<body>
<!-- wrap -->
<div class="login_wrap">
	<!-- 로그인영역 -->
	<div class="login">
		<!-- 로고 -->
		<h1>H&amp;Bio</h1>
		<div class="login_top">
			<h2>로그인</h2>
			임상시험관리시스템에 로그인하시려면<br />아이디와 비밀번호를 입력해주세요.
		</div>
		<!-- 로그인 -->
		<form:form commandName="adminVO" id="frm" name="frm">
		<fieldset>
			<legend>로그인</legend>
			<label for="adminId" class="hidden">아이디</label>
			<input type="text" placeholder="아이디" name="adminId" id="adminId" />
			<label for="adminPw" class="hidden">비밀번호</label>
			<input type="password" placeholder="비밀번호" name="adminPw" id="adminPw" />
			<a href="#" onclick="fn_login(); return false;">로그인</a>
			<!-- SNS 로그인 -->
			<div>
				<ul>
					<li><a href="#"><i></i>카카오톡 로그인</a></li>
					<li><a href="#"><i></i>네이버 로그인</a></li>
				</ul>
			</div>
		</fieldset>
		</form:form>
		<!-- //로그인 -->
		<!-- 로그인 하단 -->
		<div class="login_btm">
			<div>
				<ul>
					<li><a href="#">회원가입</a></li>
					<li><a href="#">아이디 찾기</a></li>
					<li><a href="#">비밀번호 찾기</a></li>
				</ul>
			</div>
			<p>회원가입은 무료입니다.</p>
			<p>인가된 사용자만 접속할 수 있으며 불법으로 접속시에는 제재를 받을 수 있습니다. 시스템을 사용하기 위해서는 등록과정이 필요하며, 시스템 담당자에게 문의하시기 바랍니다.</p>
		</div>
		<!-- //로그인 하단 -->
	</div>
	<!-- //로그인영역 -->	
	<!-- footer -->
	<div class="login_footer">
		Copyright © eCRF LOGO All rights reserved.
	</div>
	<!-- //footer -->
</div>
<!-- //wrap -->
</body>
</html>
