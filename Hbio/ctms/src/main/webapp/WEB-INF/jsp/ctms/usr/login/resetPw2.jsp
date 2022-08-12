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
	//관리자 비밀번호 변경
	function fn_modify_pw(){
		var pw2 = $("#pw2").val();
		var pw3 = $("#pw3").val();
		var num = pw2.search(/[0-9]/g);
		var eng = pw2.search(/[a-z]/ig);
		var spe = pw2.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		
		if(pw2 == ''){
			alert('비밀번호를 입력해주세요.');
			$("#pw2").focus();
			return;
		}
		else if(pw3 == ''){
			alert('비밀번호를 입력해주세요.');
			$("#pw3").focus();
			return;
		} 
		else if(pw2 != pw3){
			alert('비밀번호가 일치하지 않습니다.');
			$("#pw3").focus();
			return;
			
		}
		else if(pw2.length < 8 || num < 0 || eng < 0 || spe < 0){
			alert('비밀번호는 영문,숫자,특수문자 조합으로 8자 이상이어야 합니다.');
			$("pw2").focus();
			return;
		}		
		else{
			$("#detailForm").attr("action", "<c:url value= '/usr/login/usrAjaxPasswordUpdate.do'/>").submit();
			alert('변경 되었습니다.');
		}
	}


</script>


<body>
<!-- wrap -->
<div class="com_wrap">
	<h1>H&amp;Bio</h1>
	<div class="com_top">
		<h2>비밀번호 재설정</h2>
		신규 비밀번호를 입력하세요.
	</div>
	<!-- 정보입력 -->
	<form:form commandName="sb1000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
		<input type="hidden" id="corpCd" name="corpCd" value="${sb1000mVO.corpCd}">
		<input type="hidden" id="rsjNo" name="rsjNo" value="${sb1000mVO.rsjNo}">
	<div class="com_reg">
		<input type="password" placeholder="신규 비밀번호" />
		<input type="password" placeholder="신규 비밀번호" id="pw" value="<c:out value="${sb1000mVO.hpNo }"/>" name="hpNo" />
		
			<input type="password" id="pw2" name="adminPw" class="input-data p20" placeholder="영문,숫자, 특수문자를 혼합하여 8자리 이상" />
								<span class="alt-txt dpn" id="alert-pw-guide">영문,숫자,특수문자 조합으로 8자 이상 설정</span>
								<span class="alt-txt dpn" id="alert-pw-check">영문,숫자,특수문자 조합으로 8자 이상이어야 합니다.</span>
								<!-- <span class="alt-txt" id="alert-pw-space-check" >비밀번호는 공백없이 입력해주세요.</span> -->
								<span class="ok-signature dpn" id="alert-success_1">O.K</span>
		
		
		
		<input type="password" placeholder="비밀번호 재입력" />
		<td colspan="3">
								<input type="password" id="pw3" class="input-data p20" placeholder="비밀번호 재입력"/>
								<span class="alt-txt dpn" id="alert-danger_1">비밀번호가 일치하지 않습니다.</span>
								<span class="alt-txt dpn" id="alert-pw-check_1">영문,숫자,특수문자 조합으로 8자 이상이어야 합니다.</span>
								<span class="ok-signature dpn" id="alert-success_2">O.K</span>
							</td>
		
		
		
		
		<a href="#" onclick="fn_modify_pw(); return false;">비밀번호 재설정</a>
	</div>
	</form:form>
	<!-- //정보입력 -->
</div>
<!-- //wrap -->
</body>
</html>

