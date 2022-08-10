<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javaScript">

	$(function(){
	
		$("#admId").val('celldio');
		$("#admPwd").val('qwer$1234');
		
	    var message = $("#message").val();
	    if (message != "") {
	        alert(message);
	        $("#message").val('');
	    }
		$("#admId").focus();
		
		//enter
		$("#admPwd").on("keydown", function(e) {
			if (e.keyCode == 13) {
				fn_login();
				return false;
			}
		}); 
	});
	
	// 로그인
	function fn_login(){
		if( $.trim($("#admId").val())==""){
			alert("사번을 입력해주세요.");
			$("#admId").focus();
			return false;
		}else if($.trim($("#admPwd").val())==""){
			alert("비밀번호를 입력해주세요.");
			$("#admId").focus();
			return false;
		}
		$("#detailForm").submit();
	}

</script>
<body>
<form id="detailForm" name="detailForm" method="post" action="<c:url value='/qxerpynm/lgn/admLogin.do'/>">
	<div class="main_top">
		<div id="header02">
			<div>
				<img src="<c:url value='/assets/adm/img/top_logo.jpg'/>"/>
			</div>
		</div>
	
		<div id="loginWrap">
			<div class="inner">
				<p class="log_tit">한성대학교 부설 디자인아트 교육원 관리자</p>
				<div class="log_box">
					<p>한성대학교 종합정보시스템 <span>ID, PW</span>로 로그인 가능합니다.</p>
					<div>
							<input type="text" id="admId" name="admId" style="width:30%;" placeholder="아이디"/>
							<input type="password" id="admPwd" name="admPwd" style="width:30%;" placeholder="비밀번호" />
						<a href="#" onclick="fn_login(); return false;" style="display: inline-block;">로그인</a>
					</div>
				</div>
				<div class="icon_li">
					<ul>
						<li>한성대학교 부설 디자인아트 교육원 관리자 공간입니다.</li>
						<li>권한이 없는 사용자는 접근하실 수 없습니다.</li>
						<li>비밀번호 분실시 시스템관리자에게 문의해주세요.</li>
					</ul>
				</div>
				<div id="log_foot">Copyright@한성대학교. All Rights reserved.</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="message" name="message" value="${message }"/>
</form>
</body>
</html>