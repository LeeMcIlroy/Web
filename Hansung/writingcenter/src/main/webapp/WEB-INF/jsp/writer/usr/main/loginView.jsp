<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javaScript" defer="defer">

	$(function(){
	
	    var message = $("#message").val();
	    if (message != "") {
	        alert(message);
	        $("#message").val('');
	    }
		
		$("#memCode").focus();
		
		//enter
		$("#memCode, #memName").on("keydown", function(e) {
			if (e.keyCode == 13) {
				fn_login();
				return false;
			}
		}); 
	    
	});
	
	// 로그인
	function fn_login(){
		
		if( $.trim($("#memCode").val())==""){
			alert("학번을 입력해주세요.");
			$("#memCode").focus();
			return false;
		}else if( $.trim($("#memName").val())==""){
			alert("이름을 입력해주세요.");
			$("#memName").focus();
			return false;
		}else if( $.trim($("#memType").val())==""){
			alert("타입을 선택해주세요.");
			$("#memType").focus();
			return false;
		}
	
		$("#detailForm").submit();
	}

</script>
<body>
<form id="detailForm" name="detailForm" method="post" action="<c:url value='/usr/lgn/tmpLogin.do'/>">
<div class="main_top">
	<div id="header02">
		<div>
			<img src="<c:url value='/assets/adm/img/top_logo.jpg'/>"/>
		</div>
	</div>

	<div id="loginWrap">
		<div class="inner">
			<p class="log_tit">한성대학교 사고와 표현</p>
			<div class="log_box">
				<p>
					한성대학교 종합정보시스템 <span>ID, PW</span>로 로그인 가능합니다.
				</p>
				<div>
					<input type="text" id="memCode" name="memCode" style="width:20%" placeholder="학번"/>
					<input type="text" id="memDept" name="memDept" style="width:20%" placeholder="학과"/>
					<input type="text" id="memName" name="memName" style="width:20%;" placeholder="이름"/>
					<select id="memType" name="memType">
						<option value="PROF">교수, 강사, 연구원</option>
						<option value="STUD">학생</option>
					</select>
					<a href="#" onclick="fn_login(); return false;" style="display: inline-block;">로그인</a>
				</div>
			</div>
			<div id="log_foot">Copyright@한성대학교. All Rights reserved.</div>
		</div>
	</div>
</div>
<input type="hidden" id="message" value="${message}" />
</form>
</form>
</body>
</html>