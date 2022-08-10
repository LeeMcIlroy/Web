<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width">
	<title>학사관리시스템</title>

	<link rel="stylesheet" media="screen" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/style.css'/>">
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/js/lcms_common.js'/>"></script>
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
</head> 
<body>
	<div class="log-cont">
		<div class="log-box">
			<form:form commandName="adminVO" id="frm" name="frm">
				<div class="log-forom type-2">
					<div class="login-logo">
						<div class="log-title">학사관리시스템 <span>로그인</span></div>
					</div>
						<div>
							<p class="icon-id">아이디</p>
							<input type="text" name="adminId" id="adminId" placeholder="아이디를 입력하세요"/>
						</div>
						<div>
							<p class="icon-pw">비밀번호</p>
							<input type="password" name="adminPw" id="adminPw" placeholder="비밀번호를 입력하세요"/>
						</div>
					<a href="#" onclick="fn_login(); return false;">로그인</a>
				</div>
			</form:form>
		</div>
	</div>

	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
	<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>">
	<div class="black"></div>
</body>
</html>